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


%x=cat(1,desire_out,x);
%x=x(:,randperm(size(x,2)));
%desire_out=x(1,:);
%x=x(2:1025,:);



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


%x_test=cat(1,desire_out_test,x_test);
%x_test=x_test(:,randperm(size(x_test,2)));
%desire_out_test=x_test(1,:);
%x_test=x_test(2:1025,:);


n=1; 
weights(:,n)=rand(1,1024); 
eta=0.1; 
y=zeros(1,900);
v=[];
while isequal(y,desire_out)~=1
    for j=1:900
        v(j)=weights(:,n)'*x(:,j);
        if (v(j)>=0)
            y(j)=1;
        else
            y(j)=0;
        end
        
        if y(j)~=desire_out(j)
            e(j)= desire_out(j)-y(j);
            weights(:,n+1)=weights(:,n)+(eta*e(j)*x(:,j));
            n=n+1;
        else
            weights(:,n+1)=weights(:,n);
        end
    end
end

accuracy_train = 0 ;
accuracy_test = 0;

for j=1:900
   if ((weights(:,n)'*x(:,j)) >=0)
       class_train_y(j)=1.0;
   else
       class_train_y(j)=0;
   end
   if(((desire_out(j)== 0) && (class_train_y(j)== 0))||((desire_out(j)== 1.0) && (class_train_y(j)==1.0)))
       accuracy_train = accuracy_train + 1;
   end
end

for j=1:100
    if ((weights(:,n)'*x_test(:,j)) >=0)
        class_test_y(j)=1.0;
    else
        class_test_y(j)=0;
    end
    if(((desire_out_test(j)== 0) && (class_test_y(j)== 0))||((desire_out_test(j)== 1.0) && (class_test_y(j)==1.0)))
        accuracy_test = accuracy_test + 1;
    end
end

accuracy_perc_test = accuracy_test/100*100;
accuracy_perc_train = accuracy_train/900*100;
disp(accuracy_perc_train);
disp(accuracy_perc_test);
