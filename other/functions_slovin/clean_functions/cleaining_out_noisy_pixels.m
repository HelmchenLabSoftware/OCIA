

th=0.8e-3;
load('cond1n_dt_bl.mat')
load('cond2n_dt_bl.mat')
tot=cat(3,cond1n_dt_bl,cond2n_dt_bl);
mymap = nanmean(nanstd(tot(:,43:53,:),0,3),2)<th;
mymap=reshape(mymap,100,100);
mymap=mymap';
load imaged_pixels
new_pix=mymap&pix;
save new_pix new_pix
figure;imagesc(new_pix)
axis off
axis square


