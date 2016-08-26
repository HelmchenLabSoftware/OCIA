load('cond1n_dt_bl_no_eyemove.mat')
load('cond2n_dt_bl_no_eyemove.mat')
load('cond4n_dt_bl_no_eyemove.mat')
load('cond5n_dt_bl_no_eyemove.mat')
load('trials_without_blood_vessel_activation.mat')
load pixels_to_remove
time=43:58;
mm=nanmean(nanmean(cat(3,cond1n_dt_bl(:,time,:),cond2n_dt_bl(:,time,:),cond4n_dt_bl(:,time,:),cond5n_dt_bl(:,time,:)),3),2);
for i=1
    figure(100);mimg(mfilt2(nanmean(cond1n_dt_bl(:,time,i),2)-mm,100,100,1,'lm'),100,100,-1e-3,1e-3);colormap(mapgeog)
    %09,15 aug
%      hold on
%     line([4 18],[58 57],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
%     line([18 25],[57 59],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
%     line([25 54],[59 59],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
%     line([54 61],[59 59],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
%     line([61 87],[59 55],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    %02 aug
%     hold on
%     line([10 20],[61 60],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
%     line([20 28],[60 62],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
%     line([28 55],[62 62],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
%     line([55 62],[62 62],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
%     line([62 84],[62 60],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    %06june2012
%     hold on
%     line([6 16],[65 65],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
%     line([16 24],[65 66],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
%     line([24 51],[66 66],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
%     line([51 58],[66 66],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
%     line([58 83],[66 63],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    %22May2012
%    hold on
%     line([19 36],[56 61],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
%     line([36 43],[61 62],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
%     line([43 69],[62 65],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
%     line([69 76],[65 66],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
%     line([76 97],[66 66],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
%16may2012
 hold on
%     line([13 26],[47 52],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
%     line([26 34],[52 53],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
%     line([34 59],[53 56],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
%     line([59 66],[56 57],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
%     line([66 87],[57 57],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
%     
    h=zeros(10000,1);
    h(pixels_to_remove)=10;
    contour(reshape(h,100,100)','k')
    roi = choose_polygon(100);
end

time=2:68;
mm=cat(3,cond1n_dt_bl(:,time,:),cond2n_dt_bl(:,time,:),cond4n_dt_bl(:,time,:),cond5n_dt_bl(:,time,:));
for i=1:size(cond1n_dt_bl,3)
    figure;plot(nanmean(cond1n_dt_bl(roi,time,i),1)-1,'r')
    hold on
    errorbar(nanmean(nanmean(mm(roi,:,:),1),3)-1,1*nanstd(nanmean(mm(roi,:,:),1),0,3),'k')
end

tr1_bad=[17 26 30];
a=ones(1,size(cond1n_dt_bl,3));
a(tr1_bad)=0;
tr1_good=find(a);
close all

time=2:68;
mm=cat(3,cond1n_dt_bl(:,time,:),cond2n_dt_bl(:,time,:),cond4n_dt_bl(:,time,:),cond5n_dt_bl(:,time,:));
for i=1:size(cond2n_dt_bl,3)
    figure;plot(nanmean(cond2n_dt_bl(roi,time,i),1)-1,'r')
    hold on
    errorbar(nanmean(nanmean(mm(roi,:,:),1),3)-1,1*nanstd(nanmean(mm(roi,:,:),1),0,3),'k')
end

tr2_bad=[11 14 19];
a=ones(1,size(cond2n_dt_bl,3));
a(tr2_bad)=0;
tr2_good=find(a);
close all

time=2:68;
mm=cat(3,cond1n_dt_bl(:,time,:),cond2n_dt_bl(:,time,:),cond4n_dt_bl(:,time,:),cond5n_dt_bl(:,time,:));
for i=1:size(cond4n_dt_bl,3)
    figure;plot(nanmean(cond4n_dt_bl(roi,time,i),1)-1,'r')
    hold on
    errorbar(nanmean(nanmean(mm(roi,:,:),1),3)-1,1*nanstd(nanmean(mm(roi,:,:),1),0,3),'k')
end

tr4_bad=[19 30];
a=ones(1,size(cond4n_dt_bl,3));
a(tr4_bad)=0;
tr4_good=find(a);
close all

time=2:68;
mm=cat(3,cond1n_dt_bl(:,time,:),cond2n_dt_bl(:,time,:),cond4n_dt_bl(:,time,:),cond5n_dt_bl(:,time,:));
for i=1:size(cond5n_dt_bl,3)
    figure;plot(nanmean(cond5n_dt_bl(roi,time,i),1)-1,'r')
    hold on
    errorbar(nanmean(nanmean(mm(roi,:,:),1),3)-1,1*nanstd(nanmean(mm(roi,:,:),1),0,3),'k')
end

tr5_bad=[26];
a=ones(1,size(cond5n_dt_bl,3));
a(tr5_bad)=0;
tr5_good=find(a);
close all

save trials_without_blood_vessel_activation_v2 tr* roi






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

