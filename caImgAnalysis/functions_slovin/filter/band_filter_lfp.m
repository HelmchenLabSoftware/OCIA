% choose a band of your choice. use ctrl+H
%% lowgamma filter
% filter specifications
wn=[13/125 25/125]; %cutoff frequencies. choose bottom top or both
db=6;

%[b,a] = butter(db,wn);  %build a filter
[b,a] = cheby2(6,db,wn);

load time_cond3_2804a
lfp=lfp_cond3;
n='2804a';

win=16;

for i=[1]
    disp(i)
    x=size(lfp,1);
    y=size(lfp,2);
    eval(['lowgamma_',int2str(i),'_',n,'=zeros(y,x);'])
    eval(['lowgamma_',int2str(i),'_',n,'=filtfilt(b,a,lfp(:,:,i));'])
    %eval(['save lowgamma_',int2str(i),'_',n,' lowgamma_',int2str(i),'_',n,' db wn'])
    %eval(['clear lowgamma_',int2str(i),'_',n])
    
    eval(['lowgammaRMS_',int2str(i),'_',n,'=zeros(x-win,y);'])
    for j=1:x-win
        eval(['lowgammaRMS_',int2str(i),'_',n,'(j,:)=squeeze(sqrt(mean(lowgamma_',int2str(i),'_',n,'(j:j+win-1,:).^2,1)));'])
    end
    %eval(['save lowgammaRMS_',int2str(i),'_',n,' lowgammaRMS',int2str(i),'_',n,' db wn'])
end





