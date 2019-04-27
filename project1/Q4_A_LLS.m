x=[1,0;1,0.8;1,1.6;1,3;1,4;1,5];
d=[0.5;1;4;5;6;8];
w=inv(x'*x)*x'*d;

plot(x(:,2),d,'o');
hold on;
x_range = 0:5;
y_range = w(2)*x_range + w(1);
plot(x_range,y_range, '--','LineWidth',3);
