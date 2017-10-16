% more statistics

S=zeros(6,15);

%alpha
[mc i]=max(squeeze(mean(coher_colin(4:9,20:40,:),1)));
[mn j]=max(squeeze(mean(coher_nocolin(4:9,20:40,:),1)));

mc=squeeze(mean(mean(coher_colin(4:9,20:30,:),1),2));
mn=squeeze(mean(mean(coher_nocolin(4:9,20:30,:),1),2));

%beta
[mc i]=max(squeeze(mean(coher_colin(10:15,20:40,:),1)));
[mn j]=max(squeeze(mean(coher_nocolin(10:15,20:40,:),1)));

mc=squeeze(mean(mean(coher_colin(10:15,20:30,:),1),2));
mn=squeeze(mean(mean(coher_nocolin(10:15,20:30,:),1),2));


%gamma
mc=squeeze(mean(mean(coher_colin(16:32,20:30,:),1),2));
mn=squeeze(mean(mean(coher_nocolin(16:32,20:30,:),1),2));

[mc i]=max(squeeze(mean(coher_colin(16:32,20:40,:),1)));
[mn j]=max(squeeze(mean(coher_nocolin(16:32,20:40,:),1)));


%% target
S(1,1)=mean(mc(1:94));
S(1,2)=mean(mn(1:94));
S(1,3)=std(mc(1:94));
S(1,4)=std(mn(1:94));
S(1,5)=ranksum(mc(1:94),mn(1:94));
S(2,1)=mean(mc(95:176));
S(2,2)=mean(mn(95:176));
S(2,3)=std(mc(95:176));
S(2,4)=std(mn(95:176));
S(2,5)=ranksum(mc(95:176),mn(95:176));
S(3,1)=mean(mc(177:257));
S(3,2)=mean(mn(177:257));
S(3,3)=std(mc(177:257));
S(3,4)=std(mn(177:257));
S(3,5)=ranksum(mc(177:257),mn(177:257));
S(4,1)=mean(mc(258:340));
S(4,2)=mean(mn(258:340));
S(4,3)=std(mc(258:340));
S(4,4)=std(mn(258:340));
S(4,5)=ranksum(mc(258:340),mn(258:340));
S(5,1)=mean(mc(341:369));
S(5,2)=mean(mn(341:369));
S(5,3)=std(mc(341:369));
S(5,4)=std(mn(341:369));
S(5,5)=ranksum(mc(341:369),mn(341:369));
S(6,1)=mean(mc);
S(6,2)=mean(mn);
S(6,3)=std(mc);
S(6,4)=std(mn);
S(6,5)=ranksum(mc,mn);


S(1,6)=mean(mc(1:94));
S(1,7)=mean(mn(1:94));
S(1,8)=std(mc(1:94));
S(1,9)=std(mn(1:94));
S(1,10)=ranksum(mc(1:94),mn(1:94));
S(2,6)=mean(mc(95:176));
S(2,7)=mean(mn(95:176));
S(2,8)=std(mc(95:176));
S(2,9)=std(mn(95:176));
S(2,10)=ranksum(mc(95:176),mn(95:176));
S(3,6)=mean(mc(177:257));
S(3,7)=mean(mn(177:257));
S(3,8)=std(mc(177:257));
S(3,9)=std(mn(177:257));
S(3,10)=ranksum(mc(177:257),mn(177:257));
S(4,6)=mean(mc(258:340));
S(4,7)=mean(mn(258:340));
S(4,8)=std(mc(258:340));
S(4,9)=std(mn(258:340));
S(4,10)=ranksum(mc(258:340),mn(258:340));
S(5,6)=mean(mc(341:369));
S(5,7)=mean(mn(341:369));
S(5,8)=std(mc(341:369));
S(5,9)=std(mn(341:369));
S(5,10)=ranksum(mc(341:369),mn(341:369));
S(6,6)=mean(mc);
S(6,7)=mean(mn);
S(6,8)=std(mc);
S(6,9)=std(mn);
S(6,10)=ranksum(mc,mn);


S(1,11)=mean(i(1:94))*10;
S(1,12)=mean(j(1:94))*10;
S(1,13)=std(i(1:94))*10;
S(1,14)=std(j(1:94))*10;
S(1,15)=ranksum(i(1:94),j(1:94));
S(2,11)=mean(i(95:176))*10;
S(2,12)=mean(j(95:176))*10;
S(2,13)=std(i(95:176))*10;
S(2,14)=std(j(95:176))*10;
S(2,15)=ranksum(i(95:176),j(95:176));
S(3,11)=mean(i(177:257))*10;
S(3,12)=mean(j(177:257))*10;
S(3,13)=std(i(177:257))*10;
S(3,14)=std(j(177:257))*10;
S(3,15)=ranksum(i(177:257),j(177:257));
S(4,11)=mean(i(258:340))*10;
S(4,12)=mean(j(258:340))*10;
S(4,13)=std(i(258:340))*10;
S(4,14)=std(j(258:340))*10;
S(4,15)=ranksum(i(258:340),j(258:340));
S(5,11)=mean(i(341:369))*10;
S(5,12)=mean(j(341:369))*10;
S(5,13)=std(i(341:369))*10;
S(5,14)=std(j(341:369))*10;
S(5,15)=ranksum(i(341:369),j(341:369));
S(6,11)=mean(i)*10;
S(6,12)=mean(j)*10;
S(6,13)=std(i)*10;
S(6,14)=std(j)*10;
S(6,15)=ranksum(i,j);

