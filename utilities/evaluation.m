function [diff_cluster, M_dis1, M_dis2] = evaluation()
%
%   EVALUATION implement three evaluation metrics for testing
%     the effectiveness of DP mixture model.
%
%   Date: 12/5/2012


global data;
global crp;

% difference between actual and expected number of clusters
diff_cluster = crp.prenumclass - crp.alpha*log(1+data.numdata/crp.alpha);

% difference of all components means to their means
M_dis1=sum(sqrt(sum(crp.classpara(1:crp.prenumclass,:).*crp.classpara(1:crp.prenumclass,:), 2)));

% difference of all data points to their centers
mu = repmat(0.0, data.numdata, data.dim);
for ii=1:crp.prenumclass,
    mu(find(crp.predataclass == ii),:) = sum(data.ss(find(crp.predataclass == ii),:), 1);
end
M_dis2 = sum(sqrt(sum((data.ss-mu).*(data.ss-mu), 2)), 1);
