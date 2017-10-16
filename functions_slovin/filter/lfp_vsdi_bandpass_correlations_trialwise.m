
clear all
%cd /fat/Ariel/matlab_analysis/vsdi/frodo
%load bandpass_alphaRMS_roi
%cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/lfp/frodo
%load bandpass_lowgammaRMS
load cheby_test

al=alpha_2804a_blank;
lg=lowgammaRMS_1_2804a;



freq=32;
time=112;
tr=size(lg,2);
% lfp plot

x2=(1:610)*4-(420); %lfp for collinear
x3 = resample(x2,4,10);
lg_ds=resample(lg,4,10);

% vsdi plot
%x1=(20:10:1130)-190; %for faces
x1=(20:10:1940)-1190; %for faces

win=25;

cov_cond3=zeros(tr,win*2+1);
    for j=1:tr %trial count
        disp(j)
        lt=46;
        for vt=122:173-win
            lt=lt+1;
            d(:,vt)=xcov(lg_ds(lt:lt+win,j),al(vt:vt+win,j),'coeff');
        end
        cov_cond3(j,:)=mean(d(:,2:end),2);
        %figure;plot(d)
    end



x7=-win*10:10:win*10;

figure;
errorbar(x7,mean(cov_cond3,1),std(cov_cond3,0,1)/sqrt(size(cov_cond3,1)))
ylim([-0.3 0.3])
xlim([-300 300])
figure;
plot(cov_cond3')

signrank(mean(cov_cond3(:,26),2))











