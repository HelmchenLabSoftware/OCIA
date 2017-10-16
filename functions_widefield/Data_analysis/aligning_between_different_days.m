
cd D:\intrinsic\20150511
load('green_ds.mat')
g=green_ds;
cd D:\intrinsic\20150520
load('green_ds.mat')

cpselect(g, green_ds)
save reg_points_20150504 movingPoints fixedPoints

%%
cd D:\intrinsic\20150520

load('reg_points_20150504.mat')
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
figure;imagesc(out_image(:,:,1),[0 0.9]);colormap(gray)
figure;imagesc(green_ds,[0 0.9]);colormap(gray)

cd D:\intrinsic\20150520
save registration_transform_20150504 tform

%%
cd D:\intrinsic\20150511
load('steriotaxic_rois_registered.mat')
out_image = zeros(205,205,3);
for i = 1:length(temp)
    if (temp(i,1)<=0 || temp(i,1) >size(rois_st,2) || temp(i,2)<=0 || temp(i,2) >size(rois_st,1))
        continue
    else
        out_image(new_brain(i,2),new_brain(i,1),:) = rois_st(temp(i,2),temp(i,1),:);
    end
end
figure;imagesc(out_image(:,:,1),[0 26]);colormap(gray)
figure;imagesc(green_ds,[0 0.9]);colormap(gray)
hold on
contour(out_image(:,:,1),'c')

%cd D:\intrinsic\20150520
rois_st=out_image(:,:,1);
save steriotaxic_rois_registered rois_st list

%%
for i=1:size(list,1)
    t=find(rois_st==i);
    rois(i).name=list{i};
    rois(i).index=t;
end
cd D:\intrinsic\20150520
save rois_st_indexes rois   
%%

cd D:\intrinsic\20150511
load('rois.mat')
g=zeros(205,205);
g(roi_s1)=1;
g(roi_v1)=2;
g(roi_a1)=3;
g(roi_fl)=4;
g(roi_s2)=5;
g(roi_hl)=6;

cd D:\intrinsic\20150520
load registration_transform

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
figure;imagesc(out_image(:,:,1),[0 0.9]);colormap(gray)
figure;imagesc(green_ds,[0 0.9]);colormap(gray)
hold on
contour(out_image(:,:,1),'g')

hold on
hh=zeros(205,205);
hh(rois_st==5)=1;
hh(rois_st==6)=1;
contour(hh,'c')







