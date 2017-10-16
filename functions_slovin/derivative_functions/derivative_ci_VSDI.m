

der_1=cond1n_dt_bl(:,6:116,:)-cond1n_dt_bl(:,2:112,:);
der_4=cond4n_dt_bl(:,6:116,:)-cond4n_dt_bl(:,2:112,:);
der_2=cond2n_dt_bl(:,6:116,:)-cond2n_dt_bl(:,2:112,:);
der_5=cond5n_dt_bl(:,6:116,:)-cond5n_dt_bl(:,2:112,:);


der_1111d1_V2=mean(der_1(roi_V2,:,:),3);
der_1111d1_circ=mean(der_1(roi_contour2,:,:),3);
der_1111d1_bgi=mean(der_1(roi_maskin,:,:),3);

der_1111d2_V2=mean(der_2(roi_V2,:,:),3);
der_1111d2_circ=mean(der_2(roi_contour2,:,:),3);
der_1111d2_bgi=mean(der_2(roi_maskin,:,:),3);

der_1111d4_V2=mean(der_4(roi_V2,:,:),3);
der_1111d4_circ=mean(der_4(roi_contour2,:,:),3);
der_1111d4_bgi=mean(der_4(roi_maskin,:,:),3);

der_1111d5_V2=mean(der_5(roi_V2,:,:),3);
der_1111d5_circ=mean(der_5(roi_contour2,:,:),3);
der_1111d5_bgi=mean(der_5(roi_maskin,:,:),3);



der_1=cond1n_dt_bl(:,6:116,:)-cond1n_dt_bl(:,2:112,:);
der_5=cond5n_dt_bl(:,6:116,:)-cond5n_dt_bl(:,2:112,:);

der_1203f1_V2=mean(der_1(roi_V2,:,:),3);
der_1203f1_circ=mean(der_1(roi_contour,:,:),3);
der_1203f1_bgi=mean(der_1(roi_bg_in,:,:),3);

der_1203f5_V2=mean(der_5(roi_V2,:,:),3);
der_1203f5_circ=mean(der_5(roi_contour,:,:),3);
der_1203f5_bgi=mean(der_5(roi_bg_in,:,:),3);







%%

der_cont_V2=der_1111c1_V2;
der_cont_V2=cat(1,der_cont_V2,der_1111c2_V2);
der_cont_V2=cat(1,der_cont_V2,der_1111d1_V2);
der_cont_V2=cat(1,der_cont_V2,der_1111d2_V2);
der_cont_V2=cat(1,der_cont_V2,der_1811c1_V2);
der_cont_V2=cat(1,der_cont_V2,der_1811d1_V2);
der_cont_V2=cat(1,der_cont_V2,der_1811e1_V2);
der_cont_V2=cat(1,der_cont_V2,der_2511d1_V2);
der_cont_V2=cat(1,der_cont_V2,der_2511e1_V2);
der_cont_V2=cat(1,der_cont_V2,der_2511f1_V2);
der_cont_V2=cat(1,der_cont_V2,der_1203d1_V2);
der_cont_V2=cat(1,der_cont_V2,der_1203e1_V2);
der_cont_V2=cat(1,der_cont_V2,der_1203f1_V2);


der_non_V2=der_1111c4_V2;
der_non_V2=cat(1,der_non_V2,der_1111c5_V2);
der_non_V2=cat(1,der_non_V2,der_1111d4_V2);
der_non_V2=cat(1,der_non_V2,der_1111d5_V2);
der_non_V2=cat(1,der_non_V2,der_1811c5_V2);
der_non_V2=cat(1,der_non_V2,der_1811d5_V2);
der_non_V2=cat(1,der_non_V2,der_1811e5_V2);
der_non_V2=cat(1,der_non_V2,der_2511d5_V2);
der_non_V2=cat(1,der_non_V2,der_2511e5_V2);
der_non_V2=cat(1,der_non_V2,der_2511f5_V2);
der_non_V2=cat(1,der_non_V2,der_1203d5_V2);
der_non_V2=cat(1,der_non_V2,der_1203e5_V2);
der_non_V2=cat(1,der_non_V2,der_1203f5_V2);


