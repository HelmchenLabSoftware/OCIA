
cont_distances_bg_bg=nan*ones(50,23);
non_distances_bg_bg=nan*ones(50,23);
diff_distances_bg_bg=nan*ones(50,23);

cont_distances_circ_circ=nan*ones(50,23);
non_distances_circ_circ=nan*ones(50,23);
diff_distances_circ_circ=nan*ones(50,23);

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008
load corr_bg_bg_as_a_function_of_distance_1111cd
cont_distances_bg_bg(1:size(dist_vec,2)-1,1:4)=dist_cont;
non_distances_bg_bg(1:size(dist_vec,2)-1,1:4)=dist_non;
diff_distances_bg_bg(1:size(dist_vec,2)-1,1:4)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec
load corr_circ_circ_as_a_function_of_distance_1111cd
cont_distances_circ_circ(1:size(dist_vec,2)-1,1:4)=dist_cont;
non_distances_circ_circ(1:size(dist_vec,2)-1,1:4)=dist_non;
diff_distances_circ_circ(1:size(dist_vec,2)-1,1:4)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\c\correct_and_incorrect_together\pixelwise
n=5;
load corr_bg_bg_as_a_function_of_distance
cont_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec
load corr_circ_circ_as_a_function_of_distance
cont_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\d\correct_and_incorrect_together\pixelwise
n=6;
load corr_bg_bg_as_a_function_of_distance
cont_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec
load corr_circ_circ_as_a_function_of_distance
cont_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\e\correct_and_incorrect_together\pixelwise
n=7;
load corr_bg_bg_as_a_function_of_distance
cont_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec
load corr_circ_circ_as_a_function_of_distance
cont_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together\pixelwise
n=8;
load corr_bg_bg_as_a_function_of_distance
cont_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec
load corr_circ_circ_as_a_function_of_distance
cont_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\e\correct_and_incorrect_together\pixelwise
n=9;
load corr_bg_bg_as_a_function_of_distance
cont_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec
load corr_circ_circ_as_a_function_of_distance
cont_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\f\correct_and_incorrect_together\pixelwise
n=10;
load corr_bg_bg_as_a_function_of_distance
cont_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec
load corr_circ_circ_as_a_function_of_distance
cont_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\d\correct_and_incorrect_together\pixelwise
n=11;
load corr_bg_bg_as_a_function_of_distance
cont_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec
load corr_circ_circ_as_a_function_of_distance
cont_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\e\correct_and_incorrect_together\pixelwise
n=12;
load corr_bg_bg_as_a_function_of_distance
cont_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec
load corr_circ_circ_as_a_function_of_distance
cont_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\f\correct_and_incorrect_together\pixelwise
n=13;
load corr_bg_bg_as_a_function_of_distance
cont_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec
load corr_circ_circ_as_a_function_of_distance
cont_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\h\pixelwise
n=14:15;
load corr_bg_bg_as_a_function_of_distance
cont_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec
load corr_circ_circ_as_a_function_of_distance
cont_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec



cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\e\pixelwise
n=16:17;
load corr_bg_bg_as_a_function_of_distance
cont_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec
load corr_circ_circ_as_a_function_of_distance
cont_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\f\pixelwise
n=18:19;
load corr_bg_bg_as_a_function_of_distance
cont_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec
load corr_circ_circ_as_a_function_of_distance
cont_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\d\pixelwise
n=20:21;
load corr_bg_bg_as_a_function_of_distance
cont_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec
load corr_circ_circ_as_a_function_of_distance
cont_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\e\pixelwise
n=22:23;
load corr_bg_bg_as_a_function_of_distance
cont_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_bg_bg(1:size(dist_vec,2)-1,n)=dist_diff;
clear dist_diff dist_cont dist_non dist_vec
load corr_circ_circ_as_a_function_of_distance
cont_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_cont;
non_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_non;
diff_distances_circ_circ(1:size(dist_vec,2)-1,n)=dist_diff;

distances=nan*ones(50,1);
distances(1:29)=dist_vec(2:30)*0.17;
clear dist_diff dist_cont dist_non dist_vec


%%

for i=1:50
    n1(i)=sum(~isnan(cont_distances_circ_circ(i,:)));
    n2(i)=sum(~isnan(non_distances_circ_circ(i,:)));
    n3(i)=sum(~isnan(cont_distances_bg_bg(i,:)));
    n4(i)=sum(~isnan(non_distances_bg_bg(i,:)));
end


figure;plot(distances,nanmean(cont_distances_circ_circ,2))
hold on
plot(distances,nanmean(non_distances_circ_circ,2),'r')
xlim([0 8])
ylim([0 0.4])
figure;plot(distances,nanmean(cont_distances_bg_bg,2))
hold on
plot(distances,nanmean(non_distances_bg_bg,2),'r')
xlim([0 8])
ylim([0 0.4])

figure;errorbar(distances,nanmean(diff_distances_circ_circ,2),nanstd(diff_distances_circ_circ,0,2)./sqrt(n1'))
hold on
errorbar(distances,nanmean(diff_distances_bg_bg,2),nanstd(diff_distances_bg_bg,0,2)./sqrt(n3'),'r')
plot(distances,zeros(1,50),'k')
xlim([0 8])
ylim([-0.05 0.05])


% anova1(diff_distances_circ_circ(1:20,:)')
% anova1(diff_distances_bg_bg(1:20,:)')
% 
% anova1(cont_distances_circ_circ(1:20,:)')
% anova1(cont_distances_bg_bg(1:20,:)')
%  
% anova1(non_distances_circ_circ(1:20,:)')
% anova1(non_distances_bg_bg(1:20,:)')
% 




