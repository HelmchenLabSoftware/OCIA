cd F:\Data\VSDI\figure_figure\Smeagol_left\06June2012\d
load('myrois3.mat', 'thresh')
%thresh=1e-3;
load('cond1n_dt_bl_no_eyemove.mat')
%load('cond2n_dt_bl.mat')
tot=cat(3,cond1n_dt_bl);
mymap = nanmean(nanstd(tot(:,43:53,:),0,3),2)<thresh;
mymap=reshape(mymap,100,100);
mymap=mymap';
load('F:\Data\VSDI\figure_figure\Smeagol_left\15Aug2012\d\clean_pix_smeg.mat')
%load('F:\Data\VSDI\figure_figure\Smeagol_left\16May2012\clean_pix_smeg.mat')
%load('F:\Data\VSDI\figure_figure\Smeagol_left\22May2012\clean_pix_smeg.mat')

new_pix=mymap&pix;
save new_pix new_pix thresh
figure(100);imagesc(new_pix)
axis off
axis square

%outline = choose_polygon(100);
%save outline outline
