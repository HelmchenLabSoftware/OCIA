%% SMEAGOL 30:38


cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\b

load crv_bg_in_cond1_30_38
load crv_bg_in_cond2_30_38
load crv_bg_in_cond4_30_38
load crv_bg_in_cond5_30_38
crv_cont_bg=mean(crv_cond1,1)';
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=mean(crv_cond4,1)';
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\c

load crv_bg_in_cond1_30_38
load crv_bg_in_cond2_30_38
load crv_bg_in_cond4_30_38
load crv_bg_in_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\g

load crv_bg_in_cond1_30_38
load crv_bg_in_cond2_30_38
load crv_bg_in_cond4_30_38
load crv_bg_in_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\b


load crv_bg_in_cond1_30_38
load crv_bg_in_cond2_30_38
load crv_bg_in_cond4_30_38
load crv_bg_in_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\d

load crv_bg_in_cond1_30_38
load crv_bg_in_cond2_30_38
load crv_bg_in_cond4_30_38
load crv_bg_in_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\f

load crv_bg_in_cond1_30_38
load crv_bg_in_cond2_30_38
load crv_bg_in_cond4_30_38
load crv_bg_in_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\b

load crv_bg_in_cond1_30_38
load crv_bg_in_cond2_30_38
load crv_bg_in_cond4_30_38
load crv_bg_in_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\c


load crv_bg_in_cond1_30_38
load crv_bg_in_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\d


load crv_bg_in_cond1_30_38
load crv_bg_in_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\e

load crv_bg_in_cond1_30_38
load crv_bg_in_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\b

load crv_bg_in_cond1_30_38
load crv_bg_in_cond2_30_38
load crv_bg_in_cond4_30_38
load crv_bg_in_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\c

load crv_bg_in_cond1_30_38
load crv_bg_in_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\d

load crv_bg_in_cond1_30_38
load crv_bg_in_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5




cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\b

load crv_bg_in_cond1_30_38
load crv_bg_in_cond2_30_38
load crv_bg_in_cond4_30_38
load crv_bg_in_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c

load crv_bg_out_cond1_30_38
load crv_bg_out_cond2_30_38
load crv_bg_out_cond4_30_38
load crv_bg_out_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\d

load crv_bg_in_cond1_30_38
load crv_bg_in_cond2_30_38
load crv_bg_in_cond4_30_38
load crv_bg_in_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\e


load crv_bg_out_cond1_30_38
load crv_bg_out_cond2_30_38
load crv_bg_out_cond4_30_38
load crv_bg_out_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\k

load crv_bg_out_cond1_30_38
load crv_bg_out_cond2_30_38
load crv_bg_out_cond4_30_38
load crv_bg_out_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\b

load crv_bg_out_cond1_30_38
load crv_bg_out_cond2_30_38
load crv_bg_out_cond4_30_38
load crv_bg_out_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\c


load crv_bg_out_cond1_30_38
load crv_bg_out_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\d

load crv_bg_out_cond1_30_38
load crv_bg_out_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\e


load crv_bg_in_cond1_30_38
load crv_bg_in_cond2_30_38
load crv_bg_in_cond4_30_38
load crv_bg_in_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond2,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond4,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


%%
t=-80:10:80;
figure;errorbar(t,mean(crv_cont_bg(:,ses1_smeg),2),std(crv_cont_bg(:,ses1_smeg),0,2)/sqrt(size(crv_cont_bg(:,ses1_smeg),2)))
hold on
errorbar(t,mean(crv_non_bg(:,ses1_smeg),2),std(crv_non_bg(:,ses1_smeg),0,2)/sqrt(size(crv_non_bg(:,ses1_smeg),2)),'r')

figure;errorbar(t,mean(crv_cont_bg(:,ses1_smeg),2),std(crv_cont_bg(:,ses1_smeg),0,2)/sqrt(size(crv_cont_bg(:,ses1_smeg),2)))
hold on
errorbar(t,mean(crv_non_bg(:,ses1_smeg),2),std(crv_non_bg(:,ses1_smeg),0,2)/sqrt(size(crv_non_bg(:,ses1_smeg),2)),'r')

diff_bg=crv_cont_bg-crv_non_bg;
figure;errorbar(t,mean(diff_bg(:,ses1_smeg),2),std(diff_bg(:,ses1_smeg),0,2)/sqrt(size(diff_bg(:,ses1_smeg),2)))
hold on
errorbar(t,mean(diff_bg(:,ses1_smeg),2),std(diff_bg(:,ses1_smeg),0,2)/sqrt(size(diff_bg(:,ses1_smeg),2)),'r')
plot(t,zeros(1,17),'k')
xlim([-80 80])

signrank(mean(diff_bg(2:4,ses1_smeg),1))
signrank(mean(diff_bg(8:10,ses1_smeg),1))
signrank(mean(diff_bg(14:16,ses1_smeg),1))



