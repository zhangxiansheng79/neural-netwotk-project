clc; 
clear all; 
num = 1; 
x(num) = rand(1)*2-1; 
y(num) = rand(1)*2-1; 
f(num) = (1-x(num))^2 + 100*(y(num)-x(num)^2)^2; 
while f(num) > 1e-8 || num > 20000
Fx(num) = 2*x(num)-2+400*(x(num)^3-x(num)*y(num));
Fy(num) = 200*(y(num)-x(num)^2);
hex{num} = [1200*x(num)^2-400*y(num)+2 -400*x(num); -400*x(num) 200];
num = num + 1;
tmp = [x(num-1);y(num-1)] - inv(hex{num-1})*[Fx(num-1);Fy(num-1)];
x(num) = tmp(1);
y(num) = tmp(2);
f(num) = (1-x(num))^2 + 100*(y(num)-x(num)^2)^2; 
end

plot(x,y,'-');
s = sprintf('Trajectory of (x, y) for eta = 0.001');
title(s);