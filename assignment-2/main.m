%%
% II.1.1
%
clear;fprintf('--------- II.1.1 ---------\n');

trainData = importdata('data/IrisTrain2014.dt');
testData = importdata('data/IrisTest2014.dt');

out = lda(trainData);

disp(out);

fprintf('Training data:\n');
C = arrayfun(@(x, y) out([x y]), trainData(:, 1), trainData(:, 2));
acc = 1 - sum(trainData(:, 3) ~= C)/length(C);
fprintf('\taccuracy = %1.2f\n\n', acc);

fprintf('Test data:\n');
C = arrayfun(@(x, y) out([x y]), testData(:, 1), testData(:, 2));
acc = 1 - sum(testData(:, 3) ~= C)/length(C);
fprintf('\taccuracy = %1.2f\n\n', acc);

%%
% II.1.2
%
clear;fprintf('--------- II.1.2 ---------\n');

trainData = importdata('data/IrisTrain2014.dt');
testData = importdata('data/IrisTest2014.dt');

Means = mean(trainData(:,1:2), 1);
Stds = std(trainData(:,1:2), 0, 1);

normTrainData = my_normalize(trainData, Means, Stds);
normMeans = mean(normTrainData(:,1:2), 1)
normVars = var(normTrainData(:,1:2), 0, 1)

normTestData = my_normalize(testData, Means, Stds);

getClassFun = lda(normTrainData);

fprintf('Training data, normalized:\n');
C = arrayfun(@(x, y) getClassFun([x y]), normTrainData(:, 1), normTrainData(:, 2));
acc = 1 - sum(trainData(:, 3) ~= C)/length(C);
fprintf('\taccuracy = %1.2f\n\n', acc);

fprintf('Test data, normalized:\n');
C = arrayfun(@(x, y) getClassFun([x y]), normTestData(:, 1), normTestData(:, 2));
acc = 1 - sum(testData(:, 3) ~= C)/length(C);
fprintf('\taccuracy = %1.2f\n\n', acc);

%%
% II.1.1
%
clear;fprintf('--------- II.1.3 ---------\n');

trainData = importdata('data/IrisTrain2014.dt');
testData = importdata('data/IrisTest2014.dt');

[trainAcc testAcc] = my_lda(trainData, testData);
disp (trainAcc);
disp (testAcc);



