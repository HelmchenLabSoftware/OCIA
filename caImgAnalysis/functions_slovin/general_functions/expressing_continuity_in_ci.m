

time=43:53;
circ=roi_circle;
bg=roi_bg_in;
k=zeros(10000,1);
k(circ)=10;
k(bg)=10;
%diff=c1-c5;
%diff=((a-c)+(b-d))/2;
diff=a-b;

g=zeros(10000,1);
g(roi)=1;
g(pixels_to_remove)=2;
roi=find(g==1);

up=roi(find(mean(diff(roi,time),2)>=prctile(mean(diff(roi,time),2),50)));
down=roi(find(mean(diff(roi,time),2)<prctile(mean(diff(roi,time),2),50)));
g=ones(10000,1);
g(up)=0.75;
g(down)=0.25;
circ_up=circ(find(mean(g(circ),2)==0.75));
bg_down=bg(find(mean(g(bg),2)==0.25));
h=ones(10000,1);
h(circ_up)=0.75;
h(bg_down)=0.25;
figure;mimg(h,100,100,0,1);colormap(mapgeog)
hold on
contour(reshape(k,100,100)')
figure;mimg(g,100,100,0,1);colormap(mapgeog)


%

percent_circ=sum(mean(g(circ),2)==0.75)/size(circ,1)*100
percent_bg=sum(mean(g(bg),2)==0.25)/size(bg,1)*100



