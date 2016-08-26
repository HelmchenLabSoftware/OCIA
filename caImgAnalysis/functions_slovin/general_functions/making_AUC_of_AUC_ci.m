


scores=[AUC_c1c;AUC_c4c]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1c,1)+1:end)=0;
[X,Y,THRE,AUC_1111c14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c2c;AUC_c5c]';
labels=ones(1,size(scores,2));
labels(size(AUC_c2c,1)+1:end)=0;
[X,Y,THRE,AUC_1111c25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c1d;AUC_c4d]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1d,1)+1:end)=0;
[X,Y,THRE,AUC_1111d14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c2d;AUC_c5d]';
labels=ones(1,size(scores,2));
labels(size(AUC_c2d,1)+1:end)=0;
[X,Y,THRE,AUC_1111d25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


scores=[AUC_c1h;AUC_c4h]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1h,1)+1:end)=0;
[X,Y,THRE,AUC_1111h14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c2h;AUC_c5h]';
labels=ones(1,size(scores,2));
labels(size(AUC_c2h,1)+1:end)=0;
[X,Y,THRE,AUC_1111h25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



scores=[AUC_c1d;AUC_c4d]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1d,1)+1:end)=0;
[X,Y,THRE,AUC_2210d14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c2d;AUC_c5d]';
labels=ones(1,size(scores,2));
labels(size(AUC_c2d,1)+1:end)=0;
[X,Y,THRE,AUC_2210d25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


scores=[AUC_c1e;AUC_c4e]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1e,1)+1:end)=0;
[X,Y,THRE,AUC_2210e14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c2e;AUC_c5e]';
labels=ones(1,size(scores,2));
labels(size(AUC_c2e,1)+1:end)=0;
[X,Y,THRE,AUC_2210e25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



scores=[AUC_c1e;AUC_c4e]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1e,1)+1:end)=0;
[X,Y,THRE,AUC_0610e14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c2e;AUC_c5e]';
labels=ones(1,size(scores,2));
labels(size(AUC_c2e,1)+1:end)=0;
[X,Y,THRE,AUC_0610e25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



scores=[AUC_c1f;AUC_c4f]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1f,1)+1:end)=0;
[X,Y,THRE,AUC_0610f14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c2f;AUC_c5f]';
labels=ones(1,size(scores,2));
labels(size(AUC_c2f,1)+1:end)=0;
[X,Y,THRE,AUC_0610f25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)





scores=[AUC_c1c;AUC_c5c]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1c,1)+1:end)=0;
[X,Y,THRE,AUC_1811c15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c1d;AUC_c5d]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1d,1)+1:end)=0;
[X,Y,THRE,AUC_1811d15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c1e;AUC_c5e]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1e,1)+1:end)=0;
[X,Y,THRE,AUC_1811e15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


scores=[AUC_c1d;AUC_c5d]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1d,1)+1:end)=0;
[X,Y,THRE,AUC_2511d15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c1e;AUC_c5e]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1e,1)+1:end)=0;
[X,Y,THRE,AUC_2511e15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c1f;AUC_c5f]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1f,1)+1:end)=0;
[X,Y,THRE,AUC_2511f15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



scores=[AUC_c1d;AUC_c5d]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1d,1)+1:end)=0;
[X,Y,THRE,AUC_1203d15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c1e;AUC_c5e]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1e,1)+1:end)=0;
[X,Y,THRE,AUC_1203e15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c1f;AUC_c5f]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1f,1)+1:end)=0;
[X,Y,THRE,AUC_1203f15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



AUC_leg=[AUC_1111c14 AUC_1111c25 AUC_1111d14 AUC_1111d25 AUC_1111h14 AUC_1111h25 ...
    AUC_1811c15 AUC_1811d15 AUC_1811e15 AUC_2511d15 AUC_2511e15 AUC_2511f15 ...
    AUC_1203d15 AUC_1203e15 AUC_1203f15 AUC_0610e14 AUC_0610e25 AUC_0610f14 ...
    AUC_0610f25 AUC_2210d14 AUC_2210d25 AUC_2210e14 AUC_2210e25];



%% psychophysics

%1811
scores=[AUC_c1c;AUC_c5c]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1c,1)+1:end)=0;
[X,Y,THRE,AUC_1811_c,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_5;AUC_c5c]';
labels=ones(1,size(scores,2));
labels(size(AUC_5,1)+1:end)=0;
[X,Y,THRE,AUC_1811_5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_15;AUC_c5c]';
labels=ones(1,size(scores,2));
labels(size(AUC_15,1)+1:end)=0;
[X,Y,THRE,AUC_1811_15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)






