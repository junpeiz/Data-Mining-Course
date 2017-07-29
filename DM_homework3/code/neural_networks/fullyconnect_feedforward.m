function [out] = fullyconnect_feedforward(in,  weight, bias)
%The feedward process of fullyconnect
%   input parameters:
%       in      : the intputs, shape: [number of images, number of inputs]
%       weight  : the weight matrix, shape: [number of inputs, number of outputs]
%       bias    : the bias, shape: [number of outputs, 1]
%
%   output parameters:
%       out     : the output of this layer, shape: [number of images, number of outputs]

% TODO
[img_num, input_num] = size(in);
output_num = size(weight, 2);
out = in*weight + repmat(bias', img_num, 1);

end

