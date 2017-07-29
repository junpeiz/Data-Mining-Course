function [w, iter] = perceptron(X, y)
%PERCEPTRON Perceptron Learning Algorithm.
%
%   INPUT:  X: training sample features, P-by-N matrix.
%           y: training sample labels, 1-by-N row vector.
%
%   OUTPUT: w:    learned perceptron parameters, (P+1)-by-1 column vector.
%           iter: number of iterations
%

% YOUR CODE HERE
step_size = 0.01;
[P,N] = size(X);
w = rand(P+1, 1);
X = [ones(1,N);X];
iter = 0;
while 1
    has_err = 0;
    y_temp = sign(((w')*X).*y);
    delta_w = zeros(P+1, 1);
    for i = 1:N
        if(y_temp(1,i) < 0)
            has_err = 1;
            delta_w = delta_w + X(:,i)*y(1,i);
        end
    end
    if(has_err == 0)
        break;
    end
    w = w+step_size*delta_w;
    iter = iter+1;

    % The online method
    % for i = 1:N
    %     x_it = X(:, i);
    %     if(w * x_it * y(1,i) < 0)
    %         w = w + x_it*y(1,i);
    %         has_err = 1;
    %     end
    % end
end
