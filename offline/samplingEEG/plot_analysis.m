clean

[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
analysisFolder = fullfile(pathstr, 'analysis');

methodFolders = getfilenames(analysisFolder);
nMethod = length(methodFolders);

nSegment = 5;
tmp = linspace(0.5, 1, nSegment+1);
minLimit = tmp(1:end-1);
maxLimit = tmp(2:end);

maxElem = 300; %nb of element max per category

nSim = zeros(nMethod, nSegment);
timeFirst = nan(nMethod, maxElem, nSegment);
nCorrect = nan(nMethod, maxElem, nSegment);
nWrong = nan(nMethod, maxElem, nSegment);
ratioFirstWrong = zeros(nMethod, nSegment);

%%
for iMethod = 1:nMethod
    
    filename = fullfile(methodFolders{iMethod}, 'analysisLogs.mat');
    load(filename)
        
    %correct time per target, not reached are noted 500
    timeFirstTarget = analysisLogs.timePerTarget(:,1);
    timeFirstTarget(timeFirstTarget == -1) = size(analysisLogs.timePerTarget, 2);
    
    for iSegment = 1:nSegment
        idx = get_indice_accuracy(analysisLogs, minLimit(iSegment), maxLimit(iSegment));
        
        nSim(iMethod, iSegment) = length(idx);
        
        tmpTimeFirst = timeFirstTarget(idx);
        timeFirst(iMethod, 1:length(tmpTimeFirst) ,iSegment) = tmpTimeFirst;
        
        tmpCorrect = sum(analysisLogs.correctReach(idx,:), 2);
        nCorrect(iMethod, 1:length(tmpCorrect) ,iSegment) = tmpCorrect;
        
        tmpWrong = sum(analysisLogs.wrongReach(idx,:), 2);
        nWrong(iMethod, 1:length(tmpWrong) ,iSegment) = tmpWrong;
        
        tmpRatio = mean(analysisLogs.targetCorrect(idx,1) == 0);
        ratioFirstWrong(iMethod,iSegment) = tmpRatio;
        
    end   
end

%% 

% Change default axes fonts.
set(0,'DefaultAxesFontName', 'Courier')
DefaultAxesFontSize = 25;
set(0,'DefaultAxesFontSize', DefaultAxesFontSize)
set(0,'DefaultAxesFontWeight','bold')
set(0,'DefaultAxesLineWidth', 2.5)

pltMargin = 0.05;
pltSegmentMargin = 1;

niceBlue = [0.2, 0.4, 0.8];
niceGreen = [0.4, 0.8, 0.2];
niceGray = [0.5, 0.5, 0.5];
niceOrange = [0.9, 0.5, 0];
niceRed = [1, 0.2, 0.2];

figPosition = [200, 300, 800, 700];

OutlierMarker = 'x';
OutlierMarkerSize = 10;
OutlierMarkerFaceColor = 'k';
OutlierMarkerEdgeColor = 'k';
WidthE = 0.8;
WidthL = 0.8;
WidthS = 0.8;

labelNames = {'50-60',...
    '60-70',...
    '70-80',...
    '80-90',...
    '90-100'};

dimColor = [niceBlue;niceGreen;niceOrange];
legendNames = {'matching', 'power', 'power matching'};

%% time first
figure('Position', figPosition)

aboxplot(timeFirst,'labels',labelNames, ...
    'Colormap', dimColor , ...
    'OutlierMarker', OutlierMarker, ...
    'OutlierMarkerSize', OutlierMarkerSize, ...
    'OutlierMarkerEdgeColor', OutlierMarkerEdgeColor, ...
    'OutlierMarkerFaceColor', OutlierMarkerFaceColor, ...
    'WidthE', WidthE, ...
    'WidthL', WidthL,...
    'WidthS', WidthS);

xlabel('Dataset Accuracies');
ylabel('Number of iteration to first target');
[legh,objh,outh,outm] = legend(legendNames{:}, 'Location', 'NE');
% legend('boxoff')
set(legh,'linewidth',1);
% 
hold on
plot([0, 9.5], [500, 500], 'k--')
ylim([0 520])
set(gca, 'box', 'off')

%% n correct
figure('Position', figPosition)

aboxplot(nCorrect,'labels',labelNames, ...
    'Colormap', dimColor , ...
    'OutlierMarker', OutlierMarker, ...
    'OutlierMarkerSize', OutlierMarkerSize, ...
    'OutlierMarkerEdgeColor', OutlierMarkerEdgeColor, ...
    'OutlierMarkerFaceColor', OutlierMarkerFaceColor, ...
    'WidthE', WidthE, ...
    'WidthL', WidthL,...
    'WidthS', WidthS);

xlabel('Dataset Accuracies');
ylabel('Number of correctly reached target');
[legh,objh,outh,outm] = legend(legendNames{:}, 'Location', 'NW');
% legend('boxoff')
set(legh,'linewidth',1);
% 
hold on
plot([0, 11], [0, 0], 'k--')
ylim([-2 30])
set(gca, 'box', 'off')

%% n wrong
figure('Position', figPosition)

aboxplot(nWrong,'labels',labelNames, ...
    'Colormap', dimColor , ...
    'OutlierMarker', OutlierMarker, ...
    'OutlierMarkerSize', OutlierMarkerSize, ...
    'OutlierMarkerEdgeColor', OutlierMarkerEdgeColor, ...
    'OutlierMarkerFaceColor', OutlierMarkerFaceColor, ...
    'WidthE', WidthE, ...
    'WidthL', WidthL,...
    'WidthS', WidthS);

xlabel('Dataset Accuracies');
ylabel('Number of incorrectly reached target');
[legh,objh,outh,outm] = legend(legendNames{:}, 'Location', 'NW');
% legend('boxoff')
set(legh,'linewidth',1);
% 
hold on
plot([0, 11], [0, 0], 'k--')
ylim([-2 30])
set(gca, 'box', 'off')

%%

bw_title = [];
bw_xlabel = 'Dataset Accuracies';
bw_colormap = dimColor;
gridstatus = [];
bw_legend = legendNames;
error_sides = [];
legend_type = [];


bw_ylabel = 'Number of simulated experiment';
figure('Position', figPosition)
hold on
barweb(nSim', zeros(nSegment, nMethod), 0.8, labelNames, bw_title, bw_xlabel, bw_ylabel, bw_colormap, gridstatus, bw_legend, error_sides, legend_type);

bw_ylabel = 'Ratio of incorrectly reached first target';
figure('Position', figPosition)
hold on
barweb(ratioFirstWrong', zeros(nSegment, nMethod), 0.8, labelNames, bw_title, bw_xlabel, bw_ylabel, bw_colormap, gridstatus, bw_legend, error_sides, legend_type);


%% save plots
[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
plotFolder = fullfile(pathstr, 'plot');
if ~exist(plotFolder, 'dir')
   mkdir(plotFolder)
end

plotFormats = {'png', 'eps'};

plotFilenames = {'timefirst', 'correct', 'error', 'nSim', 'errorfirst'};

save_all_images(plotFolder, plotFormats, plotFilenames)
close all

%% save data

resultFile = fullfile(plotFolder, 'results.mat');
dataToSave = {'nSim', 'timeFirst', 'nCorrect', 'nWrong', 'ratioFirstWrong', ...
    'labelNames', 'legendNames'};
save(resultFile, dataToSave{:})




 
