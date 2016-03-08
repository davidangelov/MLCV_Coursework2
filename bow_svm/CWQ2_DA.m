clc; clear; close all;

% Select and load dataset
[data_train, data_test] = getData('Toy_Spiral');

figure(1) % plot training data
plot_toydata(data_train);
title('Training data');

%% One-v-one M = 3
predict_label = fMSVM_1v1(data_train, data_test);

%%
data_test(:,end) = predict_label;

figure(2)
plot_toydata(data_test);
