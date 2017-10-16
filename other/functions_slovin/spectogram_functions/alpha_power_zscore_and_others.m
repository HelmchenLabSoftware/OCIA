


pow3_V1=squeeze(mean(mean(b(20:30,roi_V1,:),1),2));
pow4_V1=squeeze(mean(mean(a(20:30,roi_V1,:),1),2));

pow3_z=(pow3_V1-mean(pow3_V1))/std(pow3_V1);
pow4_z=(pow4_V1-mean(pow3_V1))/std(pow3_V1);


lim=[-20:0.3:30];

[n,x1]=hist(pow3_z,lim);
[c,x2]=hist(pow4_z,lim);

figure;
bar(lim,[n;c]')







%%

pow3_V1=cat(1,pow3_z_1804,pow3_z_1203,pow3_z_1005b,pow3_z_1005e,pow3_z_2011);
pow4_V1=cat(1,pow3_z_1804,pow3_z_1203,pow4_z_1005b,pow4_z_1005e,pow4_z_2011);

lim=[-20:0.5:30];

[n,x1]=hist(pow3_V1,lim);
[c,x2]=hist(pow4_V1,lim);

figure;
bar(lim,[n;c]')





%%

scores=[pow3_V1;pow4_V1]';
labels=zeros(1,size(scores,2));
labels(size(pow3_V1,1):end)=1;
[X,Y,THRE,AUC,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)



%% ROC curve for trial
clear pfa phit
ind=find(c, 1, 'first');
ind2=find(n, 1, 'first');
s=min(ind,ind2);

ind=find(c, 1, 'last');
ind2=find(n, 1, 'last');
e=max(ind,ind2)+1;

lim=lim(s:e);
n=n(s:e);
c=c(s:e);

for i=1:size(lim,2)
    pfa(i)=sum(n(i:end))/size(pow3_V1,1);
    phit(i)=sum(c(i:end))/size(pow4_V1,1);    
end    


figure;plot(pfa,phit)



%%


pow3_z_1804=(pow3_V1_1804-mean(pow3_V1_1804))/std(pow3_V1_1804);
pow4_z_1804=(pow4_V1_1804-mean(pow3_V1_1804))/std(pow3_V1_1804);

pow3_z_1203=(pow3_V1_1203-mean(pow3_V1_1203))/std(pow3_V1_1203);
pow4_z_1203=(pow4_V1_1203-mean(pow3_V1_1203))/std(pow3_V1_1203);

pow3_z_1005b=(pow3_V1_1005b-mean(pow3_V1_1005b))/std(pow3_V1_1005b);
pow4_z_1005b=(pow4_V1_1005b-mean(pow3_V1_1005b))/std(pow3_V1_1005b);

pow3_z_1005e=(pow3_V1_1005e-mean(pow3_V1_1005e))/std(pow3_V1_1005e);
pow4_z_1005e=(pow4_V1_1005e-mean(pow3_V1_1005e))/std(pow3_V1_1005e);

pow3_z_2011=(pow3_V1_2011-mean(pow3_V1_2011))/std(pow3_V1_2011);
pow4_z_2011=(pow4_V1_2011-mean(pow3_V1_2011))/std(pow3_V1_2011);




%%

scores=[pow3_V1_1804;pow4_V1_1804]';
labels=zeros(1,size(scores,2));
labels(size(pow3_V1_1804,1):end)=1;
[X,Y,THRE,AUC_1804,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


scores=[pow3_V1_1203;pow4_V1_1203]';
labels=zeros(1,size(scores,2));
labels(size(pow3_V1_1203,1):end)=1;
[X,Y,THRE,AUC_1203,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


scores=[pow3_V1_1005b;pow4_V1_1005b]';
labels=zeros(1,size(scores,2));
labels(size(pow3_V1_1005b,1):end)=1;
[X,Y,THRE,AUC_1005b,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)

scores=[pow3_V1_1005e;pow4_V1_1005e]';
labels=zeros(1,size(scores,2));
labels(size(pow3_V1_1005e,1):end)=1;
[X,Y,THRE,AUC_1005e,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)


scores=[pow3_V1_2011;pow4_V1_2011]';
labels=zeros(1,size(scores,2));
labels(size(pow3_V1_2011,1):end)=1;
[X,Y,THRE,AUC_2011,OPTROCPT,SUBY,SUBYNAMES] = perfcurve(labels,scores,1);
figure;plot(X,Y)




