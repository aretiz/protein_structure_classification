%% GS-RQA
clear all
clc

zscor_xnan = @(x) bsxfun(@rdivide, bsxfun(@minus, x, mean(x,'omitnan')), std(x, 'omitnan'));

emb = [2 3 4 5 6 7 8];
tau = [1 2 3 4 5 6 7 8];

for i = 1:30
    rand_indx(:,i) = randperm(1673);
end

for ind = 1:size(rand_indx,2)
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
                load('DATA','label')
                
                feature_mat = zscor_xnan(feat);
                
                percent = 0.7;
                index = floor(percent*size(feature_mat,1));
                
                rand_pos = rand_indx(:,ind);
                feature_mat = feature_mat(rand_pos,:);
                label = label(rand_pos);
                
                train_mat   = feature_mat(1:index,:);
                train_label = label(1:index)';
                test_mat    = feature_mat(index+1:end,:);
                true_label  = label(index+1:end)';
                
                MdlLinear = fitcdiscr(train_mat,train_label);
                estim = predict(MdlLinear,test_mat);
                
                statscm = confusionmatStats(true_label,estim);
                acc = statscm.Overall_Accuracy;
                FDA_ACC = acc;
                clear feat feature_mat
                
                %                 fprintf('The classification accuracy of GS-RQA for FDA is %f.\n',FDA_ACC);
                folder2load = ['GS_RQA_feat_emb=' num2str(emb1) '_tau=' num2str(tau1) '.mat'];
                load(folder2load)
                
                fda_acc_p = [fda_acc_p FDA_ACC];
                load('DATA','label')
                
                feature_mat = zscor_xnan(feat);
                
                percent = 0.7;
                index = floor(percent*size(feature_mat,1));
                
                rand_pos = rand_indx(:,ind);
                feature_mat = feature_mat(rand_pos,:);
                label = label(rand_pos);
                
                train_mat   = feature_mat(1:index,:);
                train_label = label(1:index)';
                test_mat    = feature_mat(index+1:end,:);
                true_label  = label(index+1:end)';
                
                t = templateSVM('KernelFunction','rbf','KernelScale','auto','Standardize', false);
                SVMModel = fitcecoc(train_mat,train_label,'Learners', t,'FitPosterior',false,'Coding','onevsone');
                
                [estim,~] = predict(SVMModel,test_mat);
                
                statscm = confusionmatStats(true_label,estim);
                acc = statscm.Overall_Accuracy;
                
                clear feat feature_mat
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


for i = 1:size(rand_indx,2)
    temp = FDA_acc_all{i};
    [M,I] = max(temp(:));
    [I_row, I_col] = ind2sub(size(temp),I);
    
    best_m = I_row+1;
    best_t = I_col;
%     fprintf('The optimal pair for GS-RQA with FDA is (m,t)=(%d,%d).\n',best_m, best_t);
    xx{1,i} = ['(' num2str(best_m) ',' num2str(best_t) ')']; 
end

[yy,~,i] = unique(xx,'stable');
count = accumarray(i(:),1,[numel(yy),1])';
best = yy(find(count==max(count)));

fprintf('The optimal pair for GS-RQA with FDA is (m,t)=%s.\n', best{1});

for i = 1:size(rand_indx,2)
    temp = SVM_acc_all{i};
    [M,I] = max(temp(:));
    [I_row, I_col] = ind2sub(size(temp),I);
    
    best_m = I_row+1;
    best_t = I_col;
    xx{1,i} = ['(' num2str(best_m) ',' num2str(best_t) ')']; 
end

[yy,~,i] = unique(xx,'stable');
count = accumarray(i(:),1,[numel(yy),1])';
best = yy(find(count==max(count)));

fprintf('The optimal pair for GS-RQA with SVM is (m,t)=%s.\n', best{1});

%% GS-GmdRQA
clear all
% clc

zscor_xnan = @(x) bsxfun(@rdivide, bsxfun(@minus, x, mean(x,'omitnan')), std(x, 'omitnan'));

