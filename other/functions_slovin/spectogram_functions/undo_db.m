%% undo dB from the spectograms

for i=1:6
    disp('hello');
    cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_23/cond_data_b
    eval(['load baseline_cond',int2str(i),'_bl8_hb']);
    eval(['load spect_pixel_wise_cond',int2str(i),'_res_64_bl8_hb']); 
    %vsdi
    eval(['spect_pixel_wise_cond',int2str(i),'=(10.^(spect_pixel_wise_cond',int2str(i),'./10)).*shiftdim(repmat(baseline_ave_pixels.'',[1,1,223]),1);']);
    cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_23/different_dB
    eval(['save spect_pixel_wise_cond',int2str(i),'_res_64_bl8_hb_no_dB spect_pixel_wise_cond',int2str(i)]);
    clear all;
end;
    %lfp
    %spect_all_conds=(10.^(spect_all_conds./10)).*shiftdim(repmat(baseline_ave_all_conds.',[1,1,467]),1);



%% calculate new dB
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_23/different_dB
load spect_pixel_wise_cond6_res_64_bl8_hb_no_dB
dB=squeeze(mean(spect_pixel_wise_cond6,2));
save dB_cond6 dB
clear spect_pixel_wise_cond6

%% activate new dB

for i=1:6
    disp('hi');
    cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_23/different_dB
    eval(['load spect_pixel_wise_cond',int2str(i),'_res_64_bl8_hb_no_dB']); 
    eval(['spect_pixel_wise_cond',int2str(i),'=10*log10(spect_pixel_wise_cond',int2str(i),'./shiftdim(repmat(dB.'',[1,1,223]),1));']);
    cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_23/different_dB
    eval(['save spect_pixel_wise_cond',int2str(i),'_res_64_bl8_hb_new_dB spect_pixel_wise_cond',int2str(i)]);
    eval(['clear spect_pixel_wise_cond',int2str(i)]);
end