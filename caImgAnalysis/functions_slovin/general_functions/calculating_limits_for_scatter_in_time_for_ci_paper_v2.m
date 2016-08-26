


%% LEGOLAS

con=(a+b)/2;
non=(c+d)/2;


time=20:23;
diff_circ=mean(con(roi_contour2,time),2)-mean(non(roi_contour2,time),2);
figure;hist(diff_circ)
top_circ = mean(diff_circ)+1.96*std(diff_circ)/sqrt(size(roi_contour2,1));
bottom_circ = mean(diff_circ)-1.96*std(diff_circ)/sqrt(size(roi_contour2,1));

time=34:36;
diff_circ=mean(con(roi_contour2,time),2)-mean(non(roi_contour2,time),2);
sum(diff_circ>top_circ)/size(diff_circ,1)
sum(diff_circ<bottom_circ)/size(diff_circ,1)

time=49:51;
diff_circ=mean(con(roi_contour2,time),2)-mean(non(roi_contour2,time),2);
sum(diff_circ>top_circ)/size(diff_circ,1)
sum(diff_circ<bottom_circ)/size(diff_circ,1)













