% creating some ave matrices

cd /fat/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/Path/legolas/2007_04_18/way2
load 1804
load alpha100RMS4n_dt_bl
load alpha100RMS3n_dt_bl
load alpha100RMS6n_dt_bl

alpha_1804_V1_colin=mean(alphaRMS4n_dt_bl(roi_V1,:,:),3);
alpha_1804_V1_nocolin=mean(alphaRMS3n_dt_bl(roi_V1,:,:),3);
alpha_1804_V1_blank=mean(alphaRMS6n_dt_bl(roi_V1,:,:),3);

clear alphaRMS4n_dt_bl
clear alphaRMS3n_dt_bl
clear alphaRMS6n_dt_bl



cd /fat/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/Path/legolas/2007_03_12/conds/way2
load 1203
load alpha100RMS4n_dt_bl
load alpha100RMS3n_dt_bl
load alpha100RMS6n_dt_bl

alpha_1203_V1_colin=mean(alphaRMS4n_dt_bl(roi_V1,:,:),3);
alpha_1203_V1_nocolin=mean(alphaRMS3n_dt_bl(roi_V1,:,:),3);
alpha_1203_V1_blank=mean(alphaRMS6n_dt_bl(roi_V1,:,:),3);

clear alphaRMS4n_dt_bl
clear alphaRMS3n_dt_bl
clear alphaRMS6n_dt_bl


cd /fat/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/Path/legolas/2007_05_10/b/way2
load 1005
load alpha100RMS4n_dt_bl
load alpha100RMS3n_dt_bl
load alpha100RMS6n_dt_bl

alpha_1005b_V1_colin=mean(alphaRMS4n_dt_bl(roi_V1,:,:),3);
alpha_1005b_V1_nocolin=mean(alphaRMS3n_dt_bl(roi_V1,:,:),3);
alpha_1005b_V1_blank=mean(alphaRMS6n_dt_bl(roi_V1,:,:),3);

clear alphaRMS4n_dt_bl
clear alphaRMS3n_dt_bl
clear alphaRMS6n_dt_bl


cd /fat/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/Path/legolas/2007_05_10/e/way2
load 1005
load alpha100RMS4n_dt_bl
load alpha100RMS3n_dt_bl
load alpha100RMS6n_dt_bl

alpha_1005e_V1_colin=mean(alphaRMS4n_dt_bl(roi_V1,:,:),3);
alpha_1005e_V1_nocolin=mean(alphaRMS3n_dt_bl(roi_V1,:,:),3);
alpha_1005e_V1_blank=mean(alphaRMS6n_dt_bl(roi_V1,:,:),3);

clear alphaRMS4n_dt_bl
clear alphaRMS3n_dt_bl
clear alphaRMS6n_dt_bl


cd /fat/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/Path/aragon/2007_11_20/way2
load 2011
load alpha100RMS4n_dt_bl
load alpha100RMS3n_dt_bl
load alpha100RMS6n_dt_bl

alpha_2011_V1_colin=mean(alphaRMS4n_dt_bl(roi_V1,:,:),3);
alpha_2011_V1_nocolin=mean(alphaRMS3n_dt_bl(roi_V1,:,:),3);
alpha_2011_V1_blank=mean(alphaRMS6n_dt_bl(roi_V1,:,:),3);

clear alphaRMS4n_dt_bl
clear alphaRMS3n_dt_bl
clear alphaRMS6n_dt_bl


%

alpha_V1_colin=zeros(193,5);
alpha_V1_colin(:,1)=mean(alpha_1804_V1_colin,1);
alpha_V1_colin(:,2)=mean(alpha_1203_V1_colin,1);
alpha_V1_colin(:,3)=mean(alpha_1005b_V1_colin,1);
alpha_V1_colin(:,4)=mean(alpha_1005e_V1_colin,1);
alpha_V1_colin(:,5)=mean(alpha_2011_V1_colin,1);


alpha_V1_nocolin=zeros(193,5);
alpha_V1_nocolin(:,1)=mean(alpha_1804_V1_nocolin,1);
alpha_V1_nocolin(:,2)=mean(alpha_1203_V1_nocolin,1);
alpha_V1_nocolin(:,3)=mean(alpha_1005b_V1_nocolin,1);
alpha_V1_nocolin(:,4)=mean(alpha_1005e_V1_nocolin,1);
alpha_V1_nocolin(:,5)=mean(alpha_2011_V1_nocolin,1);


alpha_V1_blank=zeros(193,5);
alpha_V1_blank(:,1)=mean(alpha_1804_V1_blank,1);
alpha_V1_blank(:,2)=mean(alpha_1203_V1_blank,1);
alpha_V1_blank(:,3)=mean(alpha_1005b_V1_blank,1);
alpha_V1_blank(:,4)=mean(alpha_1005e_V1_blank,1);
alpha_V1_blank(:,5)=mean(alpha_2011_V1_blank,1);






%% for frodo

cd /fat/Ariel/matlab_analysis/vsdi/frodo/28_04_2010/a
load roi
load alpha9RMS3n_dt_bl
alpha_2804a_blank=squeeze(mean(alphaRMS3n_dt_bl(roi,:,:),1));
clear alphaRMS3n_dt_bl


