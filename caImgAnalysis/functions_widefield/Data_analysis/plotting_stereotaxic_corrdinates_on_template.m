cd D:\intrinsic
load('steriotaxic_regions.mat')
ap_ax=3.52:-.1:-6.02;
ml_ax=-.2:0.01:5.5;

brain=zeros(size(ml_ax,2),size(ap_ax,2));

for i=1:size(m2,1)
    x=find(round(ap_ax*10)/10==round(m2(i,1)*10)/10);
    y1=find(round(ml_ax*100)/100'==round(m2(i,2)*10)/10);
    y2=find(round(ml_ax*100)/100'==round(m2(i,3)*10)/10);
    brain(y1:y2,x)=10;
    %brain(x,y2)=1;
end

for i=1:size(m1,1)
    x=find(round(ap_ax*10)/10==round(m1(i,1)*10)/10);
    y1=find(round(ml_ax*100)/100'==round(m1(i,2)*10)/10);
    y2=find(round(ml_ax*100)/100'==round(m1(i,3)*10)/10);
    brain(y1:y2,x)=15;
    %brain(x,y2)=1;
end

for i=1:size(ssp_bf,1)
    x=find(round(ap_ax*10)/10==round(ssp_bf(i,1)*10)/10);
    y1=find(round(ml_ax*100)/100'==round(ssp_bf(i,2)*10)/10);
    y2=find(round(ml_ax*100)/100'==round(ssp_bf(i,3)*10)/10);
    brain(y1:y2,x)=20;
    %brain(x,y2)=1;
end

for i=1:size(ssp_ul,1)
    x=find(round(ap_ax*10)/10==round(ssp_ul(i,1)*10)/10);
    y1=find(round(ml_ax*100)/100'==round(ssp_ul(i,2)*10)/10);
    y2=find(round(ml_ax*100)/100'==round(ssp_ul(i,3)*10)/10);
    brain(y1:y2,x)=25;
    %brain(x,y2)=1;
end

for i=1:size(ssp_ll,1)
    x=find(round(ap_ax*10)/10==round(ssp_ll(i,1)*10)/10);
    y1=find(round(ml_ax*100)/100'==round(ssp_ll(i,2)*10)/10);
    y2=find(round(ml_ax*100)/100'==round(ssp_ll(i,3)*10)/10);
    brain(y1:y2,x)=4;
    %brain(x,y2)=1;
end

for i=1:size(ptl_p,1)
    x=find(round(ap_ax*10)/10==round(ptl_p(i,1)*10)/10);
    y1=find(round(ml_ax*100)/100'==round(ptl_p(i,2)*10)/10);
    y2=find(round(ml_ax*100)/100'==round(ptl_p(i,3)*10)/10);
    brain(y1:y2,x)=9;
    %brain(x,y2)=1;
end

for i=1:size(ssp_tr,1)
    x=find(round(ap_ax*10)/10==round(ssp_tr(i,1)*10)/10);
    y1=find(round(ml_ax*100)/100'==round(ssp_tr(i,2)*10)/10);
    y2=find(round(ml_ax*100)/100'==round(ssp_tr(i,3)*10)/10);
    brain(y1:y2,x)=14;
    %brain(x,y2)=1;
end

for i=1:size(vis_p,1)
    x=find(round(ap_ax*10)/10==round(vis_p(i,1)*10)/10);
    y1=find(round(ml_ax*100)/100'==round(vis_p(i,2)*10)/10);
    y2=find(round(ml_ax*100)/100'==round(vis_p(i,3)*10)/10);
    brain(y1:y2,x)=19;
    %brain(x,y2)=1;
end

for i=1:size(sc,1)
    x=find(round(ap_ax*10)/10==round(sc(i,1)*10)/10);
    y1=find(round(ml_ax*100)/100'==round(sc(i,2)*10)/10);
    y2=find(round(ml_ax*100)/100'==round(sc(i,3)*10)/10);
    brain(y1:y2,x)=24;
    %brain(x,y2)=1;
end

for i=1:size(ice,1)
    x=find(round(ap_ax*10)/10==round(ice(i,1)*10)/10);
    y1=find(round(ml_ax*100)/100'==round(ice(i,2)*10)/10);
    y2=find(round(ml_ax*100)/100'==round(ice(i,3)*10)/10);
    brain(y1:y2,x)=3;
    %brain(x,y2)=1;
end


for i=1:size(icd,1)
    x=find(round(ap_ax*10)/10==round(icd(i,1)*10)/10);
    y1=find(round(ml_ax*100)/100'==round(icd(i,2)*10)/10);
    y2=find(round(ml_ax*100)/100'==round(icd(i,3)*10)/10);
    brain(y1:y2,x)=8;
    %brain(x,y2)=1;
end

for i=1:size(ssp_m,1)
    x=find(round(ap_ax*10)/10==round(ssp_m(i,1)*10)/10);
    y1=find(round(ml_ax*100)/100'==round(ssp_m(i,2)*10)/10);
    y2=find(round(ml_ax*100)/100'==round(ssp_m(i,3)*10)/10);
    brain(y1:y2,x)=13;
    %brain(x,y2)=1;
end

for i=1:size(aud_d,1)
    x=find(round(ap_ax*10)/10==round(aud_d(i,1)*10)/10);
    y1=find(round(ml_ax*100)/100'==round(aud_d(i,2)*10)/10);
    y2=find(round(ml_ax*100)/100'==round(aud_d(i,3)*10)/10);
    brain(y1:y2,x)=18;
    %brain(x,y2)=1;
end

for i=1:size(aud_p,1)
    x=find(round(ap_ax*10)/10==round(aud_p(i,1)*10)/10);
    y1=find(round(ml_ax*100)/100'==round(aud_p(i,2)*10)/10);
    y2=find(round(ml_ax*100)/100'==round(aud_p(i,3)*10)/10);
    brain(y1:y2,x)=23;
    %brain(x,y2)=1;
end


for i=1:size(vis_al,1)
    x=find(round(ap_ax*10)/10==round(vis_al(i,1)*10)/10);
    y1=find(round(ml_ax*100)/100'==round(vis_al(i,2)*10)/10);
    y2=find(round(ml_ax*100)/100'==round(vis_al(i,3)*10)/10);
    brain(y1:y2,x)=2;
    %brain(x,y2)=1;
end

for i=1:size(vis_l,1)
    x=find(round(ap_ax*10)/10==round(vis_l(i,1)*10)/10);
    y1=find(round(ml_ax*100)/100'==round(vis_l(i,2)*10)/10);
    y2=find(round(ml_ax*100)/100'==round(vis_l(i,3)*10)/10);
    brain(y1:y2,x)=7;
    %brain(x,y2)=1;
end

for i=1:size(vis_pl,1)
    x=find(round(ap_ax*10)/10==round(vis_pl(i,1)*10)/10);
    y1=find(round(ml_ax*100)/100'==round(vis_pl(i,2)*10)/10);
    y2=find(round(ml_ax*100)/100'==round(vis_pl(i,3)*10)/10);
    brain(y1:y2,x)=12;
    %brain(x,y2)=1;
end

for i=1:size(vis_am,1)
    x=find(round(ap_ax*10)/10==round(vis_am(i,1)*10)/10);
    y1=find(round(ml_ax*100)/100'==round(vis_am(i,2)*10)/10);
    y2=find(round(ml_ax*100)/100'==round(vis_am(i,3)*10)/10);
    brain(y1:y2,x)=17;
    %brain(x,y2)=1;
end

for i=1:size(vis_pm,1)
    x=find(round(ap_ax*10)/10==round(vis_pm(i,1)*10)/10);
    y1=find(round(ml_ax*100)/100'==round(vis_pm(i,2)*10)/10);
    y2=find(round(ml_ax*100)/100'==round(vis_pm(i,3)*10)/10);
    brain(y1:y2,x)=14;
    %brain(x,y2)=1;
end

for i=1:size(rsp_d,1)
    x=find(round(ap_ax*10)/10==round(rsp_d(i,1)*10)/10);
    y1=find(round(ml_ax*100)/100'==round(rsp_d(i,2)*10)/10);
    y2=find(round(ml_ax*100)/100'==round(rsp_d(i,3)*10)/10);
    brain(y1:y2,x)=2;
    %brain(x,y2)=1;
end

for i=1:size(rsp_agl,1)
    x=find(round(ap_ax*10)/10==round(rsp_agl(i,1)*10)/10);
    y1=find(round(ml_ax*100)/100'==round(rsp_agl(i,2)*10)/10);
    y2=find(round(ml_ax*100)/100'==round(rsp_agl(i,3)*10)/10);
    brain(y1:y2,x)=5;
    %brain(x,y2)=1;
end

for i=1:size(acc,1)
    x=find(round(ap_ax*10)/10==round(acc(i,1)*10)/10);
    y1=find(round(ml_ax*100)/100'==round(acc(i,2)*10)/10);
    y2=find(round(ml_ax*100)/100'==round(acc(i,3)*10)/10);
    brain(y1:y2,x)=26;
    %brain(x,y2)=1;
end

for i=1:size(pl,1)
    x=find(round(ap_ax*10)/10==round(pl(i,1)*10)/10);
    y1=find(round(ml_ax*100)/100'==round(pl(i,2)*10)/10);
    y2=find(round(ml_ax*100)/100'==round(pl(i,3)*10)/10);
    brain(y1:y2,x)=1;
    %brain(x,y2)=1;
end

for i=1:size(tea,1)
    x=find(round(ap_ax*10)/10==round(tea(i,1)*10)/10);
    y1=find(round(ml_ax*100)/100'==round(tea(i,2)*10)/10);
    y2=find(round(ml_ax*100)/100'==round(tea(i,3)*10)/10);
    brain(y1:y2,x)=14;
    %brain(x,y2)=1;
end

for i=1:size(ect,1)
    x=find(round(ap_ax*10)/10==round(ect(i,1)*10)/10);
    y1=find(round(ml_ax*100)/100'==round(ect(i,2)*10)/10);
    y2=find(round(ml_ax*100)/100'==round(ect(i,3)*10)/10);
    brain(y1:y2,x)=21;
    %brain(x,y2)=1;
end

for i=1:size(sss,1)
    x=find(round(ap_ax*10)/10==round(sss(i,1)*10)/10);
    y1=find(round(ml_ax*100)/100'==round(sss(i,2)*10)/10);
    y2=find(round(ml_ax*100)/100'==round(sss(i,3)*10)/10);
    brain(y1:y2,x)=16;
    %brain(x,y2)=1;
end

figure;imagesc(ap_ax,ml_ax,brain,[0 26]);colormap(mapgeog)






