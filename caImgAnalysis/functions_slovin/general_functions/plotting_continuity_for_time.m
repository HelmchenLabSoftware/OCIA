
line_real_circ(line_real_circ==1)=0.25e-3;
line_real_circ(line_real_circ==0)=-0.25e-3;
line_real_bg(line_real_bg==1)=0.25e-3;
line_real_bg(line_real_bg==0)=-0.25e-3;

x=(10:10:2560)-280;
for i=28:68
    figure;plot(mean(mean(barline_bg(:,:,i),2),3),'r');
    ylim([-1e-3 2e-3])
    hold on
    plot(zeros(1,size(barline_bg,1)),'k')
    plot(line_real_bg,'k')
    title(['time ',int2str(x(i)),' ms'])
end




for i=28:73
    figure;plot(mean(mean(barline_circ(:,:,i),2),3),'r');
    ylim([-1e-3 2e-3])
    hold on
    plot(zeros(1,size(barline_circ,1)),'k')
    plot(line_real_circ,'k')
    title(['time ',int2str(x(i)),' ms'])
end





x=(10:10:2560)-280;
for i=28:68
    figure;plot(mean(mean(barline_circ(:,:,i),2),3),'b');
    ylim([-1e-3 2e-3])
    hold on
    plot(mean(mean(barline_bg(:,:,i),2),3),'r');
    plot(zeros(1,size(barline_bg,1)),'k')
    plot(line_real_bg+0.75e-3,'r')
    plot(line_real_circ+0.75e-3,'b')
    title(['time ',int2str(x(i)),' ms'])
end




%%

line_real_circ(line_real_circ==1)=0.25e-3;
line_real_circ(line_real_circ==0)=-0.25e-3;
line_real_bg(line_real_bg==1)=0.25e-3;
line_real_bg(line_real_bg==0)=-0.25e-3;


x=(10:10:2560)-280;
for i=20:63
    figure;plot(mean(mean(circ_plane_2511(:,i,:),2),3),'r');
    ylim([-1e-3 1e-3])
    hold on
    plot(zeros(1,size(circ_plane_2511,1)),'k')
    plot(line_real_circ,'k')
    title(['time ',int2str(x(i)),' ms'])
end

for i=10:63
    figure;plot(mean(mean(bg_plane_2511(:,i,:),2),3),'r');
    ylim([-1e-3 1e-3])
    hold on
    plot(zeros(1,size(bg_plane_2511,1)),'k')
    plot(line_real_bg,'k')
    title(['time ',int2str(x(i)),' ms'])
end







