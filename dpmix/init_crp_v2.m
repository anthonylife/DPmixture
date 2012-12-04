function crp = init_crp(data, alpha, dim)
%
%   INITCRP doing some initialization work for CRP, including
%     partitioning data based on the start of CRP. This is different
%     from randomly partition as the construction process is based on
%     simulating users choosing tables.
%       
%   Input variable:
%       data --> structural variable, used for storing all related
%           information of data.
%       alpha --> concentration parameter.
%
%   Date: 12/4/2012


% variable setting
crp.predataclass = repmat(0, data.numdata, 1);
crp.prenumclass = 0;
crp.classnd = repmat(0, data.numdata, 1);
%   Note, as in this special task, only mean values of Gaussian need
%       to be infered. Moreover, each dimension is dependent on others.
crp.classpara = repmat(0, data.numdata, dim);
crp.alpha = alpha;

probs=
% partition data based on simulating users choosing tables
for ii=randperm(data.numdata),
    % no users being assigned to a specific category
    if crp.prenumclass == 0,
        crp.predataclass(ii) = 1;
        crp.classnd(1) = 1;
        crp.prenumclass = 1;
    else,
        for jj=1:crp.prenumclass,
            probs(jj) = multigaussian(data.ss(ii), crp.classpara(jj), 1, 'z_old');
        end
        probs(1:crp.prenumclass) = crp.classnd(1:crp.prenumclass).*probs./(data.numdata+crp.alpha-1);
        pro
        crp.predataclass(ii) = randmult();
        crp.classnd(crp.predataclass(ii)) = crp.classnd(crp.predataclass(ii)) + 1;
    end    
end

% 

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
