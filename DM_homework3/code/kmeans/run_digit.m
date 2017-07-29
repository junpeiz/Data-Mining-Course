clear all;

load('digit_data');
[data_num, feature_num] = size(X);
K_collect = [10, 20, 50];
for i = 1:length(K_collect)
    K = K_collect(i);
    [idx, ctrs, iter_ctrs] = kmeans(X, K);
    figure;
    show_digit(ctrs);
end