emb = [2 3 4 5 6 7 8];
tau = [1 2 3 4 5 6 7 8];

for i = 1:30
    rand_indx(:,i) = randperm(1673);
end

for ind = 1:size(rand_indx,2)
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
                folder2load = ['GS_GmdRQA_feat_emb=' num2str(emb1) '_tau=' num2str(tau1) '.mat'];
                load(folder2load)
                load('DATA','label')
                
                feature_mat = zscor_xnan(feat);
                
                percent = 0.7;
                index = floor(percent*size(feature_mat,1));
                
                rand_pos = rand_indx(:,ind);
                feature_mat = feature_mat(rand_pos,:);
                label = label(rand_pos);
                
                train_mat   = feature_mat(1:index,:);
                train_label = label(1:index)';
                test_mat    = feature_mat(index+1:end,:);
                true_label  = label(index+1:end)';
                
                MdlLinear = fitcdiscr(train_mat,train_label);
                estim = predict(MdlLinear,test_mat);
                
                statscm = confusionmatStats(true_label,estim);
                acc = statscm.Overall_Accuracy;
                FDA_ACC = acc;
                clear feat feature_mat
                
                folder2load = ['GS_GmdRQA_feat_emb=' num2str(emb1) '_tau=' num2str(tau1) '.mat'];
                load(folder2load)
                
                fda_acc_p = [fda_acc_p FDA_ACC];
                load('DATA','label')
                
                feature_mat = zscor_xnan(feat);
                
                percent = 0.7;
                index = floor(percent*size(feature_mat,1));
                
                rand_pos = rand_indx(:,ind);
                feature_mat = feature_mat(rand_pos,:);
                label = label(rand_pos);
                
                train_mat   = feature_mat(1:index,:);
                train_label = label(1:index)';
                test_mat    = feature_mat(index+1:end,:);
                true_label  = label(index+1:end)';
                
                t = templateSVM('KernelFunction','rbf','KernelScale','auto','Standardize', false);
                SVMModel = fitcecoc(train_mat,train_label,'Learners', t,'FitPosterior',false,'Coding','onevsone');
                
                [estim,~] = predict(SVMModel,test_mat);
                
                statscm = confusionmatStats(true_label,estim);
                acc = statscm.Overall_Accuracy;
                
                clear feat feature_mat
                SVM_ACC = acc;
                svm_acc_p = [svm_acc_p SVM_ACC];
            end
        end
        fda_acc = [fda_acc; fda_acc_p];
        svm_acc = [svm_acc; svm_acc_p];
    end
    FDA_acc_all{ind} = fda_acc;
    SVM_acc_all{ind} = svm_acc;
end


for i = 1:size(rand_indx,2)
    temp = FDA_acc_all{i};
    [M,I] = max(temp(:));
    [I_row, I_col] = ind2sub(size(temp),I);
    
    best_m = I_row+1;
    best_t = I_col;
%     fprintf('The optimal pair for GS-RQA with FDA is (m,t)=(%d,%d).\n',best_m, best_t);
    xx{1,i} = ['(' num2str(best_m) ',' num2str(best_t) ')']; 
end

[yy,~,i] = unique(xx,'stable');
count = accumarray(i(:),1,[numel(yy),1])';
best = yy(find(count==max(count)));

fprintf('The optimal pair for GS-GmdRQA with FDA is (m,t)=%s.\n', best{1});

for i = 1:size(rand_indx,2)
    temp = SVM_acc_all{i};
    [M,I] = max(temp(:));
    [I_row, I_col] = ind2sub(size(temp),I);
    
    best_m = I_row+1;
    best_t = I_col;
    xx{1,i} = ['(' num2str(best_m) ',' num2str(best_t) ')']; 
end

[yy,~,i] = unique(xx,'stable');
count = accumarray(i(:),1,[numel(yy),1])';
best = yy(find(count==max(count)));

fprintf('The optimal pair for GS-GmdRQA with SVM is (m,t)=%s.\n', best{1});
