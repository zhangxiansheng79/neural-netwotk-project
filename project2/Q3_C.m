clc
clear all;
close all;

dictname_dog='group_1/dog';
dictname_automobile='group_1/automobile';

files_jpg_dog = dir( fullfile(dictname_dog,'*.jpg') );
files_jpg_automobile = dir( fullfile(dictname_automobile,'*.jpg') );
files_jpg_name_dog = {files_jpg_dog.name}';
files_jpg_name_automobile = {files_jpg_automobile.name}';

x_dog=ones(1024,450);
x_automobile=ones(1024,450);

for i=1:numel(files_jpg_name_dog)
    file_name_dog = fullfile(dictname_dog,files_jpg_name_dog{i});
    I_dog = imread(file_name_dog);
    G_dog =rgb2gray(I_dog);
    [m,n] = size(G_dog);
    if (m>=32 || n>=32)
        G_dog=imresize(G_dog,[32,32]);
    end
    V_dog = G_dog(:);
    data_img_dog{i} = V_dog;
end

for q=1:numel(files_jpg_name_automobile)
    file_name_automobile = fullfile(dictname_automobile,files_jpg_name_automobile{q});
    I_automobile = imread(file_name_automobile);
    G_automobile =rgb2gray(I_automobile);
    [m,n] = size(G_automobile);
    if (m>=32 || n>=32)
        G_automobile=imresize(G_automobile,[32,32]);
    end
    V_automobile = G_automobile(:);
    data_img_automobile{q} = V_automobile;
end

for i=1:450
    x_dog(:,i) = data_img_dog{1,i};
end

for q=1:450
    x_automobile(:,q)= data_img_automobile{1,q};
end

dog=450;
automobile=450;
desire_out=zeros(1,900);
desire_out(1:450)=1.0;
desire_out(451:900)=0;
x=cat(2,x_dog,x_automobile);
mean = mean(x(1:1024),2);
std = std(x(1:1024),1,2);


for z=1:900

x(:,z)=(x(:,z)-mean)./std;

end



dirtest_dog = 'group_1/dog_test';
dirtest_automobile = 'group_1/automobile_test';

files_jpg_dog_test = dir( fullfile(dirtest_dog,'*.jpg') );
files_jpg_name_dog_test = {files_jpg_dog_test.name}';
files_jpg_automobile_test = dir( fullfile(dirtest_automobile,'*.jpg') );
files_jpg_name_automobile_test = {files_jpg_automobile_test.name}';

xtest_dog = ones(1024,50);
xtest_automobile=ones(1024,50);


for i = 1:numel(files_jpg_name_dog_test)
    file_name_dog = fullfile(dirtest_dog,files_jpg_name_dog_test{i});
    I_dog = imread(file_name_dog);
    G_dog_test = rgb2gray(I_dog);
    [m,n] = size(G_dog_test);
    if (m>=32 || n>=32)
        G_dog_test = imresize(G_dog_test,[32,32]);
    end
    V_dog_test = G_dog_test(:);
    data_img_dog_test{i} = V_dog_test;
end
for i = 1:numel(files_jpg_name_automobile_test)
    file_name_automobile = fullfile(dirtest_automobile,files_jpg_name_automobile_test{i});
    I_automobile = imread(file_name_automobile);
    G_automobile_test = rgb2gray(I_automobile);
    [m,n] = size(G_automobile_test);
    if (m>=32 || n>=32)
        G_automobile_test = imresize(G_automobile_test,[32,32]);
    end
    V_automobile_test = G_automobile_test(:);
    data_img_automobile_test{i} = V_automobile_test;
end



for i = 1:50
    xtest_dog(:,i) = data_img_dog_test{1,i};
end

for i = 1:50
    xtest_automobile(:,i) = data_img_automobile_test{1,i};
end


desire_out_test = zeros(1,100);
dog_t = 50;
automobile_t =50;
desire_out_test(1:50)=1.0;
desire_out_test(51:100)=0;
x_test=cat(2,xtest_dog,xtest_automobile);

for l=1:100

x_test(:,l)=(x_test(:,l)-mean)./std;


end


n= [1];%n=1,2,3,4,5,10,20,40

accuracy_train = zeros(length(n),1);
accuracy_test = zeros(length(n),1);
accuracy_perc_test=zeros(length(n),1);
accuracy_perc_train=zeros(length(n),1); 

for k=1:length(n)
    net = newff(minmax(x),[n(k),1],{'tansig','logsig'},'traincgf'); 
    net.trainparam.show = 2000;
    net.trainparam.lr = 0.01;
    net.trainparam.epochs = 100;
    net.trainparam.goal = 1e-8;
    net.performParam.regularization = 0.1;
    net = train(net,x,desire_out); 
    test_output=sim(net,x_test);
    train_output =sim(net,x); 
    
    for j=1:length(train_output)
        if train_output(j) > 0.5
            clas_train_y(j)=1.0;
        else
            clas_train_y(j)=0;
        end
        if(((desire_out(j)==0) && (clas_train_y(j)==0))||((desire_out(j)==1.0) && (clas_train_y(j)==1.0)))
            accuracy_train(k,1) = accuracy_train(k,1) + 1;
        end
        accuracy_perc_train(k,1) = accuracy_train(k,1)/900*100;
    end
    for j=1:length(test_output)
        if test_output(j) > 0.5
            clas_test_y(j)= 1.0;
        else
            clas_test_y(j)=0;
        end
        if(((desire_out_test(j)==0) && (clas_test_y(j)==0))||((desire_out_test(j)==1.0) && (clas_test_y(j)==1.0)))
            accuracy_test(k,1) = accuracy_test(k,1) + 1;
        end
        accuracy_perc_test(k,1) = accuracy_test(k,1)/100*100;
    end
end