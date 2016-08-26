xc=0:0.2:0.2*(size(distance_circle,1)-1);
xb=0:0.2:0.2*(size(distance_bg,1)-1);

figure
for i=20:68
    figure
    errorbar(xc,nanmean(nanmean(distance_circle(:,i,:),2),3),nanstd(nanmean(distance_circle(:,i,:),2),0,3)/sqrt(size(distance_circle,3)),'b')
    hold on
    errorbar(xb,nanmean(nanmean(distance_bg(:,i,:),2),3),nanstd(nanmean(distance_bg(:,i,:),2),0,3)/sqrt(size(distance_bg,3)),'r')
    xlim([0 2.2])    
end



figure
errorbar(xc,nanmean(nanmean(distance_circle(:,28,:),2),3),nanstd(nanmean(distance_circle(:,28,:),2),0,3)/sqrt(size(distance_circle,3)),'b')
hold on
errorbar(xc,nanmean(nanmean(distance_circle(:,35,:),2),3),nanstd(nanmean(distance_circle(:,35,:),2),0,3)/sqrt(size(distance_circle,3)),'c')
errorbar(xc,nanmean(nanmean(distance_circle(:,42,:),2),3),nanstd(nanmean(distance_circle(:,42,:),2),0,3)/sqrt(size(distance_circle,3)),'g')
errorbar(xc,nanmean(nanmean(distance_circle(:,49,:),2),3),nanstd(nanmean(distance_circle(:,49,:),2),0,3)/sqrt(size(distance_circle,3)),'m')
errorbar(xc,nanmean(nanmean(distance_circle(:,56,:),2),3),nanstd(nanmean(distance_circle(:,56,:),2),0,3)/sqrt(size(distance_circle,3)),'r')
plot(xc,zeros(1,size(distance_circle,1)),'k')
xlim([0 2.2]) 



figure
errorbar(xb,nanmean(nanmean(distance_bg(:,28,:),2),3),nanstd(nanmean(distance_bg(:,28,:),2),0,3)/sqrt(size(distance_bg,3)),'b')
hold on
errorbar(xb,nanmean(nanmean(distance_bg(:,35,:),2),3),nanstd(nanmean(distance_bg(:,35,:),2),0,3)/sqrt(size(distance_bg,3)),'c')
errorbar(xb,nanmean(nanmean(distance_bg(:,42,:),2),3),nanstd(nanmean(distance_bg(:,42,:),2),0,3)/sqrt(size(distance_bg,3)),'g')
errorbar(xb,nanmean(nanmean(distance_bg(:,49,:),2),3),nanstd(nanmean(distance_bg(:,49,:),2),0,3)/sqrt(size(distance_bg,3)),'m')
errorbar(xb,nanmean(nanmean(distance_bg(:,56,:),2),3),nanstd(nanmean(distance_bg(:,56,:),2),0,3)/sqrt(size(distance_bg,3)),'r')
plot(xb,zeros(1,size(distance_bg,1)),'k')
xlim([0 2.2]) 





figure
plot(xc,nanmean(nanmean(distance_circle(:,28,:),2),3),'LineWidth',1)
hold on
plot(xc,nanmean(nanmean(distance_circle(:,35,:),2),3),'LineWidth',2)
plot(xc,nanmean(nanmean(distance_circle(:,42,:),2),3),'LineWidth',4)
plot(xc,nanmean(nanmean(distance_circle(:,49,:),2),3),'LineWidth',6)
plot(xc,nanmean(nanmean(distance_circle(:,56,:),2),3),'LineWidth',8)
plot(xc,zeros(1,size(distance_circle,1)),'k')
xlim([0 2.2]) 
plot(xb,nanmean(nanmean(distance_bg(:,28,:),2),3),'LineWidth',1,'Color','r')
plot(xb,nanmean(nanmean(distance_bg(:,35,:),2),3),'LineWidth',2,'Color','r')
plot(xb,nanmean(nanmean(distance_bg(:,42,:),2),3),'LineWidth',4,'Color','r')
plot(xb,nanmean(nanmean(distance_bg(:,49,:),2),3),'LineWidth',6,'Color','r')
plot(xb,nanmean(nanmean(distance_bg(:,56,:),2),3),'LineWidth',8,'Color','r')




