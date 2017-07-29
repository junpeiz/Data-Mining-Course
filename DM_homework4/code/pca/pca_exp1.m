load('ORL_data', 'fea_Train', 'gnd_Train', 'fea_Test', 'gnd_Test');
% fea_Train is nxp which has n samples

% YOUR CODE HERE
eigface_num = 40;
% 1. Feature preprocessing
mean_face = mean(fea_Train);
% 2. Run PCA
[eigvector, eigvalue] = pca(fea_Train);
% 3. Visualize eigenface
eigface = eigvector(:, 1:eigface_num);
figure('Name', 'Original face');
show_face(fea_Train);
figure('Name', 'Eigenface');
show_face(eigface');

eig_num_collect = [8, 16, 32, 64, 128];
for i = 1:length(eig_num_collect)
    eigface_num = eig_num_collect(i);
    transform_m = eigvector(:, 1:eigface_num);
    % 4. Project data on to low dimensional space
    train_res = fea_Train*transform_m;
    % 5. Run KNN in low dimensional space
    Mdl = fitcknn(train_res, gnd_Train);
    test_res = fea_Test*transform_m;
    label = predict(Mdl, test_res);
    error_rate = sum(label~=gnd_Test)*1.0/length(gnd_Test);
    fprintf('For the %d eigen face, the test error rate is %f\n', eigface_num, error_rate);
    % 6. Recover face images form low dimensional space, visualize them
    str = sprintf('The reconstruct with %d eigenfaces', eigface_num);
    figure('Name',str);
    reconstruct = transform_m*(train_res');
    show_face(reconstruct');
end


