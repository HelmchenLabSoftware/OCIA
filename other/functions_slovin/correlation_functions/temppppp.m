cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008
load time_course_trials_wo_drifts
time=34:36;
it=1000;
diff_circ=mean(mean(cont_circ_tr(:,time,:),2),3)-mean(mean(non_circ_tr(:,time,:),2),3);
circ_vec=squeeze(cat(3,mean(cont_circ_tr(:,time,:),2),mean(non_circ_tr(:,time,:),2)));
diff_shuffle=zeros(size(circ_vec,1),it);
for i=1:it
    t=randperm(size(circ_vec,2));
    diff_shuffle(:,i)=mean(circ_vec(:,t(1:size(cont_circ_tr,3))),2)-mean(circ_vec(:,t(size(cont_circ_tr,3)+1:end)),2);
end
top_circ=mean(reshape(diff_shuffle,1,it*size(circ_vec,1)))+2*std(reshape(diff_shuffle,1,it*size(circ_vec,1)));
bottom_circ=mean(reshape(diff_shuffle,1,it*size(circ_vec,1)))-2*std(reshape(diff_shuffle,1,it*size(circ_vec,1)));

figure;
scatter(mean(mean(non_circ_tr(:,time,:),3),2)-1,mean(mean(cont_circ_tr(:,time,:),3),2)-1)
hold on
plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_circ,'r')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_circ,'r')
xlim([0 2e-3]);ylim([0 2e-3])
axis square

[n1 x1]=hist(diff_circ,-1e-3:.5e-4:1e-3);
[n2 x2]=hist(reshape(diff_shuffle,1,it*size(circ_vec,1)),-1e-3:.5e-4:1e-3);
figure;bar(x1,[n1/size(diff_circ,1);n2/(it*size(circ_vec,1))]')

sum(diff_circ>top_circ)/size(diff_circ,1)
sum(diff_circ<bottom_circ)/size(diff_circ,1)


diff_bg=mean(mean(cont_bg_tr(:,time,:),2),3)-mean(mean(non_bg_tr(:,time,:),2),3);
bg_vec=squeeze(cat(3,mean(cont_bg_tr(:,time,:),2),mean(non_bg_tr(:,time,:),2)));
diff_shuffle=zeros(size(bg_vec,1),it);
for i=1:it
    t=randperm(size(bg_vec,2));
    diff_shuffle(:,i)=mean(bg_vec(:,t(1:size(cont_bg_tr,3))),2)-mean(bg_vec(:,t(size(cont_bg_tr,3)+1:end)),2);
end
top_bg=mean(reshape(diff_shuffle,1,it*size(bg_vec,1)))+2*std(reshape(diff_shuffle,1,it*size(bg_vec,1)));
bottom_bg=mean(reshape(diff_shuffle,1,it*size(bg_vec,1)))-2*std(reshape(diff_shuffle,1,it*size(bg_vec,1)));

figure;
scatter(mean(mean(non_bg_tr(:,time,:),3),2)-1,mean(mean(cont_bg_tr(:,time,:),3),2)-1)
hold on
plot(0:0.0001:3e-3,0:0.0001:3e-3,'k')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+top_bg,'r')
plot((0:0.0001:3e-3),(0:0.0001:3e-3)+bottom_bg,'r')
xlim([0 2e-3]);ylim([0 2e-3])
axis square

[n1 x1]=hist(diff_bg,-1e-3:.5e-4:1e-3);
[n2 x2]=hist(reshape(diff_shuffle,1,it*size(bg_vec,1)),-1e-3:.5e-4:1e-3);
figure;bar(x1,[n1/size(diff_bg,1);n2/(it*size(bg_vec,1))]')

sum(diff_bg>top_bg)/size(diff_bg,1)
sum(diff_bg<bottom_bg)/size(diff_bg,1)

