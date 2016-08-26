

figure;plot(squeeze(mean(mean(cond1n_dt_bl(roi_V2,2:112,:),3),1)),'r')

figure;plot(squeeze(mean(mean(cond1n_dt_bl(roi_maskin,2:112,:),3),1)),'g')
hold on
plot(squeeze(mean(mean(cond4n_dt_bl(roi_maskin,2:112,:),3),1)),'g','Linestyle','--')



figure;plot(squeeze(mean(mean(cond2n_dt_bl(roi_maskin,2:112,:),3),1)),'g')
hold on
plot(squeeze(mean(mean(cond5n_dt_bl(roi_maskin,2:112,:),3),1)),'g','Linestyle','--')


x=(20:10:1120)-280;
figure;plot(x,squeeze(mean(mean(cond1n_dt_bl(roi_V2,2:112,:),3),1))-1,'r')
hold on
plot(x,squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,2:112,:),3),1))-1,'g')
plot(x,squeeze(mean(mean(cond1n_dt_bl(roi_contour,2:112,:),3),1))-1,'b')
plot(x,squeeze(mean(mean(cond5n_dt_bl(roi_V2,2:112,:),3),1))-1,'r','Linestyle','--')
plot(x,squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,2:112,:),3),1))-1,'g','Linestyle','--')
plot(x,squeeze(mean(mean(cond5n_dt_bl(roi_contour,2:112,:),3),1))-1,'b','Linestyle','--')
xlim([-100 350])

x=(20:10:1120)-280;
for i=1:32
    figure;plot(x,squeeze(mean(cond2n_dt_bl(roi_V2,2:112,i),1))-1,'r')
    hold on
    plot(x,squeeze(mean(cond2n_dt_bl(roi_maskin,2:112,i),1))-1,'g')
    plot(x,squeeze(mean(cond2n_dt_bl(roi_contour2,2:112,i),1))-1,'b')
    xlim([-100 350])
end

figure;plot(x(44:48),squeeze(mean(mean(cond2n_dt_bl(roi_V2,44:48,:)/1),3))-1)
hold on
plot(x(44:48),squeeze(mean(mean(cond5n_dt_bl(roi_V2,44:48,:),1),3))-1,'r')



figure;plot(x,squeeze(mean(mean(cond1n_dt_bl(roi_V2,2:112,:),3),1))-squeeze(mean(mean(cond5n_dt_bl(roi_V2,2:112,:),3),1)),'r')
hold on
plot(x,squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,2:112,:),3),1))-squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,2:112,:),3),1)),'g')
plot(x,squeeze(mean(mean(cond1n_dt_bl(roi_contour,2:112,:),3),1))-squeeze(mean(mean(cond5n_dt_bl(roi_contour,2:112,:),3),1)),'b')
xlim([-100 350])


x=(20:10:1120)-280;
figure;errorbar(x,squeeze(mean(mean(cond1n_dt_bl(roi_V2,2:112,:)-1,3),1)),(squeeze(mean(std(cond1n_dt_bl(roi_V2,2:112,:)-1,0,1),3)))/sqrt(149),'r')
hold on
errorbar(x,squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,2:112,:)-1,1),3)),(squeeze(mean(std(cond1n_dt_bl(roi_bg_in,2:112,:)-1,0,1),3)))/sqrt(614),'g')
errorbar(x,squeeze(mean(mean(cond1n_dt_bl(roi_contour,2:112,:)-1,1),3)),(squeeze(mean(std(cond1n_dt_bl(roi_contour,2:112,:)-1,0,1),3)))/sqrt(733),'b')
errorbar(x,squeeze(mean(mean(cond5n_dt_bl(roi_V2,2:112,:)-1,1),3)),(squeeze(mean(std(cond5n_dt_bl(roi_V2,2:112,:)-1,0,1),3)))/sqrt(149),'r','Linestyle','--')
errorbar(x,squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,2:112,:)-1,1),3)),(squeeze(mean(std(cond5n_dt_bl(roi_bg_in,2:112,:)-1,0,1),3)))/sqrt(614),'g','Linestyle','--')
errorbar(x,squeeze(mean(mean(cond5n_dt_bl(roi_contour,2:112,:)-1,1),3)),(squeeze(mean(std(cond5n_dt_bl(roi_contour,2:112,:)-1,0,1),3)))/sqrt(733),'b','Linestyle','--')
xlim([-100 350])
%
x=(20:10:1120)-280;
figure;
h=errorbar(x,squeeze(mean(mean(cond1n_dt_bl(roi_V2,2:112,:)-1,3),1)),(squeeze(mean(std(cond1n_dt_bl(roi_V2,2:112,:)-1,0,1),3)))/sqrt(149),'r');
ll=15;
hb = get(h,'children');
Xdata = get(hb(2),'Xdata');
temp = 4:3:length(Xdata);
temp(3:3:end) = [];
xleft = temp; xright = temp+1;  %xleft and xright contain the indices of the left and right endpoints of the horizontal lines
Xdata(xleft) = Xdata(xleft) + ll; % Decrease line length of the errorbar by 0.2 units
Xdata(xright) = Xdata(xright) - ll;
set(hb(2),'Xdata',Xdata)

