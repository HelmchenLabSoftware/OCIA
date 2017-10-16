
%% 1111c1245 contour2

h=zeros(10000,1);
h(roi_contour2)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_contour2,1)
    for j=1:size(roi_contour2,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end


[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));
diff=reshape(con-non,1,size(dist_mat,1)*size(dist_mat,1));
figure;plot(diff(dist_ind))

u=unique(d_sort);
for i=1:size(u,2)
    ddd(i)=mean(diff(d_sort==u(i)));
end

con1=reshape(con,1,size(dist_mat,1)*size(dist_mat,1));
non1=reshape(non,1,size(dist_mat,1)*size(dist_mat,1));
for i=1:size(u,2)
    dddc(i)=mean(con1(d_sort==u(i)));
    dddn(i)=mean(non1(d_sort==u(i)));
end

k=-50;
for j=1:22
k=k+50;
    us(j)=mean(u(j+k:j+k+50));
    ddds(j)=mean(ddd(j+k:j+k+50));
    dddcs(j)=mean(dddc(j+k:j+k+50));
    dddns(j)=mean(dddn(j+k:j+k+50));
end
figure;plot(us,ddds)
figure;plot(us,dddcs)
hold on
plot(us,dddns,'r')


[n1 x1]=hist(con1,0.2:0.05:0.8);
[n2 x2]=hist(non1,0.2:0.05:0.8);
figure;bar(x1,[n1/size(con1,2);n2/size(non1,2)]')
ranksum(con1,non1)
mean(con1)
mean(non1)

[n1 x1]=hist(con1-non1,-0.5:0.01:0.6);
figure;bar(x1,n1/size(con1,2))
xlim([-.3 .3])

l=prctile(reshape(con-non,782*782,1),99.99);
[row col]=find((con-non)>l);
k=zeros(10000,1);
k(pixels_to_remove)=1;
figure;mimg(k,100,100,0,1);
h=zeros(10000,1);
h(roi_contour2)=1;
hold on
contour(reshape(h,100,100)','Color','w')
line([11 97],[29 40],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([16 94],[21 29],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
for i=1:size(col,1)
    line([rem(roi_contour2(row(i)),100) rem(roi_contour2(col(i)),100)],[ceil(roi_contour2(row(i))/100) ceil(roi_contour2(col(i))/100)],'Marker','.','LineStyle','-','LineWidth',1,'Color','r')    
end
%% 1111c1245 maskin

h=zeros(10000,1);
h(roi_maskin)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_maskin,1)
    for j=1:size(roi_maskin,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end


[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));
diff=reshape(con-non,1,size(dist_mat,1)*size(dist_mat,1));
figure;plot(diff(dist_ind))

u=unique(d_sort);
for i=1:size(u,2)
    ddd(i)=mean(diff(d_sort==u(i)));
end

con1=reshape(con,1,size(dist_mat,1)*size(dist_mat,1));
non1=reshape(non,1,size(dist_mat,1)*size(dist_mat,1));
for i=1:size(u,2)
    dddc(i)=mean(con1(d_sort==u(i)));
    dddn(i)=mean(non1(d_sort==u(i)));
end


k=-50;
for j=1:25
k=k+50;
    us(j)=mean(u(j+k:j+k+50));
    ddds(j)=mean(ddd(j+k:j+k+50));
    dddcs(j)=mean(dddc(j+k:j+k+50));
    dddns(j)=mean(dddn(j+k:j+k+50));
end
figure;plot(us,ddds)
figure;plot(us,dddcs)
hold on
plot(us,dddns,'r')


[n1 x1]=hist(con1,-0.5:0.05:0.8);
[n2 x2]=hist(non1,-0.5:0.05:0.8);
figure;bar(x1,[n1/size(con1,2);n2/size(non1,2)]')


%% 2511d15 bg in

h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end


[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));
diff=reshape(con-non,1,size(dist_mat,1)*size(dist_mat,1));
figure;plot(diff(dist_ind))

u=unique(d_sort);
for i=1:size(u,2)
    ddd(i)=mean(diff(d_sort==u(i)));
end

con1=reshape(con,1,size(dist_mat,1)*size(dist_mat,1));
non1=reshape(non,1,size(dist_mat,1)*size(dist_mat,1));
for i=1:size(u,2)
    dddc(i)=mean(con1(d_sort==u(i)));
    dddn(i)=mean(non1(d_sort==u(i)));
end


k=-50;
for j=1:16
k=k+50;
    us(j)=mean(u(j+k:j+k+50));
    ddds(j)=mean(ddd(j+k:j+k+50));
    dddcs(j)=mean(dddc(j+k:j+k+50));
    dddns(j)=mean(dddn(j+k:j+k+50));
end
figure;plot(us,ddds)
figure;plot(us,dddcs)
hold on
plot(us,dddns,'r')


[n1 x1]=hist(con1,-0.5:0.05:0.8);
[n2 x2]=hist(non1,-0.5:0.05:0.8);
figure;bar(x1,[n1/size(con1,2);n2/size(non1,2)]')


[n1 x1]=hist(con1-non1,-0.5:0.01:0.6);
figure;bar(x1,n1/size(con1,2))
xlim([-.3 .3])

l=prctile(reshape(con-non,1072*1072,1),0.005);
[row col]=find((con-non)<l);
k=zeros(10000,1);
k(pixels_to_remove)=1;
figure;mimg(k,100,100,0,1);
h=zeros(10000,1);
h(roi_bg_in_fig5)=1;
hold on
contour(reshape(h,100,100)','Color','w')
line([14 92],[19 31],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([7 96],[31 46],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
for i=1:size(col,1)
    line([rem(roi_bg_in(row(i)),100) rem(roi_bg_in(col(i)),100)],[ceil(roi_bg_in(row(i))/100) ceil(roi_bg_in(col(i))/100)],'Marker','.','LineStyle','-','LineWidth',1,'Color','r')    
end

%% 2912c1245

h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end


[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));
diff=reshape(con-non,1,size(dist_mat,1)*size(dist_mat,1));
figure;plot(diff(dist_ind))

u=unique(d_sort);
for i=1:size(u,2)
    ddd(i)=mean(diff(d_sort==u(i)));
end

con1=reshape(con,1,size(dist_mat,1)*size(dist_mat,1));
non1=reshape(non,1,size(dist_mat,1)*size(dist_mat,1));
for i=1:size(u,2)
    dddc(i)=mean(con1(d_sort==u(i)));
    dddn(i)=mean(non1(d_sort==u(i)));
end


k=-50;
for j=1:9
k=k+50;
    us(j)=mean(u(j+k:j+k+50));
    ddds(j)=mean(ddd(j+k:j+k+50));
    dddcs(j)=mean(dddc(j+k:j+k+50));
    dddns(j)=mean(dddn(j+k:j+k+50));
end
figure;plot(us,ddds)
figure;plot(us,dddcs)
hold on
plot(us,dddns,'r')


[n1 x1]=hist(con1,-0.5:0.04:0.8);
[n2 x2]=hist(non1,-0.5:0.04:0.8);
figure;bar(x1,[n1/size(con1,2);n2/size(non1,2)]')
xlim([-.2 .7])

[n1 x1]=hist(con1-non1,-0.5:0.01:0.6);
figure;bar(x1,n1/size(con1,2))
xlim([-.3 .3])

l=prctile(reshape(con-non,537*537,1),99.985);
[row col]=find((con-non)>l);
k=zeros(10000,1);
k(pixels_to_remove)=1;
figure;mimg(k,100,100,0,1);
h=zeros(10000,1);
h(roi_circle)=1;
hold on
contour(reshape(h,100,100)','Color','w')
line([1 72],[40 41],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([72 94],[41 30],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([1 65],[50 52],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([65 96],[52 43],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')   
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
for i=1:size(col,1)
    line([rem(roi_circle(row(i)),100) rem(roi_circle(col(i)),100)],[ceil(roi_circle(row(i))/100) ceil(roi_circle(col(i))/100)],'Marker','.','LineStyle','-','LineWidth',1,'Color','r')    
end


%% 2912e1245

h=zeros(10000,1);
h(roi_bg_out)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_out,1)
    for j=1:size(roi_bg_out,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end


[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));
diff=reshape(con-non,1,size(dist_mat,1)*size(dist_mat,1));
figure;plot(diff(dist_ind))

u=unique(d_sort);
for i=1:size(u,2)
    ddd(i)=mean(diff(d_sort==u(i)));
end

con1=reshape(con,1,size(dist_mat,1)*size(dist_mat,1));
non1=reshape(non,1,size(dist_mat,1)*size(dist_mat,1));
for i=1:size(u,2)
    dddc(i)=mean(con1(d_sort==u(i)));
    dddn(i)=mean(non1(d_sort==u(i)));
end


k=-50;
for j=1:17
k=k+50;
    us(j)=mean(u(j+k:j+k+50));
    ddds(j)=mean(ddd(j+k:j+k+50));
    dddcs(j)=mean(dddc(j+k:j+k+50));
    dddns(j)=mean(dddn(j+k:j+k+50));
end
figure;plot(us,ddds)
figure;plot(us,dddcs)
hold on
plot(us,dddns,'r')


[n1 x1]=hist(con1,-0.5:0.05:0.8);
[n2 x2]=hist(non1,-0.5:0.05:0.8);
figure;bar(x1,[n1/size(con1,2);n2/size(non1,2)]')
xlim([-.2 .6])
ylim([0 .3])

[n1 x1]=hist(con1-non1,-0.5:0.01:0.6);
figure;bar(x1,n1/size(con1,2))
xlim([-.3 .3])

l=prctile(reshape(con-non,916*916,1),0.006);
[row col]=find((con-non)<l);
k=zeros(10000,1);
k(pixels_to_remove)=1;
figure;mimg(k,100,100,0,1);
h=zeros(10000,1);
h(roi_bg_out)=1;
hold on
contour(reshape(h,100,100)','Color','w')
line([1 72],[40 41],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([72 94],[41 30],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([1 65],[50 52],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([65 96],[52 43],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')   
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
for i=1:size(col,1)
    line([rem(roi_bg_out(row(i)),100) rem(roi_bg_out(col(i)),100)],[ceil(roi_bg_out(row(i))/100) ceil(roi_bg_out(col(i))/100)],'Marker','.','LineStyle','-','LineWidth',1,'Color','r')    
end



























