clc; clear; close all;

init;

%% Data
[data_train, data_test] = getData_HQ('Caltech', 100);

%% SVM
kernel = 'RBF';
C = Inf;
sigma = 100000;
mode = 'ovr';

switch mode
    case 'ovr'
        predict_label = fMSVM_1vR(data_train, data_test, kernel, C, sigma);
    case 'ovo'
        predict_label = fMSVM_1v1(data_train, data_test, kernel, C, sigma);
end

correct_rate = length(find(predict_label == data_test(:,end)))/length(data_test(:,end));
display(correct_rate, 'Correction rate');

%% Confusion matrix

figure(1)
conf_mat = confusionmat(predict_label, data_test(:,end));
imagesc(conf_mat); colorbar;
xlabel('Target class'), ylabel('Predicted class');
