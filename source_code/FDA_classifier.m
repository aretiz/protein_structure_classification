
% A plain FDA

load('DATA','label')

zscor_xnan = @(x) bsxfun(@rdivide, bsxfun(@minus, x, mean(x,'omitnan')), std(x, 'omitnan'));
feature_mat = feat;
feature_mat = zscor_xnan(feature_mat);

for i = 1:150
    
    percent = 0.7;
    index = floor(percent*size(feature_mat,1));
    
    rand_pos = randperm(length(feature_mat));
    feature_mat = feature_mat(rand_pos',:);
    label = label(rand_pos);
    
    train_mat   = feature_mat(1:index,:);
    train_label = label(1:index)';
    test_mat    = feature_mat(index+1:end,:);
    true_label  = label(index+1:end)';
    
    MdlLinear = fitcdiscr(train_mat,train_label);
    estim = predict(MdlLinear,test_mat);
    
    statscm = confusionmatStats(true_label,estim);
    acc(i) = statscm.Overall_Accuracy;
    
    clearvars -except feat feature_mat label acc svm_acc_p svm_std_p fda_acc_p fda_std_p SVM_ACC SVM_STD FDA_ACC FDA_STD perc p emb1 emb2 tau1 tau2 fda_acc svm_acc FDA_acc_all SVM_acc_all
end
