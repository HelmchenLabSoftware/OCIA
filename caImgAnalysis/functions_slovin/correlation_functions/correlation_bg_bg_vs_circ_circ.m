%% comparison between circle correlation and background correlation




cc_circ_circ_1111c=mean(a(roi_contour2,:),1)-mean(b(roi_contour2,:),1);
cc_bg_bg_1111c=mean(a(roi_maskin,:),1)-mean(b(roi_maskin,:),1);

cc_circ_circ_1111d=mean(a(roi_contour2,:),1)-mean(b(roi_contour2,:),1);
cc_bg_bg_1111d=mean(a(roi_maskin,:),1)-mean(b(roi_maskin,:),1);

cc_circ_circ_1111h=mean(a(roi_contour,:),1)-mean(b(roi_contour,:),1);
cc_bg_bg_1111h=mean(a(roi_dip,:),1)-mean(b(roi_dip,:),1);


cc_circ_circ_1811c=mean(a(roi_contour,:),1)-mean(b(roi_contour,:),1);
cc_bg_bg_1811c=mean(a(roi_bg_in,:),1)-mean(b(roi_bg_in,:),1);

cc_circ_circ_1811d=mean(a(roi_contour,:),1)-mean(b(roi_contour,:),1);
cc_bg_bg_1811d=mean(a(roi_bg_in,:),1)-mean(b(roi_bg_in,:),1);

cc_circ_circ_1811e=mean(a(roi_contour,:),1)-mean(b(roi_contour,:),1);
cc_bg_bg_1811e=mean(a(roi_bg_in,:),1)-mean(b(roi_bg_in,:),1);


cc_circ_circ_2511d=mean(a(roi_contour,:),1)-mean(b(roi_contour,:),1);
cc_bg_bg_2511d=mean(a(roi_bg_in,:),1)-mean(b(roi_bg_in,:),1);

cc_circ_circ_2511e=mean(a(roi_contour,:),1)-mean(b(roi_contour,:),1);
cc_bg_bg_2511e=mean(a(roi_bg_in,:),1)-mean(b(roi_bg_in,:),1);

cc_circ_circ_2511f=mean(a(roi_contour,:),1)-mean(b(roi_contour,:),1);
cc_bg_bg_2511f=mean(a(roi_bg_in,:),1)-mean(b(roi_bg_in,:),1);

cc_circ_circ_1203d=mean(a(roi_contour,:),1)-mean(b(roi_contour,:),1);
cc_bg_bg_1203d=mean(a(roi_bg_in,:),1)-mean(b(roi_bg_in,:),1);

cc_circ_circ_1203e=mean(a(roi_contour,:),1)-mean(b(roi_contour,:),1);
cc_bg_bg_1203e=mean(a(roi_bg_in,:),1)-mean(b(roi_bg_in,:),1);

cc_circ_circ_1203f=mean(a(roi_contour,:),1)-mean(b(roi_contour,:),1);
cc_bg_bg_1203f=mean(a(roi_bg_in,:),1)-mean(b(roi_bg_in,:),1);



cc_circ_circ_0610e=mean(a(roi_contour,:),1)-mean(b(roi_contour,:),1);
cc_bg_bg_0610e=mean(a(roi_bg_in,:),1)-mean(b(roi_bg_in,:),1);

cc_circ_circ_0610f=mean(a(roi_contour,:),1)-mean(b(roi_contour,:),1);
cc_bg_bg_0610f=mean(a(roi_bg_in,:),1)-mean(b(roi_bg_in,:),1);


cc_circ_circ_2210d=mean(a(roi_contour,:),1)-mean(b(roi_contour,:),1);
cc_bg_bg_2210d=mean(a(roi_bg_in,:),1)-mean(b(roi_bg_in,:),1);

cc_circ_circ_2210e=mean(a(roi_contour,:),1)-mean(b(roi_contour,:),1);
cc_bg_bg_2210e=mean(a(roi_bg_in,:),1)-mean(b(roi_bg_in,:),1);

cc_circ_circ_0601e=mean(a(roi_contour,:),1)-mean(b(roi_contour,:),1);
cc_bg_bg_0601e=mean(a(roi_f6,:),1)-mean(b(roi_f6,:),1);

