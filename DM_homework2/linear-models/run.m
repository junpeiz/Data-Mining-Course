% You can use this skeleton or write your own.
% You are __STRONGLY__ suggest to run this script section-by-section using Ctrl+Enter.
% See http://www.mathworks.cn/cn/help/matlab/matlab_prog/run-sections-of-programs.html for more details.

%% Part1: Preceptron
nRep = 1000; % number of replicates
nTrain = 100; % number of training data
nTest = 10000; % number of test data

avgIter = 0;
E_train = 0.0;
E_test = 0.0;
for i = 1:nRep
    [X, y, w_f] = mkdata(nTrain);
    [w_g, iter] = perceptron(X, y);
    % Compute training, testing error
    y_predict = sign((w_g')*[ones(1,size(X,2));X]);
    E_train = E_train + sum(y_predict~=y)*1.0/size(y,2);
    % Generate the test data
    X_test = rand(size(X,1), nTest)*(1-(-1)) + (-1);
    y_test = sign((w_f')*[ones(1,size(X_test,2));X_test]);
    y_predict = sign((w_g')*[ones(1,size(X_test,2));X_test]);
    E_test = E_test + sum(y_predict~=y_test)*1.0/size(y_test,2);
    % Sum up number of iterations
    avgIter = avgIter + iter;
end
avgIter = avgIter*1.0/nRep;
E_train = E_train/nRep;
E_test = E_test/nRep;

fprintf('E_train is %f, E_test is %f.\n', E_train, E_test);
fprintf('Average number of iterations is %d.\n', avgIter);
plotdata(X, y, w_f, w_g, 'Pecertron');

%% Part2: Preceptron: Non-linearly separable case
nTrain = 100; % number of training data
[X, y, w_f] = mkdata(nTrain, 'noisy');
[w_g, iter] = perceptron(X, y);


%% Part3: Linear Regression
nRep = 1000; % number of replicates
nTrain = 100; % number of training data

E_train = 0.0;
E_test = 0.0;
for i = 1:nRep
    [X, y, w_f] = mkdata(nTrain);
    w_g = linear_regression(X, y);
    % Compute training, testing error
    y_predict = sign((w_g')*[ones(1,size(X,2));X]);
    E_train = E_train + sum(y_predict~=y)*1.0/size(y,2);
    % Generate the test data
    X_test = rand(size(X,1), nTest)*(1-(-1)) + (-1);
    y_test = sign((w_f')*[ones(1,size(X_test,2));X_test]);
    y_predict = sign((w_g')*[ones(1,size(X_test,2));X_test]);
    E_test = E_test + sum(y_predict~=y_test)*1.0/size(y_test,2);
end
E_train = E_train/nRep;
E_test = E_test/nRep;

fprintf('E_train is %f, E_test is %f.\n', E_train, E_test);
plotdata(X, y, w_f, w_g, 'Linear Regression');

%% Part4: Linear Regression: noisy
nRep = 1000; % number of replicates
nTrain = 100; % number of training data

E_train = 0.0;
E_test = 0.0;
for i = 1:nRep
    [X, y, w_f] = mkdata(nTrain, 'noisy');
    w_g = linear_regression(X, y);
    % Compute training, testing error
    y_predict = sign((w_g')*[ones(1,size(X,2));X]);
    E_train = E_train + sum(y_predict~=y)*1.0/size(y,2);
    % Generate the test data
    X_test = rand(size(X,1), nTest)*(1-(-1)) + (-1);
    y_test = sign((w_f')*[ones(1,size(X_test,2));X_test]);
    idx = randsample(size(X_test,2),size(X_test,2)/10);
    y_test(idx) = -y_test(idx);
    y_predict = sign((w_g')*[ones(1,size(X_test,2));X_test]);
    E_test = E_test + sum(y_predict~=y_test)*1.0/size(y_test,2);
end
E_train = E_train/nRep;
E_test = E_test/nRep;

fprintf('E_train is %f, E_test is %f.\n', E_train, E_test);
plotdata(X, y, w_f, w_g, 'Linear Regression: noisy');

%% Part5: Linear Regression: poly_fit
load('poly_train', 'X', 'y');
load('poly_test', 'X_test', 'y_test');
w = linear_regression(X, y);
% Compute training, testing error
y_predict = sign((w')*[ones(1,size(X,2));X]);
E_train = sum(y_predict~=y)*1.0/size(y,2);
y_predict = sign((w')*[ones(1,size(X_test,2));X_test]);
E_test = sum(y_predict~=y_test)*1.0/size(y_test,2);
fprintf('E_train is %f, E_test is %f.\n', E_train, E_test);

% poly_fit with transform
X_t = [X;X(1,:).*X(2,:);X(1,:).*X(1,:);X(2,:).*X(2,:)]; % CHANGE THIS LINE TO DO TRANSFORMATION
X_test_t = [X_test;X_test(1,:).*X_test(2,:);X_test(1,:).*X_test(1,:);X_test(2,:).*X_test(2,:)]; % CHANGE THIS LINE TO DO TRANSFORMATION
w = linear_regression(X_t, y);
% Compute training, testing error
y_predict = sign((w')*[ones(1,size(X_t,2));X_t]);
E_train = sum(y_predict~=y)*1.0/size(y,2);
y_predict = sign((w')*[ones(1,size(X_test_t,2));X_test_t]);
E_test = sum(y_predict~=y_test)*1.0/size(y_test,2);
fprintf('E_train is %f, E_test is %f.\n', E_train, E_test);


%% Part6: Logistic Regression
nRep = 100; % number of replicates
nTrain = 100; % number of training data

E_train = 0.0;
E_test = 0.0;
for i = 1:nRep
    [X, y, w_f] = mkdata(nTrain);
    w_g = logistic(X, y);
    % Compute training, testing error
    y_predict = sign(1.0./(1.0+exp(-(w_g')*[ones(1,size(X,2));X]))-0.5);
    E_train = E_train + sum(y_predict~=y)*1.0/size(y,2);
    % Generate the test data
    X_test = rand(size(X,1), nTest)*(1-(-1)) + (-1);
    y_test = sign((w_f')*[ones(1,size(X_test,2));X_test]);
    y_predict = sign(1.0./(1.0+exp(-(w_g')*[ones(1,size(X_test,2));X_test]))-0.5);
    E_test = E_test + sum(y_predict~=y_test)*1.0/size(y_test,2);
end
E_train = E_train/nRep;
E_test = E_test/nRep;

fprintf('E_train is %f, E_test is %f.\n', E_train, E_test);
plotdata(X, y, w_f, w_g, 'Logistic Regression');

%% Part7: Logistic Regression: noisy
nRep = 100; % number of replicates
nTrain = 100; % number of training data
nTest = 10000; % number of training data

E_train = 0.0;
E_test = 0.0;
for i = 1:nRep
    [X, y, w_f] = mkdata(nTrain, 'noisy');
    w_g = logistic(X, y);
    % Compute training, testing error
    y_predict = sign(1.0./(1.0+exp(-(w_g')*[ones(1,size(X,2));X]))-0.5);
    E_train = E_train + sum(y_predict~=y)*1.0/size(y,2);
    % Generate the test data
    X_test = rand(size(X,1), nTest)*(1-(-1)) + (-1);
    y_test = sign((w_f')*[ones(1,size(X_test,2));X_test]);
    idx = randsample(size(X_test,2),size(X_test,2)/10);
    y_test(idx) = -y_test(idx);
    y_predict = sign(1.0./(1.0+exp(-(w_g')*[ones(1,size(X_test,2));X_test]))-0.5);
    E_test = E_test + sum(y_predict~=y_test)*1.0/size(y_test,2);
end
E_train = E_train/nRep;
E_test = E_test/nRep;

fprintf('E_train is %f, E_test is %f.\n', E_train, E_test);
plotdata(X, y, w_f, w_g, 'Logistic Regression: noisy');

%% Part8: SVM
nRep = 1000; % number of replicates
nTrain = 100; % number of training data
nTest = 10000; % number of training data

E_train = 0.0;
E_test = 0.0;
support_num = 0;
for i = 1:nRep
    [X, y, w_f] = mkdata(nTrain);
    [w_g, num_sc] = svm(X, y);
    % Compute training, testing error
    y_predict = sign((w_g')*[ones(1,size(X,2));X]);
    E_train = E_train + sum(y_predict~=y)*1.0/size(y,2);
    % Generate the test data
    X_test = rand(size(X,1), nTest)*(1-(-1)) + (-1);
    y_test = sign((w_f')*[ones(1,size(X_test,2));X_test]);
    y_predict = sign((w_g')*[ones(1,size(X_test,2));X_test]);
    E_test = E_test + sum(y_predict~=y_test)*1.0/size(y_test,2);
    % Sum up number of support vectors
    support_num = support_num + num_sc;
end
E_train = E_train/nRep;
E_test = E_test/nRep;
support_num = support_num/nRep;

fprintf('E_train is %f, E_test is %f.\n', E_train, E_test);
fprintf('Number of support vector is %f\n', support_num);
plotdata(X, y, w_f, w_g, 'SVM');
