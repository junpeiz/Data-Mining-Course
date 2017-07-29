function digits = hack(img_name)
%HACK Recognize a CAPTCHA image
%   Inputs:
%       img_name: filename of image
%   Outputs:
%       digits: 1x5 matrix, 5 digits in the input CAPTCHA image.

load('hack_data');
% YOUR CODE HERE
digit_m = extract_image(img_name);
show_image(digit_m);
digits = knn(double(digit_m), X_train, y_train, 20);
fprintf('The digits in this captcha is %d %d %d %d %d\n', digits);

end