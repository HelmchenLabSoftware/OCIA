

contour_circle=zeros(256,12);
contour_circle(:,1)=cond1_1711b_circle;
contour_circle(:,2)=cond2_1711b_circle;
contour_circle(:,3)=cond1_1711c_circle;
contour_circle(:,4)=cond2_1711c_circle;
contour_circle(:,5)=cond1_1711g_circle;
contour_circle(:,6)=cond2_1711g_circle;
contour_circle(:,7)=cond1_2411b_circle;
contour_circle(:,8)=cond2_2411b_circle;
contour_circle(:,9)=cond1_2411d_circle;
contour_circle(:,10)=cond2_2411d_circle;
contour_circle(:,11)=cond1_2411f_circle;
contour_circle(:,12)=cond2_2411f_circle;


contour_bg_in=zeros(256,12);
contour_bg_in(:,1)=cond1_1711b_bg_in;
contour_bg_in(:,2)=cond2_1711b_bg_in;
contour_bg_in(:,3)=cond1_1711c_bg_in;
contour_bg_in(:,4)=cond2_1711c_bg_in;
contour_bg_in(:,5)=cond1_1711g_bg_in;
contour_bg_in(:,6)=cond2_1711g_bg_in;
contour_bg_in(:,7)=cond1_2411b_bg_in;
contour_bg_in(:,8)=cond2_2411b_bg_in;
contour_bg_in(:,9)=cond1_2411d_bg_in;
contour_bg_in(:,10)=cond2_2411d_bg_in;
contour_bg_in(:,11)=cond1_2411f_bg_in;
contour_bg_in(:,12)=cond2_2411f_bg_in;




noncon_circle=zeros(256,12);
noncon_circle(:,1)=cond4_1711b_circle;
noncon_circle(:,2)=cond5_1711b_circle;
noncon_circle(:,3)=cond4_1711c_circle;
noncon_circle(:,4)=cond5_1711c_circle;
noncon_circle(:,5)=cond4_1711g_circle;
noncon_circle(:,6)=cond5_1711g_circle;
noncon_circle(:,7)=cond4_2411b_circle;
noncon_circle(:,8)=cond5_2411b_circle;
noncon_circle(:,9)=cond4_2411d_circle;
noncon_circle(:,10)=cond5_2411d_circle;
noncon_circle(:,11)=cond4_2411f_circle;
noncon_circle(:,12)=cond5_2411f_circle;


noncon_bg_in=zeros(256,12);
noncon_bg_in(:,1)=cond4_1711b_bg_in;
noncon_bg_in(:,2)=cond5_1711b_bg_in;
noncon_bg_in(:,3)=cond4_1711c_bg_in;
noncon_bg_in(:,4)=cond5_1711c_bg_in;
noncon_bg_in(:,5)=cond4_1711g_bg_in;
noncon_bg_in(:,6)=cond5_1711g_bg_in;
noncon_bg_in(:,7)=cond4_2411b_bg_in;
noncon_bg_in(:,8)=cond5_2411b_bg_in;
noncon_bg_in(:,9)=cond4_2411d_bg_in;
noncon_bg_in(:,10)=cond5_2411d_bg_in;
noncon_bg_in(:,11)=cond4_2411f_bg_in;
noncon_bg_in(:,12)=cond5_2411f_bg_in;



figure;errorbar(mean(contour_circle(2:112,:),2),std(contour_circle(2:112,:),0,2)/sqrt(12))
hold on
errorbar(mean(noncon_circle(2:112,:),2),std(noncon_circle(2:112,:),0,2)/sqrt(12),'r')

figure;errorbar(mean(contour_bg_in(2:112,:),2),std(contour_bg_in(2:112,:),0,2)/sqrt(12))
hold on
errorbar(mean(noncon_bg_in(2:112,:),2),std(noncon_bg_in(2:112,:),0,2)/sqrt(12),'r')


x=(10:10:2560)-280;


figure;plot(x(2:112),mean(contour_circle(2:112,:),2))
hold on
plot(x(2:112),mean(noncon_circle(2:112,:),2),'r')

figure;plot(x(2:112),mean(contour_bg_in(2:112,:),2))
hold on
plot(x(2:112),mean(noncon_bg_in(2:112,:),2),'r')


figure;plot(x(2:112),mean(contour_circle(2:112,:),2))
hold on
plot(x(2:112),mean(contour_bg_in(2:112,:),2),'r')

