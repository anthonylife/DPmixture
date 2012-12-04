function crp = init_crp(data, alpha)
%
%   INITCRP doing some initialization work for CRP, including
%     randomly partitioning data,
%       
%   Input variable:
%       data --> structural variable, used for storing all related
%           information of data.
%       alpha --> concentration parameter.
%
%   Date: 12/4/2012


% variable setting
crp.predataclass = repmat(0, data.numdata, 1);
crp.prenumclass = data.numdata;
crp.classnd = repmat(0, data.numdata, 1);
crp.classpara = repmat(0, data.numdata, 1);
crp.alpha = alpha;

% randomly partition data
for ii=1:data.numdata,
    crp.predataclass(ii) = randmult(repmat(1, 1, data.numdata)/data.numdata);
    crp.classnd(crp.predataclass(ii)) = crp.classnd(crp.predataclass(ii)) + 1;
end

% data category clean
numclass = crp.prenumclass;
for ii=crp.prenumclass:-1:1,
    % empty category
    if crp.classnd(ii) == 0,
        numclass = numclass - 1;
        idx = find(crp.predataclass > ii);
        crp.predataclass(idx) = crp.predataclass(idx) - 1;
        crp.classnd(ii:end-1) = crp.classnd(ii+1:end);
        crp.classnd(end) = 0;
    end
end
