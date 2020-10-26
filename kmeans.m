% Given an n x m data matrix, return a
% n x 1 labeling of the data points using
% kmeans clustering
function [labels] = kmeans(M,k)

    [n,m] = size(M);
    maxiter = 100;
    
    if n < k
        error('k must be less than the number of data points')
    elseif k == 1 
        error('k must be greater than 1')
    end
    
    % greedily initialize k centers by iteratively
    % picking the furthest points from the average
    % of the current centers
    means = zeros(k,m);
    mean_ids = zeros(k,1);
    mean_ids(1) = randperm(n,1);
    means(1,:) = M(mean_ids(1),:); % randomly select the first center
    for i = 2 : k
        center = sum(means)./ (i-1); % average of the centers so far
        dists = zeros(n,1);
        for row  = setdiff(1:n,mean_ids)
            dists(row) = norm(M(row,:) - center);
        end
        [~,maxid] = max(dists);
        mean_ids(i) = maxid;
        means(i,:) = M(maxid,:);
    end
    
    labels = zeros(n,1);
    
    for i = 1 : maxiter
        new_labels = zeros(n,1);
        for j = 1 : n
            dists = zeros(k,1);
            for u = 1 : k
                dists(u) = norm(M(j,:)-means(u,:));
            end
            [~,minid] = min(dists);
            new_labels(j) = minid;
        end
        
        if new_labels == labels
            break
        else 
            for u = 1 : k
                points = find(new_labels == u);
                means(u) = sum(points) ./ length(points);
                labels = new_labels;
            end
        end
    end
    
end