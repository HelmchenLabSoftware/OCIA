%%% create frequency bands
clear all
for i=1:6 %condition count
    cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/spect_trials
    eval(['a=dir(''spect_pixels_cond',int2str(i),'*'');']);
    for j=1:size(a,1) %trial counnnt don't put anything else in this folder
        disp(['cond #',int2str(i),' trial #',int2str(j)])
        cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/spect_trials
        eval(['load spect_pixels_cond',int2str(i),'_trial_',int2str(j)])
        for k=1:6 %band count
            eval(['band_',int2str((1+5*(k-1))*2),'_',int2str((5+5*(k-1))*2),' = squeeze(mean(spect_pixel_wise(',int2str(1+5*(k-1)),':',int2str(5+5*(k-1)),',:,:),1));'])
            cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/frequency_bands
            eval(['save cond',int2str(i),'_trial_',int2str(j),'_band_',int2str((1+5*(k-1))*2),'_',int2str((5+5*(k-1))*2),' band_',int2str((1+5*(k-1))*2),'_',int2str((5+5*(k-1))*2)])
            eval(['clear band_',int2str((1+5*(k-1))*2),'_',int2str((5+5*(k-1))*2)])
        end;
        for k=7:9 %band count
            eval(['band_',int2str((1+5*(k-1))*2),'_',int2str((10+5*(k-1))*2),' = squeeze(mean(spect_pixel_wise(',int2str(1+5*(k-1)),':',int2str(10+5*(k-1)),',:,:),1));'])
            cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/frequency_bands
            eval(['save cond',int2str(i),'_trial_',int2str(j),'_band_',int2str((1+5*(k-1))*2),'_',int2str((10+5*(k-1))*2),' band_',int2str((1+5*(k-1))*2),'_',int2str((10+5*(k-1))*2)])
            eval(['clear band_',int2str((1+5*(k-1))*2),'_',int2str((10+5*(k-1))*2)]);
        end;
        clear spect_pixel_wise
    end;
end;