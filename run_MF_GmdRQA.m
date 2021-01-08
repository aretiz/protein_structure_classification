clear all


load('DATA.mat')

% percentages
p = [0.01 0.05 0.1 0.2 0.3 0.4 0.5];

%find the most frequent value of m and tau
[emb1,tau1] = find_mode_m_t_GmdRQA(data);

% save the final results for each percentage and classifier
svm_acc_p = [];
svm_std_p = [];
fda_acc_p = [];
fda_std_p = [];

for k = 1:size(p,2)
    perc = p(k);

    % run MF-GmdRQA
    MF_GmdRQA

    % SVM classification
    SVM_classifier
    SVM_ACC = mean(acc);
    SVM_STD = std(acc);
    fprintf('The average classification accuracy of MF-GmdRQA for SVM and p=%f is %f with STD %f.\n',perc,SVM_ACC,SVM_STD);
    svm_acc_p = [svm_acc_p SVM_ACC];
    svm_std_p = [svm_std_p SVM_STD];

    % FDA classification
    FDA_classifier
    FDA_ACC = mean(acc);
    FDA_STD = std(acc);
    fprintf('The average classification accuracy of MF-GmdRQA for FDA and p=%f is %f with STD %f.\n',perc,FDA_ACC,FDA_STD);
    fda_acc_p = [fda_acc_p FDA_ACC];
    fda_std_p = [fda_std_p FDA_STD];
end

save(['MF_GmdRQA_SVM_perc_acc.mat'],'svm_acc_p')
save(['MF_GmdRQA_SVM_perc_std.mat'],'svm_std_p')

save(['MF_GmdRQA_FDA_perc_acc.mat'],'fda_acc_p')
save(['MF_GmdRQA_FDA_perc_std.mat'],'fda_std_p')