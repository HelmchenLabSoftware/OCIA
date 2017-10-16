% peak latencies
%target v1
c=zeros(1,369);
c(1:94)=1;
c(95:176)=12;
c(177:257)=24;
c(258:340)=36;
c(341:369)=48;
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


%alpha
[ac i]=max(squeeze(mean(coher_colin(4:9,20:40,:),1)));
[an j]=max(squeeze(mean(coher_nocolin(4:9,20:40,:),1)));


figure;
scatter(i,j,16);
hold on
plot(-30:30,-30:30,'k')
xlim([min(i)-2 max(i)+2]);ylim([min(i)-2 max(i)+2]);ylabel('Collinear coherence peak');xlabel('Orthogonal coherence');


l=j-i; %latency between peaks
hist(l,-30:30);xlim([min(l)-2 max(l)+2]);xlabel('Time frames difference between peaks');ylabel('Number of pixels');
c=zeros(1,563);
c(1:117)=1;
c(118:268)=12;
c(269:358)=24;
c(359:450)=36;
c(451:563)=48;

[a1 b1]=hist(l(1:117),-30:30);xlim([min(l)-2 max(l)+2]);xlabel('Time frames difference between peaks');ylabel('Number of pixels');
%figure;hist(l(1:94),-30:30);xlim([min(l)-2 max(l)+2]);xlabel('Time frames difference between peaks');ylabel('Number of pixels');

[a2 b2]=hist(l(118:268),-30:30);xlim([min(l)-2 max(l)+2]);xlabel('Time frames difference between peaks');ylabel('Number of pixels');
%figure;hist(l(95:176),-30:30);xlim([min(l)-2 max(l)+2]);xlabel('Time frames difference between peaks');ylabel('Number of pixels');

[a3 b3]=hist(l(269:358),-30:30);xlim([min(l)-2 max(l)+2]);xlabel('Time frames difference between peaks');ylabel('Number of pixels');
%figure;hist(l(177:257),-30:30);xlim([min(l)-2 max(l)+2]);xlabel('Time frames difference between peaks');ylabel('Number of pixels');

[a4 b4]=hist(l(359:450),-30:30);xlim([min(l)-2 max(l)+2]);xlabel('Time frames difference between peaks');ylabel('Number of pixels');
%figure;hist(l(258:340),-30:30);xlim([min(l)-2 max(l)+2]);xlabel('Time frames difference between peaks');ylabel('Number of pixels');

[a5 b5]=hist(l(451:563),-30:30);xlim([min(l)-2 max(l)+2]);xlabel('Time frames difference between peaks');ylabel('Number of pixels');
%figure;hist(l(341:369),-30:30);xlim([min(l)-2 max(l)+2]);xlabel('Time frames difference between peaks');ylabel('Number of pixels');

figure
bar(b1,[a1;a2;a3;a4;a5]','stack')



p = ranksum(i,j)



p1 = ranksum(i(1:117),j(1:117))
p2 = ranksum(i(118:268),j(118:268))
p3 = ranksum(i(269:358),j(269:358))
p4 = ranksum(i(359:450),j(359:450))
p5 = ranksum(i(451:563),j(451:563))


p = ranksum(i,j)
p1 = ranksum(i(1:94),j(1:94))
p2 = ranksum(i(95:176),j(95:176))
p3 = ranksum(i(177:257),j(177:257))
p4 = ranksum(i(258:340),j(258:340))
p5 = ranksum(i(341:369),j(341:369))


p = ranksum(i,j)
p1 = ranksum(i(1:62),j(1:62))
p2 = ranksum(i(63:119),j(63:119))
p3 = ranksum(i(120:173),j(120:173))
p4 = ranksum(i(174:231),j(174:231))
p5 = ranksum(i(232:240),j(232:240))


%beta

[ac i]=max(squeeze(mean(coher_colin(10:15,20:40,:),1)));
[an j]=max(squeeze(mean(coher_nocolin(10:15,20:40,:),1)));

l=j-i; %latency between peaks


hist(l,-30:30);xlim([min(l)-2 max(l)+2]);xlabel('Time frames difference between peaks');ylabel('Number of pixels');

p = ranksum(i,j)
p1 = ranksum(i(1:117),j(1:117))
p2 = ranksum(i(118:268),j(118:268))
p3 = ranksum(i(269:358),j(269:358))
p4 = ranksum(i(359:450),j(359:450))
p5 = ranksum(i(451:563),j(451:563))

