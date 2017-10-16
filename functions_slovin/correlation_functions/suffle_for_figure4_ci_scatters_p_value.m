
%% 1111
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\
load corr_for_shuffle_p_val_fig4
time=32:34;
it=100;

diff_bg=mean(mean(cont_bg_tr(:,time,:),2),3)-mean(mean(non_bg_tr(:,time,:),2),3);
bg_vec=squeeze(cat(3,mean(cont_bg_tr(:,time,:),2),mean(non_bg_tr(:,time,:),2)));
diff_circ=mean(mean(cont_circ_tr(:,time,:),2),3)-mean(mean(non_circ_tr(:,time,:),2),3);
circ_vec=squeeze(cat(3,mean(cont_circ_tr(:,time,:),2),mean(non_circ_tr(:,time,:),2)));
diff_shuffle_bg=zeros(size(bg_vec,1),it);
diff_shuffle_circ=zeros(size(circ_vec,1),it);
for i=1:it
    t=randperm(size(bg_vec,2));
    diff_shuffle_bg(:,i)=mean(bg_vec(:,t(1:size(cont_bg_tr,3))),2)-mean(bg_vec(:,t(size(cont_bg_tr,3)+1:end)),2);
    diff_shuffle_circ(:,i)=mean(circ_vec(:,t(1:size(cont_circ_tr,3))),2)-mean(circ_vec(:,t(size(cont_circ_tr,3)+1:end)),2);
end

sum(mean(diff_shuffle_bg,1)<mean(diff_bg))/100;
sum(mean(diff_shuffle_circ,1)<mean(diff_circ))/100;


dp_shuff=(mean(diff_shuffle_circ,1)-mean(diff_shuffle_bg,1))./((std(diff_shuffle_circ,0,1)+std(diff_shuffle_bg,0,1))/2);
figure;hist(dp_shuff)
dp=(mean(diff_circ,1)-mean(diff_bg,1))./((std(diff_circ,0,1)+std(diff_bg,0,1))/2);
sum(dp<dp_shuff)/it
mean(dp_shuff)

%% 2511
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together
load corr_for_shuffle_p_val_fig4
time=28:33;
it=100;

diff_bg=mean(mean(cont_bg_tr(:,time,:),2),3)-mean(mean(non_bg_tr(:,time,:),2),3);
bg_vec=squeeze(cat(3,mean(cont_bg_tr(:,time,:),2),mean(non_bg_tr(:,time,:),2)));
diff_circ=mean(mean(cont_circ_tr(:,time,:),2),3)-mean(mean(non_circ_tr(:,time,:),2),3);
circ_vec=squeeze(cat(3,mean(cont_circ_tr(:,time,:),2),mean(non_circ_tr(:,time,:),2)));
diff_shuffle_bg=zeros(size(bg_vec,1),it);
diff_shuffle_circ=zeros(size(circ_vec,1),it);
for i=1:it
    t=randperm(size(bg_vec,2));
    diff_shuffle_bg(:,i)=mean(bg_vec(:,t(1:size(cont_bg_tr,3))),2)-mean(bg_vec(:,t(size(cont_bg_tr,3)+1:end)),2);
    diff_shuffle_circ(:,i)=mean(circ_vec(:,t(1:size(cont_circ_tr,3))),2)-mean(circ_vec(:,t(size(cont_circ_tr,3)+1:end)),2);
end

sum(mean(diff_shuffle_bg,1)<mean(diff_bg))/100;
sum(mean(diff_shuffle_circ,1)<mean(diff_circ))/100;


dp_shuff=(mean(diff_shuffle_circ,1)-mean(diff_shuffle_bg,1))./((std(diff_shuffle_circ,0,1)+std(diff_shuffle_bg,0,1))/2);
figure;hist(dp_shuff)
dp=(mean(diff_circ,1)-mean(diff_bg,1))./((std(diff_circ,0,1)+std(diff_bg,0,1))/2);
sum(dp<dp_shuff)/it
dp
mean(dp_shuff)