hold on
h=errorbar(x,squeeze(mean(mean(cond1n_dt_bl(roi_bg_in,2:112,:)-1,1),3)),(squeeze(mean(std(cond1n_dt_bl(roi_bg_in,2:112,:)-1,0,1),3)))/sqrt(614),'g');
ll=15;
hb = get(h,'children');
Xdata = get(hb(2),'Xdata');
temp = 4:3:length(Xdata);
temp(3:3:end) = [];
xleft = temp; xright = temp+1;  %xleft and xright contain the indices of the left and right endpoints of the horizontal lines
Xdata(xleft) = Xdata(xleft) + ll; % Decrease line length of the errorbar by 0.2 units
Xdata(xright) = Xdata(xright) - ll;
set(hb(2),'Xdata',Xdata)

h=errorbar(x,squeeze(mean(mean(cond1n_dt_bl(roi_contour,2:112,:)-1,1),3)),(squeeze(mean(std(cond1n_dt_bl(roi_contour,2:112,:)-1,0,1),3)))/sqrt(733),'b');
ll=15;
hb = get(h,'children');
Xdata = get(hb(2),'Xdata');
temp = 4:3:length(Xdata);
temp(3:3:end) = [];
xleft = temp; xright = temp+1;  %xleft and xright contain the indices of the left and right endpoints of the horizontal lines
Xdata(xleft) = Xdata(xleft) + ll; % Decrease line length of the errorbar by 0.2 units
Xdata(xright) = Xdata(xright) - ll;
set(hb(2),'Xdata',Xdata)

h=errorbar(x,squeeze(mean(mean(cond5n_dt_bl(roi_V2,2:112,:)-1,1),3)),(squeeze(mean(std(cond5n_dt_bl(roi_V2,2:112,:)-1,0,1),3)))/sqrt(149),'r','Linestyle','--');
ll=15;
hb = get(h,'children');
Xdata = get(hb(2),'Xdata');
temp = 4:3:length(Xdata);
temp(3:3:end) = [];
xleft = temp; xright = temp+1;  %xleft and xright contain the indices of the left and right endpoints of the horizontal lines
Xdata(xleft) = Xdata(xleft) + ll; % Decrease line length of the errorbar by 0.2 units
Xdata(xright) = Xdata(xright) - ll;
set(hb(2),'Xdata',Xdata)

h=errorbar(x,squeeze(mean(mean(cond5n_dt_bl(roi_bg_in,2:112,:)-1,1),3)),(squeeze(mean(std(cond5n_dt_bl(roi_bg_in,2:112,:)-1,0,1),3)))/sqrt(614),'g','Linestyle','--');
ll=15;
hb = get(h,'children');
Xdata = get(hb(2),'Xdata');
temp = 4:3:length(Xdata);
temp(3:3:end) = [];
xleft = temp; xright = temp+1;  %xleft and xright contain the indices of the left and right endpoints of the horizontal lines
Xdata(xleft) = Xdata(xleft) + ll; % Decrease line length of the errorbar by 0.2 units
Xdata(xright) = Xdata(xright) - ll;
set(hb(2),'Xdata',Xdata)

h=errorbar(x,squeeze(mean(mean(cond5n_dt_bl(roi_contour,2:112,:)-1,1),3)),(squeeze(mean(std(cond5n_dt_bl(roi_contour,2:112,:)-1,0,1),3)))/sqrt(733),'b','Linestyle','--');
ll=15;
hb = get(h,'children');
Xdata = get(hb(2),'Xdata');
temp = 4:3:length(Xdata);
temp(3:3:end) = [];
xleft = temp; xright = temp+1;  %xleft and xright contain the indices of the left and right endpoints of the horizontal lines
Xdata(xleft) = Xdata(xleft) + ll; % Decrease line length of the errorbar by 0.2 units
Xdata(xright) = Xdata(xright) - ll;
set(hb(2),'Xdata',Xdata)

