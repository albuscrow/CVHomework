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
    title('������д���ֵľ��ྫȷ��');
    xlabel('����');
    ylabel('accuracy');
end