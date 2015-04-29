clean
[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
jobFolder = fullfile(pathstr, 'wait_jobs');

if ~exist(jobFolder, 'dir')
   mkdir(jobFolder) 
end

nJobs = 0;

nSubject = 8;

% calibTime = [150, 300];
% calibTimePerSubject = [213, 246, 190, 101, 234, 301, 82, 252];


for jobId = 1:nJobs
    for i = 1:nSubject
%         for j = 1:length(calibTime)
            jobFile = generate_available_filename(jobFolder, '.m', 10);
            fid = fopen(jobFile, 'w');

            fprintf(fid, ['subjectId = ', num2str(i),';\n']);
            
%             fprintf(fid, ['nInitSteps = ', num2str(calibTime(j)),';\n']);

            fprintf(fid, 'start\n');
            fprintf(fid, 'power_matching_method\n');
            fprintf(fid, 'main\n');
            fclose(fid);
%         end 
    end
end