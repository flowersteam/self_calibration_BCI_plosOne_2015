%%

% [pathstr, ~, ~] = fileparts(mfilename('fullpath'));
% resultFolder = fullfile(pathstr, 'results');
% rF = getfilenames(resultFolder);
% 
% for irF = 1:length(rF)
%     
%     fn = getfilenames(rF{irF}, 'refiles', '*');
%     
%     for ifn = 1:length(fn)
%         saveFile = [fn{ifn}, '.mat'];
%         movefile(fn{ifn}, saveFile)
%     end
% end




%%
[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
resultFolder = fullfile(pathstr, 'results');

matfiles = getfilenames(resultFolder, 'refiles', '*.mat');
nFile = length(matfiles);

for iFile = 1:nFile
    fprintf('%4d/%4d', iFile, nFile);

    %%
    filename = fullfile(matfiles{iFile});
    load(filename)

    moveFolder = fullfile(resultFolder, [rec.actionSelectionInfo.method, '_', rec.methodInfo.estimateMethod]);
    %%
    if ~exist(moveFolder, 'dir')
       mkdir(moveFolder)
    end

    [~, fname, ~] = fileparts(filename);
    saveFile = fullfile(moveFolder, [fname, '.mat']);
    movefile(filename, saveFile)

    %%
    fprintf('\b\b\b\b\b\b\b\b\b')
end
