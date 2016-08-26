
diff_distances_bl=nan*ones(50,16);

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),1)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\d\elhanan_new\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),2)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\c\correct_and_incorrect_together\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),3)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\d\correct_and_incorrect_together\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),4)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\e\correct_and_incorrect_together\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),5)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),6)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\e\correct_and_incorrect_together\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),7)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\f\correct_and_incorrect_together\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),8)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\d\correct_and_incorrect_together\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),9)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\e\correct_and_incorrect_together\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),10)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\f\correct_and_incorrect_together\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),11)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec



cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\h\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),12)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\e\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),13)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\f\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),14)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\d\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),15)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\e\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),16)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\f\pixelwise
load corr_between_rois_bl
distances=nan*ones(50,1);
distances(1:38)=dist_vec;
clear dist_diff dist_vec


%%

for i=1:50
    n(i)=sum(~isnan(diff_distances_bl(i,:)));
end

% figure;errorbar(distances,nanmean(diff_distances_bl(:,[1 3 6 9 13 15]),2),nanstd(diff_distances_bl(:,[1 3 6 9 13 15]),0,2)./sqrt(6))
% hold on
% plot(distances,zeros(1,50),'k')
% anova1(diff_distances_bl(1:18,[1 3 6 9 13 15])')
% xlim([0 8])
% 

figure;errorbar(distances,nanmean(diff_distances_bl,2),nanstd(diff_distances_bl,0,2)./sqrt(n'))
hold on
plot(distances,zeros(1,50),'k')
xlim([0 8])
%ylim([-0.02 0.04])

anova1(diff_distances_bl(1:13,:)')





