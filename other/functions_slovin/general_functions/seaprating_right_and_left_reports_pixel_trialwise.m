
circ_10=cond2n_dt_bl(roi_circle,:,:)-1;
bg_10=cond2n_dt_bl(roi_bg_out,:,:)-1;

X_10=zeros(size(circ_10,1)+size(bg_10,1)+1,size(circ_10,3),80);
Y_10=zeros(size(circ_10,1)+size(bg_10,1)+1,size(circ_10,3),80);
AUC_10=zeros(size(circ_10,3),80);

for j=1:80
    disp(j)
    for i=1:size(circ_10,3)
        scores=[circ_10(:,j,i);bg_10(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_10,1)+1:end)=0;
        [X_10(:,i,j),Y_10(:,i,j),THRE,AUC_10(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end



for i=[18 20]
    figure
    mimg(mfilt2(cond2n_dt_bl_right(:,28:68,i)-1,100,100,1,'lm'),100,100,0e-3,1.5e-3);colormap(mapgeog)
end

[n1 x1]=hist(AUC_10_right,0.3:0.05:1);
[n2 x2]=hist(AUC_10_left,0.3:0.05:1);
figure;bar(x1,[n1;n2]')
legend('right','left')

ranksum(AUC_10_right,AUC_10_left)


scores=[AUC_10_right;AUC_10_left]';
labels=ones(1,size(scores,2));
labels(size(AUC_10_right,1)+1:end)=0;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

figure;plot(mean(AUC_10,1))
hold on
plot(mean(AUC_10_left,1),'r')
plot(mean(AUC_10_right,1),'g')




circ_5=cond2n_dt_bl(roi_circle,:,:)-1;
bg_5=cond2n_dt_bl(roi_bg_out,:,:)-1;

X_5=zeros(size(circ_5,1)+size(bg_5,1)+1,size(circ_5,3),80);
Y_5=zeros(size(circ_5,1)+size(bg_5,1)+1,size(circ_5,3),80);
AUC_5=zeros(size(circ_5,3),80);

for j=1:80
    disp(j)
    for i=1:size(circ_5,3)
        scores=[circ_5(:,j,i);bg_5(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_5,1)+1:end)=0;
        [X_5(:,i,j),Y_5(:,i,j),THRE,AUC_5(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
AUC_5_left=AUC_5(left2,:);
AUC_5_right=AUC_5(right2,:);

figure;plot(mean(AUC_5,1))
hold on
plot(mean(AUC_5_left,1),'r')
plot(mean(AUC_5_right,1),'g')







circ_5=cond2n_dt_bl(roi_circle,:,:)-1;
bg_5=cond2n_dt_bl(roi_bg_in,:,:)-1;

X_5=zeros(size(circ_5,1)+size(bg_5,1)+1,size(circ_5,3),80);
Y_5=zeros(size(circ_5,1)+size(bg_5,1)+1,size(circ_5,3),80);
AUC_5=zeros(size(circ_5,3),80);

for j=1:80
    disp(j)
    for i=1:size(circ_5,3)
        scores=[circ_5(:,j,i);bg_5(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_5,1)+1:end)=0;
        [X_5(:,i,j),Y_5(:,i,j),THRE,AUC_5(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
AUC_5_left=AUC_5(left2,:);
AUC_5_right=AUC_5(right2,:);

figure;plot(mean(AUC_5,1))
hold on
plot(mean(AUC_5_left,1),'r')
plot(mean(AUC_5_right,1),'g')





circ_17=cond4n_dt_bl(roi_circle,:,:)-1;
bg_17=cond4n_dt_bl(roi_bg_in,:,:)-1;

X_17=zeros(size(circ_17,1)+size(bg_17,1)+1,size(circ_17,3),80);
Y_17=zeros(size(circ_17,1)+size(bg_17,1)+1,size(circ_17,3),80);
AUC_17=zeros(size(circ_17,3),80);

for j=20:80
    disp(j)
    for i=1:size(circ_17,3)
        scores=[circ_17(:,j,i);bg_17(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_17,1)+1:end)=0;
        [X_17,Y_17,THRE,AUC_17(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
AUC_17_left=AUC_17(left4,:);
AUC_17_right=AUC_17(right4,:);


figure;plot(mean(AUC_17,1))
hold on
plot(mean(AUC_17_left,1),'r')
plot(mean(AUC_17_right,1),'g')
xlim([20 68])





circ_20=cond2n_dt_bl(roi_circle,:,:)-1;
bg_20=cond2n_dt_bl(roi_bg_in,:,:)-1;

X_20=zeros(size(circ_20,1)+size(bg_20,1)+1,size(circ_20,3),80);
Y_20=zeros(size(circ_20,1)+size(bg_20,1)+1,size(circ_20,3),80);
AUC_20=zeros(size(circ_20,3),80);

for j=25:70
    disp(j)
    for i=1:size(circ_20,3)
        scores=[circ_20(:,j,i);bg_20(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_20,1)+1:end)=0;
        [X_20(:,i,j),Y_20(:,i,j),THRE,AUC_20(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
AUC_20_left=AUC_20(left2,:);
AUC_20_right=AUC_20(right2,:);

figure;plot(mean(AUC_20,1))
hold on
plot(mean(AUC_20_left,1),'r')
plot(mean(AUC_20_right,1),'g')
xlim([25 68])



circ_15=cond24n_dt_bl(roi_circle,:,:)-1;
bg_15=cond24n_dt_bl(roi_bg_in,:,:)-1;

X_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,3),80);
Y_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,3),80);
AUC_15=zeros(size(circ_15,3),80);

for j=25:70
    disp(j)
    for i=1:size(circ_15,3)
        scores=[circ_15(:,j,i);bg_15(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_15,1)+1:end)=0;
        [X_15(:,i,j),Y_15(:,i,j),THRE,AUC_15(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
AUC_15_left=AUC_15(left24,:);
AUC_15_right=AUC_15(right24,:);

figure;plot(mean(AUC_15,1))
hold on
plot(mean(AUC_15_left,1),'r')
plot(mean(AUC_15_right,1),'g')
xlim([25 68])



circ_15=cond2n_dt_bl(roi_circle,:,:)-1;
bg_15=cond2n_dt_bl([roi_bg_in;roi_bg_out],:,:)-1;

X_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,3),80);
Y_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,3),80);
AUC_15=zeros(size(circ_15,3),80);

for j=25:70
    disp(j)
    for i=1:size(circ_15,3)
        scores=[circ_15(:,j,i);bg_15(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_15,1)+1:end)=0;
        [X_15(:,i,j),Y_15(:,i,j),THRE,AUC_15(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
AUC_15_left=AUC_15(left2,:);
AUC_15_right=AUC_15(right2,:);

figure;plot(mean(AUC_15,1))
hold on
plot(mean(AUC_15_left,1),'r')
plot(mean(AUC_15_right,1),'g')
xlim([25 68])


circ_12=cond2n_dt_bl(roi_circle,:,:)-1;
bg_12=cond2n_dt_bl([roi_bg_in;roi_bg_out],:,:)-1;

X_12=zeros(size(circ_12,1)+size(bg_12,1)+1,size(circ_12,3),80);
Y_12=zeros(size(circ_12,1)+size(bg_12,1)+1,size(circ_12,3),80);
AUC_12=zeros(size(circ_12,3),80);

for j=25:70
    disp(j)
    for i=1:size(circ_12,3)
        scores=[circ_12(:,j,i);bg_12(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_12,1)+1:end)=0;
        [X_12(:,i,j),Y_12(:,i,j),THRE,AUC_12(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
AUC_12_left=AUC_12(left2,:);
AUC_12_right=AUC_12(right2,:);

figure;plot(mean(AUC_12,1))
hold on
plot(mean(AUC_12_left,1),'r')
plot(mean(AUC_12_right,1),'g')
xlim([25 68])




%legolas
circ_15=cond2n_dt_bl_right(roi_contour,:,:)-1;
bg_15=cond2n_dt_bl_right(roi_bg_in,:,:)-1;

%X_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,3),80);
%Y_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,3),80);
AUC_15_right=zeros(size(circ_15,3),80);

for j=1:80
    disp(j)
    for i=1:size(circ_15,3)
        scores=[circ_15(:,j,i);bg_15(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_15,1)+1:end)=0;
        [X_15,Y_15,THRE,AUC_15_right(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
figure;plot(mean(AUC_15_right,1))


circ_15=cond2n_dt_bl_left(roi_contour,:,:)-1;
bg_15=cond2n_dt_bl_left(roi_bg_in,:,:)-1;

%X_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,3),80);
%Y_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,3),80);
AUC_15_left=zeros(size(circ_15,3),80);

for j=1:80
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



%
circ_20=cond4n_dt_bl_right(roi_contour,:,:)-1;
bg_20=cond4n_dt_bl_right(roi_bg_in,:,:)-1;

%X_20=zeros(size(circ_20,1)+size(bg_20,1)+1,size(circ_20,3),80);
%Y_20=zeros(size(circ_20,1)+size(bg_20,1)+1,size(circ_20,3),80);
AUC_20_right=zeros(size(circ_20,3),80);

for j=1:80
    disp(j)
    for i=1:size(circ_20,3)
        scores=[circ_20(:,j,i);bg_20(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_20,1)+1:end)=0;
        [X_20,Y_20,THRE,AUC_20_right(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
figure;plot(mean(AUC_20_right,1))


circ_20=cond4n_dt_bl_left(roi_contour,:,:)-1;
bg_20=cond4n_dt_bl_left(roi_bg_in,:,:)-1;

%X_20=zeros(size(circ_20,1)+size(bg_20,1)+1,size(circ_20,3),80);
%Y_20=zeros(size(circ_20,1)+size(bg_20,1)+1,size(circ_20,3),80);
AUC_20_left=zeros(size(circ_20,3),80);

for j=1:80
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





circ_25=cond2n_dt_bl_right(roi_contour,:,:)-1;
bg_25=cond2n_dt_bl_right(roi_bg_in,:,:)-1;

%X_25=zeros(size(circ_25,1)+size(bg_25,1)+1,size(circ_25,3),80);
%Y_25=zeros(size(circ_25,1)+size(bg_25,1)+1,size(circ_25,3),80);
AUC_25_right=zeros(size(circ_25,3),80);

for j=1:80
    disp(j)
    for i=1:size(circ_25,3)
        scores=[circ_25(:,j,i);bg_25(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_25,1)+1:end)=0;
        [X_25,Y_25,THRE,AUC_25_right(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
figure;plot(mean(AUC_25_right,1))


circ_25=cond2n_dt_bl_left(roi_contour,:,:)-1;
bg_25=cond2n_dt_bl_left(roi_bg_in,:,:)-1;

%X_25=zeros(size(circ_25,1)+size(bg_25,1)+1,size(circ_25,3),80);
%Y_25=zeros(size(circ_25,1)+size(bg_25,1)+1,size(circ_25,3),80);
AUC_25_left=zeros(size(circ_25,3),80);

for j=1:80
    disp(j)
    for i=1:size(circ_25,3)
        scores=[circ_25(:,j,i);bg_25(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_25,1)+1:end)=0;
        [X_25,Y_25,THRE,AUC_25_left(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
hold on
plot(mean(AUC_25_left,1),'r')







circ_15=cond4n_dt_bl_right(roi_contour,:,:)-1;
bg_15=cond4n_dt_bl_right(roi_bg_in,:,:)-1;

%X_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,3),80);
%Y_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,3),80);
AUC_15_right=zeros(size(circ_15,3),80);

for j=25:70
    disp(j)
    for i=1:size(circ_15,3)
        scores=[circ_15(:,j,i);bg_15(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_15,1)+1:end)=0;
        [X_15,Y_15,THRE,AUC_15_right(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
figure;plot(mean(AUC_15_right,1))


circ_15=cond4n_dt_bl_left(roi_contour,:,:)-1;
bg_15=cond4n_dt_bl_left(roi_bg_in,:,:)-1;

%X_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,3),80);
%Y_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,3),80);
AUC_15_left=zeros(size(circ_15,3),80);

for j=25:70
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
xlim([25 68])





circ_20=cond4n_dt_bl_right(roi_contour,:,:)-1;
bg_20=cond4n_dt_bl_right(roi_bg_in,:,:)-1;

%X_20=zeros(size(circ_20,1)+size(bg_20,1)+1,size(circ_20,3),80);
%Y_20=zeros(size(circ_20,1)+size(bg_20,1)+1,size(circ_20,3),80);
AUC_20_right=zeros(size(circ_20,3),80);

for j=20:80
    disp(j)
    for i=1:size(circ_20,3)
        scores=[circ_20(:,j,i);bg_20(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_20,1)+1:end)=0;
        [X_20,Y_20,THRE,AUC_20_right(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
figure;plot(mean(AUC_20_right,1))


circ_20=cond4n_dt_bl_left(roi_contour,:,:)-1;
bg_20=cond4n_dt_bl_left(roi_bg_in,:,:)-1;

%X_20=zeros(size(circ_20,1)+size(bg_20,1)+1,size(circ_20,3),80);
%Y_20=zeros(size(circ_20,1)+size(bg_20,1)+1,size(circ_20,3),80);
AUC_20_left=zeros(size(circ_20,3),80);

for j=20:80
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






circ_10=cond2n_dt_bl_right(roi_contour,:,:)-1;
bg_10=cond2n_dt_bl_right(roi_bg_in,:,:)-1;

%X_10=zeros(size(circ_10,1)+size(bg_10,1)+1,size(circ_10,3),80);
%Y_10=zeros(size(circ_10,1)+size(bg_10,1)+1,size(circ_10,3),80);
AUC_10_right=zeros(size(circ_10,3),80);

for j=20:80
    disp(j)
    for i=1:size(circ_10,3)
        scores=[circ_10(:,j,i);bg_10(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_10,1)+1:end)=0;
        [X_10,Y_10,THRE,AUC_10_right(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
figure;plot(mean(AUC_10_right,1))


circ_10=cond2n_dt_bl_left(roi_contour,:,:)-1;
bg_10=cond2n_dt_bl_left(roi_bg_in,:,:)-1;

%X_10=zeros(size(circ_10,1)+size(bg_10,1)+1,size(circ_10,3),80);
%Y_10=zeros(size(circ_10,1)+size(bg_10,1)+1,size(circ_10,3),80);
AUC_10_left=zeros(size(circ_10,3),80);

for j=20:80
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






circ_17=cond2n_dt_bl_right(roi_contour,:,:)-1;
bg_17=cond2n_dt_bl_right(roi_bg_in,:,:)-1;

%X_17=zeros(size(circ_17,1)+size(bg_17,1)+1,size(circ_17,3),80);
%Y_17=zeros(size(circ_17,1)+size(bg_17,1)+1,size(circ_17,3),80);
AUC_17_right=zeros(size(circ_17,3),80);

for j=25:70
    disp(j)
    for i=1:size(circ_17,3)
        scores=[circ_17(:,j,i);bg_17(:,j,i)]';
        labels=ones(1,size(scores,2));
        labels(size(circ_17,1)+1:end)=0;
        [X_17,Y_17,THRE,AUC_17_right(i,j),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
    end    
end
figure;plot(mean(AUC_17_right,1))


circ_17=cond2n_dt_bl_left(roi_contour,:,:)-1;
bg_17=cond2n_dt_bl_left(roi_bg_in,:,:)-1;

%X_17=zeros(size(circ_17,1)+size(bg_17,1)+1,size(circ_17,3),80);
%Y_17=zeros(size(circ_17,1)+size(bg_17,1)+1,size(circ_17,3),80);
AUC_17_left=zeros(size(circ_17,3),80);

for j=25:70
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





