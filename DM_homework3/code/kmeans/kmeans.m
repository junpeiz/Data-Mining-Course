function [idx, ctrs, iter_ctrs] = kmeans(X, K)
%KMEANS K-Means clustering algorithm
%
%   Input: X - data point features, n-by-p maxtirx.
%          K - the number of clusters
%
%   OUTPUT: idx  - cluster label
%           ctrs - cluster centers, K-by-p matrix.
%           iter_ctrs - cluster centers of each iteration, K-by-p-by-iter
%                       3D matrix.

% YOUR CODE HERE
[data_num, feature_num] = size(X);
center = X(randsample(data_num, K), :);
last_center = center + 1;
threshold = 0.01;
it_num = 1;
while(norm(center - last_center) > threshold)
    iter_ctrs(:,:,it_num) = center;
    it_num = it_num+1;
    last_center = center;
    Dist_m = EuDist2(center, X);
    % I is a 1-by-n vector stored the minimum index (1 to K) of each data point
    [M, I] = min(Dist_m);
    for k = 1:K
        data_collect = find(I==k);
        center(k,:) = mean(X(data_collect,:));
    end
end
iter_ctrs(:,:,it_num) = center;
idx = I;
ctrs = center;

end
