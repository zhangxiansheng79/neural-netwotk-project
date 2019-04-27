w=rand(1,3);
learning_rate=1;
x_label=[0,0,1,1;0,1,0,1];
% add one row with 1 to x_label for the bias from w
x_label=[ones(1,4);x_label];
y_label=[1,1,1,0];
learning_time=15;
i=0;
while i<learning_time
    v=w*x_label;
    y_hat=hardlim(v);
    %error
    e=y_label-y_hat;
    %upodate the weights
    w=w+learning_rate*e*x_label';
    i=i+1;
    % for three values in w , give their values to w1,w2 and w3
    w1(i+1)=w(1);
    w2(i+1)=w(2);
    w3(i+1)=w(3);
end

figure;
subplot(2,1,1);
plot([0,0,1],[0,1,0],'x','markersize',10);
hold on;
plot(1,1,'+','markersize',10);
axis([-0.2,1.6,-0.2,1.6]);
m=sprintf('NAND:%.2f+%.2f*x1+%.2f*x2=0',w(1),w(2),w(3));
title(m);
xlabel('x1');
ylabel('x2');
hold on;
x1 = -0.5:.01:1.6;
x2 = x1*(-w(2)/w(3))-w(1)/w(3);
plot(x1,x2,'LineWidth',3);

subplot(2,1,2);
x=0:learning_time;
plot(x,w1,'*-','LineWidth',3);
hold on;
plot(x,w2,'+-','LineWidth',3);
hold on;
plot(x,w3,'o-','LineWidth',3);
axis([0,15,-5,5]);
legend('bias','w1','w2');
title('Trajectory of "NAND" weights');
hold off;
    