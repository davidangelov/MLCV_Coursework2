clc; clear; close all;

% init;

% Select and load dataset
[data_train, data_test] = getData('Toy_Spiral');

figure(1) % plot training data
plot_toydata(data_train);
title('Training data');

% class_type = unique(data_train(:,3));

data_train_data = data_train(:,1:2);
data_class = data_train(:,3);

%% One-v-rest M = 3

data_class_1 = ones(length(data_class), 1);
data_class_2 = ones(length(data_class), 1);
data_class_3 = ones(length(data_class), 1);

data_class_1(data_class ~= 1) = -1;
data_class_2(data_class ~= 2) = -1;
data_class_3(data_class ~= 3) = -1;

C = 1; % max of C
SVM1 = fitcsvm(data_train_data, data_class_1,'KernelFunction', 'rbf','BoxConstraint',C);
SVM2 = fitcsvm(data_train_data, data_class_2,'KernelFunction', 'rbf','BoxConstraint',C);
SVM3 = fitcsvm(data_train_data, data_class_3,'KernelFunction', 'rbf','BoxConstraint',C);
% 
% C = 20; % polynomial order
% SVM1 = fitcsvm(data_train_data, data_class_1,'KernelFunction', 'polynomial','PolynomialOrder',C);
% SVM2 = fitcsvm(data_train_data, data_class_2,'KernelFunction', 'polynomial','PolynomialOrder',C);
% SVM3 = fitcsvm(data_train_data, data_class_3,'KernelFunction', 'polynomial','PolynomialOrder',C);

[predict_label_1, score1] = predict(SVM1,data_test(:,1:2));
[predict_label_2, score2] = predict(SVM2,data_test(:,1:2));
[predict_label_3, score3] = predict(SVM3,data_test(:,1:2));

score1_norm = (score1(:,1) - min(score1(:,1)))./(max(score1(:,1)) - min(score1(:,1)));
score2_norm = (score2(:,1) - min(score2(:,1)))./(max(score2(:,1)) - min(score2(:,1)));
score3_norm = (score3(:,1) - min(score3(:,1)))./(max(score3(:,1)) - min(score3(:,1)));

score = [score1_norm, score2_norm, score3_norm];
[~, predict_label] = max(score,[],2);

figure(2) % M=3 SVM
gscatter(data_test(:,1), data_test(:,2), predict_label, 'brg');
axis([-1.5,1.5,-1.5,1.5]);
