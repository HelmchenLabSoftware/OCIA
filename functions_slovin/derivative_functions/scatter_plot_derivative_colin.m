
time=31:33;
%target
d_V1=[1 94;95 176;177 257;258 340;341 369];
%flanker
d_V1_2=[1 62;63 119;120 173;174 231;232 240];
%V2
d_V2=[1 117;118 268;269 358;359 450;451 563];


figure;
scatter(mean(ball_V1(d_V1(1,1):d_V1(1,2),time),2),mean(aall_V1(d_V1(1,1):d_V1(1,2),time),2),16,'b');
hold on
scatter(mean(ball_V1(d_V1(2,1):d_V1(2,2),time),2),mean(aall_V1(d_V1(2,1):d_V1(2,2),time),2),16,'r');
scatter(mean(ball_V1(d_V1(3,1):d_V1(3,2),time),2),mean(aall_V1(d_V1(3,1):d_V1(3,2),time),2),16,'g');
scatter(mean(ball_V1(d_V1(4,1):d_V1(4,2),time),2),mean(aall_V1(d_V1(4,1):d_V1(4,2),time),2),16,'c');
scatter(mean(ball_V1(d_V1(5,1):d_V1(5,2),time),2),mean(aall_V1(d_V1(5,1):d_V1(5,2),time),2),16,'y');
xlim([-2e-4 12e-4]);ylim([-2e-4 12e-4]);
plot(-1e-3:0.0001:3e-3,-1e-3:0.0001:3e-3,'k')
ylabel('derivative V1 collinear');xlabel('derivative V1 orthogonal');

p = ranksum(mean(ball_V1(d_V1(1,1):d_V1(1,2),time),2),mean(aall_V1(d_V1(1,1):d_V1(1,2),time),2))
p1 = ranksum(mean(ball_V1(d_V1(2,1):d_V1(2,2),time),2),mean(aall_V1(d_V1(2,1):d_V1(2,2),time),2))
p2 = ranksum(mean(ball_V1(d_V1(3,1):d_V1(3,2),time),2),mean(aall_V1(d_V1(3,1):d_V1(3,2),time),2))
p3 = ranksum(mean(ball_V1(d_V1(3,1):d_V1(3,2),time),2),mean(aall_V1(d_V1(3,1):d_V1(3,2),time),2))
p4 = ranksum(mean(ball_V1(d_V1(4,1):d_V1(4,2),time),2),mean(aall_V1(d_V1(4,1):d_V1(4,2),time),2))
p5 = ranksum(mean(ball_V1(d_V1(5,1):d_V1(5,2),time),2),mean(aall_V1(d_V1(5,1):d_V1(5,2),time),2))



figure;
scatter(mean(ball_V1_2(d_V1_2(1,1):d_V1_2(1,2),time),2),mean(aall_V1_2(d_V1_2(1,1):d_V1_2(1,2),time),2),16,'b');
hold on
scatter(mean(ball_V1_2(d_V1_2(2,1):d_V1_2(2,2),time),2),mean(aall_V1_2(d_V1_2(2,1):d_V1_2(2,2),time),2),16,'r');
scatter(mean(ball_V1_2(d_V1_2(3,1):d_V1_2(3,2),time),2),mean(aall_V1_2(d_V1_2(3,1):d_V1_2(3,2),time),2),16,'g');
scatter(mean(ball_V1_2(d_V1_2(4,1):d_V1_2(4,2),time),2),mean(aall_V1_2(d_V1_2(4,1):d_V1_2(4,2),time),2),16,'c');
scatter(mean(ball_V1_2(d_V1_2(5,1):d_V1_2(5,2),time),2),mean(aall_V1_2(d_V1_2(5,1):d_V1_2(5,2),time),2),16,'y');
xlim([-2e-4 12e-4]);ylim([-2e-4 12e-4]);
plot(-1e-3:0.0001:3e-3,-1e-3:0.0001:3e-3,'k')
ylabel('derivative V1_2 collinear');xlabel('derivative V1_2 orthogonal');

p = ranksum(mean(ball_V1_2(d_V1_2(1,1):d_V1_2(1,2),time),2),mean(aall_V1_2(d_V1_2(1,1):d_V1_2(1,2),time),2))
p1 = ranksum(mean(ball_V1_2(d_V1_2(2,1):d_V1_2(2,2),time),2),mean(aall_V1_2(d_V1_2(2,1):d_V1_2(2,2),time),2))
p2 = ranksum(mean(ball_V1_2(d_V1_2(3,1):d_V1_2(3,2),time),2),mean(aall_V1_2(d_V1_2(3,1):d_V1_2(3,2),time),2))
p3 = ranksum(mean(ball_V1_2(d_V1_2(3,1):d_V1_2(3,2),time),2),mean(aall_V1_2(d_V1_2(3,1):d_V1_2(3,2),time),2))
p4 = ranksum(mean(ball_V1_2(d_V1_2(4,1):d_V1_2(4,2),time),2),mean(aall_V1_2(d_V1_2(4,1):d_V1_2(4,2),time),2))
p5 = ranksum(mean(ball_V1_2(d_V1_2(5,1):d_V1_2(5,2),time),2),mean(aall_V1_2(d_V1_2(5,1):d_V1_2(5,2),time),2))




figure;
scatter(mean(ball_V2(d_V2(1,1):d_V2(1,2),time),2),mean(aall_V2(d_V2(1,1):d_V2(1,2),time),2),16,'b');
hold on
scatter(mean(ball_V2(d_V2(2,1):d_V2(2,2),time),2),mean(aall_V2(d_V2(2,1):d_V2(2,2),time),2),16,'r');
scatter(mean(ball_V2(d_V2(3,1):d_V2(3,2),time),2),mean(aall_V2(d_V2(3,1):d_V2(3,2),time),2),16,'g');
scatter(mean(ball_V2(d_V2(4,1):d_V2(4,2),time),2),mean(aall_V2(d_V2(4,1):d_V2(4,2),time),2),16,'c');
scatter(mean(ball_V2(d_V2(5,1):d_V2(5,2),time),2),mean(aall_V2(d_V2(5,1):d_V2(5,2),time),2),16,'y');
xlim([-2e-4 12e-4]);ylim([-2e-4 12e-4]);
plot(-1e-3:0.0001:3e-3,-1e-3:0.0001:3e-3,'k')
ylabel('derivative V2 collinear');xlabel('derivative V2 orthogonal');

p = ranksum(mean(ball_V2(d_V2(1,1):d_V2(1,2),time),2),mean(aall_V2(d_V2(1,1):d_V2(1,2),time),2))
p1 = ranksum(mean(ball_V2(d_V2(2,1):d_V2(2,2),time),2),mean(aall_V2(d_V2(2,1):d_V2(2,2),time),2))
p2 = ranksum(mean(ball_V2(d_V2(3,1):d_V2(3,2),time),2),mean(aall_V2(d_V2(3,1):d_V2(3,2),time),2))
p3 = ranksum(mean(ball_V2(d_V2(3,1):d_V2(3,2),time),2),mean(aall_V2(d_V2(3,1):d_V2(3,2),time),2))
p4 = ranksum(mean(ball_V2(d_V2(4,1):d_V2(4,2),time),2),mean(aall_V2(d_V2(4,1):d_V2(4,2),time),2))
p5 = ranksum(mean(ball_V2(d_V2(5,1):d_V2(5,2),time),2),mean(aall_V2(d_V2(5,1):d_V2(5,2),time),2))





