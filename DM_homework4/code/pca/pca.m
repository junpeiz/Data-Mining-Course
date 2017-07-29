function [eigvector, eigvalue] = PCA(data)
%PCA	Principal Component Analysis
%
%             Input:
%               data       - Data matrix. Each row vector of fea is a data point.
%
%             Output:
%               eigvector - Each column is an embedding function, for a new
%                           data point (row vector) x,  y = x*eigvector
%                           will be the embedding result of x.
%               eigvalue  - The sorted eigvalue of PCA eigen-problem.
%

% YOUR CODE HERE
% preprocess the data to extract the mean
[n, p] = size(data);
data = data - repmat(mean(data),n,1);
% set the threshold
threshold = 0.001;
C = cov(data);
[eigvector, eigvalue] = eig(C);
% Convert the eigvector and eigvalue to the descend order
[eigvalue, I]=sort(diag(eigvalue), 'descend');
eigvector=eigvector(:,I);
thre_index = abs(eigvalue) > threshold;
eigvalue = eigvalue(thre_index);
eigvector = eigvector(:,thre_index);
eigvalue = diag(eigvalue);
end