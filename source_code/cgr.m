% Chaos Game Representation 
function [x,y] = cgr(sequence)

x(1) = 0.5; y(1) = sqrt(3)/6; 

for j = 1:length(sequence)
    
    a = sequence(j);
    
    switch a
        
        case 'H'
            v = [0,0];
        case 'C'
            v = [0.5,sqrt(3)/2];
        case 'E'
            v = [1,0];
    end
    
    x(j+1) = 0.5 * (x(j) + v(1));
    y(j+1) = 0.5 * (y(j) + v(2));
end
end

