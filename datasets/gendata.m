function data = gendata(numdata, numclass, dim)
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
%       dim --> number of dimensions of data.
%
%   Date: 12/4/2012

% components
data.dim = dim;
if length(numdata) == 1 & numdata ~= 0,
    data.numclass = numclass;
    data.numdata = repmat(numdata, 1, data.numclass);
elseif length(numdata) > 1,
    data.numclass = numclass;
end

data.ss = repmat(0.0, sum(data.numdata), )
