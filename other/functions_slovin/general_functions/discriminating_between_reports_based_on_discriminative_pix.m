


AUC_10=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond2n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond2n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond2n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_10(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end


lim = prctile(AUC_10,75);
high_val=find(AUC_10>lim);

lim2 = prctile(AUC_10,25);
low_val=find(AUC_10<lim2);

h=zeros(10000,1);
h(high_val)=1;
h(low_val)=-1;
h(pixels_to_remove)=0;
figure;mimg(h,100,100,-1,1)


g=zeros(10000,1);
g(roi_circle)=1;
g(roi_bg_out)=-1;

k=g+h;
roi_high=find(k==2);
roi_low=find(k==-2);


circ_10=cond2n_dt_bl_right(roi_high,:,:)-1;
bg_10=cond2n_dt_bl_right(roi_low,:,:)-1;

%X_10=zeros(size(circ_10,1)+size(bg_10,1)+1,size(circ_10,3),80);
%Y_10=zeros(size(circ_10,1)+size(bg_10,1)+1,size(circ_10,3),80);
AUC_10_right=zeros(size(circ_10,3),80);

for j=25:75
    disp(j)
    for i=1:size(circ_10,3)
        scores=[circ_10(:,j,i);bg_10(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_10,1)+1:end)=0;
        [X_10,Y_10,THRE,AUC_10_right(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
figure;plot(mean(AUC_10_right,1))


circ_10=cond2n_dt_bl_left(roi_high,:,:)-1;
bg_10=cond2n_dt_bl_left(roi_low,:,:)-1;

%X_10=zeros(size(circ_10,1)+size(bg_10,1)+1,size(circ_10,3),80);
%Y_10=zeros(size(circ_10,1)+size(bg_10,1)+1,size(circ_10,3),80);
AUC_10_left=zeros(size(circ_10,3),80);

for j=25:75
    disp(j)
    for i=1:size(circ_10,3)
        scores=[circ_10(:,j,i);bg_10(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_10,1)+1:end)=0;
        [X_10,Y_10,THRE,AUC_10_left(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
hold on
plot(mean(AUC_10_left,1),'r')
xlim([20 68])

[n1 x1]=hist(mean(AUC_10_right(:,43:53),2),0:0.05:1);
[n2 x2]=hist(mean(AUC_10_left(:,43:53),2),0:0.05:1);
figure;bar(x1,[n1;n2]')


scores=[mean(AUC_10_right(:,43:53),2);mean(AUC_10_left(:,43:53),2)]';
labels=ones(1,size(scores,2));
labels(size(AUC_10_right,1)+1:end)=0;
[X_10,Y_10,THRE,AUC_AUC_10,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);










%% 2511



AUC_15=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond4n_dt_bl_right(i,48:58,:),2));squeeze(mean(cond4n_dt_bl_left(i,48:58,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond4n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_15(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end


lim = prctile(AUC_15,75);
high_val=find(AUC_15>lim);

lim2 = prctile(AUC_15,25);
low_val=find(AUC_15<lim2);

h=zeros(10000,1);
h(high_val)=1;
h(low_val)=-1;
h(pixels_to_remove)=0;
figure;mimg(h,100,100,-1,1)


g=zeros(10000,1);
g(roi_contour)=1;
g(roi_bg_in)=-1;

k=g+h;
roi_high=find(k==2);
roi_low=find(k==-2);


circ_15=cond4n_dt_bl_right(roi_high,:,:)-1;
bg_15=cond4n_dt_bl_right(roi_low,:,:)-1;

%X_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,3),80);
%Y_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,3),80);
AUC_15_right=zeros(size(circ_15,3),80);

for j=25:75
    disp(j)
    for i=1:size(circ_15,3)
        scores=[circ_15(:,j,i);bg_15(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_15,1)+1:end)=0;
        [X_15,Y_15,THRE,AUC_15_right(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
figure;plot(mean(AUC_15_right,1))


circ_15=cond4n_dt_bl_left(roi_high,:,:)-1;
bg_15=cond4n_dt_bl_left(roi_low,:,:)-1;

%X_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,3),80);
%Y_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,3),80);
AUC_15_left=zeros(size(circ_15,3),80);

for j=25:75
    disp(j)
    for i=1:size(circ_15,3)
        scores=[circ_15(:,j,i);bg_15(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_15,1)+1:end)=0;
        [X_15,Y_15,THRE,AUC_15_left(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
hold on
plot(mean(AUC_15_left,1),'r')
xlim([20 68])

[n1 x1]=hist(mean(AUC_15_right(:,48:58),2),0:0.05:1);
[n2 x2]=hist(mean(AUC_15_left(:,48:58),2),0:0.05:1);
figure;bar(x1,[n1;n2]')


scores=[mean(AUC_15_right(:,48:58),2);mean(AUC_15_left(:,48:58),2)]';
labels=ones(1,size(scores,2));
labels(size(AUC_15_right,1)+1:end)=0;
[X_15,Y_15,THRE,AUC_AUC_15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_15,Y_15)








%% 1811



AUC_15=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond4n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond4n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond4n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_15(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end


lim = prctile(AUC_15,75);
high_val=find(AUC_15>lim);

lim2 = prctile(AUC_15,25);
low_val=find(AUC_15<lim2);

h=zeros(10000,1);
h(high_val)=1;
h(low_val)=-1;
h(pixels_to_remove)=0;
figure;mimg(h,100,100,-1,1)


g=zeros(10000,1);
g(roi_contour)=1;
g(roi_bg_in)=-1;

k=g+h;
roi_high=find(k==2);
roi_low=find(k==-2);


circ_15=cond4n_dt_bl_right(roi_high,:,:)-1;
bg_15=cond4n_dt_bl_right(roi_low,:,:)-1;

%X_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,3),80);
%Y_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,3),80);
AUC_15_right=zeros(size(circ_15,3),80);

for j=25:75
    disp(j)
    for i=1:size(circ_15,3)
        scores=[circ_15(:,j,i);bg_15(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_15,1)+1:end)=0;
        [X_15,Y_15,THRE,AUC_15_right(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
figure;plot(mean(AUC_15_right,1))


circ_15=cond4n_dt_bl_left(roi_high,:,:)-1;
bg_15=cond4n_dt_bl_left(roi_low,:,:)-1;

%X_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,3),80);
%Y_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,3),80);
AUC_15_left=zeros(size(circ_15,3),80);

