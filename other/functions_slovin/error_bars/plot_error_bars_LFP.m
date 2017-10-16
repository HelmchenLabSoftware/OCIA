%% calculate error bars
cd /fat2/Ariel_Gilad/Matlab_analysis/lfp/leg_2008_03_06/leg_2008_03_06_e/spect_trials
color=['b';'r';'g';'c';'m';'y'];
for i=[1 4] %condition set
    eval(['load spect_trials_cond',int2str(i)])
    for j=1:6 %band count
        ste=nanstd(mean(spect_trial(1+5*(j-1):5+5*(j-1),:,:),1),0,3)./sqrt(size(spect_trial,3));
        subplot(3,3,j)
        errorbar(nanmean(mean(spect_trial(1+5*(j-1):5+5*(j-1),:,:),1),3),ste,color(i));axis([0,size(spect_trial,2),-12,10])
        hold on;
    end;
    for j=7:9 %band count
        ste=nanstd(mean(spect_trial(1+5*(j-1):10+5*(j-1),:,:),1),0,3)./sqrt(size(spect_trial,3));
        subplot(3,3,j)
        errorbar(nanmean(mean(spect_trial(1+5*(j-1):10+5*(j-1),:,:),1),3),ste,color(i));axis([0,size(spect_trial,2),-12,10])
        hold on;
    end;
end;
subplot(3,3,1);title('frequency 2-10 Hz');
subplot(3,3,2);title('frequency 12-20 Hz');
subplot(3,3,3);title('frequency 22-30 Hz');
subplot(3,3,4);title('frequency 32-40 Hz');
subplot(3,3,5);title('frequency 42-50 Hz');
subplot(3,3,6);title('frequency 52-60 Hz');
subplot(3,3,7);title('frequency 62-80 Hz');
subplot(3,3,8);title('frequency 82-100 Hz');
subplot(3,3,9);title('frequency 102-120 Hz');
%legend('co-linear','non co-linear');
%legend('target','flankers');
legend('cond1','cond2','cond3','cond4','cond5','cond6');




%%
figure
for i=1:6 %condition set
    eval(['load spect_trials_cond',int2str(i)])
    for j=1:6 %band count
        subplot(3,3,j)
        plot(filtx(nanmean(mean(spect_trial(1+5*(j-1):5+5*(j-1),:,:),1),3),5,'lm'),color(i));axis([0,size(spect_trial,2),-12,10])
        hold on;
    end;
    for j=7:9 %band count
        subplot(3,3,j)
       plot(filtx(nanmean(mean(spect_trial(1+5*(j-1):10+5*(j-1),:,:),1),3),5,'lm'),color(i));axis([0,size(spect_trial,2),-12,10])
        hold on;
    end;
end;
xlim([75 500])
legend('cond1','cond2','cond3','cond4','cond5','cond6');

shg
