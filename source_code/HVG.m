clear all 


load('DATA.mat')

tic
feature_mat = [];

for i = 1:length(data)
    load('DATA.mat')

    dta = data{i};
    
    %chaos game theory
    [xx,yy] = cgr(dta);
    
    xs = [xx(2:end);yy(2:end)]';
    
    for k = 1:2
        %horizontal visibility graph and metrics
        VG = fast_HVG(xs(:,k)-1,ones(1,length(xs(:,1))),0); %adjacency matrix
        G  = graph(VG);
        d  = distances(G,'Method','unweighted');   %shortest path distance between all pairs of graph nodes
        LG = laplacian(G);
        mu = eig(LG);
        lambda = eig(VG);
        deg = degree(G);      %node degree
        mm  = size(G.Edges,1);
        n  = size(G.Nodes,1); %number of nodes
        m  = size(G.Edges,1); %number of edges
        
        y(k,1) = max(deg);      %max degree
        y(k,2) = sum(d(:))/(n*(n-1)); %average shortest path length
        y(k,3) = max(d(:));           %average diameter
        
        trinum = full(diag(VG*triu(VG)*VG)); %number of triangles for each node
        cc = sum(trinum)/(sum(trinum)+length(find(triu(d)==2)));
        
        y(k,4) = cc;                                     %clustering coefficient
        y(k,5) = sum(abs(lambda));                       %energy
        y(k,6) = sum(abs(mu-(2*m/n)));                   %laplace energy
        y(k,7) = assortativity(VG,0);                    %pearson correlation coefficient
        y(k,8) = sum((n-1)./sum(d))/n;                   %closeness sentrality
        
    end
    
    Y = [y(1,:) y(2,:) n]; %number of nodes
    feature_mat = [feature_mat; Y];
    clearvars -except perc feature_mat 
end

toc

