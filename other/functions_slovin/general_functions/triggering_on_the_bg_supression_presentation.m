%%








trig_bg_sup_cont=trig_bg_sup_1111c_cond1;
trig_bg_sup_cont=cat(2,trig_bg_sup_cont,trig_bg_sup_1111c_cond2);
trig_bg_sup_cont=cat(2,trig_bg_sup_cont,trig_bg_sup_1111d_cond1);
trig_bg_sup_cont=cat(2,trig_bg_sup_cont,trig_bg_sup_1111d_cond2);
trig_bg_sup_cont=cat(2,trig_bg_sup_cont,trig_bg_sup_1811c_cond1);
trig_bg_sup_cont=cat(2,trig_bg_sup_cont,trig_bg_sup_1811d_cond1);
trig_bg_sup_cont=cat(2,trig_bg_sup_cont,trig_bg_sup_1811e_cond1);
trig_bg_sup_cont=cat(2,trig_bg_sup_cont,trig_bg_sup_2511d_cond1);
trig_bg_sup_cont=cat(2,trig_bg_sup_cont,trig_bg_sup_2511e_cond1);
trig_bg_sup_cont=cat(2,trig_bg_sup_cont,trig_bg_sup_2511f_cond1);
trig_bg_sup_cont=cat(2,trig_bg_sup_cont,trig_bg_sup_1203d_cond1);
trig_bg_sup_cont=cat(2,trig_bg_sup_cont,trig_bg_sup_1203e_cond1);
trig_bg_sup_cont=cat(2,trig_bg_sup_cont,trig_bg_sup_1203f_cond1);


trig_bg_sup_non=trig_bg_sup_1111c_cond4;
trig_bg_sup_non=cat(2,trig_bg_sup_non,trig_bg_sup_1111c_cond5);
trig_bg_sup_non=cat(2,trig_bg_sup_non,trig_bg_sup_1111d_cond4);
trig_bg_sup_non=cat(2,trig_bg_sup_non,trig_bg_sup_1111d_cond5);
trig_bg_sup_non=cat(2,trig_bg_sup_non,trig_bg_sup_1811c_cond5);
trig_bg_sup_non=cat(2,trig_bg_sup_non,trig_bg_sup_1811d_cond5);
trig_bg_sup_non=cat(2,trig_bg_sup_non,trig_bg_sup_1811e_cond5);
trig_bg_sup_non=cat(2,trig_bg_sup_non,trig_bg_sup_2511d_cond5);
trig_bg_sup_non=cat(2,trig_bg_sup_non,trig_bg_sup_2511e_cond5);
trig_bg_sup_non=cat(2,trig_bg_sup_non,trig_bg_sup_2511f_cond5);
trig_bg_sup_non=cat(2,trig_bg_sup_non,trig_bg_sup_1203d_cond5);
trig_bg_sup_non=cat(2,trig_bg_sup_non,trig_bg_sup_1203e_cond5);
trig_bg_sup_non=cat(2,trig_bg_sup_non,trig_bg_sup_1203f_cond5);





x=-250:10:250;
figure;errorbar(x,mean(trig_bg_sup_cont,2),std(trig_bg_sup_cont,0,2)/sqrt(size(trig_bg_sup_cont,2)))
xlim([-100 200])
hold on
errorbar(x,mean(trig_bg_sup_non,2),std(trig_bg_sup_non,0,2)/sqrt(size(trig_bg_sup_non,2)),'r')
xlim([-100 200])

x=(-250:10:250)-20;
d1=trig_bg_sup_cont(4:51,:)-trig_bg_sup_cont(1:48,:);
d2=trig_bg_sup_non(4:51,:)-trig_bg_sup_non(1:48,:);

figure;errorbar(x(2:end-2),mean(d1,2),std(d1,0,2)/sqrt(size(d1,2)))
%xlim([20 100])
hold on
errorbar(x(2:end-2),mean(d2,2),std(d2,0,2)/sqrt(size(d2,2)),'r')
%xlim([20 100])

