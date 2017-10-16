


%% 1111cd

fg_cont=cat(1,fg_c1c,fg_c2c,fg_c1d,fg_c2d);
fg_non=cat(1,fg_c4c,fg_c5c,fg_c4d,fg_c5d);

for i=1:100
    iter(:,i)=round(rand(size(fg_cont,1)+size(fg_non,1),1));
end

scores=[fg_cont;fg_non]';
Xshuf=zeros(size(scores,2)+1,100);
Yshuf=zeros(size(scores,2)+1,100);
for i=1:100
    [Xshuf(:,i),Yshuf(:,i),THRE,AUCshuf(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(iter(:,i)',scores,1);
end    

labels=ones(1,size(scores,2));
labels(size(fg_cont,1)+1:end)=0;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)
hold on
plot(mean(Xshuf,2),mean(Yshuf,2))
plot(mean(Xshuf,2)+3*std(Xshuf,0,2),mean(Yshuf,2),'--')
plot(mean(Xshuf,2)-3*std(Xshuf,0,2),mean(Yshuf,2),'--')
xlim([0 1]);ylim([0 1])
axis square



%% for the example trial in figure 6 ci

%1111c cond1
scores=[mean(cond1n_dt_bl(roi_contour2,50:51,14),2)-1;mean(cond1n_dt_bl(roi_maskin,50:51,14),2)-1]';
labels=ones(1,size(scores,2));
labels(size(mean(cond1n_dt_bl(roi_contour2,50:51,14),2)-1,1)+1:end)=0;
Xshuf=zeros(size(scores,2)+1,100);
Yshuf=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf(:,i),Yshuf(:,i),THRE,AUCshuf(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    

[X_tr14,Y_tr14,THRE,AUC_tr14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_tr14,Y_tr14)
hold on
plot(mean(Xshuf,2),mean(Yshuf,2))
plot(mean(Xshuf,2)+3*std(Xshuf,0,2),mean(Yshuf,2),'--')
plot(mean(Xshuf,2)-3*std(Xshuf,0,2),mean(Yshuf,2),'--')
xlim([0 1]);ylim([0 1])
axis square



%1111c cond2 
scores=[mean(cond2n_dt_bl(roi_contour2,48:50,11),2)-1;mean(cond2n_dt_bl(roi_maskin,48:50,11),2)-1]';
labels=ones(1,size(scores,2));
labels(size(mean(cond2n_dt_bl(roi_contour2,48:50,11),2)-1,1)+1:end)=0;
Xshuf=zeros(size(scores,2)+1,100);
Yshuf=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf(:,i),Yshuf(:,i),THRE,AUCshuf(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
[X_tr11,Y_tr11,THRE,AUC_tr11,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_tr11,Y_tr11)
hold on
plot(mean(Xshuf,2),mean(Yshuf,2))
plot(mean(Xshuf,2)+3*std(Xshuf,0,2),mean(Yshuf,2),'--')
plot(mean(Xshuf,2)-3*std(Xshuf,0,2),mean(Yshuf,2),'--')
xlim([0 1]);ylim([0 1])
axis square


%1111c cond5

scores=[mean(cond5n_dt_bl(roi_contour2,43:53,16),2)-1;mean(cond5n_dt_bl(roi_maskin,43:53,16),2)-1]';   
labels=ones(1,size(scores,2));
labels(size(mean(cond5n_dt_bl(roi_contour2,43:53,16),2)-1,1)+1:end)=0;
Xshuf=zeros(size(scores,2)+1,100);
Yshuf=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf(:,i),Yshuf(:,i),THRE,AUCshuf(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
[Xn_tr16,Yn_tr16,THRE,AUCn_tr16,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(Xn_tr16,Yn_tr16)
hold on
plot(mean(Xshuf,2),mean(Yshuf,2))
plot(mean(Xshuf,2)+3*std(Xshuf,0,2),mean(Yshuf,2),'--')
plot(mean(Xshuf,2)-3*std(Xshuf,0,2),mean(Yshuf,2),'--')
xlim([0 1]);ylim([0 1])
axis square



%1111d cond5

scores=[mean(cond5n_dt_bl(roi_contour2,43:53,3),2)-1;mean(cond5n_dt_bl(roi_maskin,43:53,3),2)-1]';
labels=ones(1,size(scores,2));
labels(size(mean(cond5n_dt_bl(roi_contour2,43:53,3),2)-1,1)+1:end)=0;
Xshuf=zeros(size(scores,2)+1,100);
Yshuf=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf(:,i),Yshuf(:,i),THRE,AUCshuf(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
[Xn_tr3,Yn_tr3,THRE,AUCn_tr3,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(Xn_tr3,Yn_tr3)
hold on
plot(mean(Xshuf,2),mean(Yshuf,2))
plot(mean(Xshuf,2)+3*std(Xshuf,0,2),mean(Yshuf,2),'--')
plot(mean(Xshuf,2)-3*std(Xshuf,0,2),mean(Yshuf,2),'--')
xlim([0 1]);ylim([0 1])
axis square



%% now for all the data

%% 1111

%c
scores=[fg_c1c;fg_c4c]';
labels=ones(1,size(scores,2));
labels(size(fg_c1c,1)+1:end)=0;
Xshuf_1111c14=zeros(size(scores,2)+1,100);
Yshuf_1111c14=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_1111c14(:,i),Yshuf_1111c14(:,i),THRE,AUCshuf_1111c14(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_1111c14,2),mean(Yshuf_1111c14,2))


scores=[fg_c2c;fg_c5c]';
labels=ones(1,size(scores,2));
labels(size(fg_c2c,1)+1:end)=0;
Xshuf_1111c25=zeros(size(scores,2)+1,100);
Yshuf_1111c25=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_1111c25(:,i),Yshuf_1111c25(:,i),THRE,AUCshuf_1111c25(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_1111c25,2),mean(Yshuf_1111c25,2))



%d
scores=[fg_c1d;fg_c4d]';
labels=ones(1,size(scores,2));
labels(size(fg_c1d,1)+1:end)=0;
Xshuf_1111d14=zeros(size(scores,2)+1,100);
Yshuf_1111d14=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_1111d14(:,i),Yshuf_1111d14(:,i),THRE,AUCshuf_1111d14(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_1111d14,2),mean(Yshuf_1111d14,2))


scores=[fg_c2d;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_c2d,1)+1:end)=0;
Xshuf_1111d25=zeros(size(scores,2)+1,100);
Yshuf_1111d25=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_1111d25(:,i),Yshuf_1111d25(:,i),THRE,AUCshuf_1111d25(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_1111d25,2),mean(Yshuf_1111d25,2))



%h
scores=[fg_c1h;fg_c4h]';
labels=ones(1,size(scores,2));
labels(size(fg_c1h,1)+1:end)=0;
Xshuf_1111h14=zeros(size(scores,2)+1,100);
Yshuf_1111h14=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_1111h14(:,i),Yshuf_1111h14(:,i),THRE,AUCshuf_1111h14(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_1111h14,2),mean(Yshuf_1111h14,2))


scores=[fg_c2h;fg_c5h]';
labels=ones(1,size(scores,2));
labels(size(fg_c2h,1)+1:end)=0;
Xshuf_1111h25=zeros(size(scores,2)+1,100);
Yshuf_1111h25=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_1111h25(:,i),Yshuf_1111h25(:,i),THRE,AUCshuf_1111h25(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_1111h25,2),mean(Yshuf_1111h25,2))

%% 2210
%d
scores=[fg_c1d;fg_c4d]';
labels=ones(1,size(scores,2));
labels(size(fg_c1d,1)+1:end)=0;
Xshuf_2210d14=zeros(size(scores,2)+1,100);
Yshuf_2210d14=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_2210d14(:,i),Yshuf_2210d14(:,i),THRE,AUCshuf_2210d14(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_2210d14,2),mean(Yshuf_2210d14,2))


