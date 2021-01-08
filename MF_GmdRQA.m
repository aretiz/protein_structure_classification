clearvars -except perc svm_acc_p svm_std_p fda_acc_p fda_std_p SVM_ACC SVM_STD FDA_ACC FDA_STD p emb1 emb2 tau1 tau2

load('DATA.mat')

tic

feat = [];

for i = 1:length(data)

    load('DATA.mat')
    
    dta = data{i};
    
    %chaos game theory
    [xx,yy] = cgr(dta);
    xs = [xx(2:end) ; yy(2:end)]';
    
    %Recurrence Quantification Analysis
        if length(dta)<45
            m = 2;
            tau = 1;
            [~,Y,~] = GmdRQA(xs,m,tau,'frob',perc,0);        
        else 
            [~,Y,~] = GmdRQA(xs,emb1,ceil(tau1),'frob',perc,0); 
        end
    
    feat = [feat; Y];
    clearvars -except perc feat svm_acc_p svm_std_p fda_acc_p fda_std_p SVM_ACC SVM_STD FDA_ACC FDA_STD p emb1 emb2 tau1 tau2
end
toc


