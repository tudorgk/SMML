
%Exercise 2.1
[Ox,Oy] = gaussian1d(2,3);

plot(Ox,Oy,'b');

%%
%Exercise 2.2
%S = randn(100,2);
%plot(S);

mu = [1 2];
sigma = [0.3 0.2; 0.2 0.2];
R = chol(sigma,'lower');
z = repmat(mu',1,100) + R*randn(100,2)';
z=z';

plot(z(:,1),z(:,2),'b.');

%Exercise 2.3
%calcualte mean
s = sum(z);
m = s/size(z,1);

hold on; plot(m(:,1),m(:,2),'r.');hold off;
hold on; plot(mu(:,1),mu(:,2),'g.');hold off;


%Exercise 2.4
%calculate covariance
covariance = cov(z);
%covariance=sigma;
[eigenvec, eigenval] = eig(covariance);
k = sqrt(diag(eigenval));
axis([-1 4 -1 4])
hold on; plot([m(1) m(1)+k(1)*eigenvec(1,1)],[m(2) m(2)+k(1)*eigenvec(1,2)],'r-');hold off;
hold on; plot([m(1) m(1)+k(2)*eigenvec(2,1)],[m(2) m(2)+k(2)*eigenvec(2,2)],'r-');hold off;


%%
%Rotated Gaussian distributions
figure;
mu = [1 2];
sigma = [0.3 0.2; 0.2 0.2];
r30 = [cos(30) -sin(30); sin(30) cos(30)];
r60 = [cos(60) -sin(60); sin(60) cos(60)];
r90 = [cos(90) -sin(90); sin(90) cos(90)];
sigma30 = r30 * sigma *inv(r30) ;
sigma60 = r60 * sigma *inv(r60) ;
sigma90 = r90 * sigma *inv(r90) ;

R30 = chol(sigma30,'lower');
R60 = chol(sigma60,'lower');
R90 = chol(sigma90,'lower');

z30 = repmat(mu',1,100) + R30*randn(100,2)';
z60 = repmat(mu',1,100) + R60*randn(100,2)';
z90 = repmat(mu',1,100) + R90*randn(100,2)';

z30=z30';
z60=z60';
z90=z90';


plot(z30(:,1),z30(:,2),'b.');
hold on;plot(z60(:,1),z60(:,2),'y.');hold off;
hold on;plot(z90(:,1),z90(:,2),'r.');hold off;

%Exercise 2.4
%calculate covariance
covariance30 = cov(z30);
covariance60 = cov(z60);
covariance90 = cov(z90);
%covariance=sigma;
[eigenvec30, eigenval30] = eig(covariance30);
[eigenvec60, eigenval60] = eig(covariance60);
[eigenvec90, eigenval90] = eig(covariance90);

k30 = sqrt(diag(eigenval30));
k60 = sqrt(diag(eigenval60));
k90 = sqrt(diag(eigenval90));

axis([-1 4 -1 4])
hold on; plot([m(1) m(1)+k30(1)*eigenvec30(1,1)],[m(2) m(2)+k30(1)*eigenvec30(1,2)],'b-');hold off;
hold on; plot([m(1) m(1)+k30(2)*eigenvec30(2,1)],[m(2) m(2)+k30(2)*eigenvec30(2,2)],'b-');hold off;

axis([-1 4 -1 4])
hold on; plot([m(1) m(1)+k60(1)*eigenvec60(1,1)],[m(2) m(2)+k60(1)*eigenvec60(1,2)],'y-');hold off;
hold on; plot([m(1) m(1)+k60(2)*eigenvec60(2,1)],[m(2) m(2)+k60(2)*eigenvec60(2,2)],'y-');hold off;

axis([-1 4 -1 4])
hold on; plot([m(1) m(1)+k90(1)*eigenvec90(1,1)],[m(2) m(2)+k90(1)*eigenvec90(1,2)],'r-');hold off;
hold on; plot([m(1) m(1)+k90(2)*eigenvec90(2,1)],[m(2) m(2)+k90(2)*eigenvec90(2,2)],'r-');hold off;


%%
%
trainFileID = fopen('IrisTrain2014.dt','r');
formatSpec = '%f %f %d';
sizeTrainMat = [3 Inf];
TrainMat = fscanf(trainFileID,formatSpec,sizeTrainMat);
TrainMat=TrainMat';

testFileID = fopen('IrisTest2014.dt','r');
formatSpec = '%f %f %d';
sizeTestMat = [3 Inf];
TestMat = fscanf(testFileID,formatSpec,sizeTestMat);
TestMat = TestMat';


% figure;


%display test input
% for i = 1:size(TrainMat,1)
%     flower = TrainMat(i,:);
%     if(flower(3) == 0)
%         hold on; plot(flower(:,1),flower(:,2),'b.');hold off;
%     end
%     
%     if(flower(3) == 1)
%         hold on; plot(flower(:,1),flower(:,2),'r.');hold off;
%     end
%     
%     if(flower(3) == 2)
%         hold on; plot(flower(:,1),flower(:,2),'y.');hold off;
%     end
%     
% end
% 


K = 1;

riskSum = 0;

for i = 1:size(TestMat,1)
    distances = zeros(size(TrainMat,1),2);
    for j = 1:size(TrainMat,1)
        d = sqrt(power(TrainMat(j,1)-TestMat(i,1),2)+power(TrainMat(j,2)-TestMat(i,2),2));
        distances(j,:) = [d,TrainMat(j,3)]; 
    end
    distances = sortrows(distances,1);

    countingVector = zeros(1,3);
    for k = 1:K 
        countingVector(distances(k,2) + 1) = countingVector(distances(k,2) + 1) + 1;
    end
    
    index = find(countingVector == max(countingVector(:))) - 1;
  
    if index ~= TestMat(i,3)
        riskSum = riskSum + 1;
    end
    
end

riskSum = riskSum / size(TestMat,1);

%%

trainFileID = fopen('IrisTrain2014.dt','r');
formatSpec = '%f %f %d';
sizeTrainMat = [3 Inf];
TrainMat = fscanf(trainFileID,formatSpec,sizeTrainMat);
TrainMat=TrainMat';

testFileID = fopen('IrisTest2014.dt','r');
formatSpec = '%f %f %d';
sizeTestMat = [3 Inf];
TestMat = fscanf(testFileID,formatSpec,sizeTestMat);
TestMat = TestMat';

S = 5;

kRiskMatrix = [];

blockDimension = int32(size(TrainMat,1)/S);

for k = 1:2:25
    
    kAverage = 0;
    
   for s = 1:S
        Test = TrainMat((s-1)*blockDimension + 1:s*blockDimension,:);
        Train = TrainMat;
        Train((s-1)*blockDimension + 1:s*blockDimension,:) = [];
        kAverage = kAverage + kNN(k,Train, Test); 
   end
   
   new_row =[k kAverage/5] ; 
   kRiskMatrix = [kRiskMatrix ; new_row];

end

    kBestIndex = find(kRiskMatrix == min(kRiskMatrix(2)));
    kBest = kRiskMatrix(kBestIndex,1);