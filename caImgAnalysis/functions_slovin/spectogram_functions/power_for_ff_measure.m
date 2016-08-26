cd F:\Data\VSDI\figure_figure\tolkin\25may2011\b

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t
cd F:\Data\VSDI\figure_figure\tolkin\25may2011
load('amp_ff_fgt_fgb_trials_bcf.mat')
time=[48 49 50:51 53];


NFFT =64;
win=16;
Pxx=NaN*ones(NFFT/2,256-win,size(ff_two,2));
for i=1:size(ff_two,2) %condition count 
    disp(i)
    ttt=ff_two(:,i);
    
    
    data_win=zeros(1,32);
    for j=1:(256-win) 
        w=hamming(win).';
        data_win=w'.*(ttt(j:j+win-1)-mean(ttt(j:j+win-1)));
        %w=hanning(win).';
        y=fft(data_win.',NFFT);
        y=y./win;
        y = y(2:NFFT/2+1);
        Pxx(:,j,i)=abs(y).^2; 
    end
end;             

a=10*log10(Pxx./repmat(mean(Pxx(:,2:11,:),2),[1 240 1]));
a(isnan(a))=0;
a(isinf(a))=0;
f=1:50/32:50;
figure(1);plot(f,nanmean(nanmean(a(:,20:40,:),2),3),'r')
hold on
%%

cd F:\Data\VSDI\figure_figure\tolkin\25may2011\b

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t
cd F:\Data\VSDI\figure_figure\tolkin\25may2011
load('amp_ff_fgt_fgb_trials_bcf.mat')
time=[48 49 50:51 53];

NFFT =64;
win=16;
Pxx=NaN*ones(NFFT/2,256-win,size(ff_two,2));
for i=1:size(ff_two,2) %condition count 
    disp(i)
    ttt=top_two(:,i);
    
    
    data_win=zeros(1,32);
    for j=1:(256-win) 
        w=hamming(win).';
        data_win=w'.*(ttt(j:j+win-1)-mean(ttt(j:j+win-1)));
        %w=hanning(win).';
        y=fft(data_win.',NFFT);
        y=y./win;
        y = y(2:NFFT/2+1);
        Pxx(:,j,i)=abs(y).^2; 
    end
end;             

a=10*log10(Pxx./repmat(mean(Pxx(:,2:11,:),2),[1 240 1]));
a(isnan(a))=0;
a(isinf(a))=0;

f=1:50/32:50;
figure(1);plot(f,nanmean(nanmean(a(:,20:40,:),2),3))







