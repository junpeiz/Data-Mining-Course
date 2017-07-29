function idx = spectral(W, k)
%SPECTRUAL spectral clustering
%   Input:
%     W: Adjacency matrix, N-by-N matrix
%     k: number of clusters
%   Output:
%     idx: data point cluster labels, n-by-1 vector.

% YOUR CODE HERE
N = size(W,1);
D = diag(sum(W,2));
% Prevent the singular matrix error in the spectral_exp2
% D = D + eye(N)*0.001;
% get the eigen vector corresponding to the least k vectors
[eig_vector, eig_value] = eigs(D-W, D, k, 'sm');
idx = kmeans(eig_vector, k);
end