scores=[AUC_c1d;AUC_c5d]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1d,1)+1:end)=0;
[X,Y,THRE,AUC_1811_d,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_10;AUC_c5d]';
labels=ones(1,size(scores,2));
labels(size(AUC_10,1)+1:end)=0;
[X,Y,THRE,AUC_1811_10,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_20;AUC_c5d]';
labels=ones(1,size(scores,2));
labels(size(AUC_20,1)+1:end)=0;
[X,Y,THRE,AUC_1811_20,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


scores=[AUC_c1e;AUC_c5e]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1e,1)+1:end)=0;
[X,Y,THRE,AUC_1811_e,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_17;AUC_c5e]';
labels=ones(1,size(scores,2));
labels(size(AUC_17,1)+1:end)=0;
[X,Y,THRE,AUC_1811_17,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_25;AUC_c5e]';
labels=ones(1,size(scores,2));
labels(size(AUC_25,1)+1:end)=0;
[X,Y,THRE,AUC_1811_25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


AUC_curve_1811(1)=mean([AUC_1811_c,AUC_1811_d,AUC_1811_e]);
AUC_curve_1811(2)=AUC_1811_5;
AUC_curve_1811(3)=AUC_1811_10;
AUC_curve_1811(4)=AUC_1811_15;
AUC_curve_1811(5)=AUC_1811_17;
AUC_curve_1811(6)=AUC_1811_20;
AUC_curve_1811(7)=AUC_1811_25;
AUC_curve_1811(8)=0.5;

jit=[0 5 10 15 17 20 25 45];
figure;plot(jit,AUC_curve_1811)







%2511

scores=[AUC_c1d;AUC_c5d]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1d,1)+1:end)=0;
[X,Y,THRE,AUC_2511_d,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_15;AUC_c5d]';
labels=ones(1,size(scores,2));
labels(size(AUC_15,1)+1:end)=0;
[X,Y,THRE,AUC_2511_15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_20;AUC_c5d]';
labels=ones(1,size(scores,2));
labels(size(AUC_20,1)+1:end)=0;
[X,Y,THRE,AUC_2511_20,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)




scores=[AUC_c1e;AUC_c5e]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1e,1)+1:end)=0;
[X,Y,THRE,AUC_2511_e,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_17;AUC_c5e]';
labels=ones(1,size(scores,2));
labels(size(AUC_17,1)+1:end)=0;
[X,Y,THRE,AUC_2511_17,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_20;AUC_c5e]';
labels=ones(1,size(scores,2));
labels(size(AUC_20,1)+1:end)=0;
[X,Y,THRE,AUC_2511_20,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)





scores=[AUC_c1f;AUC_c5f]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1f,1)+1:end)=0;
[X,Y,THRE,AUC_2511_f,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_5;AUC_c5f]';
labels=ones(1,size(scores,2));
labels(size(AUC_5,1)+1:end)=0;
[X,Y,THRE,AUC_2511_5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_25;AUC_c5f]';
labels=ones(1,size(scores,2));
labels(size(AUC_25,1)+1:end)=0;
[X,Y,THRE,AUC_2511_25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



AUC_curve_2511(1)=mean([AUC_2511_d,AUC_2511_e,AUC_2511_f]);
AUC_curve_2511(2)=AUC_2511_5;
AUC_curve_2511(3)=AUC_2511_10;
AUC_curve_2511(4)=AUC_2511_15;
AUC_curve_2511(5)=AUC_2511_17;
AUC_curve_2511(6)=AUC_2511_20;
AUC_curve_2511(7)=AUC_2511_25;
AUC_curve_2511(8)=0.5;

jit=[0 5 10 15 17 20 25 45];
figure;plot(jit,AUC_curve_2511)




%1203

scores=[AUC_c1d;AUC_c5d]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1d,1)+1:end)=0;
[X,Y,THRE,AUC_1203_d,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_15;AUC_c5d]';
labels=ones(1,size(scores,2));
labels(size(AUC_15,1)+1:end)=0;
[X,Y,THRE,AUC_1203_15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_20;AUC_c5d]';
labels=ones(1,size(scores,2));
labels(size(AUC_20,1)+1:end)=0;
[X,Y,THRE,AUC_1203_20,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)




scores=[AUC_c1e;AUC_c5e]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1e,1)+1:end)=0;
[X,Y,THRE,AUC_1203_e,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_5;AUC_c5e]';
labels=ones(1,size(scores,2));
labels(size(AUC_5,1)+1:end)=0;
[X,Y,THRE,AUC_1203_5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_10;AUC_c5e]';
labels=ones(1,size(scores,2));
labels(size(AUC_10,1)+1:end)=0;
[X,Y,THRE,AUC_1203_10,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)





