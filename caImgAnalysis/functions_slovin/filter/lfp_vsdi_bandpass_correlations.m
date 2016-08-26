% vsdi and lfp bandpass correlation







x1=(20:10:1940)-1200; % vsdi time

x2=(1:626)*4-(420+25); %lfp for collinear

figure;plot(x2,mean(lowgammaRMS_4,2))
hold on
plot(x2,mean(highgammaRMS_4,2),'r')
xlim([-100 400])

figure;plot(x1,mean(alpha_V1_colin,2))
hold on
plot(x1,mean(alpha_V1_nocolin,2),'r')
xlim([-100 400])


al=mean(alpha_V1_colin(:,[1 3 4 5]),2);
lg=mean(lowgammaRMS_4,2);
hg=mean(highgammaRMS_4,2);


alm=al./max(al(114:139));
figure;plot(x1(1:193),alm)
lgm=lg./max(lg(99:162));
hgm=hg./max(hg(99:162));
figure;plot(x2,lgm)
hold on
plot(x2,hgm,'r')


x3 = resample(x2,4,10);
lg_ds = resample(lg',4,10)';
hg_ds = resample(hg',4,10)';

corrcoef(lg_ds(30:65),al(104:139))
corrcoef(hg_ds(30:65),al(104:139))

















