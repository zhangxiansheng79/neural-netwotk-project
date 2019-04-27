clc
clear all;
close all;

x = -1.6:0.08:1.6;

y = 1.2*sin(pi*x) - cos(2.4*pi*x);
d = 1.2*sin(pi*x) - cos(2.4*pi*x) + 0.3*randn(size(x));
w = zeros(length(x),1);
D = zeros(length(x),length(x));
lambda = 0.2;

D = exp(-(dist(x)).^2/0.02);
w = inv(D'*D+lambda*eye(size(D)))*D'*d';

xtest = -1.6:0.01:1.6;
ytest = 1.2*sin(pi*xtest) - cos(2.4*pi*xtest);
y_out = zeros(size(xtest));
 
% for i = 1:length(x)
%     y_out = y_out + w(i)*exp(-(xtest - x(i)).^2/0.02);
% end
% 
DD = exp(-(dist(xtest',x)).^2/0.02);
y_out = (DD*w)';


figure
plot(xtest,ytest,'b-','LineWidth',2);
hold on;
plot(xtest,y_out,'r+-');
hold on;
plot(x,d,'-dk');
legend('Test dataset','RBFN output','Train dataset')
hold off
