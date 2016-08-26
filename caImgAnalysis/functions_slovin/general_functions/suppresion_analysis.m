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
eval(['cond=(cond',int2str(c),'n_dt_bl-1);'])
eval(['clear cond',int2str(c),'n_dt_bl'])

peak=zeros(10000,tr);
minpeak=zeros(10000,tr);
for i=1:tr
    for j=1:10000
        peak(j,i)=max(cond(j,28:58,i),[],2);
        minpeak(j,i)=min(cond(j,28:58,i),[],2);
        
    end
end

%cond=(cond)-permute(repmat(minpeak,[1 1 256]),[1 3 2]);
%cond=(cond)./permute(repmat(peak,[1 1 256]),[1 3 2]);
%cond=(cond)./max(max(peak(pixels,:)));
%cond=(cond)./max(mean(peak(pixels,:),2));
%cond=(cond)./repmat(mean(peak,2),[1 256 tr]);

%% Calculating indeces
minpeak=zeros(10000,tr);
minpeak_time=zeros(10000,tr);
peak_time=zeros(10000,tr);
for i=1:tr
    for j=1:10000
        peak(j,i)=max(cond(j,28:58,i),[],2);
        peak_time(j,i)=find(cond(j,:,i)==max(cond(j,28:48,i),[],2));
        minpeak(j,i)=min(cond(j,peak_time(j,i):58,i),[],2);
        minpeak_time(j,i)=find(cond(j,:,i)==min(cond(j,peak_time(j,i):58,i),[],2));
        
    end
end
mod=(minpeak./peak)*100;
mod2=(peak-minpeak)./(minpeak+peak);
mod3=(peak-minpeak);
mod4=(peak+minpeak)-(minpeak-peak);
mod5=(mean(minpeak,2)./mean(peak,2))*100;

mod_time=minpeak_time-peak_time;

%% Calculating derivatives
d=4;
der=cond(:,2+d:58,:)-cond(:,2:58-d,:);
der_peak=zeros(10000,53,20);
minder_time=zeros(10000,tr);
minder=zeros(10000,tr);
maxder=zeros(10000,tr);

for i=1:tr
    for j=1:10000
        minder_time(j,i,:)=find(der(j,:,i)==min(der(j,28:end,i),[],2));
        minder(j,i,:)=min(der(j,28:end,i),[],2);
        maxder(j,i,:)=max(der(j,28:end,i),[],2);
        der_peak(j,1:end-peak_time(j,i)+1+2,i)=der(j,peak_time(j,i)-2:end,i);
    end
end









