
cd D:\intrinsic\20150617\a\Matt_files
load('whisker_envelope.mat')

for i=1:1:size(whisk_env,2)
    whisk_env_smooth(:,i)=smooth(whisk_env(:,i),7,'Gauss');
end

w=4;
whisk_der=whisk_env_smooth(w:end,:)-whisk_env_smooth(1:end-w+1,:);

th=-1.5;
%find(whisk_der>th);
der_th=whisk_der<th;

whisk_start=zeros(size(whisk_env));
for i=1:1:size(whisk_env,2)
    t=find(der_th(:,i));
    a=zeros(size(whisk_env,1),1);
    a(t)=1;
    d=diff(a);
    g=find(d==-1);
    gg=find(d==1);
    if ~isempty(g)
       if ~isempty(gg)
           if size(g,1)>size(gg,1)           
                g(1)=[];
           end     
           if size(g,1)<size(gg,1)           
               gg(end)=[];
           end  
            u=find([gg(2:end);size(whisk_env,1)]-g(1:end)>40);
            whisk_start(g(u)+4,i)=1;
       end
    end
end



k=0;
for i=1:1:size(whisk_env,2)
    tttt=find(whisk_start(:,i));
    for j=tttt'
        if j<125&&j>18
            k=k+1;
            whisk_trigger(:,k)=whisk_env_smooth(j-10:j+40,i);
        end
    end
end

xt=(1:51)*0.05-0.5;
figure;errorbar(xt,nanmedian(whisk_trigger,2),nanstd(whisk_trigger,0,2)/sqrt(size(whisk_trigger,2)))
xlim([-.4 2])

for i=1:20
    figure;plot(xt,whisk_trigger(:,i))
end


k=0;
for i=1:1:size(whisk_env,2)
    disp(i)
    load(['stim_trial',int2str(i)])
    tttt=find(whisk_start(:,i));
    for j=tttt'
        if j<125&&j>18
            k=k+1;
            amp_wh_trig(:,:,:,k)=tr(:,:,((j-7)-10):((j-7)+40));
        end
    end
end


% 
% 
for i=51:-1:1
    figure;imagesc(smoothn(nanmean(amp_wh_trig(:,:,i,:),4)-1,[3 3],'Gauss'),[-1e-2 1e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,205,205),'k')
    title([int2str(xt(i)*1000)])
    %title([int2str(i)])
end

