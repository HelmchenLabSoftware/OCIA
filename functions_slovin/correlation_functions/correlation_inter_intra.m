

x=(20:10:1130)-240;
cc_diff_1111c14_cont=cc_circ_V2_1111c14_cont-cc_circ_circ_1111c14_cont;
cc_diff_1111c14_non=cc_circ_V2_1111c14_non-cc_circ_circ_1111c14_non;

cc_diff_1111c25_cont=cc_circ_V2_1111c25_cont-cc_circ_circ_1111c25_cont;
cc_diff_1111c25_non=cc_circ_V2_1111c25_non-cc_circ_circ_1111c25_non;

cc_diff_1111d14_cont=cc_circ_V2_1111d14_cont-cc_circ_circ_1111d14_cont;
cc_diff_1111d14_non=cc_circ_V2_1111d14_non-cc_circ_circ_1111d14_non;

cc_diff_1111d25_cont=cc_circ_V2_1111d25_cont-cc_circ_circ_1111d25_cont;
cc_diff_1111d25_non=cc_circ_V2_1111d25_non-cc_circ_circ_1111d25_non;

cc_diff_1811c_cont=cc_circ_V2_1811c_cont-cc_circ_circ_1811c_cont;
cc_diff_1811c_non=cc_circ_V2_1811c_non-cc_circ_circ_1811c_non;

cc_diff_1811d_cont=cc_circ_V2_1811d_cont-cc_circ_circ_1811d_cont;
cc_diff_1811d_non=cc_circ_V2_1811d_non-cc_circ_circ_1811d_non;

cc_diff_1811e_cont=cc_circ_V2_1811e_cont-cc_circ_circ_1811e_cont;
cc_diff_1811e_non=cc_circ_V2_1811e_non-cc_circ_circ_1811e_non;

cc_diff_2511d_cont=cc_circ_V2_2511d_cont-cc_circ_circ_2511d_cont;
cc_diff_2511d_non=cc_circ_V2_2511d_non-cc_circ_circ_2511d_non;

cc_diff_2511e_cont=cc_circ_V2_2511e_cont-cc_circ_circ_2511e_cont;
cc_diff_2511e_non=cc_circ_V2_2511e_non-cc_circ_circ_2511e_non;

cc_diff_2511f_cont=cc_circ_V2_2511f_cont-cc_circ_circ_2511f_cont;
cc_diff_2511f_non=cc_circ_V2_2511f_non-cc_circ_circ_2511f_non;

cc_diff_1203d_cont=cc_circ_V2_1203d_cont-cc_circ_circ_1203d_cont;
cc_diff_1203d_non=cc_circ_V2_1203d_non-cc_circ_circ_1203d_non;

cc_diff_1203e_cont=cc_circ_V2_1203e_cont-cc_circ_circ_1203e_cont;
cc_diff_1203e_non=cc_circ_V2_1203e_non-cc_circ_circ_1203e_non;

cc_diff_1203f_cont=cc_circ_V2_1203f_cont-cc_circ_circ_1203f_cont;
cc_diff_1203f_non=cc_circ_V2_1203f_non-cc_circ_circ_1203f_non;


cc_diff_cont(:,1)=mean(cc_diff_1111c14_cont,1);
cc_diff_cont(:,2)=mean(cc_diff_1111c25_cont,1);
cc_diff_cont(:,3)=mean(cc_diff_1111d14_cont,1);
cc_diff_cont(:,4)=mean(cc_diff_1111d25_cont,1);
cc_diff_cont(:,5)=mean(cc_diff_1811c_cont,1);
cc_diff_cont(:,6)=mean(cc_diff_1811d_cont,1);
cc_diff_cont(:,7)=mean(cc_diff_1811e_cont,1);
cc_diff_cont(:,8)=mean(cc_diff_2511d_cont,1);
cc_diff_cont(:,9)=mean(cc_diff_2511e_cont,1);
cc_diff_cont(:,10)=mean(cc_diff_2511f_cont,1);
cc_diff_cont(:,11)=mean(cc_diff_1203d_cont,1);
cc_diff_cont(:,12)=mean(cc_diff_1203e_cont,1);
cc_diff_cont(:,13)=mean(cc_diff_1203f_cont,1);


cc_diff_non(:,1)=mean(cc_diff_1111c14_non,1);
cc_diff_non(:,2)=mean(cc_diff_1111c25_non,1);
cc_diff_non(:,3)=mean(cc_diff_1111d14_non,1);
cc_diff_non(:,4)=mean(cc_diff_1111d25_non,1);
cc_diff_non(:,5)=mean(cc_diff_1811c_non,1);
cc_diff_non(:,6)=mean(cc_diff_1811d_non,1);
cc_diff_non(:,7)=mean(cc_diff_1811e_non,1);
cc_diff_non(:,8)=mean(cc_diff_2511d_non,1);
cc_diff_non(:,9)=mean(cc_diff_2511e_non,1);
cc_diff_non(:,10)=mean(cc_diff_2511f_non,1);
cc_diff_non(:,11)=mean(cc_diff_1203d_non,1);
cc_diff_non(:,12)=mean(cc_diff_1203e_non,1);
cc_diff_non(:,13)=mean(cc_diff_1203f_non,1);


figure;plot(x,mean(cc_diff_cont,2))
hold on
plot(x,mean(cc_diff_non,2),'r')
xlim([-100 250])



for i=11:13
    figure;plot(x,cc_diff_cont(:,i))
    hold on
    plot(x,cc_diff_non(:,i),'r')
    xlim([-100 250])
end



%% 


