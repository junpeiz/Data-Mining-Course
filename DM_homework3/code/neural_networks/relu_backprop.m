function [out_sensitivity] = relu_backprop(in_sensitivity, in)
%The backpropagation process of relu
%   input paramter:
%       in_sensitivity  : the sensitivity from the upper layer, shape: 
%                       : [number of images, number of outputs in feedforward]
%       in              : the input in feedforward process, shape: same as in_sensitivity
%   
%   output paramter:
%       out_sensitivity : the sensitivity to the lower layer, shape: same as in_sensitivity

% TODO
[img_num, output_num] = size(in_sensitivity);
out_sensitivity = zeros(img_num, output_num);
for i = 1:img_num
    f_der = zeros(1, output_num);
    f_der(in(i,:)>0) = 1;
    out_sensitivity(i,:) = in_sensitivity(i,:).*f_der;
end

end

