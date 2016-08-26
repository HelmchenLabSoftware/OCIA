

load blank
load myrois
v1=[roi_circle;roi_bg_out];
time=2:80;


load cond1n_error
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

load cond2n_error
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

    
load cond4n_error
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


load cond5n_error
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



load cond6n
cond6n_dt_bl=cond6n./repmat(blank,[1 1 size(cond6n,3)]);
for i=1:size(cond6n_dt_bl,3)
    figure;errorbar(mean(mean(cond6n_dt_bl(v1,time,:),1),3),2*std(mean(cond6n_dt_bl(v1,time,:),1),0,3))
    hold on
    plot(mean(cond6n_dt_bl(v1,time,i),1),'r');
    title(['trial # ',int2str(i)])
end    
  
error_6=[8 36];
cond6n_dt_bl=cond6n_dt_bl(:,:,[1:7 9:35 37:40]); 
save cond6n_dt_bl cond6n_dt_bl
clear cond6n_dt_bl cond6n





