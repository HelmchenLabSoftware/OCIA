
x=(20:10:1120)-280;
x2=(20:10:1130)-240;

roi1=roi_contour2;
roi2=roi_maskin;
roi3=roi_maskout;

for i=1:20
    tr=i;

    fg=mean(cond1n_dt_bl(roi1,2:112,tr),1)-mean(cond1n_dt_bl(roi2,2:112,tr),1);
    fg=fg./max(fg);

    bind=mean(a(roi3,:,tr),1);
    bind=bind/max(bind(1:60));
    
    bind2=mean(b(roi1,:,tr),1);
    bind2=bind2/max(bind2(1:60));

    
    figure;plot(x,fg)
    hold on
    plot(x2,bind,'r')
    plot(x2,bind2,'g')
end



