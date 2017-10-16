cd D:\intrinsic\20150514\b\Matt_files
load('whisker_envelope.mat')
%load('rois_initial_205x205.mat')
load('trials_ind.mat')
x=(1:180)*0.05-2.7;

load cond_100_trial1
fr=size(tr,3);
pix=size(tr,2);

th=0.5;
map_no_whisk_100=nan*ones(pix*pix,fr,size(tr_100,2));
for i=1:size(tr_100,2)
    disp(i)
    t=smooth(whisk_env(:,tr_100(i)),3,'Gauss');
    wh_ind=t(8:167)>th;
    r=find(wh_ind);
    y=find(wh_ind(1:end))-1;
    r=[r;y(2:end)];
    r=[r;find(wh_ind(1:end-1))+1];
    r=[r;find(wh_ind(1:end-2))+2];
    r=[r;find(wh_ind(1:end-3))+3];
    r=[r;find(wh_ind(1:end-4))+4];
    iii=unique(r);
    z=zeros(1,size(wh_ind,2));
    z(iii)=1;
    wh_ind=(z==1);
    eval(['load cond_100_trial',int2str(i)])
    d=reshape(tr,pix*pix,fr);
    map_no_whisk_100(:,~wh_ind,i)=d(:,~wh_ind)-1;
    
end
cond_100_ave_no_whisk=reshape(nanmean(map_no_whisk_100,3),[pix,pix,fr]);


map_no_whisk_1200=nan*ones(pix*pix,fr,size(tr_1200,2));
for i=1:size(tr_1200,2)
    disp(i)
    t=smooth(whisk_env(:,tr_1200(i)),3,'Gauss');
    wh_ind=t(8:167)>th;
    r=find(wh_ind);
    y=find(wh_ind(1:end))-1;
    r=[r;y(2:end)];
    r=[r;find(wh_ind(1:end-1))+1];
    r=[r;find(wh_ind(1:end-2))+2];
    r=[r;find(wh_ind(1:end-3))+3];
    r=[r;find(wh_ind(1:end-4))+4];
    iii=unique(r);
    z=zeros(1,size(wh_ind,2));
    z(iii)=1;
    wh_ind=(z==1);
    eval(['load cond_1200_trial',int2str(i)])
    d=reshape(tr,pix*pix,fr);
    map_no_whisk_1200(:,~wh_ind,i)=d(:,~wh_ind)-1;
    
end
cond_1200_ave_no_whisk=reshape(nanmean(map_no_whisk_1200,3),[pix,pix,fr]);

save cond_100_ave_no_whisk cond_100_ave_no_whisk th
save cond_1200_ave_no_whisk cond_1200_ave_no_whisk th

%%

for i=180:-5:1
    figure;imagesc(smoothn(cond_100_ave_no_whisk(:,:,i),[5 5],'Gauss'),[-1.5e-2 1.5e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,205,205),'k')
    title([int2str(x(i)*1000)])
    %title([int2str(i)])
end

for i=180:-1:1
    figure;imagesc(smoothn(cond_1200_ave_whisk(:,:,i),[5 5],'Gauss'),[-1e-2 1.5e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,205,205),'k')
    title([int2str(x(i)*1000)])
    %title([int2str(i)])
end


for i=180:-4:1
    figure;imagesc(smoothn(cond_1200_ave_no_whisk(:,:,i)-cond_100_ave_no_whisk(:,:,i),[5 5],'Gauss'),[-1e-2 1e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,205,205),'k')
    title([int2str(x(i)*1000)])
    %title([int2str(i)])
end




%%

load rois_initial_205x205
h=zeros(205*205,1);
h(roi_s1)=1;
h(roi_s2)=1;
h(roi_m1)=1;
h(roi_m2)=1;
h(roi_a1)=1;
h(roi_alm)=1;
%h(roi_ppc)=1;

x=(1:size(cond_100_ave_no_whisk,3))*0.05-3.05;
d=reshape(cond_100_ave_no_whisk,pix*pix,size(cond_100_ave_no_whisk,3));
figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1)),1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1)),1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d(roi_m1,:),1)),1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d(roi_a1,:),1)),1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1)),1,'Gauss'),'k')
plot(x,smooth(squeeze(nanmean(d(roi_alm,:),1)),1,'Gauss'),'m')
%plot(x,smooth(squeeze(nanmean(d(roi_ppc,:),1)),1,'Gauss'),'y')
plot(x,zeros(1,size(cond_100_ave_no_whisk,3)),'k')
legend('s1','s2','m1','a1','m2','alm','ppc')

d2=reshape(cond_1200_ave_no_whisk,pix*pix,size(cond_1200_ave_no_whisk,3));
figure;plot(x,smooth(squeeze(nanmean(d2(roi_s1,:),1)),1,'Gauss'),'--b')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_s2,:),1)),1,'Gauss'),'--c')
plot(x,smooth(squeeze(nanmean(d2(roi_m1,:),1)),1,'Gauss'),'--r')
plot(x,smooth(squeeze(nanmean(d2(roi_a1,:),1)),1,'Gauss'),'--g')
plot(x,smooth(squeeze(nanmean(d2(roi_m2,:),1)),1,'Gauss'),'--k')
plot(x,smooth(squeeze(nanmean(d2(roi_alm,:),1)),1,'Gauss'),'--m')
plot(x,zeros(1,size(cond_100_ave_no_whisk,3)),'k')
legend('s1','s2','m1','a1','m2','alm')

figure;plot(x,smooth(squeeze(nanmean(d2(roi_s1,:),1))-squeeze(nanmean(d(roi_s1,:),1)),1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_s2,:),1))-squeeze(nanmean(d(roi_s2,:),1)),1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d2(roi_m1,:),1))-squeeze(nanmean(d(roi_m1,:),1)),1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d2(roi_m2,:),1))-squeeze(nanmean(d(roi_m2,:),1)),1,'Gauss'),'k')
plot(x,smooth(squeeze(nanmean(d2(roi_alm,:),1))-squeeze(nanmean(d(roi_alm,:),1)),1,'Gauss'),'m')
plot(x,smooth(squeeze(nanmean(d2(roi_a1,:),1))-squeeze(nanmean(d(roi_a1,:),1)),1,'Gauss'),'g')
%plot(x,smooth(squeeze(nanmean(d(roi_ppc,:),1))-squeeze(nanmean(d2(roi_ppc,:),1)),1,'Gauss'),'y')
plot(x,zeros(1,size(cond_100_ave_no_whisk,3)),'k')
legend('s1','s2','m1','m2','alm','a1')
