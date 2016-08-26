% choose a band of your choice. use ctrl+H
%% alpha filter
% filter specifications
wn=[4/50 9/50]; %cutoff frequencies. choose bottom top or both
db=6;
%[b,a] = cheby1(6,db,wn);
[b,a] = cheby2(6,db,wn);
%[b,a] = butter(db,wn);  %build a filter

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


win=16;

for i=[4 6]
    disp(i)
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['cond',int2str(i),'n_dt_bl(isnan(cond',int2str(i),'n_dt_bl))=1;'])
    %extrapolate data. Add 100 random point in the baseline (taken from the
    %baseline). this is true for the vsdi data only.
    
    r=floor(rand(1,100)*19)+2;
    eval(['v=cond',int2str(i),'n_dt_bl(:,r,:);']);
    eval(['cond',int2str(i),'n_dt_bl=cat(2,v,cond',int2str(i),'n_dt_bl(:,2:110,:));'])
    
    % add also at the end
    %r=floor(rand(1,100)*19)+100;
    %eval(['v=cond',int2str(i),'n_dt_bl(:,r,:);']);
    %eval(['cond',int2str(i),'n_dt_bl=cat(2,cond',int2str(i),'n_dt_bl,v);'])
    
    %eval(['cond',int2str(i),'n_dt_bl=cond',int2str(i),'n_dt_bl(:,2:115,:);'])
    
    %eval(['cond',int2str(i),'n_dt_bl=cat(2,cond',int2str(i),'n_dt_bl(:,100:-1:2,:),cond',int2str(i),'n_dt_bl(:,2:100,:),cond',int2str(i),'n_dt_bl(:,100:-1:2,:));'])
    
    eval(['x=size(cond',int2str(i),'n_dt_bl,3);'])
    eval(['y=size(cond',int2str(i),'n_dt_bl,2);'])
    eval(['alpha',int2str(i),'n_dt_bl=zeros(10000,y-1,x);'])
    tic
    for k=pixels'
        
        eval(['alpha',int2str(i),'n_dt_bl(k,:,:)=filtfilt(b,a,squeeze(cond',int2str(i),'n_dt_bl(k,2:end,:))-1);'])
        
    end
    %eval(['alpha',int2str(i),'n_dt_bl=abs(alpha',int2str(i),'n_dt_bl);'])
    eval(['save alpha101',int2str(i),'n_dt_bl alpha',int2str(i),'n_dt_bl db wn'])
    %eval(['clear alpha',int2str(i),'n_dt_bl'])
    toc
    eval(['clear cond',int2str(i),'n_dt_bl'])
    eval(['alphaRMS',int2str(i),'n_dt_bl=zeros(10000,y-win,x);'])
    for j=1:y-win
        eval(['alphaRMS',int2str(i),'n_dt_bl(:,j,:)=squeeze(sqrt(mean(alpha',int2str(i),'n_dt_bl(:,j:j+win-1,:).^2,2)));'])
    end
    eval(['save alpha101RMS',int2str(i),'n_dt_bl alphaRMS',int2str(i),'n_dt_bl db wn'])
    eval(['clear alpha',int2str(i),'n_dt_bl'])
    eval(['clear alphaRMS',int2str(i),'n_dt_bl'])
end
