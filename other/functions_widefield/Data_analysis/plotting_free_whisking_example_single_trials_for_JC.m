

load('whisk_map.mat')
for i=73
    y=fliplr(smoothn(nanmean(reshape(whisk_map(:,i),[205,205]),3),[5 5],'Gauss')');
    y(isnan(y))=10000;
    figure;imagesc(y,[.2 .6]);colormap(mapgeog)
    hold on
    %h=zeros(205*205,1);
    %h(roi_s1)=1;
    %contour(fliplr(reshape(h,205,205)'),'k')
    %line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
    axis square
    axis off
    title([int2str(i)])
end

y=fliplr(smoothn(nanmean(reshape(nanmean(whisk_map(:,:),2),[205,205]),3),[5 5],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[0.1 .4]);colormap(mapgeog)
hold on
axis square
axis off

for ii=73
    load(['stim_trial',int2str(ii),'.mat'])
    load('whisker_envelope.mat')
    x=(1:180)*0.05-2.7;
    d=reshape(tr,205*205,size(tr,3));
    figure;
    subplot(2,1,1)    
    plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'k')
    hold on
    plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'),'b')
    plot(x,smooth(squeeze(nanmean(d(roi_ic,:),1))-1,1,'Gauss'),'r')
    plot(x,smooth(squeeze(nanmean(d(roi_sc,:),1))-1,1,'Gauss'),'g')
    plot(x,smooth(squeeze(nanmean(d(roi_rs,:),1))-1,1,'Gauss'),'c')
    %plot(x,smooth(squeeze(nanmean(d(roi_pf,:),1))-1,1,'Gauss'),'m')
    plot(x,zeros(1,size(tr,3)),'k')
    %legend('m2','sc','ic','ppc','rs','pf')
    xlim([-2.5 5])
    subplot(2,1,2)
    plot(x_env,smooth(whisk_env(:,ii),1,'Gauss'))
    xlim([-2.5 5])
    ylim([-5 12])
    title([int2str(ii)])
end



figure(100);imagesc(smoothn(nanmean(cond_100_ave(:,:,104:132),3)-1,[5 5],'Gauss'),[-.5e-2 4e-2]);colormap(mapgeog)
roi_m2 = choose_polygon_imagesc(205);
roi_s1 = choose_polygon_imagesc(205);
roi_rs = choose_polygon_imagesc(205);
roi_ic = choose_polygon_imagesc(205);
roi_sc = choose_polygon_imagesc(205);
roi_v1 = choose_polygon_imagesc(205);
roi_a1 = choose_polygon_imagesc(205);


load rois_initial_205x205
h=zeros(205*205,1);
h(roi_s1)=1;
h(roi_s2)=1;
h(roi_m1)=1;
h(roi_m2)=1;
h(roi_a1)=1;
h(roi_alm)=1;
%h(roi_ppc)=1;

%%

y=fliplr(smoothn(nanmean(tr(:,:,11:24),3)-1,[5 5],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-1e-2 5e-2]);colormap(mapgeog)
hold on
%h=zeros(205*205,1);
%h(roi_s1)=1;
%contour(fliplr(reshape(h,205,205)'),'k')
%line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off

y=fliplr(smoothn(nanmean(tr(:,:,28:34),3)-1,[5 5],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-1e-2 5e-2]);colormap(mapgeog)
hold on
h=zeros(205*205,1);
h(roi_ic)=1;
contour(fliplr(reshape(h,205,205)'),'k')
%line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off


y=fliplr(smoothn(nanmean(tr(:,:,51:60),3)-1,[5 5],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-1e-2 5e-2]);colormap(mapgeog)
hold on
%h=zeros(205*205,1);
%h(roi_s1)=1;
%contour(fliplr(reshape(h,205,205)'),'k')
%line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off


y=fliplr(smoothn(nanmean(tr(:,:,67:78),3)-1,[5 5],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-1e-2 5e-2]);colormap(mapgeog)
hold on
%h=zeros(205*205,1);
%h(roi_s1)=1;
%contour(fliplr(reshape(h,205,205)'),'k')
%line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off

y=fliplr(smoothn(nanmean(tr(:,:,91:99),3)-1,[5 5],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-1e-2 5e-2]);colormap(mapgeog)
hold on
%h=zeros(205*205,1);
%h(roi_s1)=1;
%contour(fliplr(reshape(h,205,205)'),'k')
%line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off


y=fliplr(smoothn(nanmean(tr(:,:,102:109),3)-1,[5 5],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-1e-2 5e-2]);colormap(mapgeog)
hold on
%h=zeros(205*205,1);
%h(roi_s1)=1;
%contour(fliplr(reshape(h,205,205)'),'k')
%line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off



y=fliplr(smoothn(nanmean(tr(:,:,129:134),3)-1,[5 5],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-1e-2 5e-2]);colormap(mapgeog)
hold on
%h=zeros(205*205,1);
%h(roi_s1)=1;
%contour(fliplr(reshape(h,205,205)'),'k')
%line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off




%%
y=fliplr(smoothn(nanmean(amp_trig_ave(:,:,18:22),3)-1,[3 3],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[0e-2 2.5e-2]);colormap(mapgeog)
hold on
%h=zeros(205*205,1);
%h(roi_s1)=1;
%contour(fliplr(reshape(h,205,205)'),'k')
%line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off


time=18:22;
aa=[nanmean(nanmean(nanmean(dd(roi_m2,time,:))))-1 nanmean(nanmean(nanmean(dd(roi_rs,time,:))))-1 nanmean(nanmean(nanmean(dd(roi_ic,time,:))))-1 nanmean(nanmean(nanmean(dd(roi_sc,time,:))))-1 nanmean(nanmean(nanmean(dd(roi_s1,time,:))))-1];
bb=[nanstd(nanmean(nanmean(dd(roi_m2,time,:))),0,3) nanstd(nanmean(nanmean(dd(roi_rs,time,:))),0,3) nanstd(nanmean(nanmean(dd(roi_ic,time,:))),0,3) nanstd(nanmean(nanmean(dd(roi_sc,time,:))),0,3) nanstd(nanmean(nanmean(dd(roi_s1,time,:))),0,3)]/sqrt(size(dd,3));
figure;
bar(aa)
hold on
errorbar(aa,bb)


aa=[nanmean(nanmean(whisk_map(roi_m2,:))) nanmean(nanmean(whisk_map(roi_rs,:))) nanmean(nanmean(whisk_map(roi_ic,:))) nanmean(nanmean(whisk_map(roi_sc,:))) nanmean(nanmean(whisk_map(roi_s1,:)))];
bb=[nanstd(nanmean(whisk_map(roi_m2,:)),0,2) nanstd(nanmean(whisk_map(roi_rs,:)),0,2) nanstd(nanmean(whisk_map(roi_ic,:)),0,2) nanstd(nanmean(whisk_map(roi_sc,:)),0,2) nanstd(nanmean(whisk_map(roi_s1,:)),0,2)]/sqrt(size(whisk_map,2));
figure;
bar(aa)
hold on
errorbar(aa,bb)












