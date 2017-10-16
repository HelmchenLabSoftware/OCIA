%% plotting correlations for figure 5 contour integration


%% legolas

%fig 5 a lego

x=(20:10:1130)-240;
figure;errorbar(x,mean(diff_fg_leg(1:112,:),2),std(diff_fg_leg(1:112,:),0,2)/sqrt(size(diff_fg_leg,2)));
hold on
plot(x,zeros(1,112),'k')
xlim([-100 150])
ylim([-0.02 0.06])

for i=1:57
    p(i)=signrank(diff_fg_leg(i,:));
    if p(i)<0.05
        disp(x(i))
        %disp(p)
    end
end


%this is for figure 4, the bar plot
cc_circ_circ_leg=mean(diff_cccirc_circ_leg(30:33,:),1);
cc_bg_bg_leg=mean(diff_ccbg_bg_leg(34,:),1);
cc_circ_bg_leg=mean(diff_cccirc_bg_leg(30:34,:),1);

[h p]=ttest(cc_circ_circ_leg)
[h p]=ttest(cc_bg_bg_leg)
[h p]=ttest(cc_circ_bg_leg)

%% smeagol

ses1_smeg=[1:21 24:29 32:37];
ses2_smeg=[24 25 28:35];



x=(20:10:1130)-240;
figure;errorbar(x,mean(diff_fg_smeg(1:112,ses1_smeg),2),std(diff_fg_smeg(1:112,ses1_smeg),0,2)/sqrt(size(diff_fg_smeg(:,ses1_smeg),2)));
hold on
plot(x,zeros(1,112),'k')
xlim([-100 150])
ylim([-0.02 0.05])

for i=1:57
    p=signrank(diff_fg_smeg(i,ses1_smeg));
    if p<0.05
        disp(x(i))
        %disp(p)
    end
end


cc_circ_circ_smeg=mean(diff_cccirc_circ_smeg(27,ses1_smeg),1);
cc_bg_bg_smeg=mean(diff_ccbg_bg_smeg(30:31,ses1_smeg),1);
cc_circ_bg_smeg=mean(diff_cccirc_bg_smeg(27:28,ses1_smeg),1);

[h p]=ttest(cc_circ_circ_smeg)
[h p]=ttest(cc_bg_bg_smeg)
[h p]=ttest(cc_circ_bg_smeg)

% figure 4e

figure;bar([mean(cc_circ_circ_leg) mean(cc_bg_bg_leg) mean(cc_circ_bg_leg);mean(cc_circ_circ_smeg) mean(cc_bg_bg_smeg) mean(cc_circ_bg_smeg)]')
hold on
errorbar([mean(cc_circ_circ_smeg) mean(cc_bg_bg_smeg) mean(cc_circ_bg_smeg)],[std(cc_circ_circ_smeg) std(cc_bg_bg_smeg) std(cc_circ_bg_smeg)]/sqrt(size(cc_circ_circ_smeg,2)))
errorbar([mean(cc_circ_circ_leg) mean(cc_bg_bg_leg) mean(cc_circ_bg_leg)],[std(cc_circ_circ_leg) std(cc_bg_bg_leg) std(cc_circ_bg_leg)]/sqrt(size(cc_circ_circ_leg,2)))

% figure 5b
s1_leg=32:34;
s2_leg=42:45;
s1_smeg=27:29;
s2_smeg=42:45;
m=[mean(mean(diff_fg_leg(s1_leg,:))) mean(mean(diff_fg_leg(s2_leg,:)));mean(mean(diff_fg_smeg(s1_smeg,ses1_smeg))) mean(mean(diff_fg_smeg(s2_smeg,ses1_smeg)))];
s=[std(mean(diff_fg_leg(s1_leg,:),1),0,2)/sqrt(size(diff_fg_leg,2)) std(mean(diff_fg_leg(s2_leg,:),1),0,2)/sqrt(size(diff_fg_leg,2));std(mean(diff_fg_smeg(s1_smeg,ses1_smeg,:),1),0,2)/sqrt(size(diff_fg_smeg(:,ses1_smeg),2)) std(mean(diff_fg_smeg(s2_smeg,ses1_smeg),1),0,2)/sqrt(size(diff_fg_smeg(:,ses1_smeg),2))];

figure;bar(m')
hold on
errorbar(m',s')

[h p]=ttest(mean(diff_fg_leg(s1_leg,:),1))
[h p]=ttest(mean(diff_fg_leg(s2_leg,:),1))
[h p]=ttest(mean(diff_fg_smeg(s1_smeg,:),1))
[h p]=ttest(mean(diff_fg_smeg(s2_smeg,:),1))

%% late phase

%this is for figure 4, the bar plot
cc_circ_circ_leg2=mean(diff_cccirc_circ_leg(42:45,:),1);
cc_bg_bg_leg2=mean(diff_ccbg_bg_leg(42:45,:),1);
cc_circ_bg_leg2=mean(diff_cccirc_bg_leg(42:45,:),1);
cc_circ_circ_smeg2=mean(diff_cccirc_circ_smeg(42:45,ses1_smeg),1);
cc_bg_bg_smeg2=mean(diff_ccbg_bg_smeg(42:45,ses2_smeg),1);
cc_circ_bg_smeg2=mean(diff_cccirc_bg_smeg(42:45,ses1_smeg),1);

figure;bar([mean(cc_circ_circ_leg2) mean(cc_bg_bg_leg2) mean(cc_circ_bg_leg2);mean(cc_circ_circ_smeg2) mean(cc_bg_bg_smeg2) mean(cc_circ_bg_smeg2)]')
hold on
errorbar([mean(cc_circ_circ_smeg2) mean(cc_bg_bg_smeg2) mean(cc_circ_bg_smeg2)],[std(cc_circ_circ_smeg2) std(cc_bg_bg_smeg2) std(cc_circ_bg_smeg2)]/sqrt(size(cc_circ_circ_smeg2,2)))
errorbar([mean(cc_circ_circ_leg2) mean(cc_bg_bg_leg2) mean(cc_circ_bg_leg2)],[std(cc_circ_circ_leg2) std(cc_bg_bg_leg2) std(cc_circ_bg_leg2)]/sqrt(size(cc_circ_circ_leg2,2)))

[h p]=ttest(cc_circ_circ_leg2)
[h p]=ttest(cc_bg_bg_leg2)
[h p]=ttest(cc_circ_bg_leg2)
[h p]=ttest(cc_circ_circ_smeg2)
[h p]=ttest(cc_bg_bg_smeg2)
[h p]=ttest(cc_circ_bg_smeg2)


