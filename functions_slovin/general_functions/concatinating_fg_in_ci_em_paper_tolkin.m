%% 0812
%c
load myrois2
load cond1n_dt_bl_no_eyemove
circ_cont_0812c1=squeeze(nanmean(cond1n_dt_bl(roi_circle14,:,:),1));
bg_cont_0812c1=squeeze(nanmean(cond1n_dt_bl([roi_bg_in14;roi_bg_out14],:,:),1));
clear cond1n_dt_bl
load cond2n_dt_bl_no_eyemove
circ_cont_0812c2=squeeze(nanmean(cond2n_dt_bl(roi_circle25,:,:),1));
bg_cont_0812c2=squeeze(nanmean(cond2n_dt_bl([roi_bg_in25;roi_bg_out25],:,:),1));
clear cond2n_dt_bl
load cond4n_dt_bl_no_eyemove
circ_cont_0812c4=squeeze(nanmean(cond4n_dt_bl(roi_circle14,:,:),1));
bg_cont_0812c4=squeeze(nanmean(cond4n_dt_bl([roi_bg_in14;roi_bg_out14],:,:),1));
clear cond4n_dt_bl
load cond5n_dt_bl_no_eyemove
circ_cont_0812c5=squeeze(nanmean(cond5n_dt_bl(roi_circle25,:,:),1));
bg_cont_0812c5=squeeze(nanmean(cond5n_dt_bl([roi_bg_in25;roi_bg_out25],:,:),1));
clear cond5n_dt_bl

%e
load myrois2
load cond1n_dt_bl_no_eyemove
circ_cont_0812e1=squeeze(nanmean(cond1n_dt_bl(roi_circle14,:,:),1));
bg_cont_0812e1=squeeze(nanmean(cond1n_dt_bl([roi_bg_in14;roi_bg_out14],:,:),1));
clear cond1n_dt_bl
load cond2n_dt_bl_no_eyemove
circ_cont_0812e2=squeeze(nanmean(cond2n_dt_bl(roi_circle25,:,:),1));
bg_cont_0812e2=squeeze(nanmean(cond2n_dt_bl([roi_bg_in25;roi_bg_out25],:,:),1));
clear cond2n_dt_bl
load cond4n_dt_bl_no_eyemove
circ_cont_0812e4=squeeze(nanmean(cond4n_dt_bl(roi_circle14,:,:),1));
bg_cont_0812e4=squeeze(nanmean(cond4n_dt_bl([roi_bg_in14;roi_bg_out14],:,:),1));
clear cond4n_dt_bl
load cond5n_dt_bl_no_eyemove
circ_cont_0812e5=squeeze(nanmean(cond5n_dt_bl(roi_circle25,:,:),1));
bg_cont_0812e5=squeeze(nanmean(cond5n_dt_bl([roi_bg_in25;roi_bg_out25],:,:),1));
clear cond5n_dt_bl


%% 1512
%b
load myrois2
load cond1n_dt_bl_no_eyemove
circ_cont_1512b1=squeeze(nanmean(cond1n_dt_bl(roi_circle,:,:),1));
bg_cont_1512b1=squeeze(nanmean(cond1n_dt_bl(roi_bg_in,:,:),1));
clear cond1n_dt_bl
load cond2n_dt_bl_no_eyemove
circ_cont_1512b2=squeeze(nanmean(cond2n_dt_bl(roi_circle,:,:),1));
bg_cont_1512b2=squeeze(nanmean(cond2n_dt_bl(roi_bg_in,:,:),1));
clear cond2n_dt_bl
load cond4n_dt_bl_no_eyemove
circ_cont_1512b4=squeeze(nanmean(cond4n_dt_bl(roi_circle,:,:),1));
bg_cont_1512b4=squeeze(nanmean(cond4n_dt_bl(roi_bg_in,:,:),1));
clear cond4n_dt_bl
load cond5n_dt_bl_no_eyemove
circ_cont_1512b5=squeeze(nanmean(cond5n_dt_bl(roi_circle,:,:),1));
bg_cont_1512b5=squeeze(nanmean(cond5n_dt_bl(roi_bg_in,:,:),1));
clear cond5n_dt_bl

%c
load myrois2
load cond1n_dt_bl_no_eyemove
circ_cont_1512c1=squeeze(nanmean(cond1n_dt_bl(roi_circle,:,:),1));
bg_cont_1512c1=squeeze(nanmean(cond1n_dt_bl([roi_bg_in;roi_bg_out],:,:),1));
clear cond1n_dt_bl
load cond2n_dt_bl_no_eyemove
circ_cont_1512c2=squeeze(nanmean(cond2n_dt_bl(roi_circle,:,:),1));
bg_cont_1512c2=squeeze(nanmean(cond2n_dt_bl([roi_bg_in;roi_bg_out],:,:),1));
clear cond2n_dt_bl
load cond4n_dt_bl_no_eyemove
circ_cont_1512c4=squeeze(nanmean(cond4n_dt_bl(roi_circle,:,:),1));
bg_cont_1512c4=squeeze(nanmean(cond4n_dt_bl([roi_bg_in;roi_bg_out],:,:),1));
clear cond4n_dt_bl
load cond5n_dt_bl_no_eyemove
circ_cont_1512c5=squeeze(nanmean(cond5n_dt_bl(roi_circle,:,:),1));
bg_cont_1512c5=squeeze(nanmean(cond5n_dt_bl([roi_bg_in;roi_bg_out],:,:),1));
clear cond5n_dt_bl