cc_circ_circ_0601fg=mean(a(roi_contour2,:),1)-mean(b(roi_contour2,:),1);
cc_bg_bg_0601fg=mean(a(roi_dip,:),1)-mean(b(roi_dip,:),1);

figure;
plot(cc_circ_circ_1111c)
hold on
plot(cc_bg_bg_1111c,'r')
xlim([20 58])





cc_circ_circ(:,1)=cc_circ_circ_1111c;
cc_circ_circ(:,2)=cc_circ_circ_1111d;
cc_circ_circ(:,3)=cc_circ_circ_1111h;
cc_circ_circ(:,4)=cc_circ_circ_1811c;
cc_circ_circ(:,5)=cc_circ_circ_1811d;
cc_circ_circ(:,6)=cc_circ_circ_1811e;
cc_circ_circ(:,7)=cc_circ_circ_2511d;
cc_circ_circ(:,8)=cc_circ_circ_2511e;
cc_circ_circ(:,9)=cc_circ_circ_2511f;
cc_circ_circ(:,10)=cc_circ_circ_1203d;
cc_circ_circ(:,11)=cc_circ_circ_1203e;
cc_circ_circ(:,12)=cc_circ_circ_1203f;
cc_circ_circ(:,13)=cc_circ_circ_0610e;
cc_circ_circ(:,14)=cc_circ_circ_0610f;
cc_circ_circ(:,15)=cc_circ_circ_2210d;
cc_circ_circ(:,16)=cc_circ_circ_2210e;
cc_circ_circ(:,17)=cc_circ_circ_0601e;
cc_circ_circ(:,18)=cc_circ_circ_0601fg;



cc_bg_bg(:,1)=cc_bg_bg_1111c;
cc_bg_bg(:,2)=cc_bg_bg_1111d;
cc_bg_bg(:,3)=cc_bg_bg_1111h;
cc_bg_bg(:,4)=cc_bg_bg_1811c;
cc_bg_bg(:,5)=cc_bg_bg_1811d;
cc_bg_bg(:,6)=cc_bg_bg_1811e;
cc_bg_bg(:,7)=cc_bg_bg_2511d;
cc_bg_bg(:,8)=cc_bg_bg_2511e;
cc_bg_bg(:,9)=cc_bg_bg_2511f;
cc_bg_bg(:,10)=cc_bg_bg_1203d;
cc_bg_bg(:,11)=cc_bg_bg_1203e;
cc_bg_bg(:,12)=cc_bg_bg_1203f;
cc_bg_bg(:,13)=cc_bg_bg_0610e;
cc_bg_bg(:,14)=cc_bg_bg_0610f;
cc_bg_bg(:,15)=cc_bg_bg_2210d;
cc_bg_bg(:,16)=cc_bg_bg_2210e;
cc_bg_bg(:,17)=cc_bg_bg_0601e;
cc_bg_bg(:,18)=cc_bg_bg_0601fg;


x=(20:10:1130)-240;
figure
errorbar(x,mean(cc_circ_circ,2),std(cc_circ_circ,0,2)/sqrt(18))
hold on
errorbar(x,mean(cc_bg_bg,2),std(cc_bg_bg,0,2)/sqrt(18),'r')




for i=1:112
    [p(i) h(i)]=ranksum(cc_circ_circ(i,:),cc_bg_bg(i,:));
end




%% V2

cc_circ_V2_1111c14=mean(a(roi_V2,:),1)-mean(b(roi_V2,:),1);
cc_circ_V2_1111c25=mean(c(roi_V2,:),1)-mean(d(roi_V2,:),1);

cc_bg_V2_1111c14=mean(a(roi_V2,:),1)-mean(b(roi_V2,:),1);
cc_bg_V2_1111c25=mean(c(roi_V2,:),1)-mean(d(roi_V2,:),1);


cc_circ_V2_1111d14=mean(a(roi_V2,:),1)-mean(b(roi_V2,:),1);
cc_circ_V2_1111d25=mean(c(roi_V2,:),1)-mean(d(roi_V2,:),1);