cd /fat/Ariel/matlab_analysis/vsdi/frodo/28_04_2010/b
load roi
load alpha9RMS3n_dt_bl
alpha_2804b_blank=squeeze(mean(alphaRMS3n_dt_bl(roi,:,:),1));
clear alphaRMS3n_dt_bl


cd /fat/Ariel/matlab_analysis/vsdi/frodo/12_05_2010/a
load roi
load alpha9RMS3n_dt_bl
alpha_1205a_blank=squeeze(mean(alphaRMS3n_dt_bl(roi,:,:),1));
clear alphaRMS3n_dt_bl


cd /fat/Ariel/matlab_analysis/vsdi/frodo/12_05_2010/c
load roi
load alpha9RMS3n_dt_bl
alpha_1205c_blank=squeeze(mean(alphaRMS3n_dt_bl(roi,:,:),1));
clear alphaRMS3n_dt_bl


cd /fat/Ariel/matlab_analysis/vsdi/frodo/12_05_2010/d
load roi
load alpha9RMS3n_dt_bl
alpha_1205d_blank=squeeze(mean(alphaRMS3n_dt_bl(roi,:,:),1));
clear alphaRMS3n_dt_bl

cd /fat/Ariel/matlab_analysis/vsdi/frodo/12_05_2010/e
load roi
load alpha9RMS3n_dt_bl
alpha_1205e_blank=squeeze(mean(alphaRMS3n_dt_bl(roi,:,:),1));
clear alphaRMS3n_dt_bl

cd /fat/Ariel/matlab_analysis/vsdi/frodo/12_05_2010/f
load roi
load alpha9RMS3n_dt_bl
alpha_1205f_blank=squeeze(mean(alphaRMS3n_dt_bl(roi,:,:),1));
clear alphaRMS3n_dt_bl



%% normalization


alpha_1804_V1_colin=10*log10(alpha_1804_V1_colin./repmat(mean(alpha_1804_V1_colin(:,100:111),2),[1 size(alpha_1804_V1_colin,2)]));
alpha_1203_V1_colin=10*log10(alpha_1203_V1_colin./repmat(mean(alpha_1203_V1_colin(:,100:111),2),[1 size(alpha_1203_V1_colin,2)]));
alpha_1005b_V1_colin=10*log10(alpha_1005b_V1_colin./repmat(mean(alpha_1005b_V1_colin(:,100:111),2),[1 size(alpha_1005b_V1_colin,2)]));
alpha_1005e_V1_colin=10*log10(alpha_1005e_V1_colin./repmat(mean(alpha_1005e_V1_colin(:,100:111),2),[1 size(alpha_1005e_V1_colin,2)]));
alpha_2011_V1_colin=10*log10(alpha_2011_V1_colin./repmat(mean(alpha_2011_V1_colin(:,100:111),2),[1 size(alpha_2011_V1_colin,2)]));


alpha_1804_V1_nocolin=10*log10(alpha_1804_V1_nocolin./repmat(mean(alpha_1804_V1_nocolin(:,100:111),2),[1 size(alpha_1804_V1_nocolin,2)]));
alpha_1203_V1_nocolin=10*log10(alpha_1203_V1_nocolin./repmat(mean(alpha_1203_V1_nocolin(:,100:111),2),[1 size(alpha_1203_V1_nocolin,2)]));
alpha_1005b_V1_nocolin=10*log10(alpha_1005b_V1_nocolin./repmat(mean(alpha_1005b_V1_nocolin(:,100:111),2),[1 size(alpha_1005b_V1_nocolin,2)]));
alpha_1005e_V1_nocolin=10*log10(alpha_1005e_V1_nocolin./repmat(mean(alpha_1005e_V1_nocolin(:,100:111),2),[1 size(alpha_1005e_V1_nocolin,2)]));
alpha_2011_V1_nocolin=10*log10(alpha_2011_V1_nocolin./repmat(mean(alpha_2011_V1_nocolin(:,100:111),2),[1 size(alpha_2011_V1_nocolin,2)]));


alpha_1804_V1_blank=10*log10(alpha_1804_V1_blank./repmat(mean(alpha_1804_V1_blank(:,100:111),2),[1 size(alpha_1804_V1_blank,2)]));
alpha_1203_V1_blank=10*log10(alpha_1203_V1_blank./repmat(mean(alpha_1203_V1_blank(:,100:111),2),[1 size(alpha_1203_V1_blank,2)]));
alpha_1005b_V1_blank=10*log10(alpha_1005b_V1_blank./repmat(mean(alpha_1005b_V1_blank(:,100:111),2),[1 size(alpha_1005b_V1_blank,2)]));
alpha_1005e_V1_blank=10*log10(alpha_1005e_V1_blank./repmat(mean(alpha_1005e_V1_blank(:,100:111),2),[1 size(alpha_1005e_V1_blank,2)]));
alpha_2011_V1_blank=10*log10(alpha_2011_V1_blank./repmat(mean(alpha_2011_V1_blank(:,100:111),2),[1 size(alpha_2011_V1_blank,2)]));












