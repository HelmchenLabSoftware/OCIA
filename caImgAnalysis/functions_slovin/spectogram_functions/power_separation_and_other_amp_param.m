% projection


y=[1 -1;1 1];
for i=1:size(pow3_V1,2)
    temp=[pow3_V1(i) pow4_V1(i)]*y*(-1);
    proj_pow(i)=temp(2);
end


%%
%separating by pixels
pow3_V1=squeeze(mean(mean(b(23:27,roi_V1,:),1),3));
pow4_V1=squeeze(mean(mean(a(23:27,roi_V1,:),1),3));

lim=[-2:0.3:6];

[n,x1]=hist(pow3_V1,lim);
[c,x2]=hist(pow4_V1,lim);

figure;
bar(lim,[n;c]')


pow3_V1=squeeze(max(mean(b(20:30,roi_V1,:),3),[],1));
pow4_V1=squeeze(max(mean(a(20:30,roi_V1,:),3),[],1));

lim=[-2:0.3:6];

[n,x1]=hist(pow3_V1,lim);
[c,x2]=hist(pow4_V1,lim);

figure;
bar(lim,[n;c]')


%separating by trials
t=24:31;
pow3_V1=squeeze(mean(mean(b(t,roi_V1,:),1),2));
pow4_V1=squeeze(mean(mean(a(t,roi_V1,:),1),2));

lim=[-4:0.5:6];

[n,x1]=hist(pow3_V1,lim);
[c,x2]=hist(pow4_V1,lim);

figure;
bar(lim,[n;c]')


scores=[pow3_V1;pow4_V1]';
labels=zeros(1,size(scores,2));
labels(size(pow3_V1,1)+1:end)=1;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


%max power
pow3_V1=squeeze(max(mean(b(20:30,roi_V1,:),2),[],1));
pow4_V1=squeeze(max(mean(a(20:30,roi_V1,:),2),[],1));

lim=[-2:0.3:12];

[n,x1]=hist(pow3_V1,lim);
[c,x2]=hist(pow4_V1,lim);

figure;
bar(lim,[n;c]')




%% amplitude
%separating by pixels
% time4=squeeze(mean(mean(cond4n_dt_bl(roi_V1,28:48,:)-1,2),3));
% time3=squeeze(mean(mean(cond3n_dt_bl(roi_V1,28:48,:)-1,2),3));
% 
% lim=[0:0.00004:0.001];
% 
% [n,x1]=hist(time3,lim);
% [c,x2]=hist(time4,lim);
% 
% figure;
% bar(lim,[n;c]')


%separating by trials 

%100 ms amp
time4=squeeze(mean(mean(cond4n_dt_bl(roi_V1,38,:)-1,2),1));
time3=squeeze(mean(mean(cond3n_dt_bl(roi_V1,38,:)-1,2),1));

lim=[-0.001:0.0001:0.002];

[n,x1]=hist(time3,lim);
[c,x2]=hist(time4,lim);

figure;
bar(lim,[n;c]')

% max amp
time4=squeeze(max(mean(cond4n_dt_bl(roi_V1,28:48,:)-1,1),[],2));
time3=squeeze(max(mean(cond3n_dt_bl(roi_V1,28:48,:)-1,1),[],2));

lim=[-0.001:0.0001:0.003];

[n,x1]=hist(time3,lim);
[c,x2]=hist(time4,lim);

figure;
bar(lim,[n;c]')

scores=[time3;time4]';
labels=zeros(1,size(scores,2));
labels(size(time3,1)+1:end)=1;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


%amplitude at max der
der4=cond4n_dt_bl(:,6:112,:)-cond4n_dt_bl(:,2:108,:);
der3=cond3n_dt_bl(:,6:112,:)-cond3n_dt_bl(:,2:108,:);


for i=1:size(cond4n_dt_bl,3)
    d4=find(mean(der4(roi_V1,:,i),1)==squeeze(max(mean(der4(roi_V1,26:46,i),1),[],2)));
    time4(i)=squeeze(mean(cond4n_dt_bl(roi_V1,d4+3,i),1))-1;
end

for i=1:size(cond3n_dt_bl,3)
    d3=find(mean(der3(roi_V1,:,i),1)==squeeze(max(mean(der3(roi_V1,26:46,i),1),[],2)));
    time3(i)=squeeze(mean(cond3n_dt_bl(roi_V1,d3+3,i),1))-1;
end

lim=[-0.001:0.0001:0.003];

[n,x1]=hist(time3,lim);
[c,x2]=hist(time4,lim);

figure;
bar(lim,[n;c]')


%max derivative
der4=cond4n_dt_bl(:,6:112,:)-cond4n_dt_bl(:,2:108,:);
der3=cond3n_dt_bl(:,6:112,:)-cond3n_dt_bl(:,2:108,:);


for i=1:size(cond4n_dt_bl,3)
    time4(i)=squeeze(max(mean(der4(roi_V1,26:46,i),1),[],2));
end

for i=1:size(cond3n_dt_bl,3)
    time3(i)=squeeze(max(mean(der3(roi_V1,26:46,i),1),[],2));
end

lim=[-0e-4:0.00005:15e-4];

[n,x1]=hist(time3,lim);
[c,x2]=hist(time4,lim);

figure;
bar(lim,[n;c]')

scores=[time3;time4]';
labels=zeros(1,size(scores,2));
labels(size(time3,1)+1:end)=1;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

%time to peak
t4=squeeze(max(mean(cond4n_dt_bl(roi_V1,28:68,:)-1,1),[],2));
t3=squeeze(max(mean(cond3n_dt_bl(roi_V1,28:68,:)-1,1),[],2));

for i=1:size(cond4n_dt_bl,3)
    time4(i)=find(mean(cond4n_dt_bl(roi_V1,:,i)-1,1)==t4(i));
end

for i=1:size(cond3n_dt_bl,3)
    time3(i)=find(mean(cond3n_dt_bl(roi_V1,:,i)-1,1)==t3(i));
end

x=(10:10:2560)-280;
time4=x(time4);
time3=x(time3);

lim=[-20:10:500];
[n,x1]=hist(time3,lim);
[c,x2]=hist(time4,lim);

figure;
bar(lim,[n;c]')

scores=[time3';time4']';
labels=zeros(1,size(scores,2));
labels(size(time3',1)+1:end)=1;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

%time to half peak
t4=squeeze(max(mean(cond4n_dt_bl(roi_V1,28:68,:)-1,1),[],2));
t3=squeeze(max(mean(cond3n_dt_bl(roi_V1,28:68,:)-1,1),[],2));

for i=1:size(cond4n_dt_bl,3)
    time4(i)=find(mean(cond4n_dt_bl(roi_V1,1:48,i)-1,1)<t4(i)/2,1,'last');
end

for i=1:size(cond3n_dt_bl,3)
    time3(i)=find(mean(cond3n_dt_bl(roi_V1,1:48,i)-1,1)<t3(i)/2,1,'last');
end

x=(10:10:2560)-280;
time4=x(time4)+5;
time3=x(time3)+5;

lim=[-20:10:250];
[n,x1]=hist(time3,lim);
[c,x2]=hist(time4,lim);

figure;
bar(lim,[n;c]')


scores=[time4';time3']';
labels=zeros(1,size(scores,2));
labels(size(time4',1)+1:end)=1;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


%% ROC curve for trial
clear pfa phit
ind=find(c, 1, 'first');
ind2=find(n, 1, 'first');
s=min(ind,ind2);

ind=find(c, 1, 'last');
ind2=find(n, 1, 'last');
e=max(ind,ind2)+1;

lim=lim(s:e);
n=n(s:e);
c=c(s:e);

for i=1:size(lim,2)
    pfa(i)=sum(n(i:end))/size(cond3n_dt_bl,3);
    phit(i)=sum(c(i:end))/size(cond4n_dt_bl,3);    
end    


figure;plot(pfa,phit)




%% calculating AUC

scores=[pow3_V1;pow4_V1]';
labels=zeros(1,52);
labels(27:end)=1;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



scores=[time3 time4]';
labels=zeros(1,52);
labels(27:end)=1;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



scores=[time3 time4];
labels=zeros(1,52);
labels(27:end)=1;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,0);
figure;plot(X,Y)

%%

scores=[pow3_V1;pow4_V1]';
labels=zeros(1,size(scores,2));
labels(size(pow3_V1+1,1):end)=1;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


%% for pixels

scores=[pow3_V1 pow4_V1];
labels=zeros(1,size(scores,2));
labels(size(pow3_V1,2):end)=1;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

%%

auc=[AUC_power AUC_100ms AUC_maxamp AUC_maxderamp AUC_maxder AUC_ttp AUC_lat ; AUC_pow2 AUC_100ms2 AUC_maxamp2 AUC_maxampder2 AUC_maxder2 AUC_ttp2 AUC_lat2]

figure;bar(auc')




%% another way to calculate roc curve: all trial and all pixels

pow3_V1=reshape(squeeze(mean(b(20:30,roi_V1,:),1)),1,29*94);
pow4_V1=reshape(squeeze(mean(a(20:30,roi_V1,:),1)),1,27*94);


scores=[pow3_V1 pow4_V1];
labels=zeros(1,size(pow3_V1,2)+size(pow4_V1,2));
labels(size(pow3_V1,2)+1:end)=1;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


time4=reshape(squeeze(cond4n_dt_bl(roi_V1,38,:))-1,1,27*94);
time3=reshape(squeeze(cond3n_dt_bl(roi_V1,38,:))-1,1,29*94);

scores=[time3 time4];
labels=zeros(1,size(time3,2)+size(time4,2));
labels(size(time3,2)+1:end)=1;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



%% calculate d prime as a function of time


pow3_V1=squeeze(mean(b(:,roi_V1,:),2));
pow4_V1=squeeze(mean(a(:,roi_V1,:),2));


for i=1:112
    d_pow(i)=(mean(pow4_V1(i,:))-mean(pow3_V1(i,:)))/std(pow3_V1(i,:));
end

x1=(20:10:1130)-200; %for collinear
figure;plot(x1,d_pow)

time4=squeeze(mean(cond4n_dt_bl(roi_V1,:,:)-1,1));
time3=squeeze(mean(cond3n_dt_bl(roi_V1,:,:)-1,1));

for i=1:112
    d_time(i)=(mean(time4(i,:))-mean(time3(i,:)))/std(time3(i,:));
end

x=(10:10:2560)-280;
figure;plot(x(1:112),d_time,'r')


der4=squeeze(mean(cond4n_dt_bl(roi_V1,6:112,:)-cond4n_dt_bl(roi_V1,2:108,:),1));
der3=squeeze(mean(cond3n_dt_bl(roi_V1,6:112,:)-cond3n_dt_bl(roi_V1,2:108,:),1));

for i=1:107
    d_der(i)=(mean(der4(i,:))-mean(der3(i,:)))/std(der3(i,:));
end

x2=(30:10:1090)-280;
figure;plot(x2(1:107),d_der,'g')



%% for cond 2 and 4

%% alpha power
%separating by trials
t=24:26;
pow4_V1=squeeze(mean(mean(b(t,roi_V1,:),1),2));
pow2_V1=squeeze(mean(mean(a(t,roi_V1,:),1),2));

lim=[-4:0.5:6];

[n,x1]=hist(pow4_V1,lim);
[c,x2]=hist(pow2_V1,lim);

figure;
bar(lim,[n;c]')


scores=[pow4_V1;pow2_V1]';
labels=zeros(1,size(scores,2));
labels(size(pow4_V1,1)+1:end)=1;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

%% amplitude

%separating by trials 

%% max amp
time2=squeeze(max(mean(cond2n_dt_bl(roi_V1,28:48,:)-1,1),[],2));
time4=squeeze(max(mean(cond4n_dt_bl(roi_V1,28:48,:)-1,1),[],2));

lim=[-0.001:0.0001:0.003];

[n,x1]=hist(time4,lim);
[c,x2]=hist(time2,lim);

figure;
bar(lim,[n;c]')

scores=[time4;time2]';
labels=zeros(1,size(scores,2));
labels(size(time4,1)+1:end)=1;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

%% max derivative
der2=cond2n_dt_bl(:,6:112,:)-cond2n_dt_bl(:,2:108,:);
der4=cond4n_dt_bl(:,6:112,:)-cond4n_dt_bl(:,2:108,:);


for i=1:size(der2,3)
    time2(i)=squeeze(max(mean(der2(roi_V1,26:46,i),1),[],2));
end

for i=1:size(der4,3)
    time4(i)=squeeze(max(mean(der4(roi_V1,26:46,i),1),[],2));
end

lim=[-0e-4:0.00005:15e-4];

[n,x1]=hist(time4,lim);
[c,x2]=hist(time2,lim);

figure;
bar(lim,[n;c]')

scores=[time4;time2]';
labels=zeros(1,size(scores,2));
labels(size(time4,1)+1:end)=1;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


%% time to peak
t2=squeeze(max(mean(cond2n_dt_bl(roi_V1,28:68,:)-1,1),[],2));
t4=squeeze(max(mean(cond4n_dt_bl(roi_V1,28:68,:)-1,1),[],2));

for i=1:size(cond2n_dt_bl,3)
    time2(i)=find(mean(cond2n_dt_bl(roi_V1,:,i)-1,1)==t2(i));
end

for i=1:size(cond4n_dt_bl,3)
    time4(i)=find(mean(cond4n_dt_bl(roi_V1,:,i)-1,1)==t4(i));
end

x=(10:10:2560)-280;
time2=x(time2);
time4=x(time4);

lim=[-20:10:500];
[n,x1]=hist(time4,lim);
[c,x2]=hist(time2,lim);

figure;
bar(lim,[n;c]')

scores=[time4';time2']';
labels=zeros(1,size(scores,2));
labels(size(time4',1)+1:end)=1;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

%% time to half peak
t2=squeeze(max(mean(cond2n_dt_bl(roi_V1,28:68,:)-1,1),[],2));
t4=squeeze(max(mean(cond4n_dt_bl(roi_V1,28:68,:)-1,1),[],2));

for i=1:size(cond2n_dt_bl,3)
    time2(i)=find(mean(cond2n_dt_bl(roi_V1,1:48,i)-1,1)<t2(i)/2,1,'last');
end

for i=1:size(cond4n_dt_bl,3)
    time4(i)=find(mean(cond4n_dt_bl(roi_V1,1:48,i)-1,1)<t4(i)/2,1,'last');
end

x=(10:10:2560)-280;
time2=x(time2)+5;
time4=x(time4)+5;

lim=[-20:10:250];
[n,x1]=hist(time4,lim);
[c,x2]=hist(time2,lim);

figure;
bar(lim,[n;c]')

scores=[time2';time4']';
labels=zeros(1,size(scores,2));
labels(size(time2',1)+1:end)=1;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
























