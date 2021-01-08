clearvars -except perc svm_acc_p svm_std_p fda_acc_p fda_std_p SVM_ACC SVM_STD FDA_ACC FDA_STD p

load('DATA.mat')

tic

feat = [];

for i = 1:length(data)
    close all
    load('DATA.mat')
    
    dta = data{i};
    
    %chaos game theory
    [xx,yy] = cgr(dta);
    xs = [xx(2:end) ; yy(2:end)]';
    
    %Recurrence Quantification Analysis
    for k = 1:2
        if length(dta)<45
            [m,~] = find_parameters(xs(:,k));
            tau = 1;
            [~,yy,~] = GmdRQA(xs(:,k),m,tau,'frob',perc,0); %% mdrqa on each coordinate
            y(k,:) = yy;
        else
            [m,tau] = find_parameters(xs(:,k));
            [~,yy,~] = GmdRQA(xs(:,k),m,tau,'frob',perc,0); %% mdrqa on each coordinate
            y(k,:) = yy;
        end
    end
    
    Y = [y(1,:) y(2,:)];
    
    feat = [feat; Y];
    clearvars -except perc feat svm_acc_p svm_std_p fda_acc_p fda_std_p SVM_ACC SVM_STD FDA_ACC FDA_STD p
end
toc


