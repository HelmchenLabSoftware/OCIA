


trials=25;


a=zeros(10000,120,trials);
a(pixels,:,:)=coeff_tar_cond1;


figure;mimg(mfilt2(a(:,20:100,2),100,100,1,'lm'),100,100,-0.8,0.8);colormap(mapgeog);


time_cond1=[86 90;62 66;68 72;51 56;59 62;79 85;46 49;50 55;99 102;63 68;71 76;49 55;75 78;50 54;59 64;53 59;51 55;91 93;54 57;63 64;60 65;59 62;65 69;54 58;54 58;98 101;75 77];


for i=1:trials
    b=squeeze(mean(a(:,time_cond1(i,1):time_cond1(i,2),i),2));
    if i==1
        c=b;
    else
        c=c+b;
    end
end
c=c/i;