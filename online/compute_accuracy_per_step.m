function cRate = compute_accuracy_per_step(rec)
%COMPUTE_ACCURACY_PER_STEP

pY = [];
cRate = zeros(rec.nSteps, 1);
for iStep = 1:rec.nSteps
    %
    fprintf('%4d/%4d',iStep, rec.nSteps);
    
    state = rec.state(iStep);
    action = rec.action(iStep);
    hyp = rec.hypothesisPolicies{rec.teacherHypothesis(iStep)};
    pY = [pY; rec.learnerFrame.compute_labels(hyp, state, action)];

    %%
    if iStep > rec.nInitSteps
        X = rec.teacherSignal(1:iStep, :);
        %CV
        [predicted, given] = cross_validation(rec.blankClassifier, X, pY, 10);
        predicted = vertcat(predicted{:});
        given = vertcat(given{:});
        %
        cRate(iStep) = accuracy_label(plabel_to_label(predicted), plabel_to_label(given));
    end
    %
    fprintf('\b\b\b\b\b\b\b\b\b')
end