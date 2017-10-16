


fg_right_leg(:,1)=fg_right_1811_jit10;
fg_right_leg(:,2)=fg_right_1811_jit15;
fg_right_leg(:,3)=fg_right_2511_jit15;
fg_right_leg(:,4)=fg_right_2511_jit17;
fg_right_leg(:,5)=fg_right_2511_jit20;
fg_right_leg(:,6)=fg_right_2511_jit25;
% fg_right_leg(:,7)=fg_right_1203_jit10;
% fg_right_leg(:,8)=fg_right_1203_jit15;
% fg_right_leg(:,9)=fg_right_1203_jit20;

fg_left_leg(:,1)=fg_left_1811_jit10;
fg_left_leg(:,2)=fg_left_1811_jit15;
fg_left_leg(:,3)=fg_left_2511_jit15;
fg_left_leg(:,4)=fg_left_2511_jit17;
fg_left_leg(:,5)=fg_left_2511_jit20;
fg_left_leg(:,6)=fg_left_2511_jit25;
% fg_left_leg(:,7)=fg_left_1203_jit10;
% fg_left_leg(:,8)=fg_left_1203_jit15;
% fg_left_leg(:,9)=fg_left_1203_jit20;

fg_right_smeg(:,1)=fg_right_1412_jit5;
fg_right_smeg(:,2)=fg_right_1412_jit10;
fg_right_smeg(:,3)=fg_right_1412_jit15;
fg_right_smeg(:,4)=fg_right_1412_jit15_2;
fg_right_smeg(:,5)=fg_right_2212_jit5;
fg_right_smeg(:,6)=fg_right_2212_jit10;
fg_right_smeg(:,7)=fg_right_2212_jit17;
fg_right_smeg(:,8)=fg_right_0501_jit5;
fg_right_smeg(:,9)=fg_right_0501_jit10;

fg_left_smeg(:,1)=fg_left_1412_jit5;
fg_left_smeg(:,2)=fg_left_1412_jit10;
fg_left_smeg(:,3)=fg_left_1412_jit15;
fg_left_smeg(:,4)=fg_left_1412_jit15_2;
fg_left_smeg(:,5)=fg_left_2212_jit5;
fg_left_smeg(:,6)=fg_left_2212_jit10;
fg_left_smeg(:,7)=fg_left_2212_jit17;
fg_left_smeg(:,8)=fg_left_0501_jit5;
fg_left_smeg(:,9)=fg_left_0501_jit10;


figure;plot(mean(fg_right_leg,2))
hold on
plot(mean(fg_left_leg,2),'r')
xlim([20 58])
ranksum(mean(fg_right_leg(34,:),1),mean(fg_left_leg(34,:),1))

fgp_leg=fg_right_leg-fg_left_leg;
figure;errorbar(mean(fgp_leg,2),std(fgp_leg,0,2)/sqrt(9))
xlim([20 58])
hold on 
plot(zeros(1,256),'k')
for i=20:70
    p=signrank(fgp_leg(i,:));
    if p<0.05
        disp(i)
    end
end
for i=1:9
    figure;plot(fgp_leg(:,i))
    xlim([20 58])
    hold on 
    plot(zeros(1,256),'k')
end


figure;plot(mean(fg_right_smeg,2))
hold on
plot(mean(fg_left_smeg,2),'r')
xlim([20 58])
ranksum(mean(fg_right_smeg(34,:),1),mean(fg_left_smeg(34,:),1))

fgp_smeg=fg_right_smeg-fg_left_smeg;
figure;errorbar(mean(fgp_smeg,2),std(fgp_smeg,0,2)/sqrt(5))
xlim([20 58])
hold on 
plot(zeros(1,256),'k')
for i=20:70
    p=signrank(fgp_smeg(i,:));
    if p<0.05
        disp(i)
    end
end

for i=1:7
    figure;plot(fgp_smeg(:,i))
    xlim([20 58])
    hold on 
    plot(zeros(1,256),'k')
end



fgp_total=cat(2,fgp_leg,fgp_smeg);
figure;errorbar(mean(fgp_total,2),std(fgp_total,0,2)/sqrt(size(fgp_total,2)))
xlim([20 58])
hold on 
plot(zeros(1,256),'k')
for i=20:70
    p=signrank(fgp_total(i,:));
    if p<0.05
        disp(i)
    end
end

time=43:53;
figure;bar([mean(mean(fgp_leg(time,:),1)),mean(mean(fgp_smeg(time,:),1))])
hold on
errorbar([mean(mean(fgp_leg(time,:),1)),mean(mean(fgp_smeg(time,:),1))],[std(mean(fgp_leg(time,:),1))/sqrt(6),std(mean(fgp_smeg(time,:),1))/sqrt(9)])
signrank(mean(fgp_leg(time,:),1))
signrank(mean(fgp_smeg(time,:),1))
ylim([0 1.5e-4])
time=32:42;
figure;bar([mean(mean(fgp_leg(time,:),1)),mean(mean(fgp_smeg(time,:),1))])
hold on
errorbar([mean(mean(fgp_leg(time,:),1)),mean(mean(fgp_smeg(time,:),1))],[std(mean(fgp_leg(time,:),1))/sqrt(6),std(mean(fgp_smeg(time,:),1))/sqrt(9)])
signrank(mean(fgp_leg(time,:),1))
signrank(mean(fgp_smeg(time,:),1))
ylim([0 1.5e-4])











