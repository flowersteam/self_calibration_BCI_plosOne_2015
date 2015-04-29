clean
[pathstr, ~, ~] = fileparts(mfilename('fullpath'));

%% analyse
analysisFolder = fullfile(pathstr, 'analysis');

analysisFiles = getfilenames(analysisFolder, 'refiles','*.mat');
nSubject = length(analysisFiles);

timeFirst = zeros(nSubject, 1);
firstCorrect = zeros(nSubject, 1);
nCorrect = zeros(nSubject, 1);
nWrong = zeros(nSubject, 1);
accuracies = zeros(nSubject, 1);

for iSubject = 1:nSubject
    fname = analysisFiles{iSubject};    
    load(fname)
    
    
    timeFirst(iSubject) = log.timePerTarget(1);
    firstCorrect(iSubject) = log.targetCorrect(1);
    nCorrect(iSubject) = sum(log.correctReach);
    nWrong(iSubject) = sum(log.wrongReach);
    accuracies(iSubject) = log.accuracy * 100;
end

%% plots

% Change default axes fonts.
set(0,'DefaultAxesFontName', 'Courier')
DefaultAxesFontSize = 25;
set(0,'DefaultAxesFontSize', DefaultAxesFontSize)
set(0,'DefaultAxesFontWeight','bold')
set(0,'DefaultAxesLineWidth', 2.5)

figPositionBasic = [0, 0, 800, 800];
figPositionLong = [0, 0, 1200, 800];

niceBlue = [0.2, 0.4, 0.8];
niceGreen = [0.4, 0.8, 0.2];
niceGray = [0.5, 0.5, 0.5];
niceOrange = [0.9, 0.5, 0];
niceRed = [1, 0.2, 0.2];

dotSize = 200;

plotFormats = {'png', 'eps'};

