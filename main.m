clear all 
clc

%% 
fprintf('-------------------------- GS-RQA --------------------------------------\n');
run_GS_RQA

%%
fprintf('-------------------------- GS-GmdRQA --------------------------------------\n');
run_GS_GmdRQA

%%
fprintf('-------------------------- DD-RQA --------------------------------------\n');
run_DD_RQA

%%
fprintf('-------------------------- DD-GmdRQA --------------------------------------\n');
run_DD_GmdRQA

%%
fprintf('-------------------------- MF-RQA --------------------------------------\n');
run_MF_RQA

%%
fprintf('-------------------------- MF-GmdRQA --------------------------------------\n');
run_MF_GmdRQA

%% 
fprintf('-------------------------- RQA and HVG --------------------------------------\n');
HVG_and_RQA