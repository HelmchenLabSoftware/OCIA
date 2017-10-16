

load cond3n
load myrois3
v1=[roi_top_clean;roi_bottom_clean];
time=2:88;

for i=1:size(cond3n,3)
    figure;errorbar(mean(mean(cond3n(v1,time,:),1),3),2*std(mean(cond3n(v1,time,:),1),0,3))
    hold on
    plot(mean(cond3n(v1,time,i),1),'r');
    title(['trial # ',int2str(i)])
end

error_3=[];
cond3n_temp=cond3n(:,:,:);
blank=mean(cond3n_temp,3);
save blank blank
cond3n_dt_bl=cond3n_temp./repmat(blank,[1 1 size(cond3n_temp,3)]);
save cond3n_dt_bl cond3n_dt_bl
clear cond3n_dt_bl cond3n_temp cond3n


load cond1n
cond1n_dt_bl=cond1n./repmat(blank,[1 1 size(cond1n,3)]);
for i=1:size(cond1n_dt_bl,3)
    figure;errorbar(mean(mean(cond1n_dt_bl(v1,time,:),1),3),2*std(mean(cond1n_dt_bl(v1,time,:),1),0,3))
    hold on
    plot(mean(cond1n_dt_bl(v1,time,i),1),'r');
    title(['trial # ',int2str(i)])
end

error_1=[];
cond1n_dt_bl=cond1n_dt_bl(:,:,:); 
save cond1n_dt_bl cond1n_dt_bl
clear cond1n_dt_bl cond1n

load cond2n
cond2n_dt_bl=cond2n./repmat(blank,[1 1 size(cond2n,3)]);
for i=1:size(cond2n_dt_bl,3)
    figure;errorbar(mean(mean(cond2n_dt_bl(v1,time,:),1),3),2*std(mean(cond2n_dt_bl(v1,time,:),1),0,3))
    hold on
    plot(mean(cond2n_dt_bl(v1,time,i),1),'r');
    title(['trial # ',int2str(i)])
end

error_2=[];
cond2n_dt_bl=cond2n_dt_bl(:,:,:); 
save cond2n_dt_bl cond2n_dt_bl
clear cond2n_dt_bl cond2n

    
load cond4n
cond4n_dt_bl=cond4n./repmat(blank,[1 1 size(cond4n,3)]);
for i=1:size(cond4n_dt_bl,3)
    figure;errorbar(mean(mean(cond4n_dt_bl(v1,time,:),1),3),2*std(mean(cond4n_dt_bl(v1,time,:),1),0,3))
    hold on
    plot(mean(cond4n_dt_bl(v1,time,i),1),'r');
    title(['trial # ',int2str(i)])
end    

error_4=[];
cond4n_dt_bl=cond4n_dt_bl(:,:,:); 
save cond4n_dt_bl cond4n_dt_bl
clear cond4n_dt_bl cond4n


load cond5n
cond5n_dt_bl=cond5n./repmat(blank,[1 1 size(cond5n,3)]);
for i=1:size(cond5n_dt_bl,3)
    figure;errorbar(mean(mean(cond5n_dt_bl(v1,time,:),1),3),2*std(mean(cond5n_dt_bl(v1,time,:),1),0,3))
    hold on
    plot(mean(cond5n_dt_bl(v1,time,i),1),'r');
    title(['trial # ',int2str(i)])
end    
  
error_5=[];
cond5n_dt_bl=cond5n_dt_bl(:,:,:); 
save cond5n_dt_bl cond5n_dt_bl
clear cond5n_dt_bl cond5n


save noisytrials error*




