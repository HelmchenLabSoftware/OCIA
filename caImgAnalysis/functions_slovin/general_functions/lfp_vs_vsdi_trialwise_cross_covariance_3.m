clear all
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/lfp/frodo
load 1205d3clean_spect_trials_corrected  

cd /fat/Ariel/matlab_analysis/vsdi/frodo/12_05_2010/d/trials
freq=32;
time=112;
tr=size(spect_cond3,3);
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
lband=13:25;
win=25;


k=0;
for i=3
    k=k+1;
    eval(['load power_clean_cond',int2str(i)])
    eval(['cov_cond',int2str(i),'=zeros(tr(k),win*2+1);'])
    for j=1:tr(k) %trial count
        disp(j)
        eval(['v_tr=power_cond',int2str(i),'(:,:,j);'])
        eval(['l_tr=spect_cond',int2str(i),'(:,:,j);'])             
        % calculate correlations between lfp and vsdi
        l_ds = resample(l_tr',4,10)';
        % calculate for stimulus -50 to 200 ms - 38:63 for LFP and 13:38 for vsdi
        % -10 to 800 ms - 33:123 for LFP and 8:98 for vsdi
        % calculate cross covariance for lfp and vsdi
                lt=26;
                for vt=2:110-win
                    lt=lt+1;
                    d(:,vt)=xcov(mean(l_ds(lband,lt:lt+win),1),mean(v_tr(vband,vt:vt+win),1),'coeff');
                end
                eval(['cov_cond',int2str(i),'(j,:)=mean(d(:,2:end),2);'])
                %figure;plot(d)
    end
end


x7=-win*10:10:win*10;
% x7=-900:10:900;
% x7=-400:10:400;
% x7=-500:10:500;
% x7=-600:10:600;
% x7=-800:10:800;

figure;
errorbar(x7,mean(cov_cond3,1),std(cov_cond3,0,1)/sqrt(size(cov_cond3,1)))
ylim([-0.3 0.3])
xlim([-300 300])
figure;
plot(cov_cond3')

signrank(mean(cov_cond3(:,26),2))