scores=[fg_c2d;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_c2d,1)+1:end)=0;
Xshuf_2210d25=zeros(size(scores,2)+1,100);
Yshuf_2210d25=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_2210d25(:,i),Yshuf_2210d25(:,i),THRE,AUCshuf_2210d25(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_2210d25,2),mean(Yshuf_2210d25,2))



%e
scores=[fg_c1e;fg_c4e]';
labels=ones(1,size(scores,2));
labels(size(fg_c1e,1)+1:end)=0;
Xshuf_2210e14=zeros(size(scores,2)+1,100);
Yshuf_2210e14=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_2210e14(:,i),Yshuf_2210e14(:,i),THRE,AUCshuf_2210e14(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_2210e14,2),mean(Yshuf_2210e14,2))


scores=[fg_c2e;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_c2e,1)+1:end)=0;
Xshuf_2210e25=zeros(size(scores,2)+1,100);
Yshuf_2210e25=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_2210e25(:,i),Yshuf_2210e25(:,i),THRE,AUCshuf_2210e25(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_2210e25,2),mean(Yshuf_2210e25,2))



%% 0610
%e
scores=[fg_c1e;fg_c4e]';
labels=ones(1,size(scores,2));
labels(size(fg_c1e,1)+1:end)=0;
Xshuf_0610e14=zeros(size(scores,2)+1,100);
Yshuf_0610e14=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_0610e14(:,i),Yshuf_0610e14(:,i),THRE,AUCshuf_0610e14(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_0610e14,2),mean(Yshuf_0610e14,2))


