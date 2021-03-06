clc; clear; close all;

init;

[data_train, data_test] = getData_DA('Caltech', 100);

%% 
mode = 2; % 1 for 1vsRest, 2 for 1vs1
switch mode
    
    case 1
        predict_label = fMSVM_1vR(data_train, data_test);
    case 2
        predict_label = fMSVM_1v1(data_train, data_test);
end

correct_rate = length(find(predict_label == data_test(:,end)))/length(data_test(:,end));
display(correct_rate, 'Correction rate');