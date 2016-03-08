% M-SVM 1 vs 1 function

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input
% data_train = [dim_train x (K+1)], last column is label
% data_test = [dim_test x (K+1)]
% M = number of classes

% Output
% predict_label = [dim_test x 1]
%                 predicted label for each row of testing data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function predict_label = fMSVM_1v1(data_train, data_test)

data_class = data_train(:,end);

class_type = unique(data_train(:,end));
M = length(class_type);
%num_svm = M*(M-1)/2;
vote = [];
C = Inf;
Kernel_Scale = 'auto';

for id_svm_i = 1 : M - 1
    for id_svm_j = id_svm_i + 1 : M
        data_train_svm = data_train((data_class == class_type(id_svm_i) | data_class == class_type(id_svm_j)), :);
        
        SVM = fitcsvm(data_train_svm(:,1:end-1), data_train_svm(:,end),...
        'KernelFunction', 'rbf','BoxConstraint',C,'KernelScale',Kernel_Scale,...
        'ClassNames',[id_svm_j,id_svm_i]);
        
        vote_svm = predict(SVM,data_test(:,1:end-1));
        vote = [vote, vote_svm];
    end
end

[predict_label, vote_freq, values_with_freq] = mode(vote, 2);

for i = 1:length(values_with_freq)
    if length(cell2mat(values_with_freq(i,1))) ~= 1
        predict_label(i,1) = 0;
    end
end

end
