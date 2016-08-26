%% 1111

load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1111c_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_contour2,2:112,:),1));'])
    eval(['c',int2str(i),'_1111c_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_maskin,2:112,:),1));'])
    eval(['c',int2str(i),'_1111c_circle_diff=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle_diff,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end     


load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1111d_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_contour2,2:112,:),1));'])
    eval(['c',int2str(i),'_1111d_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_maskin,2:112,:),1));'])
    eval(['c',int2str(i),'_1111d_circle_diff=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle_diff,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end     



load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1111h_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_contour,2:112,:),1));'])
    eval(['c',int2str(i),'_1111h_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_maskin,2:112,:),1));'])
    eval(['c',int2str(i),'_1111h_bg_out=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_maskout,2:112,:),1));'])
    eval(['c',int2str(i),'_1111h_circle_diff=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle_diff,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end     
   


%% 1811


load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1811c_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_contour,2:112,:),1));'])
    eval(['c',int2str(i),'_1811c_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['c',int2str(i),'_1811c_circle_diff=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle_diff,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end     



load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1811d_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_contour,2:112,:),1));'])
    eval(['c',int2str(i),'_1811d_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['c',int2str(i),'_1811d_circle_diff=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle_diff,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end     



load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1811e_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_contour,2:112,:),1));'])
    eval(['c',int2str(i),'_1811e_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['c',int2str(i),'_1811e_circle_diff=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle_diff,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end     



%% 2511

load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2511d_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_contour,2:112,:),1));'])
    eval(['c',int2str(i),'_2511d_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['c',int2str(i),'_2511d_circle_diff=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle_diff,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end     


load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2511e_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_contour,2:112,:),1));'])
    eval(['c',int2str(i),'_2511e_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['c',int2str(i),'_2511e_circle_diff=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle_diff,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end     



load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2511f_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_contour,2:112,:),1));'])
    eval(['c',int2str(i),'_2511f_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['c',int2str(i),'_2511f_circle_diff=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle_diff,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end     




%% 1203

load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1203d_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_contour,2:112,:),1));'])
    eval(['c',int2str(i),'_1203d_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['c',int2str(i),'_1203d_circle_diff=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle_diff,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end  

load myrois
for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1203e_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_contour,2:112,:),1));'])
    eval(['c',int2str(i),'_1203e_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['c',int2str(i),'_1203e_circle_diff=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle_diff,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end  


load myrois
for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1203f_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_contour,2:112,:),1));'])
    eval(['c',int2str(i),'_1203f_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['c',int2str(i),'_1203f_circle_diff=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle_diff,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end  


%% 0610

load myrois
for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_0610e_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_contour,2:112,:),1));'])
    eval(['c',int2str(i),'_0610e_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['c',int2str(i),'_0610e_circle_diff=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle_diff,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end  


load myrois
for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_0610f_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_contour,2:112,:),1));'])
    eval(['c',int2str(i),'_0610f_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['c',int2str(i),'_0610f_circle_diff=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle_diff,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end  


%% 2210

load myrois
for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2210d_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_contour,2:112,:),1));'])
    eval(['c',int2str(i),'_2210d_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['c',int2str(i),'_2210d_circle_diff=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle_diff,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end  


load myrois
for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2210e_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_contour,2:112,:),1));'])
    eval(['c',int2str(i),'_2210e_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['c',int2str(i),'_2210e_circle_diff=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle_diff,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end


%% 0601

load myrois
for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_0601e_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_contour,2:112,:),1));'])
    eval(['c',int2str(i),'_0601e_bg_out=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_out,2:112,:),1));'])
    eval(['c',int2str(i),'_0601e_V2=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end  


load myrois
for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_0601fg_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_contour,2:112,:),1));'])
    eval(['c',int2str(i),'_0601fg_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['c',int2str(i),'_0601fg_V2=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end  


load myrois
for i=2:4
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_0601h_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_0601h_bg_out=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_out,2:112,:),1));'])
    eval(['c',int2str(i),'_0601h_V2=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end  



load myrois
for i=2:4
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_0601i_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_contour,2:112,:),1));'])
    eval(['c',int2str(i),'_0601i_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['c',int2str(i),'_0601i_V2=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end


%% 0403

load myrois
for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_0403b_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_0403b_bg_out=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_out,2:112,:),1));'])
    eval(['c',int2str(i),'_0403b_V2=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end  


load myrois
for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_0403d_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_0403d_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['c',int2str(i),'_0403d_V2=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end  

load myrois
for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_0403e_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_0403e_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['c',int2str(i),'_0403e_V2=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end  


%%


cont_circle(:,1)=mean(c1_1111c_circle,2);
cont_circle(:,2)=mean(c2_1111c_circle,2);
cont_circle(:,3)=mean(c1_1111d_circle,2);
cont_circle(:,4)=mean(c2_1111d_circle,2);
cont_circle(:,5)=mean(c1_1811c_circle,2);
cont_circle(:,6)=mean(c1_1811d_circle,2);
cont_circle(:,7)=mean(c1_1811e_circle,2);
cont_circle(:,8)=mean(c1_2511d_circle,2);
cont_circle(:,9)=mean(c1_2511e_circle,2);
cont_circle(:,10)=mean(c1_2511f_circle,2);
cont_circle(:,11)=mean(c1_1203d_circle,2);
cont_circle(:,12)=mean(c1_1203e_circle,2);
cont_circle(:,13)=mean(c1_1203f_circle,2);
cont_circle(:,14)=mean(c1_1111h_circle,2);
cont_circle(:,15)=mean(c2_1111h_circle,2);
cont_circle(:,16)=mean(c1_0610e_circle,2);
cont_circle(:,17)=mean(c2_0610e_circle,2);
cont_circle(:,18)=mean(c1_0610f_circle,2);
cont_circle(:,19)=mean(c2_0610f_circle,2);
cont_circle(:,20)=mean(c1_2210d_circle,2);
cont_circle(:,21)=mean(c2_2210d_circle,2);
cont_circle(:,22)=mean(c1_2210e_circle,2);
cont_circle(:,23)=mean(c2_2210e_circle,2);
cont_circle(:,24)=mean(c1_0601e_circle,2);
cont_circle(:,25)=mean(c2_0601e_circle,2);
cont_circle(:,26)=mean(c1_0601fg_circle,2);
cont_circle(:,27)=mean(c2_0601fg_circle,2);
cont_circle(:,28)=mean(c2_0601h_circle,2);
cont_circle(:,29)=mean(c2_0601i_circle,2);
cont_circle(:,30)=mean(c1_0403b_circle,2);
cont_circle(:,31)=mean(c2_0403b_circle,2);
cont_circle(:,32)=mean(c1_0403d_circle,2);
cont_circle(:,33)=mean(c1_0403e_circle,2);




non_circle(:,1)=mean(c4_1111c_circle,2);
non_circle(:,2)=mean(c5_1111c_circle,2);
non_circle(:,3)=mean(c4_1111d_circle,2);
non_circle(:,4)=mean(c5_1111d_circle,2);
non_circle(:,5)=mean(c5_1811c_circle,2);
non_circle(:,6)=mean(c5_1811d_circle,2);
non_circle(:,7)=mean(c5_1811e_circle,2);
non_circle(:,8)=mean(c5_2511d_circle,2);
non_circle(:,9)=mean(c5_2511e_circle,2);
non_circle(:,10)=mean(c5_2511f_circle,2);
non_circle(:,11)=mean(c5_1203d_circle,2);
non_circle(:,12)=mean(c5_1203e_circle,2);
non_circle(:,13)=mean(c5_1203f_circle,2);
non_circle(:,14)=mean(c4_1111h_circle,2);
non_circle(:,15)=mean(c5_1111h_circle,2);
non_circle(:,16)=mean(c4_0610e_circle,2);
non_circle(:,17)=mean(c5_0610e_circle,2);
non_circle(:,18)=mean(c4_0610f_circle,2);
non_circle(:,19)=mean(c5_0610f_circle,2);
non_circle(:,20)=mean(c4_2210d_circle,2);
non_circle(:,21)=mean(c5_2210d_circle,2);
non_circle(:,22)=mean(c4_2210e_circle,2);
non_circle(:,23)=mean(c5_2210e_circle,2);
non_circle(:,24)=mean(c4_0601e_circle,2);
non_circle(:,25)=mean(c5_0601e_circle,2);
non_circle(:,26)=mean(c4_0601fg_circle,2);
non_circle(:,27)=mean(c5_0601fg_circle,2);
non_circle(:,28)=mean(c4_0601h_circle,2);
non_circle(:,29)=mean(c4_0601i_circle,2);
non_circle(:,30)=mean(c4_0403b_circle,2);
non_circle(:,31)=mean(c5_0403b_circle,2);
non_circle(:,32)=mean(c5_0403d_circle,2);
non_circle(:,33)=mean(c5_0403e_circle,2);





cont_circle_diff(:,1)=mean(c1_1111c_circle_diff,2);
cont_circle_diff(:,2)=mean(c2_1111c_circle_diff,2);
cont_circle_diff(:,3)=mean(c1_1111d_circle_diff,2);
cont_circle_diff(:,4)=mean(c2_1111d_circle_diff,2);
cont_circle_diff(:,5)=mean(c1_1811c_circle_diff,2);
cont_circle_diff(:,6)=mean(c1_1811d_circle_diff,2);
cont_circle_diff(:,7)=mean(c1_1811e_circle_diff,2);
cont_circle_diff(:,8)=mean(c1_2511d_circle_diff,2);
cont_circle_diff(:,9)=mean(c1_2511e_circle_diff,2);
cont_circle_diff(:,10)=mean(c1_2511f_circle_diff,2);
cont_circle_diff(:,11)=mean(c1_1203d_circle_diff,2);
cont_circle_diff(:,12)=mean(c1_1203e_circle_diff,2);
cont_circle_diff(:,13)=mean(c1_1203f_circle_diff,2);
cont_circle_diff(:,14)=mean(c1_1111h_circle_diff,2);
cont_circle_diff(:,15)=mean(c2_1111h_circle_diff,2);
cont_circle_diff(:,16)=mean(c1_0610e_circle_diff,2);
cont_circle_diff(:,17)=mean(c2_0610e_circle_diff,2);
cont_circle_diff(:,18)=mean(c1_0610f_circle_diff,2);
cont_circle_diff(:,19)=mean(c2_0610f_circle_diff,2);
cont_circle_diff(:,20)=mean(c1_2210d_circle_diff,2);
cont_circle_diff(:,21)=mean(c2_2210d_circle_diff,2);
cont_circle_diff(:,22)=mean(c1_2210e_circle_diff,2);
cont_circle_diff(:,23)=mean(c2_2210e_circle_diff,2);

non_circle_diff(:,1)=mean(c4_1111c_circle_diff,2);
non_circle_diff(:,2)=mean(c5_1111c_circle_diff,2);
non_circle_diff(:,3)=mean(c4_1111d_circle_diff,2);
non_circle_diff(:,4)=mean(c5_1111d_circle_diff,2);
non_circle_diff(:,5)=mean(c5_1811c_circle_diff,2);
non_circle_diff(:,6)=mean(c5_1811d_circle_diff,2);
non_circle_diff(:,7)=mean(c5_1811e_circle_diff,2);
non_circle_diff(:,8)=mean(c5_2511d_circle_diff,2);
non_circle_diff(:,9)=mean(c5_2511e_circle_diff,2);
non_circle_diff(:,10)=mean(c5_2511f_circle_diff,2);
non_circle_diff(:,11)=mean(c5_1203d_circle_diff,2);
non_circle_diff(:,12)=mean(c5_1203e_circle_diff,2);
non_circle_diff(:,13)=mean(c5_1203f_circle_diff,2);
non_circle_diff(:,14)=mean(c4_1111h_circle_diff,2);
non_circle_diff(:,15)=mean(c5_1111h_circle_diff,2);
non_circle_diff(:,16)=mean(c4_0610e_circle_diff,2);
non_circle_diff(:,17)=mean(c5_0610e_circle_diff,2);
non_circle_diff(:,18)=mean(c4_0610f_circle_diff,2);
non_circle_diff(:,19)=mean(c5_0610f_circle_diff,2);
non_circle_diff(:,20)=mean(c4_2210d_circle_diff,2);
non_circle_diff(:,21)=mean(c5_2210d_circle_diff,2);
non_circle_diff(:,22)=mean(c4_2210e_circle_diff,2);
non_circle_diff(:,23)=mean(c5_2210e_circle_diff,2);






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
cont_bg_in(:,24)=mean(c1_0601fg_bg_in,2);
cont_bg_in(:,25)=mean(c2_0601fg_bg_in,2);
cont_bg_in(:,26)=mean(c2_0601i_bg_in,2);
cont_bg_in(:,27)=mean(c1_0403d_bg_in,2);
cont_bg_in(:,28)=mean(c1_0403e_bg_in,2);



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
non_bg_in(:,24)=mean(c4_0601fg_bg_in,2);
non_bg_in(:,25)=mean(c5_0601fg_bg_in,2);
non_bg_in(:,26)=mean(c4_0601i_bg_in,2);
non_bg_in(:,27)=mean(c5_0403d_bg_in,2);
non_bg_in(:,28)=mean(c5_0403e_bg_in,2);



cont_bg_out(:,1)=mean(c1_1111h_bg_out,2);
cont_bg_out(:,2)=mean(c2_1111h_bg_out,2);
cont_bg_out(:,3)=mean(c1_0601e_bg_out,2);
cont_bg_out(:,4)=mean(c2_0601e_bg_out,2);
cont_bg_out(:,5)=mean(c2_0601h_bg_out,2);
cont_bg_out(:,6)=mean(c1_0403b_bg_out,2);
cont_bg_out(:,7)=mean(c2_0403b_bg_out,2);


non_bg_out(:,1)=mean(c4_1111h_bg_out,2);
non_bg_out(:,2)=mean(c5_1111h_bg_out,2);
non_bg_out(:,3)=mean(c4_0601e_bg_out,2);
non_bg_out(:,4)=mean(c5_0601e_bg_out,2);
non_bg_out(:,5)=mean(c4_0601h_bg_out,2);
non_bg_out(:,6)=mean(c4_0403b_bg_out,2);
non_bg_out(:,7)=mean(c5_0403b_bg_out,2);


cont_bg(:,1)=mean(c1_1111c_bg_in,2);
cont_bg(:,2)=mean(c2_1111c_bg_in,2);
cont_bg(:,3)=mean(c1_1111d_bg_in,2);
cont_bg(:,4)=mean(c2_1111d_bg_in,2);
cont_bg(:,5)=mean(c1_1811c_bg_in,2);
cont_bg(:,6)=mean(c1_1811d_bg_in,2);
cont_bg(:,7)=mean(c1_1811e_bg_in,2);
cont_bg(:,8)=mean(c1_2511d_bg_in,2);
cont_bg(:,9)=mean(c1_2511e_bg_in,2);
cont_bg(:,10)=mean(c1_2511f_bg_in,2);
cont_bg(:,11)=mean(c1_1203d_bg_in,2);
cont_bg(:,12)=mean(c1_1203e_bg_in,2);
cont_bg(:,13)=mean(c1_1203f_bg_in,2);
cont_bg(:,14)=mean(c1_1111h_bg_in,2);
cont_bg(:,15)=mean(c2_1111h_bg_in,2);
cont_bg(:,16)=mean(c1_0610e_bg_in,2);
cont_bg(:,17)=mean(c2_0610e_bg_in,2);
cont_bg(:,18)=mean(c1_0610f_bg_in,2);
cont_bg(:,19)=mean(c2_0610f_bg_in,2);
cont_bg(:,20)=mean(c1_2210d_bg_in,2);
cont_bg(:,21)=mean(c2_2210d_bg_in,2);
cont_bg(:,22)=mean(c1_2210e_bg_in,2);
cont_bg(:,23)=mean(c2_2210e_bg_in,2);
cont_bg(:,24)=mean(c1_0601e_bg_out,2);
cont_bg(:,25)=mean(c2_0601e_bg_out,2);
cont_bg(:,26)=mean(c1_0601fg_bg_in,2);
cont_bg(:,27)=mean(c2_0601fg_bg_in,2);
cont_bg(:,28)=mean(c2_0601h_bg_out,2);
cont_bg(:,29)=mean(c2_0601i_bg_in,2);
cont_bg(:,30)=mean(c1_0403d_bg_in,2);
cont_bg(:,31)=mean(c1_0403e_bg_in,2);
cont_bg(:,32)=mean(c1_0403b_bg_out,2);
cont_bg(:,33)=mean(c2_0403b_bg_out,2);



non_bg(:,1)=mean(c4_1111c_bg_in,2);
non_bg(:,2)=mean(c5_1111c_bg_in,2);
non_bg(:,3)=mean(c4_1111d_bg_in,2);
non_bg(:,4)=mean(c5_1111d_bg_in,2);
non_bg(:,5)=mean(c5_1811c_bg_in,2);
non_bg(:,6)=mean(c5_1811d_bg_in,2);
non_bg(:,7)=mean(c5_1811e_bg_in,2);
non_bg(:,8)=mean(c5_2511d_bg_in,2);
non_bg(:,9)=mean(c5_2511e_bg_in,2);
non_bg(:,10)=mean(c5_2511f_bg_in,2);
non_bg(:,11)=mean(c5_1203d_bg_in,2);
non_bg(:,12)=mean(c5_1203e_bg_in,2);
non_bg(:,13)=mean(c5_1203f_bg_in,2);
non_bg(:,14)=mean(c4_1111h_bg_in,2);
non_bg(:,15)=mean(c5_1111h_bg_in,2);
non_bg(:,16)=mean(c4_0610e_bg_in,2);
non_bg(:,17)=mean(c5_0610e_bg_in,2);
non_bg(:,18)=mean(c4_0610f_bg_in,2);
non_bg(:,19)=mean(c5_0610f_bg_in,2);
non_bg(:,20)=mean(c4_2210d_bg_in,2);
non_bg(:,21)=mean(c5_2210d_bg_in,2);
non_bg(:,22)=mean(c4_2210e_bg_in,2);
non_bg(:,23)=mean(c5_2210e_bg_in,2);
non_bg(:,24)=mean(c4_0601e_bg_out,2);
non_bg(:,25)=mean(c5_0601e_bg_out,2);
non_bg(:,26)=mean(c4_0601fg_bg_in,2);
non_bg(:,27)=mean(c5_0601fg_bg_in,2);
non_bg(:,28)=mean(c4_0601h_bg_out,2);
non_bg(:,29)=mean(c4_0601i_bg_in,2);
non_bg(:,30)=mean(c5_0403d_bg_in,2);
non_bg(:,31)=mean(c5_0403e_bg_in,2);
non_bg(:,32)=mean(c4_0403b_bg_out,2);
non_bg(:,33)=mean(c5_0403b_bg_out,2);


%% V2 area
%% 1111

load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1111c_V2=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end  


load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1111d_V2=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end  


load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1111h_V2=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end  




%% 2210
load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2210d_V2=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end 


load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2210e_V2=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end 



%% 1811
load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1811c_V2=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end 


load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1811d_V2=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end 


load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1811e_V2=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end 



%% 2511
load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2511d_V2=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end 


load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2511e_V2=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end 


load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2511f_V2=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end 


%% 1203
load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1203d_V2=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end 


load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1203e_V2=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end 



load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1203f_V2=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end 




%% 



cont_V2_circ(:,1)=mean(c1_1111c_V2,2);
cont_V2_circ(:,2)=mean(c2_1111c_V2,2);
cont_V2_circ(:,3)=mean(c1_1111d_V2,2);
cont_V2_circ(:,4)=mean(c2_1111d_V2,2);
cont_V2_circ(:,5)=mean(c1_1811c_V2,2);
cont_V2_circ(:,6)=mean(c1_1811d_V2,2);
cont_V2_circ(:,7)=mean(c1_1811e_V2,2);
cont_V2_circ(:,8)=mean(c1_2511d_V2,2);
cont_V2_circ(:,9)=mean(c1_2511e_V2,2);
cont_V2_circ(:,10)=mean(c1_2511f_V2,2);
cont_V2_circ(:,11)=mean(c1_1203d_V2,2);
cont_V2_circ(:,12)=mean(c1_1203e_V2,2);
cont_V2_circ(:,13)=mean(c1_1203f_V2,2);
cont_V2_circ(:,14)=mean(c1_0601fg_V2,2);
cont_V2_circ(:,15)=mean(c2_0601fg_V2,2);
cont_V2_circ(:,16)=mean(c2_0601i_V2,2);
cont_V2_circ(:,17)=mean(c1_0403d_V2,2);
cont_V2_circ(:,18)=mean(c1_0403e_V2,2);
cont_V2_circ(:,19)=mean(c1_2210d_V2,2);
cont_V2_circ(:,20)=mean(c2_2210d_V2,2);
cont_V2_circ(:,21)=mean(c1_2210e_V2,2);
cont_V2_circ(:,22)=mean(c2_2210e_V2,2);


non_V2_circ(:,1)=mean(c4_1111c_V2,2);
non_V2_circ(:,2)=mean(c5_1111c_V2,2);
non_V2_circ(:,3)=mean(c4_1111d_V2,2);
non_V2_circ(:,4)=mean(c5_1111d_V2,2);
non_V2_circ(:,5)=mean(c5_1811c_V2,2);
non_V2_circ(:,6)=mean(c5_1811d_V2,2);
non_V2_circ(:,7)=mean(c5_1811e_V2,2);
non_V2_circ(:,8)=mean(c5_2511d_V2,2);
non_V2_circ(:,9)=mean(c5_2511e_V2,2);
non_V2_circ(:,10)=mean(c5_2511f_V2,2);
non_V2_circ(:,11)=mean(c5_1203d_V2,2);
non_V2_circ(:,12)=mean(c5_1203e_V2,2);
non_V2_circ(:,13)=mean(c5_1203f_V2,2);
non_V2_circ(:,14)=mean(c4_0601fg_V2,2);
non_V2_circ(:,15)=mean(c5_0601fg_V2,2);
non_V2_circ(:,16)=mean(c4_0601i_V2,2);
non_V2_circ(:,17)=mean(c5_0403d_V2,2);
non_V2_circ(:,18)=mean(c5_0403e_V2,2);
non_V2_circ(:,19)=mean(c4_2210d_V2,2);
non_V2_circ(:,20)=mean(c5_2210d_V2,2);
non_V2_circ(:,21)=mean(c4_2210e_V2,2);
non_V2_circ(:,22)=mean(c5_2210e_V2,2);



cont_V2_bg(:,1)=mean(c1_1111h_V2,2);
cont_V2_bg(:,2)=mean(c2_1111h_V2,2);
cont_V2_bg(:,3)=mean(c1_0601e_V2,2);
cont_V2_bg(:,4)=mean(c2_0601e_V2,2);
cont_V2_bg(:,5)=mean(c2_0601h_V2,2);
cont_V2_bg(:,6)=mean(c1_0403b_V2,2);
cont_V2_bg(:,7)=mean(c2_0403b_V2,2);


non_V2_bg(:,1)=mean(c4_1111h_V2,2);
non_V2_bg(:,2)=mean(c5_1111h_V2,2);
non_V2_bg(:,3)=mean(c4_0601e_V2,2);
non_V2_bg(:,4)=mean(c5_0601e_V2,2);
non_V2_bg(:,5)=mean(c4_0601h_V2,2);
non_V2_bg(:,6)=mean(c4_0403b_V2,2);
non_V2_bg(:,7)=mean(c5_0403b_V2,2);
















