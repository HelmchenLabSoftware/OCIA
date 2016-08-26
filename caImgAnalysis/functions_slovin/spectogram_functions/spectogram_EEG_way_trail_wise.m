function []=spectogram_EEG_way_trail_wise(win,baseline)
%this function computes the spectogram for each trial for each pixel
%the trial are saved in the spect_trials folder
%the baseline average is also calculated
spect_pixel_wise=NaN*ones(64,223,10000); %this is the spectogram matrix for each trial
baseline_ave_pixels=NaN*ones(64,10000); %this is the baseline average matrix for each trial
baseline_std_pixels=NaN*ones(64,10000); %this is the baseline std matrix for each trial
for i=1:6 %condition count
    cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_23/cond_data_b
    eval(['load cond',int2str(i),'n_dt_hb']) %load the file
    eval(['data=cond',int2str(i),'n_dt_hb;'])
    eval(['clear cond',int2str(i),'n_dt_hb']);
    cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_23/spect_trials
    for j=1:size(data,3) %trial count
        disp(['cond #',int2str(i),' trial #',int2str(j)])
        for k=1:size(data,1) %pixel count
            [spect,baseline_ave,baseline_std]=spectogram_for_data_EEG_way(data(k,2:256,j),win,baseline,k);  %calculate spectogram  
            spect_pixel_wise(:,:,k)=spect;
            baseline_ave_pixels(:,k)=baseline_ave;
            baseline_std_pixels(:,k)=baseline_std;
        end;
        eval(['save spect_pixels_cond',int2str(i),'_trial_',int2str(j),' spect_pixel_wise baseline_ave_pixels']);
    end;
    eval(['clear cond',int2str(i),'n_dt_hb']);
end;

%% create frequency bands
clear all
for i=1:6 %condition count
    cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_23/spect_trials
    eval(['a=dir(''spect_pixels_cond',int2str(i),'*'');']);
    for j=1:size(a,1) %trial counnnt don't put anything else in this folder
        disp(['cond #',int2str(i),' trial #',int2str(j)])
        cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_23/spect_trials
        eval(['load spect_pixels_cond',int2str(i),'_trial_',int2str(j)])
        for k=1:6 %band count
            eval(['band_',int2str((1+5*(k-1))*2),'_',int2str((5+5*(k-1))*2),' = squeeze(mean(spect_pixel_wise(',int2str(1+5*(k-1)),':',int2str(5+5*(k-1)),',:,:),1));'])
            cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_23/frequency_bands
            eval(['save cond',int2str(i),'_trial_',int2str(j),'_band_',int2str((1+5*(k-1))*2),'_',int2str((5+5*(k-1))*2),' band_',int2str((1+5*(k-1))*2),'_',int2str((5+5*(k-1))*2)])
            eval(['clear band_',int2str((1+5*(k-1))*2),'_',int2str((5+5*(k-1))*2)])
        end;
        for k=7:9 %band count
            eval(['band_',int2str((1+5*(k-1))*2),'_',int2str((10+5*(k-1))*2),' = squeeze(mean(spect_pixel_wise(',int2str(1+5*(k-1)),':',int2str(10+5*(k-1)),',:,:),1));'])
            cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_23/frequency_bands
            eval(['save cond',int2str(i),'_trial_',int2str(j),'_band_',int2str((1+5*(k-1))*2),'_',int2str((10+5*(k-1))*2),' band_',int2str((1+5*(k-1))*2),'_',int2str((10+5*(k-1))*2)])
            eval(['clear band_',int2str((1+5*(k-1))*2),'_',int2str((10+5*(k-1))*2)]);
        end;
        clear spect_pixel_wise
    end;
end;
    

%% create band trial matrix
clear all
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_23/frequency_bands
for i=1:6 %condition count
    cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_23/spect_trials
    eval(['a=dir(''spect_pixels_cond',int2str(i),'*'');']);
    cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_23/frequency_bands
    for k=1:6 %band count
        b=size(a,1);
        eval(['cond',int2str(i),'_band_',int2str((1+5*(k-1))*2),'_',int2str((5+5*(k-1))*2),'=zeros(223,10000,',int2str(b),');']);
        for j=1:size(a) %trial count
            disp(['cond #',int2str(i),' trial #',int2str(j)])
            eval(['load cond',int2str(i),'_trial_',int2str(j),'_band_',int2str((1+5*(k-1))*2),'_',int2str((5+5*(k-1))*2)]);
            eval(['cond',int2str(i),'_band_',int2str((1+5*(k-1))*2),'_',int2str((5+5*(k-1))*2),'(:,:,',int2str(j),')=band_',int2str((1+5*(k-1))*2),'_',int2str((5+5*(k-1))*2),';']);
            eval(['clear band_',int2str((1+5*(k-1))*2),'_',int2str((5+5*(k-1))*2)])
        end;
        eval(['save cond',int2str(i),'_band_',int2str((1+5*(k-1))*2),'_',int2str((5+5*(k-1))*2),' cond',int2str(i),'_band_',int2str((1+5*(k-1))*2),'_',int2str((5+5*(k-1))*2)]);
        eval(['clear cond',int2str(i),'_band_',int2str((1+5*(k-1))*2),'_',int2str((5+5*(k-1))*2)]);
    end;
    for k=7:9 %band count
        b=size(a,1);
        eval(['cond',int2str(i),'_band_',int2str((1+5*(k-1))*2),'_',int2str((10+5*(k-1))*2),'=zeros(223,10000,',int2str(b),');']);
        for j=1:size(a)
            eval(['load cond',int2str(i),'_trial_',int2str(j),'_band_',int2str((1+5*(k-1))*2),'_',int2str((10+5*(k-1))*2)]);
            eval(['cond',int2str(i),'_band_',int2str((1+5*(k-1))*2),'_',int2str((10+5*(k-1))*2),'(:,:,',int2str(j),')=band_',int2str((1+5*(k-1))*2),'_',int2str((10+5*(k-1))*2),';']);
            eval(['clear band_',int2str((1+5*(k-1))*2),'_',int2str((10+5*(k-1))*2)])
        end;
        eval(['save cond',int2str(i),'_band_',int2str((1+5*(k-1))*2),'_',int2str((10+5*(k-1))*2),' cond',int2str(i),'_band_',int2str((1+5*(k-1))*2),'_',int2str((10+5*(k-1))*2)]);
        eval(['clear cond',int2str(i),'_band_',int2str((1+5*(k-1))*2),'_',int2str((10+5*(k-1))*2)]);
    end; 
end;
        
        

        
