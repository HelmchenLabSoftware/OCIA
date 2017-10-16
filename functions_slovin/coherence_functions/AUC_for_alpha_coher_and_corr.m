%% AUC for alpha coherence
roi=roi_V2_target;

colin=squeeze(mean(a(roi,4:9,:),2))';
nocolin=squeeze(mean(b(roi,4:9,:),2))';

for i=1:112
    scores=[colin(i,:) nocolin(i,:)];
    labels=zeros(1,size(scores,2));
    labels(size(colin,2):end)=1;
    [X,Y,THRE,AUC_pow(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

x1=(20:10:1130)-200; %for collinear
figure;plot(x1,AUC_pow)



%% AUC for correlations
 
roi=roi_V2_target;

colin=squeeze(mean(a(roi,:,:),3))';
nocolin=squeeze(mean(b(roi,:,:),3))';

for i=1:112
    scores=[colin(i,:) nocolin(i,:)];
    labels=zeros(1,size(scores,2));
    labels(size(colin,2):end)=1;
    [X,Y,THRE,AUC_pow(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

x1=(1:112)*10-240; %for collinear
figure;plot(x1,AUC_pow)




%% AUC for derivatives
 
roi=roi_V1;

colin=squeeze(mean(der_cond4(roi,:,:),3))';
nocolin=squeeze(mean(der_cond3(roi,:,:),3))';

for i=1:112
    scores=[colin(i,:) nocolin(i,:)];
    labels=zeros(1,size(scores,2));
    labels(size(colin,2):end)=1;
    [X,Y,THRE,AUC_pow(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

x1=(1:112)*10-260; %for collinear
figure;plot(x1,AUC_pow)


