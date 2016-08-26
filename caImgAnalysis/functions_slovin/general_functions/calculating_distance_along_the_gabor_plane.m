

time=43:53;
plane_c=mean(mean(barline_circ_0501e25(:,:,time),2),3);
plane_b=mean(mean(barline_bg_0501e25(:,:,time),2),3);

dist1_c=abs(circ_gabors_center(1)-(1:size(plane_c,1)));
dist2_c=abs(circ_gabors_center(2)-(1:size(plane_c,1)));
dist3_c=abs(circ_gabors_center(3)-(1:size(plane_c,1)));
dist_c=min([dist1_c;dist2_c;dist3_c]);
%dist_c=min([dist1_c;dist2_c]);


plane_c_dist=zeros(max(dist_c),1);
k=0;
for i=min(dist_c):max(dist_c)
    k=k+1;
    t=find(dist_c==i);
    plane_c_dist(k)=mean(plane_c(t));
end


dist1_b=abs(bg_gabors_center(1)-(1:size(plane_b,1)));
dist2_b=abs(bg_gabors_center(2)-(1:size(plane_b,1)));
dist3_b=abs(bg_gabors_center(3)-(1:size(plane_b,1)));
dist_b=min([dist1_b;dist2_b;dist3_b]);
%dist_b=min([dist1_b;dist2_b]);
%dist_b=dist1_b;

plane_b_dist=zeros(max(dist_b),1);
k=0;
for i=min(dist_b):max(dist_b)
    k=k+1;
    t=find(dist_b==i);
    plane_b_dist(k)=mean(plane_b(t));
end

figure;plot(plane_c_dist)
hold on
plot(zeros(1,size(plane_c_dist,1)),'k')
ylim([-.5e-3 .5e-3])

figure;plot(plane_b_dist)
hold on
plot(zeros(1,size(plane_b_dist,1)),'k')
ylim([-.5e-3 .5e-3])








