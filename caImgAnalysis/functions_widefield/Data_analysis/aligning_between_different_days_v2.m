cd D:\intrinsic\20150520
load('blue_ds.mat')
g=green_ds;

cd D:\intrinsic\20150617\a
load('green_ds.mat')

cpselect(g*6, green_ds*6)

save reg_points_20150520 movingPoints fixedPoints

%%
cd D:\intrinsic\20150617\a

load('reg_points_20150520.mat')
tform = cp2tform(movingPoints(:,:),fixedPoints(:,:), 'nonreflective similarity');
new_brain = reshape([ones(205,1)*(1:205),(1:205)'*ones(1,205)],205*205,2);
new_brain(:,3) = ones(205*205,1);
temp = round(new_brain*tform.tdata(1).Tinv);
out_image = zeros(205,205,3);
for i = 1:length(temp)
    if (temp(i,1)<=0 || temp(i,1) >size(g,2) || temp(i,2)<=0 || temp(i,2) >size(g,1))
        continue
    else
        out_image(new_brain(i,2),new_brain(i,1),:) = g(temp(i,2),temp(i,1),:);
    end
end
figure;imagesc(out_image(:,:,1),[0 0.1]);colormap(gray)
figure;imagesc(green_ds,[0 0.1]);colormap(gray)

cd D:\intrinsic\20150617\a
save registration_transform_20150520 tform


%%

cd D:\intrinsic\20150520
load('rois_combined.mat')
g=zeros(205,205);
g(roi_s1)=1;
g(roi_v1)=2;
g(roi_a1)=3;
g(roi_fl)=4;
g(roi_s2)=5;
g(roi_hl)=6;
g(roi_m1)=7;
g(roi_m2)=8;
g(roi_m2_med)=9;
g(roi_sc)=10;
g(roi_ic)=11;
g(roi_ppc)=12;
g(mid2(1),mid1(1))=13;
g(mid2(2),mid1(2))=14;

cd D:\intrinsic\20150617\a
load registration_transform_20150520

new_brain = reshape([ones(205,1)*(1:205),(1:205)'*ones(1,205)],205*205,2);
new_brain(:,3) = ones(205*205,1);
temp = round(new_brain*tform.tdata(1).Tinv);
out_image = zeros(205,205,3);
for i = 1:length(temp)
    if (temp(i,1)<=0 || temp(i,1) >size(g,2) || temp(i,2)<=0 || temp(i,2) >size(g,1))
        continue
    else
        out_image(new_brain(i,2),new_brain(i,1),:) = g(temp(i,2),temp(i,1),:);
    end
end
figure;imagesc(out_image(:,:,1),[0 15]);colormap(gray)
figure;imagesc(green_ds,[0 0.1]);colormap(gray)
hold on
contour(out_image(:,:,1),'g')




roi_s1=find(out_image(:,:,1)==1);
roi_v1=find(out_image(:,:,1)==2);
roi_a1=find(out_image(:,:,1)==3);
roi_fl=find(out_image(:,:,1)==4);
roi_s2=find(out_image(:,:,1)==5);
roi_hl=find(out_image(:,:,1)==6);
roi_m1=find(out_image(:,:,1)==7);
roi_m2=find(out_image(:,:,1)==8);
roi_m2_med=find(out_image(:,:,1)==9);
roi_sc=find(out_image(:,:,1)==10);
roi_ic=find(out_image(:,:,1)==11);
roi_ppc=find(out_image(:,:,1)==12);




