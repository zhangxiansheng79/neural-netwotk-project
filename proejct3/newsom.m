function w = newsom(data,m,n,iteration)

[row,column] = size(data);
neurons = m*n;
w = -1 + 2 * rand(neurons, column);

[I,J] = ind2sub([m,n],1:neurons); %the positions of neurons in the som
coords = [I', J'];
iter = iteration;
eta0 = 0.05;
eta = eta0;

sigma0 = m;
sigma = sigma0;

for t = 1:iteration
    % calculate distance matrix and sort
    % return the winning w index
    [~, winIdx] = pdist2(w, data, 'euclidean', 'Smallest', 1);
    % index to position
    [winrow, wincolumn] = ind2sub([m,n], winIdx);
    win_pos = [winrow', wincolumn'];
    % distance between every neuron to each data point
    dist = pdist2(coords, win_pos, 'euclidean');
    h = exp( - dist.^2 / (2 * sigma^2));
    for n = 1: row
        w = w + eta * h(:, n) .* (data(n, :) - w);
    end
    
	eta = eta0*exp(-t/iter);
	sigma = sigma0*exp(-t/iter * log(sigma0));

end