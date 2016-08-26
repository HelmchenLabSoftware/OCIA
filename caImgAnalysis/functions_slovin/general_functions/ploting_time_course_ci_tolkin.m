
roi=roi_bg_out;
time=2:130;

figure;errorbar(mean(mean(cond1n_dt_bl(roi,time,:)-1,1),3),std(mean(cond1n_dt_bl(roi,time,:)-1,1),0,3)/sqrt(size(cond1n_dt_bl,3)));
hold on
errorbar(mean(mean(cond4n_dt_bl(roi,time,:)-1,1),3),std(mean(cond4n_dt_bl(roi,time,:)-1,1),0,3)/sqrt(size(cond4n_dt_bl,3)),'g');

figure;errorbar(mean(mean(cond2n_dt_bl(roi,2:100,:)-1,1),3),std(mean(cond2n_dt_bl(roi,2:100,:)-1,1),0,3)/sqrt(size(cond2n_dt_bl,3)));
hold on
errorbar(mean(mean(cond5n_dt_bl(roi,2:100,:)-1,1),3),std(mean(cond5n_dt_bl(roi,2:100,:)-1,1),0,3)/sqrt(size(cond5n_dt_bl,3)),'g');
