x=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,40,50,60,70,80,90,100];
y1=[69.6,78.5,78.7,79.6,79.4,81.7,82,81.4,82.2,82.3,82.3,84.3,86.1,86.4,87.8,86.8,86.7,88,88.6,85.4,86.7,88.2,86.3,88.1,89.8,88.9,86.9,88.4,89.5,90,91.4,92.3,91.9,92.7,93.8,93.7,94];
y2=[67,71,68.7,69.3,69,69,73,72,69,70,70,66,68,66,68,68,73,69,65,65,67,67,69,67,66,68,68.6,68.8,69,70.2,70,70.4,71.2,71,72,72,73];

plot(x,y1,'LineWidth',3);
hold on;
plot(x,y2,'LineWidth',3);
legend('Train Accuracy','Test Accuracy');