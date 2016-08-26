


circ_plane(:,1)=mean(barline_circ_1111c14,2);
circ_plane(:,2)=mean(barline_circ_1111c25,2);
circ_plane(:,3)=mean(barline_circ_1111d14,2);
circ_plane(:,4)=mean(barline_circ_1111d25,2);

bg_plane(:,1)=mean(barline_bg_1111c14,2);
bg_plane(:,2)=mean(barline_bg_1111c25,2);
bg_plane(:,3)=mean(barline_bg_1111d14,2);
bg_plane(:,4)=mean(barline_bg_1111d25,2);


% circ_plane_n=mean(circ_plane,2);
% circ_plane_n=circ_plane_n-min(circ_plane_n);
% circ_plane_n=circ_plane_n/max(circ_plane_n);
% bg_plane_n=mean(bg_plane,2);
% bg_plane_n=bg_plane_n-min(bg_plane_n);
% bg_plane_n=bg_plane_n/max(bg_plane_n);



line_real_circ(line_real_circ==1)=max(mean(circ_plane,2));
line_real_circ(line_real_circ==0)=min(mean(circ_plane,2));
line_real_bg(line_real_bg==1)=max(mean(bg_plane,2));
line_real_bg(line_real_bg==0)=min(mean(bg_plane,2));


figure;plot(mean(circ_plane,2))
hold on
plot(line_real_circ,'r')

figure;plot(mean(bg_plane,2))
hold on
plot(line_real_bg,'r')

figure;plot(circ_plane)
hold on
plot(line_real_circ,'r')

figure;plot(bg_plane)
hold on
plot(line_real_bg,'r')





figure;plot(mean(circ_plane(:,3:4),2))
hold on
plot(line_real_circ,'r')
plot(zeros(1,size(line_real_circ,2)),'k')

figure;plot(mean(bg_plane(:,1:2),2))
hold on
plot(line_real_bg,'r')
plot(zeros(1,size(line_real_bg,2)),'k')





%% per time frame

circ_plane_1111cd(:,:,1)=mean(barline_circ_1111c14,2);
circ_plane_1111cd(:,:,2)=mean(barline_circ_1111c25,2);
circ_plane_1111cd(:,:,3)=mean(barline_circ_1111d14,2);
circ_plane_1111cd(:,:,4)=mean(barline_circ_1111d25,2);

bg_plane_1111cd(:,:,1)=mean(barline_bg_1111c14,2);
bg_plane_1111cd(:,:,2)=mean(barline_bg_1111c25,2);
bg_plane_1111cd(:,:,3)=mean(barline_bg_1111d14,2);
bg_plane_1111cd(:,:,4)=mean(barline_bg_1111d25,2);



circ_plane_2511(:,:,1)=mean(barline_circ_2511d,2);
circ_plane_2511(:,:,2)=mean(barline_circ_2511e,2);
circ_plane_2511(:,:,3)=mean(barline_circ_2511f,2);

bg_plane_2511(:,:,1)=mean(barline_bg_2511d,2);
bg_plane_2511(:,:,2)=mean(barline_bg_2511e,2);
bg_plane_2511(:,:,3)=mean(barline_bg_2511f,2);








circ_plane_1811(:,:,1)=mean(barline_circ_1811c,2);
circ_plane_1811(:,:,2)=mean(barline_circ_1811d,2);
circ_plane_1811(:,:,3)=mean(barline_circ_1811e,2);

bg_plane_1811(:,:,1)=mean(barline_bg_1811c,2);
bg_plane_1811(:,:,2)=mean(barline_bg_1811d,2);
bg_plane_1811(:,:,3)=mean(barline_bg_1811e,2);



circ_plane_1203(:,:,1)=mean(barline_circ_1203d,2);
circ_plane_1203(:,:,2)=mean(barline_circ_1203e,2);
circ_plane_1203(:,:,3)=mean(barline_circ_1203f,2);

bg_plane_1203(:,:,1)=mean(barline_bg_1203d,2);
bg_plane_1203(:,:,2)=mean(barline_bg_1203e,2);
bg_plane_1203(:,:,3)=mean(barline_bg_1203f,2);










%%



circ_plane_2511_cont(:,:,1)=mean(barline_circ_cont_2511d,2);
circ_plane_2511_cont(:,:,2)=mean(barline_circ_cont_2511e,2);
circ_plane_2511_cont(:,:,3)=mean(barline_circ_cont_2511f,2);

