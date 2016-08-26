%% create band trial matrix
clear all
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/frequency_bands
for i=1:6 %condition count
    cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/spect_trials
    eval(['a=dir(''spect_pixels_cond',int2str(i),'*'');']);
    cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/frequency_bands
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
        