figure;plot(x(2:112),mean(noncon_circle(2:112,:),2))
hold on
plot(x(2:112),mean(noncon_bg_in(2:112,:),2),'r')




figure;plot(x(2:112),mean(contour_circle(2:112,:)-noncon_circle(2:112,:),2))
hold on
plot(x(2:112),mean(contour_bg_in(2:112,:)-noncon_bg_in(2:112,:),2),'r')
xlim([-100 300])




diff_circle=contour_circle(2:112,:)-noncon_circle(2:112,:);
diff_bg_in=contour_bg_in(2:112,:)-noncon_bg_in(2:112,:);

diff_fg=diff_circle-diff_bg_in;

figure;errorbar(x(2:112),mean(diff_circle,2),std(diff_circle,0,2)/sqrt(12))
hold on 
errorbar(x(2:112),mean(diff_bg_in,2),std(diff_bg_in,0,2)/sqrt(12),'r')
xlim([-100 300])



figure;errorbar(x(2:112),mean(diff_fg,2),std(diff_fg,0,2)/sqrt(size(diff_fg,2)))
xlim([-100 300])


for i=1:12
    figure;plot(x(2:112),diff_circle(:,i),'b')
    hold on
    plot(x(2:112),diff_bg_in(:,i),'r')
end

for i=1:12
    figure;plot(x(2:112),diff_fg(:,i),'b')
end


diff_contour=contour_circle(2:112,:)-contour_bg_in(2:112,:);
diff_noncon=noncon_circle(2:112,:)-noncon_bg_in(2:112,:);

diff_fg=diff_contour-diff_noncon;

figure;errorbar(x(2:112),mean(diff_contour,2),std(diff_contour,0,2)/sqrt(12))
hold on 
errorbar(x(2:112),mean(diff_noncon,2),std(diff_noncon,0,2)/sqrt(12),'r')
xlim([-100 400])

for i=1:12
    figure;plot(x(2:112),diff_contour(:,i),'b')
    hold on
    plot(x(2:112),diff_noncon(:,i),'r')
end

%for legolas
diff_fg=time_circ(2:112,:)-time_bgi(2:112,:);
diff_circle=time_circ(2:112,:);
diff_bg_in=time_bgi(2:112,:);





for i=1:111
    p(i)=signrank(diff_fg(i,:));
end
x(find(p<0.05))

for i=1:111
    p(i)=signrank(diff_fg_leg(i,:));
end
x(find(p<0.05))


%%

contour_circ_right=zeros(256,12);
contour_circ_right(:,1)=cond1_1711b_circ_right;
contour_circ_right(:,2)=cond2_1711b_circ_right;
contour_circ_right(:,3)=cond1_1711c_circ_middle;
contour_circ_right(:,4)=cond2_1711c_circ_middle;
contour_circ_right(:,5)=cond1_1711g_circ_right;
contour_circ_right(:,6)=cond2_1711g_circ_right;
contour_circ_right(:,7)=cond1_2411b_circ_right;
contour_circ_right(:,8)=cond2_2411b_circ_right;
contour_circ_right(:,9)=cond1_2411d_circ_right;
contour_circ_right(:,10)=cond2_2411d_circ_right;
contour_circ_right(:,11)=cond1_2411f_circ_middle;
contour_circ_right(:,12)=cond2_2411f_circ_middle;


contour_bg_right=zeros(256,12);
contour_bg_right(:,1)=cond1_1711b_bg_right;
contour_bg_right(:,2)=cond2_1711b_bg_right;
contour_bg_right(:,3)=cond1_1711c_bg_middle;
contour_bg_right(:,4)=cond2_1711c_bg_middle;
contour_bg_right(:,5)=cond1_1711g_bg_right;
contour_bg_right(:,6)=cond2_1711g_bg_right;
contour_bg_right(:,7)=cond1_2411b_bg_right;
contour_bg_right(:,8)=cond2_2411b_bg_right;
contour_bg_right(:,9)=cond1_2411d_bg_right;
contour_bg_right(:,10)=cond2_2411d_bg_right;
contour_bg_right(:,11)=cond1_2411f_bg_middle;
contour_bg_right(:,12)=cond2_2411f_bg_middle;




