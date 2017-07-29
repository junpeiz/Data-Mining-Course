function y = knn(X, X_train, y_train, K)
%KNN k-Nearest Neighbors Algorithm.
%
%   INPUT:  X:         testing sample features, P-by-N_test matrix.
%           X_train:   training sample features, P-by-N matrix.
%           y_train:   training sample labels, 1-by-N row vector.
%           K:         the k in k-Nearest Neighbors
%
%   OUTPUT: y    : predicted labels, 1-by-N_test row vector.
%

% YOUR CODE HERE
N_ = size(X,2);
[P, N] = size(X_train);
y = zeros(1,N_);
% Get the whole number of classes
class_num = length(unique(y_train));
% Get a distance matrix of size N x N_
Dist_m = EuDist2(X_train', X');
for i = 1:N_
    Dist = Dist_m(:,i);
    [sort_value, sort_index] = sort(Dist, 'ascend');
    top_k_index = sort_index(1:K);
    vote_map = repmat([0], 1, class_num);
    for j = 1:K
        label_temp = y_train(1, top_k_index(j));
        vote_map(label_temp + 1) = vote_map(label_temp + 1) + 1;
    end
    [temp, max_index] = max(vote_map);
    y(1,i) = max_index-1;
end

end

