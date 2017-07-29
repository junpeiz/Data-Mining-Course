function [weight_grad, bias_grad, out_sensitivity] = fullyconnect_backprop(in_sensitivity,  in, weight)
%The backpropagation process of fullyconnect
%   input parameter:
%       in_sensitivity  : the sensitivity from the upper layer, shape: 
%                       : [number of images, number of outputs in feedforward]
%       in              : the input in feedforward process, shape: 
%                       : [number of images, number of inputs in feedforward]
%       weight          : the weight matrix of this layer, shape: 
%                       : [number of inputs in feedforward, number of outputs in feedforward]
%
%   output parameter:
%       weight_grad     : the gradient of the weights, shape: 
%                       : [number of inputs in feedforward, number of outputs in feedforward]
%       bias_grad       : the gradient of the bias, shape:
%                       : [number of outputs in feedforward, 1]
%       out_sensitivity : the sensitivity to the lower layer, shape: 
%                       : [number of images, number of inputs in feedforward]
%       
%
% Note : remember to divide by number of images in the calculation of gradients.

% TODO
[input_num, output_num] = size(weight);
img_num = size(in,1);
weight_grad = zeros(input_num, output_num);
bias_grad = zeros(output_num, 1);
out_sensitivity = zeros(img_num, input_num);
for ii = 1:img_num
    in_sensitivity_it = in_sensitivity(ii, :);
    in_it = in(ii, :);
    out_sensitivity(ii, :) = in_sensitivity_it*(weight');
    for i = 1:output_num
        for j = 1:input_num
            weight_grad(j,i) = weight_grad(j,i)+ in_sensitivity(ii,i)*in(ii,j);
        end
        bias_grad(i, 1) = bias_grad(i,1) + in_sensitivity(ii,i);
    end
end
weight_grad = weight_grad.*1.0./img_num;
bias_grad = bias_grad.*1.0./img_num;

end