%timefisrt
figure('Position', figPositionBasic)
scatter(accuracies, timeFirst, dotSize, niceBlue, 'filled', 'LineWidth',1.5')

xlabel('Dataset accuracies')
ylabel('Time to first target')

xlim([50, 100])
ylim([0, 600])

%nCorrect
figure('Position', figPositionBasic)
scatter(accuracies, nCorrect, dotSize, niceBlue, 'filled', 'LineWidth',1.5')

xlabel('Dataset accuracies')
ylabel('Number of target correctly reached')

xlim([50, 100])
ylim([0, 20])

%nWrong
figure('Position', figPositionBasic)
scatter(accuracies, nWrong, dotSize, niceBlue, 'filled', 'LineWidth',1.5')

xlabel('Dataset accuracies')
ylabel('Number of target incorrectly reached')

xlim([50, 100])
ylim([0, 5])

%% save plots
plotFolder = fullfile(pathstr, 'plot');
if ~exist(plotFolder, 'dir')
   mkdir(plotFolder)
end

plotFilenames = {'timefirst', 'correct', 'error'};

save_all_images(plotFolder, plotFormats, plotFilenames)

close all

%%

figure('Position', figPositionBasic)
hold on
scatter(accuracies, nCorrect, dotSize, niceGreen, 'filled', 'LineWidth',1.5')
scatter(accuracies, nWrong, dotSize, 'r', 'x', 'LineWidth',1.5)

xlabel('Dataset accuracies')
ylabel('Number of target reached')

xlim([50, 100])
ylim([0, 20])

%% save
plotFilenames = {'correct_and_error'};

save_all_images(plotFolder, plotFormats, plotFilenames)

close all


%% plot and save table
subjectNames = cell(nSubject, 1);
for iSubject = 1:nSubject
    [~,subjectId, ~] = fileparts(analysisFiles{iSubject});
    subjectNames{iSubject} = subjectId;
end

tablePos = [0, 0, 500, 300];
h = figure('Position', tablePos);

data = [round(accuracies), timeFirst, firstCorrect, nCorrect, nWrong];

cnames = {'Accuracy', 'Time First','First Correct','nCorrect', 'nWrong'};
t = uitable('Parent',h, ...
            'Data',data, ...
            'ColumnName', cnames,... 
            'RowName',subjectNames,...
            'Position', tablePos);
        
saveas(h, fullfile(plotFolder, 'table'), 'png')

close all

%% red line plots
resultFolder = fullfile(pathstr, 'results');
resultFiles = getfilenames(resultFolder, 'refiles','*.mat');

plotFilenames = {};
for i = 1:length(resultFiles)
    fname = resultFiles{i};    
    load(fname)

    %find value for current target
    teacherHypothesisProba = zeros(rec.nSteps, 1);
    for iStep = 1:rec.nSteps
        teacherHypothesisProba(iStep) = rec.probabilities_online_one_shot_power_matching_filter_pairwise(iStep, rec.teacherHypothesis(iStep));
    end
    
    figure('Position', figPositionLong)
    plot(rec.probabilities_online_one_shot_power_matching_filter_pairwise, 'b')
    hold on
    plot(teacherHypothesisProba, 'r')
    xlim([0 rec.nSteps+10])
    ylim([0 1])
    drawnow
    
    [~,tmpf,~] = fileparts(fname);
    plotFilenames = [plotFilenames, {tmpf}];
end

plotFolder = fullfile(pathstr, 'plot');
if ~exist(plotFolder, 'dir')
   mkdir(plotFolder)
end

save_all_images(plotFolder, plotFormats, plotFilenames)

close all

%% plot stepTime
resultFolder = fullfile(pathstr, 'results');
resultFiles = getfilenames(resultFolder, 'refiles','*.mat');

stepTimes = zeros(length(resultFiles), 499);
legendNames = {};
for i = 1:length(resultFiles)
    fname = resultFiles{i};    
    load(fname)

    tmpStepTime = smooth(1:length(rec.stepTime),rec.stepTime,0.1,'rloess');
    stepTimes(i, :) = tmpStepTime(1:499);
    
    [~,tmpf,~] = fileparts(fname);
    legendNames = [legendNames, {tmpf}];
end


figure('Position', figPositionLong)
plot(stepTimes', 'linewidth', 2)
legend(legendNames{:}, 'Location', 'NW')

plotFolder = fullfile(pathstr, 'plot');
if ~exist(plotFolder, 'dir')
   mkdir(plotFolder)
end

save_all_images(plotFolder, plotFormats, {'stepTime'})
close all

%% plot evo accuracy
analysisFolder = fullfile(pathstr, 'analysis');
analysisFiles = getfilenames(analysisFolder, 'refiles','*.mat');

stepAcc = zeros(length(analysisFiles), 500);
legendNames = {};
for i = 1:length(analysisFiles)
    fname = analysisFiles{i};    
    load(fname)

    stepAcc(i, :) = log.trueClassificationRate(1:500);
    
    stepAcc(:, 100:101)
    
    [~,tmpf,~] = fileparts(fname);
    legendNames = [legendNames, {tmpf}];
end


figure('Position', figPositionLong)
plot(stepAcc', 'linewidth', 2)
legend(legendNames{:}, 'Location', 'SE')

plotFolder = fullfile(pathstr, 'plot');
if ~exist(plotFolder, 'dir')
   mkdir(plotFolder)
end

save_all_images(plotFolder, plotFormats, {'accuracyEvo'})
close all

%% plot power
resultFolder = fullfile(pathstr, 'results');
resultFiles = getfilenames(resultFolder, 'refiles','*.mat');

powers = zeros(length(resultFiles), 500);
legendNames = {};
for i = 1:length(resultFiles)
    fname = resultFiles{i};    
    load(fname)

    powers(i, :) = sum(rec.teacherSignal(1:500, :).^2, 2);
    
    [~,tmpf,~] = fileparts(fname);
    legendNames = [legendNames, {tmpf}];
end


figure('Position', figPositionLong)
plot(powers', 'linewidth', 2)
legend(legendNames{:}, 'Location', 'NW')

plotFolder = fullfile(pathstr, 'plot');
if ~exist(plotFolder, 'dir')
   mkdir(plotFolder)
end

save_all_images(plotFolder, plotFormats, {'power'})
close all

%% plot power and accuracy
resultFolder = fullfile(pathstr, 'results');
resultFiles = getfilenames(resultFolder, 'refiles','*.mat');

fileNames = {};
for i = 1:length(resultFiles)
    fname = resultFiles{i};

    figure('Position', figPositionLong)
    hold on
    
    formatPower = powers(i,:) / max(powers(i,:));
    plot(formatPower, 'r')
    plot(stepAcc(i,:), 'k')
    legend('normalized power', 'accuracy', 'Location', 'NW')
    
    [~,tmpf,~] = fileparts(fname);
    fileNames = [fileNames, {[tmpf, '_poweracc']}];
end

plotFolder = fullfile(pathstr, 'plot');
if ~exist(plotFolder, 'dir')
   mkdir(plotFolder)
end

save_all_images(plotFolder, plotFormats, fileNames)
close all