xlim([-100 350])


%
x=(20:10:1120)-280;
figure;plot(x,squeeze(mean(mean(cond1n_dt_bl(roi_V2,2:112,:),3),1))-1,'r')
hold on
plot(x,squeeze(mean(mean(cond1n_dt_bl(roi_maskin,2:112,:),3),1))-1,'g')
plot(x,squeeze(mean(mean(cond1n_dt_bl(roi_contour,2:112,:),3),1))-1,'b')
plot(x,squeeze(mean(mean(cond4n_dt_bl(roi_V2,2:112,:),3),1))-1,'r','Linestyle','--')
plot(x,squeeze(mean(mean(cond4n_dt_bl(roi_maskin,2:112,:),3),1))-1,'g','Linestyle','--')
plot(x,squeeze(mean(mean(cond4n_dt_bl(roi_contour,2:112,:),3),1))-1,'b','Linestyle','--')
xlim([-100 350])


%% triggering on the background supression

bg_sup=[38 38 39 39 40 40 41 50 44 47 38 39 44]-1;
%bg_sup=ones(1,13)*44;

cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/11_11_2008/c/elhanan_new
load myrois
load cond1n_dt_bl
load cond4n_dt_bl
bg_trig_V2_cont(:,1)=squeeze(mean(mean(cond1n_dt_bl(roi_V2,bg_sup(1)-25:bg_sup(1)+25,:),3),1));
bg_trig_circ_cont(:,1)=squeeze(mean(mean(cond1n_dt_bl(roi_contour2,bg_sup(1)-25:bg_sup(1)+25,:),3),1));
bg_trig_V2_non(:,1)=squeeze(mean(mean(cond4n_dt_bl(roi_V2,bg_sup(1)-25:bg_sup(1)+25,:),3),1));
bg_trig_circ_non(:,1)=squeeze(mean(mean(cond4n_dt_bl(roi_contour2,bg_sup(1)-25:bg_sup(1)+25,:),3),1));
clear cond1n_dt_bl
clear cond4n_dt_bl
load cond2n_dt_bl
load cond5n_dt_bl
bg_trig_V2_cont(:,2)=squeeze(mean(mean(cond2n_dt_bl(roi_V2,bg_sup(2)-25:bg_sup(2)+25,:),3),1));
bg_trig_circ_cont(:,2)=squeeze(mean(mean(cond2n_dt_bl(roi_contour2,bg_sup(2)-25:bg_sup(2)+25,:),3),1));
bg_trig_V2_non(:,2)=squeeze(mean(mean(cond5n_dt_bl(roi_V2,bg_sup(2)-25:bg_sup(2)+25,:),3),1));
bg_trig_circ_non(:,2)=squeeze(mean(mean(cond5n_dt_bl(roi_contour2,bg_sup(2)-25:bg_sup(2)+25,:),3),1));
clear cond2n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/11_11_2008/d/elhanan_new
load cond1n_dt_bl
load cond4n_dt_bl
bg_trig_V2_cont(:,3)=squeeze(mean(mean(cond1n_dt_bl(roi_V2,bg_sup(3)-25:bg_sup(3)+25,:),3),1));
bg_trig_circ_cont(:,3)=squeeze(mean(mean(cond1n_dt_bl(roi_contour2,bg_sup(3)-25:bg_sup(3)+25,:),3),1));
bg_trig_V2_non(:,3)=squeeze(mean(mean(cond4n_dt_bl(roi_V2,bg_sup(3)-25:bg_sup(3)+25,:),3),1));
bg_trig_circ_non(:,3)=squeeze(mean(mean(cond4n_dt_bl(roi_contour2,bg_sup(3)-25:bg_sup(3)+25,:),3),1));
clear cond1n_dt_bl
clear cond4n_dt_bl
load cond2n_dt_bl
load cond5n_dt_bl
bg_trig_V2_cont(:,4)=squeeze(mean(mean(cond2n_dt_bl(roi_V2,bg_sup(4)-25:bg_sup(4)+25,:),3),1));
bg_trig_circ_cont(:,4)=squeeze(mean(mean(cond2n_dt_bl(roi_contour2,bg_sup(4)-25:bg_sup(4)+25,:),3),1));
bg_trig_V2_non(:,4)=squeeze(mean(mean(cond5n_dt_bl(roi_V2,bg_sup(4)-25:bg_sup(4)+25,:),3),1));
bg_trig_circ_non(:,4)=squeeze(mean(mean(cond5n_dt_bl(roi_contour2,bg_sup(4)-25:bg_sup(4)+25,:),3),1));
clear cond2n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/c
load myrois
load cond1n_dt_bl
load cond5n_dt_bl
bg_trig_V2_cont(:,5)=squeeze(mean(mean(cond1n_dt_bl(roi_V2,bg_sup(5)-25:bg_sup(5)+25,:),3),1));
bg_trig_circ_cont(:,5)=squeeze(mean(mean(cond1n_dt_bl(roi_contour,bg_sup(5)-25:bg_sup(5)+25,:),3),1));
bg_trig_V2_non(:,5)=squeeze(mean(mean(cond5n_dt_bl(roi_V2,bg_sup(5)-25:bg_sup(5)+25,:),3),1));
bg_trig_circ_non(:,5)=squeeze(mean(mean(cond5n_dt_bl(roi_contour,bg_sup(5)-25:bg_sup(5)+25,:),3),1));
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/d
load cond1n_dt_bl
load cond5n_dt_bl
bg_trig_V2_cont(:,6)=squeeze(mean(mean(cond1n_dt_bl(roi_V2,bg_sup(6)-25:bg_sup(6)+25,:),3),1));
bg_trig_circ_cont(:,6)=squeeze(mean(mean(cond1n_dt_bl(roi_contour,bg_sup(6)-25:bg_sup(6)+25,:),3),1));
bg_trig_V2_non(:,6)=squeeze(mean(mean(cond5n_dt_bl(roi_V2,bg_sup(6)-25:bg_sup(6)+25,:),3),1));
bg_trig_circ_non(:,6)=squeeze(mean(mean(cond5n_dt_bl(roi_contour,bg_sup(6)-25:bg_sup(6)+25,:),3),1));
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/e
load cond1n_dt_bl
load cond5n_dt_bl
bg_trig_V2_cont(:,7)=squeeze(mean(mean(cond1n_dt_bl(roi_V2,bg_sup(7)-25:bg_sup(7)+25,:),3),1));
bg_trig_circ_cont(:,7)=squeeze(mean(mean(cond1n_dt_bl(roi_contour,bg_sup(7)-25:bg_sup(7)+25,:),3),1));
bg_trig_V2_non(:,7)=squeeze(mean(mean(cond5n_dt_bl(roi_V2,bg_sup(7)-25:bg_sup(7)+25,:),3),1));
bg_trig_circ_non(:,7)=squeeze(mean(mean(cond5n_dt_bl(roi_contour,bg_sup(7)-25:bg_sup(7)+25,:),3),1));
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/d
load 2511
load cond1n_dt_bl
load cond5n_dt_bl
bg_trig_V2_cont(:,8)=squeeze(mean(mean(cond1n_dt_bl(roi_V2,bg_sup(8)-25:bg_sup(8)+25,:),3),1));
bg_trig_circ_cont(:,8)=squeeze(mean(mean(cond1n_dt_bl(roi_contour,bg_sup(8)-25:bg_sup(8)+25,:),3),1));
bg_trig_V2_non(:,8)=squeeze(mean(mean(cond5n_dt_bl(roi_V2,bg_sup(8)-25:bg_sup(8)+25,:),3),1));
bg_trig_circ_non(:,8)=squeeze(mean(mean(cond5n_dt_bl(roi_contour,bg_sup(8)-25:bg_sup(8)+25,:),3),1));
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/e
load cond1n_dt_bl
load cond5n_dt_bl
bg_trig_V2_cont(:,9)=squeeze(mean(mean(cond1n_dt_bl(roi_V2,bg_sup(9)-25:bg_sup(9)+25,:),3),1));
bg_trig_circ_cont(:,9)=squeeze(mean(mean(cond1n_dt_bl(roi_contour,bg_sup(9)-25:bg_sup(9)+25,:),3),1));
bg_trig_V2_non(:,9)=squeeze(mean(mean(cond5n_dt_bl(roi_V2,bg_sup(9)-25:bg_sup(9)+25,:),3),1));
bg_trig_circ_non(:,9)=squeeze(mean(mean(cond5n_dt_bl(roi_contour,bg_sup(9)-25:bg_sup(9)+25,:),3),1));
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/f
load cond1n_dt_bl
load cond5n_dt_bl
bg_trig_V2_cont(:,10)=squeeze(mean(mean(cond1n_dt_bl(roi_V2,bg_sup(10)-25:bg_sup(10)+25,:),3),1));
bg_trig_circ_cont(:,10)=squeeze(mean(mean(cond1n_dt_bl(roi_contour,bg_sup(10)-25:bg_sup(10)+25,:),3),1));
bg_trig_V2_non(:,10)=squeeze(mean(mean(cond5n_dt_bl(roi_V2,bg_sup(10)-25:bg_sup(10)+25,:),3),1));
bg_trig_circ_non(:,10)=squeeze(mean(mean(cond5n_dt_bl(roi_contour,bg_sup(10)-25:bg_sup(10)+25,:),3),1));
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/d
load myrois
load cond1n_dt_bl
load cond5n_dt_bl
bg_trig_V2_cont(:,11)=squeeze(mean(mean(cond1n_dt_bl(roi_V2,bg_sup(11)-25:bg_sup(11)+25,:),3),1));
bg_trig_circ_cont(:,11)=squeeze(mean(mean(cond1n_dt_bl(roi_contour,bg_sup(11)-25:bg_sup(11)+25,:),3),1));
bg_trig_V2_non(:,11)=squeeze(mean(mean(cond5n_dt_bl(roi_V2,bg_sup(11)-25:bg_sup(11)+25,:),3),1));
bg_trig_circ_non(:,11)=squeeze(mean(mean(cond5n_dt_bl(roi_contour,bg_sup(11)-25:bg_sup(11)+25,:),3),1));
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/e
load cond1n_dt_bl
load cond5n_dt_bl
bg_trig_V2_cont(:,12)=squeeze(mean(mean(cond1n_dt_bl(roi_V2,bg_sup(12)-25:bg_sup(12)+25,:),3),1));
bg_trig_circ_cont(:,12)=squeeze(mean(mean(cond1n_dt_bl(roi_contour,bg_sup(12)-25:bg_sup(12)+25,:),3),1));
bg_trig_V2_non(:,12)=squeeze(mean(mean(cond5n_dt_bl(roi_V2,bg_sup(12)-25:bg_sup(12)+25,:),3),1));
bg_trig_circ_non(:,12)=squeeze(mean(mean(cond5n_dt_bl(roi_contour,bg_sup(12)-25:bg_sup(12)+25,:),3),1));
clear cond1n_dt_bl
clear cond5n_dt_bl
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/f
load cond1n_dt_bl
load cond5n_dt_bl
bg_trig_V2_cont(:,13)=squeeze(mean(mean(cond1n_dt_bl(roi_V2,bg_sup(13)-25:bg_sup(13)+25,:),3),1));
bg_trig_circ_cont(:,13)=squeeze(mean(mean(cond1n_dt_bl(roi_contour,bg_sup(13)-25:bg_sup(13)+25,:),3),1));
bg_trig_V2_non(:,13)=squeeze(mean(mean(cond5n_dt_bl(roi_V2,bg_sup(13)-25:bg_sup(13)+25,:),3),1));
bg_trig_circ_non(:,13)=squeeze(mean(mean(cond5n_dt_bl(roi_contour,bg_sup(13)-25:bg_sup(13)+25,:),3),1));
clear cond1n_dt_bl
clear cond5n_dt_bl



%%

figure;plot(mean(bg_trig_V2_cont(21:31,:),2))
hold on
plot(mean(bg_trig_V2_non(21:31,:),2),'r')


figure;plot(mean(bg_trig_V2_cont(21:31,:)-bg_trig_V2_non(21:31,:),2))
figure;plot(bg_trig_V2_cont(21:31,:)-bg_trig_V2_non(21:31,:))
figure;plot(bg_trig_V2_cont(21:31,:))


figure;plot(mean(bg_trig_circ_cont,2))
hold on
plot(mean(bg_trig_circ_non,2),'r')




x=-250:10:250;
for i=1:13
    figure;plot(x,bg_trig_V2_cont(:,i))
    hold on
    plot(x,bg_trig_V2_non(:,i),'r')
end




for i=1:13
    figure;plot(x(21:35),bg_trig_V2_cont(21:35,i)-bg_trig_V2_non(21:35,i))
end


