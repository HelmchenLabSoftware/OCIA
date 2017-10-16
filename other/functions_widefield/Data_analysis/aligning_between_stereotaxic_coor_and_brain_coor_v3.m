clear all
cd D:\intrinsic
load('steriotaxic_regions_v2.mat')
list=who;

ap_ax=3.52:-.1:-6.02;
ml_ax=-.2:0.01:5.5;
brain=zeros(size(ml_ax,2),size(ap_ax,2));



for j=1:size(list,1)
    t=eval(list{j});
    for i=1:size(t,1)
        x=find(round(ap_ax*10)/10==round(t(i,1)*10)/10);
        y1=find(round(ml_ax*100)/100'==round(t(i,2)*10)/10);
        y2=find(round(ml_ax*100)/100'==round(t(i,3)*10)/10);
        brain(y1:y2,x)=j;
        %brain(x,y2)=1;
    end
end


%figure;imagesc(ap_ax,ml_ax,brain,[0 26]);colormap(mapgeog)
figure;imagesc(brain,[0 26]);colormap(mapgeog)



%% 
cd D:\intrinsic\ruler_jan2016
load('resolution_vectors.mat')
%cd D:\intrinsic\ruler_nov2015


br=[67 55];

h=zeros(205,205);
for j=1:size(list,1)
    [r c]=find(brain==j);
    t=ml_ax(r);
    tt=ap_ax(c);
    coor=[t;tt];
    br_coor=[(res_vec_205-res_vec_205(br(2)));-(res_vec_205-res_vec_205(br(1)))];
    for i=1:size(coor,2)
        x=find(abs(coor(1,i)-br_coor(1,:))==min(abs(coor(1,i)-br_coor(1,:))));
        y=find(abs(coor(2,i)-br_coor(2,:))==min(abs(coor(2,i)-br_coor(2,:))));
        h(x,y)=j;
        h(x+1,y+1)=j;
        h(x+2,y+2)=j;
    end  
end

h(br(2),br(1))=50;
figure;imagesc(h,[0 26])
cd D:\intrinsic\20150511
save stero_coor_on_brain h list



%%

cd D:\intrinsic\20150511

load('rois.mat')
load('green_ds.mat')
g=green_ds;
% g(roi_s1)=1;
% g(roi_v1)=2;
g(roi_a1)=3;
g(roi_fl)=4;
% g(roi_s2)=5;
% g(roi_hl)=6;


% cpselect(h/26, g)
% save reg_points_for_st_coor movingPoints fixedPoints
% 

load('reg_points_for_st_coor.mat')
tform = cp2tform(movingPoints([1 2 3 4],:),fixedPoints([1 2 3 4],:), 'affine');
new_brain = reshape([ones(205,1)*(1:205),(1:205)'*ones(1,205)],205*205,2);
new_brain(:,3) = ones(205*205,1);
temp = round(new_brain*tform.tdata(1).Tinv);
out_image = zeros(205,205,3);
for i = 1:length(temp)
    if (temp(i,1)<=0 || temp(i,1) >size(h,2) || temp(i,2)<=0 || temp(i,2) >size(h,1))
        continue
    else
        out_image(new_brain(i,2),new_brain(i,1),:) = h(temp(i,2),temp(i,1),:);
    end
end
figure;imagesc(out_image(:,:,1),[0 26]);colormap(mapgeog)




figure;imagesc(g,[0 0.9]);colormap(gray)
hold on
contour(out_image(:,:,1),'g')
rois_st=out_image(:,:,1);
cd D:\intrinsic\20150511
save steriotaxic_rois_registered rois_st list




%% 
cd D:\intrinsic\ruler_jan2016
%cd D:\intrinsic\ruler_nov2015
load('resolution_vectors.mat')

br=[67 55];
k=0;
h2=zeros(205,205);
for j=[2 3 8 13]
    k=k+1;
    [r c]=find(brain==j);
    t=ml_ax(r);
    tt=ap_ax(c);
    coor=[t;tt];
    br_coor=[(res_vec_205-res_vec_205(br(2)));-(res_vec_205-res_vec_205(br(1)))];
    for i=1:size(coor,2)
        x=find(abs(coor(1,i)-br_coor(1,:))==min(abs(coor(1,i)-br_coor(1,:))));
        y=find(abs(coor(2,i)-br_coor(2,:))==min(abs(coor(2,i)-br_coor(2,:))));
        h2(x,y)=k;
        h2(x+1,y+1)=k;
        h2(x+2,y+2)=k;
    end  
end

h2(br(2),br(1))=5;
figure;imagesc(h2)


%%
out_image2 = zeros(205,205,3);
for i = 1:length(temp)
    if (temp(i,1)<=0 || temp(i,1) >size(h2,2) || temp(i,2)<=0 || temp(i,2) >size(h2,1))
        continue
    else
        out_image2(new_brain(i,2),new_brain(i,1),:) = h2(temp(i,2),temp(i,1),:);
    end
end
figure;imagesc(out_image2(:,:,1),[0 26]);colormap(mapgeog)


figure;imagesc(g,[0 0.9]);colormap(gray)
hold on
contour(out_image2(:,:,1),'r')
