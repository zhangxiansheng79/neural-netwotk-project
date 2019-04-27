clc; 
clear all; 
num = 1; %set the initialized iteration as 1 
x(num) = rand(1)*2-1; %2*rand(1) belongs to (0,2),then -1 belongs to (-1,1)
y(num) = rand(1)*2-1; %y:a random value between -1 and 1
f(num) = (1-x(num))^2 + 100*(y(num)-x(num)^2)^2; 
learningrate = 0.001; %learning rate

while f(num) > 1e-8
Gx(num) = 2*x(num)-2+400*(x(num)^3-x(num)*y(num));
Gy(num) = 200*(y(num)-x(num)^2);
num = num + 1;
x(num) = x(num-1) - learningrate*Gx(num-1);
y(num) = y(num-1) - learningrate*Gy(num-1);
f(num) = (1-x(num))^2 + 100*(y(num)-x(num)^2)^2; 
end


plot(x,y,'-');
s = sprintf('Trajectory of (x, y) for learning rate = 0.001');
title(s);