figure
plot(xc,nanmean(nanmean(distance_circle(:,24:28,:),2),3),'LineWidth',1)
hold on
plot(xc,nanmean(nanmean(distance_circle(:,33:37,:),2),3),'LineWidth',2)
plot(xc,nanmean(nanmean(distance_circle(:,40:44,:),2),3),'LineWidth',4)
plot(xc,nanmean(nanmean(distance_circle(:,47:51,:),2),3),'LineWidth',6)
plot(xc,nanmean(nanmean(distance_circle(:,54:58,:),2),3),'LineWidth',8)
plot(xc,zeros(1,size(distance_circle,1)),'k')
xlim([0 2.2]) 
plot(xb,nanmean(nanmean(distance_bg(:,24:28,:),2),3),'LineWidth',1,'Color','r')
plot(xb,nanmean(nanmean(distance_bg(:,33:37,:),2),3),'LineWidth',2,'Color','r')
plot(xb,nanmean(nanmean(distance_bg(:,40:44,:),2),3),'LineWidth',4,'Color','r')
plot(xb,nanmean(nanmean(distance_bg(:,47:51,:),2),3),'LineWidth',6,'Color','r')
plot(xb,nanmean(nanmean(distance_bg(:,54:58,:),2),3),'LineWidth',8,'Color','r')




figure
plot(xc,nanmean(nanmean(distance_circle_cont(:,28,:),2),3),'LineWidth',1)
hold on
plot(xc,nanmean(nanmean(distance_circle_cont(:,35,:),2),3),'LineWidth',2)
plot(xc,nanmean(nanmean(distance_circle_cont(:,42,:),2),3),'LineWidth',4)
plot(xc,nanmean(nanmean(distance_circle_cont(:,49,:),2),3),'LineWidth',6)
plot(xc,nanmean(nanmean(distance_circle_cont(:,56,:),2),3),'LineWidth',8)
plot(xc,zeros(1,size(distance_circle_cont,1)),'k')
xlim([0 2.2]) 
plot(xc,nanmean(nanmean(distance_circle_non(:,28,:),2),3),'LineWidth',1,'Color','r')
plot(xc,nanmean(nanmean(distance_circle_non(:,35,:),2),3),'LineWidth',2,'Color','r')
plot(xc,nanmean(nanmean(distance_circle_non(:,42,:),2),3),'LineWidth',4,'Color','r')
plot(xc,nanmean(nanmean(distance_circle_non(:,49,:),2),3),'LineWidth',6,'Color','r')
plot(xc,nanmean(nanmean(distance_circle_non(:,56,:),2),3),'LineWidth',8,'Color','r')






figure
plot(xb,nanmean(nanmean(distance_bg_cont(:,28,:),2),3),'LineWidth',1)
hold on
plot(xb,nanmean(nanmean(distance_bg_cont(:,35,:),2),3),'LineWidth',2)
plot(xb,nanmean(nanmean(distance_bg_cont(:,42,:),2),3),'LineWidth',4)
plot(xb,nanmean(nanmean(distance_bg_cont(:,49,:),2),3),'LineWidth',6)
plot(xb,nanmean(nanmean(distance_bg_cont(:,56,:),2),3),'LineWidth',8)
plot(xb,zeros(1,size(distance_bg_cont,1)),'k')
xlim([0 2.2]) 
plot(xb,nanmean(nanmean(distance_bg_non(:,28,:),2),3),'LineWidth',1,'Color','r')
plot(xb,nanmean(nanmean(distance_bg_non(:,35,:),2),3),'LineWidth',2,'Color','r')
plot(xb,nanmean(nanmean(distance_bg_non(:,42,:),2),3),'LineWidth',4,'Color','r')
plot(xb,nanmean(nanmean(distance_bg_non(:,49,:),2),3),'LineWidth',6,'Color','r')
plot(xb,nanmean(nanmean(distance_bg_non(:,56,:),2),3),'LineWidth',8,'Color','r')








