% CW2_Q3_PARFOR
clc; clear; close all;

init;

K = 50; % or whatever value you find is the best

%% Set paramters
C_range = 2.^(-20:5:20); % 9 of this
sigma_range = 2.^(5:5:40); % 8 of this
% 8*9*10*time_per_loop

kernel = 'RBF';
mode = 'ovo';

%% loopssssss

correct_rate_mean = zeros(length(C_range), length(sigma_range));

for idx_C = 1:length(C_range)
C = C_range(idx_C);
parfor idx_sigma = 1:length(sigma_range)
    
sigma = sigma_range(idx_sigma);

correct_rate = zeros(1,10);

for iter = 1:10
    
[data_train, data_test] = getData_HQ('Caltech', K);

switch mode
    case 'ovr'
        predict_label = fMSVM_1vR(data_train, data_test, kernel, C, sigma);
    case 'ovo'
        predict_label = fMSVM_1v1(data_train, data_test, kernel, C, sigma);
end
correct_rate(iter) = length(find(predict_label == data_test(:,end)))/length(data_test(:,end));

end %iteration

correct_rate_mean(idx_C, idx_sigma) = mean(correct_rate);

end %sigma
end %C


