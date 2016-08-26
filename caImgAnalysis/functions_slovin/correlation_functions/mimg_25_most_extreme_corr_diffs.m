
%% 1111c1245 contour2
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008
load pair_corr_contour5_1111cd
roi=roi_contour5;
h=zeros(10000,1);
h(roi)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi,1)
    for j=1:size(roi,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end

diff=cont-non;

tt=sort(diff);
[row col]=find((reshape(diff,size(roi,1),size(roi,1)))>=tt(end-50));
k=zeros(10000,1);
k(pixels_to_remove)=1;
figure;mimg(k,100,100,0,1);
h=zeros(10000,1);
h(roi)=1;
hold on
contour(reshape(h,100,100)','Color','w')
line([11 97],[29 40],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([16 94],[21 29],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
for i=1:size(col,1)
    line([rem(roi(row(i)),100) rem(roi(col(i)),100)],[ceil(roi(row(i))/100) ceil(roi(col(i))/100)],'Marker','.','LineStyle','-','LineWidth',1,'Color','r')    
end


%% 2511d15 bg in

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together\pixelwise
load pair_corr_bg_in4
roi=roi_bg_in4;
h=zeros(10000,1);
h(roi)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi,1)
    for j=1:size(roi,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end

diff=cont-non;

tt=sort(diff);
[row col]=find((reshape(diff,size(roi,1),size(roi,1)))<=tt(50));
k=zeros(10000,1);
k(pixels_to_remove)=1;
figure;mimg(k,100,100,0,1);
h=zeros(10000,1);
h(roi)=1;
hold on
contour(reshape(h,100,100)','Color','w')
line([14 92],[19 31],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([7 96],[31 46],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
text(100,46,'V1','FontSize',16)
text(100,35,'V2','FontSize',16)
text(96,22,'V4','FontSize',16)
for i=1:size(col,1)
    line([rem(roi(row(i)),100) rem(roi(col(i)),100)],[ceil(roi(row(i))/100) ceil(roi(col(i))/100)],'Marker','.','LineStyle','-','LineWidth',1,'Color','r')    
end


%% 2912c
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c\pixelwise
load pair_corr_circle4
roi=roi_circle4;
h=zeros(10000,1);
h(roi)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi,1)
    for j=1:size(roi,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end

diff=cont-non;

tt=sort(diff);
[row col]=find((reshape(diff,size(roi,1),size(roi,1)))>=tt(end-50));
k=zeros(10000,1);
k(pixels_to_remove)=1;
figure;mimg(k,100,100,0,1);
h=zeros(10000,1);
h(roi)=1;
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
    line([rem(roi(row(i)),100) rem(roi(col(i)),100)],[ceil(roi(row(i))/100) ceil(roi(col(i))/100)],'Marker','.','LineStyle','-','LineWidth',1,'Color','r')    
end


%% 2912e1245 bg out

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\e\pixelwise
load pair_corr_bg_out4
roi=roi_bg_out4;
h=zeros(10000,1);
h(roi)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi,1)
    for j=1:size(roi,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end

diff=cont-non;

tt=sort(diff);
[row col]=find((reshape(diff,size(roi,1),size(roi,1)))<=tt(50));
k=zeros(10000,1);
k(pixels_to_remove)=1;
figure;mimg(k,100,100,0,1);
h=zeros(10000,1);
h(roi)=1;
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
    line([rem(roi(row(i)),100) rem(roi(col(i)),100)],[ceil(roi(row(i))/100) ceil(roi(col(i))/100)],'Marker','.','LineStyle','-','LineWidth',1,'Color','r')    
end




















