function generate_table(calibResults)

nSubject = 8;

%%perfect use of the logger here!!!
rec = Logger();
for i = 1:nSubject
    
    log = calibResults.(['s', num2str(i)]);
    rec.log_from_logger(log, log.fields)
    rec.log_field('subjectNames', ['s', num2str(i)])
end


tablePos = [0, 0, 1000, 300];
h = figure('Position', tablePos);

data = [rec.nSim, rec.ratioReachedOnce, rec.meanFirstNStep, rec.stdFirstNStep, rec.ratioFirstCorrect, rec.meanNCorrect, rec.stdNCorrect, rec.meanNError, rec.stdNError];

cnames = {'nSim', 'Ratio Reach Once', 'mean Time First', 'std Time First', 'ratio First Correct', ...
    'mean Correct Reach', 'std Correct Reach', 'nmean Wrong Reach', 'std Wrong Reach'};
t = uitable('Parent',h, ...
            'Data',data, ...
            'ColumnName', cnames,... 
            'RowName', rec.subjectNames,...
            'Position', tablePos);