figure;errorbar(x(2:end-2),mean(d1-d2,2),std(d1-d2,0,2)/sqrt(size(d1,2)))
xlim([-100 200])

figure;plot(x(2:end-2),mean(d1,2)-mean(d2,2))

w1=mean(d1,2)-mean(d2,2);
w2=mean(d1,2)-mean(d2,2);

w1=d1-d2;
w2=d1-d2;


figure;plot(x(2:end-2),w1)
hold on
plot(x(2:end-2),w2,'r')

figure;errorbar(x(2:end-2),mean(w1,2),std(w1,0,2)/sqrt(13))
hold on
errorbar(x(2:end-2),mean(w2,2),std(w2,0,2)/sqrt(13),'r')

figure;errorbar(x(2:end-2),mean(w1-w2,2),std(w1-w2,0,2)/sqrt(13))

for i=1:48
    p(i)=ranksum(w1(i,:),w2(i,:));
    p1(i)=signrank(w1(i,:));
    p2(i)=signrank(w2(i,:));
    p3(i)=signrank(w1(i,:)-w2(i,:));
end
t=find(p<0.05);
x(t+1)
p(t)
t=find(p1<0.05);
x(t+1)
p1(t)
t=find(p2<0.05);
x(t+1)
p2(t)
t=find(p3<0.05);
x(t+1)
p3(t)

figure;plot(x(2:end-2),w1-w2)

for i=151:308
    figure;plot(x(2:end-2),d1(:,i))
    xlim([-100 100])
end

for i=1:48
    p(i)=ranksum(d1(i,:),d2(i,:));
    %p2(i)=signrank(d1(i,:)-d2(i,:));
end

t=find(p<0.05);
x(t+2)
p(t)

t2=find(p2<0.05);
x(t2+2)

%%


trig_bg_sup_cont=zeros(51,13);
trig_bg_sup_cont(:,1)=mean(trig_bg_sup_1111c_cond1,2);
trig_bg_sup_cont(:,2)=mean(trig_bg_sup_1111c_cond2,2);
trig_bg_sup_cont(:,3)=mean(trig_bg_sup_1111d_cond1,2);
trig_bg_sup_cont(:,4)=mean(trig_bg_sup_1111d_cond2,2);
trig_bg_sup_cont(:,5)=mean(trig_bg_sup_1811c_cond1,2);
trig_bg_sup_cont(:,6)=mean(trig_bg_sup_1811d_cond1,2);
trig_bg_sup_cont(:,7)=mean(trig_bg_sup_1811e_cond1,2);
trig_bg_sup_cont(:,8)=mean(trig_bg_sup_2511d_cond1,2);
trig_bg_sup_cont(:,9)=mean(trig_bg_sup_2511e_cond1,2);
trig_bg_sup_cont(:,10)=mean(trig_bg_sup_2511f_cond1,2);
trig_bg_sup_cont(:,11)=mean(trig_bg_sup_1203d_cond1,2);
trig_bg_sup_cont(:,12)=mean(trig_bg_sup_1203e_cond1,2);
trig_bg_sup_cont(:,13)=mean(trig_bg_sup_1203f_cond1,2);


trig_bg_sup_non=zeros(51,13);
trig_bg_sup_non(:,1)=mean(trig_bg_sup_1111c_cond4,2);
trig_bg_sup_non(:,2)=mean(trig_bg_sup_1111c_cond5,2);
trig_bg_sup_non(:,3)=mean(trig_bg_sup_1111d_cond4,2);
trig_bg_sup_non(:,4)=mean(trig_bg_sup_1111d_cond5,2);
trig_bg_sup_non(:,5)=mean(trig_bg_sup_1811c_cond5,2);
trig_bg_sup_non(:,6)=mean(trig_bg_sup_1811d_cond5,2);
trig_bg_sup_non(:,7)=mean(trig_bg_sup_1811e_cond5,2);
trig_bg_sup_non(:,8)=mean(trig_bg_sup_2511d_cond5,2);
trig_bg_sup_non(:,9)=mean(trig_bg_sup_2511e_cond5,2);
trig_bg_sup_non(:,10)=mean(trig_bg_sup_2511f_cond5,2);
trig_bg_sup_non(:,11)=mean(trig_bg_sup_1203d_cond5,2);
trig_bg_sup_non(:,12)=mean(trig_bg_sup_1203e_cond5,2);
trig_bg_sup_non(:,13)=mean(trig_bg_sup_1203f_cond5,2);




