clear all 

%% run HVG
HVG
hvg_feat = feature_mat;
save(['hvg_feat.mat'],'hvg_feat')

%% HVG & GS-RQA
emb1 = 4;
emb2 = 4;
tau1 = 1;
tau2 = 1;

perc = 0.3;

MF_RQA
load('hvg_feat.mat')
feat = [feat hvg_feat];
FDA_classifier
fprintf('The classification accuracy of GS-RQA and HVG for FDA is %f.\n',mean(acc));
clear feat

emb1 = 2;
emb2 = 2;
tau1 = 4;
tau2 = 4;

perc = 0.3;

MF_RQA
load('hvg_feat.mat')
feat = [feat hvg_feat];
SVM_classifier
fprintf('The classification accuracy of GS-RQA and HVG for SVM is %f.\n',mean(acc));
clear feat
%% HVG & GS-GmdRQA
emb1 = 2;
tau1 = 4;

perc = 0.3;

MF_GmdRQA

load('hvg_feat.mat')
feat = [feat hvg_feat];
FDA_classifier
fprintf('The classification accuracy of GS-GmdRQA and HVG for FDA is %f.\n',mean(acc));
clear all_feat

emb1 = 5;
tau1 = 1;

perc = 0.3;

MF_GmdRQA

load('hvg_feat.mat')
feat = [feat hvg_feat];
SVM_classifier
fprintf('The classification accuracy of GS-GmdRQA and HVG for SVM is %f.\n',mean(acc));
clear all_feat
%% HVG & DD-RQA
perc = 0.3;
DD_RQA
load('hvg_feat.mat')
feat = [feat hvg_feat];
FDA_classifier
fprintf('The classification accuracy of DD-RQA and HVG for FDA is %f.\n',mean(acc));
SVM_classifier
fprintf('The classification accuracy of DD-RQA and HVG for SVM is %f.\n',mean(acc));

clear feat

%% HVG & DD-GmdRQA
perc = 0.3;
DD_GmdRQA
load('hvg_feat.mat')
feat = [feat hvg_feat];
FDA_classifier
fprintf('The classification accuracy of DD-GmdRQA and HVG for FDA is %f.\n',mean(acc));
SVM_classifier
fprintf('The classification accuracy of DD-GmdRQA and HVG for SVM is %f.\n',mean(acc));

clear feat

%% HVG & MF-RQA
load('DATA.mat')
[emb1,emb2,tau1,tau2] = find_mode_m_t_RQA(data);
perc = 0.3;
MF_RQA
load('hvg_feat.mat')
feat = [feat hvg_feat];
FDA_classifier
fprintf('The classification accuracy of MF-RQA and HVG for FDA is %f.\n',mean(acc));
SVM_classifier
fprintf('The classification accuracy of MF-RQA and HVG for SVM is %f.\n',mean(acc));

clear feat

%% HVG & MF-GmdRQA
load('DATA.mat')
[emb1,tau1] = find_mode_m_t_GmdRQA(data);

perc = 0.3;
MF_RQA
load('hvg_feat.mat')
feat = [feat hvg_feat];
FDA_classifier
fprintf('The classification accuracy of MF-GmdRQA and HVG for FDA is %f.\n',mean(acc));
SVM_classifier
fprintf('The classification accuracy of MF-GmdRQA and HVG for SVM is %f.\n',mean(acc));
