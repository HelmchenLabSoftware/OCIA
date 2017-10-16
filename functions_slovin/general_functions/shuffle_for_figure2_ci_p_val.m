cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008
load time_course_trials_wo_drifts
time=50:58;
it=1000;
diff_circ=mean(mean(cont_circ_tr(:,time,:),2),3)-mean(mean(non_circ_tr(:,time,:),2),3);
circ_vec=squeeze(cat(3,mean(cont_circ_tr(:,time,:),2),mean(non_circ_tr(:,time,:),2)));
diff_shuffle_circ=zeros(size(circ_vec,1),it);
diff_bg=mean(mean(cont_bg_tr(:,time,:),2),3)-mean(mean(non_bg_tr(:,time,:),2),3);
bg_vec=squeeze(cat(3,mean(cont_bg_tr(:,time,:),2),mean(non_bg_tr(:,time,:),2)));
diff_shuffle_bg=zeros(size(bg_vec,1),it);
for i=1:it
    t=randperm(size(circ_vec,2));
    diff_shuffle_circ(:,i)=mean(circ_vec(:,t(1:size(cont_circ_tr,3))),2)-mean(circ_vec(:,t(size(cont_circ_tr,3)+1:end)),2);
    diff_shuffle_bg(:,i)=mean(bg_vec(:,t(1:size(cont_bg_tr,3))),2)-mean(bg_vec(:,t(size(cont_bg_tr,3)+1:end)),2);
end

dp_shuff=(mean(diff_shuffle_circ,1)-mean(diff_shuffle_bg,1))./((std(diff_shuffle_circ,0,1)+std(diff_shuffle_bg,0,1))/2);
figure;hist(dp_shuff)
dp=(mean(diff_circ,1)-mean(diff_bg,1))./((std(diff_circ,0,1)+std(diff_bg,0,1))/2);
sum(dp<dp_shuff)/it
dp
mean(dp_shuff)


time=34:36;
it=1000;
diff_circ=mean(mean(cont_circ_tr(:,time,:),2),3)-mean(mean(non_circ_tr(:,time,:),2),3);
circ_vec=squeeze(cat(3,mean(cont_circ_tr(:,time,:),2),mean(non_circ_tr(:,time,:),2)));
diff_shuffle_circ=zeros(size(circ_vec,1),it);
diff_bg=mean(mean(cont_bg_tr(:,time,:),2),3)-mean(mean(non_bg_tr(:,time,:),2),3);
bg_vec=squeeze(cat(3,mean(cont_bg_tr(:,time,:),2),mean(non_bg_tr(:,time,:),2)));
diff_shuffle_bg=zeros(size(bg_vec,1),it);
for i=1:it
    t=randperm(size(circ_vec,2));
    diff_shuffle_circ(:,i)=mean(circ_vec(:,t(1:size(cont_circ_tr,3))),2)-mean(circ_vec(:,t(size(cont_circ_tr,3)+1:end)),2);
    diff_shuffle_bg(:,i)=mean(bg_vec(:,t(1:size(cont_bg_tr,3))),2)-mean(bg_vec(:,t(size(cont_bg_tr,3)+1:end)),2);
end

dp_shuff=(mean(diff_shuffle_circ,1)-mean(diff_shuffle_bg,1))./((std(diff_shuffle_circ,0,1)+std(diff_shuffle_bg,0,1))/2);
figure;hist(dp_shuff)
dp=(mean(diff_circ,1)-mean(diff_bg,1))./((std(diff_circ,0,1)+std(diff_bg,0,1))/2);
sum(dp<dp_shuff)/it
dp
mean(dp_shuff)



