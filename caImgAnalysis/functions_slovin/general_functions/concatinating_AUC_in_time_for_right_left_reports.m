


AUC_5_diff_0501=mean(AUC_5_right_0501,1)-mean(AUC_5_left_0501,1);
AUC_10_diff_0501=mean(AUC_10_right_0501,1)-mean(AUC_10_left_0501,1);
AUC_5_diff_2212=mean(AUC_5_right_2212,1)-mean(AUC_5_left_2212,1);
AUC_17_diff_2212=mean(AUC_17_right_2212,1)-mean(AUC_17_left_2212,1);

AUC_diff=cat(1,AUC_5_diff_0501,AUC_10_diff_0501,AUC_5_diff_2212,AUC_17_diff_2212)';




AUC_10_diff_1811=mean(AUC_10_right_1811,1)-mean(AUC_10_left_1811,1);
AUC_15_diff_1811=mean(AUC_15_right_1811,1)-mean(AUC_15_left_1811,1);
AUC_15_diff_2511=mean(AUC_15_right_2511,1)-mean(AUC_15_left_2511,1);
AUC_15_diff_1203=mean(AUC_15_right_1203,1)-mean(AUC_15_left_1203,1);

AUC_diff=cat(1,AUC_10_diff_1811,AUC_15_diff_1811,AUC_15_diff_2511,AUC_15_diff_1203)';

figure;plot(mean(AUC_diff,2))
xlim([20 68])


for i=20:80   
    scores=[AUC_15_right_2511(:,i);AUC_15_left_2511(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(AUC_15_right_2511,1)+1:end)=0;
    [X_10,Y_10,THRE,AUC_15_2511(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
figure;plot(mean(AUC_15_2511,1))
xlim([20 68])
hold on
plot(0.5*ones(1,80),'k')



for i=20:80   
    scores=[AUC_15_right_1811(:,i);AUC_15_left_1811(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(AUC_15_right_1811,1)+1:end)=0;
    [X_10,Y_10,THRE,AUC_15_1811(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
figure;plot(mean(AUC_15_1811,1))
xlim([20 68])
hold on
plot(0.5*ones(1,80),'k')



for i=20:80   
    scores=[AUC_15_right_1203(:,i);AUC_15_left_1203(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(AUC_15_right_1203,1)+1:end)=0;
    [X_10,Y_10,THRE,AUC_15_1203(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
figure;plot(mean(AUC_15_1203,1))
xlim([20 68])
hold on
plot(0.5*ones(1,80),'k')




for i=20:80   
    scores=[AUC_10_right_0501(:,i);AUC_10_left_0501(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(AUC_10_right_0501,1)+1:end)=0;
    [X_10,Y_10,THRE,AUC_10_0501(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
figure;plot(mean(AUC_10_0501,1))
xlim([20 68])
hold on
plot(0.5*ones(1,80),'k')



for i=20:80   
    scores=[AUC_5_right_0501(:,i);AUC_5_left_0501(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(AUC_5_right_0501,1)+1:end)=0;
    [X_10,Y_10,THRE,AUC_5_0501(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
figure;plot(mean(AUC_5_0501,1))
xlim([20 68])
hold on
plot(0.5*ones(1,80),'k')




for i=20:80   
    scores=[AUC_17_right_2212(:,i);AUC_17_left_2212(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(AUC_17_right_2212,1)+1:end)=0;
    [X_10,Y_10,THRE,AUC_17_2212(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
figure;plot(mean(AUC_17_2212,1))
xlim([20 68])
hold on
plot(0.5*ones(1,80),'k')


for i=20:80   
    scores=[AUC_5_right_2212(:,i);AUC_5_left_2212(:,i)]';
    labels=ones(1,size(scores,2));
    labels(size(AUC_5_right_2212,1)+1:end)=0;
    [X_10,Y_10,THRE,AUC_5_2212(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end
figure;plot(mean(AUC_5_2212,1))
xlim([20 68])
hold on
plot(0.5*ones(1,80),'k')



AUC=cat(1,AUC_5_0501,AUC_10_0501,AUC_5_2212,AUC_17_2212);
figure;plot(mean(AUC,1))
xlim([20 68])
hold on
plot(0.5*ones(1,80),'k')


figure;bar(mean(AUC(:,43:53),2))


