% mu: 2x1 matrix
% Sigma: 2x2 matrix
% phi: a number

%%line
mu0 = [0; 0];
Sigma0 = [1,0; 0,1];
mu1 = [1; 1];
Sigma1 = [1,0; 0,1];
phi = 0.5;
plot_ex1(mu0, Sigma0, mu1, Sigma1, phi, 'Line', 1);

%%line one side
mu0 = [0; 0];
Sigma0 = [1,0; 0,1];
mu1 = [1; 1];
Sigma1 = [1,0; 0,1];
phi = 0.1;
plot_ex1(mu0, Sigma0, mu1, Sigma1, phi, 'Line (one side)', 2);

%%Parabalic
mu0 = [0; 0];
Sigma0 = [1,0; 0,1];
mu1 = [1; 1];
Sigma1 = [0.4,0; 0,1];
phi = 0.5;
plot_ex1(mu0, Sigma0, mu1, Sigma1, phi, 'Parabalic', 3);

%%Hyperbola
mu0 = [0; 0];
Sigma0 = [1,0; 0,1];
mu1 = [1; 1];
Sigma1 = [0.4,0; 0,2];
phi = 0.5;
plot_ex1(mu0, Sigma0, mu1, Sigma1, phi, 'Hyperbola', 4);

%%Two parallel lines
mu0 = [0; 0];
Sigma0 = [1,0; 0,1];
mu1 = [0; 0];
Sigma1 = [2,1; 1,2];
phi = 0.5;
plot_ex1(mu0, Sigma0, mu1, Sigma1, phi, 'Two parallel lines.', 5);

%%Circle
mu0 = [0; 0];
Sigma0 = [1,0; 0,1];
mu1 = [0; 0];
Sigma1 = [2,0; 0,2];
phi = 0.5;
plot_ex1(mu0, Sigma0, mu1, Sigma1, phi, 'Circle', 6);

%%Ellipsoid
mu0 = [0; 0];
Sigma0 = [1,0; 0,4];
mu1 = [0; 0];
Sigma1 = [2,0; 0,8];
phi = 0.5;
plot_ex1(mu0, Sigma0, mu1, Sigma1, phi, 'Ellipsoid', 7);

%%No boundary
mu0 = [0; 0];
Sigma0 = [1,0; 0,1];
mu1 = [0; 0];
Sigma1 = [1,0; 0,1];
phi = 0.5;
plot_ex1(mu0, Sigma0, mu1, Sigma1, phi, 'No boundary', 8);