scores=[AUC_c1f;AUC_c5f]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1f,1)+1:end)=0;
[X,Y,THRE,AUC_1203_f,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_25;AUC_c5f]';
labels=ones(1,size(scores,2));
labels(size(AUC_25,1)+1:end)=0;
[X,Y,THRE,AUC_1203_25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_30;AUC_c5f]';
labels=ones(1,size(scores,2));
labels(size(AUC_30,1)+1:end)=0;
[X,Y,THRE,AUC_1203_30,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



AUC_curve_1203(1)=mean([AUC_1203_d,AUC_1203_e,AUC_1203_f]);
AUC_curve_1203(2)=AUC_1203_5;
AUC_curve_1203(3)=AUC_1203_10;
AUC_curve_1203(4)=AUC_1203_15;
AUC_curve_1203(5)=AUC_1203_20;
AUC_curve_1203(6)=AUC_1203_25;
AUC_curve_1203(7)=AUC_1203_30;
AUC_curve_1203(8)=0.5;

jit=[0 5 10 15 20 25 30 45];
figure;plot(jit,AUC_curve_1203)



%% legolas

AUC_curve_leg(1)=mean([AUC_curve_1811(1),AUC_curve_2511(1),AUC_curve_1203(1)]);
AUC_curve_leg(2)=mean([AUC_curve_1811(2),AUC_curve_2511(2),AUC_curve_1203(2)]);
AUC_curve_leg(3)=mean([AUC_curve_1811(3),AUC_curve_2511(3),AUC_curve_1203(3)]);
AUC_curve_leg(4)=mean([AUC_curve_1811(4),AUC_curve_2511(4),AUC_curve_1203(4)]);
AUC_curve_leg(5)=mean([AUC_curve_1811(5),AUC_curve_2511(5)]);
AUC_curve_leg(6)=mean([AUC_curve_1811(6),AUC_curve_2511(6),AUC_curve_1203(5)]);
AUC_curve_leg(7)=mean([AUC_curve_1811(7),AUC_curve_2511(7),AUC_curve_1203(6)]);
AUC_curve_leg(8)=AUC_curve_1203(7);
AUC_curve_leg(9)=0.5;

jit=[0 5 10 15 17 20 25 30 45];
figure;plot(jit,AUC_curve_leg)





%% SMEAGOL

scores=[AUC_c1c;AUC_c4c]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1c,1)+1:end)=0;
[X,Y,THRE,AUC_2912c14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c2c;AUC_c5c]';
labels=ones(1,size(scores,2));
labels(size(AUC_c2c,1)+1:end)=0;
[X,Y,THRE,AUC_2912c25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


scores=[AUC_c1e;AUC_c4e]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1e,1)+1:end)=0;
[X,Y,THRE,AUC_2912e14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c2e;AUC_c5e]';
labels=ones(1,size(scores,2));
labels(size(AUC_c2e,1)+1:end)=0;
[X,Y,THRE,AUC_2912e25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c1k;AUC_c4k]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1k,1)+1:end)=0;
[X,Y,THRE,AUC_2912k14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c2k;AUC_c5k]';
labels=ones(1,size(scores,2));
labels(size(AUC_c2k,1)+1:end)=0;
[X,Y,THRE,AUC_2912k25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



scores=[AUC_c1b;AUC_c4b]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1b,1)+1:end)=0;
[X,Y,THRE,AUC_0501b14,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c2b;AUC_c5b]';
labels=ones(1,size(scores,2));
labels(size(AUC_c2b,1)+1:end)=0;
[X,Y,THRE,AUC_0501b25,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



scores=[AUC_c1c;AUC_c5c]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1c,1)+1:end)=0;
[X,Y,THRE,AUC_0501c15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_c1d;AUC_c5d]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1d,1)+1:end)=0;
[X,Y,THRE,AUC_0501d15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)





AUC_smeg=[AUC_2912c14 AUC_2912c25 AUC_2912e14 AUC_2912e25 AUC_2912k14 AUC_2912k25...
    AUC_0501b14 AUC_0501b25 AUC_0501c15 AUC_0501d15];




%% psychophysics smeg

