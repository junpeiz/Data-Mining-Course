function w = logistic_r(X, y, lambda)
%LR Logistic Regression.
%
%   INPUT:  X:   training sample features, P-by-N matrix.
%           y:   training sample labels, 1-by-N row vector.
%           lambda: regularization parameter.
%
%   OUTPUT: w    : learned parameters, (P+1)-by-1 column vector.
%

% YOUR CODE HERE
X = [ones(1,size(X,2));X];
step_size = 0.1;
w = rand(size(X,1),1);
delta_w = zeros(size(X,1),1);
for iter = 1:100
    for i = 1:size(X,2)
        delta_w = delta_w + y(1,i)*X(:,i)*1.0/(1.0+exp(y(1,i).*(w')*X(:,i)));
    end
    w = (1-2.0*step_size*lambda)*w + step_size*(1.0/iter)*delta_w;
end

end
