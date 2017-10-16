clear all
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/lfp/frodo
load 2804ab_spect_trials_corrected

cd /fat/Ariel/matlab_analysis/vsdi/frodo/b/trials/unite

freq=32;
time=112;
tr=[43];
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


vband=4:9;
lband=8:12;



k=0;
for i=3
    k=k+1;
    eval(['load power_cond',int2str(i)])
    eval(['cov_cond',int2str(i),'=zeros(tr(k),51);'])
    for j=1:tr(k) %trial count
        disp(j)
        eval(['v_tr=power_cond',int2str(i),'(:,:,j);'])
        eval(['l_tr=spect_cond',int2str(i),'(:,:,j);'])             
        % calculate correlations between lfp and vsdi
        l_ds = resample(l_tr',4,10)';
        % calculate for stimulus -50 to 200 ms - 38:63 for LFP and 13:38 for vsdi
        % -10 to 800 ms - 33:123 for LFP and 8:98 for vsdi
        % calculate cross covariance for lfp and vsdi
                lt=27;
                y=0;
                for vt=2:25:42-25
                    y=y+1;
                    d(:,y)=xcov(mean(l_ds(lband,lt:lt+25),1),mean(v_tr(vband,vt:vt+25),1),'coeff');
                    lt=lt+25;
                end
                eval(['cov_cond',int2str(i),'(j,:)=mean(d(:,2:end),2);'])
    end
end

x7=-250:10:250;
% x7=-900:10:900;
% x7=-400:10:400;
% x7=-500:10:500;
% x7=-600:10:600;

figure;
errorbar(x7,mean(cov_cond3,1),std(cov_cond3,0,1)/sqrt(size(cov_cond3,1)))
%ylim([-0.02 0.02])

figure;
plot(cov_cond3')

signrank(mean(cov_cond3(:,26),2))
