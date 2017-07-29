listing = dir('captcha/*.jpg');
file_num = length(listing);
% X_train:   training sample features, P-by-N matrix.
% y_train:   training sample labels, 1-by-N row vector.
X_train = [];
y_train = [];
for i = 1:file_num
    caption = listing(i).name;
    file_name = strcat('./captcha/', caption);
    temp_X = extract_image(file_name);
    X_train = [X_train double(temp_X)];
    temp_y = [];
    for i = 1:5
        temp_y = [temp_y str2num(caption(i))];
    end
    y_train = [y_train temp_y];
end

save('hack_data.mat', 'X_train', 'y_train');