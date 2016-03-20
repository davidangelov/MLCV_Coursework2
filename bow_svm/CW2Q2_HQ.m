clc; clear; close all;

%% Data
% Select and load dataset
[data_train, data_test] = getData('Toy_Spiral');

figure(1) % plot training data
subplot(121)
plot_toydata(data_train);
legend('Class 1','Class 2', 'Class 3');
title('Training data');

subplot(122)
plot(data_test(:,1), data_test(:,2), 'ko');
xlim([-1.5, 1.5]), ylim([-1.5, 1.5]);
title('Testing data');

%% SVM

kernel = 'RBF';
C = Inf;
sigma = 1;
mode = 'ovr';

switch mode
    case 'ovr'
    predict_label = fMSVM_1vR(data_train, data_test, kernel, C, sigma);
    
    case 'ovo'
    predict_label = fMSVM_1v1(data_train, data_test,kernel, C, sigma);
end

data_test(:,end) = predict_label;

figure(2)
hold on
plot(data_test(data_test(:,end)==1,1), data_test(data_test(:,end)==1,2), 'o','MarkerEdgeColor', [.9 .5 .5], 'MarkerSize',1.3);
plot(data_test(data_test(:,end)==2,1), data_test(data_test(:,end)==2,2), 'o','MarkerEdgeColor', [.5 .9 .5], 'MarkerSize',1.3);
plot(data_test(data_test(:,end)==3,1), data_test(data_test(:,end)==3,2), 'o','MarkerEdgeColor', [.5 .5 .9], 'MarkerSize',1.3);
plot_toydata(data_train);