circ_plane_2511_non(:,:,1)=mean(barline_circ_non_2511d,2);
circ_plane_2511_non(:,:,2)=mean(barline_circ_non_2511e,2);
circ_plane_2511_non(:,:,3)=mean(barline_circ_non_2511f,2);

bg_plane_2511_cont(:,:,1)=mean(barline_bg_cont_2511d,2);
bg_plane_2511_cont(:,:,2)=mean(barline_bg_cont_2511e,2);
bg_plane_2511_cont(:,:,3)=mean(barline_bg_cont_2511f,2);

bg_plane_2511_non(:,:,1)=mean(barline_bg_non_2511d,2);
bg_plane_2511_non(:,:,2)=mean(barline_bg_non_2511e,2);
bg_plane_2511_non(:,:,3)=mean(barline_bg_non_2511f,2);





circ_plane_1811_cont(:,:,1)=mean(barline_circ_cont_1811c,2);
circ_plane_1811_cont(:,:,2)=mean(barline_circ_cont_1811d,2);
circ_plane_1811_cont(:,:,3)=mean(barline_circ_cont_1811e,2);

circ_plane_1811_non(:,:,1)=mean(barline_circ_non_1811c,2);
circ_plane_1811_non(:,:,2)=mean(barline_circ_non_1811d,2);
circ_plane_1811_non(:,:,3)=mean(barline_circ_non_1811e,2);

bg_plane_1811_cont(:,:,1)=mean(barline_bg_cont_1811c,2);
bg_plane_1811_cont(:,:,2)=mean(barline_bg_cont_1811d,2);
bg_plane_1811_cont(:,:,3)=mean(barline_bg_cont_1811e,2);

bg_plane_1811_non(:,:,1)=mean(barline_bg_non_1811c,2);
bg_plane_1811_non(:,:,2)=mean(barline_bg_non_1811d,2);
bg_plane_1811_non(:,:,3)=mean(barline_bg_non_1811e,2);


figure;plot(mean(mean(bg_plane_1811_cont(:,43:53,:),2),3),'r');
ylim([-1e-3 2e-3])
hold on
plot(mean(mean(bg_plane_1811_non(:,43:53,:),2),3),'g');
plot(zeros(1,size(bg_plane_1811_cont,1)),'k')
plot(line_real_bg,'k')
title(['time ',int2str(x(i)),' ms'])


figure;plot(mean(mean(circ_plane_1811_cont(:,43:53,:),2),3),'r');
ylim([-1e-3 2e-3])
hold on
plot(mean(mean(circ_plane_1811_non(:,43:53,:),2),3),'g');
plot(zeros(1,size(circ_plane_1811_cont,1)),'k')
plot(line_real_circ,'k')
title(['time ',int2str(x(i)),' ms'])





circ_plane_1203_cont(:,:,1)=mean(barline_circ_cont_1203d,2);
circ_plane_1203_cont(:,:,2)=mean(barline_circ_cont_1203e,2);
circ_plane_1203_cont(:,:,3)=mean(barline_circ_cont_1203f,2);

circ_plane_1203_non(:,:,1)=mean(barline_circ_non_1203d,2);
circ_plane_1203_non(:,:,2)=mean(barline_circ_non_1203e,2);
circ_plane_1203_non(:,:,3)=mean(barline_circ_non_1203f,2);

bg_plane_1203_cont(:,:,1)=mean(barline_bg_cont_1203d,2);
bg_plane_1203_cont(:,:,2)=mean(barline_bg_cont_1203e,2);
bg_plane_1203_cont(:,:,3)=mean(barline_bg_cont_1203f,2);

bg_plane_1203_non(:,:,1)=mean(barline_bg_non_1203d,2);
bg_plane_1203_non(:,:,2)=mean(barline_bg_non_1203e,2);
bg_plane_1203_non(:,:,3)=mean(barline_bg_non_1203f,2);


figure;plot(mean(mean(bg_plane_1203_cont(:,43:53,:),2),3),'r');
ylim([-1e-3 2e-3])
hold on
plot(mean(mean(bg_plane_1203_non(:,43:53,:),2),3),'g');
plot(zeros(1,size(bg_plane_1203_cont,1)),'k')
plot(line_real_bg,'k')
title(['time ',int2str(x(i)),' ms'])



figure;plot(mean(mean(circ_plane_1203_cont(:,43:53,:),2),3),'r');
ylim([-1e-3 2e-3])
hold on
plot(mean(mean(circ_plane_1203_non(:,43:53,:),2),3),'g');
plot(zeros(1,size(circ_plane_1203_cont,1)),'k')
plot(line_real_circ,'k')
title(['time ',int2str(x(i)),' ms'])








