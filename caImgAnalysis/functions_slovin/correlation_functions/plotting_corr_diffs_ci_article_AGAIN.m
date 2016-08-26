%% plotting correlations for figure 5 contour integration


%% legolas

%fig 5 a lego

x=(20:10:1130)-240;
figure;errorbar(x,abs(mean(diff_fg_leg,2)),std(diff_fg_leg,0,2)/sqrt(size(diff_fg_leg,2)));
hold on
plot(x,zeros(1,112),'k')
xlim([-100 250])

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

signrank(cc_circ_circ_leg)
signrank(cc_bg_bg_leg)
signrank(cc_circ_bg_leg)

%% smeagol

ses1_smeg=[1:21 24:29 32:37];
ses2_smeg=[24 25 28:35];



x=(20:10:1130)-240;
figure;errorbar(x,abs(mean(diff_fg_smeg(:,ses1_smeg),2)),std(diff_fg_smeg(:,ses1_smeg),0,2)/sqrt(size(diff_fg_smeg(:,ses1_smeg),2)));
hold on
plot(x,zeros(1,112),'k')
xlim([-100 250])


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

signrank(cc_circ_circ_smeg)
signrank(cc_bg_bg_smeg)
signrank(cc_circ_bg_smeg)

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
m=[abs(mean(mean(diff_fg_leg(s1_leg,:)))) abs(mean(mean(diff_fg_leg(s2_leg,:))));abs(mean(mean(diff_fg_smeg(s1_smeg,ses1_smeg)))) abs(mean(mean(diff_fg_smeg(s2_smeg,ses1_smeg))))];
s=[std(mean(diff_fg_leg(s1_leg,:),1),0,2)/sqrt(size(diff_fg_leg,2)) std(mean(diff_fg_leg(s2_leg,:),1),0,2)/sqrt(size(diff_fg_leg,2));std(mean(diff_fg_smeg(s1_smeg,ses1_smeg,:),1),0,2)/sqrt(size(diff_fg_smeg(:,ses1_smeg),2)) std(mean(diff_fg_smeg(s2_smeg,ses1_smeg),1),0,2)/sqrt(size(diff_fg_smeg(:,ses1_smeg),2))];

figure;bar(m')
hold on
errorbar(m',s')












