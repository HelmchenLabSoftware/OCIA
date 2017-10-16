


g=zeros(10000,1);
g(roi_contour2)=1;
g([roi_f1late;roi_tar;roi_f2])=2;
bet_cont=find(g==1);

mean(mean(a([roi_f1late;roi_tar;roi_f2],49:51),2))-1
mean(mean(a(bet_cont,49:51),2))-1

ranksum(mean(a([roi_f1late;roi_tar;roi_f2],49:51),2),mean(a(bet_cont,49:51),2))

figure;hist(mean(a([roi_f1late;roi_tar;roi_f2],49:51)-1,2))
figure;hist(mean(a(bet_cont,49:51)-1,2))


g=zeros(10000,1);
g(roi_maskin)=1;
g([roi_f3;roi_f4;roi_f5])=2;
bet_bg=find(g==1);


mean(mean(a([roi_f3;roi_f4;roi_f5],49:51),2))-1;
mean(mean(a(bet_bg,49:51),2))-1;


diff=a-b;

mean(mean(diff([roi_f1late;roi_tar;roi_f2],49:51),2))
mean(mean(diff(bet_cont,49:51),2))

mean(mean(diff([roi_f3;roi_f4;roi_f5],49:51),2))
mean(mean(diff(bet_bg,49:51),2))

ranksum(mean(diff([roi_f1late;roi_tar;roi_f2],49:51),2),mean(diff(bet_cont,49:51),2))
ranksum(mean(diff([roi_f1late;roi_tar;roi_f2],49:51),2),mean(diff(bet_cont,49:51),2))




h=zeros(10000,1);
h(roi_contour2)=mean(diff(roi_contour2,34:36),2);
figure;surf(reshape(h,100,100)')










