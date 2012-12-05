function idx = randmult(probs, numitem)
%
%   RANDMULT randomly sample category index from multinomial
%     distribution.
%
%   Input variables:
%       probs --> probability vector, with accumulated value
%           equal to 1.
%       numitem --> number of valid items
%
%   Output variables:
%       idx --> sampled category id.
%
%   Date: 12/4/2012


rand('state', sum(100*clock));

cumprobs = cumsum(probs(1:numitem));
idx = find(cumprobs>rand, 1);
