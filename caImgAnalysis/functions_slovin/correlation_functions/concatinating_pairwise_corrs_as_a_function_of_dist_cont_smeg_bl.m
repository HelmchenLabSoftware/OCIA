
diff_distances_bl=nan*ones(50,22);

cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\b\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),1)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\c\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),2)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\g\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),3)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\b\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),4)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\d\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),5)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\f\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),6)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\b\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),7)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\c\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),8)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\d\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),9)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\e\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),10)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\b\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),11)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\c\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),12)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\d\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),13)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\b\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),14)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),15)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\d\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),16)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\e\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),17)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\k\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),18)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\b\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),19)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\c\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),20)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\d\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),21)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\e\pixelwise
load corr_between_rois_bl
diff_distances_bl(1:size(dist_vec,2),22)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec


%%
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\d\pixelwise
load corr_bg_bg_as_a_function_of_distance
distances=nan*ones(1,50);
distances(1:size(dist_vec,2))=dist_vec;
clear dist_diff dist_cont dist_non dist_vec

for i=1:50
    n(i)=sum(~isnan(diff_distances_bl(i,:)));
end


figure;errorbar(distances,nanmean(diff_distances_bl,2),nanstd(diff_distances_bl,0,2)./sqrt(n'))
hold on
plot(distances,zeros(1,50),'k')
xlim([0 8])
%ylim([-0.02 0.04])

anova1(diff_distances_bl(1:13,:)')





