function testResults=knn(trainImages,testImages,trainLabels,testLabels,K)
trainLabels=trainLabels';
testLabels=testLabels';
trainLength = length(trainImages);%2000   
testResults = linspace(0,0,length(testImages));  %0��0 length�ȷ�
compLabel = linspace(0,0,K);  
testLength=length(testLabels);%500
for i=1:testLength  %�������ﳤ��Ӧ��������������
    curImage = repmat(testImages(:,i),1,trainLength);  
    curImage = abs(trainImages-curImage);  %�����ֵ
	curImage=curImage.^2;%��ƽ��
    comp=sum(curImage);  
    [sortedComp,ind] = sort(comp);  
    for j = 1:K  
        compLabel(j) = trainLabels(ind(j));  %���������ĳ����������ʲô�����ı�Ǿ���ʲô
    end  
    table = tabulate(compLabel);  
    [maxCount,idx] = max(table(:,2));  %�ҵڶ����������ģ����Ǵ�����������
    testResults(i) = table(idx,1);    
end  
