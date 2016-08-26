function [spect_ave,spect_ave_sig,baseline_ave,baseline_std]=spectogram_for_data(data,win,baseline)
%this function calculates a spectogram for a data set
%the data variable should be 3d matrix of all the trials 
%the win input variable is the size of the window that will be calculted in
%the spectogram. It should be in frame numbers
%the baseline input variable should be a vector that sets the baseline of
%each pixel (row in the 3d matrix). Baseline is calculated from the begining of each trial from this baseline the DB will be
%calculated for each pixel and for each window
%each window transform the time domain through a fft using a hamming window
%and the output is in DB
data=data(:,2:end,:);
NFFT = 2^nextpow2(max(size(baseline,2),2*(win+1)));
spect=zeros(NFFT/2,size(data,2)-win,size(data,1));
for h=1:size(data,3)
    disp(h)
    for j=1:(size(data,2)-win)
        w=hamming(win).';
        %w=hann(win).';
        %data_win=data(:,j:j+win-1,h);
        data_win=w(1*ones(1,size(data,1)),:).*(data(:,j:j+win-1,h)-repmat(mean(data(:,j:j+win-1,h),2),[size(data,1),win,size(data,3)]));
        y=fft(data_win,NFFT,2);
        %y=y./win;
        %y = y(:,2:2*win/2+1);
        %Pxx=2/0.375*abs(y).^2;
        Pxx=y.*conj(y);
        clear y data_win;
        spect(:,j,:)=Pxx(:,2:NFFT/2+1).';
        clear Pxx
    end;
    if h==1
        spect_ave=spect;
    else
        for i=1:size(spect,1)
            disp(i)
            spect_ave(i,:,:)=spect_ave(i,:,:)+spect(i,:,:);
        end;
    end;
end;
for i=1:size(spect,1)
   disp(i) 
   spect_ave(i,:,:)=spect_ave(i,:,:)./h;
end;
baseline_ave=nanmean(nanmean(spect_ave(:,baseline,:),2),3);
baseline_std = std(std(spect_ave(:,baseline,:),0,2),0,3);
spect_ave=10*(log10(spect_ave)-log10(baseline_ave(:,1*ones(1,size(spect_ave,2)),1*ones(1,size(spect_ave,3)))));


%% after computing the spectogram, check for significance
% significance is calculated by comparing the spectogram data to 2 times of the std of the baseline
upper_limit=baseline_ave+2*baseline_std;
bottom_limit=baseline_ave-2*baseline_std;
spect_ave_upper=spect_ave-repmat(upper_limit,[1,size(spect_ave,2),size(spect_ave,3)]);
spect_ave_bottom=spect_ave-repmat(bottom_limit,[1,size(spect_ave,2),size(spect_ave,3)]);
for i=1:size(spect_ave,3)
    [r,c,v]=find(spect_ave_upper(:,:,i)>0);
    spect_ave_upper(r,c,i)=0;
    [r,c,v]=find(spect_ave_bottom(:,:,i)>0);
    spect_ave_bottom(r,c,i)=0;
end;    
spect_ave_sig=spect_ave_bottom+spect_ave_upper;

%%



