clc; clear; close all;

% Select and load dataset
[data_train, data_test] = getData('Toy_Spiral');

figure(1) % plot training data
plot_toydata(data_train);
legend('Class 1','Class 2', 'Class 3');
title('Training data');

predict_label = fMSVM_1vR(data_train, data_test);

%predict_label = fMSVM_1v1(data_train, data_test);
data_test(:,end) = predict_label;

figure(2) % M=3 SVM
plot_toydata(data_test);
legend('Class 1','Class 2', 'Class 3');
