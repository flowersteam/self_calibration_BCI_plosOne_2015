%%

[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
plotFolder = fullfile(pathstr, 'plots');
if ~exist(plotFolder, 'dir')
   mkdir(plotFolder)
end

generate_table(concatenate_calib_results('_150'))
generate_table(concatenate_calib_results('_300'))
generate_table(concatenate_calib_results('_custom'))
generate_table(concatenate_calib_results('_self'))