function img = hack_pca(filename)
% Input: filename -- input image file name/path
% Output: img -- image without rotation

img_r = double(imread(filename));
imshow(uint8(img_r));

% YOUR CODE HERE
% mark the content which is not the background
[content_row, content_col] = find(img_r~=255);
[eigvector, eigvalue] = pca([content_row, content_col]);
first_pc = eigvector(:,1);
base_vec = [1, 0];
res_arc = acos(dot(first_pc,base_vec)/(norm(first_pc)*norm(base_vec)));
res_img = imrotate(img_r, 90-radtodeg(res_arc));
imshow(uint8(res_img));
end