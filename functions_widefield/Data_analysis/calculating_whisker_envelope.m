cd F:\whisker_data_wf\20151023\mouse_tgg6fl23_9\e
load('whiskAngle.mat')
%x=(1:size(whiskAngle,1))*0.002-3;  % 500 fps
x=(1:size(whiskAngle,1))*0.005-3;   % 200 fps
%win=25; % 500 fps 
win=10; % 200 fps 

k=0;
whisk_env=nan*ones(floor(size(whiskAngle,1)/win),size(whiskAngle,2));
x_env=nan*ones(floor(size(whiskAngle,1)/win),1);
for i=1:win:(size(whiskAngle,1)-win)
    k=k+1;
    x_env(k)=x(i);
    whisk_env(k,:)=max(whiskAngle(i:i+win-1,:),[],1)-min(whiskAngle(i:i+win-1,:),[],1);
end

whisk_env=whisk_env-repmat(nanmean(whisk_env(14:17,:),1),size(whisk_env,1),1);
figure;plot(x_env,nanmean(whisk_env,2))
xlim([-3 6])

save whisker_envelope whisk_env x_env
%%
cd D:\intrinsic\20151008\mouse_tgg6fl23_9\a\Matt_files
save whisker_envelope whisk_env x_env
%%
load('trials_ind.mat')
figure;errorbar(x_env,nanmean(whisk_env(:,tr_100),2),nanstd(whisk_env(:,tr_100),0,2)/sqrt(size(tr_100,2)))
hold on
errorbar(x_env,nanmean(whisk_env(:,tr_1200),2),nanstd(whisk_env(:,tr_1200),0,2)/sqrt(size(tr_1200,2)))
xlim([-3 6])
%ylim([-1 4])









