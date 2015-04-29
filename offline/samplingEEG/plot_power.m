init_random_seed(1);

%%

%generate artificial teaching signals
nFeatures = 34;
expNames = {'OT1', 'OT2', 'RL2', 'RL3'};
isValid = false;
while ~isValid % it should alwyas be valid
    [path, isValid] = sample_EEG_dataset_path(nFeatures, expNames);
end
load(path)

pY = label_to_plabel(Y, 1);

%%
classifier = GaussianUninformativePrior_classifier('shrink', 0.5);
classifier.fit(X, pY)

confusionMatrix = classifier.compute_hard_empirical_confusion_matrix(nCrossValidation);
accuracy = sum(diag(confusionMatrix))

%%
nCrossValidation = 10;
nObservation = size(X, 1);

confusionMatrix = classifier.compute_proba_empirical_confusion_matrix(nCrossValidation);
% normalize it per column!  may be optimized
confusionMatrix = proba_normalize_row(confusionMatrix')';

%compute powers
powers = sum(X.^2, 2);

%
predictedPLabel = classifier.logpredict(X);
correctedPredictedPLabel = zeros(size(predictedPLabel));
for iObservation = 1:nObservation
    correctedPredictedPLabel(iObservation, :) = confusionMatrix * predictedPLabel(iObservation, :)';
end

%
powerCorrect = weighted_mean(powers, correctedPredictedPLabel(:,1))
powerWrong = weighted_mean(powers, correctedPredictedPLabel(:,2))
ratio = powerWrong/powerCorrect
ration_symmetric = powerCorrect/powerWrong

%%

% Change default axes fonts.
set(0,'DefaultAxesFontName', 'Courier')
DefaultAxesFontSize = 25;
set(0,'DefaultAxesFontSize', DefaultAxesFontSize)
set(0,'DefaultAxesFontWeight','bold')
set(0,'DefaultAxesLineWidth', 2.5)

pltMargin = 0.05;
pltSegmentMargin = 1;

niceBlue = [0.2, 0.4, 0.8];
niceGreen = [0.4, 0.8, 0.2];
niceGray = [0.5, 0.5, 0.5];
niceOrange = [0.9, 0.5, 0];
niceRed = [1, 0.2, 0.2];

figPosition = [200, 300, 800, 700];

OutlierMarker = 'x';
OutlierMarkerSize = 10;
OutlierMarkerFaceColor = 'k';
OutlierMarkerEdgeColor = 'k';
WidthE = 0.8;
WidthL = 0.8;
WidthS = 0.8;

labelNames = {'Correct', 'Incorrect'};

dimColor = [niceGray];

%%

data = nan(1000, 2);
tmp = powers(Y == 1);
data(1:length(tmp), 1) = tmp;
tmp = powers(Y == 2);
data(1:length(tmp), 2) = tmp;

figure('Position', figPosition)


aboxplot(data,'labels', labelNames, ...
    'Colormap', dimColor , ...
    'OutlierMarker', OutlierMarker, ...
    'OutlierMarkerSize', OutlierMarkerSize, ...
    'OutlierMarkerEdgeColor', OutlierMarkerEdgeColor, ...
    'OutlierMarkerFaceColor', OutlierMarkerFaceColor, ...
    'WidthE', WidthE, ...
    'WidthL', WidthL,...
    'WidthS', WidthS);


ylim([0 2500])
ylabel('Signal power')


%%

idx = randperm(nObservation);
X = X(idx, :);

classifier = GaussianUninformativePrior_classifier('shrink', 0.5);
classifier.fit(X, pY)

confusionMatrix = classifier.compute_hard_empirical_confusion_matrix(nCrossValidation);
accuracy_shuffle = sum(diag(confusionMatrix))

confusionMatrix = classifier.compute_proba_empirical_confusion_matrix(nCrossValidation);
% normalize it per column!  may be optimized
confusionMatrix = proba_normalize_row(confusionMatrix')';

%compute powers
powers = sum(X.^2, 2);

%
predictedPLabel = classifier.logpredict(X);
correctedPredictedPLabel = zeros(size(predictedPLabel));
for iObservation = 1:nObservation
    correctedPredictedPLabel(iObservation, :) = confusionMatrix * predictedPLabel(iObservation, :)';
end

%
powerCorrect = weighted_mean(powers, correctedPredictedPLabel(:,1));
powerWrong = weighted_mean(powers, correctedPredictedPLabel(:,2));
ratio_shuffle = powerWrong/powerCorrect









