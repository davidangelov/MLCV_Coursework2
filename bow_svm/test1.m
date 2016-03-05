% Example fitcsvm

clc;clear;close all

% load fisheriris
% inds = ~strcmp(species,'setosa');
% X = meas(inds,3:4);
% y = species(inds);
% 
% SVMModel = fitcsvm(X,y);
% 
% sv = SVMModel.SupportVectors;
% 
% figure
% gscatter(X(:,1),X(:,2),y)
% hold on
% plot(sv(:,1),sv(:,2),'ko','MarkerSize',10)
% legend('versicolor','virginica','Support Vector')
% hold off

% Select and load dataset
[data_train, data_test] = getData('Toy_Spiral');

figure % plot training data
plot_toydata(data_train);
title('Training data');

class_index = find(data_train(:,3) == 1 | data_train(:,3) == 2);
SVM12 = fitcsvm(data_train(class_index,1:2), data_train(class_index,3));

figure
gscatter(data_train(class_index,1),data_train(class_index,2),data_train(class_index,3));
