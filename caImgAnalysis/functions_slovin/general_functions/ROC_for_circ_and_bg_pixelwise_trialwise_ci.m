%% 1811
%c
circ_c1c=squeeze(mean(cond1n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c1c=squeeze(mean(cond1n_dt_bl(roi_bg_in,43:53,:),2))-1;
circ_5=squeeze(mean(cond2n_dt_bl(roi_contour,43:53,:),2))-1;
bg_5=squeeze(mean(cond2n_dt_bl(roi_bg_in,43:53,:),2))-1;
circ_15=squeeze(mean(cond4n_dt_bl(roi_contour,43:53,:),2))-1;
bg_15=squeeze(mean(cond4n_dt_bl(roi_bg_in,43:53,:),2))-1;
circ_c5c=squeeze(mean(cond5n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c5c=squeeze(mean(cond5n_dt_bl(roi_bg_in,43:53,:),2))-1;

%d
circ_c1d=squeeze(mean(cond1n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c1d=squeeze(mean(cond1n_dt_bl(roi_bg_in,43:53,:),2))-1;
circ_10=squeeze(mean(cond2n_dt_bl(roi_contour,43:53,:),2))-1;
bg_10=squeeze(mean(cond2n_dt_bl(roi_bg_in,43:53,:),2))-1;
circ_20=squeeze(mean(cond4n_dt_bl(roi_contour,43:53,:),2))-1;
bg_20=squeeze(mean(cond4n_dt_bl(roi_bg_in,43:53,:),2))-1;
circ_c5d=squeeze(mean(cond5n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c5d=squeeze(mean(cond5n_dt_bl(roi_bg_in,43:53,:),2))-1;

%d
circ_c1e=squeeze(mean(cond1n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c1e=squeeze(mean(cond1n_dt_bl(roi_bg_in,43:53,:),2))-1;
circ_17=squeeze(mean(cond2n_dt_bl(roi_contour,43:53,:),2))-1;
bg_17=squeeze(mean(cond2n_dt_bl(roi_bg_in,43:53,:),2))-1;
circ_25=squeeze(mean(cond4n_dt_bl(roi_contour,43:53,:),2))-1;
bg_25=squeeze(mean(cond4n_dt_bl(roi_bg_in,43:53,:),2))-1;
circ_c5e=squeeze(mean(cond5n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c5e=squeeze(mean(cond5n_dt_bl(roi_bg_in,43:53,:),2))-1;


for i=1:size(circ_c1c,2)
    [n1 x1]=hist(circ_c1c(:,i),-.5e-3:.75e-4:2.5e-3);
    [n2 x2]=hist(bg_c1c(:,i),-.5e-3:.75e-4:2.5e-3);
    figure;bar(x1,[n1;n2]')
    legend('circle','background')
end

  
for i=1:size(circ_5,2)
    [n1 x1]=hist(circ_5(:,i),-.5e-3:.75e-4:2.5e-3);
    [n2 x2]=hist(bg_5(:,i),-.5e-3:.75e-4:2.5e-3);
    figure;bar(x1,[n1;n2]')
    legend('circle','background')
end


for i=1:size(circ_15,2)
    [n1 x1]=hist(circ_15(:,i),-.5e-3:.75e-4:2.5e-3);
    [n2 x2]=hist(bg_15(:,i),-.5e-3:.75e-4:2.5e-3);
    figure;bar(x1,[n1;n2]')
    legend('circle','background')
end


for i=1:size(circ_c5c,2)
    [n1 x1]=hist(circ_c5c(:,i),-.5e-3:.75e-4:2.5e-3);
    [n2 x2]=hist(bg_c5c(:,i),-.5e-3:.75e-4:2.5e-3);
    figure;bar(x1,[n1;n2]')
    legend('circle','background')
end


for i=1:size(circ_c1d,2)
    [n1 x1]=hist(circ_c1d(:,i),-.5e-3:.75e-4:2.5e-3);
    [n2 x2]=hist(bg_c1d(:,i),-.5e-3:.75e-4:2.5e-3);
    figure;bar(x1,[n1;n2]')
    legend('circle','background')
end

  
for i=1:size(circ_10,2)
    [n1 x1]=hist(circ_10(:,i),-.5e-3:.75e-4:2.5e-3);
    [n2 x2]=hist(bg_10(:,i),-.5e-3:.75e-4:2.5e-3);
    figure;bar(x1,[n1;n2]')
    legend('circle','background')
end


for i=1:size(circ_20,2)
    [n1 x1]=hist(circ_20(:,i),-.5e-3:.75e-4:2.5e-3);
    [n2 x2]=hist(bg_20(:,i),-.5e-3:.75e-4:2.5e-3);
    figure;bar(x1,[n1;n2]')
    legend('circle','background')
end


for i=1:size(circ_c5d,2)
    [n1 x1]=hist(circ_c5d(:,i),-.5e-3:.75e-4:2.5e-3);
    [n2 x2]=hist(bg_c5d(:,i),-.5e-3:.75e-4:2.5e-3);
    figure;bar(x1,[n1;n2]')
    legend('circle','background')
end


for i=1:size(circ_c1e,2)
    [n1 x1]=hist(circ_c1e(:,i),-.5e-3:.75e-4:2.5e-3);
    [n2 x2]=hist(bg_c1e(:,i),-.5e-3:.75e-4:2.5e-3);
    figure;bar(x1,[n1;n2]')
    legend('circle','background')
end

  
for i=1:size(circ_17,2)
    [n1 x1]=hist(circ_17(:,i),-.5e-3:.75e-4:2.5e-3);
    [n2 x2]=hist(bg_17(:,i),-.5e-3:.75e-4:2.5e-3);
    figure;bar(x1,[n1;n2]')
    legend('circle','background')
end


for i=1:size(circ_25,2)
    [n1 x1]=hist(circ_25(:,i),-.5e-3:.75e-4:2.5e-3);
    [n2 x2]=hist(bg_25(:,i),-.5e-3:.75e-4:2.5e-3);
    figure;bar(x1,[n1;n2]')
    legend('circle','background')
end


for i=1:size(circ_c5e,2)
    [n1 x1]=hist(circ_c5e(:,i),-.5e-3:.75e-4:2.5e-3);
    [n2 x2]=hist(bg_c5e(:,i),-.5e-3:.75e-4:2.5e-3);
    figure;bar(x1,[n1;n2]')
    legend('circle','background')
end


X_c1c=zeros(size(circ_c1c,1)+size(bg_c1c,1)+1,size(circ_c1c,2));
Y_c1c=zeros(size(circ_c1c,1)+size(bg_c1c,1)+1,size(circ_c1c,2));
AUC_c1c=zeros(size(circ_c1c,2),1);
for i=1:size(circ_c1c,2)
    scores=[circ_c1c(:,i);bg_c1c(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c1c,1)+1:end)=0;
    [X_c1c(:,i),Y_c1c(:,i),THRE,AUC_c1c(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_5=zeros(size(circ_5,1)+size(bg_5,1)+1,size(circ_5,2));
Y_5=zeros(size(circ_5,1)+size(bg_5,1)+1,size(circ_5,2));
AUC_5=zeros(size(circ_5,2),1);
for i=1:size(circ_5,2)
    scores=[circ_5(:,i);bg_5(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_5,1)+1:end)=0;
    [X_5(:,i),Y_5(:,i),THRE,AUC_5(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
    
    
X_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,2));
Y_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,2));
AUC_15=zeros(size(circ_15,2),1);
for i=1:size(circ_15,2)
    scores=[circ_15(:,i);bg_15(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_15,1)+1:end)=0;
    [X_15(:,i),Y_15(:,i),THRE,AUC_15(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
    
X_c5c=zeros(size(circ_c5c,1)+size(bg_c5c,1)+1,size(circ_c5c,2));
Y_c5c=zeros(size(circ_c5c,1)+size(bg_c5c,1)+1,size(circ_c5c,2));
AUC_c5c=zeros(size(circ_c5c,2),1);
for i=1:size(circ_c5c,2)
    scores=[circ_c5c(:,i);bg_c5c(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c5c,1)+1:end)=0;
    [X_c5c(:,i),Y_c5c(:,i),THRE,AUC_c5c(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
    
figure;
errorbar(mean(X_c1c,2),mean(Y_c1c,2),std(Y_c1c,0,2)/sqrt(size(Y_c1c,2)))
hold on
errorbar(mean(X_5,2),mean(Y_5,2),std(Y_5,0,2)/sqrt(size(Y_5,2)),'c')
errorbar(mean(X_15,2),mean(Y_15,2),std(Y_15,0,2)/sqrt(size(Y_15,2)),'m')
errorbar(mean(X_c5c,2),mean(Y_c5c,2),std(Y_c5c,0,2)/sqrt(size(Y_c5c,2)),'r')




X_c1d=zeros(size(circ_c1d,1)+size(bg_c1d,1)+1,size(circ_c1d,2));
Y_c1d=zeros(size(circ_c1d,1)+size(bg_c1d,1)+1,size(circ_c1d,2));
AUC_c1d=zeros(size(circ_c1d,2),1);
for i=1:size(circ_c1d,2)
    scores=[circ_c1d(:,i);bg_c1d(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c1d,1)+1:end)=0;
    [X_c1d(:,i),Y_c1d(:,i),THRE,AUC_c1d(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_10=zeros(size(circ_10,1)+size(bg_10,1)+1,size(circ_10,2));
Y_10=zeros(size(circ_10,1)+size(bg_10,1)+1,size(circ_10,2));
AUC_10=zeros(size(circ_10,2),1);
for i=1:size(circ_10,2)
    scores=[circ_10(:,i);bg_10(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_10,1)+1:end)=0;
    [X_10(:,i),Y_10(:,i),THRE,AUC_10(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
    
    
X_20=zeros(size(circ_20,1)+size(bg_20,1)+1,size(circ_20,2));
Y_20=zeros(size(circ_20,1)+size(bg_20,1)+1,size(circ_20,2));
AUC_20=zeros(size(circ_20,2),1);
for i=1:size(circ_20,2)
    scores=[circ_20(:,i);bg_20(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_20,1)+1:end)=0;
    [X_20(:,i),Y_20(:,i),THRE,AUC_20(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
    
X_c5d=zeros(size(circ_c5d,1)+size(bg_c5d,1)+1,size(circ_c5d,2));
Y_c5d=zeros(size(circ_c5d,1)+size(bg_c5d,1)+1,size(circ_c5d,2));
AUC_c5d=zeros(size(circ_c5d,2),1);
for i=1:size(circ_c5d,2)
    scores=[circ_c5d(:,i);bg_c5d(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c5d,1)+1:end)=0;
    [X_c5d(:,i),Y_c5d(:,i),THRE,AUC_c5d(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
    
figure;
errorbar(mean(X_c1d,2),mean(Y_c1d,2),std(Y_c1d,0,2)/sqrt(size(Y_c1d,2)))
hold on
errorbar(mean(X_10,2),mean(Y_10,2),std(Y_10,0,2)/sqrt(size(Y_10,2)),'c')
errorbar(mean(X_20,2),mean(Y_20,2),std(Y_20,0,2)/sqrt(size(Y_20,2)),'m')
errorbar(mean(X_c5d,2),mean(Y_c5d,2),std(Y_c5d,0,2)/sqrt(size(Y_c5d,2)),'r')

figure;
bar([mean(AUC_c1d) mean(AUC_10) mean(AUC_20) mean(AUC_c5d)])
hold on
errorbar([mean(AUC_c1d) mean(AUC_10) mean(AUC_20),mean(AUC_c5d)],[std(AUC_c1d)/sqrt(size(AUC_c1d,1)) std(AUC_10)/sqrt(size(AUC_10,1)) std(AUC_20)/sqrt(size(AUC_20,1)) std(AUC_c5d)/sqrt(size(AUC_c5d,1))])


X_c1e=zeros(size(circ_c1e,1)+size(bg_c1e,1)+1,size(circ_c1e,2));
Y_c1e=zeros(size(circ_c1e,1)+size(bg_c1e,1)+1,size(circ_c1e,2));
AUC_c1e=zeros(size(circ_c1e,2),1);
for i=1:size(circ_c1e,2)
    scores=[circ_c1e(:,i);bg_c1e(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c1e,1)+1:end)=0;
    [X_c1e(:,i),Y_c1e(:,i),THRE,AUC_c1e(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_17=zeros(size(circ_17,1)+size(bg_17,1)+1,size(circ_17,2));
Y_17=zeros(size(circ_17,1)+size(bg_17,1)+1,size(circ_17,2));
AUC_17=zeros(size(circ_17,2),1);
for i=1:size(circ_17,2)
    scores=[circ_17(:,i);bg_17(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_17,1)+1:end)=0;
    [X_17(:,i),Y_17(:,i),THRE,AUC_17(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
    
    
X_25=zeros(size(circ_25,1)+size(bg_25,1)+1,size(circ_25,2));
Y_25=zeros(size(circ_25,1)+size(bg_25,1)+1,size(circ_25,2));
AUC_25=zeros(size(circ_25,2),1);
for i=1:size(circ_25,2)
    scores=[circ_25(:,i);bg_25(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_25,1)+1:end)=0;
    [X_25(:,i),Y_25(:,i),THRE,AUC_25(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
    
X_c5e=zeros(size(circ_c5e,1)+size(bg_c5e,1)+1,size(circ_c5e,2));
Y_c5e=zeros(size(circ_c5e,1)+size(bg_c5e,1)+1,size(circ_c5e,2));
AUC_c5e=zeros(size(circ_c5e,2),1);
for i=1:size(circ_c5e,2)
    scores=[circ_c5e(:,i);bg_c5e(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c5e,1)+1:end)=0;
    [X_c5e(:,i),Y_c5e(:,i),THRE,AUC_c5e(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
    
figure;
errorbar(mean(X_c1e,2),mean(Y_c1e,2),std(Y_c1e,0,2)/sqrt(size(Y_c1e,2)))
hold on
errorbar(mean(X_17,2),mean(Y_17,2),std(Y_17,0,2)/sqrt(size(Y_17,2)),'c')
errorbar(mean(X_25,2),mean(Y_25,2),std(Y_25,0,2)/sqrt(size(Y_25,2)),'m')
errorbar(mean(X_c5e,2),mean(Y_c5e,2),std(Y_c5e,0,2)/sqrt(size(Y_c5e,2)),'r')

figure;
bar([mean(AUC_c1e) mean(AUC_17) mean(AUC_25) mean(AUC_c5e)])
hold on
errorbar([mean(AUC_c1e) mean(AUC_17) mean(AUC_25),mean(AUC_c5e)],[std(AUC_c1e)/sqrt(size(AUC_c1e,1)) std(AUC_17)/sqrt(size(AUC_17,1)) std(AUC_25)/sqrt(size(AUC_25,1)) std(AUC_c5e)/sqrt(size(AUC_c5e,1))])




AUC_cont=cat(1,AUC_c1c,AUC_c1d,AUC_c1e);
AUC_non=cat(1,AUC_c5c,AUC_c5d,AUC_c5e);

AUC_curve=[mean(AUC_cont),mean(AUC_5),mean(AUC_10),mean(AUC_15),mean(AUC_17),mean(AUC_20),mean(AUC_25),mean(AUC_non)];
AUC_std=[std(AUC_cont)/sqrt(size(AUC_cont,1)),std(AUC_5)/sqrt(size(AUC_5,1)),std(AUC_10)/sqrt(size(AUC_10,1)),std(AUC_15)/sqrt(size(AUC_15,1)),std(AUC_17)/sqrt(size(AUC_17,1)),std(AUC_20)/sqrt(size(AUC_20,1)),std(AUC_25)/sqrt(size(AUC_25,1)),std(AUC_non)/sqrt(size(AUC_non,1))];
figure;bar([0 5 10 15 17 20 25 45],AUC_curve)
hold on
errorbar([0 5 10 15 17 20 25 45],AUC_curve,AUC_std)

scores=[AUC_cont;AUC_non]';
labels=ones(1,size(scores,2));
labels(size(AUC_cont,1)+1:end)=0;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


scores=[AUC_c1c;AUC_c5c]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1c,1)+1:end)=0;
[X,Y,THRE,AUCc,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


scores=[AUC_c1d;AUC_c5d]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1d,1)+1:end)=0;
[X,Y,THRE,AUCd,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c1e;AUC_c5e]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1e,1)+1:end)=0;
[X,Y,THRE,AUCe,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

%% 2511

%d
circ_c1d=squeeze(mean(cond1n_dt_bl(roi_contour,53:58,:),2))-1;
bg_c1d=squeeze(mean(cond1n_dt_bl(roi_bg_in,53:58,:),2))-1;
circ_10=squeeze(mean(cond2n_dt_bl(roi_contour,53:58,:),2))-1;
bg_10=squeeze(mean(cond2n_dt_bl(roi_bg_in,53:58,:),2))-1;
circ_15=squeeze(mean(cond4n_dt_bl(roi_contour,53:58,:),2))-1;
bg_15=squeeze(mean(cond4n_dt_bl(roi_bg_in,53:58,:),2))-1;
circ_c5d=squeeze(mean(cond5n_dt_bl(roi_contour,53:58,:),2))-1;
bg_c5d=squeeze(mean(cond5n_dt_bl(roi_bg_in,53:58,:),2))-1;

%e
circ_c1e=squeeze(mean(cond1n_dt_bl(roi_contour,53:58,:),2))-1;
bg_c1e=squeeze(mean(cond1n_dt_bl(roi_bg_in,53:58,:),2))-1;
circ_17=squeeze(mean(cond2n_dt_bl(roi_contour,53:58,:),2))-1;
bg_17=squeeze(mean(cond2n_dt_bl(roi_bg_in,53:58,:),2))-1;
circ_20=squeeze(mean(cond4n_dt_bl(roi_contour,53:58,:),2))-1;
bg_20=squeeze(mean(cond4n_dt_bl(roi_bg_in,53:58,:),2))-1;
circ_c5e=squeeze(mean(cond5n_dt_bl(roi_contour,53:58,:),2))-1;
bg_c5e=squeeze(mean(cond5n_dt_bl(roi_bg_in,53:58,:),2))-1;

%f
circ_c1f=squeeze(mean(cond1n_dt_bl(roi_contour,53:58,:),2))-1;
bg_c1f=squeeze(mean(cond1n_dt_bl(roi_bg_in,53:58,:),2))-1;
circ_5=squeeze(mean(cond2n_dt_bl(roi_contour,53:58,:),2))-1;
bg_5=squeeze(mean(cond2n_dt_bl(roi_bg_in,53:58,:),2))-1;
circ_25=squeeze(mean(cond4n_dt_bl(roi_contour,53:58,:),2))-1;
bg_25=squeeze(mean(cond4n_dt_bl(roi_bg_in,53:58,:),2))-1;
circ_c5f=squeeze(mean(cond5n_dt_bl(roi_contour,53:58,:),2))-1;
bg_c5f=squeeze(mean(cond5n_dt_bl(roi_bg_in,53:58,:),2))-1;



   

X_c1d=zeros(size(circ_c1d,1)+size(bg_c1d,1)+1,size(circ_c1d,2));
Y_c1d=zeros(size(circ_c1d,1)+size(bg_c1d,1)+1,size(circ_c1d,2));
AUC_c1d=zeros(size(circ_c1d,2),1);
for i=1:size(circ_c1d,2)
    scores=[circ_c1d(:,i);bg_c1d(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c1d,1)+1:end)=0;
    [X_c1d(:,i),Y_c1d(:,i),THRE,AUC_c1d(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_10=zeros(size(circ_10,1)+size(bg_10,1)+1,size(circ_10,2));
Y_10=zeros(size(circ_10,1)+size(bg_10,1)+1,size(circ_10,2));
AUC_10=zeros(size(circ_10,2),1);
for i=1:size(circ_10,2)
    scores=[circ_10(:,i);bg_10(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_10,1)+1:end)=0;
    [X_10(:,i),Y_10(:,i),THRE,AUC_10(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
    
X_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,2));
Y_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,2));
AUC_15=zeros(size(circ_15,2),1);
for i=1:size(circ_15,2)
    scores=[circ_15(:,i);bg_15(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_15,1)+1:end)=0;
    [X_15(:,i),Y_15(:,i),THRE,AUC_15(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
        

X_c5d=zeros(size(circ_c5d,1)+size(bg_c5d,1)+1,size(circ_c5d,2));
Y_c5d=zeros(size(circ_c5d,1)+size(bg_c5d,1)+1,size(circ_c5d,2));
AUC_c5d=zeros(size(circ_c5d,2),1);
for i=1:size(circ_c5d,2)
    scores=[circ_c5d(:,i);bg_c5d(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c5d,1)+1:end)=0;
    [X_c5d(:,i),Y_c5d(:,i),THRE,AUC_c5d(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
    
figure;
errorbar(mean(X_c1d,2),mean(Y_c1d,2),std(Y_c1d,0,2)/sqrt(size(Y_c1d,2)))
hold on
errorbar(mean(X_10,2),mean(Y_10,2),std(Y_10,0,2)/sqrt(size(Y_10,2)),'c')
errorbar(mean(X_15,2),mean(Y_15,2),std(Y_15,0,2)/sqrt(size(Y_15,2)),'m')
errorbar(mean(X_c5d,2),mean(Y_c5d,2),std(Y_c5d,0,2)/sqrt(size(Y_c5d,2)),'r')


X_c1e=zeros(size(circ_c1e,1)+size(bg_c1e,1)+1,size(circ_c1e,2));
Y_c1e=zeros(size(circ_c1e,1)+size(bg_c1e,1)+1,size(circ_c1e,2));
AUC_c1e=zeros(size(circ_c1e,2),1);
for i=1:size(circ_c1e,2)
    scores=[circ_c1e(:,i);bg_c1e(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c1e,1)+1:end)=0;
    [X_c1e(:,i),Y_c1e(:,i),THRE,AUC_c1e(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_17=zeros(size(circ_17,1)+size(bg_17,1)+1,size(circ_17,2));
Y_17=zeros(size(circ_17,1)+size(bg_17,1)+1,size(circ_17,2));
AUC_17=zeros(size(circ_17,2),1);
for i=1:size(circ_17,2)
    scores=[circ_17(:,i);bg_17(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_17,1)+1:end)=0;
    [X_17(:,i),Y_17(:,i),THRE,AUC_17(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
    
X_20=zeros(size(circ_20,1)+size(bg_20,1)+1,size(circ_20,2));
Y_20=zeros(size(circ_20,1)+size(bg_20,1)+1,size(circ_20,2));
AUC_20=zeros(size(circ_20,2),1);
for i=1:size(circ_20,2)
    scores=[circ_20(:,i);bg_20(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_20,1)+1:end)=0;
    [X_20(:,i),Y_20(:,i),THRE,AUC_20(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
            
X_c5e=zeros(size(circ_c5e,1)+size(bg_c5e,1)+1,size(circ_c5e,2));
Y_c5e=zeros(size(circ_c5e,1)+size(bg_c5e,1)+1,size(circ_c5e,2));
AUC_c5e=zeros(size(circ_c5e,2),1);
for i=1:size(circ_c5e,2)
    scores=[circ_c5e(:,i);bg_c5e(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c5e,1)+1:end)=0;
    [X_c5e(:,i),Y_c5e(:,i),THRE,AUC_c5e(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
    
figure;
errorbar(mean(X_c1e,2),mean(Y_c1e,2),std(Y_c1e,0,2)/sqrt(size(Y_c1e,2)))
hold on
errorbar(mean(X_17,2),mean(Y_17,2),std(Y_17,0,2)/sqrt(size(Y_17,2)),'c')
errorbar(mean(X_20,2),mean(Y_20,2),std(Y_20,0,2)/sqrt(size(Y_20,2)),'m')
errorbar(mean(X_c5e,2),mean(Y_c5e,2),std(Y_c5e,0,2)/sqrt(size(Y_c5e,2)),'r')


X_c1f=zeros(size(circ_c1f,1)+size(bg_c1f,1)+1,size(circ_c1f,2));
Y_c1f=zeros(size(circ_c1f,1)+size(bg_c1f,1)+1,size(circ_c1f,2));
AUC_c1f=zeros(size(circ_c1f,2),1);
for i=1:size(circ_c1f,2)
    scores=[circ_c1f(:,i);bg_c1f(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c1f,1)+1:end)=0;
    [X_c1f(:,i),Y_c1f(:,i),THRE,AUC_c1f(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_5=zeros(size(circ_5,1)+size(bg_5,1)+1,size(circ_5,2));
Y_5=zeros(size(circ_5,1)+size(bg_5,1)+1,size(circ_5,2));
AUC_5=zeros(size(circ_5,2),1);
for i=1:size(circ_5,2)
    scores=[circ_5(:,i);bg_5(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_5,1)+1:end)=0;
    [X_5(:,i),Y_5(:,i),THRE,AUC_5(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_25=zeros(size(circ_25,1)+size(bg_25,1)+1,size(circ_25,2));
Y_25=zeros(size(circ_25,1)+size(bg_25,1)+1,size(circ_25,2));
AUC_25=zeros(size(circ_25,2),1);
for i=1:size(circ_25,2)
    scores=[circ_25(:,i);bg_25(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_25,1)+1:end)=0;
    [X_25(:,i),Y_25(:,i),THRE,AUC_25(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_c5f=zeros(size(circ_c5f,1)+size(bg_c5f,1)+1,size(circ_c5f,2));
Y_c5f=zeros(size(circ_c5f,1)+size(bg_c5f,1)+1,size(circ_c5f,2));
AUC_c5f=zeros(size(circ_c5f,2),1);
for i=1:size(circ_c5f,2)
    scores=[circ_c5f(:,i);bg_c5f(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c5f,1)+1:end)=0;
    [X_c5f(:,i),Y_c5f(:,i),THRE,AUC_c5f(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    


figure;
errorbar(mean(X_c1f,2),mean(Y_c1f,2),std(Y_c1f,0,2)/sqrt(size(Y_c1f,2)))
hold on
errorbar(mean(X_5,2),mean(Y_5,2),std(Y_5,0,2)/sqrt(size(Y_5,2)),'c')
errorbar(mean(X_25,2),mean(Y_25,2),std(Y_25,0,2)/sqrt(size(Y_25,2)),'m')
errorbar(mean(X_c5f,2),mean(Y_c5f,2),std(Y_c5f,0,2)/sqrt(size(Y_c5f,2)),'r')








AUC_cont=cat(1,AUC_c1d,AUC_c1e,AUC_c1f);
AUC_non=cat(1,AUC_c5d,AUC_c5e,AUC_c5f);

AUC_curve=[mean(AUC_cont),mean(AUC_5),mean(AUC_10),mean(AUC_15),mean(AUC_17),mean(AUC_20),mean(AUC_25),mean(AUC_non)];
AUC_std=[std(AUC_cont)/sqrt(size(AUC_cont,1)),std(AUC_5)/sqrt(size(AUC_5,1)),std(AUC_10)/sqrt(size(AUC_10,1)),std(AUC_15)/sqrt(size(AUC_15,1)),std(AUC_17)/sqrt(size(AUC_17,1)),std(AUC_20)/sqrt(size(AUC_20,1)),std(AUC_25)/sqrt(size(AUC_25,1)),std(AUC_non)/sqrt(size(AUC_non,1))];
figure;bar([0 5 10 15 17 20 25 45],AUC_curve)
hold on
errorbar([0 5 10 15 17 20 25 45],AUC_curve,AUC_std)

scores=[AUC_cont;AUC_non]';
labels=ones(1,size(scores,2));
labels(size(AUC_cont,1)+1:end)=0;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



scores=[AUC_c1d;AUC_c5d]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1d,1)+1:end)=0;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c1e;AUC_c5e]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1e,1)+1:end)=0;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c1f;AUC_c5f]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1f,1)+1:end)=0;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)





%% 1203

%d
circ_c1d=squeeze(mean(cond1n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c1d=squeeze(mean(cond1n_dt_bl(roi_bg_in,43:53,:),2))-1;
circ_15=squeeze(mean(cond2n_dt_bl(roi_contour,43:53,:),2))-1;
bg_15=squeeze(mean(cond2n_dt_bl(roi_bg_in,43:53,:),2))-1;
circ_20=squeeze(mean(cond4n_dt_bl(roi_contour,43:53,:),2))-1;
bg_20=squeeze(mean(cond4n_dt_bl(roi_bg_in,43:53,:),2))-1;
circ_c5d=squeeze(mean(cond5n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c5d=squeeze(mean(cond5n_dt_bl(roi_bg_in,43:53,:),2))-1;

%e
circ_c1e=squeeze(mean(cond1n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c1e=squeeze(mean(cond1n_dt_bl(roi_bg_in,43:53,:),2))-1;
circ_5=squeeze(mean(cond2n_dt_bl(roi_contour,43:53,:),2))-1;
bg_5=squeeze(mean(cond2n_dt_bl(roi_bg_in,43:53,:),2))-1;
circ_10=squeeze(mean(cond4n_dt_bl(roi_contour,43:53,:),2))-1;
bg_10=squeeze(mean(cond4n_dt_bl(roi_bg_in,43:53,:),2))-1;
circ_c5e=squeeze(mean(cond5n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c5e=squeeze(mean(cond5n_dt_bl(roi_bg_in,43:53,:),2))-1;

%f
circ_c1f=squeeze(mean(cond1n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c1f=squeeze(mean(cond1n_dt_bl(roi_bg_in,43:53,:),2))-1;
circ_25=squeeze(mean(cond2n_dt_bl(roi_contour,43:53,:),2))-1;
bg_25=squeeze(mean(cond2n_dt_bl(roi_bg_in,43:53,:),2))-1;
circ_30=squeeze(mean(cond4n_dt_bl(roi_contour,43:53,:),2))-1;
bg_30=squeeze(mean(cond4n_dt_bl(roi_bg_in,43:53,:),2))-1;
circ_c5f=squeeze(mean(cond5n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c5f=squeeze(mean(cond5n_dt_bl(roi_bg_in,43:53,:),2))-1;



   

X_c1d=zeros(size(circ_c1d,1)+size(bg_c1d,1)+1,size(circ_c1d,2));
Y_c1d=zeros(size(circ_c1d,1)+size(bg_c1d,1)+1,size(circ_c1d,2));
AUC_c1d=zeros(size(circ_c1d,2),1);
for i=1:size(circ_c1d,2)
    scores=[circ_c1d(:,i);bg_c1d(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c1d,1)+1:end)=0;
    [X_c1d(:,i),Y_c1d(:,i),THRE,AUC_c1d(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end


X_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,2));
Y_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,2));
AUC_15=zeros(size(circ_15,2),1);
for i=1:size(circ_15,2)
    scores=[circ_15(:,i);bg_15(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_15,1)+1:end)=0;
    [X_15(:,i),Y_15(:,i),THRE,AUC_15(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
        
X_20=zeros(size(circ_20,1)+size(bg_20,1)+1,size(circ_20,2));
Y_20=zeros(size(circ_20,1)+size(bg_20,1)+1,size(circ_20,2));
AUC_20=zeros(size(circ_20,2),1);
for i=1:size(circ_20,2)
    scores=[circ_20(:,i);bg_20(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_20,1)+1:end)=0;
    [X_20(:,i),Y_20(:,i),THRE,AUC_20(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_c5d=zeros(size(circ_c5d,1)+size(bg_c5d,1)+1,size(circ_c5d,2));
Y_c5d=zeros(size(circ_c5d,1)+size(bg_c5d,1)+1,size(circ_c5d,2));
AUC_c5d=zeros(size(circ_c5d,2),1);
for i=1:size(circ_c5d,2)
    scores=[circ_c5d(:,i);bg_c5d(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c5d,1)+1:end)=0;
    [X_c5d(:,i),Y_c5d(:,i),THRE,AUC_c5d(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
    
figure;
errorbar(mean(X_c1d,2),mean(Y_c1d,2),std(Y_c1d,0,2)/sqrt(size(Y_c1d,2)))
hold on
errorbar(mean(X_15,2),mean(Y_15,2),std(Y_15,0,2)/sqrt(size(Y_15,2)),'c')
errorbar(mean(X_20,2),mean(Y_20,2),std(Y_20,0,2)/sqrt(size(Y_20,2)),'m')
errorbar(mean(X_c5d,2),mean(Y_c5d,2),std(Y_c5d,0,2)/sqrt(size(Y_c5d,2)),'r')


X_c1e=zeros(size(circ_c1e,1)+size(bg_c1e,1)+1,size(circ_c1e,2));
Y_c1e=zeros(size(circ_c1e,1)+size(bg_c1e,1)+1,size(circ_c1e,2));
AUC_c1e=zeros(size(circ_c1e,2),1);
for i=1:size(circ_c1e,2)
    scores=[circ_c1e(:,i);bg_c1e(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c1e,1)+1:end)=0;
    [X_c1e(:,i),Y_c1e(:,i),THRE,AUC_c1e(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_5=zeros(size(circ_5,1)+size(bg_5,1)+1,size(circ_5,2));
Y_5=zeros(size(circ_5,1)+size(bg_5,1)+1,size(circ_5,2));
AUC_5=zeros(size(circ_5,2),1);
for i=1:size(circ_5,2)
    scores=[circ_5(:,i);bg_5(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_5,1)+1:end)=0;
    [X_5(:,i),Y_5(:,i),THRE,AUC_5(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_10=zeros(size(circ_10,1)+size(bg_10,1)+1,size(circ_10,2));
Y_10=zeros(size(circ_10,1)+size(bg_10,1)+1,size(circ_10,2));
AUC_10=zeros(size(circ_10,2),1);
for i=1:size(circ_10,2)
    scores=[circ_10(:,i);bg_10(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_10,1)+1:end)=0;
    [X_10(:,i),Y_10(:,i),THRE,AUC_10(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
                
X_c5e=zeros(size(circ_c5e,1)+size(bg_c5e,1)+1,size(circ_c5e,2));
Y_c5e=zeros(size(circ_c5e,1)+size(bg_c5e,1)+1,size(circ_c5e,2));
AUC_c5e=zeros(size(circ_c5e,2),1);
for i=1:size(circ_c5e,2)
    scores=[circ_c5e(:,i);bg_c5e(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c5e,1)+1:end)=0;
    [X_c5e(:,i),Y_c5e(:,i),THRE,AUC_c5e(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
    
figure;
errorbar(mean(X_c1e,2),mean(Y_c1e,2),std(Y_c1e,0,2)/sqrt(size(Y_c1e,2)))
hold on
errorbar(mean(X_5,2),mean(Y_5,2),std(Y_5,0,2)/sqrt(size(Y_5,2)),'c')
errorbar(mean(X_10,2),mean(Y_10,2),std(Y_10,0,2)/sqrt(size(Y_10,2)),'m')
errorbar(mean(X_c5e,2),mean(Y_c5e,2),std(Y_c5e,0,2)/sqrt(size(Y_c5e,2)),'r')


X_c1f=zeros(size(circ_c1f,1)+size(bg_c1f,1)+1,size(circ_c1f,2));
Y_c1f=zeros(size(circ_c1f,1)+size(bg_c1f,1)+1,size(circ_c1f,2));
AUC_c1f=zeros(size(circ_c1f,2),1);
for i=1:size(circ_c1f,2)
    scores=[circ_c1f(:,i);bg_c1f(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c1f,1)+1:end)=0;
    [X_c1f(:,i),Y_c1f(:,i),THRE,AUC_c1f(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_25=zeros(size(circ_25,1)+size(bg_25,1)+1,size(circ_25,2));
Y_25=zeros(size(circ_25,1)+size(bg_25,1)+1,size(circ_25,2));
AUC_25=zeros(size(circ_25,2),1);
for i=1:size(circ_25,2)
    scores=[circ_25(:,i);bg_25(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_25,1)+1:end)=0;
    [X_25(:,i),Y_25(:,i),THRE,AUC_25(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_30=zeros(size(circ_30,1)+size(bg_30,1)+1,size(circ_30,2));
Y_30=zeros(size(circ_30,1)+size(bg_30,1)+1,size(circ_30,2));
AUC_30=zeros(size(circ_30,2),1);
for i=1:size(circ_30,2)
    scores=[circ_30(:,i);bg_30(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_30,1)+1:end)=0;
    [X_30(:,i),Y_30(:,i),THRE,AUC_30(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
    
X_c5f=zeros(size(circ_c5f,1)+size(bg_c5f,1)+1,size(circ_c5f,2));
Y_c5f=zeros(size(circ_c5f,1)+size(bg_c5f,1)+1,size(circ_c5f,2));
AUC_c5f=zeros(size(circ_c5f,2),1);
for i=1:size(circ_c5f,2)
    scores=[circ_c5f(:,i);bg_c5f(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c5f,1)+1:end)=0;
    [X_c5f(:,i),Y_c5f(:,i),THRE,AUC_c5f(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    


figure;
errorbar(mean(X_c1f,2),mean(Y_c1f,2),std(Y_c1f,0,2)/sqrt(size(Y_c1f,2)))
hold on
errorbar(mean(X_5,2),mean(Y_25,2),std(Y_25,0,2)/sqrt(size(Y_25,2)),'c')
errorbar(mean(X_25,2),mean(Y_30,2),std(Y_30,0,2)/sqrt(size(Y_30,2)),'m')
errorbar(mean(X_c5f,2),mean(Y_c5f,2),std(Y_c5f,0,2)/sqrt(size(Y_c5f,2)),'r')








AUC_cont=cat(1,AUC_c1d,AUC_c1e,AUC_c1f);
AUC_non=cat(1,AUC_c5d,AUC_c5e,AUC_c5f);

AUC_curve=[mean(AUC_cont),mean(AUC_5),mean(AUC_10),mean(AUC_15),mean(AUC_20),mean(AUC_25),mean(AUC_30),mean(AUC_non)];
AUC_std=[std(AUC_cont)/sqrt(size(AUC_cont,1)),std(AUC_5)/sqrt(size(AUC_5,1)),std(AUC_10)/sqrt(size(AUC_10,1)),std(AUC_15)/sqrt(size(AUC_15,1)),std(AUC_20)/sqrt(size(AUC_20,1)),std(AUC_25)/sqrt(size(AUC_25,1)),std(AUC_30)/sqrt(size(AUC_30,1)),std(AUC_non)/sqrt(size(AUC_non,1))];
figure;bar([0 5 10 15 20 25 30 45],AUC_curve)
hold on
errorbar([0 5 10 15 20 25 30 45],AUC_curve,AUC_std)

scores=[AUC_cont;AUC_non]';
labels=ones(1,size(scores,2));
labels(size(AUC_cont,1)+1:end)=0;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



scores=[AUC_c1d;AUC_c5d]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1d,1)+1:end)=0;
[X,Y,THRE,AUCd,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c1e;AUC_c5e]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1e,1)+1:end)=0;
[X,Y,THRE,AUCe,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c1f;AUC_c5f]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1f,1)+1:end)=0;
[X,Y,THRE,AUCf,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


%% SMEAGOL 0501

%c
circ_c1c=squeeze(mean(cond1n_dt_bl(roi_circle,48:58,:),2))-1;
bg_c1c=squeeze(mean(cond1n_dt_bl(roi_bg_out,48:58,:),2))-1;
circ_10=squeeze(mean(cond2n_dt_bl(roi_circle,48:58,:),2))-1;
bg_10=squeeze(mean(cond2n_dt_bl(roi_bg_out,48:58,:),2))-1;
circ_20=squeeze(mean(cond4n_dt_bl(roi_circle,48:58,:),2))-1;
bg_20=squeeze(mean(cond4n_dt_bl(roi_bg_out,48:58,:),2))-1;
circ_c5c=squeeze(mean(cond5n_dt_bl(roi_circle,48:58,:),2))-1;
bg_c5c=squeeze(mean(cond5n_dt_bl(roi_bg_out,48:58,:),2))-1;

%d
circ_c1d=squeeze(mean(cond1n_dt_bl(roi_circle,48:58,:),2))-1;
bg_c1d=squeeze(mean(cond1n_dt_bl(roi_bg_out,48:58,:),2))-1;
circ_5=squeeze(mean(cond2n_dt_bl(roi_circle,48:58,:),2))-1;
bg_5=squeeze(mean(cond2n_dt_bl(roi_bg_out,48:58,:),2))-1;
circ_15=squeeze(mean(cond4n_dt_bl(roi_circle,48:58,:),2))-1;
bg_15=squeeze(mean(cond4n_dt_bl(roi_bg_out,48:58,:),2))-1;
circ_c5d=squeeze(mean(cond5n_dt_bl(roi_circle,48:58,:),2))-1;
bg_c5d=squeeze(mean(cond5n_dt_bl(roi_bg_out,48:58,:),2))-1;




X_c1c=zeros(size(circ_c1c,1)+size(bg_c1c,1)+1,size(circ_c1c,2));
Y_c1c=zeros(size(circ_c1c,1)+size(bg_c1c,1)+1,size(circ_c1c,2));
AUC_c1c=zeros(size(circ_c1c,2),1);
for i=1:size(circ_c1c,2)
    scores=[circ_c1c(:,i);bg_c1c(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c1c,1)+1:end)=0;
    [X_c1c(:,i),Y_c1c(:,i),THRE,AUC_c1c(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_10=zeros(size(circ_10,1)+size(bg_10,1)+1,size(circ_10,2));
Y_10=zeros(size(circ_10,1)+size(bg_10,1)+1,size(circ_10,2));
AUC_10=zeros(size(circ_10,2),1);
for i=1:size(circ_10,2)
    scores=[circ_10(:,i);bg_10(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_10,1)+1:end)=0;
    [X_10(:,i),Y_10(:,i),THRE,AUC_10(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
    
    
X_20=zeros(size(circ_20,1)+size(bg_20,1)+1,size(circ_20,2));
Y_20=zeros(size(circ_20,1)+size(bg_20,1)+1,size(circ_20,2));
AUC_20=zeros(size(circ_20,2),1);
for i=1:size(circ_20,2)
    scores=[circ_20(:,i);bg_20(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_20,1)+1:end)=0;
    [X_20(:,i),Y_20(:,i),THRE,AUC_20(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
    
    
X_c5c=zeros(size(circ_c5c,1)+size(bg_c5c,1)+1,size(circ_c5c,2));
Y_c5c=zeros(size(circ_c5c,1)+size(bg_c5c,1)+1,size(circ_c5c,2));
AUC_c5c=zeros(size(circ_c5c,2),1);
for i=1:size(circ_c5c,2)
    scores=[circ_c5c(:,i);bg_c5c(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c5c,1)+1:end)=0;
    [X_c5c(:,i),Y_c5c(:,i),THRE,AUC_c5c(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
    
figure;
errorbar(mean(X_c1c,2),mean(Y_c1c,2),std(Y_c1c,0,2)/sqrt(size(Y_c1c,2)))
hold on
errorbar(mean(X_10,2),mean(Y_10,2),std(Y_10,0,2)/sqrt(size(Y_10,2)),'c')
errorbar(mean(X_20,2),mean(Y_20,2),std(Y_20,0,2)/sqrt(size(Y_20,2)),'m')
errorbar(mean(X_c5c,2),mean(Y_c5c,2),std(Y_c5c,0,2)/sqrt(size(Y_c5c,2)),'r')




X_c1d=zeros(size(circ_c1d,1)+size(bg_c1d,1)+1,size(circ_c1d,2));
Y_c1d=zeros(size(circ_c1d,1)+size(bg_c1d,1)+1,size(circ_c1d,2));
AUC_c1d=zeros(size(circ_c1d,2),1);
for i=1:size(circ_c1d,2)
    scores=[circ_c1d(:,i);bg_c1d(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c1d,1)+1:end)=0;
    [X_c1d(:,i),Y_c1d(:,i),THRE,AUC_c1d(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
X_5=zeros(size(circ_5,1)+size(bg_5,1)+1,size(circ_5,2));
Y_5=zeros(size(circ_5,1)+size(bg_5,1)+1,size(circ_5,2));
AUC_5=zeros(size(circ_5,2),1);
for i=1:size(circ_5,2)
    scores=[circ_5(:,i);bg_5(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_5,1)+1:end)=0;
    [X_5(:,i),Y_5(:,i),THRE,AUC_5(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
    
    
X_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,2));
Y_15=zeros(size(circ_15,1)+size(bg_15,1)+1,size(circ_15,2));
AUC_15=zeros(size(circ_15,2),1);
for i=1:size(circ_15,2)
    scores=[circ_15(:,i);bg_15(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_15,1)+1:end)=0;
    [X_15(:,i),Y_15(:,i),THRE,AUC_15(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_c5d=zeros(size(circ_c5d,1)+size(bg_c5d,1)+1,size(circ_c5d,2));
Y_c5d=zeros(size(circ_c5d,1)+size(bg_c5d,1)+1,size(circ_c5d,2));
AUC_c5d=zeros(size(circ_c5d,2),1);
for i=1:size(circ_c5d,2)
    scores=[circ_c5d(:,i);bg_c5d(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c5d,1)+1:end)=0;
    [X_c5d(:,i),Y_c5d(:,i),THRE,AUC_c5d(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
    
figure;
errorbar(mean(X_c1d,2),mean(Y_c1d,2),std(Y_c1d,0,2)/sqrt(size(Y_c1d,2)))
hold on
errorbar(mean(X_5,2),mean(Y_5,2),std(Y_5,0,2)/sqrt(size(Y_5,2)),'c')
errorbar(mean(X_15,2),mean(Y_15,2),std(Y_15,0,2)/sqrt(size(Y_15,2)),'m')
errorbar(mean(X_c5d,2),mean(Y_c5d,2),std(Y_c5d,0,2)/sqrt(size(Y_c5d,2)),'r')



AUC_cont=cat(1,AUC_c1c,AUC_c1d);
AUC_non=cat(1,AUC_c5c,AUC_c5d);

AUC_curve=[mean(AUC_cont),mean(AUC_5),mean(AUC_10),mean(AUC_15),mean(AUC_20),mean(AUC_non)];
AUC_std=[std(AUC_cont)/sqrt(size(AUC_cont,1)),std(AUC_5)/sqrt(size(AUC_5,1)),std(AUC_10)/sqrt(size(AUC_10,1)),std(AUC_15)/sqrt(size(AUC_15,1)),std(AUC_20)/sqrt(size(AUC_20,1)),std(AUC_non)/sqrt(size(AUC_non,1))];
figure;bar([0 5 10 15 20 45],AUC_curve)
hold on
errorbar([0 5 10 15 20 45],AUC_curve,AUC_std)

scores=[AUC_cont;AUC_non]';
labels=ones(1,size(scores,2));
labels(size(AUC_cont,1)+1:end)=0;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


scores=[AUC_c1c;AUC_c5c]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1c,1)+1:end)=0;
[X,Y,THRE,AUCc,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c1d;AUC_c5d]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1d,1)+1:end)=0;
[X,Y,THRE,AUCd,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


[n1 x1]=hist(AUC_cont,0.1:0.05:1);
[n2 x2]=hist(AUC_non,0.1:0.05:1);
figure;bar(x1,[n1/size(AUC_cont,1);n2/size(AUC_non,1)]')
legend('contour','non-contour')
xlim([0 1]);





%% SMEAGOL 2212

%c
circ_c1c=squeeze(mean(cond1n_dt_bl(roi_circle,48:58,:),2))-1;
bg_c1c=squeeze(mean(cond1n_dt_bl(roi_bg_in,48:58,:),2))-1;
circ_5=squeeze(mean(cond2n_dt_bl(roi_circle,48:58,:),2))-1;
bg_5=squeeze(mean(cond2n_dt_bl(roi_bg_in,48:58,:),2))-1;
circ_20=squeeze(mean(cond4n_dt_bl(roi_circle,48:58,:),2))-1;
bg_20=squeeze(mean(cond4n_dt_bl(roi_bg_in,48:58,:),2))-1;
circ_c5c=squeeze(mean(cond5n_dt_bl(roi_circle,48:58,:),2))-1;
bg_c5c=squeeze(mean(cond5n_dt_bl(roi_bg_in,48:58,:),2))-1;

%d
circ_c1d=squeeze(mean(cond1n_dt_bl(roi_circle,48:58,:),2))-1;
bg_c1d=squeeze(mean(cond1n_dt_bl(roi_bg_in,48:58,:),2))-1;
circ_10=squeeze(mean(cond2n_dt_bl(roi_circle,48:58,:),2))-1;
bg_10=squeeze(mean(cond2n_dt_bl(roi_bg_in,48:58,:),2))-1;
circ_17=squeeze(mean(cond4n_dt_bl(roi_circle,48:58,:),2))-1;
bg_17=squeeze(mean(cond4n_dt_bl(roi_bg_in,48:58,:),2))-1;
circ_c5d=squeeze(mean(cond5n_dt_bl(roi_circle,48:58,:),2))-1;
bg_c5d=squeeze(mean(cond5n_dt_bl(roi_bg_in,48:58,:),2))-1;




X_c1c=zeros(size(circ_c1c,1)+size(bg_c1c,1)+1,size(circ_c1c,2));
Y_c1c=zeros(size(circ_c1c,1)+size(bg_c1c,1)+1,size(circ_c1c,2));
AUC_c1c=zeros(size(circ_c1c,2),1);
for i=1:size(circ_c1c,2)
    scores=[circ_c1c(:,i);bg_c1c(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c1c,1)+1:end)=0;
    [X_c1c(:,i),Y_c1c(:,i),THRE,AUC_c1c(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_5=zeros(size(circ_5,1)+size(bg_5,1)+1,size(circ_5,2));
Y_5=zeros(size(circ_5,1)+size(bg_5,1)+1,size(circ_5,2));
AUC_5=zeros(size(circ_5,2),1);
for i=1:size(circ_5,2)
    scores=[circ_5(:,i);bg_5(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_5,1)+1:end)=0;
    [X_5(:,i),Y_5(:,i),THRE,AUC_5(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end   

X_20=zeros(size(circ_20,1)+size(bg_20,1)+1,size(circ_20,2));
Y_20=zeros(size(circ_20,1)+size(bg_20,1)+1,size(circ_20,2));
AUC_20=zeros(size(circ_20,2),1);
for i=1:size(circ_20,2)
    scores=[circ_20(:,i);bg_20(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_20,1)+1:end)=0;
    [X_20(:,i),Y_20(:,i),THRE,AUC_20(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
    
    
X_c5c=zeros(size(circ_c5c,1)+size(bg_c5c,1)+1,size(circ_c5c,2));
Y_c5c=zeros(size(circ_c5c,1)+size(bg_c5c,1)+1,size(circ_c5c,2));
AUC_c5c=zeros(size(circ_c5c,2),1);
for i=1:size(circ_c5c,2)
    scores=[circ_c5c(:,i);bg_c5c(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c5c,1)+1:end)=0;
    [X_c5c(:,i),Y_c5c(:,i),THRE,AUC_c5c(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
    
figure;
errorbar(mean(X_c1c,2),mean(Y_c1c,2),std(Y_c1c,0,2)/sqrt(size(Y_c1c,2)))
hold on
errorbar(mean(X_5,2),mean(Y_5,2),std(Y_5,0,2)/sqrt(size(Y_5,2)),'c')
errorbar(mean(X_20,2),mean(Y_20,2),std(Y_20,0,2)/sqrt(size(Y_20,2)),'m')
errorbar(mean(X_c5c,2),mean(Y_c5c,2),std(Y_c5c,0,2)/sqrt(size(Y_c5c,2)),'r')




X_c1d=zeros(size(circ_c1d,1)+size(bg_c1d,1)+1,size(circ_c1d,2));
Y_c1d=zeros(size(circ_c1d,1)+size(bg_c1d,1)+1,size(circ_c1d,2));
AUC_c1d=zeros(size(circ_c1d,2),1);
for i=1:size(circ_c1d,2)
    scores=[circ_c1d(:,i);bg_c1d(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c1d,1)+1:end)=0;
    [X_c1d(:,i),Y_c1d(:,i),THRE,AUC_c1d(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_10=zeros(size(circ_10,1)+size(bg_10,1)+1,size(circ_10,2));
Y_10=zeros(size(circ_10,1)+size(bg_10,1)+1,size(circ_10,2));
AUC_10=zeros(size(circ_10,2),1);
for i=1:size(circ_10,2)
    scores=[circ_10(:,i);bg_10(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_10,1)+1:end)=0;
    [X_10(:,i),Y_10(:,i),THRE,AUC_10(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
    
    
    
X_17=zeros(size(circ_17,1)+size(bg_17,1)+1,size(circ_17,2));
Y_17=zeros(size(circ_17,1)+size(bg_17,1)+1,size(circ_17,2));
AUC_17=zeros(size(circ_17,2),1);
for i=1:size(circ_17,2)
    scores=[circ_17(:,i);bg_17(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_17,1)+1:end)=0;
    [X_17(:,i),Y_17(:,i),THRE,AUC_17(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    

X_c5d=zeros(size(circ_c5d,1)+size(bg_c5d,1)+1,size(circ_c5d,2));
Y_c5d=zeros(size(circ_c5d,1)+size(bg_c5d,1)+1,size(circ_c5d,2));
AUC_c5d=zeros(size(circ_c5d,2),1);
for i=1:size(circ_c5d,2)
    scores=[circ_c5d(:,i);bg_c5d(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c5d,1)+1:end)=0;
    [X_c5d(:,i),Y_c5d(:,i),THRE,AUC_c5d(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end    
    
figure;
errorbar(mean(X_c1d,2),mean(Y_c1d,2),std(Y_c1d,0,2)/sqrt(size(Y_c1d,2)))
hold on
errorbar(mean(X_10,2),mean(Y_10,2),std(Y_10,0,2)/sqrt(size(Y_10,2)),'c')
errorbar(mean(X_17,2),mean(Y_17,2),std(Y_17,0,2)/sqrt(size(Y_17,2)),'m')
errorbar(mean(X_c5d,2),mean(Y_c5d,2),std(Y_c5d,0,2)/sqrt(size(Y_c5d,2)),'r')



AUC_cont=cat(1,AUC_c1c,AUC_c1d);
AUC_non=cat(1,AUC_c5c,AUC_c5d);

AUC_curve=[mean(AUC_cont),mean(AUC_5),mean(AUC_10),mean(AUC_17),mean(AUC_20),mean(AUC_non)];
AUC_std=[std(AUC_cont)/sqrt(size(AUC_cont,1)),std(AUC_5)/sqrt(size(AUC_5,1)),std(AUC_10)/sqrt(size(AUC_10,1)),std(AUC_17)/sqrt(size(AUC_17,1)),std(AUC_20)/sqrt(size(AUC_20,1)),std(AUC_non)/sqrt(size(AUC_non,1))];
figure;bar([0 5 10 17 20 45],AUC_curve)
hold on
errorbar([0 5 10 17 20 45],AUC_curve,AUC_std)

scores=[AUC_cont;AUC_non]';
labels=ones(1,size(scores,2));
labels(size(AUC_cont,1)+1:end)=0;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


scores=[AUC_c1c;AUC_c5c]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1c,1)+1:end)=0;
[X,Y,THRE,AUCc,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c1d;AUC_c5d]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1d,1)+1:end)=0;
[X,Y,THRE,AUCd,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


[n1 x1]=hist(AUC_cont,0.1:0.05:1);
[n2 x2]=hist(AUC_non,0.1:0.05:1);
figure;bar(x1,[n1/size(AUC_cont,1);n2/size(AUC_non,1)]')
legend('contour','non-contour')
xlim([0 1]);




