clearvars -except perc svm_acc_p svm_std_p fda_acc_p fda_std_p SVM_ACC SVM_STD FDA_ACC FDA_STD p emb1 emb2 tau1 tau2

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
            m = 2;
            tau = 1;
            [~,y1,~] = GmdRQA(xs(:,k),m,tau,'frob',perc,0); 
            y(k,:) = y1;
        elseif k ==1
            [~,y2,~] = GmdRQA(xs(:,k),emb1,tau1,'frob',perc,0); 
            y(k,:) = y2;
        elseif k==2 
            [~,y3,~] = GmdRQA(xs(:,k),emb2,tau2,'frob',perc,0); 
            y(k,:) = y3;
        end
    end
    
    Y = [y(1,:) y(2,:)];
    
    feat = [feat; Y];
    clearvars -except perc feat svm_acc_p svm_std_p fda_acc_p fda_std_p SVM_ACC SVM_STD FDA_ACC FDA_STD p emb1 emb2 tau1 tau2
end
toc


