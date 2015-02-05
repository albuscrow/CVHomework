function currency = getAccuracy(iterNum,atomNum,x_train,y_train,x_test, y_test)
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
param.K = atomNum; 

 % number of iteration to execute the K-SVD algorithm.
param.numIteration = iterNum;

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

%perform classification on the coefficients learned by KSVD
trainCoefMatrix=trainoutput.CoefMatrix;%49*2000
testCoefMatrix = OMP(trainDic,x_test, param.L); %49*500

testResults=knn(trainCoefMatrix,testCoefMatrix,trainlabelmin,y_test,3);
currency = sum(testResults == y_test) / 500;
%disp(['The accuracy is ',num2str(currency)]);f
end
