function testResults=knn(trainImages,testImages,trainLabels,testLabels,K)
trainLabels=trainLabels';
testLabels=testLabels';
trainLength = length(trainImages);%2000   
testResults = linspace(0,0,length(testImages));  %0到0 length等分
compLabel = linspace(0,0,K);  
testLength=length(testLabels);%500
for i=1:testLength  %觉得这里长度应该是样本数量？
    curImage = repmat(testImages(:,i),1,trainLength);  
    curImage = abs(trainImages-curImage);  %求绝对值
	curImage=curImage.^2;%求平方
    comp=sum(curImage);  
    [sortedComp,ind] = sort(comp);  
    for j = 1:K  
        compLabel(j) = trainLabels(ind(j));  %离它最近的某几个点标记是什么，它的标记就是什么
    end  
    table = tabulate(compLabel);  
    [maxCount,idx] = max(table(:,2));  %找第二列中数最大的，即是次数出现最多的
    testResults(i) = table(idx,1);    
end  
