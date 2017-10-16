load('cond1n_dt_bl_no_eyemove.mat')
load('cond2n_dt_bl_no_eyemove.mat')
load('cond4n_dt_bl_no_eyemove.mat')
load('cond5n_dt_bl_no_eyemove.mat')
load('trials_without_blood_vessel_activation_v2.mat')
load pixels_to_remove
load('myrois3.mat')

time=2:78;
mm=cat(3,cond1n_dt_bl(:,time,:),cond2n_dt_bl(:,time,:),cond4n_dt_bl(:,time,:),cond5n_dt_bl(:,time,:));
for i=1:size(cond1n_dt_bl,3)
    figure;subplot(1,3,1)
    plot(nanmean(cond1n_dt_bl(roi,time,i),1)-1,'Color','r','LineWidth',3)
    hold on
    errorbar(nanmean(nanmean(mm(roi,:,:),1),3)-1,1*nanstd(nanmean(mm(roi,:,:),1),0,3),'k')    
    axis off
    subplot(1,3,2)
    plot(nanmean(cond1n_dt_bl(roi_top_clean,time,i),1)-1,'Color','r','LineWidth',3)
    hold on
    errorbar(nanmean(nanmean(mm(roi_top_clean,:,:),1),3)-1,1*nanstd(nanmean(mm(roi_top_clean,:,:),1),0,3),'k')   
    axis off
    subplot(1,3,3)
    plot(nanmean(cond1n_dt_bl(roi_bottom_clean,time,i),1)-1,'Color','r','LineWidth',3)
    hold on
    errorbar(nanmean(nanmean(mm(roi_bottom_clean,:,:),1),3)-1,1*nanstd(nanmean(mm(roi_bottom_clean,:,:),1),0,3),'k')    
    axis off
end

tr1_bad=[15 16 21];
a=ones(1,size(cond1n_dt_bl,3));
a(tr1_bad)=0;
tr1_good=find(a);
close all

time=2:68;
mm=cat(3,cond1n_dt_bl(:,time,:),cond2n_dt_bl(:,time,:),cond4n_dt_bl(:,time,:),cond5n_dt_bl(:,time,:));
for i=1:size(cond2n_dt_bl,3)
    figure;subplot(1,3,1)
    plot(nanmean(cond2n_dt_bl(roi,time,i),1)-1,'Color','r','LineWidth',3)
    hold on
    errorbar(nanmean(nanmean(mm(roi,:,:),1),3)-1,1*nanstd(nanmean(mm(roi,:,:),1),0,3),'k')    
    axis off
    subplot(1,3,2)
    plot(nanmean(cond2n_dt_bl(roi_top_clean,time,i),1)-1,'Color','r','LineWidth',3)
    hold on
    errorbar(nanmean(nanmean(mm(roi_top_clean,:,:),1),3)-1,1*nanstd(nanmean(mm(roi_top_clean,:,:),1),0,3),'k')   
    axis off
    subplot(1,3,3)
    plot(nanmean(cond2n_dt_bl(roi_bottom_clean,time,i),1)-1,'Color','r','LineWidth',3)
    hold on
    errorbar(nanmean(nanmean(mm(roi_bottom_clean,:,:),1),3)-1,1*nanstd(nanmean(mm(roi_bottom_clean,:,:),1),0,3),'k')    
    axis off
end

tr2_bad=[];
a=ones(1,size(cond2n_dt_bl,3));
a(tr2_bad)=0;
tr2_good=find(a);
close all

time=2:68;
mm=cat(3,cond1n_dt_bl(:,time,:),cond2n_dt_bl(:,time,:),cond4n_dt_bl(:,time,:),cond5n_dt_bl(:,time,:));
for i=1:size(cond4n_dt_bl,3)
    figure;subplot(1,3,1)
    plot(nanmean(cond4n_dt_bl(roi,time,i),1)-1,'Color','r','LineWidth',3)
    hold on
    errorbar(nanmean(nanmean(mm(roi,:,:),1),3)-1,1*nanstd(nanmean(mm(roi,:,:),1),0,3),'k')    
    axis off
    subplot(1,3,2)
    plot(nanmean(cond4n_dt_bl(roi_top_clean,time,i),1)-1,'Color','r','LineWidth',3)
    hold on
    errorbar(nanmean(nanmean(mm(roi_top_clean,:,:),1),3)-1,1*nanstd(nanmean(mm(roi_top_clean,:,:),1),0,3),'k')   
    axis off
    subplot(1,3,3)
    plot(nanmean(cond4n_dt_bl(roi_bottom_clean,time,i),1)-1,'Color','r','LineWidth',3)
    hold on
    errorbar(nanmean(nanmean(mm(roi_bottom_clean,:,:),1),3)-1,1*nanstd(nanmean(mm(roi_bottom_clean,:,:),1),0,3),'k')    
    axis off
end

tr4_bad=[13 15 26];
a=ones(1,size(cond4n_dt_bl,3));
a(tr4_bad)=0;
tr4_good=find(a);
close all

time=2:68;
mm=cat(3,cond1n_dt_bl(:,time,:),cond2n_dt_bl(:,time,:),cond4n_dt_bl(:,time,:),cond5n_dt_bl(:,time,:));
for i=1:size(cond5n_dt_bl,3)
    figure;subplot(1,3,1)
    plot(nanmean(cond5n_dt_bl(roi,time,i),1)-1,'Color','r','LineWidth',3)
    hold on
    errorbar(nanmean(nanmean(mm(roi,:,:),1),3)-1,1*nanstd(nanmean(mm(roi,:,:),1),0,3),'k')    
    axis off
    subplot(1,3,2)
    plot(nanmean(cond5n_dt_bl(roi_top_clean,time,i),1)-1,'Color','r','LineWidth',3)
    hold on
    errorbar(nanmean(nanmean(mm(roi_top_clean,:,:),1),3)-1,1*nanstd(nanmean(mm(roi_top_clean,:,:),1),0,3),'k')   
    axis off
    subplot(1,3,3)
    plot(nanmean(cond5n_dt_bl(roi_bottom_clean,time,i),1)-1,'Color','r','LineWidth',3)
    hold on
    errorbar(nanmean(nanmean(mm(roi_bottom_clean,:,:),1),3)-1,1*nanstd(nanmean(mm(roi_bottom_clean,:,:),1),0,3),'k')    
    axis off
end

tr5_bad=[12 29];
a=ones(1,size(cond5n_dt_bl,3));
a(tr5_bad)=0;
tr5_good=find(a);
close all

save trials_without_blood_vessel_activation_v3 tr* roi






%%
load('myrois3.mat')
time=43:58;
mm=nanmean(nanmean(cat(3,cond1n_dt_bl(:,time,:),cond2n_dt_bl(:,time,:),cond4n_dt_bl(:,time,:),cond5n_dt_bl(:,time,:)),3),2);
for i=tr2_bad
    figure;mimg(mfilt2(nanmean(cond2n_dt_bl(:,time,i),2)-mm,100,100,1,'lm'),100,100,-1e-3,1e-3);colormap(mapgeog)
    hold on
    line([4 18],[58 57],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([18 25],[57 59],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([25 54],[59 59],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([54 61],[59 59],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([61 87],[59 55],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    h=zeros(10000,1);
    h(pixels_to_remove)=10;
    h(roi_top_clean)=1;
    h(roi_bottom_clean)=1;
    contour(reshape(h,100,100)','k')
end

