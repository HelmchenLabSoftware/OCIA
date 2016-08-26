
%% three flanker
%% alpha beta or gamma power
%separating by trials
t=20:25;
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
[X,Y,THRE,AUC_pow,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
%[X,Y,THRE,AUC_beta,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
%[X,Y,THRE,AUC_gamma,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

%% amplitude

%separating by trials 

% max amp
time4=squeeze(max(mean(cond4n_dt_bl(roi_V1,28:48,:),1),[],2));
time3=squeeze(max(mean(cond3n_dt_bl(roi_V1,28:48,:),1),[],2));

lim=[-0.001:0.0001:0.003];
[n,x1]=hist(time3,lim);
[c,x2]=hist(time4,lim);
figure;
bar(lim,[n;c]')
scores=[time3;time4]';
labels=zeros(1,size(scores,2));
labels(size(time3,1)+1:end)=1;
[X,Y,THRE,AUC_maxamp,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


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

scores=[time3 time4]';
labels=zeros(1,size(scores,1))';
labels(size(time3,2)+1:end)=1;
[X,Y,THRE,AUC_maxder,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
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
[X,Y,THRE,AUC_ttp,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

save AUC_trialwise_different_measures AUC_pow AUC_maxder AUC_maxamp AUC_ttp AUC_beta AUC_gamma

%% for cond 2 and 4 one flanker
%% alpha beta or gamma power
%separating by trials
t=20:30;
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
%[X,Y,THRE,AUC_pow,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
%[X,Y,THRE,AUC_beta,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
[X,Y,THRE,AUC_gamma,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

%% amplitude

%separating by trials 

%% max amp
time2=squeeze(max(mean(cond2n_dt_bl(roi_V1,28:48,:),1),[],2));
time4=squeeze(max(mean(cond4n_dt_bl(roi_V1,28:48,:),1),[],2));
lim=[-0.001:0.0001:0.003];
[n,x1]=hist(time4,lim);
[c,x2]=hist(time2,lim);
figure;
bar(lim,[n;c]')
scores=[time4;time2]';
labels=zeros(1,size(scores,2));
labels(size(time4,1)+1:end)=1;
[X,Y,THRE,AUC_maxamp,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
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

scores=[time4 time2];
labels=zeros(1,size(scores,2));
labels(size(time4,2)+1:end)=1;
[X,Y,THRE,AUC_maxder,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
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
[X,Y,THRE,AUC_ttp,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



save AUC_trialwise_different_measures AUC_pow AUC_maxder AUC_maxamp AUC_ttp

















