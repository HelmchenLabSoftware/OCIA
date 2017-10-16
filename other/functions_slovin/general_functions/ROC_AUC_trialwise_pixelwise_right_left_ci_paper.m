%% 2511

%d

circ_10_right=squeeze(mean(cond2n_dt_bl_right(roi_contour,48:58,:),2))-1;
circ_10_left=squeeze(mean(cond2n_dt_bl_left(roi_contour,48:58,:),2))-1;
bg_10_right=squeeze(mean(cond2n_dt_bl_right(roi_bg_in,48:58,:),2))-1;
bg_10_left=squeeze(mean(cond2n_dt_bl_left(roi_bg_in,48:58,:),2))-1;
circ_15_right=squeeze(mean(cond4n_dt_bl_right(roi_contour,48:58,:),2))-1;
circ_15_left=squeeze(mean(cond4n_dt_bl_left(roi_contour,48:58,:),2))-1;
bg_15_right=squeeze(mean(cond4n_dt_bl_right(roi_bg_in,48:58,:),2))-1;
bg_15_left=squeeze(mean(cond4n_dt_bl_left(roi_bg_in,48:58,:),2))-1;

%e

circ_17_right=squeeze(mean(cond2n_dt_bl_right(roi_contour,48:58,:),2))-1;
circ_17_left=squeeze(mean(cond2n_dt_bl_left(roi_contour,48:58,:),2))-1;
bg_17_right=squeeze(mean(cond2n_dt_bl_right(roi_bg_in,48:58,:),2))-1;
bg_17_left=squeeze(mean(cond2n_dt_bl_left(roi_bg_in,48:58,:),2))-1;
circ_20_right=squeeze(mean(cond4n_dt_bl_right(roi_contour,48:58,:),2))-1;
circ_20_left=squeeze(mean(cond4n_dt_bl_left(roi_contour,48:58,:),2))-1;
bg_20_right=squeeze(mean(cond4n_dt_bl_right(roi_bg_in,48:58,:),2))-1;
bg_20_left=squeeze(mean(cond4n_dt_bl_left(roi_bg_in,48:58,:),2))-1;

%f

circ_25_right=squeeze(mean(cond4n_dt_bl_right(roi_contour,48:58,:),2))-1;
circ_25_left=squeeze(mean(cond4n_dt_bl_left(roi_contour,48:58,:),2))-1;
bg_25_right=squeeze(mean(cond4n_dt_bl_right(roi_bg_in,48:58,:),2))-1;
bg_25_left=squeeze(mean(cond4n_dt_bl_left(roi_bg_in,48:58,:),2))-1;


