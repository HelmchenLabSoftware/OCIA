function [spect_ave]=spectogram_for_LFP_trial_wise(data,win,baseline,len)
cd /fat2/Ariel_Gilad/Matlab_analysis/lfp/leg_2008_03_06/leg_2008_03_06_e
mkdir spect_trials;
cd /fat2/Ariel_Gilad/Matlab_analysis/lfp/leg_2008_03_06/leg_2008_03_06_e/spect_trials %directory of trials
for i=1:6 %condition count
    NFFT = 128;
    spect=zeros(NFFT/2,len-win-1); 
    spect_trial=zeros(NFFT/2,len-win-1,size(data,2));
    baseline_ave=zeros(NFFT/2,size(data,2));
    for h=1:size(data,2)  %trial count   
        for j=1:(len-win-1) %window count      
            %w=hamming(win).';
            w=hanning(win);
            data_win=w.*(data(h+j-1:h+j+win-2,h,i)-mean(data(h+j-1:h+j+win-2,h,i),1));
            y=fft(data_win,NFFT);
            y=y./win;
            y = y(2:NFFT/2+1);
            Pxx=2/0.375*abs(y).^2;
            %Pxx=y.*conj(y);
            clear y data_win;
            spect(:,j)=Pxx;%(2:NFFT/2+1).';
            clear Pxx
        end;
        if h==1
            spect_ave=spect;
        else
            spect_ave=spect_ave+spect;
        end;
        %eval(['save spect_cond',int2str(i),'_trial',int2str(h),' spect']); 
        baseline_ave(:,h)=nanmean(spect(:,baseline),2); 
        %baseline_std =std(spect(:,baseline),0,2);
        spect=10*(log10(spect)-log10(repmat(nanmean(spect(:,baseline),2),1,len-win-1)));
        spect_trial(:,:,h)=spect;
    end;
    spect_ave=spect_ave./h;    
    eval(['save spect_trials_cond',int2str(i),' spect_trial']);
    eval(['save spect_baseline_cond',int2str(i),' baseline_ave']);
end;       