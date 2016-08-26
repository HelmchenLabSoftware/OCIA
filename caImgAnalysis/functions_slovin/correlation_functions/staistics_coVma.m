


time=45:50;
co=mean(a(roi_f2,time),2);
ma=mean(b(roi_f2,time),2);


figure
scatter(ma,co)
hold on
plot(-.5:0.01:0.9,-.5:0.01:0.9,'k')
xlim([-.3 0.5]);ylim([-.3 0.5]);


p = ranksum(co,ma)



r1=roi_f5;
r2=roi_f1;
co=mean(a(r1,time)-b(r1,time),2);
ma=mean(a(r2,time)-b(r2,time),2);

[n x1]=hist(co,-0.3:0.005:.3);

[m x2]=hist(ma,-0.3:0.005:.3);

p=max(max(find(m)),max(find(n)));

figure;bar(x1,[n;m]',1.5,'group');

p = ranksum(co,ma)






