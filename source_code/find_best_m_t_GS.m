clear all

load('GS_RQA_FDA.mat')

for i = 1:10
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


%%
clear
% clc
load('GS_RQA_SVM.mat')

for i = 1:10
    temp = SVM_acc_all{i};
    [M,I] = max(temp(:));
    [I_row, I_col] = ind2sub(size(temp),I);
    
    best_m = I_row+1;
    best_t = I_col;
%     fprintf('The optimal pair for GS-RQA with SVM is (m,t)=(%d,%d).\n',best_m, best_t);
    xx{1,i} = ['(' num2str(best_m) ',' num2str(best_t) ')']; 
end

[yy,~,i] = unique(xx,'stable');
count = accumarray(i(:),1,[numel(yy),1])';
best = yy(find(count==max(count)));

fprintf('The optimal pair for GS-RQA with SVM is (m,t)=%s.\n', best{1});

%%
clear all
% clc
load('GS_GmdRQA_FDA.mat')

for i = 1:10
    temp = FDA_acc_all{i};
    [M,I] = max(temp(:));
    [I_row, I_col] = ind2sub(size(temp),I);
    
    best_m = I_row+1;
    best_t = I_col;
%     fprintf('The optimal pair for GS-GmdRQA with FDA is (m,t)=(%d,%d).\n',best_m, best_t);
    xx{1,i} = ['(' num2str(best_m) ',' num2str(best_t) ')']; 
end

[yy,~,i] = unique(xx,'stable');
count = accumarray(i(:),1,[numel(yy),1])';
best = yy(find(count==max(count)));

fprintf('The optimal pair for GS-GmdRQA with FDA is (m,t)=%s.\n', best{1});
%%
clear
% clc
load('GS_GmdRQA_SVM.mat')

for i = 1:10
    temp = SVM_acc_all{i};
    [M,I] = max(temp(:));
    [I_row, I_col] = ind2sub(size(temp),I);
    
    best_m = I_row+1;
    best_t = I_col;
%     fprintf('The optimal pair for GS-GmdRQA with SVM is (m,t)=(%d,%d).\n',best_m, best_t);
    xx{1,i} = ['(' num2str(best_m) ',' num2str(best_t) ')']; 
end

[yy,~,i] = unique(xx,'stable');
count = accumarray(i(:),1,[numel(yy),1])';
best = yy(find(count==max(count)));

fprintf('The optimal pair for GS-GmdRQA with SVM is (m,t)=%s.\n', best{1});
