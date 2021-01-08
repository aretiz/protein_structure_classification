function a_rp = distance_metric(DATA,name,m,dim)

if exist('DATA') % check whether input data has been specified - if not, throw error message
else
    error('No input data specified.');
end

if strcmp(name,'frob') == 1 % state matrix and frobenius norm
    if isempty(DATA)==0
        for i = 1:size(DATA,1)
            A = repmat(DATA(i,:),size(DATA,1),1);
            a(i,:) = sqrt(sum((A-DATA).*(A-DATA),2));
        end
    else
        a = 0;
    end
elseif strcmp(name, 'svd_frob') ==1 % state matrix eigenvalues (svd over the state matrices) and frobenius (l2) norm
    a(length(DATA),length(DATA))= 0;
    
    for i =1:size(DATA,1)
        k = vec2mat(DATA(i,:),m);
        kk = svd(k);
        for j = 1:size(DATA,1)
            if i<=j
                l = vec2mat(DATA(j,:),m);
                ll = svd(l);
                a(i,j) = norm(kk.^2-ll.^2,'fro');
            end
        end
    end
    a = triu(a)+triu(a,1)';
else
    error('Undifined distance metric.');
end

a_rp = a;

end