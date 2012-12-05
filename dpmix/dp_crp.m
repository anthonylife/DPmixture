function dp_crp(choice)
%
%   DPCRP do gibbs sampling to infer the posterior distribution
%     of parameters, which is an implementation of CRP.
%
%   No explicit input variables other than 'choice' because we
%     use global variables here.
%     choice --> 'Gibbs sampling' or 'Collapsed Gibbs sampling'.
%
%   No explicit output variables because we directly modify the
%     corresponding global variables.
%
%   Date: 12/5/2012


global data;
global crp;

% used to store probability of belonging to each category
probs = repmat(0.0, data.numdata, 1);

switch choice,
% Gibbs Sampling
case 'GS'
    % sample category indicator variable
    for ii = randperm(data.numdata),
        cc = crp.predataclass(ii);     % predicted category for data

        % remove the point from category records
        crp.classnd(cc) = crp.classnd(cc) - 1;
        if crp.classnd(cc) == 0,
            crp.prenumclass = crp.prenumclass - 1;
            idx = find(crp.predataclass > cc);
            crp.predataclass(idx) = crp.predataclass(idx) - 1;
            crp.classnd(cc:end-1) = crp.classnd(cc+1:end);
            crp.class(end) = 0;
        end

        % conditional probability
        for jj=1:crp.prenumclass,
            probs(jj) = multigaussian(data.ss(ii,:)', crp.classpara(ii,:)', 0, 'z_old');
        end
        probs(1:crp.prenumclass) = crp.classnd(1:crp.prenumclass).*probs(1:crp.prenumclass)...
            ./(data.numdata+crp.alpha-1);
        probs(crp.prenumclass+1) = multigaussian(data.ss(ii,:)', 0, 0, 'z_new');
        
        % sample from multinomial distribution
        crp.predataclass(ii) = randmult(probs, crp.prenumclass+1);
        if crp.predataclass(ii) == crp.prenumclass + 1,
            crp.prenumclass = crp.prenumclass + 1;
        end
        crp.classnd(crp.predataclass(ii)) = crp.classnd(crp.predataclass(ii)) + 1;
    end
    
    % sample each fai for each category
    % in this task, fai indicates mean value
    for ii=1:crp.prenumclass,
        % utilizing independence between each dimension
        sigma = 1/(1+crp.classnd(ii));
        mu = sigma*sum(data.ss(find(crp.predataclass==ii)), 1);
        for jj=1:data.dim,
            crp.classpara(ii,jj) = normrnd(mu(jj), sigma, 1);
        end 
    end

% Collapsed Gibbs Sampling
case 'CGS'
    disp('Have not implemented.');

otherwise
    error('Unknown choice');
end
