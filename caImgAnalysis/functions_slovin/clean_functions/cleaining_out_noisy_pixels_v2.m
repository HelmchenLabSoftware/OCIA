

cd F:\Data\VSDI\Contour_integration\sta_analysis_Yair_oct12\Contour_integration\monkey_smeagol\2010_12_22\session_d
th=0.6e-3;
load('cond1n_dt_bl.mat')
%load('cond2n_dt_bl.mat')
tot=cat(3,cond1n_dt_bl);
mymap = nanmean(nanstd(tot(:,43:53,:),0,3),2)<th;
mymap=reshape(mymap,100,100);
mymap=mymap';
%load('F:\Data\VSDI\Contour_integration\sta_analysis_Yair_oct12\Contour_integration\Monkey_legolas\Right_hemisphere\clean_pix_legolas.mat')
%load('F:\Data\VSDI\Contour_integration\sta_analysis_Yair_oct12\Contour_integration\monkey_tolkin\clean_pix_tolkin_v1.mat')
load('F:\Data\VSDI\Contour_integration\sta_analysis_Yair_oct12\Contour_integration\monkey_smeagol\clean_pix_smeagol.mat')
new_pix=mymap&pix;
save new_pix_v2 new_pix th
figure(100);imagesc(new_pix)
axis off
axis square

outline = choose_polygon(100);
save outline outline
