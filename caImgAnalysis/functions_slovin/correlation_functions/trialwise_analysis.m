
trials=26;
%cirlce=cell(2,trials);
for i=1:trials
    figure(100);
    mimg(mfilt2(mean(cond2n_dt_bl(:,37:40,i),2),100,100,1,'lm')-1,100,100,-1e-3,1e-3);colormap(mapgeog);
    circle2{1,i} = choose_polygon(100);
    mimg(mfilt2(mean(cond2n_dt_bl(:,48:58,i),2),100,100,1,'lm')-1,100,100,-1e-3,2e-3);colormap(mapgeog);
    circle2{2,i} = choose_polygon(100);
end
    
trials=26;
%bg=cell(2,trials);
for i=1:trials
    figure(100);
    mimg(mfilt2(mean(cond2n_dt_bl(:,36:39,i),2),100,100,1,'lm')-1,100,100,-1e-3,1.2e-3);colormap(mapgeog);
    bg2{1,i} = choose_polygon(100);
    mimg(mfilt2(mean(cond2n_dt_bl(:,48:58,i),2),100,100,1,'lm')-1,100,100,-1e-3,1.6e-3);colormap(mapgeog);
    bg2{2,i} = choose_polygon(100);
end    
    
    
    
    
    