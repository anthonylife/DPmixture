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
%if 0,
numiter = 50;
alpha = 0.5;
timeinterval = 5;
infer_choice = 'GS';    % infer_choice means which inference method to choose

% evaluation results
clusters = repmat(0, numiter, 1);
diff_cluster = repmat(0, numiter, 1);
M_dis1 = repmat(0, numiter, 1);
M_dis2 = repmat(0, numiter, 1);

% synthetic data related variables setting
numclass = 3;
numdata = [100 100 100];
datadim = 2;
gaussianmean = [2.4, 2; -1.8, 1.4; -0.2, -2.6];

% data generation
global data;
data = gendata(numdata, numclass, gaussianmean, datadim);

% randomly partition data
global crp;
crp = init_crp_v1(data, alpha);
%crp = init_crp_v2(data, alpha);
crp.numiter = numiter;

% (2)=========================================
% iterative calling CRP to infer the posterior
tic;
for iter=1:numiter,
    dp_crp(infer_choice);
    if rem(iter, timeinterval) == 0,
        fprintf('Current iteration number: %d; Time cost: %fs...\n', iter, toc-tic);
    end
    clusters(iter) = crp.prenumclass;
    % intermediate result evaluation
    [diff_cluster(iter), M_dis1(iter), M_dis2(iter)] = evaluation();
    fprintf('Current number of clusters:%d,\n', clusters(iter));
    fprintf('Difference between actual and expected number of clusters:%f,\n', diff_cluster(iter));
    fprintf('Distance of mean to mean:%f,\n', M_dis1(iter));
    fprintf('Distance of all data points to their centers:%f...\n', M_dis2(iter));
end
%end
% (3)==============================
% final evaluation and plot
myplot(numiter, clusters, diff_cluster, M_dis1, M_dis2);

