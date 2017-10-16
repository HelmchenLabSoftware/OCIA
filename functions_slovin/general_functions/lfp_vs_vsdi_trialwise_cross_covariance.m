cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/lfp/frodo
load 2804a_spect_trials_corrected

cd /fat/Ariel/matlab_analysis/vsdi/frodo/a/trials

freq=32;
time=112;
tr=[30];
load roi
% lfp plot
x2=(1:459)*4-(420); %for faces and contour integration
%x2=(1:459)*4-(420+25); %for collinear
x3 = resample(x2,4,10);
f2=(1:64)*125/64;
% vsdi plot
%x1=(20:10:1130)-200; %for collinear
f1=(1:32)*50/32;
%x1=(20:10:2010)-190; %for contour integration
x1=(20:10:1130)-190; %for faces 

k=0;
for i=3
    k=k+1;
    eval(['covsh_cond',int2str(i),'=zeros(32,64,tr(k),51,100);'])
    eval(['covtsh_cond',int2str(i),'=zeros(64,tr(k),51,100);'])
    
    eval(['load cond',int2str(i),'n_dt_bl'])
    for it=1:100
        disp(it)
        p = randperm(tr(k));
        while any(p==(1:tr(k))) 
            p = randperm(tr(k));
        end
        eval(['vt=squeeze(mean(cond',int2str(i),'n_dt_bl(roi,:,p),1))-1;'])
        
        % calculate smoothed time
        
        vt_s=zeros(241,tr(k));
        for t=2:241
            vt_s(t,:)=mean(vt(t:t+15,:).*repmat(hamming(16),1,tr(k)),1);
        end 
        eval(['vt_s_cond',int2str(i),'=vt_s;'])
        eval(['load power_cond',int2str(i)])
        eval(['power_cond',int2str(i),'=power_cond',int2str(i),'(:,:,p);'])
        for j=1:tr(k) %iteration count
            eval(['v_tr=power_cond',int2str(i),'(:,:,j);'])
            eval(['l_tr=spect_cond',int2str(i),'(:,:,j);'])        

            % calulate and plot lfp high and low gamma

            % calculate correlations between lfp and vsdi
            l_ds = resample(l_tr',4,10)';
            % calculate for stimulus -50 to 200 ms - 38:63 for LFP and 13:38 for vsdi
            % -10 to 800 ms - 33:123 for LFP and 8:98 for vsdi
            % calculate cross covariance for lfp and vsdi
            for ii=1:32
                for jj=1:64
                    d=xcov(l_ds(jj,38:63),v_tr(ii,13:38),'coeff');
                    eval(['covsh_cond',int2str(i),'(ii,jj,j,:,it)=d;'])
                end
            end
            for jj=1:64
                dt=xcov(l_ds(jj,38:63),vt_s(13:38,j),'coeff');
                eval(['covtsh_cond',int2str(i),'(jj,j,:,it)=dt;'])
            end
        end
    end
 end



%%





x7=-250:10:250;
%x7=-900:10:900;
figure;
plot(x7,squeeze(mean(mean(mean(covsh_cond4(4:9,13:25,:,:),1),2),3)))

figure;
plot(x7,squeeze(mean(mean(mean(covsh_cond3(4:9,13:25,:,:,:),1),2),3)))

figure;
plot(x7,squeeze(mean(mean(mean(covsh_cond2(4:9,13:25,:,:),1),2),3)))

figure;
plot(x7,squeeze(mean(mean(covtsh_cond4(13:25,:,:),1),2)))
figure;
plot(x7,squeeze(mean(mean(covtsh_cond3(13:25,:,:),1),2)))


figure;
plot(x7,squeeze(mean(mean(mean(cov_cond4(4:9,13:25,:,:),1),2),3))-squeeze(mean(mean(mean(covsh_cond4(4:9,13:25,:,:),1),2),3)))

figure;
plot(x7,squeeze(mean(mean(mean(cov_cond3(4:9,13:25,:,:),1),2),3))-squeeze(mean(mean(mean(covsh_cond3(4:9,13:25,:,:),1),2),3)))

figure;
plot(x7,squeeze(mean(mean(mean(cov_cond2(4:9,13:25,:,:),1),2),3))-squeeze(mean(mean(mean(covsh_cond2(4:9,13:25,:,:),1),2),3)))


figure;
plot(x7,squeeze(mean(mean(covt_cond4(13:25,:,:),1),2)))
figure;
plot(x7,squeeze(mean(mean(covt_cond3(13:25,:,:),1),2)))


figure;
errorbar(x7,squeeze(mean(mean(mean(cov_cond4(4:9,13:25,:,:),1),2),3)),squeeze(std(mean(mean(cov_cond4(4:9,13:25,:,:),1),2),0,3))/sqrt(13))
hold on
errorbar(x7,squeeze(mean(mean(mean(covsh_cond4(4:9,13:25,:,:),1),2),3)),squeeze(std(mean(mean(covsh_cond4(4:9,13:25,:,:),1),2),0,3))/sqrt(13),'r')

figure;
errorbar(x7,squeeze(mean(mean(mean(cov_cond3(4:9,13:25,:,:),1),2),3)),squeeze(std(mean(mean(cov_cond3(4:9,13:25,:,:),1),2),0,3))/sqrt(13))
hold on
errorbar(x7,squeeze(mean(mean(mean(covsh_cond3(4:9,13:25,:,:),1),2),3)),squeeze(std(mean(mean(covsh_cond3(4:9,13:25,:,:),1),2),0,3))/sqrt(13),'r')

ranksum(squeeze(mean(mean(cov_cond3(4:9,13:25,:,26),1),2)),squeeze(mean(mean(covsh_cond3(4:9,13:25,:,26),1),2)))
ranksum(squeeze(mean(mean(cov_cond3(4:9,31:end,:,26),1),2)),squeeze(mean(mean(covsh_cond3(4:9,31:end,:,26),1),2)))
ranksum(squeeze(mean(mean(cov_cond3(10:15,13:25,:,26),1),2)),squeeze(mean(mean(covsh_cond3(10:15,13:25,:,26),1),2)))
ranksum(squeeze(mean(mean(cov_cond3(10:15,31:end,:,26),1),2)),squeeze(mean(mean(covsh_cond3(10:15,31:end,:,26),1),2)))


for i=1:181
   [p(i) h(i)]=ranksum(squeeze(mean(mean(cov_cond3(4:9,13:25,:,i),1),2)),squeeze(mean(mean(covsh_cond3(4:9,13:25,:,i),1),2)));
end














figure;
errorbar(x7,squeeze(mean(mean(mean(cov_cond3(4:9,13:25,:,:),1),2),3)),squeeze(std(mean(mean(cov_cond3(4:9,13:25,:,:),1),2),0,3))/sqrt(13))
hold on
errorbar(x7,squeeze(mean(mean(mean(covsh_cond3(4:9,13:25,:,:),1),2),3)),squeeze(std(mean(mean(covsh_cond3(4:9,13:25,:,:),1),2),0,3))/sqrt(100)*5,'r')


figure;
errorbar(x7,squeeze(mean(mean(mean(cov_cond3(4:9,31:end,:,:),1),2),3)),squeeze(std(mean(mean(cov_cond3(4:9,31:end,:,:),1),2),0,3))/sqrt(13))
hold on
errorbar(x7,squeeze(mean(mean(mean(covsh_cond3(4:9,31:end,:,:),1),2),3)),squeeze(std(mean(mean(covsh_cond3(4:9,31:end,:,:),1),2),0,3))/sqrt(100)*5,'r')


figure;
errorbar(x7,squeeze(mean(mean(mean(cov_cond3(10:15,13:25,:,:),1),2),3)),squeeze(std(mean(mean(cov_cond3(10:15,13:25,:,:),1),2),0,3))/sqrt(13))
hold on
errorbar(x7,squeeze(mean(mean(mean(covsh_cond3(10:15,13:25,:,:),1),2),3)),squeeze(std(mean(mean(covsh_cond3(10:15,13:25,:,:),1),2),0,3))/sqrt(100)*5,'r')


figure;
errorbar(x7,squeeze(mean(mean(mean(cov_cond3(10:15,31:end,:,:),1),2),3)),squeeze(std(mean(mean(cov_cond3(10:15,31:end,:,:),1),2),0,3))/sqrt(13))
hold on
errorbar(x7,squeeze(mean(mean(mean(covsh_cond3(10:15,31:end,:,:),1),2),3)),squeeze(std(mean(mean(covsh_cond3(10:15,31:end,:,:),1),2),0,3))/sqrt(100)*5,'r')



figure;
errorbar(x7,squeeze(mean(mean(mean(cov_cond3(4:9,13:25,:,:),1),2),3)),squeeze(std(mean(mean(cov_cond3(4:9,13:25,:,:),1),2),0,3))/sqrt(30))
hold on
errorbar(x7,squeeze(mean(mean(mean(covsh_cond3(4:9,13:25,:,:),1),2),3)),squeeze(std(mean(mean(covsh_cond3(4:9,13:25,:,:),1),2),0,3))/sqrt(100)*5,'r')




%%

x7=-250:10:250;
vband=16:32;
lband=8:12;

tl=squeeze(max(mean(mean(mean(covsh_cond3(vband,lband,:,:,:),1),2),3),[],5));
bl=squeeze(min(mean(mean(mean(covsh_cond3(vband,lband,:,:,:),1),2),3),[],5));

figure;
errorbar(x7,squeeze(mean(mean(mean(cov_cond3(vband,lband,:,:),1),2),3)),squeeze(std(mean(mean(cov_cond3(vband,lband,:,:),1),2),0,3))/sqrt(size(cov_cond3,3)))
ylim([-0.2 0.2])
hold on
plot(x7,tl,'r')
plot(x7,bl,'r')


errorbar(x7,squeeze(mean(mean(mean(mean(covsh_cond3(vband,lband,:,:,:),1),2),3),5)),squeeze(mean(std(mean(mean(covsh_cond3(vband,lband,:,:,:),1),2),0,3),5))/sqrt(size(covsh_cond3,3)))

plot(x7,squeeze(mean(mean(mean(covsh_cond3(vband,lband,:,:,:),1),2),3)))


%time vsdi vs lfp band
tlt=squeeze(max(mean(mean(covtsh_cond3(lband,:,:,:),1),2),[],4));
blt=squeeze(min(mean(mean(covtsh_cond3(lband,:,:,:),1),2),[],4));

figure;
errorbar(x7,squeeze(mean(mean(covt_cond3(lband,:,:),1),2)),squeeze(std(mean(covt_cond3(lband,:,:),1),0,2))/sqrt(size(covt_cond3,2)))
hold on
plot(x7,tlt,'r')
plot(x7,blt,'r')


x7=-400:10:400;
x7=-250:10:250;

vband=4:9;
lband=13:25;
figure;
errorbar(x7,squeeze(mean(mean(mean(cov_cond3(vband,lband,:,:),1),2),3)),squeeze(std(mean(mean(cov_cond3(vband,lband,:,:),1),2),0,3))/sqrt(size(cov_cond3,3)))
ylim([-0.1 0.1])
signrank(squeeze(mean(mean(cov_cond3(vband,lband,:,26),1),2)))
xlim([-150 150])

figure;
plot(squeeze(mean(mean(cov_cond3(vband,lband,:,:),1),2))')

vband=10:15;
lband=13:25;
for i=1:51
    [p(i) h(i)]=signrank(squeeze(mean(mean(cov_cond3(vband,lband,:,i),1),2)));
    [h2(i) p2(i)]=ttest(squeeze(mean(mean(cov_cond3a(vband,lband,:,i),1),2)));
end
min(p)
sum(h)
x7(find(h==1))
x7(find(p<0.001))
%x7(find(h2==1))






vband=4:9;
lband=4:7;
figure;
errorbar(x7,squeeze(mean(mean(mean(cov_cond3(vband,lband,:,:),1),2),3)),squeeze(std(mean(mean(cov_cond3(vband,lband,:,:),1),2),0,3))/sqrt(size(cov_cond3,3)),'LineWidth',2)
ylim([-0.15 0.15])
hold on

lband=8:12;
errorbar(x7,squeeze(mean(mean(mean(cov_cond3(vband,lband,:,:),1),2),3)),squeeze(std(mean(mean(cov_cond3(vband,lband,:,:),1),2),0,3))/sqrt(size(cov_cond3,3)),'r','LineWidth',2)
ylim([-0.15 0.15])

lband=13:25;
errorbar(x7,squeeze(mean(mean(mean(cov_cond3(vband,lband,:,:),1),2),3)),squeeze(std(mean(mean(cov_cond3(vband,lband,:,:),1),2),0,3))/sqrt(size(cov_cond3,3)),'g','LineWidth',2)
ylim([-0.15 0.15])

lband=31:64;
errorbar(x7,squeeze(mean(mean(mean(cov_cond3(vband,lband,:,:),1),2),3)),squeeze(std(mean(mean(cov_cond3(vband,lband,:,:),1),2),0,3))/sqrt(size(cov_cond3,3)),'c','LineWidth',2)
ylim([-0.15 0.15])









for i=1:101
    [p(i) h(i)]=signrank(covt_cond3(:,i));
    [h2(i) p2(i)]=ttest(covt_cond3(:,i));
end
min(p)
sum(h)
x7(find(h==1))

lband=31:64;
for i=1:51
    [p(i) h(i)]=signrank(squeeze(mean(covt_cond3(lband,:,i),1)));
    [h2(i) p2(i)]=ttest(squeeze(mean(covt_cond3(lband,:,i),1)));
end
min(p)
sum(h)
x7(find(h==1))
x7(find(p==min(p)))



vband=16:32;
lband=8:12;
for i=1:51
    [p(i) h(i)]=signrank(squeeze(mean(mean(cov_cond3_mean(vband,lband,i,:),1),2)));
    [h2(i) p2(i)]=ttest(squeeze(mean(mean(cov_cond3_mean(vband,lband,i,:),1),2)));
end
min(p)
sum(h)
x7(find(h==1))
x7(find(p==min(p)))
%x7(find(h2==1))





for i=1:51
    [p(i) h(i)]=signrank(cov_cond3(:,i));
    [h2(i) p2(i)]=ttest(cov_cond3(:,i));
end
min(p)
sum(h)
x7(find(h==1))
x7(find(p<0.05))







