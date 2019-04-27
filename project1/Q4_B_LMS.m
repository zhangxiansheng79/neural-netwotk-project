x=[1,0;1,0.8;1,1.6;1,3;1,4;1,5];
d=[0.5;1;4;5;6;8];
w=[2,3.5];
w2=inv(x'*x)*x'*d;
learning_rate=0.01;
epoches=100;
W=zeros(101,2);
W(1,:)=w;
for m=1:epoches
    for i=1:length(d)
        e=d(i)-w*x(i,:)';
        w=w+learning_rate*e*x(i,:);
        W(m+1,:)=w;       
    end
end

figure;
subplot(1,2,1);
plot(W,'LineWidth',3);
title('Learned weights for input-output problem');
xlabel('Number of examples seen')
ylabel('Weight/Bias Value')
legend('b','w1', 'Location', 'northwest')


subplot(1,2,2);
plot(x(:,2),d,'o');
hold on;
x_range = 0:5;
y_range = w2(2)*x_range + w2(1);
plot(x_range,y_range, '--','LineWidth',3);
hold on;
y_range2=w(2)*x_range+w(1)
plot(x_range,y_range2, '--','LineWidth',3);
legend('LMS','LLS');



