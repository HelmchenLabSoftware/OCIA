
%% 1111
%c
load myrois
load cond1n_dt_bl_no_eyemove
circ_cont_1111c1=squeeze(nanmean(cond1n_dt_bl(roi_contour2,:,:),1));
bg_cont_1111c1=squeeze(nanmean(cond1n_dt_bl(roi_maskin,:,:),1));
clear cond1n_dt_bl
load cond2n_dt_bl_no_eyemove
circ_cont_1111c2=squeeze(nanmean(cond2n_dt_bl(roi_contour2,:,:),1));
bg_cont_1111c2=squeeze(nanmean(cond2n_dt_bl(roi_maskin,:,:),1));
clear cond2n_dt_bl
load cond4n_dt_bl_no_eyemove
circ_cont_1111c4=squeeze(nanmean(cond4n_dt_bl(roi_contour2,:,:),1));
bg_cont_1111c4=squeeze(nanmean(cond4n_dt_bl(roi_maskin,:,:),1));
clear cond4n_dt_bl
load cond5n_dt_bl_no_eyemove
circ_cont_1111c5=squeeze(nanmean(cond5n_dt_bl(roi_contour2,:,:),1));
bg_cont_1111c5=squeeze(nanmean(cond5n_dt_bl(roi_maskin,:,:),1));
clear cond5n_dt_bl

%d
load myrois
load cond1n_dt_bl_no_eyemove
circ_cont_1111d1=squeeze(nanmean(cond1n_dt_bl(roi_contour2,:,:),1));
bg_cont_1111d1=squeeze(nanmean(cond1n_dt_bl(roi_maskin,:,:),1));
clear cond1n_dt_bl
load cond2n_dt_bl_no_eyemove
circ_cont_1111d2=squeeze(nanmean(cond2n_dt_bl(roi_contour2,:,:),1));
bg_cont_1111d2=squeeze(nanmean(cond2n_dt_bl(roi_maskin,:,:),1));
clear cond2n_dt_bl
load cond4n_dt_bl_no_eyemove
circ_cont_1111d4=squeeze(nanmean(cond4n_dt_bl(roi_contour2,:,:),1));
bg_cont_1111d4=squeeze(nanmean(cond4n_dt_bl(roi_maskin,:,:),1));
clear cond4n_dt_bl
load cond5n_dt_bl_no_eyemove
circ_cont_1111d5=squeeze(nanmean(cond5n_dt_bl(roi_contour2,:,:),1));
bg_cont_1111d5=squeeze(nanmean(cond5n_dt_bl(roi_maskin,:,:),1));
clear cond5n_dt_bl

%h
load myrois
load cond1n_dt_bl_no_eyemove
circ_cont_1111h1=squeeze(nanmean(cond1n_dt_bl(roi_contour,:,:),1));
bg_cont_1111h1=squeeze(nanmean(cond1n_dt_bl(roi_maskin,:,:),1));
clear cond1n_dt_bl
load cond2n_dt_bl_no_eyemove
circ_cont_1111h2=squeeze(nanmean(cond2n_dt_bl(roi_contour,:,:),1));
bg_cont_1111h2=squeeze(nanmean(cond2n_dt_bl(roi_maskin,:,:),1));
clear cond2n_dt_bl
load cond4n_dt_bl_no_eyemove
circ_cont_1111h4=squeeze(nanmean(cond4n_dt_bl(roi_contour,:,:),1));
bg_cont_1111h4=squeeze(nanmean(cond4n_dt_bl(roi_maskin,:,:),1));
clear cond4n_dt_bl
load cond5n_dt_bl_no_eyemove
circ_cont_1111h5=squeeze(nanmean(cond5n_dt_bl(roi_contour,:,:),1));
bg_cont_1111h5=squeeze(nanmean(cond5n_dt_bl(roi_maskin,:,:),1));
clear cond5n_dt_bl

%% 1811
%c
load myrois
load cond1n_dt_bl_no_eyemove
circ_cont_1811c1=squeeze(nanmean(cond1n_dt_bl(roi_contour,:,:),1));
bg_cont_1811c1=squeeze(nanmean(cond1n_dt_bl(roi_bg_in,:,:),1));
clear cond1n_dt_bl
load cond5n_dt_bl_no_eyemove
circ_cont_1811c5=squeeze(nanmean(cond5n_dt_bl(roi_contour,:,:),1));
bg_cont_1811c5=squeeze(nanmean(cond5n_dt_bl(roi_bg_in,:,:),1));
clear cond5n_dt_bl