cc_bg_V2_1111d14=mean(a(roi_V2,:),1)-mean(b(roi_V2,:),1);
cc_bg_V2_1111d25=mean(c(roi_V2,:),1)-mean(d(roi_V2,:),1);


cc_circ_V2_1811c=mean(a(roi_V2,:),1)-mean(b(roi_V2,:),1);
cc_bg_V2_1811c=mean(a(roi_V2,:),1)-mean(b(roi_V2,:),1);

cc_circ_V2_1811d=mean(a(roi_V2,:),1)-mean(b(roi_V2,:),1);
cc_bg_V2_1811d=mean(a(roi_V2,:),1)-mean(b(roi_V2,:),1);

cc_circ_V2_1811e=mean(a(roi_V2,:),1)-mean(b(roi_V2,:),1);
cc_bg_V2_1811e=mean(a(roi_V2,:),1)-mean(b(roi_V2,:),1);

cc_circ_V2_2511d=mean(a(roi_V2,:),1)-mean(b(roi_V2,:),1);
cc_bg_V2_2511d=mean(a(roi_V2,:),1)-mean(b(roi_V2,:),1);

cc_circ_V2_2511e=mean(a(roi_V2,:),1)-mean(b(roi_V2,:),1);
cc_bg_V2_2511e=mean(a(roi_V2,:),1)-mean(b(roi_V2,:),1);

cc_circ_V2_2511f=mean(a(roi_V2,:),1)-mean(b(roi_V2,:),1);
cc_bg_V2_2511f=mean(a(roi_V2,:),1)-mean(b(roi_V2,:),1);

cc_circ_V2_1203d=mean(a(roi_V2,:),1)-mean(b(roi_V2,:),1);
cc_bg_V2_1203d=mean(a(roi_V2,:),1)-mean(b(roi_V2,:),1);

cc_circ_V2_1203e=mean(a(roi_V2,:),1)-mean(b(roi_V2,:),1);
cc_bg_V2_1203e=mean(a(roi_V2,:),1)-mean(b(roi_V2,:),1);

cc_circ_V2_1203f=mean(a(roi_V2,:),1)-mean(b(roi_V2,:),1);
cc_bg_V2_1203f=mean(a(roi_V2,:),1)-mean(b(roi_V2,:),1);


figure;
plot(cc_circ_V2_1203f)
hold on
plot(cc_bg_V2_1203f,'r')
xlim([20 58])





cc_circ_V2(:,1)=cc_circ_V2_1111c14;
cc_circ_V2(:,2)=cc_circ_V2_1111c25;
cc_circ_V2(:,3)=cc_circ_V2_1111d14;
cc_circ_V2(:,4)=cc_circ_V2_1111d25;
cc_circ_V2(:,5)=cc_circ_V2_1811c;
cc_circ_V2(:,6)=cc_circ_V2_1811d;
cc_circ_V2(:,7)=cc_circ_V2_1811e;
cc_circ_V2(:,8)=cc_circ_V2_2511d;
cc_circ_V2(:,9)=cc_circ_V2_2511e;
cc_circ_V2(:,10)=cc_circ_V2_2511f;
cc_circ_V2(:,11)=cc_circ_V2_1203d;
cc_circ_V2(:,12)=cc_circ_V2_1203e;
cc_circ_V2(:,13)=cc_circ_V2_1203f;


cc_bg_V2(:,1)=cc_bg_V2_1111c14;
cc_bg_V2(:,2)=cc_bg_V2_1111c25;
cc_bg_V2(:,3)=cc_bg_V2_1111d14;
cc_bg_V2(:,4)=cc_bg_V2_1111d25;
cc_bg_V2(:,5)=cc_bg_V2_1811c;
cc_bg_V2(:,6)=cc_bg_V2_1811d;
cc_bg_V2(:,7)=cc_bg_V2_1811e;
cc_bg_V2(:,8)=cc_bg_V2_2511d;
cc_bg_V2(:,9)=cc_bg_V2_2511e;
cc_bg_V2(:,10)=cc_bg_V2_2511f;
cc_bg_V2(:,11)=cc_bg_V2_1203d;
cc_bg_V2(:,12)=cc_bg_V2_1203e;
cc_bg_V2(:,13)=cc_bg_V2_1203f;


