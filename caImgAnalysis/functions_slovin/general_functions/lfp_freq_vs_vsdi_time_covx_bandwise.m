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

lband=31:64;

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
    eval(['covt_cond',int2str(i),'=zeros(tr(k),win*2+1);'])
    for j=1:tr(k) %trial count
        disp(j)
        eval(['l_tr=spect_cond',int2str(i),'(:,:,j);'])        
        l_ds = resample(l_tr',4,10)';
        % calculate cross covariance for lfp and vsdi
        lt=26;
        for vt=2:110-win
            lt=lt+1;
            dt(:,vt)=xcov(mean(l_ds(lband,lt:lt+win),1),vt_s(vt:vt+win,j),'coeff');
        end    
        eval(['covt_cond',int2str(i),'(j,:)=mean(dt(:,2:end),2);'])
    end
end

x7=-win*10:10:win*10;
figure;
errorbar(x7,squeeze(mean(covt_cond3,1)),std(covt_cond3,0,1)/sqrt(size(covt_cond3,1)),'LineWidth',2)
ylim([-0.1 0.1])
xlim([-300 300])


%%


x7=-win*10:10:win*10;
figure;
plot(x7,squeeze(mean(covt_cond3a,1)),'LineWidth',2)
ylim([-0.2 0.2])
xlim([-300 300])
hold on
plot(x7,squeeze(mean(covt_cond3b,1)),'r','LineWidth',2)
plot(x7,squeeze(mean(covt_cond3aa,1)),'g','LineWidth',2)
plot(x7,squeeze(mean(covt_cond3c,1)),'c','LineWidth',2)
plot(x7,squeeze(mean(covt_cond3d,1)),'m','LineWidth',2)
plot(x7,squeeze(mean(covt_cond3e,1)),'k','LineWidth',2)
plot(x7,squeeze(mean(covt_cond3f,1)),'y','LineWidth',2)








