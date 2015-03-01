%%
% II.1.1
%
clear;fprintf('--------- II.1.1 ---------\n');

trainData = importdata('data/IrisTrain2014.dt');
testData = importdata('data/IrisTest2014.dt');

[trainAcc, testAcc] = my_lda(trainData, testData);
disp (trainAcc);
disp (testAcc);

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

[trainAcc, testAcc] = my_lda(normTrainData, normTestData);
disp (trainAcc);
disp (testAcc);

%%
% II.2.1
%
clear;fprintf('--------- II.2.1 ---------\n');

trainData = importdata('data/sunspotsTrainStatML.dt');
testData = importdata('data/sunspotsTestStatML.dt');
l = length(trainData);
testYears = 1916:2011;

%Selection 1
Phi1 = horzcat(ones(l,1),trainData(:,3),trainData(:,4));
wML1 = my_wML(Phi1, trainData(:,6));
X1 = testData (:,3:4);
prediction1 = my_lmfunction(wML1,X1);

%RMS 1
rms1 = my_rms(prediction1,testData(:,6));

figure;
hold on;
title('Selection 1 - measured(blue) vs. predicted(red) 1916 - 2011','FontSize', 15);
legend('Actual sunspots', 'Predicted sunspots');
plot(testYears, prediction1, 'r', testYears, testData(:,6), 'b');
hold off;

%Selection 2
Phi2 = horzcat(ones(l,1),trainData(:,5));
wML2 = my_wML(Phi2, trainData(:,6));
X2 = testData (:,5);
prediction2 = my_lmfunction(wML2,X2);

%RMS 2
rms2 = my_rms(prediction2,testData(:,6));

%training and test set with predicted target variables plot
figure;
hold on;
title('Selection 2 - training and test set with predicted target variables.','FontSize', 15);
legend('Training data', 'Real targets', 'Predicted targets');
plot(trainData(:,5),trainData(:,6),'rx', testData(:,5), testData(:,6), 'gx', testData(:,5), prediction2, 'bx');
hold off;

figure;
hold on;
title('Selection 2 - measured(blue) vs. predicted(red) 1916 - 2011','FontSize', 15);
legend('Actual sunspots', 'Predicted sunspots');
plot(testYears, prediction2, 'r', testYears, testData(:,6), 'b');
hold off;

%Selection 3
Phi3 = horzcat(ones(l,1),trainData(:,1),trainData(:,2),trainData(:,3),trainData(:,4),trainData(:,5));
wML3 = my_wML(Phi3, trainData(:,6));
X3 = testData (:,1:5);
prediction3 = my_lmfunction(wML3,X3);

%RMS 1
rms3 = my_rms(prediction3,testData(:,6));

figure;
hold on;
title('Selection 3 - measured(blue) vs. predicted(red) 1916 - 2011','FontSize', 15);
legend('Actual sunspots', 'Predicted sunspots');
plot(testYears, prediction3, 'r', testYears, testData(:,6), 'b');
hold off;

%%
% II.2.2
%
clear;fprintf('--------- II.2.2 ---------\n');

