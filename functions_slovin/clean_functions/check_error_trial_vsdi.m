

load cond3n
load myrois
v1=[roi_circle;roi_bg_out];
time=2:120;

for i=1:size(cond3n,3)
    figure;errorbar(mean(mean(cond3n(v1,time,:),1),3),2*std(mean(cond3n(v1,time,:),1),0,3))
    hold on
    plot(mean(cond3n(v1,time,i),1),'r');
    title(['trial # ',int2str(i)])
end

error_3=[5];
cond3n_temp=cond3n(:,:,[1:4 6:31]);
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

error_1=[5 9 22 31];
cond1n_dt_bl=cond1n_dt_bl(:,:,[1:4 6:8 10:21 23:30 32]); 
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

error_2=[1 14 18 19 21 23];
cond2n_dt_bl=cond2n_dt_bl(:,:,[2:13 15:17 20 22 24:31]); 
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

error_4=[3 10 11];
cond4n_dt_bl=cond4n_dt_bl(:,:,[1 2 4:9 12:31]); 
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
  
error_5=[5 12 28 31];
cond5n_dt_bl=cond5n_dt_bl(:,:,[1:4 6:11 13:27 29 30]); 
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





