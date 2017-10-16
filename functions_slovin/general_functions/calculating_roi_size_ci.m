%% LEGOLAS

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new
load('myrois.mat', 'roi_maskin_narrow', 'roi_contour2')
circ_size_leg(1:4)=size(roi_contour2,1);
bg_size_leg(1:4)=size(roi_maskin_narrow,1);

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\c\correct_and_incorrect_together
load('myrois.mat', 'roi_bg_in_narrow', 'roi_circle_diff')
circ_size_leg(5)=size(roi_contour2,1);
bg_size_leg(5)=size(roi_bg_in_narrow,1);

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\d\correct_and_incorrect_together
load('myrois.mat', 'roi_bg_in_narrow', 'roi_circle_diff')
circ_size_leg(6)=size(roi_circle_diff,1);
bg_size_leg(6)=size(roi_bg_in_narrow,1);

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\e\correct_and_incorrect_together
load('myrois.mat', 'roi_bg_in_narrow', 'roi_circle_diff')
circ_size_leg(7)=size(roi_circle_diff,1);
bg_size_leg(7)=size(roi_bg_in_narrow,1);

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together
load('myrois.mat', 'roi_bg_in_narrow', 'roi_circle_diff')
circ_size_leg(8)=size(roi_circle_diff,1);
bg_size_leg(8)=size(roi_bg_in_narrow,1);

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\e\correct_and_incorrect_together
load('myrois.mat', 'roi_bg_in_narrow', 'roi_circle_diff')
circ_size_leg(9)=size(roi_circle_diff,1);
bg_size_leg(9)=size(roi_bg_in_narrow,1);

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\f\correct_and_incorrect_together
load('myrois.mat', 'roi_bg_in_narrow', 'roi_circle_diff')
circ_size_leg(10)=size(roi_circle_diff,1);
bg_size_leg(10)=size(roi_bg_in_narrow,1);

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\d\correct_and_incorrect_together
load('myrois.mat', 'roi_bg_in_narrow', 'roi_circle_diff')
circ_size_leg(11)=size(roi_circle_diff,1);
bg_size_leg(11)=size(roi_bg_in_narrow,1);

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\e\correct_and_incorrect_together
load('myrois.mat', 'roi_bg_in_narrow', 'roi_circle_diff')
circ_size_leg(12)=size(roi_circle_diff,1);
bg_size_leg(12)=size(roi_bg_in_narrow,1);

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\f\correct_and_incorrect_together
load('myrois.mat', 'roi_bg_in_narrow', 'roi_circle_diff')
circ_size_leg(13)=size(roi_circle_diff,1);
bg_size_leg(13)=size(roi_bg_in_narrow,1);

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\h
load('myrois.mat', 'roi_maskin', 'roi_contour')
circ_size_leg(14:15)=size(roi_contour,1);
bg_size_leg(14:15)=size(roi_maskin,1);

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\e
load('myrois.mat', 'roi_bg_in_narrow', 'roi_circle_diff')
circ_size_leg(16:17)=size(roi_circle_diff,1);
bg_size_leg(16:17)=size(roi_bg_in_narrow,1);

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\f
load('myrois.mat', 'roi_bg_in_narrow', 'roi_circle_diff')
circ_size_leg(18:19)=size(roi_circle_diff,1);
bg_size_leg(18:19)=size(roi_bg_in_narrow,1);

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\d
load('myrois.mat', 'roi_bg_in_narrow', 'roi_circle_diff')
circ_size_leg(20:21)=size(roi_circle_diff,1);
bg_size_leg(20:21)=size(roi_bg_in_narrow,1);

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\e
load('myrois.mat', 'roi_bg_in_narrow', 'roi_circle_diff')
circ_size_leg(22:23)=size(roi_circle_diff,1);
bg_size_leg(22:23)=size(roi_bg_in_narrow,1);


%% SMEAGOL

cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\b
load('myrois.mat', 'roi_bg_in_narrow', 'roi_circle')
circ_size_smeg(1:2)=size(roi_circle,1);
bg_size_smeg(1:2)=size(roi_bg_in_narrow,1);

cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\c
load('myrois.mat', 'roi_bg_in_narrow', 'roi_circle')
circ_size_smeg(3:4)=size(roi_circle,1);
bg_size_smeg(3:4)=size(roi_bg_in_narrow,1);

cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\g
load('myrois.mat', 'roi_bg_in_narrow', 'roi_circle')
circ_size_smeg(5:6)=size(roi_circle,1);
bg_size_smeg(5:6)=size(roi_bg_in_narrow,1);

cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\b
load('myrois.mat', 'roi_bg_in_narrow', 'roi_circle')
circ_size_smeg(7:8)=size(roi_circle,1);
bg_size_smeg(7:8)=size(roi_bg_in_narrow,1);

cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\d
load('myrois.mat', 'roi_bg_in_narrow', 'roi_circle')
circ_size_smeg(9:10)=size(roi_circle,1);
bg_size_smeg(9:10)=size(roi_bg_in_narrow,1);

cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\f
load('myrois.mat', 'roi_bg_in_narrow', 'roi_circle')
circ_size_smeg(11:12)=size(roi_circle,1);
bg_size_smeg(11:12)=size(roi_bg_in_narrow,1);

cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\b
load('myrois.mat', 'roi_bg_in_narrow', 'roi_circle')
circ_size_smeg(13:17)=size(roi_circle,1);
bg_size_smeg(13:17)=size(roi_bg_in_narrow,1);

cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\b
load('myrois.mat', 'roi_bg_in_narrow', 'roi_circle')
circ_size_smeg(18:21)=size(roi_circle,1);
bg_size_smeg(18:21)=size(roi_bg_in_narrow,1);

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\b
load('myrois.mat', 'roi_bg_in_narrow', 'roi_circle')
circ_size_smeg(22:23)=size(roi_circle,1);
bg_size_smeg(22:23)=size(roi_bg_in_narrow,1);

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c
load('myrois.mat', 'roi_bg_out_narrow', 'roi_circle')
circ_size_smeg(24:25)=size(roi_circle,1);
bg_size_smeg(24:25)=size(roi_bg_out_narrow,1);

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\d
load('myrois.mat', 'roi_bg_in_narrow', 'roi_circle')
circ_size_smeg(26:27)=size(roi_circle,1);
bg_size_smeg(26:27)=size(roi_bg_in_narrow,1);

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\e
load('myrois.mat', 'roi_bg_out_narrow', 'roi_circle')
circ_size_smeg(28:29)=size(roi_circle,1);
bg_size_smeg(28:29)=size(roi_bg_out_narrow,1);


cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\k
load('myrois.mat', 'roi_bg_out_narrow', 'roi_circle')
circ_size_smeg(30:31)=size(roi_circle,1);
bg_size_smeg(30:31)=size(roi_bg_out_narrow,1);


cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\b
load('myrois.mat', 'roi_bg_out_narrow', 'roi_circle')
circ_size_smeg(32:35)=size(roi_circle,1);
bg_size_smeg(32:35)=size(roi_bg_out_narrow,1);


cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\e
load('myrois.mat', 'roi_bg_in_narrow', 'roi_circle')
circ_size_smeg(36:37)=size(roi_circle,1);
bg_size_smeg(36:37)=size(roi_bg_in_narrow,1);

