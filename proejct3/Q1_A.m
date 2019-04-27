clc
clear all;
close all;

x=-1.6:0.08:1.6;
y=1.2*sin(pi*x)-cos(2.4*pi*x);
d=1.2*sin(pi*x)-cos(2.4*pi*x)+0.3*randn(size(x));%observed output of train data
w=zeros(length(x),1);
D=zeros(length(x),length(x));

D=exp(-dist(x).^2/0.02);
w=inv(D)*d';

xtest=-1.6:0.01:1.6;
ytest = 1.2*sin(pi*xtest) - cos(2.4*pi*xtest);
y_out=zeros(size(xtest));

DD=exp(-(dist(xtest',x)).^2/0.02);
y_out=(DD*w)';



figure
plot(xtest,ytest,'b-');
hold on;
plot(xtest,y_out,'r+-');
hold on;
plot(x,d,'-dk');
legend('Test dataset','RBFN output','Train dataset')
hold off

