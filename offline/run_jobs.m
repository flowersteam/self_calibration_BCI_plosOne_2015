function run_jobs(jobFolder, runFolder, endFolder)
%RUN_JOBS

if ~exist(jobFolder, 'dir')
    mkdir(jobFolder)
end
addpath(jobFolder);

if ~exist(runFolder, 'dir')
    mkdir(runFolder)
end
addpath(runFolder);
if ~exist(endFolder, 'dir')
    mkdir(endFolder)
end
addpath(endFolder);

waiting_time = 30;

while true
    jobFiles = getfilenames(jobFolder, 'refiles', '*.m');
    if ~isempty(jobFiles)
        jobF = jobFiles{randi(length(jobFiles))};
        [~,name, ~] = fileparts(jobF);
        %
        disp(['Waiting to ensure file not in use ', name])
        pause(waiting_time)
        if exist(jobF, 'file')
            disp(['Waiting to move file ', name])
            pause(randi(waiting_time))
            try
                runJobF = fullfile(runFolder, [name, '.m']);
                movefile(jobF, runJobF)
                pause(1)
                disp(['Running ', name])
                run(runJobF)
                %
                endJobF = fullfile(endFolder, [name, '.m']);
                movefile(runJobF, endJobF)
                pause(1)
            catch err
                disp(err)
            end
        end
    else
        disp('No job available, waiting...')
        pause(waiting_time)
    end
end


