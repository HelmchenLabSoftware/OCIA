function [spect_ave,baseline_ave,baseline_std]=spectogram_for_data_EEG_way(data,win,baseline,roi)
%this function calculates a spectogram for a data set
%the data variable should be 3d matrix of all the trials 
%the win input variable is the size of the window that will be calculted in
%the spectogram. It should be in frame numbers
%the baseline input variable should be a vector that sets the baseline of
%each pixel (row in the 3d matrix). Baseline is calculated from the begining of each trial from this baseline the DB will be
%calculated for each pixel and for each window
%each window transform the time domain through a fft using a hamming window
%and the output is in DB
%data=data-1;
k=0;
%[PSD_EEG]=EEG_transform(data); use these function when you want to chain
%your data the EEGlab way
%clear data
%[PSD_EEG_ROI]=transform_EEG_ROI(PSD_EEG,roi);
%clear PSD_EEG
PSD_EEG_ROI=data; %this line is for the spectogram_pixel_wise function
clear data;
NFFT = 128; %2^nextpow2(max(size(baseline,2),4*(win+1)));
spect=zeros(NFFT/2,512-win-1);             %when returning to the original data use size(data,2)
for h=1:512-1:size(PSD_EEG_ROI,2)      %when returning to the original data use size(data,2)
    k=k+1;
    %disp(h)
    for j=1:(512-win-1)      %when returning to the original data use size(data,2)
        %w=hamming(win).';
        w=hanning(win).';
        data_win=w.*(PSD_EEG_ROI(h+j-1:h+j+win-2)-mean(PSD_EEG_ROI(h+j-1:h+j+win-2)));
        y=fft(data_win,NFFT);
        y=y./win;
        y = y(:,2:NFFT/2+1);
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
end;
spect_ave=spect_ave./k;
baseline_ave=nanmean(spect_ave(:,baseline),2); 
baseline_std =std(spect_ave(:,baseline),0,2);
spect_ave=10*(log10(spect_ave)-log10(baseline_ave(:,1*ones(1,size(spect_ave,2)))));
        
        
      