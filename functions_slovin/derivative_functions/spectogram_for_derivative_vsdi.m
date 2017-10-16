%% calculate spectogram for derivative for all conds 
clear all
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_02_19/derivative
for i=1:6 %condition count
    win=32; %choose a window size
    bl=1:25; %choose baseline
    disp(['cond #',int2str(i),' please wait'])
    eval(['load der_cond',int2str(i)])
    eval(['data_t=der_cond',int2str(i),'(:,1:end,1);'])
    eval(['a=size(der_cond',int2str(i),',3);'])
    for k=2:a
        eval(['data_t=[data_t der_cond',int2str(i),'(:,1:end,k)];'])
    end;
    clear data;
    eval(['spect_pixel_wise_der=NaN*ones(64,size(der_cond',int2str(i),',2)-win,10000);'])
    baseline_ave_pixels=NaN*ones(64,10000);
    baseline_std_pixels=NaN*ones(64,10000);
    for k=1:10000
        [spect_ave,baseline_ave,baseline_std]=spectogram_for_data_EEG_way_der(data_t(k,:),win,bl,k);
        spect_pixel_wise_der(:,:,k)=spect_ave;
        baseline_ave_pixels(:,k)=baseline_ave;
        baseline_std_pixels(:,k)=baseline_std;
    end;
    eval(['save spect_pixel_wise_der_cond',int2str(i),' spect_pixel_wise_der'])
    eval(['save baseline_ave_pixels_cond',int2str(i),' baseline_ave_pixels baseline_std_pixels'])
    clear all
end;
