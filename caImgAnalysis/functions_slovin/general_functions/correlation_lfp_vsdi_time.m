%% calculate correlations for each session between LFP and time course

vt=2;   %number of vsdi trials
lt=2;  %number of lfp trials
w=0;
cct_b=zeros(64,vt,lt);
cct=zeros(64,vt,lt);
for k=1:vt
    for m=1:lt
        w=w+1;
        v=squeeze(time_course(:,k));
        l=spect_cond4(:,:,m);      
        l_ds = resample(l',4,10)';
        % calculate for stimulus -50 to 200 ms - 38:63 for LFP and 13:38 for vsdi
        for j=1:64
            ct=corrcoef(l_ds(j,38:63),v(13:38));
            cct(j,k,m)=ct(1,2);
        end
         for j=1:64
            ct=corrcoef(l_ds(j,28:36),v(3:11));
            cct_b(j,k,m)=ct(1,2);
         end
    end
end



figure
bar(f2,mean(mean(cct,2),3))';
xlim([5 125])
ylim([-1 1])

figure
bar(f2,mean(mean(cct_b,2),3))';
xlim([5 125])
ylim([-1 1])


figure
bar(f2,[mean(mean(cct,2),3) mean(mean(cct_b,2),3)])';
xlim([5 125])
ylim([-1 1])