%0501
scores=[AUC_c1c;AUC_c5c]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1c,1)+1:end)=0;
[X,Y,THRE,AUC_0501_c,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_10;AUC_c5c]';
labels=ones(1,size(scores,2));
labels(size(AUC_10,1)+1:end)=0;
[X,Y,THRE,AUC_0501_10,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_20;AUC_c5c]';
labels=ones(1,size(scores,2));
labels(size(AUC_20,1)+1:end)=0;
[X,Y,THRE,AUC_0501_20,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

%0501
scores=[AUC_c1d;AUC_c5d]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1d,1)+1:end)=0;
[X,Y,THRE,AUC_0501_d,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_5;AUC_c5d]';
labels=ones(1,size(scores,2));
labels(size(AUC_5,1)+1:end)=0;
[X,Y,THRE,AUC_0501_5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_15;AUC_c5d]';
labels=ones(1,size(scores,2));
labels(size(AUC_15,1)+1:end)=0;
[X,Y,THRE,AUC_0501_15,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



AUC_curve_0501(1)=mean([AUC_0501_c,AUC_0501_d]);
AUC_curve_0501(2)=AUC_0501_5;
AUC_curve_0501(3)=AUC_0501_10;
AUC_curve_0501(4)=AUC_0501_15;
AUC_curve_0501(5)=AUC_0501_20;
AUC_curve_0501(6)=0.5;

jit=[0 5 10 15 20 45];
figure;plot(jit,AUC_curve_0501)



%2212
scores=[AUC_c1c;AUC_c5c]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1c,1)+1:end)=0;
[X,Y,THRE,AUC_2212_c,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_5;AUC_c5c]';
labels=ones(1,size(scores,2));
labels(size(AUC_5,1)+1:end)=0;
[X,Y,THRE,AUC_2212_5,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_20;AUC_c5c]';
labels=ones(1,size(scores,2));
labels(size(AUC_20,1)+1:end)=0;
[X,Y,THRE,AUC_2212_20,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



scores=[AUC_c1d;AUC_c5d]';
labels=ones(1,size(scores,2));
labels(size(AUC_c1d,1)+1:end)=0;
[X,Y,THRE,AUC_2212_d,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_10;AUC_c5d]';
labels=ones(1,size(scores,2));
labels(size(AUC_10,1)+1:end)=0;
[X,Y,THRE,AUC_2212_10,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[AUC_17;AUC_c5d]';
labels=ones(1,size(scores,2));
labels(size(AUC_17,1)+1:end)=0;
[X,Y,THRE,AUC_2212_17,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



AUC_curve_2212(1)=mean([AUC_2212_c,AUC_2212_d]);
AUC_curve_2212(2)=AUC_2212_5;
AUC_curve_2212(3)=AUC_2212_10;
AUC_curve_2212(4)=AUC_2212_17;
AUC_curve_2212(5)=AUC_2212_20;
AUC_curve_2212(6)=0.5;

jit=[0 5 10 17 20 45];
figure;plot(jit,AUC_curve_2212)

%% smeagol

AUC_curve_smeg(1)=mean([AUC_curve_2212(1),AUC_curve_0501(1)]);
AUC_curve_smeg(2)=mean([AUC_curve_2212(2),AUC_curve_0501(2)]);
AUC_curve_smeg(3)=mean([AUC_curve_2212(3),AUC_curve_0501(3)]);
AUC_curve_smeg(4)=AUC_curve_0501(4);
AUC_curve_smeg(5)=AUC_curve_2212(4);
AUC_curve_smeg(6)=mean([AUC_curve_2212(5),AUC_curve_0501(5)]);
AUC_curve_smeg(7)=mean([AUC_curve_2212(6),AUC_curve_0501(6)]);

jit=[0 5 10 15 17 20 45];
figure;plot(jit,AUC_curve_smeg)




%% both total


figure;bar([mean(AUC_leg) mean(AUC_smeg)])
hold on
errorbar([mean(AUC_leg) mean(AUC_smeg)],[std(AUC_leg)/sqrt(23) std(AUC_smeg)/sqrt(10)])
ylim([0.5 1])

ranksum(AUC_leg,0.5*ones(1,23))
ranksum(AUC_smeg,0.5*ones(1,23))




jit_leg=[0 5 10 15 17 20 25 30 45];
[r p]=corrcoef(jit_leg,AUC_curve_leg)

[r,m,b] = regression(jit_leg,AUC_curve_leg);
xx=0:0.25:45;
figure;plot(jit_leg,AUC_curve_leg)
hold on
plot(xx,m*xx+b)

% [T_es, b_es,r1,r2]=weibull_fit2(jit_leg,AUC_curve_leg);
% xxxx=1:0.1:45;
% figure;
% plot(xxxx,exp(-(xxxx/T_es).^b_es),'-r',jit_leg,AUC_curve_leg,'or')
% %ylim([0 1])




jit_smeg=[0 5 10 15 17 20 45];
figure;plot(jit_smeg,AUC_curve_smeg)
[r p]=corrcoef(jit_smeg,AUC_curve_smeg)


[r,m,b] = regression(jit_smeg,AUC_curve_smeg);
xx=0:0.25:45;
figure;plot(jit_smeg,AUC_curve_smeg)
hold on
plot(xx,m*xx+b)

% [T_es, b_es,r1,r2]=weibull_fit2(jit_smeg,AUC_curve_smeg);
% xxxx=1:0.1:45;
% figure;
% plot(xxxx,exp(-(xxxx/T_es).^b_es),'-r',jit_smeg,AUC_curve_smeg,'or')



[r p]=corrcoef(psych_leg,AUC_curve_leg)
[r p]=corrcoef(psych_smeg,AUC_curve_smeg)











