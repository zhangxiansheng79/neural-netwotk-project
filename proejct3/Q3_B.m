clc
clear all;
close all;

X = randn(800,2);
s2 = sum(X.^2,2);
trainX = (X.*repmat(1*(gammainc(s2/2,1).^(1/2))./sqrt(s2),1,2))';

w = som(trainX',8,8,2);

figure
plot(trainX(1,:),trainX(2,:),'+r'); 
axis equal;
hold on;
for i = 0:7
    plot(w(i*8+1:(i+1)*8,1),w(i*8+1:(i+1)*8,2),'-dk');
end
hold on;
for i = 1:8
    plot(w(i:8:i+56,1),w(i:8:i+56,2),'-dk');
end
hold off;
legend('Train accuracy','self-organize-map');