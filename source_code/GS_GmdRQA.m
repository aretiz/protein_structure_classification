clearvars -except ind jj kk emb tau emb1 tau1 perc svm_acc_p svm_std_p fda_acc_p fda_std_p SVM_ACC SVM_STD FDA_ACC FDA_STD p fda_acc svm_acc FDA_acc_all SVM_acc_all hvg_feat

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
        t = 1;
    else
        m = emb1;
        t = tau1;
    end
    
    [~,Y,~] = GmdRQA(xs,m,t,'euc',perc,0);
    
    feat = [feat;Y];
    
    clearvars -except ind jj kk emb tau perc emb1 tau1 feat svm_acc_p svm_std_p fda_acc_p fda_std_p SVM_ACC SVM_STD FDA_ACC FDA_STD p fda_acc svm_acc FDA_acc_all SVM_acc_all hvg_feat
end

save(['GS_GmdRQA_feat_emb=' num2str(emb1) '_tau=' num2str(tau1) '.mat'],'feat')

toc