% % 
% for ii=1:50
%     d=reshape(amp_wh_trig(:,:,:,ii),205*205,size(amp_wh_trig,3));
%     figure;
%     subplot(2,1,1)    
%     plot(xt,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'))
%     hold on
%     plot(xt,smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'),'c')
%     plot(xt,smooth(squeeze(nanmean(d(roi_ic,:),1))-1,1,'Gauss'),'r')
%     plot(xt,smooth(squeeze(nanmean(d(roi_sc,:),1))-1,1,'Gauss'),'g')
%     %plot(xt,smooth(squeeze(nanmean(d(roi_rs,:),1))-1,1,'Gauss'),'k')
%     %plot(xt,smooth(squeeze(nanmean(d(roi_pf,:),1))-1,1,'Gauss'),'m')
%     plot(xt,zeros(1,size(amp_wh_trig,3)),'k')
%     %legend('m2','sc','ic','ppc','rs','pf')
%     subplot(2,1,2)
%     plot(xt,whisk_trigger(:,ii))
%     title([int2str(ii)])
% end

fr_0=nanmean(amp_wh_trig(:,:,48:51,:),3);
amp_wh_trig=amp_wh_trig./repmat(fr_0,[1 1 size(amp_wh_trig,3) 1]);


%amp_trig_ave=nanmean(amp_wh_trig(:,:,:,:),4);

amp_trig_ave1=nanmean(amp_wh_trig(:,:,:,1:round(size(amp_wh_trig,4)/3)),4);
amp_trig_ave2=nanmean(amp_wh_trig(:,:,:,(round(size(amp_wh_trig,4)/3)+1):round(size(amp_wh_trig,4)*2/3)),4);
amp_trig_ave3=nanmean(amp_wh_trig(:,:,:,(round(size(amp_wh_trig,4)*2/3)+1):end),4);
amp_trig_ave=(amp_trig_ave1+amp_trig_ave2+amp_trig_ave3)/3;

load('rois_initial_205x205.mat')
d=reshape(amp_trig_ave,205*205,size(amp_trig_ave,3));
figure;
plot(xt-0.05,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'))
hold on
%plot(xt-0.05,smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'),'c')
plot(xt-0.05,smooth(squeeze(nanmean(d(roi_ic,:),1))-1,1,'Gauss'),'r')
plot(xt-0.05,smooth(squeeze(nanmean(d(roi_sc,:),1))-1,1,'Gauss'),'g')
%plot(xt,smooth(squeeze(nanmean(d(roi_rs,:),1))-1,1,'Gauss'),'k')
%plot(xt,smooth(squeeze(nanmean(d(roi_pf,:),1))-1,1,'Gauss'),'m')
plot(xt-0.05,zeros(1,size(amp_trig_ave,3)),'k')
%legend('m2','sc','ic','ppc','rs','pf')

fr_0w=nanmean(whisk_trigger(48:51,:),1);
whisk_trigger=whisk_trigger-repmat(fr_0w,[size(whisk_trigger,1) 1]);
figure;errorbar(xt,nanmean(whisk_trigger,2),nanstd(whisk_trigger,0,2)/sqrt(size(whisk_trigger,2)))
% 
dd=nan*ones(205*205,size(amp_wh_trig,3),size(amp_wh_trig,4));
for i=1:size(amp_wh_trig,4)
    disp(i)
    temp=amp_wh_trig(:,:,:,i);
    d=reshape(temp,205*205,size(amp_wh_trig,3));
    dd(:,:,i)=d;
end
% 
figure;
errorbar(xt-0.05,smooth(squeeze(nanmean(nanmean(dd(roi_m2,:,:),1),3))-1,1,'Gauss'),squeeze(nanstd(nanmean(dd(roi_m2,:,:),1),0,3))/sqrt(size(dd,3)),'k')
hold on
errorbar(xt-0.05,smooth(squeeze(nanmean(nanmean(dd(roi_s1,:,:),1),3))-1,1,'Gauss'),squeeze(nanstd(nanmean(dd(roi_s1,:,:),1),0,3))/sqrt(size(dd,3)),'b')
errorbar(xt-0.05,smooth(squeeze(nanmean(nanmean(dd(roi_ic,:,:),1),3))-1,1,'Gauss'),squeeze(nanstd(nanmean(dd(roi_ic,:,:),1),0,3))/sqrt(size(dd,3)),'r')
errorbar(xt-0.05,smooth(squeeze(nanmean(nanmean(dd(roi_sc,:,:),1),3))-1,1,'Gauss'),squeeze(nanstd(nanmean(dd(roi_sc,:,:),1),0,3))/sqrt(size(dd,3)),'g')
errorbar(xt-0.05,smooth(squeeze(nanmean(nanmean(dd(roi_rs,:,:),1),3))-1,1,'Gauss'),squeeze(nanstd(nanmean(dd(roi_rs,:,:),1),0,3))/sqrt(size(dd,3)),'c')
plot(xt-0.05,zeros(1,size(amp_wh_trig,3)),'k')
legend('m2','s1','ic','sc','rs')
xlim([-.4 1])



figure;
errorbar(xt-0.05,smooth(squeeze(nanmean(nanmedian(dd(roi_m2,:,:),1),3))-1,1,'Gauss'),squeeze(nanstd(nanmean(dd(roi_m2,:,:),1),0,3))/sqrt(size(dd,3)),'k')
hold on
errorbar(xt-0.05,smooth(squeeze(nanmean(nanmedian(dd(roi_s1,:,:),1),3))-1,1,'Gauss'),squeeze(nanstd(nanmean(dd(roi_s1,:,:),1),0,3))/sqrt(size(dd,3)),'b')
%errorbar(xt-0.05,smooth(squeeze(nanmean(nanmean(dd(roi_a1,:,:),1),3))-1,1,'Gauss'),squeeze(nanstd(nanmean(dd(roi_rs,:,:),1),0,3))/sqrt(size(dd,3)),'c')
plot(xt-0.05,zeros(1,size(amp_wh_trig,3)),'k')
legend('m2','s1','ic','sc','rs')
xlim([-.4 1])






% for i=73
%     figure;subplot(3,1,1)
%     plot(whisk_env(1:150,i))
%     ylim([-5 13])
%     %xlim([-3 6])
%     title([int2str(i)])
%     subplot(3,1,2)
%     plot(whisk_env_smooth(1:150,i))
%     ylim([-5 13])
%     %xlim([-3 6])
%     subplot(3,1,3)
%     plot(whisk_der(1:150,i),'r')
%     hold on
%     plot(1.5*ones(1,150),'k')
%     ylim([-3 4])
% end

% whisk_start_t=whisk_start;
% whisk_start_t(144:end,:)=0;
% figure;imagesc(abs(der_th(:,73:93)'-1));colormap(gray)
% figure;imagesc(abs(whisk_start(:,73:93)'-1));colormap(gray)

y=fliplr(smoothn(nanmean(amp_trig_ave(:,:,18:22),3)-1,[3 3],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-.5e-2 2.5e-2]);colormap(mapgeog)
hold on
%h=zeros(205*205,1);
%h(roi_s1)=1;
%contour(fliplr(reshape(h,205,205)'),'k')
%line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off

y=fliplr(smoothn(nanmean(amp_trig_ave(:,:,16:22),3)-1,[3 3],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-.5e-2 2e-2]);colormap(mapgeog)
hold on
%h=zeros(205*205,1);
%h(roi_s1)=1;
%contour(fliplr(reshape(h,205,205)'),'k')
%line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off

% 
for i=1:20:200
    figure;subplot(2,1,1)
    plot(whisk_trigger(:,i))
    %ylim([-5 13])
    %xlim([-3 6])
    title([int2str(i)])
    subplot(2,1,2)
    d=reshape(amp_wh_trig(:,:,:,i),205*205,51);
    plot(nanmean(d(roi_m2,:),1),'r')
    hold on
end



% amp_trig_ave=nanmean(amp_wh_trig(:,:,:,[1 2 3 4 5 8 13 18 19 20 22 23 26 27 28 29 30 31 33 34 35 41 42 46 47 48 50 55 63 64 65 66 71 76 80 81 82 85 87 91 92 94 96 99 100 104 105 106 107 109 114]),4);
% 
% d=reshape(amp_trig_ave,205*205,size(amp_trig_ave,3));
% figure;
% plot(xt-0.05,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'))
% hold on
% %plot(xt-0.05,smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'),'c')
% plot(xt-0.05,smooth(squeeze(nanmean(d(roi_ic,:),1))-1,1,'Gauss'),'r')
% plot(xt-0.05,smooth(squeeze(nanmean(d(roi_sc,:),1))-1,1,'Gauss'),'g')
% %plot(xt,smooth(squeeze(nanmean(d(roi_rs,:),1))-1,1,'Gauss'),'k')
% %plot(xt,smooth(squeeze(nanmean(d(roi_pf,:),1))-1,1,'Gauss'),'m')
% plot(xt-0.05,zeros(1,size(amp_trig_ave,3)),'k')
% %legend('m2','sc','ic','ppc','rs','pf')
% 



k=0;
amp_trig_ses=nan*ones(205,205,51,21);
for i=1:25:size(amp_wh_trig,4)-25
    disp(i)
    k=k+1;
    amp_trig_ses(:,:,:,k)=nanmean(amp_wh_trig(:,:,:,i:i+24),4);
end

dd=nan*ones(205*205,size(amp_trig_ses,3),size(amp_trig_ses,4));
for i=1:size(amp_trig_ses,4)
    disp(i)
    temp=amp_trig_ses(:,:,:,i);
    d=reshape(temp,205*205,size(amp_trig_ses,3));
    dd(:,:,i)=d;
end

figure;
errorbar(xt-0.05,smooth(squeeze(nanmean(nanmean(dd(roi_m2,:,:),1),3))-1,1,'Gauss'),squeeze(nanstd(nanmean(dd(roi_m2,:,:),1),0,3))/sqrt(size(dd,3)),'k')
hold on
errorbar(xt-0.05,smooth(squeeze(nanmean(nanmean(dd(roi_s1,:,:),1),3))-1,1,'Gauss'),squeeze(nanstd(nanmean(dd(roi_s1,:,:),1),0,3))/sqrt(size(dd,3)),'b')
errorbar(xt-0.05,smooth(squeeze(nanmean(nanmean(dd(roi_a1,:,:),1),3))-1,1,'Gauss'),squeeze(nanstd(nanmean(dd(roi_a1,:,:),1),0,3))/sqrt(size(dd,3)),'g')
%errorbar(xt-0.05,smooth(squeeze(nanmean(nanmean(dd(roi_sc,:,:),1),3))-1,1,'Gauss'),squeeze(nanstd(nanmean(dd(roi_sc,:,:),1),0,3))/sqrt(size(dd,3)),'g')
%errorbar(xt-0.05,smooth(squeeze(nanmean(nanmean(dd(roi_rs,:,:),1),3))-1,1,'Gauss'),squeeze(nanstd(nanmean(dd(roi_rs,:,:),1),0,3))/sqrt(size(dd,3)),'c')
plot(xt-0.05,zeros(1,size(amp_wh_trig,3)),'k')
legend('m2','s1','ic','sc','rs')
xlim([-.4 2])