figure;errorbar(mean(der_cont_V2,1),std(der_cont_V2,0,1)/sqrt(size(der_cont_V2,1)))
hold on
errorbar(mean(der_non_V2,1),std(der_non_V2,0,1)/sqrt(size(der_non_V2,1)),'r')








der_cont_circ=der_1111c1_circ;
der_cont_circ=cat(1,der_cont_circ,der_1111c2_circ);
der_cont_circ=cat(1,der_cont_circ,der_1111d1_circ);
der_cont_circ=cat(1,der_cont_circ,der_1111d2_circ);
der_cont_circ=cat(1,der_cont_circ,der_1811c1_circ);
der_cont_circ=cat(1,der_cont_circ,der_1811d1_circ);
der_cont_circ=cat(1,der_cont_circ,der_1811e1_circ);
der_cont_circ=cat(1,der_cont_circ,der_2511d1_circ);
der_cont_circ=cat(1,der_cont_circ,der_2511e1_circ);
der_cont_circ=cat(1,der_cont_circ,der_2511f1_circ);
der_cont_circ=cat(1,der_cont_circ,der_1203d1_circ);
der_cont_circ=cat(1,der_cont_circ,der_1203e1_circ);
der_cont_circ=cat(1,der_cont_circ,der_1203f1_circ);


der_non_circ=der_1111c4_circ;
der_non_circ=cat(1,der_non_circ,der_1111c5_circ);
der_non_circ=cat(1,der_non_circ,der_1111d4_circ);
der_non_circ=cat(1,der_non_circ,der_1111d5_circ);
der_non_circ=cat(1,der_non_circ,der_1811c5_circ);
der_non_circ=cat(1,der_non_circ,der_1811d5_circ);
der_non_circ=cat(1,der_non_circ,der_1811e5_circ);
der_non_circ=cat(1,der_non_circ,der_2511d5_circ);
der_non_circ=cat(1,der_non_circ,der_2511e5_circ);
der_non_circ=cat(1,der_non_circ,der_2511f5_circ);
der_non_circ=cat(1,der_non_circ,der_1203d5_circ);
der_non_circ=cat(1,der_non_circ,der_1203e5_circ);
der_non_circ=cat(1,der_non_circ,der_1203f5_circ);


figure;errorbar(mean(der_cont_circ,1),std(der_cont_circ,0,1)/sqrt(size(der_cont_circ,1)))
hold on
errorbar(mean(der_non_circ,1),std(der_non_circ,0,1)/sqrt(size(der_non_circ,1)),'r')






der_cont_bgi=der_1111c1_bgi;
der_cont_bgi=cat(1,der_cont_bgi,der_1111c2_bgi);
der_cont_bgi=cat(1,der_cont_bgi,der_1111d1_bgi);
der_cont_bgi=cat(1,der_cont_bgi,der_1111d2_bgi);
der_cont_bgi=cat(1,der_cont_bgi,der_1811c1_bgi);
der_cont_bgi=cat(1,der_cont_bgi,der_1811d1_bgi);
der_cont_bgi=cat(1,der_cont_bgi,der_1811e1_bgi);
der_cont_bgi=cat(1,der_cont_bgi,der_2511d1_bgi);
der_cont_bgi=cat(1,der_cont_bgi,der_2511e1_bgi);
der_cont_bgi=cat(1,der_cont_bgi,der_2511f1_bgi);
der_cont_bgi=cat(1,der_cont_bgi,der_1203d1_bgi);
der_cont_bgi=cat(1,der_cont_bgi,der_1203e1_bgi);
der_cont_bgi=cat(1,der_cont_bgi,der_1203f1_bgi);


