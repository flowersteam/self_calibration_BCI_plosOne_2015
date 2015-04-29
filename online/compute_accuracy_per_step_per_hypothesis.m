function [cRates, l] = compute_accuracy_per_step_per_hypothesis(rec)
%COMPUTE_CLASSIFICATION_EVO

l = Logger();
cRates = zeros(rec.nSteps, rec.nHypothesis);
for iStep = 1:rec.nSteps
    %
    fprintf('%4d/%4d',iStep, rec.nSteps);
    
    state = rec.state(iStep);
    action = rec.action(iStep);
    
    %% compute hypothetic plabels
    hypothesisPLabel = cellfun(@(hyp) rec.learnerFrame.compute_labels(hyp, state, action), rec.hypothesisPolicies, 'UniformOutput', false);
    l.log_multiple_fields(rec.hypothesisRecordNames, hypothesisPLabel)
    
    if rec.targetReached(iStep)
        for iHyp = 1:rec.nHypothesis
            l.(rec.hypothesisRecordNames{iHyp}) = rec.(rec.hypothesisRecordNames{iHyp})(1:iStep, :);
        end
    end
    
    %%
    if iStep > rec.nInitSteps
        for iHyp = 1:rec.nHypothesis
            X = rec.teacherSignal(1:iStep, :);
            pY = l.(rec.hypothesisRecordNames{iHyp});
            %CV
            [predicted, given] = cross_validation(rec.blankClassifier, X, pY, 10);
            predicted = vertcat(predicted{:});
            given = vertcat(given{:});
            %
            cRates(iStep, iHyp) = accuracy_label(plabel_to_label(predicted), plabel_to_label(given));
        end
    end
    %
    fprintf('\b\b\b\b\b\b\b\b\b')
end