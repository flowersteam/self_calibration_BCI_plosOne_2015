function mergeData_and_save(rec, runData, folder, filename)
%merge
rec = mergeData(rec, runData);

%save
if ~exist(folder, 'dir')
    mkdir(folder)
end

recFilename = fullfile(folder, filename);
rec.save(recFilename)