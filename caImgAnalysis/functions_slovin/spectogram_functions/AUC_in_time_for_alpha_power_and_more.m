
pow3_V1=squeeze(mean(b(:,roi_V1,:),2));
pow4_V1=squeeze(mean(a(:,roi_V1,:),2));

for i=1:112
    scores=[pow3_V1(i,:) pow4_V1(i,:)];
    labels=zeros(1,size(scores,2));
    labels(size(pow3_V1,2)+1:end)=1;
    [X,Y,THRE,AUC_pow(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

x1=(20:10:1130)-200; %for collinear
figure;plot(x1,AUC_pow)


time4=squeeze(mean(cond4n_dt_bl(roi_V1,:,:)-1,1));
time3=squeeze(mean(cond3n_dt_bl(roi_V1,:,:)-1,1));

for i=1:112
    scores=[time3(i+1,:) time4(i+1,:)];
    labels=zeros(1,size(scores,2));
    labels(size(time3,2)+1:end)=1;
    [X,Y,THRE,AUC_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

x2=(10:10:2560)-280;
figure;plot(x2(2:113),AUC_time,'r')


der4=squeeze(mean(cond4n_dt_bl(roi_V1,6:112,:)-cond4n_dt_bl(roi_V1,2:108,:),1));
der3=squeeze(mean(cond3n_dt_bl(roi_V1,6:112,:)-cond3n_dt_bl(roi_V1,2:108,:),1));

for i=1:107
    scores=[der3(i,:) der4(i,:)];
    labels=zeros(1,size(scores,2));
    labels(size(der3,2)+1:end)=1;
    [X,Y,THRE,AUC_der(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

x3=(30:10:1090)-280;
figure;plot(x3,AUC_der,'g')


%% for one flanker

pow4_V1=squeeze(mean(b(:,roi_V1,:),2));
pow2_V1=squeeze(mean(a(:,roi_V1,:),2));

for i=1:112
    scores=[pow4_V1(i,:) pow2_V1(i,:)];
    labels=zeros(1,size(scores,2));
    labels(size(pow4_V1,2)+1:end)=1;
    [X,Y,THRE,AUC_pow(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

x1=(20:10:1130)-200; %for collinear
figure;plot(x1,AUC_pow)


time2=squeeze(mean(cond2n_dt_bl(roi_V1,:,:)-1,1));
time4=squeeze(mean(cond4n_dt_bl(roi_V1,:,:)-1,1));

for i=1:112
    scores=[time4(i+1,:) time2(i+1,:)];
    labels=zeros(1,size(scores,2));
    labels(size(time4,2)+1:end)=1;
    [X,Y,THRE,AUC_time(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

x2=(10:10:2560)-280;
figure;plot(x2(2:113),AUC_time,'r')


der2=squeeze(mean(cond2n_dt_bl(roi_V1,6:112,:)-cond2n_dt_bl(roi_V1,2:108,:),1));
der4=squeeze(mean(cond4n_dt_bl(roi_V1,6:112,:)-cond4n_dt_bl(roi_V1,2:108,:),1));

for i=1:107
    scores=[der4(i,:) der2(i,:)];
    labels=zeros(1,size(scores,2));
    labels(size(der4,2)+1:end)=1;
    [X,Y,THRE,AUC_der(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

x3=(30:10:1090)-280;
figure;plot(x3,AUC_der,'g')








%%
AUC_pow=mean(cat(1,AUC_pow_1804,AUC_pow_1203,AUC_pow_2011),1);
AUC_time=mean(cat(1,AUC_time_1804,AUC_time_1203,AUC_time_2011),1);
AUC_der=mean(cat(1,AUC_der_1804,AUC_der_1203,AUC_der_2011),1);

x1=(20:10:1130)-200; %for collinear
figure;plot(x1,AUC_pow)

x2=(10:10:2560)-280;
figure;plot(x2(2:113),AUC_time,'r')

x3=(30:10:1090)-280;
figure;plot(x3,AUC_der,'g')



%% normalize for pooling

pow3_V1_1203=squeeze(mean(b(:,roi_V1,:),2));
pow4_V1_1203=squeeze(mean(a(:,roi_V1,:),2));

time4_1203=squeeze(mean(cond4n_dt_bl(roi_V1,:,:)-1,1));
time3_1203=squeeze(mean(cond3n_dt_bl(roi_V1,:,:)-1,1));

der4_1203=squeeze(mean(cond4n_dt_bl(roi_V1,6:112,:)-cond4n_dt_bl(roi_V1,2:108,:),1));
der3_1203=squeeze(mean(cond3n_dt_bl(roi_V1,6:112,:)-cond3n_dt_bl(roi_V1,2:108,:),1));


pow3_V1_1005b=squeeze(mean(b(:,roi_V1,:),2));
pow4_V1_1005b=squeeze(mean(a(:,roi_V1,:),2));

time4_1005b=squeeze(mean(cond4n_dt_bl(roi_V1,:,:)-1,1));
time3_1005b=squeeze(mean(cond3n_dt_bl(roi_V1,:,:)-1,1));

der4_1005b=squeeze(mean(cond4n_dt_bl(roi_V1,6:112,:)-cond4n_dt_bl(roi_V1,2:108,:),1));
der3_1005b=squeeze(mean(cond3n_dt_bl(roi_V1,6:112,:)-cond3n_dt_bl(roi_V1,2:108,:),1));


pow3_V1_1005e=squeeze(mean(b(:,roi_V1,:),2));
pow4_V1_1005e=squeeze(mean(a(:,roi_V1,:),2));

time4_1005e=squeeze(mean(cond4n_dt_bl(roi_V1,:,:)-1,1));
time3_1005e=squeeze(mean(cond3n_dt_bl(roi_V1,:,:)-1,1));

der4_1005e=squeeze(mean(cond4n_dt_bl(roi_V1,6:112,:)-cond4n_dt_bl(roi_V1,2:108,:),1));
der3_1005e=squeeze(mean(cond3n_dt_bl(roi_V1,6:112,:)-cond3n_dt_bl(roi_V1,2:108,:),1));


pow3_V1_2011=squeeze(mean(b(:,roi_V1,:),2));
pow4_V1_2011=squeeze(mean(a(:,roi_V1,:),2));

time4_2011=squeeze(mean(cond4n_dt_bl(roi_V1,:,:)-1,1));
time3_2011=squeeze(mean(cond3n_dt_bl(roi_V1,:,:)-1,1));

der4_2011=squeeze(mean(cond4n_dt_bl(roi_V1,6:112,:)-cond4n_dt_bl(roi_V1,2:108,:),1));
der3_2011=squeeze(mean(cond3n_dt_bl(roi_V1,6:112,:)-cond3n_dt_bl(roi_V1,2:108,:),1));


pow3_V1=cat(2,pow3_V1_1804,pow3_V1_1203,pow3_V1_1005b,pow3_V1_1005b,pow3_V1_2011);
pow4_V1=cat(2,pow4_V1_1804,pow4_V1_1203,pow4_V1_1005b,pow4_V1_1005b,pow4_V1_2011);

time3=cat(2,time3_1804,time3_1203+1,time3_1005b,time3_1005b,time3_2011);
time4=cat(2,time4_1804,time4_1203+1,time4_1005b,time4_1005b,time4_2011);

der3=cat(2,der3_1804,der3_1203,der3_1005b,der3_1005b,der3_2011);
der4=cat(2,der4_1804,der4_1203,der4_1005b,der4_1005b,der4_2011);


figure;
errorbar(x1,mean(pow4_V1,2),std(pow4_V1,0,2)/sqrt(size(pow4_V1,2)))
hold on
errorbar(x1,mean(pow3_V1,2),std(pow3_V1,0,2)/sqrt(size(pow3_V1,2)),'r')

figure;
errorbar(x2(2:113),mean(time4(2:113,:),2),std(time4(2:113,:),0,2)/sqrt(size(time4(2:113,:),2)))
hold on
errorbar(x2(2:113),mean(time3(2:113,:),2),std(time3(2:113,:),0,2)/sqrt(size(time3(2:113,:),2)),'r')


figure;
errorbar(x3,mean(der4,2),std(der4,0,2)/sqrt(size(der4,2)))
hold on
errorbar(x3,mean(der3,2),std(der3,0,2)/sqrt(size(der3,2)),'r')


