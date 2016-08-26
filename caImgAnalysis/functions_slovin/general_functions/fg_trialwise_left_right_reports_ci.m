





[n1 x1]=hist(fg_10(right2),-.5e-3:0.0001:1e-3);
[n2 x2]=hist(fg_10(left2),-.5e-3:0.0001:1e-3);
figure;bar(x1,[n2;n1]','stack')
ranksum(fg_10(right2),fg_10(left2))



[n1 x1]=hist(fg_5(right2),-.5e-3:0.0001:1e-3);
[n2 x2]=hist(fg_5(left2),-.5e-3:0.0001:1e-3);
figure;bar(x1,[n2;n1]','stack')
ranksum(fg_5(right2),fg_5(left2))

%% 2511
fgr15=squeeze(mean(mean(cond4n_dt_bl_right(roi_contour,48:53,:),1),2)-mean(mean(cond4n_dt_bl_right(roi_bg_in,48:53,:),1),2));
fgl15=squeeze(mean(mean(cond4n_dt_bl_left(roi_contour,48:53,:),1),2)-mean(mean(cond4n_dt_bl_left(roi_bg_in,48:53,:),1),2));
[n1 x1]=hist(fgr15,-.5e-3:0.0001:1e-3);
[n2 x2]=hist(fgl15,-.5e-3:0.0001:1e-3);
figure;bar(x1,[n2;n1]','stack')
ranksum(fgr15,fgl15)

fgr10=squeeze(mean(mean(cond2n_dt_bl_right(roi_contour,48:53,:),1),2)-mean(mean(cond2n_dt_bl_right(roi_bg_in,48:53,:),1),2));
fgl10=squeeze(mean(mean(cond2n_dt_bl_left(roi_contour,48:53,:),1),2)-mean(mean(cond2n_dt_bl_left(roi_bg_in,48:53,:),1),2));
[n1 x1]=hist(fgr10,-.5e-3:0.0001:1e-3);
[n2 x2]=hist(fgl10,-.5e-3:0.0001:1e-3);
figure;bar(x1,[n2;n1]','stack')
ranksum(fgr10,fgl10)


fgr17=squeeze(mean(mean(cond2n_dt_bl_right(roi_contour,48:53,:),1),2)-mean(mean(cond2n_dt_bl_right(roi_bg_in,48:53,:),1),2));
fgl17=squeeze(mean(mean(cond2n_dt_bl_left(roi_contour,48:53,:),1),2)-mean(mean(cond2n_dt_bl_left(roi_bg_in,48:53,:),1),2));
[n1 x1]=hist(fgr17,-.5e-3:0.0001:1e-3);
[n2 x2]=hist(fgl17,-.5e-3:0.0001:1e-3);
figure;bar(x1,[n2;n1]','stack')
ranksum(fgr17,fgl17)

fgr20=squeeze(mean(mean(cond4n_dt_bl_right(roi_contour,48:53,:),1),2)-mean(mean(cond4n_dt_bl_right(roi_bg_in,48:53,:),1),2));
fgl20=squeeze(mean(mean(cond4n_dt_bl_left(roi_contour,48:53,:),1),2)-mean(mean(cond4n_dt_bl_left(roi_bg_in,48:53,:),1),2));
[n1 x1]=hist(fgr20,-.5e-3:0.0001:1e-3);
[n2 x2]=hist(fgl20,-.5e-3:0.0001:1e-3);
figure;bar(x1,[n2;n1]','stack')
ranksum(fgr20,fgl20)


fgr25=squeeze(mean(mean(cond4n_dt_bl_right(roi_contour,48:53,:),1),2)-mean(mean(cond4n_dt_bl_right(roi_bg_in,48:53,:),1),2));
fgl25=squeeze(mean(mean(cond4n_dt_bl_left(roi_contour,48:53,:),1),2)-mean(mean(cond4n_dt_bl_left(roi_bg_in,48:53,:),1),2));
[n1 x1]=hist(fgr25,-.5e-3:0.0001:1e-3);
[n2 x2]=hist(fgl25,-.5e-3:0.0001:1e-3);
figure;bar(x1,[n2;n1]','stack')
ranksum(fgr25,fgl25)

fgr=[fgr10;fgr15;fgr17;fgr20;fgr25];
fgl=[fgl10;fgl15;fgl17;fgl20;fgl25];
[n1 x1]=hist(fgr,-.5e-3:0.0001:1e-3);
[n2 x2]=hist(fgl,-.5e-3:0.0001:1e-3);
figure;bar(x1,[n1;n2]')
ranksum(fgr,fgl)



%% 1811

fgr5=squeeze(mean(mean(cond2n_dt_bl_right(roi_contour,43:53,:),1),2)-mean(mean(cond2n_dt_bl_right(roi_bg_in,43:53,:),1),2));
fgl5=squeeze(mean(mean(cond2n_dt_bl_left(roi_contour,43:53,:),1),2)-mean(mean(cond2n_dt_bl_left(roi_bg_in,43:53,:),1),2));
[n1 x1]=hist(fgr5,-.5e-3:0.0001:1e-3);
[n2 x2]=hist(fgl5,-.5e-3:0.0001:1e-3);
figure;bar(x1,[n2;n1]','stack')
ranksum(fgr5,fgl5)

fgr15=squeeze(mean(mean(cond4n_dt_bl_right(roi_contour,43:53,:),1),2)-mean(mean(cond4n_dt_bl_right(roi_bg_in,43:53,:),1),2));
fgl15=squeeze(mean(mean(cond4n_dt_bl_left(roi_contour,43:53,:),1),2)-mean(mean(cond4n_dt_bl_left(roi_bg_in,43:53,:),1),2));
[n1 x1]=hist(fgr15,-.5e-3:0.0001:1e-3);
[n2 x2]=hist(fgl15,-.5e-3:0.0001:1e-3);
figure;bar(x1,[n2;n1]','stack')
ranksum(fgr15,fgl15)

fgr10=squeeze(mean(mean(cond2n_dt_bl_right(roi_contour,43:53,:),1),2)-mean(mean(cond2n_dt_bl_right(roi_bg_in,43:53,:),1),2));
fgl10=squeeze(mean(mean(cond2n_dt_bl_left(roi_contour,43:53,:),1),2)-mean(mean(cond2n_dt_bl_left(roi_bg_in,43:53,:),1),2));
[n1 x1]=hist(fgr10,-.5e-3:0.0001:1e-3);
[n2 x2]=hist(fgl10,-.5e-3:0.0001:1e-3);
figure;bar(x1,[n2;n1]','stack')
ranksum(fgr10,fgl10)

fgr20=squeeze(mean(mean(cond4n_dt_bl_right(roi_contour,43:53,:),1),2)-mean(mean(cond4n_dt_bl_right(roi_bg_in,43:53,:),1),2));
fgl20=squeeze(mean(mean(cond4n_dt_bl_left(roi_contour,43:53,:),1),2)-mean(mean(cond4n_dt_bl_left(roi_bg_in,43:53,:),1),2));
[n1 x1]=hist(fgr20,-.5e-3:0.0001:1e-3);
[n2 x2]=hist(fgl20,-.5e-3:0.0001:1e-3);
figure;bar(x1,[n2;n1]','stack')
ranksum(fgr20,fgl20)


fgr17=squeeze(mean(mean(cond2n_dt_bl_right(roi_contour,43:53,:),1),2)-mean(mean(cond2n_dt_bl_right(roi_bg_in,43:53,:),1),2));
fgl17=squeeze(mean(mean(cond2n_dt_bl_left(roi_contour,43:53,:),1),2)-mean(mean(cond2n_dt_bl_left(roi_bg_in,43:53,:),1),2));
[n1 x1]=hist(fgr17,-.5e-3:0.0001:1e-3);
[n2 x2]=hist(fgl17,-.5e-3:0.0001:1e-3);
figure;bar(x1,[n2;n1]','stack')
ranksum(fgr17,fgl17)

fgr25=squeeze(mean(mean(cond4n_dt_bl_right(roi_contour,43:53,:),1),2)-mean(mean(cond4n_dt_bl_right(roi_bg_in,43:53,:),1),2));
fgl25=squeeze(mean(mean(cond4n_dt_bl_left(roi_contour,43:53,:),1),2)-mean(mean(cond4n_dt_bl_left(roi_bg_in,43:53,:),1),2));
[n1 x1]=hist(fgr25,-.5e-3:0.0001:1e-3);
[n2 x2]=hist(fgl25,-.5e-3:0.0001:1e-3);
figure;bar(x1,[n2;n1]','stack')
ranksum(fgr25,fgl25)

fgr=[fgr5;fgr10;fgr15;fgr17;fgr20;fgr25];
fgl=[fgl5;fgl10;fgl15;fgl17;fgl20;fgl25];
[n1 x1]=hist(fgr,-.5e-3:0.0001:1e-3);
[n2 x2]=hist(fgl,-.5e-3:0.0001:1e-3);
figure;bar(x1,[n1;n2]','stack')
ranksum(fgr,fgl)




%% 1203

fgr15=squeeze(mean(mean(cond2n_dt_bl_right(roi_contour,43:53,:),1),2)-mean(mean(cond2n_dt_bl_right(roi_bg_in,43:53,:),1),2));
fgl15=squeeze(mean(mean(cond2n_dt_bl_left(roi_contour,43:53,:),1),2)-mean(mean(cond2n_dt_bl_left(roi_bg_in,43:53,:),1),2));
[n1 x1]=hist(fgr15,-.5e-3:0.0001:1e-3);
[n2 x2]=hist(fgl15,-.5e-3:0.0001:1e-3);
figure;bar(x1,[n2;n1]','stack')
ranksum(fgr15,fgl15)

fgr20=squeeze(mean(mean(cond4n_dt_bl_right(roi_contour,43:53,:),1),2)-mean(mean(cond4n_dt_bl_right(roi_bg_in,43:53,:),1),2));
fgl20=squeeze(mean(mean(cond4n_dt_bl_left(roi_contour,43:53,:),1),2)-mean(mean(cond4n_dt_bl_left(roi_bg_in,43:53,:),1),2));
[n1 x1]=hist(fgr20,-.5e-3:0.0001:1e-3);
[n2 x2]=hist(fgl20,-.5e-3:0.0001:1e-3);
figure;bar(x1,[n2;n1]','stack')
ranksum(fgr20,fgl20)


fgr5=squeeze(mean(mean(cond2n_dt_bl_right(roi_contour,43:53,:),1),2)-mean(mean(cond2n_dt_bl_right(roi_bg_in,43:53,:),1),2));
fgl5=squeeze(mean(mean(cond2n_dt_bl_left(roi_contour,43:53,:),1),2)-mean(mean(cond2n_dt_bl_left(roi_bg_in,43:53,:),1),2));
[n1 x1]=hist(fgr5,-.5e-3:0.0001:1e-3);
[n2 x2]=hist(fgl5,-.5e-3:0.0001:1e-3);
figure;bar(x1,[n2;n1]','stack')
ranksum(fgr5,fgl5)

fgr10=squeeze(mean(mean(cond4n_dt_bl_right(roi_contour,43:53,:),1),2)-mean(mean(cond4n_dt_bl_right(roi_bg_in,43:53,:),1),2));
fgl10=squeeze(mean(mean(cond4n_dt_bl_left(roi_contour,43:53,:),1),2)-mean(mean(cond4n_dt_bl_left(roi_bg_in,43:53,:),1),2));
[n1 x1]=hist(fgr10,-.5e-3:0.0001:1e-3);
[n2 x2]=hist(fgl10,-.5e-3:0.0001:1e-3);
figure;bar(x1,[n2;n1]','stack')
ranksum(fgr10,fgl10)



fgr25=squeeze(mean(mean(cond2n_dt_bl_right(roi_contour,43:53,:),1),2)-mean(mean(cond2n_dt_bl_right(roi_bg_in,43:53,:),1),2));
fgl25=squeeze(mean(mean(cond2n_dt_bl_left(roi_contour,43:53,:),1),2)-mean(mean(cond2n_dt_bl_left(roi_bg_in,43:53,:),1),2));
[n1 x1]=hist(fgr25,-.5e-3:0.0001:1e-3);
[n2 x2]=hist(fgl25,-.5e-3:0.0001:1e-3);
figure;bar(x1,[n2;n1]','stack')
ranksum(fgr25,fgl25)

fgr30=squeeze(mean(mean(cond4n_dt_bl_right(roi_contour,43:53,:),1),2)-mean(mean(cond4n_dt_bl_right(roi_bg_in,43:53,:),1),2));
fgl30=squeeze(mean(mean(cond4n_dt_bl_left(roi_contour,43:53,:),1),2)-mean(mean(cond4n_dt_bl_left(roi_bg_in,43:53,:),1),2));
[n1 x1]=hist(fgr30,-.5e-3:0.0001:1e-3);
[n2 x2]=hist(fgl30,-.5e-3:0.0001:1e-3);
figure;bar(x1,[n2;n1]','stack')
ranksum(fgr30,fgl30)


fgr=[fgr10;fgr15;fgr20;fgr25;fgr30];
fgl=[fgl10;fgl15;fgl20;fgl25;fgl30];
[n1 x1]=hist(fgr,-.5e-3:0.0001:1e-3);
[n2 x2]=hist(fgl,-.5e-3:0.0001:1e-3);
figure;bar(x1,[n1;n2]','stack')
ranksum(fgr,fgl)