der_non_bgi=der_1111c4_bgi;
der_non_bgi=cat(1,der_non_bgi,der_1111c5_bgi);
der_non_bgi=cat(1,der_non_bgi,der_1111d4_bgi);
der_non_bgi=cat(1,der_non_bgi,der_1111d5_bgi);
der_non_bgi=cat(1,der_non_bgi,der_1811c5_bgi);
der_non_bgi=cat(1,der_non_bgi,der_1811d5_bgi);
der_non_bgi=cat(1,der_non_bgi,der_1811e5_bgi);
der_non_bgi=cat(1,der_non_bgi,der_2511d5_bgi);
der_non_bgi=cat(1,der_non_bgi,der_2511e5_bgi);
der_non_bgi=cat(1,der_non_bgi,der_2511f5_bgi);
der_non_bgi=cat(1,der_non_bgi,der_1203d5_bgi);
der_non_bgi=cat(1,der_non_bgi,der_1203e5_bgi);
der_non_bgi=cat(1,der_non_bgi,der_1203f5_bgi);


figure;errorbar(mean(der_cont_bgi,1),std(der_cont_bgi,0,1)/sqrt(size(der_cont_bgi,1)))
hold on
errorbar(mean(der_non_bgi,1),std(der_non_bgi,0,1)/sqrt(size(der_non_bgi,1)),'r')





%%

der_cont_circ=zeros(111,13);
der_cont_circ(:,1)=mean(der_1111c1_circ,1);
der_cont_circ(:,2)=mean(der_1111c2_circ,1);
der_cont_circ(:,3)=mean(der_1111d1_circ,1);
der_cont_circ(:,4)=mean(der_1111d2_circ,1);
der_cont_circ(:,5)=mean(der_1811c1_circ,1);
der_cont_circ(:,6)=mean(der_1811d1_circ,1);
der_cont_circ(:,7)=mean(der_1811e1_circ,1);
der_cont_circ(:,8)=mean(der_2511d1_circ,1);
der_cont_circ(:,9)=mean(der_2511e1_circ,1);
der_cont_circ(:,10)=mean(der_2511f1_circ,1);
der_cont_circ(:,11)=mean(der_1203d1_circ,1);
der_cont_circ(:,12)=mean(der_1203e1_circ,1);
der_cont_circ(:,13)=mean(der_1203f1_circ,1);


der_non_circ=zeros(111,13);
der_non_circ(:,1)=mean(der_1111c4_circ,1);
der_non_circ(:,2)=mean(der_1111c5_circ,1);
der_non_circ(:,3)=mean(der_1111d4_circ,1);
der_non_circ(:,4)=mean(der_1111d5_circ,1);
der_non_circ(:,5)=mean(der_1811c5_circ,1);
der_non_circ(:,6)=mean(der_1811d5_circ,1);
der_non_circ(:,7)=mean(der_1811e5_circ,1);
der_non_circ(:,8)=mean(der_2511d5_circ,1);
der_non_circ(:,9)=mean(der_2511e5_circ,1);
der_non_circ(:,10)=mean(der_2511f5_circ,1);
der_non_circ(:,11)=mean(der_1203d5_circ,1);
der_non_circ(:,12)=mean(der_1203e5_circ,1);
der_non_circ(:,13)=mean(der_1203f5_circ,1);



der_cont_V2=zeros(111,13);
der_cont_V2(:,1)=mean(der_1111c1_V2,1);
der_cont_V2(:,2)=mean(der_1111c2_V2,1);
der_cont_V2(:,3)=mean(der_1111d1_V2,1);
der_cont_V2(:,4)=mean(der_1111d2_V2,1);
der_cont_V2(:,5)=mean(der_1811c1_V2,1);
der_cont_V2(:,6)=mean(der_1811d1_V2,1);
der_cont_V2(:,7)=mean(der_1811e1_V2,1);
der_cont_V2(:,8)=mean(der_2511d1_V2,1);
der_cont_V2(:,9)=mean(der_2511e1_V2,1);
der_cont_V2(:,10)=mean(der_2511f1_V2,1);
der_cont_V2(:,11)=mean(der_1203d1_V2,1);
der_cont_V2(:,12)=mean(der_1203e1_V2,1);
der_cont_V2(:,13)=mean(der_1203f1_V2,1);