scores=[fg_c2e;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_c2e,1)+1:end)=0;
Xshuf_0610e25=zeros(size(scores,2)+1,100);
Yshuf_0610e25=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_0610e25(:,i),Yshuf_0610e25(:,i),THRE,AUCshuf_0610e25(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_0610e25,2),mean(Yshuf_0610e25,2))



%f
scores=[fg_c1f;fg_c4f]';
labels=ones(1,size(scores,2));
labels(size(fg_c1f,1)+1:end)=0;
Xshuf_0610f14=zeros(size(scores,2)+1,100);
Yshuf_0610f14=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_0610f14(:,i),Yshuf_0610f14(:,i),THRE,AUCshuf_0610f14(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_0610f14,2),mean(Yshuf_0610f14,2))


scores=[fg_c2f;fg_c5f]';
labels=ones(1,size(scores,2));
labels(size(fg_c2f,1)+1:end)=0;
Xshuf_0610f25=zeros(size(scores,2)+1,100);
Yshuf_0610f25=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_0610f25(:,i),Yshuf_0610f25(:,i),THRE,AUCshuf_0610f25(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_0610f25,2),mean(Yshuf_0610f25,2))



%% 1811
%c
scores=[fg_c1c;fg_c5c]';
labels=ones(1,size(scores,2));
labels(size(fg_c1c,1)+1:end)=0;
Xshuf_1811c15=zeros(size(scores,2)+1,100);
Yshuf_1811c15=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_1811c15(:,i),Yshuf_1811c15(:,i),THRE,AUCshuf_1811c15(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_1811c15,2),mean(Yshuf_1811c15,2))

%d
scores=[fg_c1d;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_c1d,1)+1:end)=0;
Xshuf_1811d15=zeros(size(scores,2)+1,100);
Yshuf_1811d15=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_1811d15(:,i),Yshuf_1811d15(:,i),THRE,AUCshuf_1811d15(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_1811d15,2),mean(Yshuf_1811d15,2))


%e
scores=[fg_c1e;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_c1e,1)+1:end)=0;
Xshuf_1811e15=zeros(size(scores,2)+1,100);
Yshuf_1811e15=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_1811e15(:,i),Yshuf_1811e15(:,i),THRE,AUCshuf_1811e15(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_1811e15,2),mean(Yshuf_1811e15,2))



%% 2511
%d
scores=[fg_c1d;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_c1d,1)+1:end)=0;
Xshuf_2511d15=zeros(size(scores,2)+1,100);
Yshuf_2511d15=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_2511d15(:,i),Yshuf_2511d15(:,i),THRE,AUCshuf_2511d15(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_2511d15,2),mean(Yshuf_2511d15,2))


