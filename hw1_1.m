%% home work 1.1


% %% function to train data
% function mdl = trainData(predictor, classification, NumNeighbors)
%     mdl = fitcknn(predictor, classification);
%     mdl.NumNeighbors = NumNeighbors;
% end
% 
% %% function to classify data
% function result = testData(mdl, testData)
%     result = predict(mdl, testData);
% end

%% load train and test data
function accuracies =  hw1_1(predictor, classification, testData, testClassify)
    mdl = fitcknn(predictor, classification);
    numOfTest = length(testClassify);
    nns = 1:2:11;
    numOfNns = length(nns);
    accuracies = ones(1,numOfNns);
    figure % new figure
    ax1 = subplot(1,2,1); % left subplot
    ax2 = subplot(1,2,2); % right subplot
    for n = 1:numOfNns
       mdl.NumNeighbors = nns(n);
       result = predict(mdl, testData);
       accuracies(n) = sum(result == testClassify) / numOfTest;
    end
    plot(ax1, nns, accuracies);

    scales = [100,200,300,500,700,900,1000];

    numOfScales = length(scales);
    accuracies = ones(1,numOfScales);
    numOfDataCol = size(predictor,2);
    for i = 1:numOfScales
        scale = scales(i);
        randomIndexes = randi(length(predictor),1,scale);
        randomIndexes = sort(randomIndexes);
        data = ones(scale,numOfDataCol);
        correct = ones(scale, 1);
        for j = 1:scale
            data(j,:) = predictor(randomIndexes(j),:);
            correct(j) = classification(randomIndexes(j));
        end
        mdl =fitcknn(data, correct);
        mdl.NumNeighbors = 3;
        result = predict(mdl,testData)
        accuracies(i) = sum(result == testClassify) / numOfTest;
    end
    plot(ax2, scales, accuracies);
end



