
%% 0501
AUC_10=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond2n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond2n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond2n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_10(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

[n1 x1]=hist(AUC_10(roi_circle),0:0.05:1);
[n2 x2]=hist(AUC_10(roi_bg_out),0:0.05:1);
figure;bar(x1,[n1/size(roi_circle,1);n2/size(roi_bg_out,1)]')
ranksum(AUC_10(roi_circle),AUC_10(roi_bg_out))

scores=[AUC_10(roi_circle);AUC_10(roi_bg_out)]';
labels=ones(1,size(scores,2));
labels(size(AUC_10(roi_circle),1)+1:end)=0;
[X_10,Y_10,THRE,AUC_AUC_10,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_10,Y_10)



AUC_5=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond2n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond2n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond2n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_5(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

[n1 x1]=hist(AUC_5(roi_circle),0:0.05:1);
[n2 x2]=hist(AUC_5(roi_bg_out),0:0.05:1);
figure;bar(x1,[n1/size(roi_circle,1);n2/size(roi_bg_out,1)]')
ranksum(AUC_5(roi_circle),AUC_5(roi_bg_out))

scores=[AUC_5(roi_circle);AUC_5(roi_bg_out)]';
labels=ones(1,size(scores,2));
labels(size(AUC_5(roi_circle),1)+1:end)=0;
[X_5,Y_5,THRE,AUC_AUC_5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_5,Y_5)



AUC_20=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond4n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond4n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond4n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_20(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

[n1 x1]=hist(AUC_20(roi_circle),0:0.05:1);
[n2 x2]=hist(AUC_20(roi_bg_out),0:0.05:1);
figure;bar(x1,[n1/size(roi_circle,1);n2/size(roi_bg_out,1)]')
ranksum(AUC_20(roi_circle),AUC_20(roi_bg_out))

scores=[AUC_20(roi_circle);AUC_20(roi_bg_out)]';
labels=ones(1,size(scores,2));
labels(size(AUC_20(roi_circle),1)+1:end)=0;
[X_20,Y_20,THRE,AUC_AUC_20,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_20,Y_20)




AUC_15=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond4n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond4n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond4n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_15(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

[n1 x1]=hist(AUC_15(roi_circle),0:0.05:1);
[n2 x2]=hist(AUC_15(roi_bg_out),0:0.05:1);
figure;bar(x1,[n1/size(roi_circle,1);n2/size(roi_bg_out,1)]')
ranksum(AUC_15(roi_circle),AUC_15(roi_bg_out))

scores=[AUC_15(roi_circle);AUC_15(roi_bg_out)]';
labels=ones(1,size(scores,2));
labels(size(AUC_15(roi_circle),1)+1:end)=0;
[X_15,Y_15,THRE,AUC_AUC_15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_15,Y_15)



%% 2212


AUC_5=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond2n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond2n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond2n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_5(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

[n1 x1]=hist(AUC_5(roi_circle),0:0.05:1);
[n2 x2]=hist(AUC_5(roi_bg_in),0:0.05:1);
figure;bar(x1,[n1/size(roi_circle,1);n2/size(roi_bg_in,1)]')
ranksum(AUC_5(roi_circle),AUC_5(roi_bg_in))

scores=[AUC_5(roi_circle);AUC_5(roi_bg_in)]';
labels=ones(1,size(scores,2));
labels(size(AUC_5(roi_circle),1)+1:end)=0;
[X_5,Y_5,THRE,AUC_AUC_5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_5,Y_5)




AUC_20=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond4n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond4n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond4n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_20(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

[n1 x1]=hist(AUC_20(roi_circle),0:0.05:1);
[n2 x2]=hist(AUC_20(roi_bg_in),0:0.05:1);
figure;bar(x1,[n1/size(roi_circle,1);n2/size(roi_bg_in,1)]')
ranksum(AUC_20(roi_circle),AUC_20(roi_bg_in))

scores=[AUC_20(roi_circle);AUC_20(roi_bg_in)]';
labels=ones(1,size(scores,2));
labels(size(AUC_20(roi_circle),1)+1:end)=0;
[X_20,Y_20,THRE,AUC_AUC_20,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_20,Y_20)




AUC_10=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond2n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond2n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond2n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_10(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

[n1 x1]=hist(AUC_10(roi_circle),0:0.05:1);
[n2 x2]=hist(AUC_10(roi_bg_in),0:0.05:1);
figure;bar(x1,[n1/size(roi_circle,1);n2/size(roi_bg_in,1)]')
ranksum(AUC_10(roi_circle),AUC_10(roi_bg_in))

scores=[AUC_10(roi_circle);AUC_10(roi_bg_in)]';
labels=ones(1,size(scores,2));
labels(size(AUC_10(roi_circle),1)+1:end)=0;
[X_10,Y_10,THRE,AUC_AUC_10,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_10,Y_10)



AUC_17=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond4n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond4n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond4n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_17(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

[n1 x1]=hist(AUC_17(roi_circle),0:0.05:1);
[n2 x2]=hist(AUC_17(roi_bg_in),0:0.05:1);
figure;bar(x1,[n1/size(roi_circle,1);n2/size(roi_bg_in,1)]')
ranksum(AUC_17(roi_circle),AUC_17(roi_bg_in))

scores=[AUC_17(roi_circle);AUC_17(roi_bg_in)]';
labels=ones(1,size(scores,2));
labels(size(AUC_17(roi_circle),1)+1:end)=0;
[X_17,Y_17,THRE,AUC_AUC_17,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_17,Y_17)




%% 1412

AUC_10=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond2n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond2n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond2n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_10(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

[n1 x1]=hist(AUC_10(roi_circle),0:0.05:1);
[n2 x2]=hist(AUC_10(roi_bg_in),0:0.05:1);
figure;bar(x1,[n1/size(roi_circle,1);n2/size(roi_bg_in,1)]')
ranksum(AUC_10(roi_circle),AUC_10(roi_bg_in))

scores=[AUC_10(roi_circle);AUC_10(roi_bg_in)]';
labels=ones(1,size(scores,2));
labels(size(AUC_10(roi_circle),1)+1:end)=0;
[X_10,Y_10,THRE,AUC_AUC_10,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_10,Y_10)



AUC_17=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond4n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond4n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond4n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_17(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

[n1 x1]=hist(AUC_17(roi_circle),0:0.05:1);
[n2 x2]=hist(AUC_17(roi_bg_in),0:0.05:1);
figure;bar(x1,[n1/size(roi_circle,1);n2/size(roi_bg_in,1)]')
ranksum(AUC_17(roi_circle),AUC_17(roi_bg_in))

scores=[AUC_17(roi_circle);AUC_17(roi_bg_in)]';
labels=ones(1,size(scores,2));
labels(size(AUC_17(roi_circle),1)+1:end)=0;
[X_17,Y_17,THRE,AUC_AUC_17,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_17,Y_17)




AUC_20=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond2n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond2n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond2n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_20(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

[n1 x1]=hist(AUC_20(roi_circle),0:0.05:1);
[n2 x2]=hist(AUC_20(roi_bg_in),0:0.05:1);
figure;bar(x1,[n1/size(roi_circle,1);n2/size(roi_bg_in,1)]')
ranksum(AUC_20(roi_circle),AUC_20(roi_bg_in))

scores=[AUC_20(roi_circle);AUC_20(roi_bg_in)]';
labels=ones(1,size(scores,2));
labels(size(AUC_20(roi_circle),1)+1:end)=0;
[X_20,Y_20,THRE,AUC_AUC_20,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_20,Y_20)



AUC_5=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond4n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond4n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond4n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_5(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

[n1 x1]=hist(AUC_5(roi_circle),0:0.05:1);
[n2 x2]=hist(AUC_5(roi_bg_in),0:0.05:1);
figure;bar(x1,[n1/size(roi_circle,1);n2/size(roi_bg_in,1)]')
ranksum(AUC_5(roi_circle),AUC_5(roi_bg_in))

scores=[AUC_5(roi_circle);AUC_5(roi_bg_in)]';
labels=ones(1,size(scores,2));
labels(size(AUC_5(roi_circle),1)+1:end)=0;
[X_5,Y_5,THRE,AUC_AUC_5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_5,Y_5)





AUC_15=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond2n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond2n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond2n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_15(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

[n1 x1]=hist(AUC_15(roi_circle),0:0.05:1);
[n2 x2]=hist(AUC_15(roi_bg_in),0:0.05:1);
figure;bar(x1,[n1/size(roi_circle,1);n2/size(roi_bg_in,1)]')
ranksum(AUC_15(roi_circle),AUC_15(roi_bg_in))

scores=[AUC_15(roi_circle);AUC_15(roi_bg_in)]';
labels=ones(1,size(scores,2));
labels(size(AUC_15(roi_circle),1)+1:end)=0;
[X_15,Y_15,THRE,AUC_AUC_15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_15,Y_15)



AUC_15_2=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond4n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond4n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond4n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_15_2(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

[n1 x1]=hist(AUC_15_2(roi_circle),0:0.05:1);
[n2 x2]=hist(AUC_15_2(roi_bg_in),0:0.05:1);
figure;bar(x1,[n1/size(roi_circle,1);n2/size(roi_bg_in,1)]')
ranksum(AUC_15_2(roi_circle),AUC_15_2(roi_bg_in))

scores=[AUC_15_2(roi_circle);AUC_15_2(roi_bg_in)]';
labels=ones(1,size(scores,2));
labels(size(AUC_15_2(roi_circle),1)+1:end)=0;
[X_15_2,Y_15_2,THRE,AUC_AUC_15_2,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_15_2,Y_15_2)



%% 2511


AUC_10=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond2n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond2n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond2n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_10(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

[n1 x1]=hist(AUC_10(roi_circle_diff),0:0.05:1);
[n2 x2]=hist(AUC_10(roi_bg_in),0:0.05:1);
figure;bar(x1,[n1/size(roi_circle_diff,1);n2/size(roi_bg_in,1)]')
ranksum(AUC_10(roi_circle_diff),AUC_10(roi_bg_in))

scores=[AUC_10(roi_circle_diff);AUC_10(roi_bg_in)]';
labels=ones(1,size(scores,2));
labels(size(AUC_10(roi_circle_diff),1)+1:end)=0;
[X_10,Y_10,THRE,AUC_AUC_10,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_10,Y_10)



AUC_15=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond4n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond4n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond4n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_15(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

[n1 x1]=hist(AUC_15(roi_circle_diff),0:0.05:1);
[n2 x2]=hist(AUC_15(roi_bg_in),0:0.05:1);
figure;bar(x1,[n1/size(roi_circle_diff,1);n2/size(roi_bg_in,1)]')
ranksum(AUC_15(roi_circle_diff),AUC_15(roi_bg_in))

scores=[AUC_15(roi_circle_diff);AUC_15(roi_bg_in)]';
labels=ones(1,size(scores,2));
labels(size(AUC_15(roi_circle_diff),1)+1:end)=0;
[X_15,Y_15,THRE,AUC_AUC_15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_15,Y_15)





AUC_17=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond2n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond2n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond2n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_17(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

[n1 x1]=hist(AUC_17(roi_circle_diff),0:0.05:1);
[n2 x2]=hist(AUC_17(roi_bg_in),0:0.05:1);
figure;bar(x1,[n1/size(roi_circle_diff,1);n2/size(roi_bg_in,1)]')
ranksum(AUC_17(roi_circle_diff),AUC_17(roi_bg_in))

scores=[AUC_17(roi_circle_diff);AUC_17(roi_bg_in)]';
labels=ones(1,size(scores,2));
labels(size(AUC_17(roi_circle_diff),1)+1:end)=0;
[X_17,Y_17,THRE,AUC_AUC_17,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_17,Y_17)



AUC_20=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond4n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond4n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond4n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_20(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

[n1 x1]=hist(AUC_20(roi_circle_diff),0:0.05:1);
[n2 x2]=hist(AUC_20(roi_bg_in),0:0.05:1);
figure;bar(x1,[n1/size(roi_circle_diff,1);n2/size(roi_bg_in,1)]')
ranksum(AUC_20(roi_circle_diff),AUC_20(roi_bg_in))

scores=[AUC_20(roi_circle_diff);AUC_20(roi_bg_in)]';
labels=ones(1,size(scores,2));
labels(size(AUC_20(roi_circle_diff),1)+1:end)=0;
[X_20,Y_20,THRE,AUC_AUC_20,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_20,Y_20)



AUC_25=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond4n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond4n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond4n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_25(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

[n1 x1]=hist(AUC_25(roi_circle_diff),0:0.05:1);
[n2 x2]=hist(AUC_25(roi_bg_in),0:0.05:1);
figure;bar(x1,[n1/size(roi_circle_diff,1);n2/size(roi_bg_in,1)]')
ranksum(AUC_25(roi_circle_diff),AUC_25(roi_bg_in))

scores=[AUC_25(roi_circle_diff);AUC_25(roi_bg_in)]';
labels=ones(1,size(scores,2));
labels(size(AUC_25(roi_circle_diff),1)+1:end)=0;
[X_25,Y_25,THRE,AUC_AUC_25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_25,Y_25)



%% 1811

AUC_15=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond4n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond4n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond4n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_15(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

[n1 x1]=hist(AUC_15(roi_circle_diff),0:0.05:1);
[n2 x2]=hist(AUC_15(roi_bg_in),0:0.05:1);
figure;bar(x1,[n1/size(roi_circle_diff,1);n2/size(roi_bg_in,1)]')
ranksum(AUC_15(roi_circle_diff),AUC_15(roi_bg_in))

scores=[AUC_15(roi_circle_diff);AUC_15(roi_bg_in)]';
labels=ones(1,size(scores,2));
labels(size(AUC_15(roi_circle_diff),1)+1:end)=0;
[X_15,Y_15,THRE,AUC_AUC_15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_15,Y_15)



AUC_10=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond2n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond2n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond2n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_10(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

[n1 x1]=hist(AUC_10(roi_circle_diff),0:0.05:1);
[n2 x2]=hist(AUC_10(roi_bg_in),0:0.05:1);
figure;bar(x1,[n1/size(roi_circle_diff,1);n2/size(roi_bg_in,1)]')
ranksum(AUC_10(roi_circle_diff),AUC_10(roi_bg_in))

scores=[AUC_10(roi_circle_diff);AUC_10(roi_bg_in)]';
labels=ones(1,size(scores,2));
labels(size(AUC_10(roi_circle_diff),1)+1:end)=0;
[X_10,Y_10,THRE,AUC_AUC_10,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_10,Y_10)



AUC_20=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond4n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond4n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond4n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_20(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

[n1 x1]=hist(AUC_20(roi_circle_diff),0:0.05:1);
[n2 x2]=hist(AUC_20(roi_bg_in),0:0.05:1);
figure;bar(x1,[n1/size(roi_circle_diff,1);n2/size(roi_bg_in,1)]')
ranksum(AUC_20(roi_circle_diff),AUC_20(roi_bg_in))

scores=[AUC_20(roi_circle_diff);AUC_20(roi_bg_in)]';
labels=ones(1,size(scores,2));
labels(size(AUC_20(roi_circle_diff),1)+1:end)=0;
[X_20,Y_20,THRE,AUC_AUC_20,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_20,Y_20)






AUC_17=zeros(10000,1);
for i=1:10000
    scores=[squeeze(mean(cond2n_dt_bl_right(i,43:53,:),2));squeeze(mean(cond2n_dt_bl_left(i,43:53,:),2))]';
    labels=ones(1,size(scores,2));
    labels(size(cond2n_dt_bl_right,3)+1:end)=0;
    [X,Y,THRE,AUC_17(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

[n1 x1]=hist(AUC_17(roi_circle_diff),0:0.05:1);
[n2 x2]=hist(AUC_17(roi_bg_in),0:0.05:1);
figure;bar(x1,[n1/size(roi_circle_diff,1);n2/size(roi_bg_in,1)]')
ranksum(AUC_17(roi_circle_diff),AUC_17(roi_bg_in))

scores=[AUC_17(roi_circle_diff);AUC_17(roi_bg_in)]';
labels=ones(1,size(scores,2));
labels(size(AUC_17(roi_circle_diff),1)+1:end)=0;
[X_17,Y_17,THRE,AUC_AUC_17,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_17,Y_17)