%e
scores=[fg_c1e;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_c1e,1)+1:end)=0;
Xshuf_2511e15=zeros(size(scores,2)+1,100);
Yshuf_2511e15=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_2511e15(:,i),Yshuf_2511e15(:,i),THRE,AUCshuf_2511e15(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_2511e15,2),mean(Yshuf_2511e15,2))


%f
scores=[fg_c1f;fg_c5f]';
labels=ones(1,size(scores,2));
labels(size(fg_c1f,1)+1:end)=0;
Xshuf_2511f15=zeros(size(scores,2)+1,100);
Yshuf_2511f15=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_2511f15(:,i),Yshuf_2511f15(:,i),THRE,AUCshuf_2511f15(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_2511f15,2),mean(Yshuf_2511f15,2))



%% 1203
%d
scores=[fg_c1d;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_c1d,1)+1:end)=0;
Xshuf_1203d15=zeros(size(scores,2)+1,100);
Yshuf_1203d15=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_1203d15(:,i),Yshuf_1203d15(:,i),THRE,AUCshuf_1203d15(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_1203d15,2),mean(Yshuf_1203d15,2))


%e
scores=[fg_c1e;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_c1e,1)+1:end)=0;
Xshuf_1203e15=zeros(size(scores,2)+1,100);
Yshuf_1203e15=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_1203e15(:,i),Yshuf_1203e15(:,i),THRE,AUCshuf_1203e15(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_1203e15,2),mean(Yshuf_1203e15,2))


%f
scores=[fg_c1f;fg_c5f]';
labels=ones(1,size(scores,2));
labels(size(fg_c1f,1)+1:end)=0;
Xshuf_1203f15=zeros(size(scores,2)+1,100);
Yshuf_1203f15=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_1203f15(:,i),Yshuf_1203f15(:,i),THRE,AUCshuf_1203f15(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_1203f15,2),mean(Yshuf_1203f15,2))



%%


AUCshuf_leg=cat(1,AUCshuf_1111c14,AUCshuf_1111c25,AUCshuf_1111d14,AUCshuf_1111d25,AUCshuf_1111h14,AUCshuf_1111h25, ...
    AUCshuf_1811c15, AUCshuf_1811d15, AUCshuf_1811e15, AUCshuf_2511d15, AUCshuf_2511e15, AUCshuf_2511f15, ...
    AUCshuf_1203d15, AUCshuf_1203e15, AUCshuf_1203f15, AUCshuf_0610e14, AUCshuf_0610e25, AUCshuf_0610f14, ...
    AUCshuf_0610f25, AUCshuf_2210d14, AUCshuf_2210d25, AUCshuf_2210e14, AUCshuf_2210e25);






%% SMEAGOL 2912


%c
scores=[fg_c1c;fg_c4c]';
labels=ones(1,size(scores,2));
labels(size(fg_c1c,1)+1:end)=0;
Xshuf_2912c14=zeros(size(scores,2)+1,100);
Yshuf_2912c14=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_2912c14(:,i),Yshuf_2912c14(:,i),THRE,AUCshuf_2912c14(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_2912c14,2),mean(Yshuf_2912c14,2))


scores=[fg_c2c;fg_c5c]';
labels=ones(1,size(scores,2));
labels(size(fg_c2c,1)+1:end)=0;
Xshuf_2912c25=zeros(size(scores,2)+1,100);
Yshuf_2912c25=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_2912c25(:,i),Yshuf_2912c25(:,i),THRE,AUCshuf_2912c25(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_2912c25,2),mean(Yshuf_2912c25,2))



%e
scores=[fg_c1e;fg_c4e]';
labels=ones(1,size(scores,2));
labels(size(fg_c1e,1)+1:end)=0;
Xshuf_2912e14=zeros(size(scores,2)+1,100);
Yshuf_2912e14=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_2912e14(:,i),Yshuf_2912e14(:,i),THRE,AUCshuf_2912e14(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_2912e14,2),mean(Yshuf_2912e14,2))


