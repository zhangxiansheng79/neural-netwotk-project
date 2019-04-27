clc
clear all;
x = -1.6:0.05:1.6;
y = 1.2*sin(pi*x) - cos(2.4*pi*x);
net = feedforwardnet(100,'trainlm');
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'purelin';
net = configure(net,x,y);
net.trainparam.lr=0.01;
net.trainparam.epochs=10000;
net.trainparam.goal=1e-8;
net.divideParam.trainRatio=1.0;
net.divideParam.valRatio=0.0;
net.divideParam.testRatio=0.0;
[net,tr]=train(net,x,y);
xtest = -1.6:0.01:1.6;
xtest2= -3:0.01:3;
ytest = 1.2*sin(pi*xtest) - cos(2.4*pi*xtest);
ytest2 = 1.2*sin(pi*xtest2) - cos(2.4*pi*xtest2);
net_output = sim(net,xtest2);

plot(xtest2,ytest2,'LineWidth',3);
hold on;
plot(xtest,ytest,'*','LineWidth',3);
hold on;
plot(xtest2,net_output,'LineWidth',3);
legend('target','samples','MLP')
hold off