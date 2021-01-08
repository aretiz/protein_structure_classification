function [emb,tau] = find_mode_m_t_GmdRQA(data) 

tic

T=[];
M=[];

for i = 1:length(data)
   
    dta = data{i};
    
    %chaos game theory
    [xx,yy] = cgr(dta);
    xs = [xx(2:end) ; yy(2:end)]';
    
    if size(xs,1)<45
        [m,~] = find_parameters(xs);
        tau = 1;        
    else
        [m,tau] = find_parameters(xs);        
    end

    M = [M; m];
    T = [T; ceil(tau)];
    clearvars -except M T data
end

toc

emb = mode(M);
tau = mode(T);

fprintf('The most frequent embedding dimension value is %d .\n',mode(M));
fprintf('The most frequent time delay value is %d .\n',mode(T)); 
end