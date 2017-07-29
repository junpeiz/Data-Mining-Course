function W = knn_graph(X, k, threshold)
%KNN_GRAPH Construct W using KNN graph
%   Input: X - data point features, n-by-p maxtirx.
%          k - number of nn.
%          threshold - distance threshold.
%
%   Output:W - adjacency matrix, n-by-n matrix.

% YOUR CODE HERE
W = EuDist2(X);
[n p] = size(X);
W = W + diag(diag(ones(n).*10000));
copy_W = W;
temp_thre_index = W>threshold;
for i = 1:n
    temp = copy_W(i,:);
    % get the index of smallest k value
    [temp_sorted temp_idx] = sort(temp);
    temp_idx = temp_idx(1:k);
    W(temp_idx,i) = 1;
    W(i,temp_idx) = 1;
end
W(temp_thre_index) = 0;
W(W ~= 1) = 0;