
%% 2912
cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\Smeagol\29Dec2010\c
load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2912c_bg_out=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_out_narrow,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    

cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\Smeagol\29Dec2010\e
load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2912e_bg_out=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_out_narrow,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end   

cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\Smeagol\29Dec2010\k
load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2912k_bg_out=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_out_narrow,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end   



%% 0501
cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\Smeagol\05Jan2011\b
load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_0501b_bg_out=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_out_narrow,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    

cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\Smeagol\05Jan2011\c
load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_0501c_bg_out=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_out_narrow,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    

cd E:\Ariel_Gilad\Matlab_analysis\experiments\mask\Smeagol\05Jan2011\d
load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_0501d_bg_out=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_out_narrow,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    





%% creating one big matrix for each roi with all trials


cont_bg_out(:,1)=mean(c1_2912c_bg_out,2);
cont_bg_out(:,2)=mean(c2_2912c_bg_out,2);
cont_bg_out(:,3)=mean(c1_2912e_bg_out,2);
cont_bg_out(:,4)=mean(c2_2912e_bg_out,2);
cont_bg_out(:,5)=mean(c1_2912k_bg_out,2);
cont_bg_out(:,6)=mean(c2_2912k_bg_out,2);
cont_bg_out(:,7)=mean(c1_0501b_bg_out,2);
cont_bg_out(:,8)=mean(c2_0501b_bg_out,2);
cont_bg_out(:,9)=mean(c1_0501c_bg_out,2);
cont_bg_out(:,10)=mean(c1_0501d_bg_out,2);


non_bg_out(:,1)=mean(c4_2912c_bg_out,2);
non_bg_out(:,2)=mean(c5_2912c_bg_out,2);
non_bg_out(:,3)=mean(c4_2912e_bg_out,2);
non_bg_out(:,4)=mean(c5_2912e_bg_out,2);
non_bg_out(:,5)=mean(c4_2912k_bg_out,2);
non_bg_out(:,6)=mean(c5_2912k_bg_out,2);
non_bg_out(:,7)=mean(c4_0501b_bg_out,2);
non_bg_out(:,8)=mean(c5_0501b_bg_out,2);
non_bg_out(:,9)=mean(c5_0501c_bg_out,2);
non_bg_out(:,10)=mean(c5_0501d_bg_out,2);






