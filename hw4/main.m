itemNums = [5 10 15 20 30 50];
atomNums = [16 25 36 49 64 81];

accuracy = zeros(1,length(itemNums));
for i = 1:length(itemNums)
    accuracy(i) = getAccuracy(itemNums(i),64,x_train, y_train,x_test,y_test);
end

figure;
plot(itemNums, accuracy);
title('迭代次数和精确度的关系');
xlabel('迭代次数');
ylabel('accuracy');


accuracy = zeros(1,length(atomNums));
for i = 1:length(atomNums)
    accuracy(i) = getAccuracy(10,atomNums(i),x_train, y_train,x_test,y_test);
end

figure;
plot(atomNums, accuracy);
title('字典元素数量和精确度的关系');
xlabel('字典元素数量');
ylabel('accuracy');