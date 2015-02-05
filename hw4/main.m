itemNums = [5 10 15 20 30 50];
atomNums = [16 25 36 49 64 81];

accuracy = zeros(1,length(itemNums));
for i = 1:length(itemNums)
    accuracy(i) = getAccuracy(itemNums(i),64,x_train, y_train,x_test,y_test);
end

figure;
plot(itemNums, accuracy);
title('���������;�ȷ�ȵĹ�ϵ');
xlabel('��������');
ylabel('accuracy');


accuracy = zeros(1,length(atomNums));
for i = 1:length(atomNums)
    accuracy(i) = getAccuracy(10,atomNums(i),x_train, y_train,x_test,y_test);
end

figure;
plot(atomNums, accuracy);
title('�ֵ�Ԫ�������;�ȷ�ȵĹ�ϵ');
xlabel('�ֵ�Ԫ������');
ylabel('accuracy');