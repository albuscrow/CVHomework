close all;

%样本维度
[d,~] = size(x_train);

%对于每一类，取前100个样本
q = 1;
traindatamin = zeros(d, 10 * 200);
trainlabelmin = zeros(d, 10 * 200);
for i=1:10
    for j=1:200
        col = (i - 1) * 1000 + j;
        traindatamin(:,q)=x_train(:,col);
        trainlabelmin(:,q)=y_train(:,col);
        q=q+1;
    end
end
%设置参数
% number of elements in each linear combination.
param.L = 3;   

% number of dictionary elements
param.K = 49; 

 % number of iteration to execute the K-SVD algorithm.
param.numIteration = 5;

% decompose signals until a certain error is reached.
% do not use fix number of coefficients.
param.errorFlag = 0; 

%param.errorGoal = sigma;
param.preserveDCAtom = 0;
param.InitializationMethod =  'DataElements';

param.displayProgress = 1;
disp('Starting to  train the dictionary');

%生成字典
[trainDic,trainoutput]  = KSVD(traindatamin,param);
[dicrows,diccols]=size(trainDic);


%显示字典
Dic=reshape(trainDic,1,dicrows*diccols);
Dic=mapminmax(Dic,0,1);
Dic=reshape(Dic,dicrows,diccols);
n=sqrt(param.K);
A = zeros(28,196);
B = zeros(196:196);
for i=1:n
    for j=1:n
        offset = (i - 1)*n + j;
        A(:,int64((j - 1)*28 + 1):int64(j*28)) = reshape(Dic(:,offset),28,28);
    end
    B(int64((i - 1) * 28 + 1) : int64(i*28) , :) = A;
end

imshow(B');

%画网格
hold on;
x=0:28:28*n;
y=0:28:28*n;
M=meshgrid(x,y);
plot(x,M,'r');
plot(M,y,'r');
hold off;

%perform classification on the coefficients learned by KSVD
trainCoefMatrix=trainoutput.CoefMatrix;%49*2000
[rows,cols]=size(x_test);
testCoefMatrix = OMP(trainDic,x_test, param.L); %49*500

testResults=knn(trainCoefMatrix,testCoefMatrix,trainlabelmin,y_test,3);
disp(['The accuracy is ',num2str(sum(testResults == y_test) / 500)]);

