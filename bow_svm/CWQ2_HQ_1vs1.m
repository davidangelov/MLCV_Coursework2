clc; clear; close all;

% Select and load dataset
[data_train, data_test] = getData('Toy_Spiral');

figure(1) % plot training data
plot_toydata(data_train);
title('Training data');

% class_type = unique(data_train(:,3));

data_train_data = data_train(:,1:2);
data_class = data_train(:,3);

class_type = unique(data_train(:,3));

%% One-v-one M = 3

data_train_12 = data_train((data_class == class_type(1) | data_class == class_type(2)), :);
data_train_23 = data_train((data_class == class_type(2) | data_class == class_type(3)), :);
data_train_13 = data_train((data_class == class_type(1) | data_class == class_type(3)), :);

SVM12 = fitcsvm(data_train_12(:,1:end-1), data_train12(:,end));
SVM23 = fitcsvm(data_train_23(:,1:end-1), data_train23(:,end));
SVM13 = fitcsvm(data_train_13(:,1:end-1), data_train13(:,end));

[predict_label_1, score1] = predict(SVM1,data_test(:,1:2));
[predict_label_2, score2] = predict(SVM2,data_test(:,1:2));
[predict_label_3, score3] = predict(SVM3,data_test(:,1:2));


