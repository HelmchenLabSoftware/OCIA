cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/lfp/frodo
load 1205f3clean_spect_trials_corrected

cd /fat/Ariel/matlab_analysis/vsdi/frodo/12_05_2010/f/trials

win=25;
freq=32;
time=112;
tr=size(spect_cond3,3);
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
    eval(['covt_cond',int2str(i),'=zeros(64,tr(k),win*2+1);'])
    for j=1:tr(k) %trial count
        disp(j)
        eval(['l_tr=spect_cond',int2str(i),'(:,:,j);'])        
        
        l_ds = resample(l_tr',4,10)';
        % calculate cross covariance for lfp and vsdi
        for jj=1:64
            lt=26;
            for vt=2:110-win
                lt=lt+1;
                dt(:,vt)=xcov(l_ds(jj,lt:lt+win),vt_s(vt:vt+win,j),'coeff');
            end    
            eval(['covt_cond',int2str(i),'(jj,j,:)=mean(dt(:,2:end),2);'])
        end
    end
end

lband=31:64;
x7=-win*10:10:win*10;
figure;
errorbar(x7,squeeze(mean(mean(covt_cond3(lband,:,:),1),2)),std(mean(covt_cond3(lband,:,:),1),0,2)/sqrt(size(covt_cond3,2)),'LineWidth',2)
ylim([-0.1 0.1])
xlim([-300 300])

%%


x7=-win*10:10:win*10;
figure;
plot(x7,squeeze(mean(mean(covt_cond3a(lband,:,:),1),2)),'LineWidth',2)
ylim([-0.1 0.1])
xlim([-300 300])
hold on
plot(x7,squeeze(mean(mean(covt_cond3b(lband,:,:),1),2)),'r','LineWidth',2)
plot(x7,squeeze(mean(mean(covt_cond3aa(lband,:,:),1),2)),'g','LineWidth',2)
plot(x7,squeeze(mean(mean(covt_cond3c(lband,:,:),1),2)),'c','LineWidth',2)
plot(x7,squeeze(mean(mean(covt_cond3d(lband,:,:),1),2)),'m','LineWidth',2)
plot(x7,squeeze(mean(mean(covt_cond3e(lband,:,:),1),2)),'k','LineWidth',2)
plot(x7,squeeze(mean(mean(covt_cond3f(lband,:,:),1),2)),'y','LineWidth',2)