%d
load myrois
load cond1n_dt_bl_no_eyemove
circ_cont_1811d1=squeeze(nanmean(cond1n_dt_bl(roi_contour,:,:),1));
bg_cont_1811d1=squeeze(nanmean(cond1n_dt_bl(roi_bg_in,:,:),1));
clear cond1n_dt_bl
load cond5n_dt_bl_no_eyemove
circ_cont_1811d5=squeeze(nanmean(cond5n_dt_bl(roi_contour,:,:),1));
bg_cont_1811d5=squeeze(nanmean(cond5n_dt_bl(roi_bg_in,:,:),1));
clear cond5n_dt_bl


%e
load myrois
load cond1n_dt_bl_no_eyemove
circ_cont_1811e1=squeeze(nanmean(cond1n_dt_bl(roi_contour,:,:),1));
bg_cont_1811e1=squeeze(nanmean(cond1n_dt_bl(roi_bg_in,:,:),1));
clear cond1n_dt_bl
load cond5n_dt_bl_no_eyemove
circ_cont_1811e5=squeeze(nanmean(cond5n_dt_bl(roi_contour,:,:),1));
bg_cont_1811e5=squeeze(nanmean(cond5n_dt_bl(roi_bg_in,:,:),1));
clear cond5n_dt_bl


%% 2511
%d
load myrois
load cond1n_dt_bl_no_eyemove
circ_cont_2511d1=squeeze(nanmean(cond1n_dt_bl(roi_contour,:,:),1));
bg_cont_2511d1=squeeze(nanmean(cond1n_dt_bl(roi_bg_in,:,:),1));
clear cond1n_dt_bl
load cond5n_dt_bl_no_eyemove
circ_cont_2511d5=squeeze(nanmean(cond5n_dt_bl(roi_contour,:,:),1));
bg_cont_2511d5=squeeze(nanmean(cond5n_dt_bl(roi_bg_in,:,:),1));
clear cond5n_dt_bl

%e
load myrois
load cond1n_dt_bl_no_eyemove
circ_cont_2511e1=squeeze(nanmean(cond1n_dt_bl(roi_contour,:,:),1));
bg_cont_2511e1=squeeze(nanmean(cond1n_dt_bl(roi_bg_in,:,:),1));
clear cond1n_dt_bl
load cond5n_dt_bl_no_eyemove
circ_cont_2511e5=squeeze(nanmean(cond5n_dt_bl(roi_contour,:,:),1));
bg_cont_2511e5=squeeze(nanmean(cond5n_dt_bl(roi_bg_in,:,:),1));
clear cond5n_dt_bl

%f
load myrois
load cond1n_dt_bl_no_eyemove
circ_cont_2511f1=squeeze(nanmean(cond1n_dt_bl(roi_contour,:,:),1));
bg_cont_2511f1=squeeze(nanmean(cond1n_dt_bl(roi_bg_in,:,:),1));
clear cond1n_dt_bl
load cond5n_dt_bl_no_eyemove
circ_cont_2511f5=squeeze(nanmean(cond5n_dt_bl(roi_contour,:,:),1));
bg_cont_2511f5=squeeze(nanmean(cond5n_dt_bl(roi_bg_in,:,:),1));
clear cond5n_dt_bl



%% 1203
%d
load myrois
load cond1n_dt_bl_no_eyemove
circ_cont_1203d1=squeeze(nanmean(cond1n_dt_bl(roi_contour,:,:),1));
bg_cont_1203d1=squeeze(nanmean(cond1n_dt_bl(roi_bg_in,:,:),1));
clear cond1n_dt_bl
load cond5n_dt_bl_no_eyemove
circ_cont_1203d5=squeeze(nanmean(cond5n_dt_bl(roi_contour,:,:),1));
bg_cont_1203d5=squeeze(nanmean(cond5n_dt_bl(roi_bg_in,:,:),1));
clear cond5n_dt_bl

%e
load myrois
load cond1n_dt_bl_no_eyemove
circ_cont_1203e1=squeeze(nanmean(cond1n_dt_bl(roi_contour,:,:),1));
bg_cont_1203e1=squeeze(nanmean(cond1n_dt_bl(roi_bg_in,:,:),1));
clear cond1n_dt_bl
load cond5n_dt_bl_no_eyemove
circ_cont_1203e5=squeeze(nanmean(cond5n_dt_bl(roi_contour,:,:),1));
bg_cont_1203e5=squeeze(nanmean(cond5n_dt_bl(roi_bg_in,:,:),1));
clear cond5n_dt_bl


