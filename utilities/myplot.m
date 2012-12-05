function myplot(numiter, clusters, diff_cluster, M_dis1, M_dis2)
%
%   MYPLOT plot five types of pictures:(1)number of clusters in each iteration; 
%       (2)data partition; (3-5)evaluation metrics 1-3.
%
%   Date: 12/5/2012


global data;
global crp;

% color and shape setting
color = ['r', 'g', 'b', 'k', 'c', 'm', 'y'];
shape = ['.', '*', 'x', 'square', 'o'];

% (1)number of clusters
figure(1)
plot(1:numiter, clusters, 'r*-');
axis([0 50 0 10]);
set(gca, 'XTick', 0:5:50);
set(gca, 'YTick', 0:2:10);
title('Changes of number of clusters');
xlabel('Iterations');
ylabel('Number of clusters');
print(1, '-djpeg', '../fig/numclusters.jpeg');

% (2)figure of data partition
figure(2);
hold on;
for ii=1:crp.prenumclass,
    is = (ii-1)/length(shape)+1;
    ic = sem(ii-1, length(color))+1;
    plot(data.ss(find(crp.predataclass == ii), 1), data.ss(find(crp.predataclass == ii), 2), color(ic), shape(is));
end
hold off;
title('Data distribution');
print(2, '-djpeg', '../fig/dataclusters.jpeg');

%(3-5)evaluation metrics 1-3
figure(3);
plot(1:numiter, diff_cluster, 'r*-');
axis([0 50 -10 30]);
set(gca, 'YTick', -10:10:30);
set(gca, 'XTick', 0:5:50);
title('Difference between predicted clusters and expected clusters');
xlabel('Iterations');
ylabel('D(K, a)');
print(3, '-djpeg', '../fig/diffclusters.jpeg');

figure(4);
plot(1:numiter, M_dis1, 'r*-');
axis([0 50 0 100]);
set(gca, 'XTick', 0:5:50);
title('Values of mean to mean');
xlabel('Iterations');
ylabel('M_dis1');
print(4, '-djpeg', '../fig/M_dis1.jpeg');

figure(5);
plot(1:numiter, M_dis2, 'r*-');
axis([0 50 0 1000]);
set(gca, 'XTick', 0:5:50);
title('Values of data to centers');
xlabel('Iterations');
ylabel('M_dis2');
print(5, '-djpeg', '../fig/M_dis2.jpeg');