for j=25:75
    disp(j)
    for i=1:size(circ_15,3)
        scores=[circ_15(:,j,i);bg_15(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_15,1)+1:end)=0;
        [X_15,Y_15,THRE,AUC_15_left(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
hold on
plot(mean(AUC_15_left,1),'r')
xlim([20 68])

[n1 x1]=hist(mean(AUC_15_right(:,43:53),2),0:0.05:1);
[n2 x2]=hist(mean(AUC_15_left(:,43:53),2),0:0.05:1);
figure;bar(x1,[n1;n2]')


scores=[mean(AUC_15_right(:,43:53),2);mean(AUC_15_left(:,43:53),2)]';
labels=ones(1,size(scores,2));
labels(size(AUC_15_right,1)+1:end)=0;
[X_15,Y_15,THRE,AUC_AUC_15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_15,Y_15)







%% 1203



AUC_15=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond2n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond2n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond2n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_15(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end


lim = prctile(AUC_15,75);
high_val=find(AUC_15>lim);

lim2 = prctile(AUC_15,25);
low_val=find(AUC_15<lim2);

h=zeros(10000,1);
h(high_val)=1;
h(low_val)=-1;
h(pixels_to_remove)=0;
figure;mimg(h,100,100,-1,1)


g=zeros(10000,1);
g(roi_contour)=1;
g(roi_bg_in)=-1;

k=g+h;
roi_high=find(k==2);
roi_low=find(k==-2);


circ_15=cond2n_dt_bl_right(roi_high,:,:)-1;
bg_15=cond2n_dt_bl_right(roi_low,:,:)-1;

%X_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,3),80);
%Y_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,3),80);
AUC_15_right=zeros(size(circ_15,3),80);

for j=25:75
    disp(j)
    for i=1:size(circ_15,3)
        scores=[circ_15(:,j,i);bg_15(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_15,1)+1:end)=0;
        [X_15,Y_15,THRE,AUC_15_right(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
figure;plot(mean(AUC_15_right,1))


circ_15=cond2n_dt_bl_left(roi_high,:,:)-1;
bg_15=cond2n_dt_bl_left(roi_low,:,:)-1;

%X_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,3),80);
%Y_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,3),80);
AUC_15_left=zeros(size(circ_15,3),80);

