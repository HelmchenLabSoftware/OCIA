

%1804
a1804_V1=squeeze(mean(der_cond4(roi_V1,:,:),3));
b1804_V1=squeeze(mean(der_cond3(roi_V1,:,:),3));

a1804_V1_2=squeeze(mean(der_cond4(roi_V1_2,:,:),3));
b1804_V1_2=squeeze(mean(der_cond3(roi_V1_2,:,:),3));

a1804_V2=squeeze(mean(der_cond4(roi_V2,:,:),3));
b1804_V2=squeeze(mean(der_cond3(roi_V2,:,:),3));



x=(10:10:2520)-260;
n=size(a1804_V1,1);
figure
plot(x,mean(a1804_V1-1,1),'LineWidth',3)
hold on
plot(x,mean(a1804_V1-1,1)+3*std(a1804_V1,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(a1804_V1-1,1)-3*std(a1804_V1,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(b1804_V1-1,1),'r','LineWidth',3)
hold on
plot(x,mean(b1804_V1-1,1)+3*std(b1804_V1,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(b1804_V1-1,1)-3*std(b1804_V1,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('Derivative V1');xlabel('Time (ms)');
xlim([-200 400]);


x=(10:10:2520)-260;
n=size(a1804_V1_2,1);
figure
plot(x,mean(a1804_V1_2-1,1),'LineWidth',3)
hold on
plot(x,mean(a1804_V1_2-1,1)+3*std(a1804_V1_2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(a1804_V1_2-1,1)-3*std(a1804_V1_2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(b1804_V1_2-1,1),'r','LineWidth',3)
hold on
plot(x,mean(b1804_V1_2-1,1)+3*std(b1804_V1_2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(b1804_V1_2-1,1)-3*std(b1804_V1_2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('Derivative V1_2');xlabel('Time (ms)');
xlim([-200 400]);



x=(10:10:2520)-260;
n=size(a1804_V2,1);
figure
plot(x,mean(a1804_V2-1,1),'LineWidth',3)
hold on
plot(x,mean(a1804_V2-1,1)+3*std(a1804_V2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(a1804_V2-1,1)-3*std(a1804_V2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(b1804_V2-1,1),'r','LineWidth',3)
hold on
plot(x,mean(b1804_V2-1,1)+3*std(b1804_V2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(b1804_V2-1,1)-3*std(b1804_V2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('Derivative V2');xlabel('Time (ms)');
xlim([-200 400]);





%% 1203
a1203_V1=squeeze(mean(der_cond4(roi_V1,:,:),3));
b1203_V1=squeeze(mean(der_cond3(roi_V1,:,:),3));

a1203_V1_2=squeeze(mean(der_cond4(roi_V1_2,:,:),3));
b1203_V1_2=squeeze(mean(der_cond3(roi_V1_2,:,:),3));

a1203_V2=squeeze(mean(der_cond4(roi_V2,:,:),3));
b1203_V2=squeeze(mean(der_cond3(roi_V2,:,:),3));



x=(10:10:2520)-260;
n=size(a1203_V1,1);
figure
plot(x,mean(a1203_V1-1,1),'LineWidth',3)
hold on
plot(x,mean(a1203_V1-1,1)+3*std(a1203_V1,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(a1203_V1-1,1)-3*std(a1203_V1,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(b1203_V1-1,1),'r','LineWidth',3)
hold on
plot(x,mean(b1203_V1-1,1)+3*std(b1203_V1,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(b1203_V1-1,1)-3*std(b1203_V1,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('Derivative V1');xlabel('Time (ms)');
xlim([-200 400]);


x=(10:10:2520)-260;
n=size(a1203_V1_2,1);
figure
plot(x,mean(a1203_V1_2-1,1),'LineWidth',3)
hold on
plot(x,mean(a1203_V1_2-1,1)+3*std(a1203_V1_2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(a1203_V1_2-1,1)-3*std(a1203_V1_2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(b1203_V1_2-1,1),'r','LineWidth',3)
hold on
plot(x,mean(b1203_V1_2-1,1)+3*std(b1203_V1_2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(b1203_V1_2-1,1)-3*std(b1203_V1_2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('Derivative V1_2');xlabel('Time (ms)');
xlim([-200 400]);



x=(10:10:2520)-260;
n=size(a1203_V2,1);
figure
plot(x,mean(a1203_V2-1,1),'LineWidth',3)
hold on
plot(x,mean(a1203_V2-1,1)+3*std(a1203_V2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(a1203_V2-1,1)-3*std(a1203_V2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(b1203_V2-1,1),'r','LineWidth',3)
hold on
plot(x,mean(b1203_V2-1,1)+3*std(b1203_V2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(b1203_V2-1,1)-3*std(b1203_V2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('Derivative V2');xlabel('Time (ms)');
xlim([-200 400]);




%% 1005b
a1005b_V1=squeeze(mean(der_cond4(roi_V1,:,:),3));
b1005b_V1=squeeze(mean(der_cond3(roi_V1,:,:),3));

a1005b_V1_2=squeeze(mean(der_cond4(roi_V1_2,:,:),3));
b1005b_V1_2=squeeze(mean(der_cond3(roi_V1_2,:,:),3));

a1005b_V2=squeeze(mean(der_cond4(roi_V2,:,:),3));
b1005b_V2=squeeze(mean(der_cond3(roi_V2,:,:),3));



x=(10:10:2520)-260;
n=size(a1005b_V1,1);
figure
plot(x,mean(a1005b_V1-1,1),'LineWidth',3)
hold on
plot(x,mean(a1005b_V1-1,1)+3*std(a1005b_V1,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(a1005b_V1-1,1)-3*std(a1005b_V1,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(b1005b_V1-1,1),'r','LineWidth',3)
hold on
plot(x,mean(b1005b_V1-1,1)+3*std(b1005b_V1,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(b1005b_V1-1,1)-3*std(b1005b_V1,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('Derivative V1');xlabel('Time (ms)');
xlim([-200 400]);


x=(10:10:2520)-260;
n=size(a1005b_V1_2,1);
figure
plot(x,mean(a1005b_V1_2-1,1),'LineWidth',3)
hold on
plot(x,mean(a1005b_V1_2-1,1)+3*std(a1005b_V1_2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(a1005b_V1_2-1,1)-3*std(a1005b_V1_2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(b1005b_V1_2-1,1),'r','LineWidth',3)
hold on
plot(x,mean(b1005b_V1_2-1,1)+3*std(b1005b_V1_2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(b1005b_V1_2-1,1)-3*std(b1005b_V1_2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('Derivative V1_2');xlabel('Time (ms)');
xlim([-200 400]);



x=(10:10:2520)-260;
n=size(a1005b_V2,1);
figure
plot(x,mean(a1005b_V2-1,1),'LineWidth',3)
hold on
plot(x,mean(a1005b_V2-1,1)+3*std(a1005b_V2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(a1005b_V2-1,1)-3*std(a1005b_V2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(b1005b_V2-1,1),'r','LineWidth',3)
hold on
plot(x,mean(b1005b_V2-1,1)+3*std(b1005b_V2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(b1005b_V2-1,1)-3*std(b1005b_V2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('Derivative V2');xlabel('Time (ms)');
xlim([-200 400]);





%% 1005e
a1005e_V1=squeeze(mean(der_cond4(roi_V1,:,:),3));
b1005e_V1=squeeze(mean(der_cond3(roi_V1,:,:),3));

a1005e_V1_2=squeeze(mean(der_cond4(roi_V1_2,:,:),3));
b1005e_V1_2=squeeze(mean(der_cond3(roi_V1_2,:,:),3));

a1005e_V2=squeeze(mean(der_cond4(roi_V2,:,:),3));
b1005e_V2=squeeze(mean(der_cond3(roi_V2,:,:),3));



x=(10:10:2520)-260;
n=size(a1005e_V1,1);
figure
plot(x,mean(a1005e_V1-1,1),'LineWidth',3)
hold on
plot(x,mean(a1005e_V1-1,1)+3*std(a1005e_V1,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(a1005e_V1-1,1)-3*std(a1005e_V1,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(b1005e_V1-1,1),'r','LineWidth',3)
hold on
plot(x,mean(b1005e_V1-1,1)+3*std(b1005e_V1,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(b1005e_V1-1,1)-3*std(b1005e_V1,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('Derivative V1');xlabel('Time (ms)');
xlim([-200 400]);


x=(10:10:2520)-260;
n=size(a1005e_V1_2,1);
figure
plot(x,mean(a1005e_V1_2-1,1),'LineWidth',3)
hold on
plot(x,mean(a1005e_V1_2-1,1)+3*std(a1005e_V1_2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(a1005e_V1_2-1,1)-3*std(a1005e_V1_2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(b1005e_V1_2-1,1),'r','LineWidth',3)
hold on
plot(x,mean(b1005e_V1_2-1,1)+3*std(b1005e_V1_2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(b1005e_V1_2-1,1)-3*std(b1005e_V1_2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('Derivative V1_2');xlabel('Time (ms)');
xlim([-200 400]);



x=(10:10:2520)-260;
n=size(a1005e_V2,1);
figure
plot(x,mean(a1005e_V2-1,1),'LineWidth',3)
hold on
plot(x,mean(a1005e_V2-1,1)+3*std(a1005e_V2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(a1005e_V2-1,1)-3*std(a1005e_V2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(b1005e_V2-1,1),'r','LineWidth',3)
hold on
plot(x,mean(b1005e_V2-1,1)+3*std(b1005e_V2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(b1005e_V2-1,1)-3*std(b1005e_V2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('Derivative V2');xlabel('Time (ms)');
xlim([-200 400]);




%% 2011p
a2011p_V1=squeeze(mean(der_cond4(roi_V1,:,:),3));
b2011p_V1=squeeze(mean(der_cond3(roi_V1,:,:),3));

a2011p_V1_2=squeeze(mean(der_cond4(roi_V1_2,:,:),3));
b2011p_V1_2=squeeze(mean(der_cond3(roi_V1_2,:,:),3));

a2011p_V2=squeeze(mean(der_cond4(roi_V2,:,:),3));
b2011p_V2=squeeze(mean(der_cond3(roi_V2,:,:),3));



x=(10:10:2520)-260;
n=size(a2011p_V1,1);
figure
plot(x,mean(a2011p_V1-1,1),'LineWidth',3)
hold on
plot(x,mean(a2011p_V1-1,1)+3*std(a2011p_V1,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(a2011p_V1-1,1)-3*std(a2011p_V1,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(b2011p_V1-1,1),'r','LineWidth',3)
hold on
plot(x,mean(b2011p_V1-1,1)+3*std(b2011p_V1,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(b2011p_V1-1,1)-3*std(b2011p_V1,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('Derivative V1');xlabel('Time (ms)');
xlim([-200 400]);


x=(10:10:2520)-260;
n=size(a2011p_V1_2,1);
figure
plot(x,mean(a2011p_V1_2-1,1),'LineWidth',3)
hold on
plot(x,mean(a2011p_V1_2-1,1)+3*std(a2011p_V1_2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(a2011p_V1_2-1,1)-3*std(a2011p_V1_2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(b2011p_V1_2-1,1),'r','LineWidth',3)
hold on
plot(x,mean(b2011p_V1_2-1,1)+3*std(b2011p_V1_2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(b2011p_V1_2-1,1)-3*std(b2011p_V1_2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('Derivative V1_2');xlabel('Time (ms)');
xlim([-200 400]);



x=(10:10:2520)-260;
n=size(a2011p_V2,1);
figure
plot(x,mean(a2011p_V2-1,1),'LineWidth',3)
hold on
plot(x,mean(a2011p_V2-1,1)+3*std(a2011p_V2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(a2011p_V2-1,1)-3*std(a2011p_V2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(b2011p_V2-1,1),'r','LineWidth',3)
hold on
plot(x,mean(b2011p_V2-1,1)+3*std(b2011p_V2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(b2011p_V2-1,1)-3*std(b2011p_V2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('Derivative V2');xlabel('Time (ms)');
xlim([-200 400]);




%% 3101
a3101_V1=squeeze(mean(der_cond2(roi_V1,:,:),3));
b3101_V1=squeeze(mean(der_cond4(roi_V1,:,:),3));

a3101_V1_2=squeeze(mean(der_cond2(roi_V1_2,:,:),3));
b3101_V1_2=squeeze(mean(der_cond4(roi_V1_2,:,:),3));

a3101_V2=squeeze(mean(der_cond2(roi_V2,:,:),3));
b3101_V2=squeeze(mean(der_cond4(roi_V2,:,:),3));



x=(10:10:2520)-260;
n=size(a3101_V1,1);
figure
plot(x,mean(a3101_V1-1,1),'LineWidth',3)
hold on
plot(x,mean(a3101_V1-1,1)+3*std(a3101_V1,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(a3101_V1-1,1)-3*std(a3101_V1,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(b3101_V1-1,1),'r','LineWidth',3)
hold on
plot(x,mean(b3101_V1-1,1)+3*std(b3101_V1,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(b3101_V1-1,1)-3*std(b3101_V1,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('Derivative V1');xlabel('Time (ms)');
xlim([-200 400]);


x=(10:10:2520)-260;
n=size(a3101_V1_2,1);
figure
plot(x,mean(a3101_V1_2-1,1),'LineWidth',3)
hold on
plot(x,mean(a3101_V1_2-1,1)+3*std(a3101_V1_2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(a3101_V1_2-1,1)-3*std(a3101_V1_2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(b3101_V1_2-1,1),'r','LineWidth',3)
hold on
plot(x,mean(b3101_V1_2-1,1)+3*std(b3101_V1_2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(b3101_V1_2-1,1)-3*std(b3101_V1_2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('Derivative V1_2');xlabel('Time (ms)');
xlim([-200 400]);



x=(10:10:2520)-260;
n=size(a3101_V2,1);
figure
plot(x,mean(a3101_V2-1,1),'LineWidth',3)
hold on
plot(x,mean(a3101_V2-1,1)+3*std(a3101_V2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(a3101_V2-1,1)-3*std(a3101_V2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(b3101_V2-1,1),'r','LineWidth',3)
hold on
plot(x,mean(b3101_V2-1,1)+3*std(b3101_V2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(b3101_V2-1,1)-3*std(b3101_V2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('Derivative V2');xlabel('Time (ms)');
xlim([-200 400]);



%% 0702
a0702_V1=squeeze(mean(der_cond2(roi_V1,:,:),3));
b0702_V1=squeeze(mean(der_cond4(roi_V1,:,:),3));

a0702_V1_2=squeeze(mean(der_cond2(roi_V1_2,:,:),3));
b0702_V1_2=squeeze(mean(der_cond4(roi_V1_2,:,:),3));

a0702_V2=squeeze(mean(der_cond2(roi_V2,:,:),3));
b0702_V2=squeeze(mean(der_cond4(roi_V2,:,:),3));



x=(10:10:2520)-260;
n=size(a0702_V1,1);
figure
plot(x,mean(a0702_V1-1,1),'LineWidth',3)
hold on
plot(x,mean(a0702_V1-1,1)+3*std(a0702_V1,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(a0702_V1-1,1)-3*std(a0702_V1,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(b0702_V1-1,1),'r','LineWidth',3)
hold on
plot(x,mean(b0702_V1-1,1)+3*std(b0702_V1,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(b0702_V1-1,1)-3*std(b0702_V1,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('Derivative V1');xlabel('Time (ms)');
xlim([-200 400]);


x=(10:10:2520)-260;
n=size(a0702_V1_2,1);
figure
plot(x,mean(a0702_V1_2-1,1),'LineWidth',3)
hold on
plot(x,mean(a0702_V1_2-1,1)+3*std(a0702_V1_2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(a0702_V1_2-1,1)-3*std(a0702_V1_2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(b0702_V1_2-1,1),'r','LineWidth',3)
hold on
plot(x,mean(b0702_V1_2-1,1)+3*std(b0702_V1_2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(b0702_V1_2-1,1)-3*std(b0702_V1_2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('Derivative V1_2');xlabel('Time (ms)');
xlim([-200 400]);



x=(10:10:2520)-260;
n=size(a0702_V2,1);
figure
plot(x,mean(a0702_V2-1,1),'LineWidth',3)
hold on
plot(x,mean(a0702_V2-1,1)+3*std(a0702_V2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(a0702_V2-1,1)-3*std(a0702_V2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(b0702_V2-1,1),'r','LineWidth',3)
hold on
plot(x,mean(b0702_V2-1,1)+3*std(b0702_V2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(b0702_V2-1,1)-3*std(b0702_V2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('Derivative V2');xlabel('Time (ms)');
xlim([-200 400]);



%% 2011c
a2011c_V1=squeeze(mean(der_cond2(roi_V1,:,:),3));
b2011c_V1=squeeze(mean(der_cond4(roi_V1,:,:),3));

a2011c_V1_2=squeeze(mean(der_cond2(roi_V1_2,:,:),3));
b2011c_V1_2=squeeze(mean(der_cond4(roi_V1_2,:,:),3));

a2011c_V2=squeeze(mean(der_cond2(roi_V2,:,:),3));
b2011c_V2=squeeze(mean(der_cond4(roi_V2,:,:),3));



x=(10:10:2520)-260;
n=size(a2011c_V1,1);
figure
plot(x,mean(a2011c_V1-1,1),'LineWidth',3)
hold on
plot(x,mean(a2011c_V1-1,1)+3*std(a2011c_V1,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(a2011c_V1-1,1)-3*std(a2011c_V1,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(b2011c_V1-1,1),'r','LineWidth',3)
hold on
plot(x,mean(b2011c_V1-1,1)+3*std(b2011c_V1,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(b2011c_V1-1,1)-3*std(b2011c_V1,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('Derivative V1');xlabel('Time (ms)');
xlim([-200 400]);


x=(10:10:2520)-260;
n=size(a2011c_V1_2,1);
figure
plot(x,mean(a2011c_V1_2-1,1),'LineWidth',3)
hold on
plot(x,mean(a2011c_V1_2-1,1)+3*std(a2011c_V1_2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(a2011c_V1_2-1,1)-3*std(a2011c_V1_2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(b2011c_V1_2-1,1),'r','LineWidth',3)
hold on
plot(x,mean(b2011c_V1_2-1,1)+3*std(b2011c_V1_2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(b2011c_V1_2-1,1)-3*std(b2011c_V1_2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('Derivative V1_2');xlabel('Time (ms)');
xlim([-200 400]);



x=(10:10:2520)-260;
n=size(a2011c_V2,1);
figure
plot(x,mean(a2011c_V2-1,1),'LineWidth',3)
hold on
plot(x,mean(a2011c_V2-1,1)+3*std(a2011c_V2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(a2011c_V2-1,1)-3*std(a2011c_V2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(b2011c_V2-1,1),'r','LineWidth',3)
hold on
plot(x,mean(b2011c_V2-1,1)+3*std(b2011c_V2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(b2011c_V2-1,1)-3*std(b2011c_V2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('Derivative V2');xlabel('Time (ms)');
xlim([-200 400]);





%%

aall_V1=cat(1,a1804_V1,a1203_V1,a1005b_V1,a1005e_V1,a2011p_V1);
ball_V1=cat(1,b1804_V1,b1203_V1,b1005b_V1,b1005e_V1,b2011p_V1);

aall_V1_2=cat(1,a1804_V1_2,a1203_V1_2,a1005b_V1_2,a1005e_V1_2,a2011p_V1_2);
ball_V1_2=cat(1,b1804_V1_2,b1203_V1_2,b1005b_V1_2,b1005e_V1_2,b2011p_V1_2);

aall_V2=cat(1,a1804_V2,a1203_V2,a1005b_V2,a1005e_V2,a2011p_V2);
ball_V2=cat(1,b1804_V2,b1203_V2,b1005b_V2,b1005e_V2,b2011p_V2);



x=(10:10:2520)-260;
n=size(aall_V1,1);
figure
plot(x,mean(aall_V1,1),'LineWidth',3)
hold on
plot(x,mean(aall_V1,1)+3*std(aall_V1,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(aall_V1,1)-3*std(aall_V1,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(ball_V1,1),'r','LineWidth',3)
hold on
plot(x,mean(ball_V1,1)+3*std(ball_V1,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(ball_V1,1)-3*std(ball_V1,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('derivative v1');xlabel('Time (ms)');
xlim([-200 400]);




x=(10:10:2520)-260;
n=size(aall_V1_2,1);
figure
plot(x,mean(aall_V1_2,1),'LineWidth',3)
hold on
plot(x,mean(aall_V1_2,1)+3*std(aall_V1_2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(aall_V1_2,1)-3*std(aall_V1_2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(ball_V1_2,1),'r','LineWidth',3)
hold on
plot(x,mean(ball_V1_2,1)+3*std(ball_V1_2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(ball_V1_2,1)-3*std(ball_V1_2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('derivative v1 2');xlabel('Time (ms)');
xlim([-200 400]);



x=(10:10:2520)-260;
n=size(aall_V1_2,1);
figure
plot(x,mean(aall_V2,1),'LineWidth',3)
hold on
plot(x,mean(aall_V2,1)+3*std(aall_V2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)
plot(x,mean(aall_V2,1)-3*std(aall_V2,0,1)./(sqrt(n)-1),'-.b','LineWidth',2)

plot(x,mean(ball_V2,1),'r','LineWidth',3)
hold on
plot(x,mean(ball_V2,1)+3*std(ball_V2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)
plot(x,mean(ball_V2,1)-3*std(ball_V2,0,1)./(sqrt(n)-1),'-.r','LineWidth',2)

title('derivative v2');xlabel('Time (ms)');
xlim([-200 400]);










