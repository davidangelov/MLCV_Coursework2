% M-SVM 1 vs Rest function

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input
% data_train = [dim_train x (K+1)], last column is label
% data_test = [dim_test x (K+1)]
% M = number of classes
% kernel = kerner function type

% Output
% predict_label = [dim_test x 1]
%                 predicted label for each row of testing data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function predict_label = fMSVM_1vR(data_train, data_test, kernel, C, sigma)

score = [];
M = length(unique(data_train(:,end)));
% num_supp_vectors = [];

for class = 1:M
        
% Re-organise label for 1 vs Rest
data_class = ones(numel(data_train(:,end)),1);
data_class(data_train(:,end) ~= class) = -1;

    switch kernel
    case 'RBF'
    SVM = fitcsvm(data_train(:,1:end-1), data_class,...
                'KernelFunction', 'rbf',...
                'BoxConstraint',C,...
                'KernelScale', sigma,...
                'ClassNames',[-1,1]);

    case 'Poly'
    SVM = fitcsvm(data_train(:,1:end-1), data_class,...
                'KernelFunction', 'polynomial',...
                'BoxConstraint', 1, ...
                'KernelScale', sigma, ...
                'PolynomialOrder',C, ...
                'ClassNames',[-1,1]);
    end
    
%   num_supp_vectors = [num_supp_vectors, length(SVM.SupportVectors)];

% test SVM
[~, score_one] = predict(SVM,data_test(:,1:(end-1)));
score_one_norm = score_one(:,2);

% score_one_norm = (score_one_norm - min(score_one_norm))/(max(score_one_norm) - min(score_one_norm));
score_one_norm = 1./(1 + exp(-score_one_norm));

score = [score, score_one_norm];

end

[~, predict_label] = max(score,[],2);

display('1 vs Rest SVM training and testing completed');

end
