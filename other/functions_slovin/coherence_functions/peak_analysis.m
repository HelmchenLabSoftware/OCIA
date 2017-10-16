
%target v1
%c=zeros(1,369);
c(1:94)='b';
c(95:176)='r';
c(177:257)='g';
c(258:340)='c';
c(341:369)='y';
%flanker v1
c=zeros(1,240);
c(1:62)=1;
c(63:119)=12;
c(120:173)=24;
c(174:231)=36;
c(232:240)=48;
%v2
c=zeros(1,563);
c(1:117)=1;
c(118:268)=12;
c(269:358)=24;
c(359:450)=36;
c(451:563)=48;
%v2 elhanan
c=zeros(1,836);
c(1:84)=1;
c(85:192)=12;
c(193:363)=24;
c(364:578)=36;
c(579:836)=48;

%v2 elhanan
c=zeros(1,597);
c(1:120)=1;
c(121:272)=12;
c(273:386)=24;
c(387:489)=36;
c(490:597)=48;

%target v2comb
c=zeros(1,88);
c(1:11)=1;
c(12:58)=12;
c(59:66)=24;
c(67:82)=36;
c(83:88)=48;

%%
c=zeros(1,563);
c(1:117)=1;
c(118:268)=12;
c(269:358)=24;
c(359:450)=36;
c(451:563)=48;
%target
d=[1 94;95 176;177 257;258 340;341 369];
%flanker
d=[1 62;63 119;120 173;174 231;232 240];
%V2
d=[1 117;118 268;269 358;359 450;451 563];

band=4:9;

mcb=max(squeeze(mean(coher_colin(band,20:40,:),1)));
mnb=max(squeeze(mean(coher_nocolin(band,20:40,:),1)));
figure;
scatter(mnb(d(1,1):d(1,2)),mcb(d(1,1):d(1,2)),16,'b');
hold on
scatter(mnb(d(2,1):d(2,2)),mcb(d(2,1):d(2,2)),16,'r');
scatter(mnb(d(3,1):d(3,2)),mcb(d(3,1):d(3,2)),16,'g');
scatter(mnb(d(4,1):d(4,2)),mcb(d(4,1):d(4,2)),16,'c');
scatter(mnb(d(5,1):d(5,2)),mcb(d(5,1):d(5,2)),16,'y');xlim([0 0.015]);ylim([0 0.015]);
plot(0:0.01:0.2,0:0.01:0.2,'k')
ylabel('Collinear coherence peak');xlabel('Orthogonal coherence peak');


mcb=squeeze(mean(mean(coher_colin(band,20:30,:),1),2));
mnb=squeeze(mean(mean(coher_nocolin(band,20:30,:),1),2));
figure;
scatter(mnb(d(1,1):d(1,2)),mcb(d(1,1):d(1,2)),16,'b');
hold on
scatter(mnb(d(2,1):d(2,2)),mcb(d(2,1):d(2,2)),16,'r');
scatter(mnb(d(3,1):d(3,2)),mcb(d(3,1):d(3,2)),16,'g');
scatter(mnb(d(4,1):d(4,2)),mcb(d(4,1):d(4,2)),16,'c');
scatter(mnb(d(5,1):d(5,2)),mcb(d(5,1):d(5,2)),16,'y');xlim([0 0.6]);ylim([0 0.6]);
plot(0:0.01:0.9,0:0.01:0.9,'k')
ylabel('Collinear coherence peak');xlabel('Orthogonal coherence peak');

%%
[mc i]=max(squeeze(mean(coher_colin(4:9,20:40,:),1)));
nc=squeeze(mean(coher_nocolin(4:9,20:40,:),1));
for j=1:240
   mn(j)=nc(i(j),j); 
end
mn=mn';
figure;
scatter(mn,mc,16,c);
hold on
plot(0:0.01:0.9,0:0.01:0.9,'k')
xlim([0 0.6]);ylim([0 0.6]);ylabel('Collinear coherence peak');xlabel('Orthogonal coherence');



[mc i]=max(squeeze(mean(coher_colin(10:15,20:40,:),1)));
nc=squeeze(mean(coher_nocolin(10:15,20:40,:),1));
for j=1:369
   mn(j)=nc(i(j),j); 
end

figure;
scatter(mn,mc,16,c);
hold on
plot(0:0.01:0.9,0:0.01:0.9,'k')
xlim([0 0.1]);ylim([0 0.1]);ylabel('Collinear coherence peak');xlabel('Orthogonal coherence');










[ac i]=max(squeeze(mean(coher_colin(4:9,20:40,:),1)));
[an j]=max(squeeze(mean(coher_nocolin(4:9,20:40,:),1)));

d=[i-2;i-1;i;i+1;i+2]+2;
e=[j-2;j-1;j;j+1;j+2]+2;

