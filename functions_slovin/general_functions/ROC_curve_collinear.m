


for i=1:112
    scores=[squeeze(mean(coher_nocolin(4:9,i,:),1));squeeze(mean(coher_colin(4:9,i,:),1))]';
    labels=zeros(1,size(scores,2));
    labels(size(coher_nocolin,3):end)=1;
    [X,Y,THRE,AUC_coh(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

x1=(20:10:1130)-200; %for collinear
figure;plot(x1,AUC_coh)


for i=1:112
    scores=[squeeze(mean(power_nocolin(4:9,i,:),1));squeeze(mean(power_colin(4:9,i,:),1))]';
    labels=zeros(1,size(scores,2));
    labels(size(coher_nocolin,3):end)=1;
    [X,Y,THRE,AUC_pow(i),OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
end

x1=(20:10:1130)-200; %for collinear
figure;plot(x1,AUC_pow)