der_non_V2=zeros(111,13);
der_non_V2(:,1)=mean(der_1111c4_V2,1);
der_non_V2(:,2)=mean(der_1111c5_V2,1);
der_non_V2(:,3)=mean(der_1111d4_V2,1);
der_non_V2(:,4)=mean(der_1111d5_V2,1);
der_non_V2(:,5)=mean(der_1811c5_V2,1);
der_non_V2(:,6)=mean(der_1811d5_V2,1);
der_non_V2(:,7)=mean(der_1811e5_V2,1);
der_non_V2(:,8)=mean(der_2511d5_V2,1);
der_non_V2(:,9)=mean(der_2511e5_V2,1);
der_non_V2(:,10)=mean(der_2511f5_V2,1);
der_non_V2(:,11)=mean(der_1203d5_V2,1);
der_non_V2(:,12)=mean(der_1203e5_V2,1);
der_non_V2(:,13)=mean(der_1203f5_V2,1);



der_cont_bgi=zeros(111,13);
der_cont_bgi(:,1)=mean(der_1111c1_bgi,1);
der_cont_bgi(:,2)=mean(der_1111c2_bgi,1);
der_cont_bgi(:,3)=mean(der_1111d1_bgi,1);
der_cont_bgi(:,4)=mean(der_1111d2_bgi,1);
der_cont_bgi(:,5)=mean(der_1811c1_bgi,1);
der_cont_bgi(:,6)=mean(der_1811d1_bgi,1);
der_cont_bgi(:,7)=mean(der_1811e1_bgi,1);
der_cont_bgi(:,8)=mean(der_2511d1_bgi,1);
der_cont_bgi(:,9)=mean(der_2511e1_bgi,1);
der_cont_bgi(:,10)=mean(der_2511f1_bgi,1);
der_cont_bgi(:,11)=mean(der_1203d1_bgi,1);
der_cont_bgi(:,12)=mean(der_1203e1_bgi,1);
der_cont_bgi(:,13)=mean(der_1203f1_bgi,1);


der_non_bgi=zeros(111,13);
der_non_bgi(:,1)=mean(der_1111c4_bgi,1);
der_non_bgi(:,2)=mean(der_1111c5_bgi,1);
der_non_bgi(:,3)=mean(der_1111d4_bgi,1);
der_non_bgi(:,4)=mean(der_1111d5_bgi,1);
der_non_bgi(:,5)=mean(der_1811c5_bgi,1);
der_non_bgi(:,6)=mean(der_1811d5_bgi,1);
der_non_bgi(:,7)=mean(der_1811e5_bgi,1);
der_non_bgi(:,8)=mean(der_2511d5_bgi,1);
der_non_bgi(:,9)=mean(der_2511e5_bgi,1);
der_non_bgi(:,10)=mean(der_2511f5_bgi,1);
der_non_bgi(:,11)=mean(der_1203d5_bgi,1);
der_non_bgi(:,12)=mean(der_1203e5_bgi,1);
der_non_bgi(:,13)=mean(der_1203f5_bgi,1);


x=(40:10:1140)-280;
figure;
h=errorbar(x,mean(der_cont_V2,2),std(der_cont_V2,0,2)/sqrt(size(der_cont_V2,2)));
ll=15;
hb = get(h,'children');
Xdata = get(hb(2),'Xdata');
temp = 4:3:length(Xdata);
temp(3:3:end) = [];
xleft = temp; xright = temp+1;  %xleft and xright contain the indices of the left and right endpoints of the horizontal lines
Xdata(xleft) = Xdata(xleft) + ll; % Decrease line length of the errorbar by 0.2 units
Xdata(xright) = Xdata(xright) - ll;
set(hb(2),'Xdata',Xdata)
xlim([-100 250])

