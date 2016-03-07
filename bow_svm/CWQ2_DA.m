clc; clear; close all;

% init;

% Select and load dataset
[data_train, data_test] = getData('Toy_Spiral');

figure(1) % plot training data
plot_toydata(data_train);
legend('Class 1','Class 2', 'Class 3');
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

C = Inf; % max of C
Kernel_Scale = 0.6;
SVM1 = fitcsvm(data_train_data, data_class_1,...
    'KernelFunction', 'rbf','BoxConstraint',C,'KernelScale',Kernel_Scale,...
    'ClassNames',[-1,1]);

SVM2 = fitcsvm(data_train_data, data_class_2,...
    'KernelFunction', 'rbf','BoxConstraint',C,'KernelScale',Kernel_Scale,...
    'ClassNames',[-1,1]);

SVM3 = fitcsvm(data_train_data, data_class_3,...
    'KernelFunction', 'rbf','BoxConstraint',C,'KernelScale',Kernel_Scale,...
    'ClassNames',[-1,1]);
% 
% C = 20; % polynomial order
% SVM1 = fitcsvm(data_train_data, data_class_1,'KernelFunction', 'polynomial','PolynomialOrder',C);
% SVM2 = fitcsvm(data_train_data, data_class_2,'KernelFunction', 'polynomial','PolynomialOrder',C);
% SVM3 = fitcsvm(data_train_data, data_class_3,'KernelFunction', 'polynomial','PolynomialOrder',C);

num_supp_vec1 = length(SVM1.SupportVectors);
num_supp_vec2 = length(SVM2.SupportVectors);
num_supp_vec3 = length(SVM3.SupportVectors);

[predict_label_1, score1] = predict(SVM1,data_test(:,1:2));
[predict_label_2, score2] = predict(SVM2,data_test(:,1:2));
[predict_label_3, score3] = predict(SVM3,data_test(:,1:2));

score1 = (score1(:,2) - min(score1(:,2)))./(max(score1(:,2)) - min(score1(:,2)));
score2 = (score2(:,2) - min(score2(:,2)))./(max(score2(:,2)) - min(score2(:,2)));
score3 = (score3(:,2) - min(score3(:,2)))./(max(score3(:,2)) - min(score3(:,2)));

score = [score1, score2, score3];
[~, predict_label] = max(score,[],2);
data_test(:,end) = predict_label;

figure(2) % M=3 SVM
plot_toydata(data_test);
legend('Class 1','Class 2', 'Class 3');
