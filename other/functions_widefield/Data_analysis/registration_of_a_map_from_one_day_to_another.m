%%

y=smoothn(nanmean(tr_ave(:,:,13),3)-1,[5 5],'Gauss');
cd D:\intrinsic\20150520

load('reg_points.mat')
tform = cp2tform(movingPoints(:,:),fixedPoints(:,:), 'nonreflective similarity');
new_brain = reshape([ones(205,1)*(1:205),(1:205)'*ones(1,205)],205*205,2);
new_brain(:,3) = ones(205*205,1);
temp = round(new_brain*tform.tdata(1).Tinv);
out_image = zeros(205,205,3);
for i = 1:length(temp)
    if (temp(i,1)<=0 || temp(i,1) >size(y,2) || temp(i,2)<=0 || temp(i,2) >size(y,1))
        continue
    else
        out_image(new_brain(i,2),new_brain(i,1),:) = y(temp(i,2),temp(i,1),:);
    end
end
figure(100);imagesc(out_image(:,:,1),[-.25e-3 .9e-2]);colormap(mapgeog)