scores=[fg_c2e;fg_c5e]';
labels=ones(1,size(scores,2));
labels(size(fg_c2e,1)+1:end)=0;
Xshuf_2912e25=zeros(size(scores,2)+1,100);
Yshuf_2912e25=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_2912e25(:,i),Yshuf_2912e25(:,i),THRE,AUCshuf_2912e25(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_2912e25,2),mean(Yshuf_2912e25,2))



%k
scores=[fg_c1k;fg_c4k]';
labels=ones(1,size(scores,2));
labels(size(fg_c1k,1)+1:end)=0;
Xshuf_2912k14=zeros(size(scores,2)+1,100);
Yshuf_2912k14=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_2912k14(:,i),Yshuf_2912k14(:,i),THRE,AUCshuf_2912k14(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_2912k14,2),mean(Yshuf_2912k14,2))


scores=[fg_c2k;fg_c5k]';
labels=ones(1,size(scores,2));
labels(size(fg_c2k,1)+1:end)=0;
Xshuf_2912k25=zeros(size(scores,2)+1,100);
Yshuf_2912k25=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_2912k25(:,i),Yshuf_2912k25(:,i),THRE,AUCshuf_2912k25(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_2912k25,2),mean(Yshuf_2912k25,2))





%% 0501


%b
scores=[fg_c1b;fg_c4b]';
labels=ones(1,size(scores,2));
labels(size(fg_c1b,1)+1:end)=0;
Xshuf_0501b14=zeros(size(scores,2)+1,100);
Yshuf_0501b14=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_0501b14(:,i),Yshuf_0501b14(:,i),THRE,AUCshuf_0501b14(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_0501b14,2),mean(Yshuf_0501b14,2))


scores=[fg_c2b;fg_c5b]';
labels=ones(1,size(scores,2));
labels(size(fg_c2b,1)+1:end)=0;
Xshuf_0501b25=zeros(size(scores,2)+1,100);
Yshuf_0501b25=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_0501b25(:,i),Yshuf_0501b25(:,i),THRE,AUCshuf_0501b25(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_0501b25,2),mean(Yshuf_0501b25,2))



%c
scores=[fg_c1c;fg_c5c]';
labels=ones(1,size(scores,2));
labels(size(fg_c1c,1)+1:end)=0;
Xshuf_0501c15=zeros(size(scores,2)+1,100);
Yshuf_0501c15=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_0501c15(:,i),Yshuf_0501c15(:,i),THRE,AUCshuf_0501c15(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_0501c15,2),mean(Yshuf_0501c15,2))

%d
scores=[fg_c1d;fg_c5d]';
labels=ones(1,size(scores,2));
labels(size(fg_c1d,1)+1:end)=0;
Xshuf_0501d15=zeros(size(scores,2)+1,100);
Yshuf_0501d15=zeros(size(scores,2)+1,100);
for i=1:100
    ls=randperm(size(scores,2));
    [Xshuf_0501d15(:,i),Yshuf_0501d15(:,i),THRE,AUCshuf_0501d15(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels(ls),scores,1);
end    
figure;plot(mean(Xshuf_0501d15,2),mean(Yshuf_0501d15,2))



%%
AUCshuf_smeg=cat(1,AUCshuf_2912c14, AUCshuf_2912c25, AUCshuf_2912e14, AUCshuf_2912e25, AUCshuf_2912k14, AUCshuf_2912k25, ...
    AUCshuf_0501b14, AUCshuf_0501b25, AUCshuf_0501c15, AUCshuf_0501d15);

%%
figure;bar([mean(mean(AUCshuf_leg)) mean(mean(AUCshuf_smeg))])
hold on
errorbar([mean(mean(AUCshuf_leg)) mean(mean(AUCshuf_smeg))],3*[std(mean(AUCshuf_leg,2),0,1) std(mean(AUCshuf_smeg,2),0,1)])
ylim([0 1])


