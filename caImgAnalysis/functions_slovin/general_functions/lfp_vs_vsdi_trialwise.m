cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/lfp/frodo
load 2804a_spect_trials_corrected

cd /fat/Ariel/matlab_analysis/vsdi/frodo/28_04_2010/a/trials

freq=32;
time=112;
tr=[15];
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
for i=[4]
    k=k+1;
    cd ..
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['vt=squeeze(mean(cond',int2str(i),'n_dt_bl(roi,:,1:tr(k)),1))-1;'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
    % calculate smoothed time
    cd trials
    vt_s=zeros(241,tr(k));
    for t=2:241
        vt_s(t,:)=mean(vt(t:t+15,:).*repmat(hamming(16),1,tr(k)),1);
    end 
    eval(['vt_s_cond',int2str(i),'=vt_s;'])
    eval(['load power_cond',int2str(i)])
    eval(['cc_cond',int2str(i),'=zeros(32,64,tr(k));'])
    eval(['cct_cond',int2str(i),'=zeros(64,tr(k));'])
    eval(['cov_cond',int2str(i),'=zeros(32,64,tr(k),51);'])
    eval(['covt_cond',int2str(i),'=zeros(64,tr(k),51);'])
    for j=1:tr(k) %trial count
        disp(j)
        eval(['v_tr=power_cond',int2str(i),'(:,:,j);'])
        eval(['l_tr=spect_cond',int2str(i),'(:,:,j);'])        
        
        % calulate and plot lfp high and low gamma
        eval(['hg_cond',int2str(i),'(:,j)=squeeze(mean(l_tr(31:end,:),1));'])
        eval(['hg_cond',int2str(i),'(:,j)=hg_cond',int2str(i),'(:,j)./max(hg_cond',int2str(i),'(93:155,j));'])
        eval(['lg_cond',int2str(i),'(:,j)=squeeze(mean(l_tr(13:25,:),1));'])
        eval(['lg_cond',int2str(i),'(:,j)=lg_cond',int2str(i),'(:,j)./max(lg_cond',int2str(i),'(93:155,j));'])
        figure(i*100+j);
        eval(['plot(x2,lg_cond',int2str(i),'(:,j))'])
        hold on
        eval(['plot(x2,hg_cond',int2str(i),'(:,j),''r'')'])
        
        % calulate and plot vsdi alpha
        eval(['al_cond',int2str(i),'(:,j)=squeeze(mean(v_tr(4:9,:),1));'])
        eval(['al_cond',int2str(i),'(:,j)=al_cond',int2str(i),'(:,j)./max(al_cond',int2str(i),'(13:38,j));'])
        figure(i*100+j);
        eval(['plot(x1,al_cond',int2str(i),'(:,j),''LineStyle'',''--'')'])
        % plot smoothed time 
        
        t=vt_s(:,j);
        t=t/max(t(1:50));
        figure(i*100+j);plot(x1,t(1:112),'r','LineStyle','--')
        xlim([-100 300])
        
        % calculate correlations between lfp and vsdi
        l_ds = resample(l_tr',4,10)';
        % calculate for stimulus -50 to 200 ms - 38:63 for LFP and 13:38 for vsdi
        % -10 to 800 ms - 33:123 for LFP and 8:98 for vsdi
        for ii=1:32
            for jj=1:64
                c=corrcoef(l_ds(jj,38:63),v_tr(ii,13:38));
                eval(['cc_cond',int2str(i),'(ii,jj,j)=c(1,2);'])
            end
        end
        for jj=1:64
            ct=corrcoef(l_ds(jj,38:63),vt_s(13:38,j));
            eval(['cct_cond',int2str(i),'(jj,j)=ct(1,2);'])
        end
        % calculate cross covariance for lfp and vsdi
        for ii=1:32
            for jj=1:64
                d=xcov(l_ds(jj,38:63),v_tr(ii,13:38),'coeff');
                eval(['cov_cond',int2str(i),'(ii,jj,j,:)=d;'])
            end
        end
        for jj=1:64
            dt=xcov(l_ds(jj,38:63),vt_s(13:38,j),'coeff');
            eval(['covt_cond',int2str(i),'(jj,j,:)=dt;'])
        end
    end
end
        
%% plots

figure
imagesc(f2,f1,mean(cc_cond2,3),[-1 1]);colormap(mapgeog)
ylim([5 50])
xlim([5 125])

        
figure
imagesc(f2,f1,mean(cc_cond3,3),[-1 1]);colormap(mapgeog)
ylim([5 50])
xlim([5 125])

figure
imagesc(f2,f1,mean(cc_cond4,3),[-1 1]);colormap(mapgeog)
ylim([5 50])
xlim([5 125])

vt_s_cond2m=vt_s_cond2./repmat(max(vt_s_cond2(13:38,:),[],1),241,1);        
vt_s_cond3m=vt_s_cond3./repmat(max(vt_s_cond3(13:38,:),[],1),241,1);                        
vt_s_cond4m=vt_s_cond4./repmat(max(vt_s_cond4(13:38,:),[],1),241,1);        


figure;
plot(x2,mean(lg_cond4,2)) 
hold on
plot(x2,mean(hg_cond4,2),'r')        
plot(x1,mean(al_cond4,2),'LineStyle','--')        
plot(x1,mean(vt_s_cond4m(1:112,:),2),'r','LineStyle','--') 
xlim([-100 300])



lg_4 = resample(mean(lg_cond4,2),4,10)';
hg_4 = resample(mean(hg_cond4,2),4,10)';

corrcoef(mean(al_cond4(13:38,:),2),lg_4(38:63))
corrcoef(mean(al_cond4(13:38,:),2),hg_4(38:63))
corrcoef(mean(vt_s_cond4m(13:38,:),2),hg_4(38:63))
corrcoef(mean(vt_s_cond4m(13:38,:),2),lg_4(38:63))


for g=1:13
    figure
    imagesc(f2,f1,cc_cond4(:,:,g),[-1 1]);colormap(mapgeog)
    ylim([5 50])
    xlim([5 125])
end

% calculating band correlations
m(1,1)=mean(mean(mean(cc_cond4(4:9,13:25,:))));
m(2,1)=mean(mean(mean(cc_cond3(4:9,13:25,:))));
m(1,2)=mean(mean(mean(cc_cond4(10:15,13:25,:))));
m(2,2)=mean(mean(mean(cc_cond3(10:15,13:25,:))));
m(1,3)=mean(mean(mean(cc_cond4(16:32,13:25,:))));
m(2,3)=mean(mean(mean(cc_cond3(16:32,13:25,:))));
m(1,4)=mean(mean(cct_cond4(13:25,:)));
m(2,4)=mean(mean(cct_cond3(13:25,:)));

m(1,5)=mean(mean(mean(cc_cond4(4:9,31:end,:))));
m(2,5)=mean(mean(mean(cc_cond3(4:9,31:end,:))));
m(1,6)=mean(mean(mean(cc_cond4(10:15,31:end,:))));
m(2,6)=mean(mean(mean(cc_cond3(10:15,31:end,:))));
m(1,7)=mean(mean(mean(cc_cond4(16:32,31:end,:))));
m(2,7)=mean(mean(mean(cc_cond3(16:32,31:end,:))));
m(1,8)=mean(mean(cct_cond4(31:end,:,:)));
m(2,8)=mean(mean(cct_cond3(31:end,:,:)));

s(1,1)=std(mean(mean(cc_cond4(4:9,13:25,:),1),2),0,3);
s(2,1)=std(mean(mean(cc_cond3(4:9,13:25,:),1),2),0,3);
s(1,2)=std(mean(mean(cc_cond4(10:15,13:25,:),1),2),0,3);
s(2,2)=std(mean(mean(cc_cond3(10:15,13:25,:),1),2),0,3);
s(1,3)=std(mean(mean(cc_cond4(16:32,13:25,:),1),2),0,3);
s(2,3)=std(mean(mean(cc_cond3(16:32,13:25,:),1),2),0,3);
s(1,4)=std(mean(cct_cond4(13:25,:),1),0,2);
s(2,4)=std(mean(cct_cond3(13:25,:),1),0,2);

s(1,5)=std(mean(mean(cc_cond4(4:9,31:end,:),1),2),0,3);
s(2,5)=std(mean(mean(cc_cond3(4:9,31:end,:),1),2),0,3);
s(1,6)=std(mean(mean(cc_cond4(10:15,31:end,:),1),2),0,3);
s(2,6)=std(mean(mean(cc_cond3(10:15,31:end,:),1),2),0,3);
s(1,7)=std(mean(mean(cc_cond4(16:32,31:end,:),1),2),0,3);
s(2,7)=std(mean(mean(cc_cond3(16:32,31:end,:),1),2),0,3);
s(1,8)=std(mean(cct_cond4(31:end,:),1),0,2);
s(2,8)=std(mean(cct_cond3(31:end,:),1),0,2);


figure;bar(m')


figure;bar(m(1,:)')
hold on
errorbar(m(1,:)',s(1,:)'/sqrt(size(cc_cond4,3)));

figure;bar(m(2,:)')
hold on
errorbar(m(2,:)',s(2,:)'/sqrt(size(cc_cond3,3)));


ranksum(squeeze(mean(mean(cc_cond4(4:9,13:25,:),1),2)),squeeze(mean(mean(cc_cond3(4:9,13:25,:),1),2)))
ranksum(squeeze(mean(mean(cc_cond4(10:15,13:25,:),1),2)),squeeze(mean(mean(cc_cond3(10:15,13:25,:),1),2)))
ranksum(squeeze(mean(mean(cc_cond4(16:32,13:25,:),1),2)),squeeze(mean(mean(cc_cond3(16:32,13:25,:),1),2)))
ranksum(squeeze(mean(mean(cc_cond4(4:9,31:end,:),1),2)),squeeze(mean(mean(cc_cond3(4:9,31:end,:),1),2)))
ranksum(squeeze(mean(mean(cc_cond4(10:15,31:end,:),1),2)),squeeze(mean(mean(cc_cond3(10:15,31:end,:),1),2)))
ranksum(squeeze(mean(mean(cc_cond4(16:32,31:end,:),1),2)),squeeze(mean(mean(cc_cond3(16:32,31:end,:),1),2)))

ranksum(squeeze(mean(cct_cond4(13:25,:),1)),squeeze(mean(cct_cond3(13:25,:),1)))
ranksum(squeeze(mean(cct_cond4(31:end,:),1)),squeeze(mean(cct_cond3(31:end,:),1)))

signtest(squeeze(mean(mean(cc_cond4(4:9,13:25,:),1),2)))
signtest(squeeze(mean(mean(cc_cond4(10:15,13:25,:),1),2)))
signtest(squeeze(mean(mean(cc_cond4(16:32,13:25,:),1),2)))
signtest(squeeze(mean(mean(cc_cond4(4:9,31:end,:),1),2)))
signtest(squeeze(mean(mean(cc_cond4(10:15,31:end,:),1),2)))
signtest(squeeze(mean(mean(cc_cond4(16:32,31:end,:),1),2)))
signtest(squeeze(mean(cct_cond4(13:25,:),1)))
signtest(squeeze(mean(cct_cond4(31:end,:),1)))

signtest(squeeze(mean(mean(cc_cond3(4:9,13:25,:),1),2)))
signtest(squeeze(mean(mean(cc_cond3(10:15,13:25,:),1),2)))
signtest(squeeze(mean(mean(cc_cond3(16:32,13:25,:),1),2)))
signtest(squeeze(mean(mean(cc_cond3(4:9,31:end,:),1),2)))
signtest(squeeze(mean(mean(cc_cond3(10:15,31:end,:),1),2)))
signtest(squeeze(mean(mean(cc_cond3(16:32,31:end,:),1),2)))
signtest(squeeze(mean(cct_cond3(13:25,:),1)))
signtest(squeeze(mean(cct_cond3(31:end,:),1)))


figure
bar(f2,[mean(cct_cond4,2) mean(cct_cond3,2)])';
xlim([5 125])
ylim([-1 1])

figure
bar(f2,mean(cct_cond4,2));
xlim([5 125])
ylim([-1 1])
hold on
errorbar(f2,mean(cct_cond4,2),std(cct_cond4,0,2)/sqrt(size(cct_cond4,2)))


figure
bar(f2,mean(cct_cond3,2));
xlim([5 125])
ylim([-1 1])
hold on
errorbar(f2,mean(cct_cond3,2),std(cct_cond3,0,2)/sqrt(size(cct_cond3,2)))



x7=-250:10:250;
x7=-900:10:900;
figure;
plot(x7,squeeze(mean(mean(mean(cov_cond4(4:9,13:25,:,:),1),2),3)))

figure;
plot(x7,squeeze(mean(mean(mean(cov_cond3(4:9,13:25,:,:),1),2),3)))

figure;
plot(x7,squeeze(mean(mean(mean(cov_cond2(4:9,13:25,:,:),1),2),3)))


x7=-900:10:900;
figure;
plot(x7,squeeze(mean(mean(covt_cond4(13:25,:,:),1),2)))
figure;
plot(x7,squeeze(mean(mean(covt_cond3(13:25,:,:),1),2)))



for j=1:13
    figure;
    plot(x2,lg_cond3(:,j))
    xlim([-100 800])
    figure;
    plot(x1,al_cond31(:,j),'LineStyle','--')
    xlim([-100 800])
    figure;
    plot(x1,al_cond32(:,j),'LineStyle','--')
    xlim([-100 800])
    figure;
    plot(x1,al_cond33(:,j),'LineStyle','--')
    xlim([-100 800])
end





for j=10:-1:1
    figure;
    plot(x1,squeeze(mean(power_cond3(4:9,:,j),1)))
    title(['trial vsdi ',int2str(j)])
    xlim([-100 800])
    figure;
    plot(x2,squeeze(mean(spect_cond3(13:25,:,j),1)),'LineStyle','--')
    xlim([-100 800]) 
    title(['trial lfp ',int2str(j)])
end





        