%
time_bg_sup_cont=time_bg_sup_1111c_cond1;
time_bg_sup_cont=cat(2,time_bg_sup_cont,time_bg_sup_1111c_cond2);
time_bg_sup_cont=cat(2,time_bg_sup_cont,time_bg_sup_1111d_cond1);
time_bg_sup_cont=cat(2,time_bg_sup_cont,time_bg_sup_1111d_cond2);
time_bg_sup_cont=cat(2,time_bg_sup_cont,time_bg_sup_1811c_cond1);
time_bg_sup_cont=cat(2,time_bg_sup_cont,time_bg_sup_1811d_cond1);
time_bg_sup_cont=cat(2,time_bg_sup_cont,time_bg_sup_1811e_cond1);
time_bg_sup_cont=cat(2,time_bg_sup_cont,time_bg_sup_2511d_cond1);
time_bg_sup_cont=cat(2,time_bg_sup_cont,time_bg_sup_2511e_cond1);
time_bg_sup_cont=cat(2,time_bg_sup_cont,time_bg_sup_2511f_cond1);
time_bg_sup_cont=cat(2,time_bg_sup_cont,time_bg_sup_1203d_cond1);
time_bg_sup_cont=cat(2,time_bg_sup_cont,time_bg_sup_1203e_cond1);
time_bg_sup_cont=cat(2,time_bg_sup_cont,time_bg_sup_1203f_cond1);


time_bg_sup_non=time_bg_sup_1111c_cond4;
time_bg_sup_non=cat(2,time_bg_sup_non,time_bg_sup_1111c_cond5);
time_bg_sup_non=cat(2,time_bg_sup_non,time_bg_sup_1111d_cond4);
time_bg_sup_non=cat(2,time_bg_sup_non,time_bg_sup_1111d_cond5);
time_bg_sup_non=cat(2,time_bg_sup_non,time_bg_sup_1811c_cond5);
time_bg_sup_non=cat(2,time_bg_sup_non,time_bg_sup_1811d_cond5);
time_bg_sup_non=cat(2,time_bg_sup_non,time_bg_sup_1811e_cond5);
time_bg_sup_non=cat(2,time_bg_sup_non,time_bg_sup_2511d_cond5);
time_bg_sup_non=cat(2,time_bg_sup_non,time_bg_sup_2511e_cond5);
time_bg_sup_non=cat(2,time_bg_sup_non,time_bg_sup_2511f_cond5);
time_bg_sup_non=cat(2,time_bg_sup_non,time_bg_sup_1203d_cond5);
time_bg_sup_non=cat(2,time_bg_sup_non,time_bg_sup_1203e_cond5);
time_bg_sup_non=cat(2,time_bg_sup_non,time_bg_sup_1203f_cond5);

x2=(1:256)*10-280;
tt=x2(round(time_bg_sup_cont));
tt2=x2(round(time_bg_sup_non));

n1=hist(tt,90:10:250);
n2=hist(tt2,90:10:250);

