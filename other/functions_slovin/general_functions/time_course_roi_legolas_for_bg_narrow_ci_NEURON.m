%% 1111
cd C:\contour_integration\11_11_2008\c\elhanan_new
load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1111c_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_maskin_narrow,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end     

cd C:\contour_integration\11_11_2008\d\elhanan_new
load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1111d_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_maskin_narrow,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end     


cd C:\contour_integration\11_11_2008\h
load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1111h_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_maskin,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end     
   


%% 1811

cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\legolas\right_hemisphere\psychophysics\2008_11_18\c\correct_and_incorrect_together
load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1811c_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in_narrow,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end     


cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\legolas\right_hemisphere\psychophysics\2008_11_18\d\correct_and_incorrect_together
load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1811d_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in_narrow,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end     


cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\legolas\right_hemisphere\psychophysics\2008_11_18\e\correct_and_incorrect_together
load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1811e_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in_narrow,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end     



%% 2511
cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together
load myrois
for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2511d_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in_narrow,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end     

cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\legolas\right_hemisphere\psychophysics\2008_11_25\e\correct_and_incorrect_together
load myrois
for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2511e_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in_narrow,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end     


cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\legolas\right_hemisphere\psychophysics\2008_11_25\f\correct_and_incorrect_together
load myrois
for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2511f_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in_narrow,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end     




%% 1203
cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\legolas\right_hemisphere\psychophysics\2008_12_03\d\correct_and_incorrect_together
load myrois
for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1203d_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in_narrow,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end

cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\legolas\right_hemisphere\psychophysics\2008_12_03\e\correct_and_incorrect_together
load myrois
for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1203e_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in_narrow,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end  

cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\legolas\right_hemisphere\psychophysics\2008_12_03\f\correct_and_incorrect_together
load myrois
for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1203f_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in_narrow,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end  


%% 0610

cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\legolas\right_hemisphere\06_10_2008\e
load myrois
for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_0610e_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in_narrow,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end  

cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\legolas\right_hemisphere\06_10_2008\f
load myrois
for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_0610f_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in_narrow,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end  


%% 2210

cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\legolas\right_hemisphere\22_10_2008\d
load myrois
for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2210d_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in_narrow,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end  

cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\legolas\right_hemisphere\22_10_2008\e
load myrois
for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2210e_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in_narrow,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end



%%




cont_bg_in(:,1)=mean(c1_1111c_bg_in,2);
cont_bg_in(:,2)=mean(c2_1111c_bg_in,2);
cont_bg_in(:,3)=mean(c1_1111d_bg_in,2);
cont_bg_in(:,4)=mean(c2_1111d_bg_in,2);
cont_bg_in(:,5)=mean(c1_1811c_bg_in,2);
cont_bg_in(:,6)=mean(c1_1811d_bg_in,2);
cont_bg_in(:,7)=mean(c1_1811e_bg_in,2);
cont_bg_in(:,8)=mean(c1_2511d_bg_in,2);
cont_bg_in(:,9)=mean(c1_2511e_bg_in,2);
cont_bg_in(:,10)=mean(c1_2511f_bg_in,2);
cont_bg_in(:,11)=mean(c1_1203d_bg_in,2);
cont_bg_in(:,12)=mean(c1_1203e_bg_in,2);
cont_bg_in(:,13)=mean(c1_1203f_bg_in,2);
cont_bg_in(:,14)=mean(c1_1111h_bg_in,2);
cont_bg_in(:,15)=mean(c2_1111h_bg_in,2);
cont_bg_in(:,16)=mean(c1_0610e_bg_in,2);
cont_bg_in(:,17)=mean(c2_0610e_bg_in,2);
cont_bg_in(:,18)=mean(c1_0610f_bg_in,2);
cont_bg_in(:,19)=mean(c2_0610f_bg_in,2);
cont_bg_in(:,20)=mean(c1_2210d_bg_in,2);
cont_bg_in(:,21)=mean(c2_2210d_bg_in,2);
cont_bg_in(:,22)=mean(c1_2210e_bg_in,2);
cont_bg_in(:,23)=mean(c2_2210e_bg_in,2);


non_bg_in(:,1)=mean(c4_1111c_bg_in,2);
non_bg_in(:,2)=mean(c5_1111c_bg_in,2);
non_bg_in(:,3)=mean(c4_1111d_bg_in,2);
non_bg_in(:,4)=mean(c5_1111d_bg_in,2);
non_bg_in(:,5)=mean(c5_1811c_bg_in,2);
non_bg_in(:,6)=mean(c5_1811d_bg_in,2);
non_bg_in(:,7)=mean(c5_1811e_bg_in,2);
non_bg_in(:,8)=mean(c5_2511d_bg_in,2);
non_bg_in(:,9)=mean(c5_2511e_bg_in,2);
non_bg_in(:,10)=mean(c5_2511f_bg_in,2);
non_bg_in(:,11)=mean(c5_1203d_bg_in,2);
non_bg_in(:,12)=mean(c5_1203e_bg_in,2);
non_bg_in(:,13)=mean(c5_1203f_bg_in,2);
non_bg_in(:,14)=mean(c4_1111h_bg_in,2);
non_bg_in(:,15)=mean(c5_1111h_bg_in,2);
non_bg_in(:,16)=mean(c4_0610e_bg_in,2);
non_bg_in(:,17)=mean(c5_0610e_bg_in,2);
non_bg_in(:,18)=mean(c4_0610f_bg_in,2);
non_bg_in(:,19)=mean(c5_0610f_bg_in,2);
non_bg_in(:,20)=mean(c4_2210d_bg_in,2);
non_bg_in(:,21)=mean(c5_2210d_bg_in,2);
non_bg_in(:,22)=mean(c4_2210e_bg_in,2);
non_bg_in(:,23)=mean(c5_2210e_bg_in,2);


