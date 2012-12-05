function data = gendata(numdata, numclass, gaussianmean, dim)
%
%   GENDATA generates data accroding to different Gaussian
%       functions.
%
%   Input variable:
%       numdata --> (1)length > 1, number of data for each
%           class; (2)length = 1 and numdata ~= 0, each
%           class has the same number of data, i.e., numdata;
%           (3)length = 1 and numdata == 0, randly choose the
%           number of data.
%       numclass --> total number of class of the data. 
%       gaussianmean --> mean value of Gaussian distribution.
%           In this test, bias mean is set in advance.
%       dim --> number of dimensions of data.
%
%   Date: 12/4/2012


N = 200;    % maximum of data points

% components setting
data.dim = dim;
if length(numdata) == 1 & numdata ~= 0,
    data.numclass = numclass;
    data.numdata = repmat(numdata, 1, data.numclass);
    data.gaussianmean = gaussianmean;
elseif length(numdata) > 1,
    data.numclass = numclass;
    data.numdata = numdata;
    data.gaussianmean = gaussianmean;
elseif length(numdata) == 1 & numdata == 0,
    data.numclass = numclass;
    for ii=1:data.numclass,
        data.numdata(ii) = unidrnd(N);
    end
    data.gaussianmean = gaussianmean;
end

% data space allocation
data.ss = repmat(0.0, sum(data.numdata), data.dim);
data.cc = repmat(0, sum(data.numdata), 1);

% data generation
data.ss(1:data.numdata(1),:) = normrnd(0, 1, data.numdata(1), 2)...
    + repmat(data.gaussianmean(1,:), data.numdata(1), 1);
data.cc(1:data.numdata(1)) = 1;
start_idx = data.numdata(1);

for ii =2:data.numclass,
    data.ss(start_idx+1:start_idx+data.numdata(ii),:) = normrnd(0, 1,...
        data.numdata(ii), 2) + repmat(data.gaussianmean(ii,:), data.numdata(ii),1);
    data.cc(start_idx+1:start_idx+data.numdata(ii)) = repmat(ii, data.numdata(ii), 1);
    start_idx = start_idx + data.numdata(ii);
end
data.numdata = sum(data.numdata);
