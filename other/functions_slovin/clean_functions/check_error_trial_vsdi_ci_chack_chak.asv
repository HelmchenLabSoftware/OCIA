

load cond6n
load myrois2
v1=[roi_circle;roi_bg_in;roi_bg_out];
time=2:88;

for i=1:size(cond6n,3)
    figure;errorbar(mean(mean(cond6n(v1,time,:),1),3),2*std(mean(cond6n(v1,time,:),1),0,3))
    hold on
    plot(mean(cond6n(v1,time,i),1),'r');
    title(['trial # ',int2str(i)])
end

error_6=[];
cond6n_temp=cond6n(:,:,:);
blank=mean(cond6n_temp,3);
save blank blank
cond6n_dt_bl=cond6n_temp./repmat(blank,[1 1 size(cond6n_temp,3)]);
save cond6n_dt_bl cond6n_dt_bl
clear cond6n_dt_bl cond6n_temp cond6n




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



load cond3n
cond3n_dt_bl=cond3n./repmat(blank,[1 1 size(cond3n,3)]);
for i=1:size(cond3n_dt_bl,3)
    figure;errorbar(mean(mean(cond3n_dt_bl(v1,time,:),1),3),2*std(mean(cond3n_dt_bl(v1,time,:),1),0,3))
    hold on
    plot(mean(cond3n_dt_bl(v1,time,i),1),'r');
    title(['trial # ',int2str(i)])
end

error_3=[];
cond3n_dt_bl=cond3n_dt_bl(:,:,:); 
save cond3n_dt_bl cond3n_dt_bl
clear cond3n_dt_bl cond3n
  


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
