green_ds=smoothn(nanmean(tr_ave(:,:,28),3)-1,[3 3],'Gauss');
%green_ds=smoothn(nanmean(tr_ave(:,:,15),3)-1,[3 3],'Gauss');
%green_ds=smoothn(nanmean(tr_ave(:,:,148:158),3)-1,[3 3],'Gauss');
%green_ds=smoothn(nanmean(tr_ave(:,:,14:15),3)-1,[3 3],'Gauss');
%green_ds=smoothn(nanmean(tr_ave(:,:,13),3)-1,[3 3],'Gauss');
cd D:\intrinsic\ruler_nov2015
%load('resolution_vectors.mat')

br=[67 55];
mid=[121 48];
al=abs(atand((mid(2)-br(2))/(mid(1)-br(1))));        
%figure;imagesc(res_vec_205-res_vec_205(br(1)),res_vec_205-res_vec_205(br(2)),green_ds,[-.5e-2 1.5e-2]);colormap(mapgeog)
       

mat_rot=nan*ones(size(green_ds,1),size(green_ds,2));
for i=1:size(green_ds,1)
    for j=1:size(green_ds,2)
        new=round([i-br(2) j-br(1)]*[cosd(al) -sind(al);sind(al) cosd(al)])+fliplr(br);
        if new(1)>205||new(1)<-205
            new(1)=nan;
        else
            if new(1)<=0
                new(1)=size(green_ds,1)+new(1)+1;
            end
        end
        if new(2)>205||new(2)<-205
            new(2)=nan;
        else
            if new(2)<=0
                new(2)=size(green_ds,1)+new(2)+1;
            end
        end
        if sum(isnan(new))==0
            mat_rot(new(1),new(2))=green_ds(i,j); 
        end
    end
end

%figure;imagesc((res_vec_205-res_vec_205(br(1))),res_vec_205-res_vec_205(br(2)),mat_rot,[-.5e-2 2.5e-2]);colormap(mapgeog)

figure;imagesc(mat_rot,[-.5e-2 3e-2]);colormap(mapgeog)

