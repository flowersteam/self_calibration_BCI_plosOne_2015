clean
[pathstr, ~, ~] = fileparts(mfilename('fullpath'));

%% process data by pair 

disp('Merging results...')
resultFolder = fullfile(pathstr, 'results');
expFolder = fullfile(pathstr, '../data/experiments_selfCalibration');

%s1
load(fullfile(expFolder, 's1/results/16_05_08_880_13_May_2014.mat'))
load(fullfile(expFolder, 's1/s1_NIPSv3_control/Session00/s1_NIPSv3_controlS00R003.mat'))
mergeData_and_save(rec, runData, resultFolder, 's1')

%s2
load(fullfile(expFolder, 's2/results/12_49_22_582_16_May_2014.mat'))
load(fullfile(expFolder, 's2/s2_NIPSv3_control/Session00/s2_NIPSv3_controlS00R006.mat'))
mergeData_and_save(rec, runData, resultFolder, 's2')

%s3
load(fullfile(expFolder, 's3/results/11_37_09_949_22_May_2014.mat'))
load(fullfile(expFolder, 's3/s3_NIPSv3_control/Session00/s3_NIPSv3_controlS00R000.mat'))
mergeData_and_save(rec, runData, resultFolder, 's3')

%s4
load(fullfile(expFolder, 's4/results/17_02_56_878_26_August_2014.mat'))
load(fullfile(expFolder, 's4/s4_NIPSv3_control/Session00/s4_NIPSv3_controlS00R000.mat'))
mergeData_and_save(rec, runData, resultFolder, 's4')

%s5
load(fullfile(expFolder, 's5/results/13_07_37_360_05_August_2014.mat'))
load(fullfile(expFolder, 's5/s5_NIPSv3_control/Session00/s5_NIPSv4_controlS00R000.mat'))
mergeData_and_save(rec, runData, resultFolder, 's5')

%s6
load(fullfile(expFolder, 's6/results/18_11_57_235_05_August_2014.mat'))
load(fullfile(expFolder, 's6/s6_NIPSv3_control/Session00/s6_NIPSv4_controlS00R001.mat'))
mergeData_and_save(rec, runData, resultFolder, 's6')

%s7
load(fullfile(expFolder, '/s7/results/19_38_09_877_03_June_2014.mat'))
load(fullfile(expFolder, 's7/s7_NIPSv3_control/Session00/s7_NIPSv3_controlS00R001.mat'))
mergeData_and_save(rec, runData, resultFolder, 's7')

%s8
load(fullfile(expFolder, 's8/results/13_44_59_437_23_October_2014.mat'))
load(fullfile(expFolder, 's8/s8_NIPSv3_control/Session00/s8_NIPSv4_controlS00R006.mat'))
mergeData_and_save(rec, runData, resultFolder, 's8')

%% analyse
disp('Analysing results...')
analysisFolder = fullfile(pathstr, 'analysis');
if ~exist(analysisFolder, 'dir')
    mkdir(analysisFolder)
end

resultFiles = getfilenames(resultFolder, 'refiles','*.mat');
for i = 1:length(resultFiles)
    fname = resultFiles{i}; 
    [~,tmpf,~] = fileparts(fname);
    fprintf([tmpf, '  ']);
    
    load(fname)
    log = recorder_analysis(rec);
    
    cRate = compute_accuracy_per_step(rec);
    log.log_field('trueClassificationRate', cRate)
    
%     [cRates, ~] = compute_accuracy_per_step_per_hypothesis(rec);
%     log.log_field('hypClassificationRate', cRates)
    
    log.save(fullfile(analysisFolder, tmpf))
    fprintf('\n');
end

