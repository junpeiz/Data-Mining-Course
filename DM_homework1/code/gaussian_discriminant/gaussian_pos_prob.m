function P = gaussian_pos_prob(X, Mu, Sigma, Phi)
%GAUSSIAN_POS_PROB Posterior probability of GDA.
%   p = GAUSSIAN_POS_PROB(X, Mu, Sigma) compute the posterior probability
%   of given N data points X using Gaussian Discriminant Analysis where the
%   K gaussian distributions are specified by Mu, Sigma and Phi.
%
%   Inputs:
%       'X'     - M-by-N matrix, N data points of dimension M.
%       'Mu'    - M-by-K matrix, mean of K Gaussian distributions.
%       'Sigma' - M-by-M-by-K matrix (yes, a 3D matrix), variance matrix of
%                   K Gaussian distributions.
%       'Phi'   - 1-by-K matrix, prior of K Gaussian distributions.
%
%   Outputs:
%       'p'     - N-by-K matrix, posterior probability of N data points
%                   with in K Gaussian distributions.

N = size(X, 2);
K = length(Phi);
P = zeros(N, K);

% Your code HERE
P_x_y = zeros(1,K);
P_y = zeros(1,K);
for i = 1:N
    x = X(:,i);
    P_x = 0.0;
    for j = 1:K
        covarian = Sigma(:,:,j);
        mu = Mu(:,j);
        P_x_y(1,j) = 1.0/(2*pi*sqrt(det(covarian)))*exp(-0.5*(x-mu)'*inv(covarian)*(x-mu));
        P_y(1,j) = Phi(1,j);
        P_x = P_x + P_x_y(1,j)*P_y(1,j);
    end
    for j = 1:K
        P(i,j) = P_x_y(1,j)*P_y(1,j)/P_x;
    end
end