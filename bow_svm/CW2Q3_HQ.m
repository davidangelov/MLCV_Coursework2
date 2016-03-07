clc; clear; close all;

init;

[data_train, data_test] = getData_HQ('Caltech', 100);

%% 
predict_label = fMSVM_1vR(data_train, data_test);

correct_rate = length(find(predict_label == data_test(:,end)))/length(data_test(:,end));
display(correct_rate, 'Correction rate');