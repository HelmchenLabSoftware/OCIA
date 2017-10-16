




for i=1:111
    p(i)=signrank(der_cont_V2(i,:)-der_non_V2(i,:));
    p2(i)=signrank(der_cont_circ(i,:)-der_non_circ(i,:));
    p3(i)=signrank(der_cont_bgi(i,:)-der_non_bgi(i,:));
end    



for i=1:13
    figure;plot(x,mean(der_cont_V2(:,i)-der_non_V2(:,i),2))
    hold on
    plot(x,mean(der_cont_circ(:,i)-der_non_circ(:,i),2),'r')
    plot(x,mean(der_cont_bgi(:,i)-der_non_bgi(:,i),2),'g')
    xlim([-100 250])
end



for i=1:4
    figure;plot(x,mean(der_cont_V2(:,i),2))
    hold on
    plot(x,mean(der_cont_circ(:,i),2),'r')
    plot(x,mean(der_cont_bgi(:,i),2),'g')
    plot(x,mean(der_non_V2(:,i),2),'--')
    plot(x,mean(der_non_circ(:,i),2),'Color','r','LineStyle','--')
    plot(x,mean(der_non_bgi(:,i),2),'Color','g','LineStyle','--')
    xlim([-100 250])
end





figure;errorbar(x,mean(der_1111c2_V2-der_1111c5_V2,1),std(der_1111c2_V2-der_1111c5_V2,0,1)/sqrt(size(der_1111c2_V2,1)),'r')
hold on
errorbar(x,mean(der_1111c2_circ-der_1111c5_circ,1),std(der_1111c2_circ-der_1111c5_circ,0,1)/sqrt(size(der_1111c2_circ,1)),'b')
errorbar(x,mean(der_1111c2_bgi-der_1111c5_bgi,1),std(der_1111c2_bgi-der_1111c5_bgi,0,1)/sqrt(size(der_1111c2_bgi,1)),'g')
xlim([-100 250])



figure
scatter(der_non_V2(:,30),der_cont_V2(:,30))
xlim([-8e-4 8e-4]);ylim([-8e-4 8e-4])
hold on 
plot(-2e-3:0.00001:2e-3,-2e-3:0.00001:2e-3,'k')
ranksum(der_non_V2(:,30),der_cont_V2(:,30))

figure
scatter(der_non_circ(:,30),der_cont_circ(:,30))
xlim([-12e-4 14e-4]);ylim([-12e-4 14e-4])
hold on 
plot(-2e-3:0.00001:2e-3,-2e-3:0.00001:2e-3,'k')
ranksum(der_non_circ(:,30),der_cont_circ(:,30))

figure
scatter(der_non_bgi(:,30),der_cont_bgi(:,30))
xlim([-12e-4 14e-4]);ylim([-12e-4 14e-4])
hold on 
plot(-2e-3:0.00001:2e-3,-2e-3:0.00001:2e-3,'k')
ranksum(der_non_bgi(:,30),der_cont_bgi(:,30))





time=29;
figure
scatter(der_1203f5_V2(:,time),der_1203f1_V2(:,time))
xlim([-8e-4 8e-4]);ylim([-8e-4 8e-4])
hold on 
plot(-2e-3:0.00001:2e-3,-2e-3:0.00001:2e-3,'k')
ranksum(der_1203f5_V2(:,time),der_1203f1_V2(:,time))

figure
scatter(der_1203f5_circ(:,time),der_1203f1_circ(:,time))
xlim([-12e-4 14e-4]);ylim([-12e-4 14e-4])
hold on 
plot(-2e-3:0.00001:2e-3,-2e-3:0.00001:2e-3,'k')
ranksum(der_1203f5_circ(:,time),der_1203f1_circ(:,time))

figure
scatter(der_1203f5_bgi(:,time),der_1203f1_bgi(:,time))
xlim([-12e-4 14e-4]);ylim([-12e-4 14e-4])
hold on 
plot(-2e-3:0.00001:2e-3,-2e-3:0.00001:2e-3,'k')
ranksum(der_1203f5_bgi(:,time),der_1203f1_bgi(:,time))




time=36;
t=(-2e-4:0.00003:7e-4);
n1=hist(der_cont_V2(:,time),t);
n2=hist(der_non_V2(:,time),t);
%figure;bar(t,[n1;n2]')
figure;imagesc(t,t,-(n2'*n1));colormap(pink)
axis image
hold on
plot(-7e-4:0.00003:7e-4,-7e-4:0.00003:7e-4,'k')


t=(-3e-4:0.00003:9e-4);
n1=hist(der_cont_circ(:,time),t);
n2=hist(der_non_circ(:,time),t);
%figure;bar(t,[n1;n2]')
figure;imagesc(t,t,-(n2'*n1));colormap(pink)
axis image
hold on
plot(-10e-4:0.00003:10e-4,-10e-4:0.00003:10e-4,'k')

t=(-7e-4:0.00003:10e-4);
n1=hist(der_cont_bgi(:,time),t);
n2=hist(der_non_bgi(:,time),t);
%figure;bar(t,[n1;n2]')
figure;imagesc(t,t,-(n2'*n1));colormap(pink)
axis image
hold on
plot(-10e-4:0.00003:10e-4,-10e-4:0.00003:10e-4,'k')




time=29;
ranksum(der_non_V2(:,time),der_cont_V2(:,time))
ranksum(der_non_circ(:,time),der_cont_circ(:,time))
ranksum(der_non_bgi(:,time),der_cont_bgi(:,time))






x=(40:10:1140)-280;


time=29;
[n1 x1]=hist(der_cont_V2(:,time)-der_non_V2(:,time),50);
figure;plot(x1,n1/2300,'r')
hold on
[n1 x1]=hist(der_cont_circ(:,time)-der_non_circ(:,time),50);
plot(x1,n1/10076)
[n1 x1]=hist(der_cont_bgi(:,time)-der_non_bgi(:,time),50);
plot(x1,n1/13133,'g')





time=30;
[n1 x1]=hist(der_cont_V2(:,time)-der_non_V2(:,time),50);
figure;plot(x1,n1/2300,'r')
hold on
time=35;
[n1 x1]=hist(der_cont_V2(:,time)-der_non_V2(:,time),50);
plot(x1,n1/2300,'b')
time=44;
[n1 x1]=hist(der_cont_V2(:,time)-der_non_V2(:,time),50);
plot(x1,n1/2300,'g')






