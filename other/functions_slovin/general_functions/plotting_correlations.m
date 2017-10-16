


x=(20:10:1130)-240;


for i=[24 25 28:35]
    figure;plot(x,diff_cccirc_circ(:,i))
    hold on
    plot(x,diff_ccbg_bg(:,i),'r')
    xlim([-100 450])
end
    
    
for i=1:27
    figure;mimg(mfilt2(mean(a(:,50:60,i),3)-mean(c(:,50:60,i),3),100,100,1,'lm'),100,100,-0.25,0.25);colormap(mapgeog)
end






    
    
    