%% flanker

S(1,1)=mean(mc(1:62));
S(1,2)=mean(mn(1:62));
S(1,3)=std(mc(1:62));
S(1,4)=std(mn(1:62));
S(1,5)=ranksum(mc(1:62),mn(1:62));
S(2,1)=mean(mc(63:119));
S(2,2)=mean(mn(63:119));
S(2,3)=std(mc(63:119));
S(2,4)=std(mn(63:119));
S(2,5)=ranksum(mc(63:119),mn(63:119));
S(3,1)=mean(mc(120:173));
S(3,2)=mean(mn(120:173));
S(3,3)=std(mc(120:173));
S(3,4)=std(mn(120:173));
S(3,5)=ranksum(mc(120:173),mn(120:173));
S(4,1)=mean(mc(174:231));
S(4,2)=mean(mn(174:231));
S(4,3)=std(mc(174:231));
S(4,4)=std(mn(174:231));
S(4,5)=ranksum(mc(174:231),mn(174:231));
S(5,1)=mean(mc(232:240));
S(5,2)=mean(mn(232:240));
S(5,3)=std(mc(232:240));
S(5,4)=std(mn(232:240));
S(5,5)=ranksum(mc(232:240),mn(232:240));
S(6,1)=mean(mc);
S(6,2)=mean(mn);
S(6,3)=std(mc);
S(6,4)=std(mn);
S(6,5)=ranksum(mc,mn);


S(1,6)=mean(mc(1:62));
S(1,7)=mean(mn(1:62));
S(1,8)=std(mc(1:62));
S(1,9)=std(mn(1:62));
S(1,10)=ranksum(mc(1:62),mn(1:62));
S(2,6)=mean(mc(63:119));
S(2,7)=mean(mn(63:119));
S(2,8)=std(mc(63:119));
S(2,9)=std(mn(63:119));
S(2,10)=ranksum(mc(63:119),mn(63:119));
S(3,6)=mean(mc(120:173));
S(3,7)=mean(mn(120:173));
S(3,8)=std(mc(120:173));
S(3,9)=std(mn(120:173));
S(3,10)=ranksum(mc(120:173),mn(120:173));
S(4,6)=mean(mc(174:231));
S(4,7)=mean(mn(174:231));
S(4,8)=std(mc(174:231));
S(4,9)=std(mn(174:231));
S(4,10)=ranksum(mc(174:231),mn(174:231));
S(5,6)=mean(mc(232:240));
S(5,7)=mean(mn(232:240));
S(5,8)=std(mc(232:240));
S(5,9)=std(mn(232:240));
S(5,10)=ranksum(mc(232:240),mn(232:240));
S(6,6)=mean(mc);
S(6,7)=mean(mn);
S(6,8)=std(mc);
S(6,9)=std(mn);
S(6,10)=ranksum(mc,mn);


S(1,11)=mean(i(1:62))*10;
S(1,12)=mean(j(1:62))*10;
S(1,13)=std(i(1:62))*10;
S(1,14)=std(j(1:62))*10;
S(1,15)=ranksum(i(1:62),j(1:62));
S(2,11)=mean(i(63:119))*10;
S(2,12)=mean(j(63:119))*10;
S(2,13)=std(i(63:119))*10;
S(2,14)=std(j(63:119))*10;
S(2,15)=ranksum(i(63:119),j(63:119));
S(3,11)=mean(i(120:173))*10;
S(3,12)=mean(j(120:173))*10;
S(3,13)=std(i(120:173))*10;
S(3,14)=std(j(120:173))*10;
S(3,15)=ranksum(i(120:173),j(120:173));
S(4,11)=mean(i(174:231))*10;
S(4,12)=mean(j(174:231))*10;
S(4,13)=std(i(174:231))*10;
S(4,14)=std(j(174:231))*10;
S(4,15)=ranksum(i(174:231),j(174:231));
S(5,11)=mean(i(232:240))*10;
S(5,12)=mean(j(232:240))*10;
S(5,13)=std(i(232:240))*10;
S(5,14)=std(j(232:240))*10;
S(5,15)=ranksum(i(232:240),j(232:240));
S(6,11)=mean(i)*10;
S(6,12)=mean(j)*10;
S(6,13)=std(i)*10;
S(6,14)=std(j)*10;
S(6,15)=ranksum(i,j);


