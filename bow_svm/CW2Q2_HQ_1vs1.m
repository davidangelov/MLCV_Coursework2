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

C = Inf;
Kernel_Scale = 0.6;

SVM12 = fitcsvm(data_train_12(:,1:end-1), data_train_12(:,end),...
        'KernelFunction', 'rbf','BoxConstraint',C,'KernelScale',Kernel_Scale,...
        'ClassNames',[2,1]);
    
SVM23 = fitcsvm(data_train_23(:,1:end-1), data_train_23(:,end),...
        'KernelFunction', 'rbf','BoxConstraint',C,'KernelScale',Kernel_Scale,...
        'ClassNames',[3,2]);
    
SVM13 = fitcsvm(data_train_13(:,1:end-1), data_train_13(:,end),...
        'KernelFunction', 'rbf','BoxConstraint',C,'KernelScale',Kernel_Scale,...
        'ClassNames',[3,1]);

vote_12 = predict(SVM12,data_test(:,1:end-1));
vote_23 = predict(SVM23,data_test(:,1:end-1));
vote_13 = predict(SVM13,data_test(:,1:end-1));

vote = [vote_12, vote_23, vote_13];

[predict_label, vote_freq] = mode(vote, 2);
predict_label(vote_freq == 1) = 0;
data_test(:,end) = predict_label;

figure(2)
plot_toydata(data_test);
