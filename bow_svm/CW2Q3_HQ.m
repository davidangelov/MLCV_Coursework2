clc; clear; close all;

init;
<<<<<<< HEAD
parfor k = 1:100
[data_train, data_test] = getData_HQ('Caltech', k);
=======

%% Data
<<<<<<< Updated upstream
[data_train, data_test] = getData_HQ('Caltech', 100);
>>>>>>> origin/master
=======
tic;
K = 50;
[data_train, data_test] = getData_HQ('Caltech', K);
toc;
>>>>>>> Stashed changes

%% SVM
tic;
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
end
%% Confusion matrix
plot(correct_rate_array);

figure(1)
conf_mat = confusionmat(predict_label, data_test(:,end));
imagesc(conf_mat); colorbar;
xlabel('Target class'), ylabel('Predicted class');
