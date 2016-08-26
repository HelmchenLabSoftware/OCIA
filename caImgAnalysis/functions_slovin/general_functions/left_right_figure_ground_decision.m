
lr=mean(cond2n_dt_bl_right,3)-mean(cond2n_dt_bl_left,3);
fg_lr_1811c2=mean(lr(roi_contour,:),1)-mean(lr(roi_bg_in,:),1);

lr=mean(cond4n_dt_bl_right,3)-mean(cond4n_dt_bl_left,3);
fg_lr_1811c4=mean(lr(roi_contour,:),1)-mean(lr(roi_bg_in,:),1);

figure;plot(fg_lr_1811c2)
hold on
plot(fg_lr_1811c4,'r')
xlim([20 68])



lr=mean(cond2n_dt_bl_right,3)-mean(cond2n_dt_bl_left,3);
fg_lr_2511d2=mean(lr(roi_contour,:),1)-mean(lr(roi_bg_in,:),1);

lr=mean(cond4n_dt_bl_right,3)-mean(cond4n_dt_bl_left,3);
fg_lr_2511d4=mean(lr(roi_contour,:),1)-mean(lr(roi_bg_in,:),1);

figure;plot(fg_lr_2511d2)
hold on
plot(fg_lr_2511d4,'r')
xlim([20 68])



lr=mean(cond2n_dt_bl_right,3)-mean(cond2n_dt_bl_left,3);
fg_lr_2511e2=mean(lr(roi_contour,:),1)-mean(lr(roi_bg_in,:),1);

lr=mean(cond4n_dt_bl_right,3)-mean(cond4n_dt_bl_left,3);
fg_lr_2511e4=mean(lr(roi_contour,:),1)-mean(lr(roi_bg_in,:),1);

figure;plot(fg_lr_2511e2)
hold on
plot(fg_lr_2511e4,'r')
xlim([20 68])


lr=mean(cond4n_dt_bl_right,3)-mean(cond4n_dt_bl_left,3);
fg_lr_2511f4=mean(lr(roi_contour,:),1)-mean(lr(roi_bg_in,:),1);

figure;plot(fg_lr_2511f4)
hold on
xlim([20 68])




lr=mean(cond2n_dt_bl_right,3)-mean(cond2n_dt_bl_left,3);
fg_lr_1203d2=mean(lr(roi_contour,:),1)-mean(lr(roi_bg_in,:),1);

lr=mean(cond4n_dt_bl_right,3)-mean(cond4n_dt_bl_left,3);
fg_lr_1203d4=mean(lr(roi_contour,:),1)-mean(lr(roi_bg_in,:),1);

figure;plot(fg_lr_1203d2)
hold on
plot(fg_lr_1203d4,'r')
xlim([20 68])



lr=mean(cond4n_dt_bl_right,3)-mean(cond4n_dt_bl_left,3);
fg_lr_1203e4=mean(lr(roi_contour,:),1)-mean(lr(roi_bg_in,:),1);

figure;plot(fg_lr_1203e4)
hold on
xlim([20 68])



lr=mean(cond2n_dt_bl_right,3)-mean(cond2n_dt_bl_left,3);
fg_lr_1203f2=mean(lr(roi_contour,:),1)-mean(lr(roi_bg_in,:),1);

lr=mean(cond4n_dt_bl_right,3)-mean(cond4n_dt_bl_left,3);
fg_lr_1203f4=mean(lr(roi_contour,:),1)-mean(lr(roi_bg_in,:),1);

figure;plot(fg_lr_1203f2)
hold on
plot(fg_lr_1203f4,'r')
xlim([20 68])





fg_lr=cat(1,fg_lr_1811c2,fg_lr_1811c4,fg_lr_2511d2,fg_lr_2511d4 ...
    ,fg_lr_2511e2,fg_lr_2511e4,fg_lr_2511f4,fg_lr_1203d2,fg_lr_1203d4, ...
    fg_lr_1203e4,fg_lr_1203f2,fg_lr_1203f4)';


fg_lr_nor=fg_lr./repmat(mean(fg_lr(20:27,:),1),256,1);
figure;errorbar(mean(fg_lr_nor,2),std(fg_lr_nor,0,2)/sqrt(size(fg_lr_nor,2)))
hold on
xlim([20 68])
plot(zeros(1,256),'k')

fg_lr=cat(1,fg_lr_1811c4,fg_lr_2511d4,fg_lr_1203d2)';







lr1=mean(cond2n_dt_bl_right,3)-mean(cond2n_dt_bl_left,3);
fg_lr_0501c2=mean(lr(roi_circle,:),1)-mean(lr(roi_bg_out,:),1);

lr2=mean(cond4n_dt_bl_right,3)-mean(cond4n_dt_bl_left,3);
fg_lr_0501c4=mean(lr(roi_circle,:),1)-mean(lr(roi_bg_out,:),1);

figure;plot(fg_lr_0501c2)
hold on
plot(fg_lr_0501c4,'r')
xlim([20 68])


lr3=mean(cond2n_dt_bl_right,3)-mean(cond2n_dt_bl_left,3);
fg_lr_0501d2=mean(lr(roi_circle,:),1)-mean(lr(roi_bg_out,:),1);

lr4=mean(cond4n_dt_bl_right,3)-mean(cond4n_dt_bl_left,3);
fg_lr_0501d4=mean(lr(roi_circle,:),1)-mean(lr(roi_bg_out,:),1);

figure;plot(fg_lr_0501d2)
hold on
plot(fg_lr_0501d4,'r')
xlim([20 68])




lr=mean(cond2n_dt_bl_right,3)-mean(cond2n_dt_bl_left,3);
fg_lr_2212c2=mean(lr(roi_circle,:),1)-mean(lr(roi_bg_in,:),1);

lr=mean(cond4n_dt_bl_right,3)-mean(cond4n_dt_bl_left,3);
fg_lr_2212c4=mean(lr(roi_circle,:),1)-mean(lr(roi_bg_in,:),1);

figure;plot(fg_lr_2212c2)
hold on
plot(fg_lr_2212c4,'r')
xlim([20 68])




lr=mean(cond2n_dt_bl_right,3)-mean(cond2n_dt_bl_left,3);
fg_lr_2212d2=mean(lr(roi_circle,:),1)-mean(lr(roi_bg_in,:),1);

lr=mean(cond4n_dt_bl_right,3)-mean(cond4n_dt_bl_left,3);
fg_lr_2212d4=mean(lr(roi_circle,:),1)-mean(lr(roi_bg_in,:),1);

figure;plot(fg_lr_2212d2)
hold on
plot(fg_lr_2212d4,'r')
xlim([20 68])



fg_lr=cat(1,fg_lr_0501c2,fg_lr_0501c4,fg_lr_0501d2,fg_lr_0501d4 ...
    ,fg_lr_2212c2,fg_lr_2212c4,fg_lr_2212d2,fg_lr_2212d4)';

x=(10:10:2560)-280;
figure;errorbar(x,mean(fg_lr,2),std(fg_lr,0,2)/sqrt(size(fg_lr,2)))
hold on
xlim([-100 300])
plot(zeros(1,256),'k')




