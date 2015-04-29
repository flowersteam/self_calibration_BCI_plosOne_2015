%% Setup experiment
% I declare those variable this way to be sure to not use it from the workspace
% Otherwise an other method would be
% nSteps = 100; rec.logit(nSteps)

rec.log_field('nSteps', 500) % nb of step to simulate
rec.log_field('nInitSteps', 40) %minPointNeeded

actionSelectionInfo = struct;
actionSelectionInfo.method = 'uncertainty';
actionSelectionInfo.initMethod = 'random';
actionSelectionInfo.confidentMethod = 'greedy';
actionSelectionInfo.epsilon = 0;
actionSelectionInfo.nStepBetweenUpdate = 1;
rec.log_field('actionSelectionInfo', actionSelectionInfo)

rec.log_field('nStepBetweenStateReset', 0) % 0 means never reset

rec.log_field('uncertaintyMethod', 'signal_sample')
rec.log_field('nSampleUncertaintyPlanning', 20)

rec.log_field('nCrossValidation', 10)
% rec.log_field('nSampling', 50)
% rec.log_field('calibrationRatio', [0.5, 0.5])

rec.log_field('confidenceLevel', 0.9)

methodInfo = struct;
methodInfo.classifierMethod = 'online';
methodInfo.samplingMethod = 'one_shot';
methodInfo.estimateMethod = 'power_matching';
methodInfo.cumulMethod = 'filter';
methodInfo.probaMethod = 'pairwise';
rec.log_field('methodInfo', methodInfo)