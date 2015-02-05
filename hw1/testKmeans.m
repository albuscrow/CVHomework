function testKmeans(trainData)
    trainData = trainData';
    currencies = zeros(1,10);
    idx = kmeans(trainData, 10);
    for j = 1000:1000:10000
        table=tabulate(idx(j - 999:j));
        [currencies(j / 1000),I] = max(table(:,3));
        max(table(I,1));
    end
    
    figure;
    plot(0:9,currencies);
    title('各个手写数字的聚类精确度');
    xlabel('数字');
    ylabel('accuracy');
end