%substract minimum
cc_diff_cont=cc_diff_cont-repmat(mean(cc_diff_cont(13:18,:),1),112,1);
cc_diff_non=cc_diff_non-repmat(mean(cc_diff_non(13:18,:),1),112,1);

%%
time=31:34;
figure;scatter(mean(cc_diff_1111c14_non(:,time),2),mean(cc_diff_1111c14_cont(:,time),2))
xlim([-.3 .1]);ylim([-.3 .1])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')

figure;scatter(mean(cc_diff_1111c25_non(:,time),2),mean(cc_diff_1111c25_cont(:,time),2))
xlim([-.3 .1]);ylim([-.3 .1])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')


time=42:45;
figure;scatter(mean(cc_diff_1111c14_non(:,time),2),mean(cc_diff_1111c14_cont(:,time),2))
xlim([-.3 .1]);ylim([-.3 .1])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')

figure;scatter(mean(cc_diff_1111c25_non(:,time),2),mean(cc_diff_1111c25_cont(:,time),2))
xlim([-.3 .1]);ylim([-.3 .1])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')



time=31:34;
figure;scatter(mean(cc_diff_1111d14_non(:,time),2),mean(cc_diff_1111d14_cont(:,time),2))
xlim([-.3 .1]);ylim([-.3 .1])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')

figure;scatter(mean(cc_diff_1111d25_non(:,time),2),mean(cc_diff_1111d25_cont(:,time),2))
xlim([-.3 .1]);ylim([-.3 .1])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')


time=42:45;
figure;scatter(mean(cc_diff_1111d14_non(:,time),2),mean(cc_diff_1111d14_cont(:,time),2))
xlim([-.3 .1]);ylim([-.3 .1])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')

figure;scatter(mean(cc_diff_1111d25_non(:,time),2),mean(cc_diff_1111d25_cont(:,time),2))
xlim([-.3 .1]);ylim([-.3 .1])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')


time=31:34;
figure;scatter(mean(cc_diff_1811c_non(:,time),2),mean(cc_diff_1811c_cont(:,time),2))
xlim([-.3 .1]);ylim([-.3 .1])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')

figure;scatter(mean(cc_diff_1811d_non(:,time),2),mean(cc_diff_1811d_cont(:,time),2))
xlim([-.3 .1]);ylim([-.3 .1])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')

figure;scatter(mean(cc_diff_1811e_non(:,time),2),mean(cc_diff_1811e_cont(:,time),2))
xlim([-.3 .1]);ylim([-.3 .1])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')





time=42:45;

figure;scatter(mean(cc_diff_1811c_non(:,time),2),mean(cc_diff_1811c_cont(:,time),2))
xlim([-.3 .1]);ylim([-.3 .1])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')

figure;scatter(mean(cc_diff_1811d_non(:,time),2),mean(cc_diff_1811d_cont(:,time),2))
xlim([-.3 .1]);ylim([-.3 .1])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')

figure;scatter(mean(cc_diff_1811e_non(:,time),2),mean(cc_diff_1811e_cont(:,time),2))
xlim([-.3 .1]);ylim([-.3 .1])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')






time=31:34;
figure;scatter(mean(cc_diff_2511d_non(:,time),2),mean(cc_diff_2511d_cont(:,time),2))
xlim([-.3 .1]);ylim([-.3 .1])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')

figure;scatter(mean(cc_diff_2511e_non(:,time),2),mean(cc_diff_2511e_cont(:,time),2))
xlim([-.3 .1]);ylim([-.3 .1])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')

figure;scatter(mean(cc_diff_2511f_non(:,time),2),mean(cc_diff_2511f_cont(:,time),2))
xlim([-.3 .1]);ylim([-.3 .1])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')



time=42:45;
figure;scatter(mean(cc_diff_2511d_non(:,time),2),mean(cc_diff_2511d_cont(:,time),2))
xlim([-.3 .1]);ylim([-.3 .1])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')

figure;scatter(mean(cc_diff_2511e_non(:,time),2),mean(cc_diff_2511e_cont(:,time),2))
xlim([-.3 .1]);ylim([-.3 .1])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')

figure;scatter(mean(cc_diff_2511f_non(:,time),2),mean(cc_diff_2511f_cont(:,time),2))
xlim([-.3 .1]);ylim([-.3 .1])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')











time=31:34;
figure;scatter(mean(cc_diff_1203d_non(:,time),2),mean(cc_diff_1203d_cont(:,time),2))
xlim([-.3 .1]);ylim([-.3 .1])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')

figure;scatter(mean(cc_diff_1203e_non(:,time),2),mean(cc_diff_1203e_cont(:,time),2))
xlim([-.3 .1]);ylim([-.3 .1])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')

figure;scatter(mean(cc_diff_1203f_non(:,time),2),mean(cc_diff_1203f_cont(:,time),2))
xlim([-.3 .1]);ylim([-.3 .1])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')



time=42:45;
figure;scatter(mean(cc_diff_1203d_non(:,time),2),mean(cc_diff_1203d_cont(:,time),2))
xlim([-.3 .1]);ylim([-.3 .1])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')

figure;scatter(mean(cc_diff_1203e_non(:,time),2),mean(cc_diff_1203e_cont(:,time),2))
xlim([-.3 .1]);ylim([-.3 .1])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')

figure;scatter(mean(cc_diff_1203f_non(:,time),2),mean(cc_diff_1203f_cont(:,time),2))
xlim([-.3 .1]);ylim([-.3 .1])
hold on
plot(-1:0.01:1,-1:0.01:1,'k')







%%

















