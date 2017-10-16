


% 
% time=20:23;
% figure;
% scatter(mean(non(roi_contour2,time),2)-1,mean(con(roi_contour2,time),2)-1)
% hold on
% plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
% xlim([0 0.5e-3]);ylim([0 0.5e-3])
% ranksum(mean(non(roi_contour2,time),2)-1,mean(con(roi_contour2,time),2)-1)

%% LEGOLAS

con=(a+b)/2;
non=(c+d)/2;


time=20:23;
diff_circ=mean(con(roi_contour2,time),2)-mean(non(roi_contour2,time),2);
figure;hist(diff_circ)
top_circ = prctile(diff_circ,99);
bottom_circ = prctile(diff_circ,1);

time=34:36;
diff_circ=mean(con(roi_contour2,time),2)-mean(non(roi_contour2,time),2);
sum(diff_circ>top_circ)/size(diff_circ,1)
sum(diff_circ<bottom_circ)/size(diff_circ,1)

time=49:51;
diff_circ=mean(con(roi_contour2,time),2)-mean(non(roi_contour2,time),2);
sum(diff_circ>top_circ)/size(diff_circ,1)
sum(diff_circ<bottom_circ)/size(diff_circ,1)

time=20:23;
diff_bg=mean(con(roi_maskin,time),2)-mean(non(roi_maskin,time),2);
figure;hist(diff_bg)
top_bg = prctile(diff_bg,99);
bottom_bg = prctile(diff_bg,1);

time=34:36;
diff_bg=mean(con(roi_maskin,time),2)-mean(non(roi_maskin,time),2);
sum(diff_bg>top_bg)/size(diff_bg,1)
sum(diff_bg<bottom_bg)/size(diff_bg,1)

time=49:51;
diff_bg=mean(con(roi_maskin,time),2)-mean(non(roi_maskin,time),2);
sum(diff_bg>top_bg)/size(diff_bg,1)
sum(diff_bg<bottom_bg)/size(diff_bg,1)






%% smeagol


time=20:23;
diff_circ=mean(con(roi_circle,time),2)-mean(non(roi_circle,time),2);
figure;hist(diff_circ)
top_circ = prctile(diff_circ,99);
bottom_circ = prctile(diff_circ,1);

time=34:36;
diff_circ=mean(con(roi_circle,time),2)-mean(non(roi_circle,time),2);
sum(diff_circ>top_circ)/size(diff_circ,1)
sum(diff_circ<bottom_circ)/size(diff_circ,1)

time=49:51;
diff_circ=mean(con(roi_circle,time),2)-mean(non(roi_circle,time),2);
sum(diff_circ>top_circ)/size(diff_circ,1)
sum(diff_circ<bottom_circ)/size(diff_circ,1)

time=20:23;
diff_bg=mean(con(roi_bg_out,time),2)-mean(non(roi_bg_out,time),2);
figure;hist(diff_bg)
top_bg = prctile(diff_bg,99);
bottom_bg = prctile(diff_bg,1);

time=34:36;
diff_bg=mean(con(roi_bg_out,time),2)-mean(non(roi_bg_out,time),2);
sum(diff_bg>top_bg)/size(diff_bg,1)
sum(diff_bg<bottom_bg)/size(diff_bg,1)

time=49:51;
diff_bg=mean(con(roi_bg_out,time),2)-mean(non(roi_bg_out,time),2);
sum(diff_bg>top_bg)/size(diff_bg,1)
sum(diff_bg<bottom_bg)/size(diff_bg,1)





