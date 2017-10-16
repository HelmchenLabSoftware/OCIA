
%% 0501

[n1 x1]=hist(AUC_10(right_10),0:0.05:1);
[n2 x2]=hist(AUC_10(left_10),0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_10(right_10),AUC_10(left_10))

scores=[AUC_10(right_10);AUC_10(left_10)]';
labels=ones(1,size(scores,2));
labels(size(AUC_10(right_10),1)+1:end)=0;
[X_10,Y_10,THRE,AUC_lr_10,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_10,Y_10)



[n1 x1]=hist(AUC_20(right_20),0:0.05:1);
[n2 x2]=hist(AUC_20(left_20),0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_20(right_20),AUC_20(left_20))

[n1 x1]=hist(AUC_5(right_5),0:0.05:1);
[n2 x2]=hist(AUC_5(left_5),0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_5(right_5),AUC_5(left_5))

scores=[AUC_5(right_5);AUC_5(left_5)]';
labels=ones(1,size(scores,2));
labels(size(AUC_5(right_5),1)+1:end)=0;
[X_5,Y_5,THRE,AUC_lr_5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_15,Y_5)



[n1 x1]=hist(AUC_15(right_15),0:0.05:1);
[n2 x2]=hist(AUC_15(left_15),0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_15(right_15),AUC_15(left_15))



AUC_right=cat(1,AUC_5(right_5),AUC_10(right_10),AUC_15(right_15),AUC_20(right_20));
AUC_left=cat(1,AUC_5(left_5),AUC_10(left_10),AUC_15(left_15),AUC_20(left_20));

[n1 x1]=hist(AUC_right,0:0.05:1);
[n2 x2]=hist(AUC_left,0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_right,AUC_left)

scores=[AUC_right;AUC_left]';
labels=ones(1,size(scores,2));
labels(size(AUC_right,1)+1:end)=0;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


%% 2212

[n1 x1]=hist(AUC_10(right_10),0:0.05:1);
[n2 x2]=hist(AUC_10(left_10),0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_10(right_10),AUC_10(left_10))
scores=[AUC_10(right_10);AUC_10(left_10)]';
labels=ones(1,size(scores,2));
labels(size(AUC_10(right_10),1)+1:end)=0;
[X_10,Y_10,THRE,AUC_lr_10,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_10,Y_10)



[n1 x1]=hist(AUC_17(right_17),0:0.05:1);
[n2 x2]=hist(AUC_17(left_17),0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_17(right_17),AUC_17(left_17))
scores=[AUC_17(right_17);AUC_10(left_17)]';
labels=ones(1,size(scores,2));
labels(size(AUC_17(right_17),1)+1:end)=0;
[X_17,Y_17,THRE,AUC_lr_17,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_17,Y_17)


[n1 x1]=hist(AUC_5(right_5),0:0.05:1);
[n2 x2]=hist(AUC_5(left_5),0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_5(right_5),AUC_5(left_5))

scores=[AUC_5(right_5);AUC_5(left_5)]';
labels=ones(1,size(scores,2));
labels(size(AUC_5(right_5),1)+1:end)=0;
[X_5,Y_5,THRE,AUC_lr_5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_5,Y_5)



[n1 x1]=hist(AUC_20(right_20),0:0.05:1);
[n2 x2]=hist(AUC_20(left_20),0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_20(right_20),AUC_20(left_20))

scores=[AUC_20(right_20);AUC_20(left_20)]';
labels=ones(1,size(scores,2));
labels(size(AUC_20(right_20),1)+1:end)=0;
[X_20,Y_20,THRE,AUC_lr_20,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_20,Y_20)



AUC_right=cat(1,AUC_5(right_5),AUC_10(right_10),AUC_17(right_17),AUC_20(right_20));
AUC_left=cat(1,AUC_5(left_5),AUC_10(left_10),AUC_17(left_17),AUC_20(left_20));

[n1 x1]=hist(AUC_right,0:0.05:1);
[n2 x2]=hist(AUC_left,0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_right,AUC_left)

scores=[AUC_right;AUC_left]';
labels=ones(1,size(scores,2));
labels(size(AUC_right,1)+1:end)=0;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)




%% 2511

[n1 x1]=hist(AUC_10_right,0:0.05:1);
[n2 x2]=hist(AUC_10_left,0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_10_right,AUC_10_left)

scores=[AUC_10_right;AUC_10_left]';
labels=ones(1,size(scores,2));
labels(size(AUC_10_right,1)+1:end)=0;
[X_10,Y_10,THRE,AUC_lr_10,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_10,Y_10)