x=(20:10:1130)-250;
figure
errorbar(x,mean(cc_circ_V2,2),std(cc_circ_V2,0,2)/sqrt(13))
hold on
errorbar(x,mean(cc_bg_V2,2),std(cc_bg_V2,0,2)/sqrt(13),'r')




for i=1:112
    [p(i) h(i)]=ranksum(cc_circ_V2(i,:),cc_bg_V2(i,:));
end

for i=1:112
    [p(i) h(i)]=ranksum(cc_circ_V2(i,:),cc_circ_circ(i,:));
end

for i=1:112
    [h(i) p(i)]=ttest(cc_circ_V2(i,:));
end


for i=1:112
    [h(i) p(i)]=ttest(cc_circ_bg(i,:));
end
for i=1:112
    [h2(i) p2(i)]=signtest(cc_circ_circ(i,:));
end




%%


cc_V2_V2_1111c14=mean(mean(a(roi_V2,:,:),1),3)-mean(mean(b(roi_V2,:,:),1),3);
cc_V2_V2_1111c25=mean(mean(c(roi_V2,:,:),1),3)-mean(mean(d(roi_V2,:,:),1),3);

cc_V2_V2_1111d14=mean(mean(a(roi_V2,:,:),1),3)-mean(mean(b(roi_V2,:,:),1),3);
cc_V2_V2_1111d25=mean(mean(c(roi_V2,:,:),1),3)-mean(mean(d(roi_V2,:,:),1),3);

cc_V2_V2_1811c=mean(mean(a(roi_V2,:,:),1),3)-mean(mean(b(roi_V2,:,:),1),3);

cc_V2_V2_1811d=mean(mean(a(roi_V2,:,:),1),3)-mean(mean(b(roi_V2,:,:),1),3);

cc_V2_V2_1811e=mean(mean(a(roi_V2,:,:),1),3)-mean(mean(b(roi_V2,:,:),1),3);

cc_V2_V2_2511d=mean(mean(a(roi_V2,:,:),1),3)-mean(mean(b(roi_V2,:,:),1),3);

cc_V2_V2_2511e=mean(mean(a(roi_V2,:,:),1),3)-mean(mean(b(roi_V2,:,:),1),3);

cc_V2_V2_2511f=mean(mean(a(roi_V2,:,:),1),3)-mean(mean(b(roi_V2,:,:),1),3);

cc_V2_V2_1203d=mean(mean(a(roi_V2,:,:),1),3)-mean(mean(b(roi_V2,:,:),1),3);

cc_V2_V2_1203e=mean(mean(a(roi_V2,:,:),1),3)-mean(mean(b(roi_V2,:,:),1),3);

cc_V2_V2_1203f=mean(mean(a(roi_V2,:,:),1),3)-mean(mean(b(roi_V2,:,:),1),3);


cc_V2_V2(:,1)=cc_V2_V2_1111c14;
cc_V2_V2(:,2)=cc_V2_V2_1111c25;
cc_V2_V2(:,3)=cc_V2_V2_1111d14;
cc_V2_V2(:,4)=cc_V2_V2_1111d25;
cc_V2_V2(:,5)=cc_V2_V2_1811c;
cc_V2_V2(:,6)=cc_V2_V2_1811d;
cc_V2_V2(:,7)=cc_V2_V2_1811e;
cc_V2_V2(:,8)=cc_V2_V2_2511d;
cc_V2_V2(:,9)=cc_V2_V2_2511e;
cc_V2_V2(:,10)=cc_V2_V2_2511f;
cc_V2_V2(:,11)=cc_V2_V2_1203d;
cc_V2_V2(:,12)=cc_V2_V2_1203e;
cc_V2_V2(:,13)=cc_V2_V2_1203f;

%%


cc_V2_V2_stage1=mean(cc_V2_V2(31:34,:));
cc_V2_V2_stage2=mean(cc_V2_V2(42:45,:));

cc_circ_V2_stage1=mean(cc_circ_V2(31:34,:));
cc_circ_V2_stage2=mean(cc_circ_V2(42:45,:));

