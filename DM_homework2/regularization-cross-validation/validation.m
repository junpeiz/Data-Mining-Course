%% Ridge Regression
load('digit_train', 'X', 'y');

% Do feature normalization
train_mean = mean(X, 2);
train_var = sqrt(var(X, 0, 2));
for i = 1:size(X,1)
    for j = 1:size(X,2)
        if(abs(train_var(i))>0.00001)
            X(i,j) = (X(i,j)-train_mean(i))*1.0/train_var(i);
        else
            X(i,j) = 0.0;
        end
    end
end
% Do LOOCV
lambdas = [1e-6, 1e-3, 1e-2, 1e-1, 1, 1e1, 1e2, 1e3]; 
lambda = 0;

min_e_val = 10000;
for i = 1:length(lambdas)
    E_val = 0;
    Loss = 0.0;
    for j = 1:size(X, 2)
        X_ = X; X_(:,j) = []; % take point j out of X
        y_ = y; y_(:,j) = []; % take label j out of y
        w = ridge(X_, y_, lambdas(i));
        E_val = E_val + (sign(w'*[1;X(:,j)])~=y(1,j));
        X_ = [ones(1,size(X_,2));X_];
        Loss = Loss + (y_'-X_'*w)'*(y_'-X_'*w) + lambdas(i)*(w'*w);
    end
    Loss = Loss/size(X, 2);
    E_val = E_val*1.0/size(X, 2);
    fprintf('When labmda = %f  Error rate = %f  Loss = %f\n', lambdas(i), E_val, Loss);
    % Update lambda according validation error
    if(E_val < min_e_val)
        min_e_val = E_val;
        lambda = lambdas(i);
    end
end
% Because 0 will lead to sigular, I replace 0 by 1e-12
w_0 = ridge(X, y, 1e-12);
fprintf('Without regularization, the sum of omega square is %f.\n', w_0'*w_0);
fprintf('The best labmda is %f.\n', lambda);
w = ridge(X, y, lambda);
fprintf('With regularization, the sum of omega square is %f.\n', w'*w);

% Compute training error
y_predict = sign((w_0')*[ones(1,size(X,2));X]);
train_error = sum(y_predict~=y)*1.0/size(y,2);
fprintf('Without regularization, the train error is %f.\n', train_error);
y_predict = sign((w')*[ones(1,size(X,2));X]);
train_error = sum(y_predict~=y)*1.0/size(y,2);
fprintf('With regularization, the train error is %f.\n', train_error);

load('digit_test', 'X_test', 'y_test');
% Do feature normalization
for i = 1:size(X_test,1)
    for j = 1:size(X_test,2)
        if(abs(train_var(i))>0.00001)
            X_test(i,j) = (X_test(i,j)-train_mean(i))*1.0/train_var(i);
        else
            X_test(i,j) = 0.0;
        end
    end
end
% Compute test error
y_predict = sign((w_0')*[ones(1,size(X_test,2));X_test]);
test_error = sum(y_predict~=y_test)*1.0/size(y_test,2);
fprintf('Without regularization, the test error is %f.\n', test_error);
y_predict = sign((w')*[ones(1,size(X_test,2));X_test]);
test_error = sum(y_predict~=y_test)*1.0/size(y_test,2);
fprintf('With regularization, the test error is %f.\n', test_error);

%% Logistic
lambdas = [1e-6, 1e-3, 1e-2, 1e-1, 1, 1e1, 1e2, 1e3]; 
lambda = 0;
min_e_val = 10000;
for i = 1:length(lambdas)
    E_val = 0;
    for j = 1:size(X, 2)
        X_ = X; X_(:,j) = []; % take point j out of X
        y_ = y; y_(:,j) = []; % take label j out of y
        w = logistic_r(X_, y_, lambdas(i));
        E_val = E_val + (sign(1.0./(1.0+exp(-(w')*[1;X(:,j)]))-0.5)~=y(1,j));
    end
    E_val = E_val*1.0/size(X, 2);
    fprintf('When labmda = %f  Error rate = %f ', lambdas(i), E_val);
    % Update lambda according validation error
    if(E_val < min_e_val)
        min_e_val = E_val;
        lambda = lambdas(i);
    end
end
% Without regularization
w_0 = logistic_r(X, y, 0);
fprintf('Without regularization, the sum of omega square is %f.\n', w_0'*w_0);
fprintf('The best labmda is %f.\n', lambda);
w = logistic_r(X, y, lambda);
fprintf('With regularization, the sum of omega square is %f.\n', w'*w);

% Compute training error
y_predict = sign(1.0./(1.0+exp(-(w_0')*[ones(1,size(X,2));X]))-0.5);
train_error = sum(y_predict~=y)*1.0/size(y,2);
fprintf('Without regularization, the train error is %f.\n', train_error);
y_predict = sign(1.0./(1.0+exp(-(w')*[ones(1,size(X,2));X]))-0.5);
train_error = sum(y_predict~=y)*1.0/size(y,2);
fprintf('With regularization, the train error is %f.\n', train_error);

% Compute test error
y_predict = sign(1.0./(1.0+exp(-(w_0')*[ones(1,size(X_test,2));X_test]))-0.5);
test_error = sum(y_predict~=y_test)*1.0/size(y_test,2);
fprintf('Without regularization, the test error is %f.\n', test_error);
y_predict = sign(1.0./(1.0+exp(-(w')*[ones(1,size(X_test,2));X_test]))-0.5);
test_error = sum(y_predict~=y_test)*1.0/size(y_test,2);
fprintf('With regularization, the test error is %f.\n', test_error);

%% SVM with slack variable