X_10_right=zeros(size(circ_10_right,1)+size(bg_10_right,1)+1,size(circ_10_right,2));
Y_10_right=zeros(size(circ_10_right,1)+size(bg_10_right,1)+1,size(circ_10_right,2));
AUC_10_right=zeros(size(circ_10_right,2),1);
for i=1:size(circ_10_right,2)
    scores=[circ_10_right(:,i);bg_10_right(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_10_right,1)+1:end)=0;
    [X_10_right(:,i),Y_10_right(:,i),THRE,AUC_10_right(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_15_right=zeros(size(circ_15_right,1)+size(bg_15_right,1)+1,size(circ_15_right,2));
Y_15_right=zeros(size(circ_15_right,1)+size(bg_15_right,1)+1,size(circ_15_right,2));
AUC_15_right=zeros(size(circ_15_right,2),1);
for i=1:size(circ_15_right,2)
    scores=[circ_15_right(:,i);bg_15_right(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_15_right,1)+1:end)=0;
    [X_15_right(:,i),Y_15_right(:,i),THRE,AUC_15_right(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_17_right=zeros(size(circ_17_right,1)+size(bg_17_right,1)+1,size(circ_17_right,2));
Y_17_right=zeros(size(circ_17_right,1)+size(bg_17_right,1)+1,size(circ_17_right,2));
AUC_17_right=zeros(size(circ_17_right,2),1);
for i=1:size(circ_17_right,2)
    scores=[circ_17_right(:,i);bg_17_right(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_17_right,1)+1:end)=0;
    [X_17_right(:,i),Y_17_right(:,i),THRE,AUC_17_right(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_20_right=zeros(size(circ_20_right,1)+size(bg_20_right,1)+1,size(circ_20_right,2));
Y_20_right=zeros(size(circ_20_right,1)+size(bg_20_right,1)+1,size(circ_20_right,2));
AUC_20_right=zeros(size(circ_20_right,2),1);
for i=1:size(circ_20_right,2)
    scores=[circ_20_right(:,i);bg_20_right(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_20_right,1)+1:end)=0;
    [X_20_right(:,i),Y_20_right(:,i),THRE,AUC_20_right(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_25_right=zeros(size(circ_25_right,1)+size(bg_25_right,1)+1,size(circ_25_right,2));
Y_25_right=zeros(size(circ_25_right,1)+size(bg_25_right,1)+1,size(circ_25_right,2));
AUC_25_right=zeros(size(circ_25_right,2),1);
for i=1:size(circ_25_right,2)
    scores=[circ_25_right(:,i);bg_25_right(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_25_right,1)+1:end)=0;
    [X_25_right(:,i),Y_25_right(:,i),THRE,AUC_25_right(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end   

X_10_left=zeros(size(circ_10_left,1)+size(bg_10_left,1)+1,size(circ_10_left,2));
Y_10_left=zeros(size(circ_10_left,1)+size(bg_10_left,1)+1,size(circ_10_left,2));
AUC_10_left=zeros(size(circ_10_left,2),1);
for i=1:size(circ_10_left,2)
    scores=[circ_10_left(:,i);bg_10_left(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_10_left,1)+1:end)=0;
    [X_10_left(:,i),Y_10_left(:,i),THRE,AUC_10_left(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_15_left=zeros(size(circ_15_left,1)+size(bg_15_left,1)+1,size(circ_15_left,2));
Y_15_left=zeros(size(circ_15_left,1)+size(bg_15_left,1)+1,size(circ_15_left,2));
AUC_15_left=zeros(size(circ_15_left,2),1);
for i=1:size(circ_15_left,2)
    scores=[circ_15_left(:,i);bg_15_left(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_15_left,1)+1:end)=0;
    [X_15_left(:,i),Y_15_left(:,i),THRE,AUC_15_left(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_17_left=zeros(size(circ_17_left,1)+size(bg_17_left,1)+1,size(circ_17_left,2));
Y_17_left=zeros(size(circ_17_left,1)+size(bg_17_left,1)+1,size(circ_17_left,2));
AUC_17_left=zeros(size(circ_17_left,2),1);
for i=1:size(circ_17_left,2)
    scores=[circ_17_left(:,i);bg_17_left(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_17_left,1)+1:end)=0;
    [X_17_left(:,i),Y_17_left(:,i),THRE,AUC_17_left(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_20_left=zeros(size(circ_20_left,1)+size(bg_20_left,1)+1,size(circ_20_left,2));
Y_20_left=zeros(size(circ_20_left,1)+size(bg_20_left,1)+1,size(circ_20_left,2));
AUC_20_left=zeros(size(circ_20_left,2),1);
for i=1:size(circ_20_left,2)
    scores=[circ_20_left(:,i);bg_20_left(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_20_left,1)+1:end)=0;
    [X_20_left(:,i),Y_20_left(:,i),THRE,AUC_20_left(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_25_left=zeros(size(circ_25_left,1)+size(bg_25_left,1)+1,size(circ_25_left,2));
Y_25_left=zeros(size(circ_25_left,1)+size(bg_25_left,1)+1,size(circ_25_left,2));
AUC_25_left=zeros(size(circ_25_left,2),1);
for i=1:size(circ_25_left,2)
    scores=[circ_25_left(:,i);bg_25_left(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_25_left,1)+1:end)=0;
    [X_25_left(:,i),Y_25_left(:,i),THRE,AUC_25_left(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    




%% 1811

%c

circ_5_right=squeeze(mean(cond2n_dt_bl_right(roi_contour,43:53,:),2))-1;
circ_5_left=squeeze(mean(cond2n_dt_bl_left(roi_contour,43:53,:),2))-1;
bg_5_right=squeeze(mean(cond2n_dt_bl_right(roi_bg_in,43:53,:),2))-1;
bg_5_left=squeeze(mean(cond2n_dt_bl_left(roi_bg_in,43:53,:),2))-1;
circ_15_right=squeeze(mean(cond4n_dt_bl_right(roi_contour,43:53,:),2))-1;
circ_15_left=squeeze(mean(cond4n_dt_bl_left(roi_contour,43:53,:),2))-1;
bg_15_right=squeeze(mean(cond4n_dt_bl_right(roi_bg_in,43:53,:),2))-1;
bg_15_left=squeeze(mean(cond4n_dt_bl_left(roi_bg_in,43:53,:),2))-1;

%d

circ_10_right=squeeze(mean(cond2n_dt_bl_right(roi_contour,43:53,:),2))-1;
circ_10_left=squeeze(mean(cond2n_dt_bl_left(roi_contour,43:53,:),2))-1;
bg_10_right=squeeze(mean(cond2n_dt_bl_right(roi_bg_in,43:53,:),2))-1;
bg_10_left=squeeze(mean(cond2n_dt_bl_left(roi_bg_in,43:53,:),2))-1;
circ_20_right=squeeze(mean(cond4n_dt_bl_right(roi_contour,43:53,:),2))-1;
circ_20_left=squeeze(mean(cond4n_dt_bl_left(roi_contour,43:53,:),2))-1;
bg_20_right=squeeze(mean(cond4n_dt_bl_right(roi_bg_in,43:53,:),2))-1;
bg_20_left=squeeze(mean(cond4n_dt_bl_left(roi_bg_in,43:53,:),2))-1;

%f
circ_17_right=squeeze(mean(cond2n_dt_bl_right(roi_contour,43:53,:),2))-1;
circ_17_left=squeeze(mean(cond2n_dt_bl_left(roi_contour,43:53,:),2))-1;
bg_17_right=squeeze(mean(cond2n_dt_bl_right(roi_bg_in,43:53,:),2))-1;
bg_17_left=squeeze(mean(cond2n_dt_bl_left(roi_bg_in,43:53,:),2))-1;
circ_25_right=squeeze(mean(cond4n_dt_bl_right(roi_contour,43:53,:),2))-1;
circ_25_left=squeeze(mean(cond4n_dt_bl_left(roi_contour,43:53,:),2))-1;
bg_25_right=squeeze(mean(cond4n_dt_bl_right(roi_bg_in,43:53,:),2))-1;
bg_25_left=squeeze(mean(cond4n_dt_bl_left(roi_bg_in,43:53,:),2))-1;


X_5_right=zeros(size(circ_5_right,1)+size(bg_5_right,1)+1,size(circ_5_right,2));
Y_5_right=zeros(size(circ_5_right,1)+size(bg_5_right,1)+1,size(circ_5_right,2));
AUC_5_right=zeros(size(circ_5_right,2),1);
for i=1:size(circ_5_right,2)
    scores=[circ_5_right(:,i);bg_5_right(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_5_right,1)+1:end)=0;
    [X_5_right(:,i),Y_5_right(:,i),THRE,AUC_5_right(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_10_right=zeros(size(circ_10_right,1)+size(bg_10_right,1)+1,size(circ_10_right,2));
Y_10_right=zeros(size(circ_10_right,1)+size(bg_10_right,1)+1,size(circ_10_right,2));
AUC_10_right=zeros(size(circ_10_right,2),1);
for i=1:size(circ_10_right,2)
    scores=[circ_10_right(:,i);bg_10_right(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_10_right,1)+1:end)=0;
    [X_10_right(:,i),Y_10_right(:,i),THRE,AUC_10_right(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_15_right=zeros(size(circ_15_right,1)+size(bg_15_right,1)+1,size(circ_15_right,2));
Y_15_right=zeros(size(circ_15_right,1)+size(bg_15_right,1)+1,size(circ_15_right,2));
AUC_15_right=zeros(size(circ_15_right,2),1);
for i=1:size(circ_15_right,2)
    scores=[circ_15_right(:,i);bg_15_right(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_15_right,1)+1:end)=0;
    [X_15_right(:,i),Y_15_right(:,i),THRE,AUC_15_right(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_17_right=zeros(size(circ_17_right,1)+size(bg_17_right,1)+1,size(circ_17_right,2));
Y_17_right=zeros(size(circ_17_right,1)+size(bg_17_right,1)+1,size(circ_17_right,2));
AUC_17_right=zeros(size(circ_17_right,2),1);
for i=1:size(circ_17_right,2)
    scores=[circ_17_right(:,i);bg_17_right(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_17_right,1)+1:end)=0;
    [X_17_right(:,i),Y_17_right(:,i),THRE,AUC_17_right(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_20_right=zeros(size(circ_20_right,1)+size(bg_20_right,1)+1,size(circ_20_right,2));
Y_20_right=zeros(size(circ_20_right,1)+size(bg_20_right,1)+1,size(circ_20_right,2));
AUC_20_right=zeros(size(circ_20_right,2),1);
for i=1:size(circ_20_right,2)
    scores=[circ_20_right(:,i);bg_20_right(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_20_right,1)+1:end)=0;
    [X_20_right(:,i),Y_20_right(:,i),THRE,AUC_20_right(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_25_right=zeros(size(circ_25_right,1)+size(bg_25_right,1)+1,size(circ_25_right,2));
Y_25_right=zeros(size(circ_25_right,1)+size(bg_25_right,1)+1,size(circ_25_right,2));
AUC_25_right=zeros(size(circ_25_right,2),1);
for i=1:size(circ_25_right,2)
    scores=[circ_25_right(:,i);bg_25_right(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_25_right,1)+1:end)=0;
    [X_25_right(:,i),Y_25_right(:,i),THRE,AUC_25_right(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end   

X_5_left=zeros(size(circ_5_left,1)+size(bg_5_left,1)+1,size(circ_5_left,2));
Y_5_left=zeros(size(circ_5_left,1)+size(bg_5_left,1)+1,size(circ_5_left,2));
AUC_5_left=zeros(size(circ_5_left,2),1);
for i=1:size(circ_5_left,2)
    scores=[circ_5_left(:,i);bg_5_left(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_5_left,1)+1:end)=0;
    [X_5_left(:,i),Y_5_left(:,i),THRE,AUC_5_left(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_10_left=zeros(size(circ_10_left,1)+size(bg_10_left,1)+1,size(circ_10_left,2));
Y_10_left=zeros(size(circ_10_left,1)+size(bg_10_left,1)+1,size(circ_10_left,2));
AUC_10_left=zeros(size(circ_10_left,2),1);
for i=1:size(circ_10_left,2)
    scores=[circ_10_left(:,i);bg_10_left(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_10_left,1)+1:end)=0;
    [X_10_left(:,i),Y_10_left(:,i),THRE,AUC_10_left(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_15_left=zeros(size(circ_15_left,1)+size(bg_15_left,1)+1,size(circ_15_left,2));
Y_15_left=zeros(size(circ_15_left,1)+size(bg_15_left,1)+1,size(circ_15_left,2));
AUC_15_left=zeros(size(circ_15_left,2),1);
for i=1:size(circ_15_left,2)
    scores=[circ_15_left(:,i);bg_15_left(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_15_left,1)+1:end)=0;
    [X_15_left(:,i),Y_15_left(:,i),THRE,AUC_15_left(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_17_left=zeros(size(circ_17_left,1)+size(bg_17_left,1)+1,size(circ_17_left,2));
Y_17_left=zeros(size(circ_17_left,1)+size(bg_17_left,1)+1,size(circ_17_left,2));
AUC_17_left=zeros(size(circ_17_left,2),1);
for i=1:size(circ_17_left,2)
    scores=[circ_17_left(:,i);bg_17_left(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_17_left,1)+1:end)=0;
    [X_17_left(:,i),Y_17_left(:,i),THRE,AUC_17_left(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_20_left=zeros(size(circ_20_left,1)+size(bg_20_left,1)+1,size(circ_20_left,2));
Y_20_left=zeros(size(circ_20_left,1)+size(bg_20_left,1)+1,size(circ_20_left,2));
AUC_20_left=zeros(size(circ_20_left,2),1);
for i=1:size(circ_20_left,2)
    scores=[circ_20_left(:,i);bg_20_left(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_20_left,1)+1:end)=0;
    [X_20_left(:,i),Y_20_left(:,i),THRE,AUC_20_left(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_25_left=zeros(size(circ_25_left,1)+size(bg_25_left,1)+1,size(circ_25_left,2));
Y_25_left=zeros(size(circ_25_left,1)+size(bg_25_left,1)+1,size(circ_25_left,2));
AUC_25_left=zeros(size(circ_25_left,2),1);
for i=1:size(circ_25_left,2)
    scores=[circ_25_left(:,i);bg_25_left(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_25_left,1)+1:end)=0;
    [X_25_left(:,i),Y_25_left(:,i),THRE,AUC_25_left(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    





%% 1203

%d

circ_15_right=squeeze(mean(cond2n_dt_bl_right(roi_contour,43:53,:),2))-1;
circ_15_left=squeeze(mean(cond2n_dt_bl_left(roi_contour,43:53,:),2))-1;
bg_15_right=squeeze(mean(cond2n_dt_bl_right(roi_bg_in,43:53,:),2))-1;
bg_15_left=squeeze(mean(cond2n_dt_bl_left(roi_bg_in,43:53,:),2))-1;
circ_20_right=squeeze(mean(cond4n_dt_bl_right(roi_contour,43:53,:),2))-1;
circ_20_left=squeeze(mean(cond4n_dt_bl_left(roi_contour,43:53,:),2))-1;
bg_20_right=squeeze(mean(cond4n_dt_bl_right(roi_bg_in,43:53,:),2))-1;
bg_20_left=squeeze(mean(cond4n_dt_bl_left(roi_bg_in,43:53,:),2))-1;

%e

circ_10_right=squeeze(mean(cond4n_dt_bl_right(roi_contour,43:53,:),2))-1;
circ_10_left=squeeze(mean(cond4n_dt_bl_left(roi_contour,43:53,:),2))-1;
bg_10_right=squeeze(mean(cond4n_dt_bl_right(roi_bg_in,43:53,:),2))-1;
bg_10_left=squeeze(mean(cond4n_dt_bl_left(roi_bg_in,43:53,:),2))-1;

%f

circ_25_right=squeeze(mean(cond2n_dt_bl_right(roi_contour,43:53,:),2))-1;
circ_25_left=squeeze(mean(cond2n_dt_bl_left(roi_contour,43:53,:),2))-1;
bg_25_right=squeeze(mean(cond2n_dt_bl_right(roi_bg_in,43:53,:),2))-1;
bg_25_left=squeeze(mean(cond2n_dt_bl_left(roi_bg_in,43:53,:),2))-1;
circ_30_right=squeeze(mean(cond4n_dt_bl_right(roi_contour,43:53,:),2))-1;
circ_30_left=squeeze(mean(cond4n_dt_bl_left(roi_contour,43:53,:),2))-1;
bg_30_right=squeeze(mean(cond4n_dt_bl_right(roi_bg_in,43:53,:),2))-1;
bg_30_left=squeeze(mean(cond4n_dt_bl_left(roi_bg_in,43:53,:),2))-1;


X_10_right=zeros(size(circ_10_right,1)+size(bg_10_right,1)+1,size(circ_10_right,2));
Y_10_right=zeros(size(circ_10_right,1)+size(bg_10_right,1)+1,size(circ_10_right,2));
AUC_10_right=zeros(size(circ_10_right,2),1);
for i=1:size(circ_10_right,2)
    scores=[circ_10_right(:,i);bg_10_right(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_10_right,1)+1:end)=0;
    [X_10_right(:,i),Y_10_right(:,i),THRE,AUC_10_right(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_15_right=zeros(size(circ_15_right,1)+size(bg_15_right,1)+1,size(circ_15_right,2));
Y_15_right=zeros(size(circ_15_right,1)+size(bg_15_right,1)+1,size(circ_15_right,2));
AUC_15_right=zeros(size(circ_15_right,2),1);
for i=1:size(circ_15_right,2)
    scores=[circ_15_right(:,i);bg_15_right(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_15_right,1)+1:end)=0;
    [X_15_right(:,i),Y_15_right(:,i),THRE,AUC_15_right(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    


X_20_right=zeros(size(circ_20_right,1)+size(bg_20_right,1)+1,size(circ_20_right,2));
Y_20_right=zeros(size(circ_20_right,1)+size(bg_20_right,1)+1,size(circ_20_right,2));
AUC_20_right=zeros(size(circ_20_right,2),1);
for i=1:size(circ_20_right,2)
    scores=[circ_20_right(:,i);bg_20_right(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_20_right,1)+1:end)=0;
    [X_20_right(:,i),Y_20_right(:,i),THRE,AUC_20_right(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_25_right=zeros(size(circ_25_right,1)+size(bg_25_right,1)+1,size(circ_25_right,2));
Y_25_right=zeros(size(circ_25_right,1)+size(bg_25_right,1)+1,size(circ_25_right,2));
AUC_25_right=zeros(size(circ_25_right,2),1);
for i=1:size(circ_25_right,2)
    scores=[circ_25_right(:,i);bg_25_right(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_25_right,1)+1:end)=0;
    [X_25_right(:,i),Y_25_right(:,i),THRE,AUC_25_right(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end   

X_30_right=zeros(size(circ_30_right,1)+size(bg_30_right,1)+1,size(circ_30_right,2));
Y_30_right=zeros(size(circ_30_right,1)+size(bg_30_right,1)+1,size(circ_30_right,2));
AUC_30_right=zeros(size(circ_30_right,2),1);
for i=1:size(circ_30_right,2)
    scores=[circ_30_right(:,i);bg_30_right(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_30_right,1)+1:end)=0;
    [X_30_right(:,i),Y_30_right(:,i),THRE,AUC_30_right(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_10_left=zeros(size(circ_10_left,1)+size(bg_10_left,1)+1,size(circ_10_left,2));
Y_10_left=zeros(size(circ_10_left,1)+size(bg_10_left,1)+1,size(circ_10_left,2));
AUC_10_left=zeros(size(circ_10_left,2),1);
for i=1:size(circ_10_left,2)
    scores=[circ_10_left(:,i);bg_10_left(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_10_left,1)+1:end)=0;
    [X_10_left(:,i),Y_10_left(:,i),THRE,AUC_10_left(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_15_left=zeros(size(circ_15_left,1)+size(bg_15_left,1)+1,size(circ_15_left,2));
Y_15_left=zeros(size(circ_15_left,1)+size(bg_15_left,1)+1,size(circ_15_left,2));
AUC_15_left=zeros(size(circ_15_left,2),1);
for i=1:size(circ_15_left,2)
    scores=[circ_15_left(:,i);bg_15_left(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_15_left,1)+1:end)=0;
    [X_15_left(:,i),Y_15_left(:,i),THRE,AUC_15_left(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    


X_20_left=zeros(size(circ_20_left,1)+size(bg_20_left,1)+1,size(circ_20_left,2));
Y_20_left=zeros(size(circ_20_left,1)+size(bg_20_left,1)+1,size(circ_20_left,2));
AUC_20_left=zeros(size(circ_20_left,2),1);
for i=1:size(circ_20_left,2)
    scores=[circ_20_left(:,i);bg_20_left(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_20_left,1)+1:end)=0;
    [X_20_left(:,i),Y_20_left(:,i),THRE,AUC_20_left(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_25_left=zeros(size(circ_25_left,1)+size(bg_25_left,1)+1,size(circ_25_left,2));
Y_25_left=zeros(size(circ_25_left,1)+size(bg_25_left,1)+1,size(circ_25_left,2));
AUC_25_left=zeros(size(circ_25_left,2),1);
for i=1:size(circ_25_left,2)
    scores=[circ_25_left(:,i);bg_25_left(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_25_left,1)+1:end)=0;
    [X_25_left(:,i),Y_25_left(:,i),THRE,AUC_25_left(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_30_left=zeros(size(circ_30_left,1)+size(bg_30_left,1)+1,size(circ_30_left,2));
Y_30_left=zeros(size(circ_30_left,1)+size(bg_30_left,1)+1,size(circ_30_left,2));
AUC_30_left=zeros(size(circ_30_left,2),1);
for i=1:size(circ_30_left,2)
    scores=[circ_30_left(:,i);bg_30_left(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_30_left,1)+1:end)=0;
    [X_30_left(:,i),Y_30_left(:,i),THRE,AUC_30_left(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    








