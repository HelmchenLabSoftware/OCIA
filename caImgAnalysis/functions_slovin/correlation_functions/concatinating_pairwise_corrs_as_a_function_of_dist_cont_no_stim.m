
cont_distances=nan*ones(50,23);
non_distances=nan*ones(50,23);

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new
load corr_circ_circ_as_a_function_of_distance_1111cd_no_stim
cont_distances(1:size(dist_vec,2),1:4)=dist_cont;
non_distances(1:size(dist_vec,2),1:4)=dist_non;
clear dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\c\correct_and_incorrect_together\no_stim\pixelwise
n=5;
load corr_circ_circ_as_a_function_of_distance
cont_distances(1:size(dist_vec,2),n)=dist_cont;
non_distances(1:size(dist_vec,2),n)=dist_non;
clear dist_cont dist_non dist_vec


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\d\correct_and_incorrect_together\no_stim\pixelwise
n=6;
load corr_circ_circ_as_a_function_of_distance
cont_distances(1:size(dist_vec,2),n)=dist_cont;
non_distances(1:size(dist_vec,2),n)=dist_non;
clear dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\e\correct_and_incorrect_together\no_stim\pixelwise
n=7;
load corr_circ_circ_as_a_function_of_distance
cont_distances(1:size(dist_vec,2),n)=dist_cont;
non_distances(1:size(dist_vec,2),n)=dist_non;
clear dist_cont dist_non dist_vec


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together\no_stim\pixelwise
n=8;
load corr_circ_circ_as_a_function_of_distance
cont_distances(1:size(dist_vec,2),n)=dist_cont;
non_distances(1:size(dist_vec,2),n)=dist_non;
clear dist_cont dist_non dist_vec


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\e\correct_and_incorrect_together\no_stim\pixelwise
n=9;
load corr_circ_circ_as_a_function_of_distance
cont_distances(1:size(dist_vec,2),n)=dist_cont;
non_distances(1:size(dist_vec,2),n)=dist_non;
clear dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\f\correct_and_incorrect_together\no_stim\pixelwise
n=10;
load corr_circ_circ_as_a_function_of_distance
cont_distances(1:size(dist_vec,2),n)=dist_cont;
non_distances(1:size(dist_vec,2),n)=dist_non;
clear dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\d\correct_and_incorrect_together\no_stim\pixelwise
n=11;
load corr_circ_circ_as_a_function_of_distance
cont_distances(1:size(dist_vec,2),n)=dist_cont;
non_distances(1:size(dist_vec,2),n)=dist_non;
clear dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\e\correct_and_incorrect_together\no_stim\pixelwise
n=12;
load corr_circ_circ_as_a_function_of_distance
cont_distances(1:size(dist_vec,2),n)=dist_cont;
non_distances(1:size(dist_vec,2),n)=dist_non;
clear dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\f\correct_and_incorrect_together\no_stim\pixelwise
n=13;
load corr_circ_circ_as_a_function_of_distance
cont_distances(1:size(dist_vec,2),n)=dist_cont;
non_distances(1:size(dist_vec,2),n)=dist_non;
clear dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\h\no_stim\pixelwise
n=14:15;
load corr_circ_circ_as_a_function_of_distance
cont_distances(1:size(dist_vec,2),n)=dist_cont;
non_distances(1:size(dist_vec,2),n)=dist_non;
clear dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\e\no_stim\pixelwise
n=16:17;
load corr_circ_circ_as_a_function_of_distance
cont_distances(1:size(dist_vec,2),n)=dist_cont;
non_distances(1:size(dist_vec,2),n)=dist_non;
clear dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\f\no_stim\pixelwise
n=18:19;
load corr_circ_circ_as_a_function_of_distance
cont_distances(1:size(dist_vec,2),n)=dist_cont;
non_distances(1:size(dist_vec,2),n)=dist_non;
clear dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\d\no_stim\pixelwise
n=20:21;
load corr_circ_circ_as_a_function_of_distance
cont_distances(1:size(dist_vec,2),n)=dist_cont;
non_distances(1:size(dist_vec,2),n)=dist_non;
clear dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\e\no_stim\pixelwise
n=22:23;
load corr_circ_circ_as_a_function_of_distance
cont_distances(1:size(dist_vec,2),n)=dist_cont;
non_distances(1:size(dist_vec,2),n)=dist_non;
distances=nan*ones(50,1);
distances(1:39)=dist_vec;
clear dist_cont dist_non dist_vec

%%

for i=1:50
    n(i)=sum(~isnan(cont_distances(i,:)));
end

 
figure;errorbar(distances,nanmean(cont_distances,2),nanstd(cont_distances,0,2)./sqrt(n'))
hold on
errorbar(distances,nanmean(non_distances,2),nanstd(non_distances,0,2)./sqrt(n'),'r')
plot(distances,zeros(1,50),'k')
xlim([0 8])
%ylim([-0.02 0.04])

anova1(cont_distances(1:18,:)')
anova1(non_distances(1:18,:)')

