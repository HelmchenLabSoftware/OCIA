
AUC_pow(1)=AUC_pow_1804;
AUC_pow(2)=AUC_pow_1203;
AUC_pow(3)=AUC_pow_1005b;
AUC_pow(4)=AUC_pow_1005e;
AUC_pow(5)=AUC_pow_2011p;
AUC_pow(6)=AUC_pow_3101;
AUC_pow(7)=AUC_pow_0207;
AUC_pow(8)=AUC_pow_2011c;


AUC_maxamp(1)=AUC_maxamp_1804;
AUC_maxamp(2)=AUC_maxamp_1203;
AUC_maxamp(3)=AUC_maxamp_1005b;
AUC_maxamp(4)=AUC_maxamp_1005e;
AUC_maxamp(5)=AUC_maxamp_2011p;
AUC_maxamp(6)=AUC_maxamp_3101;
AUC_maxamp(7)=AUC_maxamp_0207;
AUC_maxamp(8)=AUC_maxamp_2011c;



AUC_maxder(1)=AUC_maxder_1804;
AUC_maxder(2)=AUC_maxder_1203;
AUC_maxder(3)=AUC_maxder_1005b;
AUC_maxder(4)=AUC_maxder_1005e;
AUC_maxder(5)=AUC_maxder_2011p;
AUC_maxder(6)=AUC_maxder_3101;
AUC_maxder(7)=AUC_maxder_0207;
AUC_maxder(8)=AUC_maxder_2011c;



AUC_ttp(1)=AUC_ttp_1804;
AUC_ttp(2)=AUC_ttp_1203;
AUC_ttp(3)=AUC_ttp_1005b;
AUC_ttp(4)=AUC_ttp_1005e;
AUC_ttp(5)=AUC_ttp_2011p;
AUC_ttp(6)=AUC_ttp_3101;
AUC_ttp(7)=AUC_ttp_0207;
AUC_ttp(8)=AUC_ttp_2011c;


AUC_lat(1)=AUC_lat_1804;
AUC_lat(2)=AUC_lat_1203;
AUC_lat(3)=AUC_lat_1005b;
AUC_lat(4)=AUC_lat_1005e;
AUC_lat(5)=AUC_lat_2011p;
AUC_lat(6)=AUC_lat_3101;
AUC_lat(7)=AUC_lat_0207;
AUC_lat(8)=AUC_lat_2011c;



AUC_beta(1)=AUC_beta_1804;
AUC_beta(2)=AUC_beta_1203;
AUC_beta(3)=AUC_beta_1005b;
AUC_beta(4)=AUC_beta_1005e;
AUC_beta(5)=AUC_beta_2011p;
AUC_beta(6)=AUC_beta_3101;
AUC_beta(7)=AUC_beta_0702;
AUC_beta(8)=AUC_beta_2011c;

AUC_gamma(1)=AUC_gamma_1804;
AUC_gamma(2)=AUC_gamma_1203;
AUC_gamma(3)=AUC_gamma_1005b;
AUC_gamma(4)=AUC_gamma_1005e;
AUC_gamma(5)=AUC_gamma_2011p;
AUC_gamma(6)=AUC_gamma_3101;
AUC_gamma(7)=AUC_gamma_0702;
AUC_gamma(8)=AUC_gamma_2011c;

AUC=cat(1,AUC_pow,AUC_beta,AUC_gamma,AUC_maxamp,AUC_maxder,AUC_ttp);

figure;bar(mean(AUC,2))
hold on
errorbar(mean(AUC,2),std(AUC,0,2)/sqrt(8))
ylim([0.4 0.85])

ranksum(AUC_pow,AUC_beta)*6
ranksum(AUC_pow,AUC_gamma)*6

ranksum(AUC_pow,AUC_maxamp)*6
ranksum(AUC_pow,AUC_maxder)*6
ranksum(AUC_pow,AUC_ttp)*6

ranksum(AUC_beta,AUC_maxamp)*6
ranksum(AUC_beta,AUC_maxder)*6
ranksum(AUC_beta,AUC_ttp)*6

ranksum(AUC_gamma,0.5*ones(1,8))
ranksum(AUC_gamma,AUC_maxamp)*6
ranksum(AUC_gamma,AUC_maxder)*6
ranksum(AUC_gamma,AUC_ttp)*6

































