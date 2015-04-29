function rec = mergeData(rec, runData)

%% to do first
% load the result file (not the raw_results)
% it means you should have the lfuf folder and subfolders in the path

% load the corresponding data from the interface, e.g. s1_NIPSv3_controlS00R003.mat
% you need to have the BCI folder in the path too

%% transform and align the goals

nStep = length(rec.targetReached);

grizGoal = itu2griz_state(runData.PM.currentGoal);

teacherHypothesis = zeros(nStep, 1);

%align target with iterations
currentGoal = 1;
for i = 1:nStep
    teacherHypothesis(i) = grizGoal(currentGoal);
    if rec.targetReached(i)
        currentGoal = currentGoal + 1;
    end
end

rec.log_field('teacherHypothesis', teacherHypothesis)

%% reconstruct a fake teacherDispatcher

X = rec.teacherSignal(1:nStep, :);
pY = zeros(nStep, 2);
for i = 1:nStep
    hyp = rec.hypothesisPolicies{rec.teacherHypothesis(i)};
    state = rec.state(i);
    action = rec.action(i);
    pY(i, :) = rec.learnerFrame.compute_labels(hyp, state, action);
end
Y = plabel_to_label(pY);

rec.log_field('teacherDispatcher', Dispatcher(X, Y, true));

%% other dummy fields needed to use the analysis tools

rec.log_field('nSteps', nStep)
rec.log_field('dispatcher_empty', zeros(nStep, 1))
