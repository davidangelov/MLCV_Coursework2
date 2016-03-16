clc; clear; close all;

init;

[data_train, data_test] = getData_HQ('Caltech', 100);

%% 
mode = 1; % 1 for 1vsRest, 2 for 1vs1
switch mode
    case 1
        predict_label = fMSVM_1vR(data_train, data_test);
    case 2
        predict_label = fMSVM_1v1(data_train, data_test);
end

correct_rate = length(find(predict_label == data_test(:,end)))/length(data_test(:,end));
display(correct_rate, 'Correction rate');

%% Confusion matrix

conf_mat = confusionmat(predict_label, data_test(:,end));
imagesc(conf_mat); colorbar;
xlabel('Target class'), ylabel('Predicted class');

% target = zeros(10,150);
% output = zeros(10,150);
% 
% for i = 1:150
%     
%     target(data_test(i,end), i) = 1;
%     output(predict_label(i,end), i) = 1;
%     
% end
% 
% plotconfusion(target, output);
