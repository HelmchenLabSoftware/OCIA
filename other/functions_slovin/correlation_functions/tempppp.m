

%% Figure 2
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008
load time_rois_for_fig2_ci_after_cleanning_BETTER_wo_drifts
load time_course_trials_wo_drifts

roi1=roi_contour5;
roi2=roi_maskin5;
time1=50:58;

% circ_vec=squeeze(cat(3,mean(cont_circ_tr(:,time1,:),2),mean(non_circ_tr(:,time1,:),2)));
% for i=1:100
%     t=randperm(size(circ_vec,2));
%     diff_shuffle=mean(circ_vec(:,t(1:size(cont_circ_tr,3))),2)-mean(circ_vec(:,t(size(cont_circ_tr,3)+1:end)),2);
%     top(i) = prctile(diff_shuffle,99);
%     bottom(i) = prctile(diff_shuffle,1);
% end
% top_circ=mean(top);
% bottom_circ=mean(bottom);
% 
% bg_vec=squeeze(cat(3,mean(cont_bg_tr(:,time1,:),2),mean(non_bg_tr(:,time1,:),2)));
% for i=1:100
%     t=randperm(size(bg_vec,2));
%     diff_shuffle=mean(bg_vec(:,t(1:size(cont_bg_tr,3))),2)-mean(bg_vec(:,t(size(cont_bg_tr,3)+1:end)),2);
%     top(i) = prctile(diff_shuffle,99);
%     bottom(i) = prctile(diff_shuffle,1);
% end
% top_bg=mean(top);
% bottom_bg=mean(bottom);
% 
% figure;
% scatter(mean(non(roi1,time1),2)-1,mean(con(roi1,time1),2)-1)
% hold on
% plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
% plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_circ,'r')
% plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_circ,'r')
% xlim([0 2e-3]);ylim([0 2e-3])
% axis square
% ranksum(mean(non(roi1,time1),2)-1,mean(con(roi1,time1),2)-1)
% 
% figure;
% scatter(mean(non(roi2,time1),2)-1,mean(con(roi2,time1),2)-1)
% hold on
% plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
% plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_bg,'r')
% plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_bg,'r')
% xlim([0 2e-3]);ylim([0 2e-3])
% axis square
% ranksum(mean(non(roi2,time1),2)-1,mean(con(roi2,time1),2)-1)
% 
% 
% 
% 






time=34:36;
circ_vec=squeeze(cat(3,mean(cont_circ_tr(:,time,:),2),mean(non_circ_tr(:,time,:),2)));
for i=1:100
    t=randperm(size(circ_vec,2));
    diff_shuffle=mean(circ_vec(:,t(1:size(cont_circ_tr,3))),2)-mean(circ_vec(:,t(size(cont_circ_tr,3)+1:end)),2);
    top(i) = prctile(diff_shuffle,99);
    bottom(i) = prctile(diff_shuffle,1);
end
top_circ=mean(top);
bottom_circ=mean(bottom);

bg_vec=squeeze(cat(3,mean(cont_bg_tr(:,time,:),2),mean(non_bg_tr(:,time,:),2)));
for i=1:100
    t=randperm(size(bg_vec,2));
    diff_shuffle=mean(bg_vec(:,t(1:size(cont_bg_tr,3))),2)-mean(bg_vec(:,t(size(cont_bg_tr,3)+1:end)),2);
    top(i) = prctile(diff_shuffle,99);
    bottom(i) = prctile(diff_shuffle,1);
end
top_bg=mean(top);
bottom_bg=mean(bottom);

figure;
scatter(mean(mean(non_circ_tr(:,time,:),3),2)-1,mean(mean(cont_circ_tr(:,time,:),3),2)-1)
hold on
plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_circ,'r')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_circ,'r')
xlim([0 2e-3]);ylim([0 2e-3])
axis square

figure;
scatter(mean(mean(non_bg_tr(:,time,:),3),2)-1,mean(mean(cont_bg_tr(:,time,:),3),2)-1)
hold on
plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_bg,'r')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_bg,'r')
xlim([0 2e-3]);ylim([0 2e-3])
axis square

diff_circ=mean(mean(cont_circ_tr(:,time,:),3)-mean(non_circ_tr(:,time,:),3),2);
sum(diff_circ>top_circ)/size(diff_circ,1)
sum(diff_circ<bottom_circ)/size(diff_circ,1)

diff_bg=mean(mean(cont_bg_tr(:,time,:),3)-mean(non_bg_tr(:,time,:),3),2);
sum(diff_bg>top_bg)/size(diff_bg,1)
sum(diff_bg<bottom_bg)/size(diff_bg,1)






