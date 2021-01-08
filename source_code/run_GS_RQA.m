%GS-RQA
clear all

emb = [2 3 4 5 6 7 8];
tau = [1 2 3 4 5 6 7 8];
%%
perc = 0.3; % fix a percentage

for jj = 1:7
    for kk = 1:8
        if jj==7 && kk==8
        else
            emb1 = emb(jj);
            tau1 = tau(kk);
            fprintf('Testing pair (m,t)=(%d,%d).\n',emb1,tau1);
            GS_RQA
        end
    end
end

for ind = 1:30
    fda_acc = [];
    svm_acc = [];
    for jj =1:7
        fda_acc_p = [];
        svm_acc_p = [];
        for kk = 1:8
            if jj==7 && kk==8
                fda_acc_p = [fda_acc_p 0];
                svm_acc_p = [svm_acc_p 0];
            else
                emb1 = emb(jj);
                tau1 = tau(kk);
                folder2load = ['GS_RQA_feat_emb=' num2str(emb1) '_tau=' num2str(tau1) '.mat'];
                load(folder2load)
                plain_FDA_classification
                FDA_ACC = acc;
                %                 fprintf('The classification accuracy of GS-RQA for FDA is %f.\n',FDA_ACC);
                folder2load = ['GS_RQA_feat_emb=' num2str(emb1) '_tau=' num2str(tau1) '.mat'];
                load(folder2load)
                
                fda_acc_p = [fda_acc_p FDA_ACC];
                plain_SVM_classification
                SVM_ACC = acc;
                %                 fprintf('The classification accuracy of GS-RQA for SVM is %f.\n',SVM_ACC);
                svm_acc_p = [svm_acc_p SVM_ACC];
            end
        end
        fda_acc = [fda_acc; fda_acc_p];
        svm_acc = [svm_acc; svm_acc_p];
    end
    FDA_acc_all{ind} = fda_acc;
    SVM_acc_all{ind} = svm_acc;
end
save(['GS_RQA_SVM.mat'],'SVM_acc_all')
save(['GS_RQA_FDA.mat'],'FDA_acc_all')

%% percentages
p = [0.01 0.05 0.1 0.2 0.3 0.4 0.5];

% save the final results for each percentage and classifier
fda_acc_p = [];
fda_std_p = [];

% best m and t for FDA 
emb1 = 4;
emb2 = 4;
tau1 = 1;
tau2 = 1;

for k = 1:size(p,2)
    perc = p(k);
    
    % run GS-RQA with specific m and t that is the same as MF-RQA 
    MF_RQA
    
    % FDA classification
    FDA_classifier
    FDA_ACC = mean(acc);
    FDA_STD = std(acc);
    fprintf('The average classification accuracy of GS-RQA for FDA and p=%f is %f with STD %f.\n',perc,FDA_ACC,FDA_STD);
    fda_acc_p = [fda_acc_p FDA_ACC];
    fda_std_p = [fda_std_p FDA_STD];
end

save(['GS_RQA_FDA_perc_acc.mat'],'fda_acc_p')
save(['GS_RQA_FDA_perc_std.mat'],'fda_std_p')

% save the final results for each percentage and classifier
svm_acc_p = [];
svm_std_p = [];

% best m and t for SVM 
emb1 = 2;
emb2 = 2;
tau1 = 4;
tau2 = 4;

for k = 1:size(p,2)
    perc = p(k);
    
    % run GS-RQA with specific m and t that is the same as MF-RQA 
    MF_RQA
    
    % SVM classification
    SVM_classifier
    SVM_ACC = mean(acc);
    SVM_STD = std(acc);
    fprintf('The average classification accuracy of GS-RQA for SVM and p=%f is %f with STD %f.\n',perc,SVM_ACC,SVM_STD);
    svm_acc_p = [svm_acc_p SVM_ACC];
    svm_std_p = [svm_std_p SVM_STD]; 
end

save(['GS_RQA_SVM_perc_acc.mat'],'svm_acc_p')
save(['GS_RQA_SVM_perc_std.mat'],'svm_std_p')


