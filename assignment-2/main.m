%%
% II.1.1
%
clear;fprintf('--------- II.1.1 ---------\n');

trainData = importdata('data/IrisTrain2014.dt');
testData = importdata('data/IrisTest2014.dt');

out = lda(trainData);

fprintf('Training data:\n');
C = arrayfun(@(x, y) out([x y]), trainData(:, 1), trainData(:, 2));
acc = 1 - sum(trainData(:, 3) ~= C)/length(C);
fprintf('\taccuracy = %1.2f\n\n', acc);

fprintf('Test data:\n');
C = arrayfun(@(x, y) out([x y]), testData(:, 1), testData(:, 2));
acc = 1 - sum(testData(:, 3) ~= C)/length(C);
fprintf('\taccuracy = %1.2f\n\n', acc);