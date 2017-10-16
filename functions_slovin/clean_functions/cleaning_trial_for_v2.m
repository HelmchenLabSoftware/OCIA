






v1=roi;
v2=roi_circle;
time=2:100;

fg1=squeeze(mean(cond1n_dt_bl(v2,time,:),1)-mean(cond1n_dt_bl(v1,time,:),1));


for i=1:size(cond1n_dt_bl,3)
    figure;errorbar(mean(fg1,2),std(fg1,0,2))
    hold on
    plot(fg1(:,i),'r');
    title(['trial # ',int2str(i)])
end



fg4=squeeze(mean(cond4n_dt_bl(v2,time,:),1)-mean(cond4n_dt_bl(v1,time,:),1));

for i=1:size(cond4n_dt_bl,3)
    figure;errorbar(mean(fg4,2),std(fg4,0,2))
    hold on
    plot(fg4(:,i),'r');
    title(['trial # ',int2str(i)])
end



fg2=squeeze(mean(cond2n_dt_bl(v2,time,:),1)-mean(cond2n_dt_bl(v1,time,:),1));


for i=1:size(cond2n_dt_bl,3)
    figure;errorbar(mean(fg2,2),std(fg2,0,2))
    hold on
    plot(fg2(:,i),'r');
    title(['trial # ',int2str(i)])
end



fg5=squeeze(mean(cond5n_dt_bl(v2,time,:),1)-mean(cond5n_dt_bl(v1,time,:),1));

for i=1:size(cond5n_dt_bl,3)
    figure;errorbar(mean(fg5,2),std(fg5,0,2))
    hold on
    plot(fg5(:,i),'r');
    title(['trial # ',int2str(i)])
end




%%


v1=roi_V2_bg;
time=2:100;


for i=1:size(cond2n_dt_bl,3)
    figure;errorbar(mean(mean(cond2n_dt_bl(v1,time,:),1),3),0.5*std(mean(cond2n_dt_bl(v1,time,:),1),0,3))
    hold on
    plot(mean(cond2n_dt_bl(v1,time,i),1),'r');
    title(['trial # ',int2str(i)])
end



for i=1:size(cond5n_dt_bl,3)
    figure;errorbar(mean(mean(cond5n_dt_bl(v1,time,:),1),3),0.5*std(mean(cond5n_dt_bl(v1,time,:),1),0,3))
    hold on
    plot(mean(cond5n_dt_bl(v1,time,i),1),'r');
    title(['trial # ',int2str(i)])
end




for i=tr25
    figure;errorbar(mean(mean(cond2n_dt_bl(v1,time,tr25),1),3),0.5*std(mean(cond2n_dt_bl(v1,time,tr25),1),0,3))
    hold on
    plot(mean(cond2n_dt_bl(v1,time,i),1),'c');
    title(['trial # ',int2str(i)])
    errorbar(mean(mean(cond5n_dt_bl(v1,time,tr25),1),3),0.5*std(mean(cond5n_dt_bl(v1,time,tr25),1),0,3),'r')
    plot(mean(cond5n_dt_bl(v1,time,i),1),'m');
    title(['trial # ',int2str(i)])
end


for i=tr14
    figure;errorbar(mean(mean(cond1n_dt_bl(v1,time,:),1),3),0.5*std(mean(cond1n_dt_bl(v1,time,:),1),0,3))
    hold on
    plot(mean(cond1n_dt_bl(v1,time,i),1),'c');
    title(['trial # ',int2str(i)])
    errorbar(mean(mean(cond4n_dt_bl(v1,time,:),1),3),0.5*std(mean(cond4n_dt_bl(v1,time,:),1),0,3),'r')
    plot(mean(cond4n_dt_bl(v1,time,i),1),'m');
    title(['trial # ',int2str(i)])
end




for i=1:17
    figure
    plot(mean(cond2n_dt_bl(v1,time,i),1),'c');
    hold on
    plot(mean(cond5n_dt_bl(v1,time,i),1),'m');
    title(['trial # ',int2str(i)])
end


for i=1:16
    figure
    plot(mean(cond1n_dt_bl(v1,time,i),1),'c');
    hold on
    plot(mean(cond4n_dt_bl(v1,time,i),1),'m');
    title(['trial # ',int2str(i)])
end


