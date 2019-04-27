clc
clear all;
close all;

load('Digits.mat');

train_data=zscore(train_data);
test_data=zscore(test_data);
train_data = train_data';
test_data = test_data';
train_classlabel = train_classlabel';
test_classlabel = test_classlabel';

omit1 = 1;
omit2 = 2;


% To select a few classes for training, you may refer to the following code:
train_idx = find(train_classlabel~=omit1 & train_classlabel~=omit2); % omit classes 3, 4
trainy = train_classlabel(train_idx);
trainX = train_data(train_idx,:);

test_idx = find(test_classlabel~=omit1 & test_classlabel~=omit2); % omit classes 3, 4
testy = test_classlabel(test_idx);
testX = test_data(test_idx,:);

som_size = 10;
image_size = 28;
k = 9;
iteration =1500;

w = newsom(trainX, som_size, som_size, iteration);

[~, trainPred_idx] = pdist2(trainX, w, 'euclidean', 'Smallest', k);
trainPred = trainy(trainPred_idx);
if k == 1
    w_pred = trainPred';
else
    w_pred = mode(trainPred, 1);
end

map = reshape(w_pred, [som_size som_size])';

for i = 1:som_size^2
        subplot(som_size,som_size,i);
        imshow(reshape(w(i,:), [image_size, image_size])');
        title(w_pred(i))
end
% test
[~, testPred_idx] = pdist2(w, testX, 'euclidean', 'Smallest', k);
testPred = w_pred(testPred_idx);
if k == 1
    testlabel = testPred';
else
    testlabel = mode(testPred, 1);
end

acc = sum(testlabel'== testy) / size(testy, 1);