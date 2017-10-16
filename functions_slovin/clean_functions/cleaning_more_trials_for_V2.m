

for i=1:15
    figure;mimg(mfilt2(cond1n_dt_bl(:,28:58,i)-cond4n_dt_bl(:,28:58,i),100,100,1,'lm'),100,100,-1e-3,1e-3);colormap(mapgeog)
end

for i=1:16
    figure;mimg(mfilt2(cond2n_dt_bl(:,28:60,i)-cond5n_dt_bl(:,28:60,i),100,100,1,'lm'),100,100,-1e-3,1e-3);colormap(mapgeog)
end

for i=1:33
    figure;mimg(mfilt2(cond1n_dt_bl(:,28:60,i)-cond5n_dt_bl(:,28:60,i),100,100,1,'lm'),100,100,-1e-3,1e-3);colormap(mapgeog)
end

tr15_bad=[1 5 6 8 14 16 23 24 26 30 32];
tr15_good=[2:4 7 9:13 15 17:22 25 27:29 31 33];

mm=nanmean(cat(3,cond5n_dt_bl(:,28:60,:)),3);
mm=nanmean(cat(3,cond4n_dt_bl(:,28:60,:),cond5n_dt_bl(:,28:60,:)),3);
for i=1:size(cond4n_dt_bl,3)
    figure;mimg(mfilt2(cond4n_dt_bl(:,28:60,i)-1,100,100,1,'lm'),100,100,-1e-3,2.5e-3);colormap(mapgeog)
end
tr4_bad=[24];
tr4_good=[1:23 25:33];

for i=1:size(cond5n_dt_bl,3)
    figure;mimg(mfilt2(cond5n_dt_bl(:,28:60,i)-mm,100,100,1,'lm'),100,100,-1e-3,1e-3);colormap(mapgeog)
end
tr5_bad=[2];
tr5_good=[1 3:35];

mm=nanmean(cat(3,cond5n_dt_bl(:,28:60,tr5_good)),3);
mm=nanmean(cat(3,cond4n_dt_bl(:,28:60,tr4_good),cond5n_dt_bl(:,28:60,tr5_good)),3);
for i=1:size(cond1n_dt_bl,3)
    figure;mimg(mfilt2(cond1n_dt_bl(:,28:60,i)-mm,100,100,1,'lm'),100,100,-1e-3,1e-3);colormap(mapgeog)
end
tr1_bad=[1 4 20 34];
tr1_good=[2 3 5:19 21:33];

for i=1:size(cond2n_dt_bl,3)
    figure;mimg(mfilt2(cond2n_dt_bl(:,28:60,i)-mm,100,100,1,'lm'),100,100,-1e-3,1e-3);colormap(mapgeog)
end
tr2_bad=[4 7 16 22 33];
tr2_good=[1:3 5 6 8:15 17:21 23:32 34];

figure;plot(mean(a(roi_V2_circle,2:112),1))
hold on
plot(mean(c(roi_V2_circle,2:112),1),'r')

figure;plot(mean(a(roi_circle,2:112),1))
hold on
plot(mean(c(roi_circle,2:112),1),'r')



figure;plot(mean(b(roi_V2_circle,2:112),1))
hold on
plot(mean(d(roi_V2_circle,2:112),1),'r')

figure;plot(mean(b(roi_circle,2:112),1))
hold on
plot(mean(d(roi_circle,2:112),1),'r')



figure;plot(mean(a(roi_V2_bg,2:112),1))
hold on
plot(mean(c(roi_V2_bg,2:112),1),'r')

figure;plot(mean(a(roi_bg_out,2:112),1))
hold on
plot(mean(c(roi_bg_out,2:112),1),'r')

figure;plot(mean(a(roi_bg_in,2:112),1))
hold on
plot(mean(c(roi_bg_in,2:112),1),'r')



figure;plot(mean(b(roi_V2_bg,2:112),1))
hold on
plot(mean(d(roi_V2_bg,2:112),1),'r')

figure;plot(mean(b(roi_bg_out,2:112),1))
hold on
plot(mean(d(roi_bg_out,2:112),1),'r')

figure;plot(mean(b(roi_bg_in,2:112),1))
hold on
plot(mean(d(roi_bg_in,2:112),1),'r')


figure;plot(mean(a(roi_V2,2:80),1))
hold on
plot(mean(c(roi_V2,2:80),1),'r')

figure;plot(mean(a(roi_maskout,2:112),1))
hold on
plot(mean(c(roi_maskout,2:112),1),'r')



figure;plot(mean(b(roi_V2,2:80),1))
hold on
plot(mean(d(roi_V2,2:80),1),'r')

figure;plot(mean(b(roi_bg_out,2:80),1))
hold on
plot(mean(d(roi_bg_out,2:80),1),'r')

figure;plot(mean(b(roi_maskin,2:112),1))
hold on
plot(mean(d(roi_maskin,2:112),1),'r')

figure;plot(mean(b(roi_contour,2:112),1))
hold on
plot(mean(d(roi_contour,2:112),1),'r')



figure;plot(mean(a(roi_V2,2:112),1))
hold on
plot(mean(d(roi_V2,2:112),1),'r')

figure;plot(mean(a(roi_bg_in,2:112),1))
hold on
plot(mean(d(roi_bg_in,2:112),1),'r')

figure;plot(mean(a(roi_contour,2:112),1))
hold on
plot(mean(d(roi_contour,2:112),1),'r')




%%

ave=(a+b+c+d)/4;
ave=d;



for i=1:size(cond1n_dt_bl,3)
    figure;mimg(mfilt2(cond1n_dt_bl(:,28:68,i)-ave(:,28:68),100,100,1,'lm'),100,100,-1e-3,1e-3);colormap(mapgeog)
end

for i=1:size(cond2n_dt_bl,3)
    figure;mimg(mfilt2(cond2n_dt_bl(:,28:68,i)-ave(:,28:68),100,100,1,'lm'),100,100,-1e-3,1e-3);colormap(mapgeog)
end



for i=1:size(cond4n_dt_bl,3)
    figure;mimg(mfilt2(cond4n_dt_bl(:,28:28,i)-ave(:,28:28),100,100,1,'lm'),100,100,-1e-3,1e-3);colormap(mapgeog)
end

for i=1:size(cond5n_dt_bl,3)
    figure;mimg(mfilt2(cond5n_dt_bl(:,28:60,i)-ave(:,28:60),100,100,1,'lm'),100,100,-1e-3,1e-3);colormap(mapgeog)
end





%%

for i=1:111
    p(i)=signrank(diff_circle(i,[1:23 36 37]));
    p2(i)=signrank(diff_V2_circle(i,[1:23 36 37]));
end

t=find(p<0.05);
x(t)

t=find(p2<0.05);
x(t)














