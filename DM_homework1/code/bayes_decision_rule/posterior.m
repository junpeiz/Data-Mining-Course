function p = posterior(x)
%POSTERIOR Two Class Posterior Using Bayes Formula
%
%   INPUT:  x, features of different class, C-By-N vector
%           C is the number of classes, N is the number of different feature
%
%   OUTPUT: p,  posterior of each class given by each feature, C-By-N matrix
%

[C, N] = size(x);
l = likelihood(x);
total = sum(sum(x));
%TODO
P_w = sum(x,2)./total;
P_x = sum(x,1)./total;
P_w = repmat(P_w, 1, N);
P_x = repmat(P_x, C, 1);
p = l.*P_w./P_x;

end