hold on
h=errorbar(x,mean(der_non_V2,2),std(der_non_V2,0,2)/sqrt(size(der_non_V2,2)),'r');
ll=15;
hb = get(h,'children');
Xdata = get(hb(2),'Xdata');
temp = 4:3:length(Xdata);
temp(3:3:end) = [];
xleft = temp; xright = temp+1;  %xleft and xright contain the indices of the left and right endpoints of the horizontal lines
Xdata(xleft) = Xdata(xleft) + ll; % Decrease line length of the errorbar by 0.2 units
Xdata(xright) = Xdata(xright) - ll;
set(hb(2),'Xdata',Xdata)
xlim([-100 250])


figure;
h=errorbar(x,mean(der_cont_circ,2),std(der_cont_circ,0,2)/sqrt(size(der_cont_circ,2)));
ll=15;
hb = get(h,'children');
Xdata = get(hb(2),'Xdata');
temp = 4:3:length(Xdata);
temp(3:3:end) = [];
xleft = temp; xright = temp+1;  %xleft and xright contain the indices of the left and right endpoints of the horizontal lines
Xdata(xleft) = Xdata(xleft) + ll; % Decrease line length of the errorbar by 0.2 units
Xdata(xright) = Xdata(xright) - ll;
set(hb(2),'Xdata',Xdata)
xlim([-100 250])

hold on
h=errorbar(x,mean(der_non_circ,2),std(der_non_circ,0,2)/sqrt(size(der_non_circ,2)),'r');
ll=15;
hb = get(h,'children');
Xdata = get(hb(2),'Xdata');
temp = 4:3:length(Xdata);
temp(3:3:end) = [];
xleft = temp; xright = temp+1;  %xleft and xright contain the indices of the left and right endpoints of the horizontal lines
Xdata(xleft) = Xdata(xleft) + ll; % Decrease line length of the errorbar by 0.2 units
Xdata(xright) = Xdata(xright) - ll;
set(hb(2),'Xdata',Xdata)
xlim([-100 250])

figure
h=errorbar(x,mean(der_cont_bgi,2),std(der_cont_bgi,0,2)/sqrt(size(der_cont_bgi,2)));
ll=15;
hb = get(h,'children');
Xdata = get(hb(2),'Xdata');
temp = 4:3:length(Xdata);
temp(3:3:end) = [];
xleft = temp; xright = temp+1;  %xleft and xright contain the indices of the left and right endpoints of the horizontal lines
Xdata(xleft) = Xdata(xleft) + ll; % Decrease line length of the errorbar by 0.2 units
Xdata(xright) = Xdata(xright) - ll;
set(hb(2),'Xdata',Xdata)
xlim([-100 250])

hold on
h=errorbar(x,mean(der_non_bgi,2),std(der_non_bgi,0,2)/sqrt(size(der_non_bgi,2)),'r');
ll=15;
hb = get(h,'children');
Xdata = get(hb(2),'Xdata');
temp = 4:3:length(Xdata);
temp(3:3:end) = [];
xleft = temp; xright = temp+1;  %xleft and xright contain the indices of the left and right endpoints of the horizontal lines
Xdata(xleft) = Xdata(xleft) + ll; % Decrease line length of the errorbar by 0.2 units
Xdata(xright) = Xdata(xright) - ll;
set(hb(2),'Xdata',Xdata)
xlim([-100 250])



for i=1:111
    [p(i) h(i)]=ranksum(der_cont_V2(i,:),der_non_V2(i,:));
    [p2(i) h2(i)]=ranksum(der_cont_circ(i,:),der_non_circ(i,:));
    [p3(i) h3(i)]=ranksum(der_cont_bgi(i,:),der_non_bgi(i,:));
end



%%
diff_V2=der_cont_V2-der_non_V2;
diff_circ=der_cont_circ-der_non_circ;
diff_bgi=der_cont_bgi-der_non_bgi;

x=(40:10:1140)-280;
figure;plot(x,mean(diff_V2,2))
hold on
plot(x,mean(diff_circ,2),'r')
plot(x,mean(diff_bgi,2),'g')
xlim([-100 150])




