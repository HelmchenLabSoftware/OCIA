cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/rois
load roi_1
load roi_2
load roi_3
load roi_V1
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/cond_data
load cond1n_dt_bl;
[PSD_EEG]=EEG_transform(cond1n_dt_bl);
[PSD_EEG_ROI]=transform_EEG_ROI(PSD_EEG,roi_2);
%[ersp_roi2,itc,powbase,times,freqs,erspboot,itcboot,itcphase] = timef(PSD_EEG_ROI,255,[-112 255*4-112],250,0,'winsize',16,'maxfreq',125,'timesout',239);
[spect_ave_roi2,baseline_ave]=spectogram_for_data_EEG_way(cond1n_dt_bl,32,1:12,roi_2);
[PSD_EEG_ROI]=transform_EEG_ROI(PSD_EEG,roi_1);
%[ersp_roi1,itc,powbase,times,freqs,erspboot,itcboot,itcphase] = timef(PSD_EEG_ROI,255,[-112 255*4-112],250,0,'winsize',16,'maxfreq',125,'timesout',239);
[spect_ave_roi1,baseline_ave]=spectogram_for_data_EEG_way(cond1n_dt_bl,32,1:12,roi_1);
save spect_cond1 spect_ave_roi2 spect_ave_roi1 %ersp_roi2 ersp_roi1;
clear all
pack
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/rois
load roi_1
load roi_2
load roi_3
load roi_V1
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/cond_data
load cond2n_dt_bl;
[PSD_EEG]=EEG_transform(cond2n_dt_bl);
[PSD_EEG_ROI]=transform_EEG_ROI(PSD_EEG,roi_2);
%[ersp_roi2,itc,powbase,times,freqs,erspboot,itcboot,itcphase] = timef(PSD_EEG_ROI,255,[-112 255*4-112],250,0,'winsize',16,'maxfreq',125,'timesout',239);
[spect_ave_roi2,baseline_ave]=spectogram_for_data_EEG_way(cond2n_dt_bl,32,1:12,roi_2);
[PSD_EEG_ROI]=transform_EEG_ROI(PSD_EEG,roi_1);
%[ersp_roi1,itc,powbase,times,freqs,erspboot,itcboot,itcphase] = timef(PSD_EEG_ROI,255,[-112 255*4-112],250,0,'winsize',16,'maxfreq',125,'timesout',239);
[spect_ave_roi1,baseline_ave]=spectogram_for_data_EEG_way(cond2n_dt_bl,32,1:12,roi_1);
save spect_cond2 spect_ave_roi2 spect_ave_roi1 %ersp_roi2 ersp_roi1;
clear all
pack
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/rois
load roi_1
load roi_2
load roi_3
load roi_V1
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/cond_data
load cond3n_dt_bl;
[PSD_EEG]=EEG_transform(cond3n_dt_bl);
[PSD_EEG_ROI]=transform_EEG_ROI(PSD_EEG,roi_2);
%[ersp_roi2,itc,powbase,times,freqs,erspboot,itcboot,itcphase] = timef(PSD_EEG_ROI,255,[-112 255*4-112],250,0,'winsize',16,'maxfreq',125,'timesout',239);
[spect_ave_roi2,baseline_ave]=spectogram_for_data_EEG_way(cond3n_dt_bl,32,1:12,roi_2);
[PSD_EEG_ROI]=transform_EEG_ROI(PSD_EEG,roi_1);
%[ersp_roi1,itc,powbase,times,freqs,erspboot,itcboot,itcphase] = timef(PSD_EEG_ROI,255,[-112 255*4-112],250,0,'winsize',16,'maxfreq',125,'timesout',239);
[spect_ave_roi1,baseline_ave]=spectogram_for_data_EEG_way(cond3n_dt_bl,32,1:12,roi_1);
save spect_cond3 spect_ave_roi2 spect_ave_roi1 %ersp_roi2 ersp_roi1;
clear all
pack
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/rois
load roi_1
load roi_2
load roi_3
load roi_V1
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/cond_data
load cond4n_dt_bl;
[PSD_EEG]=EEG_transform(cond4n_dt_bl);
[PSD_EEG_ROI]=transform_EEG_ROI(PSD_EEG,roi_2);
%[ersp_roi2,itc,powbase,times,freqs,erspboot,itcboot,itcphase] = timef(PSD_EEG_ROI,255,[-112 255*4-112],250,0,'winsize',16,'maxfreq',125,'timesout',239);
[spect_ave_roi2,baseline_ave]=spectogram_for_data_EEG_way(cond4n_dt_bl,32,1:12,roi_2);
[PSD_EEG_ROI]=transform_EEG_ROI(PSD_EEG,roi_1);
%[ersp_roi1,itc,powbase,times,freqs,erspboot,itcboot,itcphase] = timef(PSD_EEG_ROI,255,[-112 255*4-112],250,0,'winsize',16,'maxfreq',125,'timesout',239);
[spect_ave_roi1,baseline_ave]=spectogram_for_data_EEG_way(cond4n_dt_bl,32,1:12,roi_1);
save spect_cond4 spect_ave_roi2 spect_ave_roi1 %ersp_roi2 ersp_roi1;
clear all
pack
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/rois
load roi_1
load roi_2
load roi_3
load roi_V1
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/cond_data
load cond5n_dt_bl;
[PSD_EEG]=EEG_transform(cond5n_dt_bl);
[PSD_EEG_ROI]=transform_EEG_ROI(PSD_EEG,roi_2);
%[ersp_roi2,itc,powbase,times,freqs,erspboot,itcboot,itcphase] = timef(PSD_EEG_ROI,255,[-112 255*4-112],250,0,'winsize',16,'maxfreq',125,'timesout',239);
[spect_ave_roi2,baseline_ave]=spectogram_for_data_EEG_way(cond5n_dt_bl,32,1:12,roi_2);
[PSD_EEG_ROI]=transform_EEG_ROI(PSD_EEG,roi_1);
%[ersp_roi1,itc,powbase,times,freqs,erspboot,itcboot,itcphase] = timef(PSD_EEG_ROI,255,[-112 255*4-112],250,0,'winsize',16,'maxfreq',125,'timesout',239);
[spect_ave_roi1,baseline_ave]=spectogram_for_data_EEG_way(cond5n_dt_bl,32,1:12,roi_1);
save spect_cond5 spect_ave_roi2 spect_ave_roi1 %ersp_roi2 ersp_roi1;
clear all
pack
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/rois
load roi_1
load roi_2
load roi_3
load roi_V1
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/cond_data
load cond6n_dt_bl;
[PSD_EEG]=EEG_transform(cond6n_dt_bl);
[PSD_EEG_ROI]=transform_EEG_ROI(PSD_EEG,roi_2);
%[ersp_roi2,itc,powbase,times,freqs,erspboot,itcboot,itcphase] = timef(PSD_EEG_ROI,255,[-112 255*4-112],250,0,'winsize',16,'maxfreq',125,'timesout',239);
[spect_ave_roi2,baseline_ave]=spectogram_for_data_EEG_way(cond6n_dt_bl,32,1:12,roi_2);
[PSD_EEG_ROI]=transform_EEG_ROI(PSD_EEG,roi_1);
%[ersp_roi1,itc,powbase,times,freqs,erspboot,itcboot,itcphase] = timef(PSD_EEG_ROI,255,[-112 255*4-112],250,0,'winsize',16,'maxfreq',125,'timesout',239);
[spect_ave_roi1,baseline_ave]=spectogram_for_data_EEG_way(cond6n_dt_bl,32,1:12,roi_1);
save spect_cond6 spect_ave_roi2 spect_ave_roi1 %ersp_roi2 ersp_roi1;
clear all

