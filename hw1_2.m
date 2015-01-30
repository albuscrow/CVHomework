function output = hw1_2(predictor, classification)


    currencies = zeros(1,10);

    idx = kmeans(predictor, 10);
    %load idx;
%     beginIndex = 1;
    for j = 1000:1000:10000
        table=tabulate(idx(j - 999:j));
        [currencies(j / 1000),I] = max(table(:,3));
        max(table(I,1))
%         result=table(I(1),1);
%         currencies(j / 1000) = sum(idx(j - 999:j) == result)/1000;
       % [idx(beginIndex:endIndex),correct(beginIndex:endIndex)]
    end
    
    plot(0:9,currencies);
end