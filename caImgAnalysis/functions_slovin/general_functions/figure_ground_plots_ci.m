
roi1=roi_circle;
roi2=roi_bg;


fg_cont=squeeze(mean(cond1n_dt_bl(roi1,2:112,:),1)-mean(cond1n_dt_bl(roi2,2:112,:),1));
fg_non=squeeze(mean(cond4n_dt_bl(roi1,2:112,:),1)-mean(cond4n_dt_bl(roi2,2:112,:),1));

figure;errorbar(mean(fg_cont,2),std(fg_cont,0,2)/sqrt(size(fg_cont,2)))
hold on
errorbar(mean(fg_non,2),std(fg_non,0,2)/sqrt(size(fg_non,2)),'r')


fg_cont=squeeze(mean(cond2n_dt_bl(roi1,2:112,:),1)-mean(cond2n_dt_bl(roi2,2:112,:),1));
fg_non=squeeze(mean(cond5n_dt_bl(roi1,2:112,:),1)-mean(cond5n_dt_bl(roi2,2:112,:),1));

figure;errorbar(mean(fg_cont,2),std(fg_cont,0,2)/sqrt(size(fg_cont,2)))
hold on
errorbar(mean(fg_non,2),std(fg_non,0,2)/sqrt(size(fg_non,2)),'r')



%%

roi1=roi_circle;
roi2=roi_bg_out;


fg_cont=squeeze(mean(cond1n_dt_bl(roi1,2:112,:),1)-mean(cond1n_dt_bl(roi2,2:112,:),1));
fg_jit1=squeeze(mean(cond4n_dt_bl(roi1,2:112,:),1)-mean(cond4n_dt_bl(roi2,2:112,:),1));
fg_jit2=squeeze(mean(cond2n_dt_bl(roi1,2:112,:),1)-mean(cond2n_dt_bl(roi2,2:112,:),1));
fg_non=squeeze(mean(cond5n_dt_bl(roi1,2:112,:),1)-mean(cond5n_dt_bl(roi2,2:112,:),1));


figure;errorbar(mean(fg_cont,2),std(fg_cont,0,2)/sqrt(size(fg_cont,2)))
hold on
errorbar(mean(fg_non,2),std(fg_non,0,2)/sqrt(size(fg_non,2)),'r')
errorbar(mean(fg_jit1,2),std(fg_jit1,0,2)/sqrt(size(fg_jit1,2)),'g')
errorbar(mean(fg_jit2,2),std(fg_jit2,0,2)/sqrt(size(fg_jit2,2)),'c')







