clc; clear; close all;

% init;

% Select and load dataset
[data_train, data_test] = getData('Toy_Spiral');

%% 

figure % plot training data
plot_toydata(data_train);
title('Training data');

% figure % plot testing data
% scatter(data_zxtest(:,1),data_test(:,2),'.b');

%%