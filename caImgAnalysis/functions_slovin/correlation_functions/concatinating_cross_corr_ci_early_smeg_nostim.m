%% SMEAGOL 27:35


cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\b\no_stim
load crv_circle_cond1_27_35
load crv_circle_cond2_27_35
load crv_circle_cond4_27_35
load crv_circle_cond5_27_35
crv_cont_circ=mean(crv_cond1,1)';
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=mean(crv_cond4,1)';
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\c\no_stim
load crv_circle_cond1_27_35
load crv_circle_cond2_27_35
load crv_circle_cond4_27_35
load crv_circle_cond5_27_35
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\g\no_stim
load crv_circle_cond1_27_35
load crv_circle_cond2_27_35
load crv_circle_cond4_27_35
load crv_circle_cond5_27_35
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\b\no_stim
load crv_circle_cond1_27_35
load crv_circle_cond2_27_35
load crv_circle_cond4_27_35
load crv_circle_cond5_27_35
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\d\no_stim
load crv_circle_cond1_27_35
load crv_circle_cond2_27_35
load crv_circle_cond4_27_35
load crv_circle_cond5_27_35
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\f\no_stim
load crv_circle_cond1_27_35
load crv_circle_cond2_27_35
load crv_circle_cond4_27_35
load crv_circle_cond5_27_35
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\b\no_stim
load crv_circle_cond1_27_35
load crv_circle_cond2_27_35
load crv_circle_cond4_27_35
load crv_circle_cond5_27_35
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\c\no_stim
load crv_circle_cond1_27_35
load crv_circle_cond5_27_35
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

 


cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\d\no_stim
load crv_circle_cond1_27_35
load crv_circle_cond5_27_35
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\e\no_stim
load crv_circle_cond1_27_35
load crv_circle_cond5_27_35
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\b\no_stim
load crv_circle_cond1_27_35
load crv_circle_cond2_27_35
load crv_circle_cond4_27_35
load crv_circle_cond5_27_35
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\c\no_stim
load crv_circle_cond1_27_35
load crv_circle_cond5_27_35
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\d\no_stim
load crv_circle_cond1_27_35
load crv_circle_cond5_27_35
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\b\no_stim
load crv_circle_cond1_27_35
load crv_circle_cond2_27_35
load crv_circle_cond4_27_35
load crv_circle_cond5_27_35
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c\no_stim
load crv_circle_cond1_27_35
load crv_circle_cond2_27_35
load crv_circle_cond4_27_35
load crv_circle_cond5_27_35
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\d\no_stim
load crv_circle_cond1_27_35
load crv_circle_cond2_27_35
load crv_circle_cond4_27_35
load crv_circle_cond5_27_35
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\e\no_stim
load crv_circle_cond1_27_35
load crv_circle_cond2_27_35
load crv_circle_cond4_27_35
load crv_circle_cond5_27_35
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\k\no_stim
load crv_circle_cond1_27_35
load crv_circle_cond2_27_35
load crv_circle_cond4_27_35
load crv_circle_cond5_27_35
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\b\no_stim
load crv_circle_cond1_27_35
load crv_circle_cond2_27_35
load crv_circle_cond4_27_35
load crv_circle_cond5_27_35
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\c\no_stim
load crv_circle_cond1_27_35
load crv_circle_cond5_27_35
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\d\no_stim
load crv_circle_cond1_27_35
load crv_circle_cond5_27_35
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5

cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\e\no_stim
load crv_circle_cond1_27_35
load crv_circle_cond2_27_35
load crv_circle_cond4_27_35
load crv_circle_cond5_27_35
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond1,1)');
crv_cont_circ=cat(2,crv_cont_circ,mean(crv_cond2,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond4,1)');
crv_non_circ=cat(2,crv_non_circ,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond2
clear crv_cond4
clear crv_cond5

%% SMEAGOL 30:38


cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\b\no_stim

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



cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\c\no_stim

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


cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\g\no_stim

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



cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\b\no_stim


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


cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\d\no_stim

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


cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\f\no_stim

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

cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\b\no_stim

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


cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\c\no_stim


load crv_bg_in_cond1_30_38
load crv_bg_in_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\d\no_stim


load crv_bg_in_cond1_30_38
load crv_bg_in_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\e\no_stim

load crv_bg_in_cond1_30_38
load crv_bg_in_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\b\no_stim

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


cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\c\no_stim

load crv_bg_in_cond1_30_38
load crv_bg_in_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\d\no_stim

load crv_bg_in_cond1_30_38
load crv_bg_in_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5




cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\b\no_stim

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



cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c\no_stim

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


cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\d\no_stim

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


cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\e\no_stim


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


cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\k\no_stim

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


cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\b\no_stim

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


cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\c\no_stim


load crv_bg_out_cond1_30_38
load crv_bg_out_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5


cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\d\no_stim

load crv_bg_out_cond1_30_38
load crv_bg_out_cond5_30_38
crv_cont_bg=cat(2,crv_cont_bg,mean(crv_cond1,1)');
crv_non_bg=cat(2,crv_non_bg,mean(crv_cond5,1)');
clear crv_cond1
clear crv_cond5



cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\e\no_stim


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
figure;errorbar(t,mean(crv_cont_circ(:,ses1_smeg),2),std(crv_cont_circ(:,ses1_smeg),0,2)/sqrt(size(crv_cont_circ(:,ses1_smeg),2)))
hold on
errorbar(t,mean(crv_non_circ(:,ses1_smeg),2),std(crv_non_circ(:,ses1_smeg),0,2)/sqrt(size(crv_non_circ(:,ses1_smeg),2)),'r')

figure;errorbar(t,mean(crv_cont_bg(:,ses1_smeg),2),std(crv_cont_bg(:,ses1_smeg),0,2)/sqrt(size(crv_cont_bg(:,ses1_smeg),2)))
hold on
errorbar(t,mean(crv_non_bg(:,ses1_smeg),2),std(crv_non_bg(:,ses1_smeg),0,2)/sqrt(size(crv_non_bg(:,ses1_smeg),2)),'r')

diff_circ=crv_cont_circ-crv_non_circ;
diff_bg=crv_cont_bg-crv_non_bg;
figure;errorbar(t,mean(diff_circ(:,ses1_smeg),2),std(diff_circ(:,ses1_smeg),0,2)/sqrt(size(diff_circ(:,ses1_smeg),2)))
hold on
errorbar(t,mean(diff_bg(:,ses1_smeg),2),std(diff_bg(:,ses1_smeg),0,2)/sqrt(size(diff_bg(:,ses1_smeg),2)),'r')
plot(t,zeros(1,17),'k')
xlim([-80 80])
ylim([-0.02 0.04])

signrank(mean(diff_circ(13:18,ses1_smeg),1))
signrank(mean(diff_bg(13:18,ses1_smeg),1))

signrank(mean(diff_circ(3:8,ses1_smeg),1))
signrank(mean(diff_bg(3:8,ses1_smeg),1))

signrank(mean(diff_circ(25:29,ses1_smeg),1))
signrank(mean(diff_bg(25:29,ses1_smeg),1))


diff=diff_circ-diff_bg;
figure;errorbar(t,mean(diff(:,ses1_smeg),2),std(diff(:,ses1_smeg),0,2)/sqrt(size(diff(:,ses1_smeg),2)))
hold on
plot(t,zeros(1,31),'k')
xlim([-80 80])

signrank(mean(diff(13:18,ses1_smeg),1))
signrank(mean(diff(3:8,ses1_smeg),1))
signrank(mean(diff(25:29,ses1_smeg),1))


figure;plot(t,mean(crv_cont_circ(:,ses1_smeg),2))
hold on
plot(t,mean(crv_non_circ(:,ses1_smeg),2),'r')
ylim([-0.3 0.5])
figure;plot(t,mean(crv_cont_bg(:,ses1_smeg),2))
hold on
plot(t,mean(crv_non_bg(:,ses1_smeg),2),'r')
ylim([-0.3 0.5])
