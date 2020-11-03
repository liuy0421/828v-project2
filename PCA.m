function [] = PCA(X,y,name,dim)
    
    if nargin == 3
        dim = 2;
    end

    % normalize so that features center around 
    % mean with unit variance
    Y = normalize(X); 
    [U,S,V] = svd(Y,'econ');
    c = ['r';'b'];
    names = ['Florida'; 'Indiana'];
    PCs = Y*V(:,1:3);
    
    close all;
    figure;
    hold on; grid;
    
    if dim == 2
        for i = 1:2
            points = find(y == i);
            plot(PCs(points,1),PCs(points,2),'.',...
                 'color',c(i),'Markersize',20,"DisplayName",names(i,:));
        end
        legend;
        xlabel('PCA 1');
        ylabel('PCA 2');
    elseif dim == 3
        for i = 1:2
            points = find(y == i);
            plot3(PCs(points,1),PCs(points,2),PCs(points,3),'.',...
                 'color',c(i),'Markersize',20,"DisplayName",names(i,:));
        end
        legend;
        xlabel('PCA 1');
        ylabel('PCA 2');
        zlabel('PCA 3');
        view(3);
    end
  
    saveas(gcf,name);
    
end