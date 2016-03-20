clc; clear; close all;

init;
k = 50;
[data_train, data_test] = getData_HQ('Caltech', k);

%% SVM
kernel = 'RBF';
C = 1000;
sigma = 10000;
mode = 'ovr';

switch mode
    case 'ovr'
        predict_label = fMSVM_1vR(data_train, data_test, kernel, C, sigma);
    case 'ovo'
        predict_label = fMSVM_1v1(data_train, data_test, kernel, C, sigma);
end

correct_rate = length(find(predict_label == data_test(:,end)))/length(data_test(:,end));
display(correct_rate, 'Correction rate');
correct_rate_array(k) = correct_rate;

%% Confusion matrix
plot(correct_rate_array);

figure(1)
conf_mat = confusionmat(predict_label, data_test(:,end));
imagesc(conf_mat); colorbar;
xlabel('Target class'), ylabel('Predicted class');
