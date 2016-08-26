cd F:\Data\VSDI\figure_figure\tolkin\22june2011\e
load('myrois3.mat', 'thresh')
th=thresh;
%th=.7e-3; 
 
load('cond1n_dt_bl_no_eyemove.mat')
%load('cond2n_dt_bl.mat')
tot=cat(3,cond1n_dt_bl);
mymap = nanmean(nanstd(tot(:,43:53,:),0,3),2)<th;
mymap=reshape(mymap,100,100);
mymap=mymap';
load('F:\Data\VSDI\figure_figure\tolkin\06sep2011\c\clean_pix_tolkin.mat')
new_pix=mymap&pix;
save new_pix new_pix th
figure(100);imagesc(new_pix)
axis off
axis square

%outline = choose_polygon(100);
%save outline outline
