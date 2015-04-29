%%
[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
expDataFolder = fullfile(pathstr, 'expData');

matfiles = getfilenames(expDataFolder, 'refiles', '*.mat');
nFile = length(matfiles);


%%
subjectDispatcherFolder = fullfile(pathstr, 'subjectDispatcher');
ensure_new_folder(subjectDispatcherFolder)

for iFile = 1:nFile
    fprintf('%4d/%4d', iFile, nFile);

    %%
    filename = fullfile(matfiles{iFile});
    load(filename)

    subjectDispatcher = rec.teacherDispatcher;

    [~, fname, ~] = fileparts(filename);
    saveFile = fullfile(subjectDispatcherFolder, [fname, '.mat']);
    save(saveFile, 'subjectDispatcher')

    %%
    fprintf('\b\b\b\b\b\b\b\b\b')
end