figure;bar(90:10:250,[n1;n2]')






%% finding max derivative

max_der_cont=max(d1(30:38,:),[],1);
max_der_non=max(d2(30:38,:),[],1);

for i=1:size(trig_bg_sup_cont,2)
    time_max_der_cont(i)=find(d1(30:38,i)==max_der_cont(i));
end


for i=1:size(trig_bg_sup_non,2)
    time_max_der_non(i)=find(d2(30:38,i)==max_der_non(i));
end


figure
scatter(time_bg_sup_cont,time_bg_sup_cont+time_max_der_cont)

figure
scatter(time_bg_sup_non,time_bg_sup_non+time_max_der_non)


x2=(1:256)*10-280;
a=x2(round(time_bg_sup_cont));
b=x2(round(time_bg_sup_cont+time_max_der_cont));

c=x2(round(time_bg_sup_non));
d=x2(round(time_bg_sup_non+time_max_der_non));


sc=zeros(27);
for y=1:308
    sc(a(y)/10,b(y)/10)=sc(a(y)/10,b(y)/10)+1;
end    

figure;imagesc(0:10:270,0:10:270,-sc);colormap(pink)


n1=hist(b-a,0:10:90);
n2=hist(d-c,0:10:90);
figure;bar(0:10:90,[n1;n2]')








figure
hist(time_max_der_cont)








trig_der_cont=trig_der_1111c_cond1;
trig_der_cont=cat(2,trig_der_cont,trig_der_1111c_cond2);
trig_der_cont=cat(2,trig_der_cont,trig_der_1111d_cond1);
trig_der_cont=cat(2,trig_der_cont,trig_der_1111d_cond2);
trig_der_cont=cat(2,trig_der_cont,trig_der_1811c_cond1);
trig_der_cont=cat(2,trig_der_cont,trig_der_1811d_cond1);
trig_der_cont=cat(2,trig_der_cont,trig_der_1811e_cond1);
trig_der_cont=cat(2,trig_der_cont,trig_der_2511d_cond1);
trig_der_cont=cat(2,trig_der_cont,trig_der_2511e_cond1);
trig_der_cont=cat(2,trig_der_cont,trig_der_2511f_cond1);
trig_der_cont=cat(2,trig_der_cont,trig_der_1203d_cond1);
trig_der_cont=cat(2,trig_der_cont,trig_der_1203e_cond1);
trig_der_cont=cat(2,trig_der_cont,trig_der_1203f_cond1);


trig_der_non=trig_der_1111c_cond4;
trig_der_non=cat(2,trig_der_non,trig_der_1111c_cond5);
trig_der_non=cat(2,trig_der_non,trig_der_1111d_cond4);
trig_der_non=cat(2,trig_der_non,trig_der_1111d_cond5);
trig_der_non=cat(2,trig_der_non,trig_der_1811c_cond5);
trig_der_non=cat(2,trig_der_non,trig_der_1811d_cond5);
trig_der_non=cat(2,trig_der_non,trig_der_1811e_cond5);
trig_der_non=cat(2,trig_der_non,trig_der_2511d_cond5);
trig_der_non=cat(2,trig_der_non,trig_der_2511e_cond5);
trig_der_non=cat(2,trig_der_non,trig_der_2511f_cond5);
trig_der_non=cat(2,trig_der_non,trig_der_1203d_cond5);
trig_der_non=cat(2,trig_der_non,trig_der_1203e_cond5);
trig_der_non=cat(2,trig_der_non,trig_der_1203f_cond5);




x=-250:10:250;
figure;errorbar(x,mean(trig_der_cont,2),std(trig_der_cont,0,2)/sqrt(size(trig_der_cont,2)))
hold on
errorbar(x,mean(trig_der_non,2),std(trig_der_non,0,2)/sqrt(size(trig_der_non,2)),'r')


n1=hist(der_max_time_roi_V2_cont-time_bg_sup_cont,1:30);
n2=hist(der_max_time_roi_V2_non-time_bg_sup_non,1:30);
figure;bar(1:30,[n1;n2]')






c=corrcoef(time_bg_sup_cont(72:103),time_max_der_cont(72:103));
r(1)=c(1,2)
c=corrcoef(time_bg_sup_cont(1:20),time_max_der_cont(1:20));
r(2)=c(1,2)
c=corrcoef(time_bg_sup_cont(21:39),time_max_der_cont(21:39));
r(3)=c(1,2)
c=corrcoef(time_bg_sup_cont(40:71),time_max_der_cont(40:71));
r(4)=c(1,2)
c=corrcoef(time_bg_sup_cont(72:103),time_max_der_cont(72:103));
r(5)=c(1,2)
c=corrcoef(time_bg_sup_cont(104:120),time_max_der_cont(104:120));
r(6)=c(1,2)
c=corrcoef(time_bg_sup_cont(121:144),time_max_der_cont(121:144)); 
r(7)=c(1,2)
c=corrcoef(time_bg_sup_cont(145:164),time_max_der_cont(145:164));
r(8)=c(1,2)
c=corrcoef(time_bg_sup_cont(165:189),time_max_der_cont(165:189));
r(9)=c(1,2)
c=corrcoef(time_bg_sup_cont(190:210),time_max_der_cont(190:210));
r(10)=c(1,2)
c=corrcoef(time_bg_sup_cont(211:232),time_max_der_cont(211:232));
r(11)=c(1,2)
c=corrcoef(time_bg_sup_cont(233:259),time_max_der_cont(233:259));
r(12)=c(1,2)
c=corrcoef(time_bg_sup_cont(260:282),time_max_der_cont(260:282));
r(13)=c(1,2)
c=corrcoef(time_bg_sup_cont(283:308),time_max_der_cont(283:308));

c=corrcoef(time_bg_sup_non(1:29),time_max_der_non(1:29));
r2(1)=c(1,2)
c=corrcoef(time_bg_sup_non(30:57),time_max_der_non(30:57));
r2(2)=c(1,2)
c=corrcoef(time_bg_sup_non(58:85),time_max_der_non(58:85));
r2(3)=c(1,2)
c=corrcoef(time_bg_sup_non(86:113),time_max_der_non(86:113));
r2(4)=c(1,2)
c=corrcoef(time_bg_sup_non(114:139),time_max_der_non(114:139));
r2(5)=c(1,2)
c=corrcoef(time_bg_sup_non(140:164),time_max_der_non(140:164));
r2(6)=c(1,2)
c=corrcoef(time_bg_sup_non(165:195),time_max_der_non(165:195));
r2(7)=c(1,2)
c=corrcoef(time_bg_sup_non(196:223),time_max_der_non(196:223));
r2(8)=c(1,2)
c=corrcoef(time_bg_sup_non(224:251),time_max_der_non(224:251));
r2(9)=c(1,2)
c=corrcoef(time_bg_sup_non(252:279),time_max_der_non(252:279));
r2(10)=c(1,2)
c=corrcoef(time_bg_sup_non(280:313),time_max_der_non(280:313));
r2(11)=c(1,2)
c=corrcoef(time_bg_sup_non(314:343),time_max_der_non(314:343));
r2(12)=c(1,2)
c=corrcoef(time_bg_sup_non(344:373),time_max_der_non(344:373));
r2(13)=c(1,2)





for i=1:20
    figure;
    plot(squeeze(mean(cond1n_dt_bl(roi_maskin,1:112,i),1)))
    xlim([2 112])
end    
    
    
%%


der_max_time_roi_V2_cont=der_max_time_roi_V2_1111c_cond1;
der_max_time_roi_V2_cont=cat(2,der_max_time_roi_V2_cont,der_max_time_roi_V2_1111c_cond2);
der_max_time_roi_V2_cont=cat(2,der_max_time_roi_V2_cont,der_max_time_roi_V2_1111d_cond1);
der_max_time_roi_V2_cont=cat(2,der_max_time_roi_V2_cont,der_max_time_roi_V2_1111d_cond2);
der_max_time_roi_V2_cont=cat(2,der_max_time_roi_V2_cont,der_max_time_roi_V2_1811c_cond1);
der_max_time_roi_V2_cont=cat(2,der_max_time_roi_V2_cont,der_max_time_roi_V2_1811d_cond1);
der_max_time_roi_V2_cont=cat(2,der_max_time_roi_V2_cont,der_max_time_roi_V2_1811e_cond1);
der_max_time_roi_V2_cont=cat(2,der_max_time_roi_V2_cont,der_max_time_roi_V2_2511d_cond1);
der_max_time_roi_V2_cont=cat(2,der_max_time_roi_V2_cont,der_max_time_roi_V2_2511e_cond1);
der_max_time_roi_V2_cont=cat(2,der_max_time_roi_V2_cont,der_max_time_roi_V2_2511f_cond1);
der_max_time_roi_V2_cont=cat(2,der_max_time_roi_V2_cont,der_max_time_roi_V2_1203d_cond1);
der_max_time_roi_V2_cont=cat(2,der_max_time_roi_V2_cont,der_max_time_roi_V2_1203e_cond1);
der_max_time_roi_V2_cont=cat(2,der_max_time_roi_V2_cont,der_max_time_roi_V2_1203f_cond1);


der_max_time_roi_V2_non=der_max_time_roi_V2_1111c_cond4;
der_max_time_roi_V2_non=cat(2,der_max_time_roi_V2_non,der_max_time_roi_V2_1111c_cond5);
der_max_time_roi_V2_non=cat(2,der_max_time_roi_V2_non,der_max_time_roi_V2_1111d_cond4);
der_max_time_roi_V2_non=cat(2,der_max_time_roi_V2_non,der_max_time_roi_V2_1111d_cond5);
der_max_time_roi_V2_non=cat(2,der_max_time_roi_V2_non,der_max_time_roi_V2_1811c_cond5);
der_max_time_roi_V2_non=cat(2,der_max_time_roi_V2_non,der_max_time_roi_V2_1811d_cond5);
der_max_time_roi_V2_non=cat(2,der_max_time_roi_V2_non,der_max_time_roi_V2_1811e_cond5);
der_max_time_roi_V2_non=cat(2,der_max_time_roi_V2_non,der_max_time_roi_V2_2511d_cond5);
der_max_time_roi_V2_non=cat(2,der_max_time_roi_V2_non,der_max_time_roi_V2_2511e_cond5);
der_max_time_roi_V2_non=cat(2,der_max_time_roi_V2_non,der_max_time_roi_V2_2511f_cond5);
der_max_time_roi_V2_non=cat(2,der_max_time_roi_V2_non,der_max_time_roi_V2_1203d_cond5);
der_max_time_roi_V2_non=cat(2,der_max_time_roi_V2_non,der_max_time_roi_V2_1203e_cond5);
der_max_time_roi_V2_non=cat(2,der_max_time_roi_V2_non,der_max_time_roi_V2_1203f_cond5);

x2=(1:256)*10-280;
tt=x2(round(der_max_time_roi_V2_cont));
tt2=x2(round(der_max_time_roi_V2_non));

n1=hist(tt,90:10:250);
n2=hist(tt2,90:10:250);

figure;bar(90:10:250,[n1;n2]')


%%

x2=(1:256)*10-280;
diff_cont=(time_circ_cont-time_bg_sup_cont)*10;
diff_non=(time_circ_non-time_bg_sup_non)*10;


n1=hist(diff_cont,-40:10:60);
n2=hist(diff_non,-40:10:60);

figure;bar(-40:10:60,[n1;n2]')

ranksum(diff_cont,diff_non)
signrank(diff_cont)
signrank(diff_non)









figure;errorbar(x(4:end-2),mean(w1(3:48,:),2),std(w1(3:48,:),0,2)/sqrt(13))
hold on
errorbar(x(4:end-2),mean(w2(1:46,:),2),std(w2(1:46,:),0,2)/sqrt(13),'r')

figure;errorbar(x(4:end-2),mean(w1(3:48,:)-w2(1:46,:),2),std(w1(3:48,:)-w2(1:46,:),0,2)/sqrt(13))


for i=1:46
    p(i)=ranksum(w1(i+2,:),w2(i,:));
    p1(i)=signrank(w1(i,:));
    p2(i)=signrank(w2(i,:));
    p3(i)=signrank(w1(i+2,:)-w2(i,:));
end

t=find(p<0.05);
x(t+1)
p(t)
t=find(p1<0.05);
x(t+1)
p1(t)
t=find(p2<0.05);
x(t+1)
p2(t)
t=find(p3<0.05);
x(t+1)
p3(t)

