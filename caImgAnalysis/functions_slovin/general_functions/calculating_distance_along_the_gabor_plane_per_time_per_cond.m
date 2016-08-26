
date='0501d';
date2='0501d';
date3='0501';


eval(['plane_cont_c=squeeze(mean(barline_circ_cont_',date,',2));'])
eval(['plane_cont_b=squeeze(mean(barline_bg_cont_',date,',2));'])
eval(['plane_non_c=squeeze(mean(barline_circ_non_',date2,',2));'])
eval(['plane_non_b=squeeze(mean(barline_bg_non_',date2,',2));'])

eval(['circ_gabors_center=circ_gabors_center_',date3,';'])
eval(['bg_gabors_center=bg_gabors_center_',date3,';'])


dist1_c=abs(circ_gabors_center(1)-(1:size(plane_cont_c,1)));
dist2_c=abs(circ_gabors_center(2)-(1:size(plane_cont_c,1)));
%dist3_c=abs(circ_gabors_center(3)-(1:size(plane_cont_c,1)));
%dist_c=min([dist1_c;dist2_c;dist3_c]);
dist_c=min([dist1_c;dist2_c]);


plane_cont_c_dist=zeros(max(dist_c),256);
plane_non_c_dist=zeros(max(dist_c),256);
for j=1:256
    k=0;
    for i=min(dist_c):max(dist_c)
        k=k+1;
        t=find(dist_c==i);
        plane_cont_c_dist(k,j)=mean(plane_cont_c(t,j));
        plane_non_c_dist(k,j)=mean(plane_non_c(t,j));
    end
end

dist1_b=abs(bg_gabors_center(1)-(1:size(plane_non_b,1)));
dist2_b=abs(bg_gabors_center(2)-(1:size(plane_non_b,1)));
dist3_b=abs(bg_gabors_center(3)-(1:size(plane_non_b,1)));
dist_b=min([dist1_b;dist2_b;dist3_b]);
%dist_b=min([dist1_b;dist2_b]);
%dist_b=dist1_b;


plane_cont_b_dist=zeros(max(dist_b),256);
plane_non_b_dist=zeros(max(dist_b),256);
for j=1:256
    k=0;
    for i=min(dist_b):max(dist_b)
        k=k+1;
        t=find(dist_b==i);
        plane_cont_b_dist(k,j)=mean(plane_cont_b(t,j));
        plane_non_b_dist(k,j)=mean(plane_non_b(t,j));
    end
end



eval(['plane_cont_c_dist_',date,'=plane_cont_c_dist;'])
eval(['plane_cont_b_dist_',date,'=plane_cont_b_dist;'])
eval(['plane_non_c_dist_',date2,'=plane_non_c_dist;'])
eval(['plane_non_b_dist_',date2,'=plane_non_b_dist;'])





















