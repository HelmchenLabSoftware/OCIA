cd F:\Data\VSDI\collinear\three_flankers\legolas\2007_04_18\no_stim\way2
load('AUC_trialwise_different_measures.mat')
n=1;
AUC_pow2(n)=AUC_pow;
AUC_maxamp2(n)=AUC_maxamp;
AUC_maxder2(n)=AUC_maxder;
AUC_ttp2(n)=AUC_ttp;
AUC_beta2(n)=AUC_beta;
AUC_gamma2(n)=AUC_gamma;

cd F:\Data\VSDI\collinear\three_flankers\legolas\2007_03_12\conds_ns
load('AUC_trialwise_different_measures.mat')
n=2;
AUC_pow2(n)=AUC_pow;
AUC_maxamp2(n)=AUC_maxamp;
AUC_maxder2(n)=AUC_maxder;
AUC_ttp2(n)=AUC_ttp;
AUC_beta2(n)=AUC_beta;
AUC_gamma2(n)=AUC_gamma;

cd F:\Data\VSDI\collinear\three_flankers\legolas\2007_05_10\b\no_stim\way2
load('AUC_trialwise_different_measures.mat')
n=3;
AUC_pow2(n)=AUC_pow;
AUC_maxamp2(n)=AUC_maxamp;
AUC_maxder2(n)=AUC_maxder;
AUC_ttp2(n)=AUC_ttp;
AUC_beta2(n)=AUC_beta;
AUC_gamma2(n)=AUC_gamma;

cd F:\Data\VSDI\collinear\three_flankers\legolas\2007_05_10\e\no_stim\way2
load('AUC_trialwise_different_measures.mat')
n=4;
AUC_pow2(n)=AUC_pow;
AUC_maxamp2(n)=AUC_maxamp;
AUC_maxder2(n)=AUC_maxder;
AUC_ttp2(n)=AUC_ttp;
AUC_beta2(n)=AUC_beta;
AUC_gamma2(n)=AUC_gamma;

cd F:\Data\VSDI\collinear\three_flankers\aragon\2007_11_20\no_stim\way2
load('AUC_trialwise_different_measures.mat')
n=5;
AUC_pow2(n)=AUC_pow;
AUC_maxamp2(n)=AUC_maxamp;
AUC_maxder2(n)=AUC_maxder;
AUC_ttp2(n)=AUC_ttp;
AUC_beta2(n)=AUC_beta;
AUC_gamma2(n)=AUC_gamma;

cd F:\Data\VSDI\collinear\one_flanker\legolas\2007_01_31\no_stim
load('AUC_trialwise_different_measures.mat')
n=6;
AUC_pow2(n)=AUC_pow;
AUC_maxamp2(n)=AUC_maxamp;
AUC_maxder2(n)=AUC_maxder;
AUC_ttp2(n)=AUC_ttp;
AUC_beta2(n)=AUC_beta;
AUC_gamma2(n)=AUC_gamma;

cd F:\Data\VSDI\collinear\one_flanker\legolas\2007_02_07\no_stim
load('AUC_trialwise_different_measures.mat')
n=7;
AUC_pow2(n)=AUC_pow;
AUC_maxamp2(n)=AUC_maxamp;
AUC_maxder2(n)=AUC_maxder;
AUC_ttp2(n)=AUC_ttp;
AUC_beta2(n)=AUC_beta;
AUC_gamma2(n)=AUC_gamma;

cd F:\Data\VSDI\collinear\one_flanker\aragon\2007_11_20\no_stim
load('AUC_trialwise_different_measures.mat')
n=8;
AUC_pow2(n)=AUC_pow;
AUC_maxamp2(n)=AUC_maxamp;
AUC_maxder2(n)=AUC_maxder;
AUC_ttp2(n)=AUC_ttp;
AUC_beta2(n)=AUC_beta;
AUC_gamma2(n)=AUC_gamma;



AUC=cat(1,AUC_pow2,AUC_beta2,AUC_gamma2,AUC_maxamp2,AUC_maxder2,AUC_ttp2);

figure;bar(mean(AUC,2))
hold on
errorbar(mean(AUC,2),std(AUC,0,2)/sqrt(8))
ylim([0.4 0.7])

ranksum(AUC_pow2,0.5*ones(1,8))*6
ranksum(AUC_beta2,0.5*ones(1,8))*6
ranksum(AUC_maxder2,0.5*ones(1,8))*6
ranksum(AUC_maxamp2,0.5*ones(1,8))*6
ranksum(AUC_ttp2,0.5*ones(1,8))*6

ranksum(AUC_pow2,AUC_beta2)*6
ranksum(AUC_pow2,AUC_gamma2)*6

ranksum(AUC_pow2,AUC_maxamp2)*6
ranksum(AUC_pow2,AUC_maxder2)*6
ranksum(AUC_pow2,AUC_ttp2)*6

ranksum(AUC_beta2,AUC_maxamp2)*6
ranksum(AUC_beta2,AUC_maxder2)*6
ranksum(AUC_beta2,AUC_ttp2)*6

ranksum(AUC_gamma2,0.5*ones(1,8))
ranksum(AUC_gamma2,AUC_maxamp2)*6
ranksum(AUC_gamma2,AUC_maxder2)*6
ranksum(AUC_gamma2,AUC_ttp2)*6