%% V2
S(1,1)=mean(mc(1:117));
S(1,2)=mean(mn(1:117));
S(1,3)=std(mc(1:117));
S(1,4)=std(mn(1:117));
S(1,5)=ranksum(mc(1:117),mn(1:117));
S(2,1)=mean(mc(118:268));
S(2,2)=mean(mn(118:268));
S(2,3)=std(mc(118:268));
S(2,4)=std(mn(118:268));
S(2,5)=ranksum(mc(118:268),mn(118:268));
S(3,1)=mean(mc(269:358));
S(3,2)=mean(mn(269:358));
S(3,3)=std(mc(269:358));
S(3,4)=std(mn(269:358));
S(3,5)=ranksum(mc(269:358),mn(269:358));
S(4,1)=mean(mc(359:450));
S(4,2)=mean(mn(359:450));
S(4,3)=std(mc(359:450));
S(4,4)=std(mn(359:450));
S(4,5)=ranksum(mc(359:450),mn(359:450));
S(5,1)=mean(mc(451:563));
S(5,2)=mean(mn(451:563));
S(5,3)=std(mc(451:563));
S(5,4)=std(mn(451:563));
S(5,5)=ranksum(mc(451:563),mn(451:563));
S(6,1)=mean(mc);
S(6,2)=mean(mn);
S(6,3)=std(mc);
S(6,4)=std(mn);
S(6,5)=ranksum(mc,mn);


S(1,6)=mean(mc(1:117));
S(1,7)=mean(mn(1:117));
S(1,8)=std(mc(1:117));
S(1,9)=std(mn(1:117));
S(1,10)=ranksum(mc(1:117),mn(1:117));
S(2,6)=mean(mc(118:268));
S(2,7)=mean(mn(118:268));
S(2,8)=std(mc(118:268));
S(2,9)=std(mn(118:268));
S(2,10)=ranksum(mc(118:268),mn(118:268));
S(3,6)=mean(mc(269:358));
S(3,7)=mean(mn(269:358));
S(3,8)=std(mc(269:358));
S(3,9)=std(mn(269:358));
S(3,10)=ranksum(mc(269:358),mn(269:358));
S(4,6)=mean(mc(359:450));
S(4,7)=mean(mn(359:450));
S(4,8)=std(mc(359:450));
S(4,9)=std(mn(359:450));
S(4,10)=ranksum(mc(359:450),mn(359:450));
S(5,6)=mean(mc(451:563));
S(5,7)=mean(mn(451:563));
S(5,8)=std(mc(451:563));
S(5,9)=std(mn(451:563));
S(5,10)=ranksum(mc(451:563),mn(451:563));
S(6,6)=mean(mc);
S(6,7)=mean(mn);
S(6,8)=std(mc);
S(6,9)=std(mn);
S(6,10)=ranksum(mc,mn);


S(1,11)=mean(i(1:117))*10;
S(1,12)=mean(j(1:117))*10;
S(1,13)=std(i(1:117))*10;
S(1,14)=std(j(1:117))*10;
S(1,15)=ranksum(i(1:117),j(1:117));
S(2,11)=mean(i(118:268))*10;
S(2,12)=mean(j(118:268))*10;
S(2,13)=std(i(118:268))*10;
S(2,14)=std(j(118:268))*10;
S(2,15)=ranksum(i(118:268),j(118:268));
S(3,11)=mean(i(269:358))*10;
S(3,12)=mean(j(269:358))*10;
S(3,13)=std(i(269:358))*10;
S(3,14)=std(j(269:358))*10;
S(3,15)=ranksum(i(269:358),j(269:358));
S(4,11)=mean(i(359:450))*10;
S(4,12)=mean(j(359:450))*10;
S(4,13)=std(i(359:450))*10;
S(4,14)=std(j(359:450))*10;
S(4,15)=ranksum(i(359:450),j(359:450));
S(5,11)=mean(i(451:563))*10;
S(5,12)=mean(j(451:563))*10;
S(5,13)=std(i(451:563))*10;
S(5,14)=std(j(451:563))*10;
S(5,15)=ranksum(i(451:563),j(451:563));
S(6,11)=mean(i)*10;
S(6,12)=mean(j)*10;
S(6,13)=std(i)*10;
S(6,14)=std(j)*10;
S(6,15)=ranksum(i,j);

%%

p1 = ranksum(i(1:94),j(1:94))
p2 = ranksum(i(118:268),j(95:176))
p3 = ranksum(i(177:257),j(177:257))
p4 = ranksum(i(258:340),j(258:340))
p5 = ranksum(i(341:369),j(341:369))

c=zeros(1,563);
c(1:117)=1;
c(118:268)=12;
c(269:358)=24;
c(359:450)=36;
c(451:563)=48;

p = ranksum(i,j)
p1 = ranksum(i(1:62),j(1:62))
p2 = ranksum(i(63:119),j(63:119))
p3 = ranksum(i(120:173),j(120:173))
p4 = ranksum(i(174:231),j(174:231))
p5 = ranksum(i(232:240),j(232:240))

