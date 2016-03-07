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

class = unique(data_train(:,end));
M = length(class);
num_svm = M*(M-1)/2;
vote = [];

    for id_svm = 1:num_svm
        
        data_class = 
        
        C = 1;
        SVM = fitcsvm(data_train(:,1:end-1), data_class,...
                'KernelFunction', 'rbf','BoxConstraint',C,'KernelScale',K,'auto',...
                'ClassNames',[2,1]);
        vote_one = predict(SVM, data_test(index, 1:end-1));
        vote = [vote, vote_one];
        
    end

[predict_label, vote_freq] = mode(vote, 2);
predict_label(vote_freq == 1) = 0;
data_test(:,end) = predict_label;

end
