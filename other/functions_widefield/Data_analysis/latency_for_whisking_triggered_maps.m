cd D:\intrinsic\20150617\a\Matt_files
load('stim_whisk_trig_ave.mat')
xt=(1:51)*0.05-0.5;

d=reshape(amp_trig_ave-1,205*205,size(amp_trig_ave,3));
dn=d./repmat(max(d,[],2),1,size(d,2));

pix=find(nanmean(d(:,18:22),2)>0.75e-2);
lat=nan*ones(size(d,1),1);
for i=pix'
    disp(i)
    l=find(dn(i,:)>0.34, 1, 'first')-1;
    if l>10
        lat(i)=xt(l)+(0.34-dn(i,l))*(xt(l+1)-xt(l))/(dn(i,l+1)-dn(i,l));
    end
end
figure;imagesc(reshape(lat,205,205));colormap(mapgeog)
% roi_m2 = choose_polygon_imagesc(205);
% roi_rs = choose_polygon_imagesc(205);
% roi_s1 = choose_polygon_imagesc(205);
% roi_sc = choose_polygon_imagesc(205);
% roi_ic = choose_polygon_imagesc(205);
% 
figure;histogram(lat(roi_m2))
hold on
histogram(lat(roi_s1))
%histogram(lat(roi_rs))
histogram(lat(roi_sc))
histogram(lat(roi_ic))



%%
cd D:\intrinsic\20150617\mouse_tgg6fl23_4\a\Matt_files
load('stim_whisk_trig_ave.mat')
xt=(1:31)*0.05-0.5;

d=reshape(amp_trig_ave-1,205*205,size(amp_trig_ave,3));
dn=d./repmat(max(d,[],2),1,size(d,2));

pix=find(nanmean(d(:,18:22),2)>1.1e-2);
lat=nan*ones(size(d,1),1);
for i=pix'
    disp(i)
    l=find(dn(i,:)>0.34, 1, 'first')-1;
    if l>10
        lat(i)=xt(l)+(0.34-dn(i,l))*(xt(l+1)-xt(l))/(dn(i,l+1)-dn(i,l));
    end
end
figure;imagesc(reshape(lat,205,205));colormap(mapgeog)
% roi_m2 = choose_polygon_imagesc(205);
% roi_rs = choose_polygon_imagesc(205);
% roi_s1 = choose_polygon_imagesc(205);
% roi_sc = choose_polygon_imagesc(205);
% roi_ic = choose_polygon_imagesc(205);
% 
% figure;histogram(lat(roi_m2))
% hold on
% histogram(lat(roi_s1))
% %histogram(lat(roi_rs))
% histogram(lat(roi_sc))
% histogram(lat(roi_ic))
% 









