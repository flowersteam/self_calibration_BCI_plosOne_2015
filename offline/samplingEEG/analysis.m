clean

[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
resultFolder = fullfile(pathstr, 'results');

analysisFolder = fullfile(pathstr, 'analysis');
if ~exist(analysisFolder, 'dir')
   mkdir(analysisFolder) 
end

rF = getfilenames(resultFolder);

for irF = 1:length(rF)
    
    fprintf('%4d/%4d', irF, length(rF));
    
    usedDataOnly = 0;
    analysisLogs = folder_analysis(rF{irF}, 10, usedDataOnly);
    
    [~, fname] = fileparts(rF{irF});
    saveFolder = fullfile(analysisFolder, fname);
    
    if ~exist(saveFolder, 'dir')
        mkdir(saveFolder) 
    end
    
    saveFile = fullfile(saveFolder, 'analysisLogs');    
    analysisLogs.save(saveFile)
    
    fprintf('\b\b\b\b\b\b\b\b\b')
end