%% 2912c
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c
load corr_for_shuffle_p_val_fig4
time=26:27;
it=100;

diff_bg=mean(mean(cont_bg_tr(:,time,:),2),3)-mean(mean(non_bg_tr(:,time,:),2),3);
bg_vec=squeeze(cat(3,mean(cont_bg_tr(:,time,:),2),mean(non_bg_tr(:,time,:),2)));
diff_circ=mean(mean(cont_circ_tr(:,time,:),2),3)-mean(mean(non_circ_tr(:,time,:),2),3);
circ_vec=squeeze(cat(3,mean(cont_circ_tr(:,time,:),2),mean(non_circ_tr(:,time,:),2)));
diff_shuffle_bg=zeros(size(bg_vec,1),it);
diff_shuffle_circ=zeros(size(circ_vec,1),it);
for i=1:it
    t=randperm(size(bg_vec,2));
    diff_shuffle_bg(:,i)=mean(bg_vec(:,t(1:size(cont_bg_tr,3))),2)-mean(bg_vec(:,t(size(cont_bg_tr,3)+1:end)),2);
    diff_shuffle_circ(:,i)=mean(circ_vec(:,t(1:size(cont_circ_tr,3))),2)-mean(circ_vec(:,t(size(cont_circ_tr,3)+1:end)),2);
end

sum(mean(diff_shuffle_bg,1)<mean(diff_bg))/100;
sum(mean(diff_shuffle_circ,1)<mean(diff_circ))/100;


dp_shuff=(mean(diff_shuffle_circ,1)-mean(diff_shuffle_bg,1))./((std(diff_shuffle_circ,0,1)+std(diff_shuffle_bg,0,1))/2);
figure;hist(dp_shuff)
dp=(mean(diff_circ,1)-mean(diff_bg,1))./((std(diff_circ,0,1)+std(diff_bg,0,1))/2);
sum(dp<dp_shuff)/it
dp
mean(dp_shuff)



%% 2912c
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\e
load corr_for_shuffle_p_val_fig4
time=34:36;
it=100;

diff_bg=mean(mean(cont_bg_tr(:,time,:),2),3)-mean(mean(non_bg_tr(:,time,:),2),3);
bg_vec=squeeze(cat(3,mean(cont_bg_tr(:,time,:),2),mean(non_bg_tr(:,time,:),2)));
diff_circ=mean(mean(cont_circ_tr(:,time,:),2),3)-mean(mean(non_circ_tr(:,time,:),2),3);
circ_vec=squeeze(cat(3,mean(cont_circ_tr(:,time,:),2),mean(non_circ_tr(:,time,:),2)));
diff_shuffle_bg=zeros(size(bg_vec,1),it);
diff_shuffle_circ=zeros(size(circ_vec,1),it);
for i=1:it
    t=randperm(size(bg_vec,2));
    diff_shuffle_bg(:,i)=mean(bg_vec(:,t(1:size(cont_bg_tr,3))),2)-mean(bg_vec(:,t(size(cont_bg_tr,3)+1:end)),2);
    diff_shuffle_circ(:,i)=mean(circ_vec(:,t(1:size(cont_circ_tr,3))),2)-mean(circ_vec(:,t(size(cont_circ_tr,3)+1:end)),2);
end

sum(mean(diff_shuffle_bg,1)<mean(diff_bg))/100;
sum(mean(diff_shuffle_circ,1)<mean(diff_circ))/100;


dp_shuff=(mean(diff_shuffle_circ,1)-mean(diff_shuffle_bg,1))./((std(diff_shuffle_circ,0,1)+std(diff_shuffle_bg,0,1))/2);
figure;hist(dp_shuff)
dp=(mean(diff_circ,1)-mean(diff_bg,1))./((std(diff_circ,0,1)+std(diff_bg,0,1))/2);
sum(dp<dp_shuff)/it
dp
mean(dp_shuff)