%f
load myrois
load cond1n_dt_bl_no_eyemove
circ_cont_1203f1=squeeze(nanmean(cond1n_dt_bl(roi_contour,:,:),1));
bg_cont_1203f1=squeeze(nanmean(cond1n_dt_bl(roi_bg_in,:,:),1));
clear cond1n_dt_bl
load cond5n_dt_bl_no_eyemove
circ_cont_1203f5=squeeze(nanmean(cond5n_dt_bl(roi_contour,:,:),1));
bg_cont_1203f5=squeeze(nanmean(cond5n_dt_bl(roi_bg_in,:,:),1));
clear cond5n_dt_bl


%%

circ_cont=cat(2,circ_cont_1111c1,circ_cont_1111c2,circ_cont_1111d1,circ_cont_1111d2,circ_cont_1111h1,circ_cont_1111h2 ...
    ,circ_cont_1811c1,circ_cont_1811d1,circ_cont_1811e1,circ_cont_2511d1,circ_cont_2511e1,circ_cont_2511f1 ...
    ,circ_cont_1203d1,circ_cont_1203e1,circ_cont_1203f1);

circ_non=cat(2,circ_cont_1111c4,circ_cont_1111c5,circ_cont_1111d4,circ_cont_1111d5,circ_cont_1111h4,circ_cont_1111h5 ...
    ,circ_cont_1811c5,circ_cont_1811d5,circ_cont_1811e5,circ_cont_2511d5,circ_cont_2511e5,circ_cont_2511f5 ...
    ,circ_cont_1203d5,circ_cont_1203e5,circ_cont_1203f5);


bg_cont=cat(2,bg_cont_1111c1,bg_cont_1111c2,bg_cont_1111d1,bg_cont_1111d2,bg_cont_1111h1,bg_cont_1111h2 ...
    ,bg_cont_1811c1,bg_cont_1811d1,bg_cont_1811e1,bg_cont_2511d1,bg_cont_2511e1,bg_cont_2511f1 ...
    ,bg_cont_1203d1,bg_cont_1203e1,bg_cont_1203f1);

bg_non=cat(2,bg_cont_1111c4,bg_cont_1111c5,bg_cont_1111d4,bg_cont_1111d5,bg_cont_1111h4,bg_cont_1111h5 ...
    ,bg_cont_1811c5,bg_cont_1811d5,bg_cont_1811e5,bg_cont_2511d5,bg_cont_2511e5,bg_cont_2511f5 ...
    ,bg_cont_1203d5,bg_cont_1203e5,bg_cont_1203f5);


for i=1:256
    n1(i)=sum(~isnan(circ_cont(i,:)));
    n2(i)=sum(~isnan(circ_non(i,:)));
end

x=(10:10:2560)-280;
figure;errorbar(x(2:112),nanmean(circ_cont(2:112,:),2),nanstd(circ_cont(2:112,:),0,2)./sqrt(n1(2:112)'))
hold on
errorbar(x(2:112),nanmean(bg_cont(2:112,:),2),nanstd(bg_cont(2:112,:),0,2)./sqrt(n1(2:112)'),'r')


x=(10:10:2560)-280;
figure;errorbar(x(2:112),nanmean(circ_non(2:112,:),2),nanstd(circ_non(2:112,:),0,2)./sqrt(n2(2:112)'))
hold on
errorbar(x(2:112),nanmean(bg_non(2:112,:),2),nanstd(bg_non(2:112,:),0,2)./sqrt(n2(2:112)'),'r')


fg_cont=circ_cont-bg_cont;
fg_non=circ_non-bg_non;
x=(10:10:2560)-280;
figure;errorbar(x(18:138),nanmean(fg_cont(18:138,:),2),nanstd(fg_cont(18:138,:),0,2)./sqrt(n1(18:138)'))
hold on
errorbar(x(18:138),nanmean(fg_non(18:138,:),2),nanstd(fg_non(18:138,:),0,2)./sqrt(n2(18:138)'),'r')
xlim([-100 400])
plot(x(18:138),zeros(size(x(18:138),2),1),'k')