%% 2812
%b
load myrois2
load cond1n_dt_bl_no_eyemove
circ_cont_2812b1=squeeze(nanmean(cond1n_dt_bl(roi_circle,:,:),1));
bg_cont_2812b1=squeeze(nanmean(cond1n_dt_bl([roi_bg_in;roi_bg_out],:,:),1));
clear cond1n_dt_bl
load cond2n_dt_bl_no_eyemove
circ_cont_2812b2=squeeze(nanmean(cond2n_dt_bl(roi_circle,:,:),1));
bg_cont_2812b2=squeeze(nanmean(cond2n_dt_bl([roi_bg_in;roi_bg_out],:,:),1));
clear cond2n_dt_bl
load cond4n_dt_bl_no_eyemove
circ_cont_2812b4=squeeze(nanmean(cond4n_dt_bl(roi_circle,:,:),1));
bg_cont_2812b4=squeeze(nanmean(cond4n_dt_bl([roi_bg_in;roi_bg_out],:,:),1));
clear cond4n_dt_bl
load cond5n_dt_bl_no_eyemove
circ_cont_2812b5=squeeze(nanmean(cond5n_dt_bl(roi_circle,:,:),1));
bg_cont_2812b5=squeeze(nanmean(cond5n_dt_bl([roi_bg_in;roi_bg_out],:,:),1));
clear cond5n_dt_bl

%c
load myrois2
load cond1n_dt_bl_no_eyemove
circ_cont_2812c1=squeeze(nanmean(cond1n_dt_bl(roi_circle,:,:),1));
bg_cont_2812c1=squeeze(nanmean(cond1n_dt_bl([roi_bg_in;roi_bg_out],:,:),1));
clear cond1n_dt_bl
load cond2n_dt_bl_no_eyemove
circ_cont_2812c2=squeeze(nanmean(cond2n_dt_bl(roi_circle,:,:),1));
bg_cont_2812c2=squeeze(nanmean(cond2n_dt_bl([roi_bg_in;roi_bg_out],:,:),1));
clear cond2n_dt_bl
load cond4n_dt_bl_no_eyemove
circ_cont_2812c4=squeeze(nanmean(cond4n_dt_bl(roi_circle,:,:),1));
bg_cont_2812c4=squeeze(nanmean(cond4n_dt_bl([roi_bg_in;roi_bg_out],:,:),1));
clear cond4n_dt_bl
load cond5n_dt_bl_no_eyemove
circ_cont_2812c5=squeeze(nanmean(cond5n_dt_bl(roi_circle,:,:),1));
bg_cont_2812c5=squeeze(nanmean(cond5n_dt_bl([roi_bg_in;roi_bg_out],:,:),1));
clear cond5n_dt_bl


%d
load myrois2
load cond1n_dt_bl_no_eyemove
circ_cont_2812d1=squeeze(nanmean(cond1n_dt_bl(roi_circle,:,:),1));
bg_cont_2812d1=squeeze(nanmean(cond1n_dt_bl([roi_bg_in;roi_bg_out],:,:),1));
clear cond1n_dt_bl
load cond2n_dt_bl_no_eyemove
circ_cont_2812d2=squeeze(nanmean(cond2n_dt_bl(roi_circle,:,:),1));
bg_cont_2812d2=squeeze(nanmean(cond2n_dt_bl([roi_bg_in;roi_bg_out],:,:),1));
clear cond2n_dt_bl
load cond4n_dt_bl_no_eyemove
circ_cont_2812d4=squeeze(nanmean(cond4n_dt_bl(roi_circle,:,:),1));
bg_cont_2812d4=squeeze(nanmean(cond4n_dt_bl([roi_bg_in;roi_bg_out],:,:),1));
clear cond4n_dt_bl
load cond5n_dt_bl_no_eyemove
circ_cont_2812d5=squeeze(nanmean(cond5n_dt_bl(roi_circle,:,:),1));
bg_cont_2812d5=squeeze(nanmean(cond5n_dt_bl([roi_bg_in;roi_bg_out],:,:),1));
clear cond5n_dt_bl




%%

circ_cont=cat(2,circ_cont_0812c1,circ_cont_0812c2,circ_cont_0812e1,circ_cont_0812e2,circ_cont_1512b1 ...
    ,circ_cont_1512b2,circ_cont_1512c1,circ_cont_1512c2,circ_cont_2812b1,circ_cont_2812c1,circ_cont_2812d1);

circ_non=cat(2,circ_cont_0812c4,circ_cont_0812c5,circ_cont_0812e4,circ_cont_0812e5,circ_cont_1512b4 ...
    ,circ_cont_1512b5,circ_cont_1512c4,circ_cont_1512c5,circ_cont_2812b5,circ_cont_2812c5,circ_cont_2812d5);

bg_cont=cat(2,bg_cont_0812c1,bg_cont_0812c2,bg_cont_0812e1,bg_cont_0812e2,bg_cont_1512b1 ...
    ,bg_cont_1512b2,bg_cont_1512c1,bg_cont_1512c2,bg_cont_2812b1,bg_cont_2812c1,bg_cont_2812d1);

bg_non=cat(2,bg_cont_0812c4,bg_cont_0812c5,bg_cont_0812e4,bg_cont_0812e5,bg_cont_1512b4 ...
    ,bg_cont_1512b5,bg_cont_1512c4,bg_cont_1512c5,bg_cont_2812b5,bg_cont_2812c5,bg_cont_2812d5);

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
xlim([-100 500])
plot(x(18:138),zeros(size(x(18:138),2),1),'k')













