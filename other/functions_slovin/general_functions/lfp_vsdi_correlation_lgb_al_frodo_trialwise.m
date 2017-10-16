x2=(1:459)*4-(420); %for faces and contour integration and frodo
%x2=(1:459)*4-(420+25); %for collinear
f2=(1:64)*125/64;


lg=squeeze(mean(spect_cond4(13:25,:,:),1));
lg=lg./repmat(max(lg(1:170,:)),459,1);
figure;plot(x2,lg)

%downsample lfp time
x3 = resample(x2,4,10);
%downsample lfp frequency
lg_ds = resample(lg,4,10);
figure;plot(x3,lg_ds)


%% vsdi plot

f1=(1:32)*50/32;
x1=(20:10:1130)-190; %for faces and frodo

%alpha power

al=squeeze(mean(power_cond4(4:9,:,:),1));
al=al./repmat(max(al(25:50,:)),112,1);
figure;plot(x1,al)
xlim([-100 300])
ylim([-0.2 1.2])


%% correlations


for i=1:14
    c=corrcoef(lg_ds(38:63,i),al(13:38,i));
    corr(i)=c(1,2);
end    
    
    
 mean(corr)   
 std(corr)/sqrt(size(corr,1))  
 signrank(corr)   
    
    
    
    
    
    
    
    