[n1 x1]=hist(AUC_15_right,0:0.05:1);
[n2 x2]=hist(AUC_15_left,0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_15_right,AUC_15_left)

scores=[AUC_15_right;AUC_15_left]';
labels=ones(1,size(scores,2));
labels(size(AUC_15_right,1)+1:end)=0;
[X_15,Y_15,THRE,AUC_lr_15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_15,Y_15)


[n1 x1]=hist(AUC_17_right,0:0.05:1);
[n2 x2]=hist(AUC_17_left,0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_17_right,AUC_17_left)

scores=[AUC_17_right;AUC_17_left]';
labels=ones(1,size(scores,2));
labels(size(AUC_17_right,1)+1:end)=0;
[X_17,Y_17,THRE,AUC_lr_17,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_17,Y_17)


[n1 x1]=hist(AUC_20_right,0:0.05:1);
[n2 x2]=hist(AUC_20_left,0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_20_right,AUC_20_left)

scores=[AUC_20_right;AUC_20_left]';
labels=ones(1,size(scores,2));
labels(size(AUC_20_right,1)+1:end)=0;
[X_20,Y_20,THRE,AUC_lr_20,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_20,Y_20)


[n1 x1]=hist(AUC_25_right,0:0.05:1);
[n2 x2]=hist(AUC_25_left,0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_25_right,AUC_25_left)

scores=[AUC_25_right;AUC_25_left]';
labels=ones(1,size(scores,2));
labels(size(AUC_25_right,1)+1:end)=0;
[X_25,Y_25,THRE,AUC_lr_25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_25,Y_25)



AUC_right=cat(1,AUC_10_right,AUC_17_right,AUC_20_right,AUC_25_right);
AUC_left=cat(1,AUC_10_left,AUC_17_left,AUC_20_left,AUC_25_left);

[n1 x1]=hist(AUC_right,0:0.05:1);
[n2 x2]=hist(AUC_left,0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_right,AUC_left)

scores=[AUC_right;AUC_left]';
labels=ones(1,size(scores,2));
labels(size(AUC_right,1)+1:end)=0;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)






%% 1811
[n1 x1]=hist(AUC_5_right,0:0.05:1);
[n2 x2]=hist(AUC_5_left,0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_5_right,AUC_5_left)

scores=[AUC_5_right;AUC_5_left]';
labels=ones(1,size(scores,2));
labels(size(AUC_5_right,1)+1:end)=0;
[X_5,Y_5,THRE,AUC_lr_5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_5,Y_5)

[n1 x1]=hist(AUC_10_right,0:0.05:1);
[n2 x2]=hist(AUC_10_left,0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_10_right,AUC_10_left)

scores=[AUC_10_right;AUC_10_left]';
labels=ones(1,size(scores,2));
labels(size(AUC_10_right,1)+1:end)=0;
[X_10,Y_10,THRE,AUC_lr_10,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_10,Y_10)


[n1 x1]=hist(AUC_15_right,0:0.05:1);
[n2 x2]=hist(AUC_15_left,0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_15_right,AUC_15_left)

scores=[AUC_15_right;AUC_15_left]';
labels=ones(1,size(scores,2));
labels(size(AUC_15_right,1)+1:end)=0;
[X_15,Y_15,THRE,AUC_lr_15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_15,Y_15)


[n1 x1]=hist(AUC_17_right,0:0.05:1);
[n2 x2]=hist(AUC_17_left,0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_17_right,AUC_17_left)

scores=[AUC_17_right;AUC_17_left]';
labels=ones(1,size(scores,2));
labels(size(AUC_17_right,1)+1:end)=0;
[X_17,Y_17,THRE,AUC_lr_17,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_17,Y_17)


[n1 x1]=hist(AUC_20_right,0:0.05:1);
[n2 x2]=hist(AUC_20_left,0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_20_right,AUC_20_left)

scores=[AUC_20_right;AUC_20_left]';
labels=ones(1,size(scores,2));
labels(size(AUC_20_right,1)+1:end)=0;
[X_20,Y_20,THRE,AUC_lr_20,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_20,Y_20)


[n1 x1]=hist(AUC_25_right,0:0.05:1);
[n2 x2]=hist(AUC_25_left,0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_25_right,AUC_25_left)

scores=[AUC_25_right;AUC_25_left]';
labels=ones(1,size(scores,2));
labels(size(AUC_25_right,1)+1:end)=0;
[X_25,Y_25,THRE,AUC_lr_25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_25,Y_25)



