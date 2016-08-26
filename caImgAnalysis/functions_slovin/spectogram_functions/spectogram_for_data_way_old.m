function [spect_ave]=spectogram_for_data_way_old(data,win,baseline)
%this function calculates a spectogram for a data set
%the data variable should be 3d matrix of all the trials 
%the win input variable is the size of the window that will be calculted in
%the spectogram. It should be in frame numbers
%the baseline input variable should be a vector that sets the baseline of
%each pixel (row in the 3d matrix). Baseline is calculated from the begining of each trial from this baseline the DB will be
%calculated for each pixel and for each window
%each window transform the time domain through a fft using a hamming window
%and the output is in DB
data=data(:,2:end,:)-1;
NFFT = 2^nextpow2(max(size(baseline,2),win));
spect=zeros(NFFT,size(data,2)-win,size(data,1));
for h=1:size(data,3)
    disp(h)
    w=hamming(size(baseline,2)).';
    data_baseline=data(:,1:size(baseline,2),h);
    data_baseline=data_baseline.*w(1*ones(1,size(data,1)),:);
    b=fft(data_baseline,NFFT,2);
    Pxx_b=b.*conj(b);
    for j=1:(size(data,2)-win) 
        w=hamming(win).';
        %data_win=data(:,j:j+win-1,h);
        data_win=w(1*ones(1,size(data,1)),:).*data(:,j:j+win-1,h);
        y=fft(data_win,NFFT,2);
        Pxx=y.*conj(y);
        Pxx=10*log10(Pxx./Pxx_b);
        clear y data_win data_baseline b;
        spect(:,j,:)=Pxx.';
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
   spect_ave(i,:,:)=spect_ave(i,:,:)/h;
end;