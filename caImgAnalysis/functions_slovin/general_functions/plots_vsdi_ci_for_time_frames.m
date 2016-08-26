

t0=zeros(3,18);
t0(1,1:13)=time_V2(28,:);
t0(2,:)=time_circ(28,:);
t0(3,:)=time_bgi(28,:);
figure;plot(t0,'Marker','+')
hold on
plot(mean(t0,2),'Marker','+','LineStyle','-.')
xlim([0.5 3.5])
ylim([-3e-4 3e-4])


t60=zeros(3,18);
t60(1,1:13)=time_V2(34,:);
t60(2,:)=time_circ(34,:);
t60(3,:)=time_bgi(34,:);
figure;plot(t60,'Marker','+')
hold on
plot(mean(t60,2),'Marker','+','LineStyle','-.')
xlim([0.5 3.5])
ylim([-3e-4 3e-4])

t100=zeros(3,18);
t100(1,1:13)=time_V2(38,:);
t100(2,:)=time_circ(38,:);
t100(3,:)=time_bgi(38,:);
figure;plot(t100,'Marker','+')
hold on
plot(mean(t100,2),'Marker','+','LineStyle','-.')
xlim([0.5 3.5])
ylim([-3e-4 3e-4])

t150=zeros(3,18);
t150(1,1:13)=time_V2(43,:);
t150(2,:)=time_circ(43,:);
t150(3,:)=time_bgi(43,:);
figure;plot(t150,'Marker','+')
hold on
plot(mean(t150,2),'Marker','+','LineStyle','-.')
xlim([0.5 3.5])
ylim([-3e-4 3e-4])


t250=zeros(3,18);
t250(1,1:13)=time_V2(53,:);
t250(2,:)=time_circ(53,:);
t250(3,:)=time_bgi(53,:);
figure;plot(t250,'Marker','+')
hold on
plot(mean(t250,2),'Marker','+','LineStyle','-.')
xlim([0.5 3.5])
ylim([-8e-4 3e-4])



%%

a=mean(time_circ,2);
b=mean(time_bgi,2);
c=mean(time_V2,2);
d=mean(time_bgo,2);

figure;bar(x,[a b c])
xlim([-50 150])


for i=1:256
   [p1(i) h1(i)]=signrank(time_circ(i,:));
   [p2(i) h2(i)]=signrank(time_bgi(i,:));
   [p3(i) h3(i)]=signrank(time_bgo(i,:));
   [p4(i) h4(i)]=signrank(time_V2(i,:));
end









