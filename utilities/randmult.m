function idx = randmult(probs)
%
%   RANDMULT randomly sample category index from multinomial
%     distribution.
%
%   Input variables:
%       probs --> probability vector, with accumulated value
%           equal to 1.
%
%   Output variables:
%       idx --> sampled category id.
%
%   Date: 12/4/2012


rand('state', sum(100*clock));

cumprobs = cumsum(probs);
idx = find(cumprobs>rand, 1);