for i=28:58
   figure 
    errorbar(xc,nanmean(nanmean(distance_circle(:,i,:),2),3),nanstd(nanmean(distance_circle(:,i,:),2),0,3)/sqrt(size(distance_circle,3)),'b')
    hold on
    errorbar(xb,nanmean(nanmean(distance_bg(:,i,:),2),3),nanstd(nanmean(distance_bg(:,i,:),2),0,3)/sqrt(size(distance_bg,3)),'r')
    xlim([0 2.2]) 
    ylim([-.4e-3 .2e-3]) 
    plot(xb,zeros(1,size(distance_bg,1)),'k')
    title(['time ',int2str(x(i)),' ms'])
end




for i=28:58
   figure 
    errorbar(xc,nanmean(nanmean(distance_circle_cont(:,i,:),2),3),nanstd(nanmean(distance_circle_cont(:,i,:),2),0,3)/sqrt(size(distance_circle_cont,3)),'b')
    hold on
    errorbar(xb,nanmean(nanmean(distance_bg_cont(:,i,:),2),3),nanstd(nanmean(distance_bg_cont(:,i,:),2),0,3)/sqrt(size(distance_bg_cont,3)),'r')
    xlim([0 2.2]) 
    ylim([-.4e-3 2.2e-3]) 
    plot(xb,zeros(1,size(distance_bg_cont,1)),'k')
    title(['time ',int2str(x(i)),' ms'])
end



for i=28:58
   figure 
    errorbar(xc,nanmean(nanmean(distance_circle_non(:,i,:),2),3),nanstd(nanmean(distance_circle_non(:,i,:),2),0,3)/sqrt(size(distance_circle_non,3)),'b')
    hold on
    errorbar(xb,nanmean(nanmean(distance_bg_non(:,i,:),2),3),nanstd(nanmean(distance_bg_non(:,i,:),2),0,3)/sqrt(size(distance_bg_non,3)),'r')
    xlim([0 2.2]) 
    ylim([-.4e-3 2.2e-3]) 
    plot(xb,zeros(1,size(distance_bg_non,1)),'k')
    title(['time ',int2str(x(i)),' ms'])
end



for i=28:58
   figure 
    errorbar(xc,nanmean(nanmean(distance_circle_cont(:,i,:),2),3),nanstd(nanmean(distance_circle_cont(:,i,:),2),0,3)/sqrt(size(distance_circle_cont,3)),'b')
    hold on
    errorbar(xc,nanmean(nanmean(distance_circle_non(:,i,:),2),3),nanstd(nanmean(distance_circle_non(:,i,:),2),0,3)/sqrt(size(distance_circle_non,3)),'r')
    xlim([0 2.2]) 
    ylim([-.4e-3 2.2e-3]) 
    plot(xc,zeros(1,size(distance_circle_non,1)),'k')
    title(['time ',int2str(x(i)),' ms'])
end


for i=28:58
   figure 
    errorbar(xb,nanmean(nanmean(distance_bg_cont(:,i,:),2),3),nanstd(nanmean(distance_bg_cont(:,i,:),2),0,3)/sqrt(size(distance_bg_cont,3)),'b')
    hold on
    errorbar(xb,nanmean(nanmean(distance_bg_non(:,i,:),2),3),nanstd(nanmean(distance_bg_non(:,i,:),2),0,3)/sqrt(size(distance_bg_non,3)),'r')
    xlim([0 2.2]) 
    ylim([-.4e-3 2.2e-3]) 
    plot(xb,zeros(1,size(distance_bg_non,1)),'k')
    title(['time ',int2str(x(i)),' ms'])
end

