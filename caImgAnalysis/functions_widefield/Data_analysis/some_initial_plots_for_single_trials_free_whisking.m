

for i=60:1:70
    figure;plot(x_env,smooth(whisk_env(:,i),3,'Gauss'))
    ylim([-5 17])
    xlim([-3 6])
    title([int2str(i)])
end

tr1=[260:267];
tr2=[225 226 232 243 244];


for i=73
    y=fliplr(smoothn(nanmean(reshape(whisk_map(:,i),[205,205]),3),[3 3],'Gauss')');
    y(isnan(y))=10000;
    figure;imagesc(y,[-.2 .6]);colormap(mapgeog)
    hold on
    %h=zeros(205*205,1);
    %h(roi_s1)=1;
    %contour(fliplr(reshape(h,205,205)'),'k')
    %line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
    axis square
    axis off
    title([int2str(i)])
end



load('whisk_map.mat')
figure(100);imagesc(smoothn(nanmean(reshape(nanmean(whisk_map(:,:),2),[205,205]),3),[5 5],'Gauss'),[0 .4]);colormap(mapgeog)
roi_m2 = choose_polygon_imagesc(205);
roi_s1 = choose_polygon_imagesc(205);
%roi_ppc = choose_polygon_imagesc(205);
roi_ic = choose_polygon_imagesc(205);
roi_rs = choose_polygon_imagesc(205);
roi_sc = choose_polygon_imagesc(205);


for ii=1:100
    load(['stim_trial',int2str(ii),'.mat'])
    load('whisker_envelope.mat')
    x=(1:180)*0.05-2.7;
    d=reshape(tr,205*205,size(tr,3));
    figure;
    subplot(2,1,1)    
    plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'))
    hold on
    plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'),'c')
    plot(x,smooth(squeeze(nanmean(d(roi_ic,:),1))-1,1,'Gauss'),'r')
    plot(x,smooth(squeeze(nanmean(d(roi_sc,:),1))-1,1,'Gauss'),'g')
    %plot(x,smooth(squeeze(nanmean(d(roi_rs,:),1))-1,1,'Gauss'),'k')
    %plot(x,smooth(squeeze(nanmean(d(roi_pf,:),1))-1,1,'Gauss'),'m')
    plot(x,zeros(1,size(tr,3)),'k')
    %legend('m2','sc','ic','ppc','rs','pf')
    xlim([-3 6])
    subplot(2,1,2)
    plot(x_env,smooth(whisk_env(:,ii),1,'Gauss'))
    xlim([-3 6])
    ylim([-5 17])
    title([int2str(ii)])
end


figure
plot(x_env,whisk_env(:,tr1),'b')
hold on
plot(x_env,whisk_env(:,tr2),'r')
xlim([-3 6])
ylim([-10 17])



figure;histogram(whisk_env(:,tr1))
hold on
histogram(whisk_env(:,tr2))








for i=144:-1:1
    figure;imagesc(smoothn(tr(:,:,i)-1,[5 5],'Gauss'),[-2e-2 7e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,205,205),'k')
    title([int2str(x(i)*1000)])
    %title([int2str(i)])
end







figure(100);imagesc(smoothn(tr(:,:,70)-1,[5 5],'Gauss'),[-.5e-2 4e-2]);colormap(mapgeog)
roi_m2 = choose_polygon_imagesc(205);
roi_s1 = choose_polygon_imagesc(205);
roi_ppc = choose_polygon_imagesc(205);
roi_ic = choose_polygon_imagesc(205);
roi_sc = choose_polygon_imagesc(205);
roi_pf = choose_polygon_imagesc(205);







