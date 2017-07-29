clear all;

load('kmeans_data');
[data_num, feature_num] = size(X);
K = 2;
rep_time = 1000;
max_SD = 0;
max_idx = [];
max_ctrs = [];
max_iter_ctrs = [];
min_SD = 100000;
min_idx = [];
min_ctrs = [];
min_iter_ctrs = [];
for i = 1:rep_time
    [idx, ctrs, iter_ctrs] = kmeans(X, K);
    SD = 0.0;
    for j = 1:data_num
        X_it = X(j,:);
        X_label = idx(j);
        X_center = ctrs(X_label,:);
        SD = SD+norm(X_it-X_center);
    end
    if(SD > max_SD)
        max_SD = SD;
        max_idx = idx;
        max_ctrs = ctrs;
        max_iter_ctrs = iter_ctrs;
    end
    if(SD < min_SD)
        min_SD = SD;
        min_idx = idx;
        min_ctrs = ctrs;
        min_iter_ctrs = iter_ctrs;
    end
end
kmeans_plot(X,max_idx,max_ctrs,max_iter_ctrs);
figure;
kmeans_plot(X,min_idx,min_ctrs,min_iter_ctrs);