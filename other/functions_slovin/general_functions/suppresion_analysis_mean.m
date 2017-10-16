%% Normalization
%clear all

c=1;

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

x1=(2:2:1280)*2-305;
x2=(1:256)*10-280;

eval(['load cond',int2str(c),'n_dt_bl'])
eval(['tr=size(cond',int2str(c),'n_dt_bl,3);']);
eval(['cond=(mean(cond',int2str(c),'n_dt_bl,3)-1);'])
eval(['clear cond',int2str(c),'n_dt_bl'])

peak=zeros(10000,1);

    for j=1:10000
        peak(j)=max(cond(j,28:58),[],2);
    end


%cond=(cond)./repmat(peak,[1 256]);
%cond=(cond)./max(max(peak(pixels,:)));
%cond=(cond)./max(mean(peak(pixels,:),2));
%cond=(cond)./repmat(mean(peak,2),[1 256 tr]);

%% Calculating indeces
minpeak=zeros(10000,1);
minpeak_time=zeros(10000,1);
peak_time=zeros(10000,1);

    for j=1:10000
        peak(j)=max(cond(j,28:58),[],2);
        peak_time(j)=find(cond(j,:)==max(cond(j,28:48),[],2));
        minpeak(j)=min(cond(j,peak_time(j):58),[],2);
        minpeak_time(j)=find(cond(j,:)==min(cond(j,peak_time(j):58),[],2));
        
    end

mod=(minpeak./peak)*100;
mod2=(peak-minpeak)./(minpeak+peak);
mod3=(peak-minpeak);
mod4=(peak+minpeak)-(minpeak-peak);

mod_time=minpeak_time-peak_time;

%% Calculating derivatives
d=4;
der=cond(:,2+d:58)-cond(:,2:58-d);
der_peak=zeros(10000,53);
minder_time=zeros(10000,1);
minder=zeros(10000,1);
maxder=zeros(10000,1);


    for j=1:10000
        minder_time(j)=find(der(j,:)==min(der(j,28:end),[],2));
        minder(j)=min(der(j,28:end),[],2);
        maxder(j)=max(der(j,28:end),[],2);
        der_peak(j,1:end-peak_time(j)+1+2)=der(j,peak_time(j)-2:end);
    end



