clc
clear all;
close all;


x = linspace(-pi,pi,400);
trainX = [x; sinc(x)]; %2x400 matrix
%plot(trainX(1,:),trainX(2,:),'+r'); axis equal

%y = randn(400,2);
%s2 = sum(trainX.^2,2);
%trainX = (y.*repmat(1*(gammainc(s2/2,1).^(1/2))./sqrt(s2),1,2))';


w = som(trainX',1,25,1000);

figure
plot(trainX(1,:),trainX(2,:),'*r',w(:,1),w(:,2),'-dk');
legend('Train','self-organize-map');
