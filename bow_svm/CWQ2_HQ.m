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

SVM1 = fitcsvm(data_train_data, data_class_1,'KernelFunction', 'rbf','BoxConstraint',Inf);
SVM2 = fitcsvm(data_train_data, data_class_2,'KernelFunction', 'rbf','BoxConstraint',Inf);
SVM3 = fitcsvm(data_train_data, data_class_3,'KernelFunction', 'rbf','BoxConstraint',Inf);

predict_label_1 = predict(SVM1,data_test(:,1:2));
predict_label_2 = predict(SVM2,data_test(:,1:2));
predict_label_3 = predict(SVM3,data_test(:,1:2));

figure(2)
gscatter(data_test(:,1), data_test(:,2), predict_label_1,'kr');
title('red');
axis([-1.5 1.5 -1.5 1.5]);

figure(3)
gscatter(data_test(:,1), data_test(:,2), predict_label_2,'kg');
title('green');
axis([-1.5 1.5 -1.5 1.5]);

figure(4)
gscatter(data_test(:,1), data_test(:,2), predict_label_3,'kb');
title('blue');
axis([-1.5 1.5 -1.5 1.5]);

