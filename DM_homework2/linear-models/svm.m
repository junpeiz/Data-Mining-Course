function [w, num] = svm(X, y)
%SVM Support vector machine.
%
%   INPUT:  X: training sample features, P-by-N matrix.
%           y: training sample labels, 1-by-N row vector.
%
%   OUTPUT: w:    learned perceptron parameters, (P+1)-by-1 column vector.
%           num:  number of support vectors
%

% YOUR CODE HERE
X = [ones(1,size(X,2));X];
% Rewrite the constrains as w'*(-xi*yi) <= -1
w = quadprog(eye(3), [], -diag(y)*(X'), -ones(size(y,2),1));
temp_res = (w')*X.*y;
num = sum((temp_res-1) < 0.01);
end
