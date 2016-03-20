clc; clear; close all;

init;

rate = zeros(1,20);

parfor idxK = 1:20
    
k = 5*(idxK-1) + 1;

[data_train, data_test] = getData_HQ('Caltech', k);

%% SVM
kernel = 'RBF';
C = 2^15;
sigma = 2^15;
mode = 'ovr';

switch mode
    case 'ovr'
        predict_label = fMSVM_1vR(data_train, data_test, kernel, C, sigma);
    case 'ovo'
        predict_label = fMSVM_1v1(data_train, data_test, kernel, C, sigma);
end

rate(idxK) = length(find(predict_label == data_test(:,end)))/length(data_test(:,end));
end

%%
figure(1)
x = 5*((1:20)-1) + 1;
plot(x,rate)
ylim([0 1])
grid on
xlabel('Number of K'), ylabel('Correction rate');





