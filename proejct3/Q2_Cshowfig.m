clc 
clear all;
close all;

load muforQ2_C.mat
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
% To select a few classes for training, you may refer to the following code: % select classes 1, 2
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
%select class1

trainidx1=find(TrLabel==1);
trainx1=train_data(trainidx1,:);
class1=mean(trainx1,1);

trainidx2=find(TrLabel==0);
trainx2=train_data(trainidx2,:);
class2=mean(trainx2,1);

%imshow(reshape(mu(1, :), [28,28]));

%imshow(reshape(mu(2, :), [28,28]));

%imshow(reshape(class1(1,:),[28,28]));

imshow(reshape(class2(1,:),[28,28]));





