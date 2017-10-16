%c
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new
load cond1n_dt_bl
load cond2n_dt_bl
load cond4n_dt_bl
load cond5n_dt_bl
load('myrois.mat', 'roi_contour2', 'roi_maskin_narrow')
circ_c1c=squeeze(mean(cond1n_dt_bl(roi_contour2,43:53,:),2))-1;
bg_c1c=squeeze(mean(cond1n_dt_bl(roi_maskin_narrow,43:53,:),2))-1;
circ_c2c=squeeze(mean(cond2n_dt_bl(roi_contour2,43:53,:),2))-1;
bg_c2c=squeeze(mean(cond2n_dt_bl(roi_maskin_narrow,43:53,:),2))-1;
circ_c4c=squeeze(mean(cond4n_dt_bl(roi_contour2,43:53,:),2))-1;
bg_c4c=squeeze(mean(cond4n_dt_bl(roi_maskin_narrow,43:53,:),2))-1;
circ_c5c=squeeze(mean(cond5n_dt_bl(roi_contour2,43:53,:),2))-1;
bg_c5c=squeeze(mean(cond5n_dt_bl(roi_maskin_narrow,43:53,:),2))-1;
clear cond1n_dt_bl
clear cond2n_dt_bl
clear cond4n_dt_bl
clear cond5n_dt_bl

%d
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\d\elhanan_new
load cond1n_dt_bl
load cond2n_dt_bl
load cond4n_dt_bl
load cond5n_dt_bl
load('myrois.mat', 'roi_contour2', 'roi_maskin_narrow')
circ_c1d=squeeze(mean(cond1n_dt_bl(roi_contour2,43:53,:),2))-1;
bg_c1d=squeeze(mean(cond1n_dt_bl(roi_maskin_narrow,43:53,:),2))-1;
circ_c2d=squeeze(mean(cond2n_dt_bl(roi_contour2,43:53,:),2))-1;
bg_c2d=squeeze(mean(cond2n_dt_bl(roi_maskin_narrow,43:53,:),2))-1;
circ_c4d=squeeze(mean(cond4n_dt_bl(roi_contour2,43:53,:),2))-1;
bg_c4d=squeeze(mean(cond4n_dt_bl(roi_maskin_narrow,43:53,:),2))-1;
circ_c5d=squeeze(mean(cond5n_dt_bl(roi_contour2,43:53,:),2))-1;
bg_c5d=squeeze(mean(cond5n_dt_bl(roi_maskin_narrow,43:53,:),2))-1;
clear cond1n_dt_bl
clear cond2n_dt_bl
clear cond4n_dt_bl
clear cond5n_dt_bl