noncon_circ_right=zeros(256,12);
noncon_circ_right(:,1)=cond4_1711b_circ_right;
noncon_circ_right(:,2)=cond5_1711b_circ_right;
noncon_circ_right(:,3)=cond4_1711c_circ_middle;
noncon_circ_right(:,4)=cond5_1711c_circ_middle;
noncon_circ_right(:,5)=cond4_1711g_circ_right;
noncon_circ_right(:,6)=cond5_1711g_circ_right;
noncon_circ_right(:,7)=cond4_2411b_circ_right;
noncon_circ_right(:,8)=cond5_2411b_circ_right;
noncon_circ_right(:,9)=cond4_2411d_circ_right;
noncon_circ_right(:,10)=cond5_2411d_circ_right;
noncon_circ_right(:,11)=cond4_2411f_circ_middle;
noncon_circ_right(:,12)=cond5_2411f_circ_middle;


noncon_bg_right=zeros(256,12);
noncon_bg_right(:,1)=cond4_1711b_bg_right;
noncon_bg_right(:,2)=cond5_1711b_bg_right;
noncon_bg_right(:,3)=cond4_1711c_bg_middle;
noncon_bg_right(:,4)=cond5_1711c_bg_middle;
noncon_bg_right(:,5)=cond4_1711g_bg_right;
noncon_bg_right(:,6)=cond5_1711g_bg_right;
noncon_bg_right(:,7)=cond4_2411b_bg_right;
noncon_bg_right(:,8)=cond5_2411b_bg_right;
noncon_bg_right(:,9)=cond4_2411d_bg_right;
noncon_bg_right(:,10)=cond5_2411d_bg_right;
noncon_bg_right(:,11)=cond4_2411f_bg_middle;
noncon_bg_right(:,12)=cond5_2411f_bg_middle;




x=(10:10:2560)-280;
figure;plot(x(2:112),mean(contour_circ_right(2:112,:),2))
hold on
plot(x(2:112),mean(noncon_circ_right(2:112,:),2),'r')

figure;plot(x(2:112),mean(contour_bg_right(2:112,:),2))
hold on
plot(x(2:112),mean(noncon_bg_right(2:112,:),2),'r')


figure;plot(x(2:112),mean(contour_circ_right(2:112,:),2))
hold on
plot(x(2:112),mean(contour_bg_right(2:112,:),2),'r')

figure;plot(x(2:112),mean(noncon_circ_right(2:112,:),2))
hold on
plot(x(2:112),mean(noncon_bg_right(2:112,:),2),'r')


figure;errorbar(mean(contour_circ_right(2:112,:),2),std(contour_circ_right(2:112,:),0,2)/sqrt(12))
hold on
errorbar(mean(noncon_circ_right(2:112,:),2),std(noncon_circ_right(2:112,:),0,2)/sqrt(12),'r')

figure;errorbar(mean(contour_bg_right(2:112,:),2),std(contour_bg_right(2:112,:),0,2)/sqrt(12))
hold on
errorbar(mean(noncon_bg_right(2:112,:),2),std(noncon_bg_right(2:112,:),0,2)/sqrt(12),'r')



diff_circ_right=contour_circ_right(2:112,:)-noncon_circ_right(2:112,:);
diff_bg_right=contour_bg_right(2:112,:)-noncon_bg_right(2:112,:);

diff_fg=diff_circ_right-diff_bg_right;

figure;errorbar(x(2:112),mean(diff_circ_right,2),std(diff_circ_right,0,2)/sqrt(12))
hold on 
errorbar(x(2:112),mean(diff_bg_right,2),std(diff_bg_right,0,2)/sqrt(12),'r')
xlim([-100 300])



figure;errorbar(x(2:112),mean(diff_fg,2),std(diff_fg,0,2)/sqrt(size(diff_fg,2)))
xlim([-100 300])

for i=1:111
    p(i)=signrank(diff_fg(i,:));
end
x(find(p<0.05))



for i=1:12
    figure;plot(x(2:112),diff_circ_right(:,i),'b')
    hold on
    plot(x(2:112),diff_bg_right(:,i),'r')
end

for i=1:12
    figure;plot(x(2:112),diff_fg(:,i),'b')
end


diff_contour=contour_circle(2:112,:)-contour_bg_in(2:112,:);
diff_noncon=noncon_circle(2:112,:)-noncon_bg_in(2:112,:);

diff_fg=diff_contour-diff_noncon;

figure;errorbar(x(2:112),mean(diff_contour,2),std(diff_contour,0,2)/sqrt(12))
hold on 
errorbar(x(2:112),mean(diff_noncon,2),std(diff_noncon,0,2)/sqrt(12),'r')
xlim([-100 400])

for i=1:12
    figure;plot(x(2:112),diff_contour(:,i),'b')
    hold on
    plot(x(2:112),diff_noncon(:,i),'r')
end






