

%% SMEAGOL 
session_circ=[1:23 26 27 36 37];
session_bg=[24 25 28:35];

x=(20:10:1120)-280;
figure;errorbar(x,nanmean(diff_V2_circle(:,session_circ),2),nanstd(diff_V2_circle(:,session_circ),0,2)/sqrt(size(diff_V2_circle(:,session_circ),2)));
hold on
errorbar(x,nanmean(diff_circle(:,session_circ),2),nanstd(diff_circle(:,session_circ),0,2)/sqrt(size(diff_circle(:,session_circ),2)),'r');
plot(x,zeros(1,111),'k')
xlim([-100 300])

x=(20:10:1120)-280;
figure;errorbar(x,nanmean(diff_V2_bg(:,session_bg),2),nanstd(diff_V2_bg(:,session_bg),0,2)/sqrt(size(diff_V2_bg(:,session_bg),2)),'b');
hold on
errorbar(x,nanmean(diff_bg(:,session_bg),2),nanstd(diff_bg(:,session_bg),0,2)/sqrt(size(diff_bg(:,session_bg),2)),'r');
plot(x,zeros(1,111),'k')
xlim([-100 300])


x=(20:10:1120)-280;
figure;errorbar(x,nanmean(diff_v1_v2_circle(:,session_circ),2),nanstd(diff_v1_v2_circle(:,session_circ),0,2)/sqrt(size(diff_v1_v2_circle(:,session_circ),2)));
hold on
errorbar(x,nanmean(diff_v1_v2_bg(:,session_bg),2),nanstd(diff_v1_v2_bg(:,session_bg),0,2)/sqrt(size(diff_v1_v2_bg(:,session_bg),2)),'r');
plot(x,zeros(1,111),'k')
xlim([-100 300])


x=(20:10:1120)-280;
figure;plot(x,nanmean(diff_v1_v2_circle(:,session_circ),2));
hold on
plot(x,nanmean(diff_v1_v2_bg(:,session_bg),2),'r');
plot(x,zeros(1,111),'k')
xlim([-100 300])


for i=1:57
    p=signrank(diff_v1_v2_circle(i,session_circ));
    if p<0.05
        disp(x(i))
        disp(p)
    end
end
    
    
for i=1:57
    p=signrank(diff_v1_v2_bg(i,session_bg));
    if p<0.05
        disp(x(i))
        disp(p)
    end
end
        


    
    
%% LEGOLAS

x=(20:10:1120)-280;
figure;errorbar(x,nanmean(diff_V2_circ(:,:),2),nanstd(diff_V2_circ(:,:),0,2)/sqrt(size(diff_V2_circ(:,:),2)));
hold on
errorbar(x,nanmean(diff_V1_circ(:,:),2),nanstd(diff_V1_circ(:,:),0,2)/sqrt(size(diff_V1_circ(:,:),2)),'r');
plot(x,zeros(1,111),'k')
xlim([-100 300])


x=(20:10:1120)-280;
figure;errorbar(x,nanmean(diff_V2_bg(:,:),2),nanstd(diff_V2_bg(:,:),0,2)/sqrt(size(diff_V2_bg(:,:),2)),'b');
hold on
errorbar(x,nanmean(diff_V1_bg(:,:),2),nanstd(diff_V1_bg(:,:),0,2)/sqrt(size(diff_V1_bg(:,:),2)),'r');
plot(x,zeros(1,111),'k')
xlim([-100 300])



x=(20:10:1120)-280;
figure;errorbar(x,nanmean(diff_v1_v2_circ(:,:),2),nanstd(diff_v1_v2_circ(:,:),0,2)/sqrt(size(diff_v1_v2_circ(:,:),2)));
hold on
errorbar(x,nanmean(diff_v1_v2_bg(:,:),2),nanstd(diff_v1_v2_bg(:,:),0,2)/sqrt(size(diff_v1_v2_bg(:,:),2)),'r');
plot(x,zeros(1,111),'k')
xlim([-100 300])


x=(20:10:1120)-280;
figure;plot(x,nanmean(diff_v1_v2_circ(:,:),2));
hold on
plot(x,nanmean(diff_v1_v2_bg(:,:),2),'r');
plot(x,zeros(1,111),'k')
xlim([-100 300])



%%
% legolas
x=(20:10:1120)-280;
fg_V2=mean(diff_V2_circ,2)-mean(diff_V2_bg,2);
fg_V1=mean(diff_V1_circ,2)-mean(diff_V1_bg,2);

figure;plot(x,fg_V2)
hold on
plot(x,fg_V1,'--')
plot(x,zeros(1,111),'k')
xlim([-100 300])


%smeagol
session_circ=[1:23 26 27 36 37];
session_bg=[24 25 28:35];

x=(20:10:1120)-280;
fg_V2=mean(diff_V2_circle(:,session_circ),2)-mean(diff_V2_bg(:,session_bg),2);
fg_V1=nanmean(diff_circle(:,session_circ),2)-nanmean(diff_bg(:,session_bg),2);

figure;plot(x,fg_V2)
hold on
plot(x,fg_V1,'--')
plot(x,zeros(1,111),'k')
xlim([-100 300])












