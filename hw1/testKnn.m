%% home work 1.1

%% load train and test data
function testKnn(trainData, trainClassify, testData, testClassify)
    [~, m1] = size(trainData);
    [~, m2] = size(testData);
    if m1 ~= m2
        trainData = trainData';
        trainClassify = trainClassify';
        testData = testData';
        testClassify = testClassify';
    end
    
    mdl = fitcknn(trainData, trainClassify);
    numOfTest = length(testClassify);
    nns = 1:2:11;
    numOfNns = length(nns);
    accuracies = ones(1,numOfNns);
   
    for n = 1:numOfNns
       mdl.NumNeighbors = nns(n);
       result = predict(mdl, testData);
       accuracies(n) = sum(result == testClassify) / numOfTest;
    end
    figure % new figure
    ax1 = subplot(1,2,1); % left subplot
    ax2 = subplot(1,2,2); % right subplot
    plot(ax1, nns, accuracies);
    title(ax1, '邻居数K与分类精确度的关系');
    xlabel(ax1, 'K');
    ylabel(ax1, 'accuracy');
    
    
    scales = [100,200,300,500,700,900,1000];
    numOfScales = length(scales);
    accuracies = ones(1,numOfScales);
    numOfDataCol = size(trainData,2);
    for i = 1:numOfScales
        scale = scales(i);
        randomIndexes = randi(length(trainData),1,scale);
        randomIndexes = sort(randomIndexes);
        data = ones(scale,numOfDataCol);
        correct = ones(scale, 1);
        for j = 1:scale
            data(j,:) = trainData(randomIndexes(j),:);
            correct(j) = trainClassify(randomIndexes(j));
        end
        mdl =fitcknn(data, correct);
        mdl.NumNeighbors = 3;
        result = predict(mdl,testData);
        accuracies(i) = sum(result == testClassify) / numOfTest;
    end
    plot(ax2, scales, accuracies);
    title(ax2,'训练样本数与分类精确度的关系');
    xlabel(ax2,'样本数');
    ylabel(ax2, 'accuracy');
end



