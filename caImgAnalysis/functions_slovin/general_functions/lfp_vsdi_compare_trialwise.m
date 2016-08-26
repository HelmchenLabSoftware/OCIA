

x4=(1:256)*10-280;
x3=(1:626)*4-500;
x2 = resample(x3,4,10);



for i=1:size(lfp_cond3,2)
   figure;plot(x3,lfp_cond3(:,i),'r');xlim([-200 900])
   figure;plot(x4,vsdi_cond3(:,i));xlim([-200 900])
end

l_ds = resample(lfp_cond3,4,10);
for i=1:size(lfp_cond3,2)
   c=corrcoef(vsdi_cond3(2:98,i),l_ds(24:120,i));
   cc(i)=c(1,2);
end

mean(cc)
std(cc)
[h p]=ttest(cc)
