% DPMIX achieve Dirichlet Process mixture model by using CRP
%   to infer posterior of bayesian representation.
%
% Main procedures:
%   (1)initialization, including:
%       (1.1)data generation;
%       (1.2)model hyper-parameter and global variable setting;
%       (1.3)data randomly partition;
%   (2)iterative calling CRP to infer the posterior
%      distribution of parameters;
%   (3)evaluation on the final results:
%       (3.1)difference between actual and expected number of
%            clusters;
%       (3.2)mean distance (don't understand well)
%       (3.3)distance of all data points to their centers.
%
% Date: 12/4/2012


% (1)==============================================
% global variable and model hyper-parameter setting
numiter = 50;
alpha = 5
timeinterval = 5;

% evaluation results
diff_cluster = repmat(0, numiter, 1);
M_dis1 = repmat(0, numiter, 1);
M_dis2 = repmat(0, numiter, 1);

% synthetic data related variables setting
numclass = 3;
numdata = [100 100 100];
biasmean = [2.4, 2; -1.8, 1.4; -0.2, -2.6];
datadim = 2;

% data generation
global data;
data = gendata(numdata, numclass, biasmean, dim);

% randomly partition data
global crp;
crp = init_crp_v1(data, alpha);
%crp = init_crp_v2(data, alpha);
crp.numiter = numiter;


% (2)=========================================
% iterative calling CRP to infer the posterior
tic;
for iter=1:numiter,
    iterate_crp();
    if rem(iter, timeinterval) == 0,
        fprintf('Current iteration number: %d; Time cost: %fs...', iter, toc-tic);
    end
    
end

% (3)==============================
% final training and ploting