for j=25:75
    disp(j)
    for i=1:size(circ_15,3)
        scores=[circ_15(:,j,i);bg_15(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_15,1)+1:end)=0;
        [X_15,Y_15,THRE,AUC_15_left(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
hold on
plot(mean(AUC_15_left,1),'r')
xlim([20 68])

[n1 x1]=hist(mean(AUC_15_right(:,43:53),2),0:0.05:1);
[n2 x2]=hist(mean(AUC_15_left(:,43:53),2),0:0.05:1);
figure;bar(x1,[n1;n2]')


scores=[mean(AUC_15_right(:,43:53),2);mean(AUC_15_left(:,43:53),2)]';
labels=ones(1,size(scores,2));
labels(size(AUC_15_right,1)+1:end)=0;
[X_15,Y_15,THRE,AUC_AUC_15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_15,Y_15)








%% 2212



AUC_17=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond4n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond4n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond4n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_17(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end


lim = prctile(AUC_17,75);
high_val=find(AUC_17>lim);

lim2 = prctile(AUC_17,25);
low_val=find(AUC_17<lim2);

h=zeros(10000,1);
h(high_val)=1;
h(low_val)=-1;
h(pixels_to_remove)=0;
figure;mimg(h,100,100,-1,1)


g=zeros(10000,1);
g(roi_circle)=1;
g(roi_bg_in)=-1;

k=g+h;
roi_high=find(k==2);
roi_low=find(k==-2);


circ_17=cond4n_dt_bl_right(roi_high,:,:)-1;
bg_17=cond4n_dt_bl_right(roi_low,:,:)-1;

%X_17=zeros(size(circ_17,1)+size(bg_17,1)+1,size(circ_17,3),80);
%Y_17=zeros(size(circ_17,1)+size(bg_17,1)+1,size(circ_17,3),80);
AUC_17_right=zeros(size(circ_17,3),80);

for j=25:75
    disp(j)
    for i=1:size(circ_17,3)
        scores=[circ_17(:,j,i);bg_17(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_17,1)+1:end)=0;
        [X_17,Y_17,THRE,AUC_17_right(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
figure;plot(mean(AUC_17_right,1))


circ_17=cond4n_dt_bl_left(roi_high,:,:)-1;
bg_17=cond4n_dt_bl_left(roi_low,:,:)-1;

%X_17=zeros(size(circ_17,1)+size(bg_17,1)+1,size(circ_17,3),80);
%Y_17=zeros(size(circ_17,1)+size(bg_17,1)+1,size(circ_17,3),80);
AUC_17_left=zeros(size(circ_17,3),80);

for j=25:75
    disp(j)
    for i=1:size(circ_17,3)
        scores=[circ_17(:,j,i);bg_17(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_17,1)+1:end)=0;
        [X_17,Y_17,THRE,AUC_17_left(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
hold on
plot(mean(AUC_17_left,1),'r')
xlim([20 68])

[n1 x1]=hist(mean(AUC_17_right(:,43:53),2),0:0.05:1);
[n2 x2]=hist(mean(AUC_17_left(:,43:53),2),0:0.05:1);
figure;bar(x1,[n1;n2]')


scores=[mean(AUC_17_right(:,43:53),2);mean(AUC_17_left(:,43:53),2)]';
labels=ones(1,size(scores,2));
labels(size(AUC_17_right,1)+1:end)=0;
[X_17,Y_17,THRE,AUC_AUC_17,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_17,Y_17)





%% 2212



AUC_5=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond2n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond2n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond2n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_5(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end


lim = prctile(AUC_5,75);
high_val=find(AUC_5>lim);

lim2 = prctile(AUC_5,25);
low_val=find(AUC_5<lim2);

h=zeros(10000,1);
h(high_val)=1;
h(low_val)=-1;
h(pixels_to_remove)=0;
figure;mimg(h,100,100,-1,1)


g=zeros(10000,1);
g(roi_circle)=1;
g(roi_bg_in)=-1;

k=g+h;
roi_high=find(k==2);
roi_low=find(k==-2);


circ_5=cond2n_dt_bl_right(roi_high,:,:)-1;
bg_5=cond2n_dt_bl_right(roi_low,:,:)-1;

%X_5=zeros(size(circ_5,1)+size(bg_5,1)+1,size(circ_5,3),80);
%Y_5=zeros(size(circ_5,1)+size(bg_5,1)+1,size(circ_5,3),80);
AUC_5_right=zeros(size(circ_5,3),80);

for j=25:75
    disp(j)
    for i=1:size(circ_5,3)
        scores=[circ_5(:,j,i);bg_5(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_5,1)+1:end)=0;
        [X_5,Y_5,THRE,AUC_5_right(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
figure;plot(mean(AUC_5_right,1))


circ_5=cond2n_dt_bl_left(roi_high,:,:)-1;
bg_5=cond2n_dt_bl_left(roi_low,:,:)-1;

%X_5=zeros(size(circ_5,1)+size(bg_5,1)+1,size(circ_5,3),80);
%Y_5=zeros(size(circ_5,1)+size(bg_5,1)+1,size(circ_5,3),80);
AUC_5_left=zeros(size(circ_5,3),80);

for j=25:75
    disp(j)
    for i=1:size(circ_5,3)
        scores=[circ_5(:,j,i);bg_5(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_5,1)+1:end)=0;
        [X_5,Y_5,THRE,AUC_5_left(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
hold on
plot(mean(AUC_5_left,1),'r')
xlim([20 68])

[n1 x1]=hist(mean(AUC_5_right(:,43:53),2),0:0.05:1);
[n2 x2]=hist(mean(AUC_5_left(:,43:53),2),0:0.05:1);
figure;bar(x1,[n1;n2]')


scores=[mean(AUC_5_right(:,43:53),2);mean(AUC_5_left(:,43:53),2)]';
labels=ones(1,size(scores,2));
labels(size(AUC_5_right,1)+1:end)=0;
[X_5,Y_5,THRE,AUC_AUC_5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_5,Y_5)






%% 2212



AUC_20=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond4n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond4n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond4n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_20(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end


lim = prctile(AUC_20,75);
high_val=find(AUC_20>lim);

lim2 = prctile(AUC_20,25);
low_val=find(AUC_20<lim2);

h=zeros(10000,1);
h(high_val)=1;
h(low_val)=-1;
h(pixels_to_remove)=0;
figure;mimg(h,100,100,-1,1)


g=zeros(10000,1);
g(roi_circle)=1;
g(roi_bg_in)=-1;

k=g+h;
roi_high=find(k==2);
roi_low=find(k==-2);


circ_20=cond4n_dt_bl_right(roi_high,:,:)-1;
bg_20=cond4n_dt_bl_right(roi_low,:,:)-1;

%X_20=zeros(size(circ_20,1)+size(bg_20,1)+1,size(circ_20,3),80);
%Y_20=zeros(size(circ_20,1)+size(bg_20,1)+1,size(circ_20,3),80);
AUC_20_right=zeros(size(circ_20,3),80);

for j=25:75
    disp(j)
    for i=1:size(circ_20,3)
        scores=[circ_20(:,j,i);bg_20(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_20,1)+1:end)=0;
        [X_20,Y_20,THRE,AUC_20_right(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
figure;plot(mean(AUC_20_right,1))


circ_20=cond4n_dt_bl_left(roi_high,:,:)-1;
bg_20=cond4n_dt_bl_left(roi_low,:,:)-1;

%X_20=zeros(size(circ_20,1)+size(bg_20,1)+1,size(circ_20,3),80);
%Y_20=zeros(size(circ_20,1)+size(bg_20,1)+1,size(circ_20,3),80);
AUC_20_left=zeros(size(circ_20,3),80);

for j=25:75
    disp(j)
    for i=1:size(circ_20,3)
        scores=[circ_20(:,j,i);bg_20(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_20,1)+1:end)=0;
        [X_20,Y_20,THRE,AUC_20_left(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
hold on
plot(mean(AUC_20_left,1),'r')
xlim([20 68])

[n1 x1]=hist(mean(AUC_20_right(:,43:53),2),0:0.05:1);
[n2 x2]=hist(mean(AUC_20_left(:,43:53),2),0:0.05:1);
figure;bar(x1,[n1;n2]')


scores=[mean(AUC_20_right(:,43:53),2);mean(AUC_20_left(:,43:53),2)]';
labels=ones(1,size(scores,2));
labels(size(AUC_20_right,1)+1:end)=0;
[X_20,Y_20,THRE,AUC_AUC_20,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_20,Y_20)


