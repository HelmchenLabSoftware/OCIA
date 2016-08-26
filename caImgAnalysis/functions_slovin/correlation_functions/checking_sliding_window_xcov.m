
a=mean(cond1n_dt_bl(roi_contour2(100),28:42,:),3);
b=mean(cond1n_dt_bl(roi_contour2(600),28:42,:),3);
time=28:42;
win=6;
k=size(time,2)-win;
v=nan*ones(k*2-1,k);
for ii=1:k
    for jj=1:k
        temp=corrcoef(a(ii:ii+win),b(jj:jj+win));
        v(k+jj-ii,ii)=temp(1,2);
    end
end

figure;plot(-140:10:140,xcov(a,b,'coeff'))
hold on
plot(-80:10:80,nanmean(v,2))

