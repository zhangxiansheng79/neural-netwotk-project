clc 
clear all;
close all;

load mnist_m.mat;
% train_data - training data, 784x1000 matrix
% train_classlabel - the labels of the training data, 1x1000 vector
% test_data - test data, 784x250 matrix
% train_classlabel - the labels of the test data, 1x250 vector
train_data=train_data';
train_classlabel=train_classlabel';
test_data=test_data';
test_classlabel=test_classlabel';

%select a few classes for training
%trainelse=find(train_classlabel==0 | train_classlabel==1 | train_classlabel==2 | train_classlabel==3 | train_classlabel==4 | train_classlabel==5 | train_classlabel==8 | train_classlabel==9);

%testIdx=find(test_classlabel==6 | test_classlabel==7);
%testelse=find(test_classlabel==0 | test_classlabel==1 | test_classlabel==2 | test_classlabel==3 | test_classlabel==4 | test_classlabel==5 | test_classlabel==8 | test_classlabel==9);

%change lable to 1 and 0
%train_classlabel(1,trainIdx)=1;
%train_classlabel(1,trainelse)=0;
%test_classlabel(1,testIdx)=1;
%test_classlabel(1,testelse)=0;

%divide train and test data/label
%Train_Data = train_data(:,trainIdx);
% To select a few classes for training, you may refer to the following code:
trainIdx = find(train_classlabel==6 | train_classlabel==7); % select classes 1, 2
trainY = train_classlabel;
trainX = train_data;
TrLabel = zeros(size(trainY));
TrData = zeros(size(trainX'));

for i = 1:length(trainY)
    if trainY(i) == 6
        TrLabel(i) = 1;
    elseif trainY(i) == 7
        TrLabel(i) = 1;
    else 
        TrLabel(i)=0;     
    end
end

mutest = mean(double(trainX(1,1:784)),2);
sigmatest = std(double(trainX(1,1:784)),1,2);
for i = 1:size(trainX,1)
    TrData(:,i) = (double(trainX(i,:)) - mutest)./sigmatest;
end

[Idx,mu,sumD]=kmeans(TrData',2);
dm = max(max(dist(mu,mu')));
sigma = 8000;
D = exp(-dist(TrData',mu').^2/(2*sigma^2));
w = pinv(D'*D)*D'*TrLabel;
% After loading the data, you may view them using the code below:
%imshow(reshape(mu(2, :), [28,28]));
% sigma = ;
% D = exp(-(dist(TrData',mu)).^2/(2*sigma^2));

testIdx = find(test_classlabel==6 | test_classlabel==7); % select classes 1, 2
testY = test_classlabel;
testX = test_data;
TeLabel = zeros(size(testY));
TeData = zeros(size(testX'));
TeOut = zeros(size(testY));

for i = 1:length(testY)
    if testY(i) == 6
        TeLabel(i) = 1;
    elseif testY(i) == 7
        TeLabel(i) = 1;
    else
        TeLabel(i)=0;
    end
end

mutest = mean(double(testX(1,1:784)),2);
sigmatest = std(double(testX(1,1:784)),1,2);
for i = 1:size(testX,1)
    TeData(:,i) = (double(testX(i,:)) - mutest)./sigmatest;
end

DD = exp(-dist(TeData',mu').^2/(2*sigma^2));
TeOut = DD*w;

% Please use the following code to evaluate:

TrAcc = zeros(1,1000);
TeAcc = zeros(1,1000);
thr = zeros(1,1000);
TrN = length(TrLabel);
TeN = length(TeLabel);
TrPred = D*w;
TePred = DD*w;

for i = 1:1000
    t = (max(TrPred)-min(TrPred)) * (i-1)/1000 + min(TrPred);
    thr(i) = t;
    TrAcc(i) = (sum(TrLabel(TrPred<t)==0) + sum(TrLabel(TrPred>=t)==1)) / TrN;
    TeAcc(i) = (sum(TeLabel(TePred<t)==0) + sum(TeLabel(TePred>=t)==1)) / TeN;
end

figure
plot(thr,TrAcc,'.- ',thr,TeAcc,'^-');
legend('Train accuracy','Test accuracy');
xlabel('Thresholds');
ylabel('Accuracy');
save muforQ2_C.mat mu;
