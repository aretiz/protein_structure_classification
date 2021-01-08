function [m,tau] =  find_parameters(xs)
    
    if size(xs,1)<size(xs,2)
        xs = xs';
    end
    
    tau = mdDelay(xs, 'maxLag',10,'criterion','firstBelow', 'plottype', 'none');
    
    if tau == 0
        tau = 1;
    end
    
    [fnnPercent, ~] = mdFnn(xs,ceil(tau));
    
    m = find(fnnPercent == 0,1);
    
end