gg=squeeze(mean(coher_colin(4:9,18:42,:),1));
nc=squeeze(mean(coher_nocolin(4:9,18:42,:),1));


for h=1:369
   mc(h)=mean(gg(d(:,h),h)); 
   mn(h)=mean(nc(e(:,h),h)); 
end
mn=mn';
mc=mc';
figure;
scatter(mn,mc,16,c);
hold on
plot(0:0.01:0.9,0:0.01:0.9,'k')
xlim([0 0.25]);ylim([0 0.25]);ylabel('Collinear coherence peak');xlabel('Orthogonal coherence');
 

coher_colin=zeros(32,112,184);
coher_nocolin=zeros(32,112,184);
coher_colin=coher_blank(:,:,1:2:368);
coher_nocolin=coher_blank(:,:,2:2:368);


p = ranksum(mc,mn)

p = ranksum(mc,mn)
p1 = ranksum(mc(1:117),mn(1:117))
p2 = ranksum(mc(118:268),mn(118:268))
p3 = ranksum(mc(269:358),mn(269:358))
p4 = ranksum(mc(359:450),mn(359:450))
p5 = ranksum(mc(451:563),mn(451:563))

p = ranksum(mc,mn)

p = ranksum(mc,mn)
p1 = ranksum(mc(1:94),mn(1:94))
p2 = ranksum(mc(95:176),mn(95:176))
p3 = ranksum(mc(177:257),mn(177:257))
p4 = ranksum(mc(258:340),mn(258:340))
p5 = ranksum(mc(341:369),mn(341:369))

c=zeros(1,369);
c(1:94)=1;
c(95:176)=12;
c(177:257)=24;
c(258:340)=36;
c(341:369)=48;

p = ranksum(mc,mn)
p1 = ranksum(mc(1:62),mn(1:62))
p2 = ranksum(mc(63:119),mn(63:119))
p3 = ranksum(mc(120:173),mn(120:173))
p4 = ranksum(mc(174:231),mn(174:231))
p5 = ranksum(mc(232:240),mn(232:240))


p = ranksum(mc,mn)
p1 = ranksum(mc(1:84),mn(1:84))
p2 = ranksum(mc(85:192),mn(85:192))
p3 = ranksum(mc(193:363),mn(193:363))
p4 = ranksum(mc(364:578),mn(364:578))
p5 = ranksum(mc(579:836),mn(579:836))


p = ranksum(mc,mn)
p1 = ranksum(mc(1:11),mn(1:11))
p2 = ranksum(mc(12:58),mn(12:58))
p3 = ranksum(mc(59:66),mn(59:66))
p4 = ranksum(mc(67:82),mn(67:82))
p5 = ranksum(mc(83:88),mn(83:88))

%target v2comb
c=zeros(1,88);
c(1:11)=1;
c(12:58)=12;
c(59:66)=24;
c(67:82)=36;
c(83:88)=48;

c=zeros(1,597);
c(1:120)=1;
c(121:272)=12;
c(273:386)=24;
c(387:489)=36;
c(490:597)=48;



c=zeros(1,836);
c(1:84)=1;
c(85:192)=12;
c(193:363)=24;
c(364:578)=36;
c(579:836)=48;




p = ranksum(mcb,mnb)
p1 = ranksum(mcb(1:94),mnb(1:94))
p2 = ranksum(mcb(95:176),mnb(95:176))
p3 = ranksum(mcb(177:257),mnb(177:257))
p4 = ranksum(mcb(258:340),mnb(258:340))
p5 = ranksum(mcb(341:369),mnb(341:369))


p = ranksum(mcb,mnb)
p1 = ranksum(mcb(1:62),mnb(1:62))
p2 = ranksum(mcb(63:119),mnb(63:119))
p3 = ranksum(mcb(120:173),mnb(120:173))
p4 = ranksum(mcb(174:231),mnb(174:231))
p5 = ranksum(mcb(232:240),mnb(232:240))



p = ranksum(mcb,mnb)
p1 = ranksum(mcb(1:117),mnb(1:117))
p2 = ranksum(mcb(118:268),mnb(118:268))
p3 = ranksum(mcb(269:358),mnb(269:358))
p4 = ranksum(mcb(359:450),mnb(359:450))
p5 = ranksum(mcb(451:563),mnb(451:563))


c=zeros(1,369);
c(1:94)=1;
c(95:176)=12;
c(177:257)=24;
c(258:340)=36;
c(341:369)=48;


c=zeros(1,240);
c(1:62)=1;
c(63:119)=12;
c(120:173)=24;
c(174:231)=36;
c(232:240)=48;


c=zeros(1,563);
c(1:117)=1;
c(118:268)=12;
c(269:358)=24;
c(359:450)=36;
c(451:563)=48;
