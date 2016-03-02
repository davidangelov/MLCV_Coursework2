% test 2

clc;clear;close all;

% x = [1 2 3 4 5];
% x = x.';
% y = [2 2 2 2 2];
% y = y.';

% group = ['a', 'a', 'c', 'b', 'c'].';
% 
% gscatter(x,y,group);

[data_train, data_test] = getData('Toy_Spiral');

% num_class = unique(data_train(:,3));