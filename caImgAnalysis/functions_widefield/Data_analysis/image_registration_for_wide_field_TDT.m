
cd D:\intrinsic\20150520
unregistered = imread('map_ref.png');
figure, imshow(orthophoto)
cd D:\intrinsic\20150511
orthophoto = imread('map_rois.png');
figure, imshow(unregistered)

cpselect(unregistered, orthophoto)

mytform = fitgeotrans(movingPoints, fixedPoints, 'affine');
registered = imwarp(unregistered, mytform);



figure;imshow(orthophoto)
figure;imshow(registered)




cd D:\intrinsic
unregistered2 = imread('br_st.png');
cd D:\intrinsic\20150511
orthophoto = imread('map_rois.png');
figure; imshow(unregistered2)
figure; imshow(orthophoto)

cpselect(unregistered2, orthophoto)
mytform = fitgeotrans(movingPoints, fixedPoints, 'affine');
registered2 = imwarp(unregistered2, mytform);
figure;imshow(orthophoto)
figure;imshow(registered2)






cd D:\intrinsic
unregistered2 = imread('br_st.png');
cd D:\intrinsic\20150511
orthophoto = imread('map_rois.png');
figure; imshow(unregistered2)
figure; imshow(orthophoto)


%%
cd D:\intrinsic\20150511
load('rois.mat')
load('green_ds.mat')
g=green_ds;
g(roi_s1)=1;
g(roi_v1)=2;
g(roi_a1)=3;
g(roi_fl)=3;
plotting_stereotaxic_corrdinates_on_template


cpselect(downsample(brain,5)/26, g)
mytform = fitgeotrans(movingPoints, fixedPoints, 'affine');
registered2 = imwarp(downsample(brain,5)/26, mytform);
figure;imagesc(g)
figure;imagesc(registered2)

%%
cd D:\intrinsic\20150511
load('rois.mat')
load('green_ds.mat')
g=green_ds;
g(roi_s1)=1;
g(roi_v1)=2;
g(roi_a1)=3;
g(roi_fl)=3;
plotting_stereotaxic_corrdinates_on_template


cpselect(h, g)
mytform = fitgeotrans(movingPoints, fixedPoints, 'affine');
registered2 = imwarp(h, mytform);
figure;imagesc(g);colormap(gray)
figure;imagesc(registered2)
figure;imagesc(circshift(circshift(registered2,6,1),-8,2));

%%

cpselect(green_ds, g)
mytform = fitgeotrans(movingPoints, fixedPoints, 'affine');
registered2 = imwarp(green_ds, mytform);
figure;imagesc(g);colormap(gray)
figure;imagesc(circshift(registered2,-17,1));colormap(gray)
%figure;imagesc(registered2);colormap(gray)
%figure;imagesc(circshift(circshift(registered2,-13,1),-6,2));colormap(gray)



aa=smoothn(cond_100_ave(:,:,47)-1,[5 5],'Gauss');
aa=smoothn(cond_100_ave(:,:,18)-1,[5 5],'Gauss');  
aa=smoothn(nanmean(cond_100_ave(:,:,100:140)-cond_1200_ave(:,:,100:140),3),[5 5],'Gauss');
aa=smoothn(nanmean(cond_100_ave(:,:,66)-cond_1200_ave(:,:,66),3),[5 5],'Gauss');

aa(isnan(aa))=0;
registered3 = imwarp(aa, mytform);
figure;imagesc(circshift(registered3,-17,1),[-1e-2 12.5e-2]);colormap(mapgeog)
%figure;imagesc(circshift(circshift(registered3,-13,1),-6,2),[-1e-2 2e-2]);colormap(mapgeog)
%figure;imagesc(registered3,[-1e-2 1.5e-2]);colormap(mapgeog)





%%
cd D:\intrinsic\20150511
load('rois.mat')
load('green_ds.mat')
g=green_ds;
g(roi_s1)=1;
g(roi_v1)=2;
g(roi_a1)=3;
g(roi_fl)=4;
g(roi_s2)=5;
g(roi_hl)=6;
plotting_stereotaxic_corrdinates_on_template


cpselect(h, g)
mytform = fitgeotrans(movingPoints([1 3],:), fixedPoints([1 3],:), 'nonreflectivesimilarity');
registered2 = imwarp(h, mytform);
registered3 = imwarp(g, mytform);
figure;imagesc(g,[0 0.9]);colormap(gray)
figure;imagesc(registered2,[0 0.9]);colormap(gray)
figure;imagesc(registered3,[0 0.9]);colormap(gray)
hold on
contour(registered2,'k')




tform = cp2tform([p1;p2],[xb(1),yb(1);xb(2),yb(2)],'nonreflective similarity');
tform = cp2tform(movingPoints([1 3 8],:),fixedPoints([1 3 8],:), 'nonreflective similarity')
new_brain = reshape([ones(205,1)*(1:205),(1:205)'*ones(1,205)],205*205,2);
new_brain(:,3) = ones(205*205,1);
temp = round(new_brain*tform.tdata(1).Tinv);

% figure;imagesc(reshape(temp(:,3),205,205),[0 0.9]);colormap(gray)
% registered4 = imwarp(h, tform);
out_image = zeros(205,205,3);
for i = 1:length(temp)
    if (temp(i,1)<=0 || temp(i,1) >size(h,2) || temp(i,2)<=0 || temp(i,2) >size(h,1))
        continue
    else
        out_image(new_brain(i,2),new_brain(i,1),:) = h(temp(i,2),temp(i,1),:);
    end
end
figure;imagesc(out_image(:,:,1),[0 0.9]);colormap(gray)


tformLocalWeightedMean = images.geotrans.LocalWeightedMeanTransformation2D(movingPoints,fixedPoints,6);





tform = cp2tform(movingPoints([1:12],:),fixedPoints([1:12],:), 'lwm',12)
[B,xdata,ydata] = imtransform(h,tform,'XData',[1 205],'YData',[1 205]);
figure;imagesc(B,[0 0.9]);colormap(gray)




%%


tform2 = cp2tform(movingPoints2(:,:),fixedPoints2(:,:), 'nonreflective similarity')
new_brain = reshape([ones(205,1)*(1:205),(1:205)'*ones(1,205)],205*205,2);
new_brain(:,3) = ones(205*205,1);
temp = round(new_brain*tform2.tdata(1).Tinv);

% figure;imagesc(reshape(temp(:,3),205,205),[0 0.9]);colormap(gray)
% registered4 = imwarp(h, tform);
out_image2 = zeros(205,205,3);
for i = 1:length(temp)
    if (temp(i,1)<=0 || temp(i,1) >size(aa,2) || temp(i,2)<=0 || temp(i,2) >size(aa,1))
        continue
    else
        out_image2(new_brain(i,2),new_brain(i,1),:) = aa(temp(i,2),temp(i,1),:);
    end
end
figure;imagesc(out_image2(:,:,1),[-.5e-2 2e-2]);colormap(mapgeog)
