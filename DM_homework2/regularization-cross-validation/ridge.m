function w = ridge(X, y, lambda)
%RIDGE Ridge Regression.
%
%   INPUT:  X: training sample features, P-by-N matrix.
%           y: training sample labels, 1-by-N row vector.
%           lambda: regularization parameter.
%
%   OUTPUT: w: learned parameters, (P+1)-by-1 column vector.
%

% YOUR CODE HERE
X = [ones(1,size(X,2));X];
% Because lambda=0 will lead to singular matrix, so use gradient descent
% if(lambda < 1e-10)
%     step_size = 0.1;
%     w = rand(size(X,1),1);
%     delta_w = zeros(size(X,1),1);
%     for iter = 1:100
%         true_step = step_size*(1.0/iter);
%         w = (1-2*true_step*X*X')*w + 2*true_step*X*y';
%     end
% else
%     w = inv(X*X'+lambda*eye(size(X,1)))*X*y';
% end
w = inv(X*X'+lambda*eye(size(X,1)))*X*y';
end
