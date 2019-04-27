clc; 
clear all; 
num = 1; 
x(num) = rand(1)*2-1; 
y(num) = rand(1)*2-1; 
f(num) = (1-x(num))^2 + 100*(y(num)-x(num)^2)^2; 
learningrate =0.001; 

while f(num) > 1e-8
fx(num) = 2*x(num)-2+400*(x(num)^3-x(num)*y(num));
fy(num) = 200*(y(num)-x(num)^2);
num = num + 1;
x(num) = x(num-1) - learningrate*fx(num-1);
y(num) = y(num-1) - learningrate*fy(num-1);
f(num) = (1-x(num))^2 + 100*(y(num)-x(num)^2)^2; 
end

i = 1:num;
plot(i,f(i),'-');