function [emb1,emb2,tau1,tau2] = find_mode_m_t_RQA(data) 

tic

T=[];
M=[];

for i = 1:length(data)
    
    dta = data{i};
    
    %chaos game theory
    [xx,yy] = cgr(dta);
    xs = [xx(2:end) ; yy(2:end)]';
    
    %Recurrence Quantification Analysis
    for k = 1:2
        if length(dta)<45
            [m,~] = find_parameters(xs(:,k));
            tau = 1;
            
            m_all(k) = m;
            t_all(k) = tau;
        else
            [m,tau] = find_parameters(xs(:,k));
            
            m_all(k) = m;
            t_all(k) = tau;
        end
    end
    
    mm = [m_all(1) m_all(2)];
    tt = [t_all(1) t_all(2)];
    M = [M; mm];
    T = [T; tt];
    clearvars -except data M T 
end
toc

mm = mode(M); tt = mode(T);

emb1 = mm(1); emb2 = mm(2); tau1 = tt(1); tau2=tt(2);

fprintf('The most frequent embedding dimension value for the first dimension is %d.\n',mm(1));
fprintf('The most frequent embedding dimension value for the second dimension is %d.\n',mm(2));
fprintf('The most frequent time delay value for the first dimension is %d.\n',tt(1));
fprintf('The most frequent time delay value for the second dimension is %d.\n',tt(2));
end