AUC_right=cat(1,AUC_5_right,AUC_10_right,AUC_17_right,AUC_20_right,AUC_25_right);
AUC_left=cat(1,AUC_5_left,AUC_10_left,AUC_17_left,AUC_20_left,AUC_25_left);

[n1 x1]=hist(AUC_right,0:0.05:1);
[n2 x2]=hist(AUC_left,0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_right,AUC_left)

scores=[AUC_right;AUC_left]';
labels=ones(1,size(scores,2));
labels(size(AUC_right,1)+1:end)=0;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)




%% 1203


[n1 x1]=hist(AUC_10_right,0:0.05:1);
[n2 x2]=hist(AUC_10_left,0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_10_right,AUC_10_left)

scores=[AUC_10_right;AUC_10_left]';
labels=ones(1,size(scores,2));
labels(size(AUC_10_right,1)+1:end)=0;
[X_10,Y_10,THRE,AUC_lr_10,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_10,Y_10)


[n1 x1]=hist(AUC_15_right,0:0.05:1);
[n2 x2]=hist(AUC_15_left,0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_15_right,AUC_15_left)

scores=[AUC_15_right;AUC_15_left]';
labels=ones(1,size(scores,2));
labels(size(AUC_15_right,1)+1:end)=0;
[X_15,Y_15,THRE,AUC_lr_15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_15,Y_15)



[n1 x1]=hist(AUC_20_right,0:0.05:1);
[n2 x2]=hist(AUC_20_left,0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_20_right,AUC_20_left)

scores=[AUC_20_right;AUC_20_left]';
labels=ones(1,size(scores,2));
labels(size(AUC_20_right,1)+1:end)=0;
[X_20,Y_20,THRE,AUC_lr_20,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_20,Y_20)


[n1 x1]=hist(AUC_25_right,0:0.05:1);
[n2 x2]=hist(AUC_25_left,0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_25_right,AUC_25_left)

scores=[AUC_25_right;AUC_25_left]';
labels=ones(1,size(scores,2));
labels(size(AUC_25_right,1)+1:end)=0;
[X_25,Y_25,THRE,AUC_lr_25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_25,Y_25)

[n1 x1]=hist(AUC_30_right,0:0.05:1);
[n2 x2]=hist(AUC_30_left,0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_30_right,AUC_30_left)

scores=[AUC_30_right;AUC_30_left]';
labels=ones(1,size(scores,2));
labels(size(AUC_30_right,1)+1:end)=0;
[X_30,Y_30,THRE,AUC_lr_30,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_30,Y_30)



AUC_right=cat(1,AUC_10_right,AUC_20_right,AUC_25_right,AUC_30_right);
AUC_left=cat(1,AUC_10_left,AUC_20_left,AUC_25_left,AUC_30_left);

[n1 x1]=hist(AUC_right,0:0.05:1);
[n2 x2]=hist(AUC_left,0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_right,AUC_left)

scores=[AUC_right;AUC_left]';
labels=ones(1,size(scores,2));
labels(size(AUC_right,1)+1:end)=0;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)




%% legolas


AUC_right_leg=cat(1,AUC_right_1811,AUC_right_2511);
AUC_left_leg=cat(1,AUC_left_1811,AUC_left_2511);

[n1 x1]=hist(AUC_right_leg,0:0.05:1);
[n2 x2]=hist(AUC_left_leg,0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_right_leg,AUC_left_leg)

scores=[AUC_right_leg;AUC_left_leg]';
labels=ones(1,size(scores,2));
labels(size(AUC_right_leg,1)+1:end)=0;
[X_leg,Y_leg,THRE,AUC_leg,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_leg,Y_leg)




AUC_right_smeg=cat(1,AUC_right_2212,AUC_right_0501);
AUC_left_smeg=cat(1,AUC_left_2212,AUC_left_0501);

[n1 x1]=hist(AUC_right_smeg,0:0.05:1);
[n2 x2]=hist(AUC_left_smeg,0:0.05:1);
figure;bar(x1,[n1;n2]')
ranksum(AUC_right_smeg,AUC_left_smeg)

scores=[AUC_right_smeg;AUC_left_smeg]';
labels=ones(1,size(scores,2));
labels(size(AUC_right_smeg,1)+1:end)=0;
[X_smeg,Y_smeg,THRE,AUC_smeg,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X_smeg,Y_smeg)


