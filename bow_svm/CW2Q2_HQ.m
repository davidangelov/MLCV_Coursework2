clc; clear; close all;

%% Data
% Select and load dataset
[data_train, data_test] = getData('Toy_Spiral');

figure(1) % plot training data
plot_toydata(data_train);
legend('Class 1','Class 2', 'Class 3');
title('Training data');

%% SVM
close all;

kernel = 'RBF';
C = Inf;
sigma = 0.8;
mode = 'ovr';

switch mode
    case 'ovr'
    predict_label = fMSVM_1vR(data_train, data_test, kernel, C, sigma);
    
    case 'ovo'
    predict_label = fMSVM_1v1(data_train, data_test,kernel, C, sigma);

end

data_test(:,end) = predict_label;
    
figure(2) % M=3 SVM
plot_toydata(data_test);
legend('Class 1','Class 2', 'Class 3');
