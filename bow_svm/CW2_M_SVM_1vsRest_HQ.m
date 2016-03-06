clc; clear; close all;

% Select and load dataset
[data_train, data_test] = getData('Toy_Spiral');

figure(1) % plot training data
plot_toydata(data_train);
legend('Class 1','Class 2', 'Class 3');
title('Training data');

%% One-v-rest (M classes)
M = 3;
score = [];
num_supp_vectors = [];

for class = 1:M
    
    % Re-organise label for 1 vs Rest
    data_class = ones(numel(data_train(:,end)),1);
    data_class(data_train(:,end) ~= class) = -1;
    
    % Train SVMs
    C = Inf; % max of C
    Kernel_Scale = 0.6;
    SVM = fitcsvm(data_train(:,1:end-1), data_class,...
            'KernelFunction', 'rbf','BoxConstraint',C,'KernelScale',Kernel_Scale,...
            'ClassNames',[-1,1]);
    num_supp_vectors = [num_supp_vectors, length(SVM.SupportVectors)];
    
    % test SVM
    [~, score_one] = predict(SVM,data_test(:,1:(end-1)));
    score_one_norm = (score_one(:,2) - min(score_one(:,2)))./(max(score_one(:,2)) - min(score_one(:,2)));
    score = [score, score_one_norm];
    
    clearvars SVM;
end
% C = 20; % polynomial order
% SVM1 = fitcsvm(data_train_data, data_class_1,'KernelFunction', 'polynomial','PolynomialOrder',C);

[~, predict_label] = max(score,[],2);
data_test(:,end) = predict_label;

figure(2) % M=3 SVM
plot_toydata(data_test);
legend('Class 1','Class 2', 'Class 3');
