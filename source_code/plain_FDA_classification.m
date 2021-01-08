load('GS_DATA.mat')
load('DATA','label')

zscor_xnan = @(x) bsxfun(@rdivide, bsxfun(@minus, x, mean(x,'omitnan')), std(x, 'omitnan'));

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

clear feat feature_mat
