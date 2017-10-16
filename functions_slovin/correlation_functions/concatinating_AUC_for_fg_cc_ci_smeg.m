cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c
load AUC_cc_fg_early_late
AUC_fg_cc_early(1)=AUC14_early;
AUC_fg_cc_early(2)=AUC25_early;

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\e
load AUC_cc_fg_early_late
AUC_fg_cc_early(3)=AUC14_early;
AUC_fg_cc_early(4)=AUC25_early;

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\k
load AUC_cc_fg_early_late
AUC_fg_cc_early(5)=AUC14_early;
AUC_fg_cc_early(6)=AUC25_early;

cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\b
load AUC_cc_fg_early_late
AUC_fg_cc_early(7)=AUC14_early;
AUC_fg_cc_early(8)=AUC25_early;

cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\c
load AUC_cc_fg_early_late
AUC_fg_cc_early(9)=AUC15_early;

cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\d
load AUC_cc_fg_early_late
AUC_fg_cc_early(10)=AUC15_early;

mean(AUC_fg_cc_early)

%%
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c
load AUC_cc_fg_early_late
AUC_fg_cc_late(1)=AUC14_late;
AUC_fg_cc_late(2)=AUC25_late;

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\e
load AUC_cc_fg_early_late
AUC_fg_cc_late(3)=AUC14_late;
AUC_fg_cc_late(4)=AUC25_late;

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\k
load AUC_cc_fg_early_late
AUC_fg_cc_late(5)=AUC14_late;
AUC_fg_cc_late(6)=AUC25_late;

cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\b
load AUC_cc_fg_early_late
AUC_fg_cc_late(7)=AUC14_late;
AUC_fg_cc_late(8)=AUC25_late;

cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\c
load AUC_cc_fg_early_late
AUC_fg_cc_late(9)=AUC15_late;

cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\d
load AUC_cc_fg_early_late
AUC_fg_cc_late(10)=AUC15_late;

mean(AUC_fg_cc_late)
