% creatin a matrix of the average power of a specific roi for each trial
% note 1: create the power for each trial first
% (power_new_version_trialwise)
% note 2: choose the roi you want and save it as you want (line 27)
% note 3: choose if you want dB or not

freq=32;
time=112;
tr=[15];
load roi

k=0;
for i=4
    k=k+1;
    for j=1:tr(k)
        disp(['cond ',int2str(i),' trial ',int2str(j)])
        a=zeros(freq,time,10000);
        eval(['load power_cond',int2str(i),'_trial_',int2str(j)])
        eval(['a(:,:,pixels)=power_cond',int2str(i),'_trial_',int2str(j),'(:,1:time,:);'])
        a=shiftdim(a,2);
%         a=10*log10(a./repmat(mean(a(:,:,2:11),3),[1 1 112]));
%         a(isinf(a))=0;
%         a(isnan(a))=0;
        eval(['power_cond',int2str(i),'(:,:,j)=squeeze(mean(a(roi,:,:),1));'])
        eval(['clear power_cond',int2str(i),'_trial_',int2str(j)])
    end
    eval(['save power_clean_cond',int2str(i),' power_cond',int2str(i),' pixels roi'])
    eval(['clear power_cond',int2str(i)])    
end