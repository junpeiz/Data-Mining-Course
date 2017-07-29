% You can use this skeleton or write your own.
% You are __STRONGLY__ suggest to run this script section-by-section using Ctrl+Enter.
% See http://www.mathworks.cn/cn/help/matlab/matlab_prog/run-sections-of-programs.html for more details.

%%load data
load('data');
all_x = cat(2, x1_train, x1_test, x2_train, x2_test);
range = [min(all_x), max(all_x)];
train_x = get_x_distribution(x1_train, x2_train, range);
test_x = get_x_distribution(x1_test, x2_test, range);

%% Part1 likelihood: 
l = likelihood(train_x);

bar(range(1):range(2), l');
xlabel('x');
ylabel('P(x|\omega)');
axis([range(1) - 1, range(2) + 1, 0, 0.5]);

%TODO
%compute the number of all the misclassified x using maximum likelihood decision rule
err_num = 0;
[M,predict_y] = max(l);
for i = 1:size(test_x,2)
    temp_col = test_x(:,i);
    err_num = err_num + sum(temp_col)-temp_col(predict_y(i));
end
disp('The number of the misclassified x is:')
disp(err_num);
disp('The misclassified rate is:')
disp(err_num*1.0/sum(sum(test_x)));

%% Part2 posterior:
p = posterior(train_x);

bar(range(1):range(2), p');
xlabel('x');
ylabel('P(\omega|x)');
axis([range(1) - 1, range(2) + 1, 0, 1.2]);

%TODO
%compute the number of all the misclassified x using optimal bayes decision rule
err_num = 0;
[M,predict_y] = max(p);
for i = 1:size(test_x,2)
    temp_col = test_x(:,i);
    err_num = err_num + sum(temp_col)-temp_col(predict_y(i));
end
disp('The number of the misclassified x is:')
disp(err_num);
disp('The misclassified rate is:')
disp(err_num*1.0/sum(sum(test_x)));

%% Part3 risk:
risk = [0, 1; 2, 0];
%TODO
%get the minimal risk using optimal bayes decision rule and risk weights
result = 0;
for i = 1:size(test_x,2)
    R_a1 = risk(1,1)*p(1,i)+risk(1,2)*p(2,i);
    R_a2 = risk(2,1)*p(1,i)+risk(2,2)*p(2,i);
    result = result + min(R_a1, R_a2);
end
disp('The minimum total risk is:');
disp(result);