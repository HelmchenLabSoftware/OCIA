%% 0501b14
con=a;
non=c;


h=zeros(10000,1);
h(roi_circle)=1;
h(roi_bg_in)=1;

time=50;
y=mfilt2(mean(con(:,time)-non(:,time),2),100,100,1.5,'lm');
y(pixels_to_remove)=10;
figure(100)
mimg(y,100,100,-.1e-3,.3e-3);colormap(mapgeog)
hold on
contour(reshape(h,100,100)')
hold on
line([1 72],[40 41],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
line([72 94],[41 30],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
line([1 65],[50 52],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
line([65 96],[52 43],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')   
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)



time=20:23;
diff_circ=mean(con(roi_circle,time),2)-mean(non(roi_circle,time),2);
figure;hist(diff_circ)
top_circ = prctile(diff_circ,99);
bottom_circ = prctile(diff_circ,1);


time=50;
diff_circ=mean(con(roi_circle,time),2)-mean(non(roi_circle,time),2);
sum(diff_circ>top_circ)/size(diff_circ,1)
sum(diff_circ<bottom_circ)/size(diff_circ,1)

figure;
scatter(mean(non(roi_circle,time),2)-1,mean(con(roi_circle,time),2)-1)
hold on
plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_circ,'r')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_circ,'r')
xlim([0 2e-3]);ylim([0 2e-3])
axis square
ranksum(mean(non(roi_circle,time),2)-1,mean(con(roi_circle,time),2)-1)


time=20:23;
diff_bg=mean(con(roi_bg_in,time),2)-mean(non(roi_bg_in,time),2);
figure;hist(diff_bg)
top_bg = prctile(diff_bg,99);
bottom_bg = prctile(diff_bg,1);

time=50;
diff_bg=mean(con(roi_bg_in,time),2)-mean(non(roi_bg_in,time),2);
sum(diff_bg>top_bg)/size(diff_bg,1)
sum(diff_bg<bottom_bg)/size(diff_bg,1)
figure;
scatter(mean(non(roi_bg_in,time),2)-1,mean(con(roi_bg_in,time),2)-1)
hold on
plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_bg,'r')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_bg,'r')
xlim([0 2e-3]);ylim([0 2e-3])
axis square
ranksum(mean(non(roi_bg_in,time),2)-1,mean(con(roi_bg_in,time),2)-1)


%% 1711c14


con=a;
non=c;


h=zeros(10000,1);
h(roi_circle)=1;
h(roi_bg_in)=1;

time=51:55;
y=mfilt2(mean(con(:,time)-non(:,time),2),100,100,1.5,'lm');
y(pixels_to_remove)=10;
figure(100)
mimg(y,100,100,-.3e-3,.3e-3);colormap(mapgeog)
hold on
contour(reshape(h,100,100)')
hold on
line([1 72],[40 41],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
line([72 94],[41 30],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
line([1 65],[50 52],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
line([65 96],[52 43],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')   
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)



time=20:23;
diff_circ=mean(con(roi_circle,time),2)-mean(non(roi_circle,time),2);
figure;hist(diff_circ)
top_circ = prctile(diff_circ,99);
bottom_circ = prctile(diff_circ,1);


time=51:55;
diff_circ=mean(con(roi_circle,time),2)-mean(non(roi_circle,time),2);
sum(diff_circ>top_circ)/size(diff_circ,1)
sum(diff_circ<bottom_circ)/size(diff_circ,1)

figure;
scatter(mean(non(roi_circle,time),2)-1,mean(con(roi_circle,time),2)-1)
hold on
plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_circ,'r')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_circ,'r')
xlim([0 2e-3]);ylim([0 2e-3])
axis square
ranksum(mean(non(roi_circle,time),2)-1,mean(con(roi_circle,time),2)-1)


time=20:23;
diff_bg=mean(con(roi_bg_in,time),2)-mean(non(roi_bg_in,time),2);
figure;hist(diff_bg)
top_bg = prctile(diff_bg,99);
bottom_bg = prctile(diff_bg,1);

time=51:55;
diff_bg=mean(con(roi_bg_in,time),2)-mean(non(roi_bg_in,time),2);
sum(diff_bg>top_bg)/size(diff_bg,1)
sum(diff_bg<bottom_bg)/size(diff_bg,1)
figure;
scatter(mean(non(roi_bg_in,time),2)-1,mean(con(roi_bg_in,time),2)-1)
hold on
plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_bg,'r')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_bg,'r')
xlim([0 2e-3]);ylim([0 2e-3])
axis square
ranksum(mean(non(roi_bg_in,time),2)-1,mean(con(roi_bg_in,time),2)-1)





%% 2411d14


con=a;
non=c;


h=zeros(10000,1);
h(roi_circle)=1;
h(roi_bg_in)=1;

time=50:51;
y=mfilt2(mean(con(:,time)-non(:,time),2),100,100,1.5,'lm');
y(pixels_to_remove)=10;
figure(100)
mimg(y,100,100,-.1e-3,.3e-3);colormap(mapgeog)
hold on
contour(reshape(h,100,100)')
hold on
line([1 72],[40 41],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
line([72 94],[41 30],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
line([1 65],[50 52],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
line([65 96],[52 43],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')   
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)



time=20:23;
diff_circ=mean(con(roi_circle,time),2)-mean(non(roi_circle,time),2);
figure;hist(diff_circ)
top_circ = prctile(diff_circ,99);
bottom_circ = prctile(diff_circ,1);


time=50:51;
diff_circ=mean(con(roi_circle,time),2)-mean(non(roi_circle,time),2);
sum(diff_circ>top_circ)/size(diff_circ,1)
sum(diff_circ<bottom_circ)/size(diff_circ,1)

figure;
scatter(mean(non(roi_circle,time),2)-1,mean(con(roi_circle,time),2)-1)
hold on
plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_circ,'r')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_circ,'r')
xlim([0 2e-3]);ylim([0 2e-3])
axis square
ranksum(mean(non(roi_circle,time),2)-1,mean(con(roi_circle,time),2)-1)


time=20:23;
diff_bg=mean(con(roi_bg_in,time),2)-mean(non(roi_bg_in,time),2);
figure;hist(diff_bg)
top_bg = prctile(diff_bg,99);
bottom_bg = prctile(diff_bg,1);

time=50:51;
diff_bg=mean(con(roi_bg_in,time),2)-mean(non(roi_bg_in,time),2);
sum(diff_bg>top_bg)/size(diff_bg,1)
sum(diff_bg<bottom_bg)/size(diff_bg,1)
figure;
scatter(mean(non(roi_bg_in,time),2)-1,mean(con(roi_bg_in,time),2)-1)
hold on
plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_bg,'r')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_bg,'r')
xlim([0 2e-3]);ylim([0 2e-3])
axis square
ranksum(mean(non(roi_bg_in,time),2)-1,mean(con(roi_bg_in,time),2)-1)









