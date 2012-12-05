function prob = multigaussian(x, mu, sigma, choice)
%
%   MULTIGAUSSIAN gives some ad-hoc implementions those
%       will be used in Dirichlet Process.
%
%   Input variable:
%       x --> data point
%       mu --> average value of Gaussian distribution
%       sigma --> covariance matrix
%       choice --> ad-hoc Gaussian function choice
%
%   Output variable:
%       prob --> probability of data point
%
%   Date: 12/4/2012


dim = length(x);

switch choice
case 'z_new'
    prob = 1/(2*pi)^(dim/2)*det(inv(2.*eye(dim)))^(1/2) * ...
        exp(-1/2*x'*(1/2.*eye(dim))*x)
case 'z_old'
    prob = 1/(2*pi)^(dim/2)*exp(-1/2*(x-mu)'*(x-mu));
case 'fai'
    prob = 1/((2*pi)^(dim/2)*det(sigma)^(1/2))*exp(-1/2*(x-mu)'*inv(sigma)(x-mu));
otherwise
    error('Unknown choice.');
end
