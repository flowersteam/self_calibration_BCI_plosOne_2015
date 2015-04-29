function rec = concatenate_calib_results(calibStr)

[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
analysisFolder = fullfile(pathstr, 'analysis');

rec = Logger();

nSubject = 8;
for i = 1:nSubject
   
    expFolder = fullfile(analysisFolder, ['s', num2str(i), calibStr]);
    analysisFile = fullfile(expFolder, 'analysisLogs.mat');
    
    load(analysisFile)
    
    rec.log_field(['s', num2str(i)], compute_stats(analysisLogs))  
    
end