%h
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\d\elhanan_new
load cond1n_dt_bl
load cond2n_dt_bl
load cond4n_dt_bl
load cond5n_dt_bl
load('myrois.mat', 'roi_contour', 'roi_maskin_narrow')
circ_c1h=squeeze(mean(cond1n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c1h=squeeze(mean(cond1n_dt_bl(roi_maskin_narrow,43:53,:),2))-1;
circ_c2h=squeeze(mean(cond2n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c2h=squeeze(mean(cond2n_dt_bl(roi_maskin_narrow,43:53,:),2))-1;
circ_c4h=squeeze(mean(cond4n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c4h=squeeze(mean(cond4n_dt_bl(roi_maskin_narrow,43:53,:),2))-1;
circ_c5h=squeeze(mean(cond5n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c5h=squeeze(mean(cond5n_dt_bl(roi_maskin_narrow,43:53,:),2))-1;
clear cond1n_dt_bl
clear cond2n_dt_bl
clear cond4n_dt_bl
clear cond5n_dt_bl


X_c1c=zeros(size(circ_c1c,1)+size(bg_c1c,1)+1,size(circ_c1c,2));
Y_c1c=zeros(size(circ_c1c,1)+size(bg_c1c,1)+1,size(circ_c1c,2));
AUC_c1c=zeros(size(circ_c1c,2),1);
for i=1:size(circ_c1c,2)
    scores=[circ_c1c(:,i);bg_c1c(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c1c,1)+1:end)=0;
    [X_c1c(:,i),Y_c1c(:,i),THRE,AUC_c1c(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_c2c=zeros(size(circ_c2c,1)+size(bg_c2c,1)+1,size(circ_c2c,2));
Y_c2c=zeros(size(circ_c2c,1)+size(bg_c2c,1)+1,size(circ_c2c,2));
AUC_c2c=zeros(size(circ_c2c,2),1);
for i=1:size(circ_c2c,2)
    scores=[circ_c2c(:,i);bg_c2c(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c2c,1)+1:end)=0;
    [X_c2c(:,i),Y_c2c(:,i),THRE,AUC_c2c(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_c4c=zeros(size(circ_c4c,1)+size(bg_c4c,1)+1,size(circ_c4c,2));
Y_c4c=zeros(size(circ_c4c,1)+size(bg_c4c,1)+1,size(circ_c4c,2));
AUC_c4c=zeros(size(circ_c4c,2),1);
for i=1:size(circ_c4c,2)
    scores=[circ_c4c(:,i);bg_c4c(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c4c,1)+1:end)=0;
    [X_c4c(:,i),Y_c4c(:,i),THRE,AUC_c4c(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
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


a=[mean(AUC_c1c) mean(AUC_c2c) mean(AUC_c4c) mean(AUC_c5c)];
b=[std(AUC_c1c)/sqrt(size(AUC_c1c,1)) std(AUC_c2c)/sqrt(size(AUC_c2c,1)) std(AUC_c4c)/sqrt(size(AUC_c4c,1)) std(AUC_c5c)/sqrt(size(AUC_c5c,1))];
figure;
bar(a)
hold on
errorbar(a,b)

AUC_cont=[AUC_c1c;AUC_c2c];
AUC_non=[AUC_c4c;AUC_c5c];


[n1 x1]=hist([AUC_c1c;AUC_c2c],0.3:0.02:1);
[n2 x2]=hist([AUC_c4c;AUC_c5c],0.3:0.02:1);
figure;bar(x1,[n1/size([AUC_c1c;AUC_c2c],1);n2/size([AUC_c4c;AUC_c5c],1)]')
legend('contour','non-contour')




%d
X_c1d=zeros(size(circ_c1d,1)+size(bg_c1d,1)+1,size(circ_c1d,2));
Y_c1d=zeros(size(circ_c1d,1)+size(bg_c1d,1)+1,size(circ_c1d,2));
AUC_c1d=zeros(size(circ_c1d,2),1);
for i=1:size(circ_c1d,2)
    scores=[circ_c1d(:,i);bg_c1d(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c1d,1)+1:end)=0;
    [X_c1d(:,i),Y_c1d(:,i),THRE,AUC_c1d(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_c2d=zeros(size(circ_c2d,1)+size(bg_c2d,1)+1,size(circ_c2d,2));
Y_c2d=zeros(size(circ_c2d,1)+size(bg_c2d,1)+1,size(circ_c2d,2));
AUC_c2d=zeros(size(circ_c2d,2),1);
for i=1:size(circ_c2d,2)
    scores=[circ_c2d(:,i);bg_c2d(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c2d,1)+1:end)=0;
    [X_c2d(:,i),Y_c2d(:,i),THRE,AUC_c2d(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_c4d=zeros(size(circ_c4d,1)+size(bg_c4d,1)+1,size(circ_c4d,2));
Y_c4d=zeros(size(circ_c4d,1)+size(bg_c4d,1)+1,size(circ_c4d,2));
AUC_c4d=zeros(size(circ_c4d,2),1);
for i=1:size(circ_c4d,2)
    scores=[circ_c4d(:,i);bg_c4d(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c4d,1)+1:end)=0;
    [X_c4d(:,i),Y_c4d(:,i),THRE,AUC_c4d(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
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
errorbar(mean(X_c2d,2),mean(Y_c2d,2),std(Y_c2d,0,2)/sqrt(size(Y_c2d,2)),'c')
errorbar(mean(X_c4d,2),mean(Y_c4d,2),std(Y_c4d,0,2)/sqrt(size(Y_c4d,2)),'m')
errorbar(mean(X_c5d,2),mean(Y_c5d,2),std(Y_c5d,0,2)/sqrt(size(Y_c5d,2)),'r')

a=[mean(AUC_c1d) mean(AUC_c2d) mean(AUC_c4d) mean(AUC_c5d)];
b=[std(AUC_c1d)/sqrt(size(AUC_c1d,1)) std(AUC_c2d)/sqrt(size(AUC_c2d,1)) std(AUC_c4d)/sqrt(size(AUC_c4d,1)) std(AUC_c5d)/sqrt(size(AUC_c5d,1))];
figure;
bar(a)
hold on
errorbar(a,b)

AUC_cont=[AUC_c1d;AUC_c2d];
AUC_non=[AUC_c4d;AUC_c5d];


[n1 x1]=hist([AUC_c1d;AUC_c2d],0.3:0.02:1);
[n2 x2]=hist([AUC_c4d;AUC_c5d],0.3:0.02:1);
figure;bar(x1,[n1/size([AUC_c1d;AUC_c2d],1);n2/size([AUC_c4d;AUC_c5d],1)]')
legend('contour','non-contour')




X_cont=cat(2,X_c1c,X_c2c,X_c1d,X_c2d);
Y_cont=cat(2,Y_c1c,Y_c2c,Y_c1d,Y_c2d);
X_non=cat(2,X_c4c,X_c5c,X_c4d,X_c5d);
Y_non=cat(2,Y_c4c,Y_c5c,Y_c4d,Y_c5d);
figure;
errorbar(mean(X_cont,2),mean(Y_cont,2),std(Y_cont,0,2)/sqrt(size(Y_cont,2)))
hold on
errorbar(mean(X_non,2),mean(Y_non,2),std(Y_non,0,2)/sqrt(size(Y_non,2)),'r')
plot(0:0.1:1,0:0.1:1,'k')
xlim([0 1]);ylim([0 1])


figure;
plot(X_cont,Y_cont,'b')
hold on
plot(X_non,Y_non,'r')
plot(0:0.1:1,0:0.1:1,'k')
xlim([0 1]);ylim([0 1])






AUC_cont=[AUC_c1c;AUC_c2c;AUC_c1d;AUC_c2d];
AUC_non=[AUC_c4c;AUC_c5c;AUC_c4d;AUC_c5d];
[n1 x1]=hist(AUC_cont,0.1:0.05:1);
[n2 x2]=hist(AUC_non,0.1:0.05:1);
figure;bar(x1,[n1/size(AUC_cont,1);n2/size(AUC_non,1)]')
legend('contour','non-contour')
xlim([0 1]);

figure;bar([mean(AUC_cont) mean(AUC_non)])
hold on
errorbar([mean(AUC_cont) mean(AUC_non)],[std(AUC_cont)/sqrt(size(AUC_cont,1)) std(AUC_non)/sqrt(size(AUC_non,1))])




scores=[AUC_cont;AUC_non]';
labels=ones(1,size(scores,2));
labels(size(AUC_cont,1)+1:end)=0;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)




%h
X_c1h=zeros(size(circ_c1h,1)+size(bg_c1h,1)+1,size(circ_c1h,2));
Y_c1h=zeros(size(circ_c1h,1)+size(bg_c1h,1)+1,size(circ_c1h,2));
AUC_c1h=zeros(size(circ_c1h,2),1);
for i=1:size(circ_c1h,2)
    scores=[circ_c1h(:,i);bg_c1h(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c1h,1)+1:end)=0;
    [X_c1h(:,i),Y_c1h(:,i),THRE,AUC_c1h(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_c2h=zeros(size(circ_c2h,1)+size(bg_c2h,1)+1,size(circ_c2h,2));
Y_c2h=zeros(size(circ_c2h,1)+size(bg_c2h,1)+1,size(circ_c2h,2));
AUC_c2h=zeros(size(circ_c2h,2),1);
for i=1:size(circ_c2h,2)
    scores=[circ_c2h(:,i);bg_c2h(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c2h,1)+1:end)=0;
    [X_c2h(:,i),Y_c2h(:,i),THRE,AUC_c2h(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_c4h=zeros(size(circ_c4h,1)+size(bg_c4h,1)+1,size(circ_c4h,2));
Y_c4h=zeros(size(circ_c4h,1)+size(bg_c4h,1)+1,size(circ_c4h,2));
AUC_c4h=zeros(size(circ_c4h,2),1);
for i=1:size(circ_c4h,2)
    scores=[circ_c4h(:,i);bg_c4h(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c4h,1)+1:end)=0;
    [X_c4h(:,i),Y_c4h(:,i),THRE,AUC_c4h(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_c5h=zeros(size(circ_c5h,1)+size(bg_c5h,1)+1,size(circ_c5h,2));
Y_c5h=zeros(size(circ_c5h,1)+size(bg_c5h,1)+1,size(circ_c5h,2));
AUC_c5h=zeros(size(circ_c5h,2),1);
for i=1:size(circ_c5h,2)
    scores=[circ_c5h(:,i);bg_c5h(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c5h,1)+1:end)=0;
    [X_c5h(:,i),Y_c5h(:,i),THRE,AUC_c5h(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

figure;
errorbar(mean(X_c1h,2),mean(Y_c1h,2),std(Y_c1h,0,2)/sqrt(size(Y_c1h,2)))
hold on
errorbar(mean(X_c2h,2),mean(Y_c2h,2),std(Y_c2h,0,2)/sqrt(size(Y_c2h,2)),'c')
errorbar(mean(X_c4h,2),mean(Y_c4h,2),std(Y_c4h,0,2)/sqrt(size(Y_c4h,2)),'m')
errorbar(mean(X_c5h,2),mean(Y_c5h,2),std(Y_c5h,0,2)/sqrt(size(Y_c5h,2)),'r')

a=[mean(AUC_c1h) mean(AUC_c2h) mean(AUC_c4h) mean(AUC_c5h)];
b=[std(AUC_c1h)/sqrt(size(AUC_c1h,1)) std(AUC_c2h)/sqrt(size(AUC_c2h,1)) std(AUC_c4h)/sqrt(size(AUC_c4h,1)) std(AUC_c5h)/sqrt(size(AUC_c5h,1))];
figure;
bar(a)
hold on
errorbar(a,b)

AUC_cont=[AUC_c1h;AUC_c2h];
AUC_non=[AUC_c4h;AUC_c5h];


[n1 x1]=hist([AUC_c1h;AUC_c2h],0.3:0.02:1);
[n2 x2]=hist([AUC_c4h;AUC_c5h],0.3:0.02:1);
figure;bar(x1,[n1/size([AUC_c1h;AUC_c2h],1);n2/size([AUC_c4h;AUC_c5h],1)]')
legend('contour','non-contour')





%% 2210


%d
circ_c1d=squeeze(mean(cond1n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c1d=squeeze(mean(cond1n_dt_bl(roi_bg_in_narrow,43:53,:),2))-1;
circ_c2d=squeeze(mean(cond2n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c2d=squeeze(mean(cond2n_dt_bl(roi_bg_in_narrow,43:53,:),2))-1;
circ_c4d=squeeze(mean(cond4n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c4d=squeeze(mean(cond4n_dt_bl(roi_bg_in_narrow,43:53,:),2))-1;
circ_c5d=squeeze(mean(cond5n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c5d=squeeze(mean(cond5n_dt_bl(roi_bg_in_narrow,43:53,:),2))-1;



%d
X_c1d=zeros(size(circ_c1d,1)+size(bg_c1d,1)+1,size(circ_c1d,2));
Y_c1d=zeros(size(circ_c1d,1)+size(bg_c1d,1)+1,size(circ_c1d,2));
AUC_c1d=zeros(size(circ_c1d,2),1);
for i=1:size(circ_c1d,2)
    scores=[circ_c1d(:,i);bg_c1d(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c1d,1)+1:end)=0;
    [X_c1d(:,i),Y_c1d(:,i),THRE,AUC_c1d(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_c2d=zeros(size(circ_c2d,1)+size(bg_c2d,1)+1,size(circ_c2d,2));
Y_c2d=zeros(size(circ_c2d,1)+size(bg_c2d,1)+1,size(circ_c2d,2));
AUC_c2d=zeros(size(circ_c2d,2),1);
for i=1:size(circ_c2d,2)
    scores=[circ_c2d(:,i);bg_c2d(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c2d,1)+1:end)=0;
    [X_c2d(:,i),Y_c2d(:,i),THRE,AUC_c2d(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_c4d=zeros(size(circ_c4d,1)+size(bg_c4d,1)+1,size(circ_c4d,2));
Y_c4d=zeros(size(circ_c4d,1)+size(bg_c4d,1)+1,size(circ_c4d,2));
AUC_c4d=zeros(size(circ_c4d,2),1);
for i=1:size(circ_c4d,2)
    scores=[circ_c4d(:,i);bg_c4d(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c4d,1)+1:end)=0;
    [X_c4d(:,i),Y_c4d(:,i),THRE,AUC_c4d(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
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
errorbar(mean(X_c2d,2),mean(Y_c2d,2),std(Y_c2d,0,2)/sqrt(size(Y_c2d,2)),'c')
errorbar(mean(X_c4d,2),mean(Y_c4d,2),std(Y_c4d,0,2)/sqrt(size(Y_c4d,2)),'m')
errorbar(mean(X_c5d,2),mean(Y_c5d,2),std(Y_c5d,0,2)/sqrt(size(Y_c5d,2)),'r')

a=[mean(AUC_c1d) mean(AUC_c2d) mean(AUC_c4d) mean(AUC_c5d)];
b=[std(AUC_c1d)/sqrt(size(AUC_c1d,1)) std(AUC_c2d)/sqrt(size(AUC_c2d,1)) std(AUC_c4d)/sqrt(size(AUC_c4d,1)) std(AUC_c5d)/sqrt(size(AUC_c5d,1))];
figure;
bar(a)
hold on
errorbar(a,b)

AUC_cont=[AUC_c1d;AUC_c2d];
AUC_non=[AUC_c4d;AUC_c5d];


[n1 x1]=hist([AUC_c1d;AUC_c2d],0.3:0.02:1);
[n2 x2]=hist([AUC_c4d;AUC_c5d],0.3:0.02:1);
figure;bar(x1,[n1/size([AUC_c1d;AUC_c2d],1);n2/size([AUC_c4d;AUC_c5d],1)]')
legend('contour','non-contour')

scores=[AUC_cont;AUC_non]';
labels=ones(1,size(scores,2));
labels(size(AUC_cont,1)+1:end)=0;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)







%e
circ_c1e=squeeze(mean(cond1n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c1e=squeeze(mean(cond1n_dt_bl(roi_bg_in_narrow,43:53,:),2))-1;
circ_c2e=squeeze(mean(cond2n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c2e=squeeze(mean(cond2n_dt_bl(roi_bg_in_narrow,43:53,:),2))-1;
circ_c4e=squeeze(mean(cond4n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c4e=squeeze(mean(cond4n_dt_bl(roi_bg_in_narrow,43:53,:),2))-1;
circ_c5e=squeeze(mean(cond5n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c5e=squeeze(mean(cond5n_dt_bl(roi_bg_in_narrow,43:53,:),2))-1;




X_c1e=zeros(size(circ_c1e,1)+size(bg_c1e,1)+1,size(circ_c1e,2));
Y_c1e=zeros(size(circ_c1e,1)+size(bg_c1e,1)+1,size(circ_c1e,2));
AUC_c1e=zeros(size(circ_c1e,2),1);
for i=1:size(circ_c1e,2)
    scores=[circ_c1e(:,i);bg_c1e(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c1e,1)+1:end)=0;
    [X_c1e(:,i),Y_c1e(:,i),THRE,AUC_c1e(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_c2e=zeros(size(circ_c2e,1)+size(bg_c2e,1)+1,size(circ_c2e,2));
Y_c2e=zeros(size(circ_c2e,1)+size(bg_c2e,1)+1,size(circ_c2e,2));
AUC_c2e=zeros(size(circ_c2e,2),1);
for i=1:size(circ_c2e,2)
    scores=[circ_c2e(:,i);bg_c2e(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c2e,1)+1:end)=0;
    [X_c2e(:,i),Y_c2e(:,i),THRE,AUC_c2e(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_c4e=zeros(size(circ_c4e,1)+size(bg_c4e,1)+1,size(circ_c4e,2));
Y_c4e=zeros(size(circ_c4e,1)+size(bg_c4e,1)+1,size(circ_c4e,2));
AUC_c4e=zeros(size(circ_c4e,2),1);
for i=1:size(circ_c4e,2)
    scores=[circ_c4e(:,i);bg_c4e(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c4e,1)+1:end)=0;
    [X_c4e(:,i),Y_c4e(:,i),THRE,AUC_c4e(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
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
errorbar(mean(X_c2e,2),mean(Y_c2e,2),std(Y_c2e,0,2)/sqrt(size(Y_c2e,2)),'c')
errorbar(mean(X_c4e,2),mean(Y_c4e,2),std(Y_c4e,0,2)/sqrt(size(Y_c4e,2)),'m')
errorbar(mean(X_c5e,2),mean(Y_c5e,2),std(Y_c5e,0,2)/sqrt(size(Y_c5e,2)),'r')

a=[mean(AUC_c1e) mean(AUC_c2e) mean(AUC_c4e) mean(AUC_c5e)];
b=[std(AUC_c1e)/sqrt(size(AUC_c1e,1)) std(AUC_c2e)/sqrt(size(AUC_c2e,1)) std(AUC_c4e)/sqrt(size(AUC_c4e,1)) std(AUC_c5e)/sqrt(size(AUC_c5e,1))];
figure;
bar(a)
hold on
errorbar(a,b)

AUC_cont=[AUC_c1e;AUC_c2e];
AUC_non=[AUC_c4e;AUC_c5e];


[n1 x1]=hist([AUC_c1e;AUC_c2e],0.3:0.02:1);
[n2 x2]=hist([AUC_c4e;AUC_c5e],0.3:0.02:1);
figure;bar(x1,[n1/size([AUC_c1e;AUC_c2e],1);n2/size([AUC_c4e;AUC_c5e],1)]')
legend('contour','non-contour')

scores=[AUC_cont;AUC_non]';
labels=ones(1,size(scores,2));
labels(size(AUC_cont,1)+1:end)=0;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)




%% 0610
for i=1:size(circ_c1e,2)
    [n1 x1]=hist(circ_c1e(:,i),-.5e-3:.75e-4:2.5e-3);
    [n2 x2]=hist(bg_c1e(:,i),-.5e-3:.75e-4:2.5e-3);
    figure;bar(x1,[n1;n2]')
    legend('circle','background')
end
%e
circ_c1e=squeeze(mean(cond1n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c1e=squeeze(mean(cond1n_dt_bl(roi_bg_in_narrow,43:53,:),2))-1;
circ_c2e=squeeze(mean(cond2n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c2e=squeeze(mean(cond2n_dt_bl(roi_bg_in_narrow,43:53,:),2))-1;
circ_c4e=squeeze(mean(cond4n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c4e=squeeze(mean(cond4n_dt_bl(roi_bg_in_narrow,43:53,:),2))-1;
circ_c5e=squeeze(mean(cond5n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c5e=squeeze(mean(cond5n_dt_bl(roi_bg_in_narrow,43:53,:),2))-1;




X_c1e=zeros(size(circ_c1e,1)+size(bg_c1e,1)+1,size(circ_c1e,2));
Y_c1e=zeros(size(circ_c1e,1)+size(bg_c1e,1)+1,size(circ_c1e,2));
AUC_c1e=zeros(size(circ_c1e,2),1);
for i=1:size(circ_c1e,2)
    scores=[circ_c1e(:,i);bg_c1e(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c1e,1)+1:end)=0;
    [X_c1e(:,i),Y_c1e(:,i),THRE,AUC_c1e(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_c2e=zeros(size(circ_c2e,1)+size(bg_c2e,1)+1,size(circ_c2e,2));
Y_c2e=zeros(size(circ_c2e,1)+size(bg_c2e,1)+1,size(circ_c2e,2));
AUC_c2e=zeros(size(circ_c2e,2),1);
for i=1:size(circ_c2e,2)
    scores=[circ_c2e(:,i);bg_c2e(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c2e,1)+1:end)=0;
    [X_c2e(:,i),Y_c2e(:,i),THRE,AUC_c2e(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_c4e=zeros(size(circ_c4e,1)+size(bg_c4e,1)+1,size(circ_c4e,2));
Y_c4e=zeros(size(circ_c4e,1)+size(bg_c4e,1)+1,size(circ_c4e,2));
AUC_c4e=zeros(size(circ_c4e,2),1);
for i=1:size(circ_c4e,2)
    scores=[circ_c4e(:,i);bg_c4e(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c4e,1)+1:end)=0;
    [X_c4e(:,i),Y_c4e(:,i),THRE,AUC_c4e(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
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
errorbar(mean(X_c2e,2),mean(Y_c2e,2),std(Y_c2e,0,2)/sqrt(size(Y_c2e,2)),'c')
errorbar(mean(X_c4e,2),mean(Y_c4e,2),std(Y_c4e,0,2)/sqrt(size(Y_c4e,2)),'m')
errorbar(mean(X_c5e,2),mean(Y_c5e,2),std(Y_c5e,0,2)/sqrt(size(Y_c5e,2)),'r')

a=[mean(AUC_c1e) mean(AUC_c2e) mean(AUC_c4e) mean(AUC_c5e)];
b=[std(AUC_c1e)/sqrt(size(AUC_c1e,1)) std(AUC_c2e)/sqrt(size(AUC_c2e,1)) std(AUC_c4e)/sqrt(size(AUC_c4e,1)) std(AUC_c5e)/sqrt(size(AUC_c5e,1))];
figure;
bar(a)
hold on
errorbar(a,b)

AUC_cont=[AUC_c1e;AUC_c2e];
AUC_non=[AUC_c4e;AUC_c5e];


[n1 x1]=hist([AUC_c1e;AUC_c2e],0.3:0.02:1);
[n2 x2]=hist([AUC_c4e;AUC_c5e],0.3:0.02:1);
figure;bar(x1,[n1/size([AUC_c1e;AUC_c2e],1);n2/size([AUC_c4e;AUC_c5e],1)]')
legend('contour','non-contour')

scores=[AUC_cont;AUC_non]';
labels=ones(1,size(scores,2));
labels(size(AUC_cont,1)+1:end)=0;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)




%f
circ_c1f=squeeze(mean(cond1n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c1f=squeeze(mean(cond1n_dt_bl(roi_bg_in_narrow,43:53,:),2))-1;
circ_c2f=squeeze(mean(cond2n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c2f=squeeze(mean(cond2n_dt_bl(roi_bg_in_narrow,43:53,:),2))-1;
circ_c4f=squeeze(mean(cond4n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c4f=squeeze(mean(cond4n_dt_bl(roi_bg_in_narrow,43:53,:),2))-1;
circ_c5f=squeeze(mean(cond5n_dt_bl(roi_contour,43:53,:),2))-1;
bg_c5f=squeeze(mean(cond5n_dt_bl(roi_bg_in_narrow,43:53,:),2))-1;




X_c1f=zeros(size(circ_c1f,1)+size(bg_c1f,1)+1,size(circ_c1f,2));
Y_c1f=zeros(size(circ_c1f,1)+size(bg_c1f,1)+1,size(circ_c1f,2));
AUC_c1f=zeros(size(circ_c1f,2),1);
for i=1:size(circ_c1f,2)
    scores=[circ_c1f(:,i);bg_c1f(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c1f,1)+1:end)=0;
    [X_c1f(:,i),Y_c1f(:,i),THRE,AUC_c1f(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_c2f=zeros(size(circ_c2f,1)+size(bg_c2f,1)+1,size(circ_c2f,2));
Y_c2f=zeros(size(circ_c2f,1)+size(bg_c2f,1)+1,size(circ_c2f,2));
AUC_c2f=zeros(size(circ_c2f,2),1);
for i=1:size(circ_c2f,2)
    scores=[circ_c2f(:,i);bg_c2f(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c2f,1)+1:end)=0;
    [X_c2f(:,i),Y_c2f(:,i),THRE,AUC_c2f(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_c4f=zeros(size(circ_c4f,1)+size(bg_c4f,1)+1,size(circ_c4f,2));
Y_c4f=zeros(size(circ_c4f,1)+size(bg_c4f,1)+1,size(circ_c4f,2));
AUC_c4f=zeros(size(circ_c4f,2),1);
for i=1:size(circ_c4f,2)
    scores=[circ_c4f(:,i);bg_c4f(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c4f,1)+1:end)=0;
    [X_c4f(:,i),Y_c4f(:,i),THRE,AUC_c4f(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
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
errorbar(mean(X_c2f,2),mean(Y_c2f,2),std(Y_c2f,0,2)/sqrt(size(Y_c2f,2)),'c')
errorbar(mean(X_c4f,2),mean(Y_c4f,2),std(Y_c4f,0,2)/sqrt(size(Y_c4f,2)),'m')
errorbar(mean(X_c5f,2),mean(Y_c5f,2),std(Y_c5f,0,2)/sqrt(size(Y_c5f,2)),'r')

a=[mean(AUC_c1f) mean(AUC_c2f) mean(AUC_c4f) mean(AUC_c5f)];
b=[std(AUC_c1f)/sqrt(size(AUC_c1f,1)) std(AUC_c2f)/sqrt(size(AUC_c2f,1)) std(AUC_c4f)/sqrt(size(AUC_c4f,1)) std(AUC_c5f)/sqrt(size(AUC_c5f,1))];
figure;
bar(a)
hold on
errorbar(a,b)

AUC_cont=[AUC_c1f;AUC_c2f];
AUC_non=[AUC_c4f;AUC_c5f];


[n1 x1]=hist([AUC_c1f;AUC_c2f],0.3:0.02:1);
[n2 x2]=hist([AUC_c4f;AUC_c5f],0.3:0.02:1);
figure;bar(x1,[n1/size([AUC_c1f;AUC_c2f],1);n2/size([AUC_c4f;AUC_c5f],1)]')
legend('contour','non-contour')

scores=[AUC_cont;AUC_non]';
labels=ones(1,size(scores,2));
labels(size(AUC_cont,1)+1:end)=0;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)




%% SMEAGOL 0501b
%b
circ_c1b=squeeze(mean(cond1n_dt_bl(roi_circle,48:58,:),2))-1;
bg_c1b=squeeze(mean(cond1n_dt_bl(roi_bg_out,48:58,:),2))-1;
circ_c2b=squeeze(mean(cond2n_dt_bl(roi_circle,48:58,:),2))-1;
bg_c2b=squeeze(mean(cond2n_dt_bl(roi_bg_out,48:58,:),2))-1;
circ_c4b=squeeze(mean(cond4n_dt_bl(roi_circle,48:58,:),2))-1;
bg_c4b=squeeze(mean(cond4n_dt_bl(roi_bg_out,48:58,:),2))-1;
circ_c5b=squeeze(mean(cond5n_dt_bl(roi_circle,48:58,:),2))-1;
bg_c5b=squeeze(mean(cond5n_dt_bl(roi_bg_out,48:58,:),2))-1;




X_c1b=zeros(size(circ_c1b,1)+size(bg_c1b,1)+1,size(circ_c1b,2));
Y_c1b=zeros(size(circ_c1b,1)+size(bg_c1b,1)+1,size(circ_c1b,2));
AUC_c1b=zeros(size(circ_c1b,2),1);
for i=1:size(circ_c1b,2)
    scores=[circ_c1b(:,i);bg_c1b(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c1b,1)+1:end)=0;
    [X_c1b(:,i),Y_c1b(:,i),THRE,AUC_c1b(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_c2b=zeros(size(circ_c2b,1)+size(bg_c2b,1)+1,size(circ_c2b,2));
Y_c2b=zeros(size(circ_c2b,1)+size(bg_c2b,1)+1,size(circ_c2b,2));
AUC_c2b=zeros(size(circ_c2b,2),1);
for i=1:size(circ_c2b,2)
    scores=[circ_c2b(:,i);bg_c2b(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c2b,1)+1:end)=0;
    [X_c2b(:,i),Y_c2b(:,i),THRE,AUC_c2b(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_c4b=zeros(size(circ_c4b,1)+size(bg_c4b,1)+1,size(circ_c4b,2));
Y_c4b=zeros(size(circ_c4b,1)+size(bg_c4b,1)+1,size(circ_c4b,2));
AUC_c4b=zeros(size(circ_c4b,2),1);
for i=1:size(circ_c4b,2)
    scores=[circ_c4b(:,i);bg_c4b(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c4b,1)+1:end)=0;
    [X_c4b(:,i),Y_c4b(:,i),THRE,AUC_c4b(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_c5b=zeros(size(circ_c5b,1)+size(bg_c5b,1)+1,size(circ_c5b,2));
Y_c5b=zeros(size(circ_c5b,1)+size(bg_c5b,1)+1,size(circ_c5b,2));
AUC_c5b=zeros(size(circ_c5b,2),1);
for i=1:size(circ_c5b,2)
    scores=[circ_c5b(:,i);bg_c5b(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c5b,1)+1:end)=0;
    [X_c5b(:,i),Y_c5b(:,i),THRE,AUC_c5b(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

figure;
errorbar(mean(X_c1b,2),mean(Y_c1b,2),std(Y_c1b,0,2)/sqrt(size(Y_c1b,2)))
hold on
errorbar(mean(X_c2b,2),mean(Y_c2b,2),std(Y_c2b,0,2)/sqrt(size(Y_c2b,2)),'c')
errorbar(mean(X_c4b,2),mean(Y_c4b,2),std(Y_c4b,0,2)/sqrt(size(Y_c4b,2)),'m')
errorbar(mean(X_c5b,2),mean(Y_c5b,2),std(Y_c5b,0,2)/sqrt(size(Y_c5b,2)),'r')

a=[mean(AUC_c1b) mean(AUC_c2b) mean(AUC_c4b) mean(AUC_c5b)];
b=[std(AUC_c1b)/sqrt(size(AUC_c1b,1)) std(AUC_c2b)/sqrt(size(AUC_c2b,1)) std(AUC_c4b)/sqrt(size(AUC_c4b,1)) std(AUC_c5b)/sqrt(size(AUC_c5b,1))];
figure;
bar(a)
hold on
errorbar(a,b)

AUC_cont=[AUC_c1b;AUC_c2b];
AUC_non=[AUC_c4b;AUC_c5b];


[n1 x1]=hist([AUC_c1b;AUC_c2b],0.3:0.02:1);
[n2 x2]=hist([AUC_c4b;AUC_c5b],0.3:0.02:1);
figure;bar(x1,[n1/size([AUC_c1b;AUC_c2b],1);n2/size([AUC_c4b;AUC_c5b],1)]')
legend('contour','non-contour')

scores=[AUC_cont;AUC_non]';
labels=ones(1,size(scores,2));
labels(size(AUC_cont,1)+1:end)=0;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)




%% 2912

%c
circ_c1c=squeeze(mean(cond1n_dt_bl(roi_circle,48:58,:),2))-1;
bg_c1c=squeeze(mean(cond1n_dt_bl(roi_bg_out,48:58,:),2))-1;
circ_c2c=squeeze(mean(cond2n_dt_bl(roi_circle,48:58,:),2))-1;
bg_c2c=squeeze(mean(cond2n_dt_bl(roi_bg_out,48:58,:),2))-1;
circ_c4c=squeeze(mean(cond4n_dt_bl(roi_circle,48:58,:),2))-1;
bg_c4c=squeeze(mean(cond4n_dt_bl(roi_bg_out,48:58,:),2))-1;
circ_c5c=squeeze(mean(cond5n_dt_bl(roi_circle,48:58,:),2))-1;
bg_c5c=squeeze(mean(cond5n_dt_bl(roi_bg_out,48:58,:),2))-1;




X_c1c=zeros(size(circ_c1c,1)+size(bg_c1c,1)+1,size(circ_c1c,2));
Y_c1c=zeros(size(circ_c1c,1)+size(bg_c1c,1)+1,size(circ_c1c,2));
AUC_c1c=zeros(size(circ_c1c,2),1);
for i=1:size(circ_c1c,2)
    scores=[circ_c1c(:,i);bg_c1c(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c1c,1)+1:end)=0;
    [X_c1c(:,i),Y_c1c(:,i),THRE,AUC_c1c(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_c2c=zeros(size(circ_c2c,1)+size(bg_c2c,1)+1,size(circ_c2c,2));
Y_c2c=zeros(size(circ_c2c,1)+size(bg_c2c,1)+1,size(circ_c2c,2));
AUC_c2c=zeros(size(circ_c2c,2),1);
for i=1:size(circ_c2c,2)
    scores=[circ_c2c(:,i);bg_c2c(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c2c,1)+1:end)=0;
    [X_c2c(:,i),Y_c2c(:,i),THRE,AUC_c2c(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_c4c=zeros(size(circ_c4c,1)+size(bg_c4c,1)+1,size(circ_c4c,2));
Y_c4c=zeros(size(circ_c4c,1)+size(bg_c4c,1)+1,size(circ_c4c,2));
AUC_c4c=zeros(size(circ_c4c,2),1);
for i=1:size(circ_c4c,2)
    scores=[circ_c4c(:,i);bg_c4c(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c4c,1)+1:end)=0;
    [X_c4c(:,i),Y_c4c(:,i),THRE,AUC_c4c(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
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
errorbar(mean(X_c2c,2),mean(Y_c2c,2),std(Y_c2c,0,2)/sqrt(size(Y_c2c,2)),'c')
errorbar(mean(X_c4c,2),mean(Y_c4c,2),std(Y_c4c,0,2)/sqrt(size(Y_c4c,2)),'m')
errorbar(mean(X_c5c,2),mean(Y_c5c,2),std(Y_c5c,0,2)/sqrt(size(Y_c5c,2)),'r')

a=[mean(AUC_c1c) mean(AUC_c2c) mean(AUC_c4c) mean(AUC_c5c)];
b=[std(AUC_c1c)/sqrt(size(AUC_c1c,1)) std(AUC_c2c)/sqrt(size(AUC_c2c,1)) std(AUC_c4c)/sqrt(size(AUC_c4c,1)) std(AUC_c5c)/sqrt(size(AUC_c5c,1))];
figure;
bar(a)
hold on
errorbar(a,b)

AUC_cont=[AUC_c1c;AUC_c2c];
AUC_non=[AUC_c4c;AUC_c5c];


[n1 x1]=hist([AUC_c1c;AUC_c2c],0.3:0.02:1);
[n2 x2]=hist([AUC_c4c;AUC_c5c],0.3:0.02:1);
figure;bar(x1,[n1/size([AUC_c1c;AUC_c2c],1);n2/size([AUC_c4c;AUC_c5c],1)]')
legend('contour','non-contour')

scores=[AUC_cont;AUC_non]';
labels=ones(1,size(scores,2));
labels(size(AUC_cont,1)+1:end)=0;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)




%e
circ_c1e=squeeze(mean(cond1n_dt_bl(roi_circle,48:58,:),2))-1;
bg_c1e=squeeze(mean(cond1n_dt_bl(roi_bg_out,48:58,:),2))-1;
circ_c2e=squeeze(mean(cond2n_dt_bl(roi_circle,48:58,:),2))-1;
bg_c2e=squeeze(mean(cond2n_dt_bl(roi_bg_out,48:58,:),2))-1;
circ_c4e=squeeze(mean(cond4n_dt_bl(roi_circle,48:58,:),2))-1;
bg_c4e=squeeze(mean(cond4n_dt_bl(roi_bg_out,48:58,:),2))-1;
circ_c5e=squeeze(mean(cond5n_dt_bl(roi_circle,48:58,:),2))-1;
bg_c5e=squeeze(mean(cond5n_dt_bl(roi_bg_out,48:58,:),2))-1;




X_c1e=zeros(size(circ_c1e,1)+size(bg_c1e,1)+1,size(circ_c1e,2));
Y_c1e=zeros(size(circ_c1e,1)+size(bg_c1e,1)+1,size(circ_c1e,2));
AUC_c1e=zeros(size(circ_c1e,2),1);
for i=1:size(circ_c1e,2)
    scores=[circ_c1e(:,i);bg_c1e(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c1e,1)+1:end)=0;
    [X_c1e(:,i),Y_c1e(:,i),THRE,AUC_c1e(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_c2e=zeros(size(circ_c2e,1)+size(bg_c2e,1)+1,size(circ_c2e,2));
Y_c2e=zeros(size(circ_c2e,1)+size(bg_c2e,1)+1,size(circ_c2e,2));
AUC_c2e=zeros(size(circ_c2e,2),1);
for i=1:size(circ_c2e,2)
    scores=[circ_c2e(:,i);bg_c2e(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c2e,1)+1:end)=0;
    [X_c2e(:,i),Y_c2e(:,i),THRE,AUC_c2e(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_c4e=zeros(size(circ_c4e,1)+size(bg_c4e,1)+1,size(circ_c4e,2));
Y_c4e=zeros(size(circ_c4e,1)+size(bg_c4e,1)+1,size(circ_c4e,2));
AUC_c4e=zeros(size(circ_c4e,2),1);
for i=1:size(circ_c4e,2)
    scores=[circ_c4e(:,i);bg_c4e(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c4e,1)+1:end)=0;
    [X_c4e(:,i),Y_c4e(:,i),THRE,AUC_c4e(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
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
errorbar(mean(X_c2e,2),mean(Y_c2e,2),std(Y_c2e,0,2)/sqrt(size(Y_c2e,2)),'c')
errorbar(mean(X_c4e,2),mean(Y_c4e,2),std(Y_c4e,0,2)/sqrt(size(Y_c4e,2)),'m')
errorbar(mean(X_c5e,2),mean(Y_c5e,2),std(Y_c5e,0,2)/sqrt(size(Y_c5e,2)),'r')

a=[mean(AUC_c1e) mean(AUC_c2e) mean(AUC_c4e) mean(AUC_c5e)];
b=[std(AUC_c1e)/sqrt(size(AUC_c1e,1)) std(AUC_c2e)/sqrt(size(AUC_c2e,1)) std(AUC_c4e)/sqrt(size(AUC_c4e,1)) std(AUC_c5e)/sqrt(size(AUC_c5e,1))];
figure;
bar(a)
hold on
errorbar(a,b)

AUC_cont=[AUC_c1e;AUC_c2e];
AUC_non=[AUC_c4e;AUC_c5e];


[n1 x1]=hist([AUC_c1e;AUC_c2e],0.3:0.02:1);
[n2 x2]=hist([AUC_c4e;AUC_c5e],0.3:0.02:1);
figure;bar(x1,[n1/size([AUC_c1e;AUC_c2e],1);n2/size([AUC_c4e;AUC_c5e],1)]')
legend('contour','non-contour')

scores=[AUC_cont;AUC_non]';
labels=ones(1,size(scores,2));
labels(size(AUC_cont,1)+1:end)=0;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)





%k
circ_c1k=squeeze(mean(cond1n_dt_bl(roi_circle,48:58,:),2))-1;
bg_c1k=squeeze(mean(cond1n_dt_bl(roi_bg_out,48:58,:),2))-1;
circ_c2k=squeeze(mean(cond2n_dt_bl(roi_circle,48:58,:),2))-1;
bg_c2k=squeeze(mean(cond2n_dt_bl(roi_bg_out,48:58,:),2))-1;
circ_c4k=squeeze(mean(cond4n_dt_bl(roi_circle,48:58,:),2))-1;
bg_c4k=squeeze(mean(cond4n_dt_bl(roi_bg_out,48:58,:),2))-1;
circ_c5k=squeeze(mean(cond5n_dt_bl(roi_circle,48:58,:),2))-1;
bg_c5k=squeeze(mean(cond5n_dt_bl(roi_bg_out,48:58,:),2))-1;




X_c1k=zeros(size(circ_c1k,1)+size(bg_c1k,1)+1,size(circ_c1k,2));
Y_c1k=zeros(size(circ_c1k,1)+size(bg_c1k,1)+1,size(circ_c1k,2));
AUC_c1k=zeros(size(circ_c1k,2),1);
for i=1:size(circ_c1k,2)
    scores=[circ_c1k(:,i);bg_c1k(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c1k,1)+1:end)=0;
    [X_c1k(:,i),Y_c1k(:,i),THRE,AUC_c1k(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_c2k=zeros(size(circ_c2k,1)+size(bg_c2k,1)+1,size(circ_c2k,2));
Y_c2k=zeros(size(circ_c2k,1)+size(bg_c2k,1)+1,size(circ_c2k,2));
AUC_c2k=zeros(size(circ_c2k,2),1);
for i=1:size(circ_c2k,2)
    scores=[circ_c2k(:,i);bg_c2k(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c2k,1)+1:end)=0;
    [X_c2k(:,i),Y_c2k(:,i),THRE,AUC_c2k(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_c4k=zeros(size(circ_c4k,1)+size(bg_c4k,1)+1,size(circ_c4k,2));
Y_c4k=zeros(size(circ_c4k,1)+size(bg_c4k,1)+1,size(circ_c4k,2));
AUC_c4k=zeros(size(circ_c4k,2),1);
for i=1:size(circ_c4k,2)
    scores=[circ_c4k(:,i);bg_c4k(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c4k,1)+1:end)=0;
    [X_c4k(:,i),Y_c4k(:,i),THRE,AUC_c4k(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

X_c5k=zeros(size(circ_c5k,1)+size(bg_c5k,1)+1,size(circ_c5k,2));
Y_c5k=zeros(size(circ_c5k,1)+size(bg_c5k,1)+1,size(circ_c5k,2));
AUC_c5k=zeros(size(circ_c5k,2),1);
for i=1:size(circ_c5k,2)
    scores=[circ_c5k(:,i);bg_c5k(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(circ_c5k,1)+1:end)=0;
    [X_c5k(:,i),Y_c5k(:,i),THRE,AUC_c5k(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

figure;
errorbar(mean(X_c1k,2),mean(Y_c1k,2),std(Y_c1k,0,2)/sqrt(size(Y_c1k,2)))
hold on
errorbar(mean(X_c2k,2),mean(Y_c2k,2),std(Y_c2k,0,2)/sqrt(size(Y_c2k,2)),'c')
errorbar(mean(X_c4k,2),mean(Y_c4k,2),std(Y_c4k,0,2)/sqrt(size(Y_c4k,2)),'m')
errorbar(mean(X_c5k,2),mean(Y_c5k,2),std(Y_c5k,0,2)/sqrt(size(Y_c5k,2)),'r')

a=[mean(AUC_c1k) mean(AUC_c2k) mean(AUC_c4k) mean(AUC_c5k)];
b=[std(AUC_c1k)/sqrt(size(AUC_c1k,1)) std(AUC_c2k)/sqrt(size(AUC_c2k,1)) std(AUC_c4k)/sqrt(size(AUC_c4k,1)) std(AUC_c5k)/sqrt(size(AUC_c5k,1))];
figure;
bar(a)
hold on
errorbar(a,b)

AUC_cont=[AUC_c1k;AUC_c2k];
AUC_non=[AUC_c4k;AUC_c5k];


[n1 x1]=hist([AUC_c1k;AUC_c2k],0.3:0.02:1);
[n2 x2]=hist([AUC_c4k;AUC_c5k],0.3:0.02:1);
figure;bar(x1,[n1/size([AUC_c1k;AUC_c2k],1);n2/size([AUC_c4k;AUC_c5k],1)]')
legend('contour','non-contour')

scores=[AUC_cont;AUC_non]';
labels=ones(1,size(scores,2));
labels(size(AUC_cont,1)+1:end)=0;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

