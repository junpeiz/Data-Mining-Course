img_name = 'test.jpg';
img = imread(img_name);
% YOUR (TWO LINE) CODE HERE
K_collect = [8, 16, 32, 64];
for i = 1:length(K_collect)
    fea = double(reshape(img, size(img, 1)*size(img, 2), 3));
    K = K_collect(i);
    [idx, ctrs, iter_ctrs] = kmeans(fea, K);
    fea=ctrs(idx,:);
    figure;
    imshow(uint8(reshape(fea, size(img))));
    out_img_name = strcat('out_',int2str(K),'_',img_name);
    imwrite(uint8(reshape(fea, size(img))), out_img_name);
end