cc_circ_circ_stage1=mean(cc_circ_circ(31:34,1:18));
cc_circ_circ_stage2=mean(cc_circ_circ(42:45,1:18));


figure;bar([mean(cc_circ_circ_stage1) mean(cc_circ_V2_stage1) mean(cc_V2_V2_stage1)])
a=nan*ones(3,18);
a(1,:)=cc_circ_circ_stage1;
a(2,1:13)=cc_circ_V2_stage1;
a(3,1:13)=cc_V2_V2_stage1;
hold on
errorbar(nanmean(a,2),nanstd(a,0,2)/sqrt(13))

ranksum(cc_circ_circ_stage1,cc_circ_V2_stage1)
ranksum(cc_circ_circ_stage1,cc_V2_V2_stage1)
ranksum(cc_V2_V2_stage1,cc_circ_V2_stage1)
signrank(cc_circ_circ_stage1)
signrank(cc_circ_V2_stage1)
signrank(cc_V2_V2_stage1)

figure;bar([mean(cc_circ_circ_stage2) mean(cc_circ_V2_stage2) mean(cc_V2_V2_stage2)])
a=nan*ones(3,18);
a(1,:)=cc_circ_circ_stage2;
a(2,1:13)=cc_circ_V2_stage2;
a(3,1:13)=cc_V2_V2_stage2;
hold on
errorbar(nanmean(a,2),nanstd(a,0,2)/sqrt(13))

ranksum(cc_circ_circ_stage2,cc_circ_V2_stage2)
ranksum(cc_circ_circ_stage2,cc_V2_V2_stage2)
ranksum(cc_V2_V2_stage2,cc_circ_V2_stage2)
signrank(cc_circ_circ_stage2)
signrank(cc_circ_V2_stage2)
signrank(cc_V2_V2_stage2)


%%


cc_diff(:,1)=cc_1111c14;
cc_diff(:,2)=cc_1111c25;
cc_diff(:,3)=cc_1111d14;
cc_diff(:,4)=cc_1111d25;
cc_diff(:,5)=cc_1811c15;
cc_diff(:,6)=cc_1811d15;
cc_diff(:,7)=cc_1811e15;
cc_diff(:,8)=cc_2511d15;
cc_diff(:,9)=cc_2511e15;
cc_diff(:,10)=cc_2511f15;
cc_diff(:,11)=cc_1203d15;
cc_diff(:,12)=cc_1203e15;
cc_diff(:,13)=cc_1203f15;



%%

x=(20:10:1130)-240;
mm=max(cc_V2_V2(23:43,1:13));


cc_circ_V2=cc_circ_V2./repmat(mm,112,1);
cc_V2_V2=cc_V2_V2./repmat(mm,112,1);
cc_circ_circ=cc_circ_circ(:,1:13)./repmat(mm,112,1);

figure;plot(x,mean(cc_circ_circ,2))
hold on
plot(x,mean(cc_circ_V2,2),'g')
plot(x,mean(cc_V2_V2,2),'r')
xlim([-100 250])

for i=1:13
   figure;plot(x,mean(cc_circ_circ(:,i),2))
   hold on
   plot(x,mean(cc_circ_V2(:,i),2),'g')
   plot(x,mean(cc_V2_V2(:,i),2),'r')
   xlim([-100 250]) 
end


figure;errorbar(x,mean(cc_circ_circ,2),std(cc_circ_circ,0,2)/sqrt(13))
hold on
errorbar(x,mean(cc_circ_V2,2),std(cc_circ_V2,0,2)/sqrt(13),'g')
errorbar(x,mean(cc_V2_V2,2),std(cc_V2_V2,0,2)/sqrt(13),'r')
xlim([-100 250])

for i=1:112
    p1(i)=ranksum(cc_circ_circ(i,:),cc_circ_V2(i,:));
    p2(i)=signrank(cc_circ_circ(i,:));
    p3(i)=signrank(cc_circ_V2(i,:));
    p4(i)=signrank(cc_V2_V2(i,:));
end    

x(find(p1<0.05))
x(find(p2<0.05))
x(find(p3<0.05))
x(find(p4<0.05))














