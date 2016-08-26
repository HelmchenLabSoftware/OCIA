%% plotting correlations for figure 5 contour integration


%% legolas

%fig 5 a lego
x=(20:10:1130)-240;
figure;errorbar(x,mean(diff_cccircdiff_circdiff,2),std(diff_cccircdiff_circdiff,0,2)/sqrt(size(diff_cccircdiff_circdiff,2)));
hold on
errorbar(x,mean(diff_ccbg_bg,2),std(diff_ccbg_bg,0,2)/sqrt(size(diff_ccbg_bg,2)),'r');
plot(x,zeros(1,112),'k')
xlim([-100 250])

for i=1:57
    p=signrank(diff_cccircdiff_circdiff(i,:));
    if p<0.05
        disp(x(i))
        disp(p)
    end
end

for i=1:57
    p=signrank(diff_ccbg_bg(i,:));
    if p<0.05
        disp(x(i))
        disp(p)
    end
end

diff_fg=diff_cccircdiff_circdiff-diff_ccbg_bg;
x=(20:10:1130)-240;
figure;errorbar(x,abs(mean(diff_fg,2)),std(diff_fg,0,2)/sqrt(size(diff_fg,2)));
hold on
plot(x,zeros(1,112),'k')
xlim([-100 250])

for i=1:57
    p(i)=signrank(diff_fg(i,:));
    if p<0.05
        disp(x(i))
        disp(p)
    end
end


%this is for figure 4, the bar plot
cc_circ_circ=mean(diff_cccircdiff_circdiff(30:33,:),1);
cc_bg_bg=mean(diff_ccbg_bg(34,:),1);
cc_circ_bg=mean(diff_cccircdiff_bg(30:34,:),1);
figure;bar([mean(cc_circ_circ) mean(cc_bg_bg) mean(cc_circ_bg)])
hold on
errorbar([mean(cc_circ_circ2) mean(cc_bg_bg2) mean(cc_circ_bg2)],[std(cc_circ_circ2) std(cc_bg_bg2) std(cc_circ_bg2)]/sqrt(size(cc_circ_circ2,2)))

signrank(cc_circ_circ)
signrank(cc_bg_bg)
signrank(cc_circ_bg)

%% smeagol
ses1=1:37;
ses1=[1:21 24:29 32:37];
ses2=[24 25 28:35];

x=(20:10:1130)-240;
figure;errorbar(x,mean(diff_circ(:,ses1),2),std(diff_circ(:,ses1),0,2)/sqrt(size(diff_circ(:,ses1),2)));
hold on
errorbar(x,mean(diff_bg(:,ses1),2),std(diff_bg(:,ses1),0,2)/sqrt(size(diff_bg(:,ses1),2)),'r');
errorbar(x,mean(diff_circ_bg(:,:),2),std(diff_circ_bg(:,:),0,2)/sqrt(size(diff_circ_bg(:,:),2)),'g');
plot(x,zeros(1,112),'k')
xlim([-100 250])



for i=1:57
    p=signrank(diff_circ(i,ses1));
    if p<0.05
        disp(x(i))
        disp(p)
    end
end


for i=1:57
    p=signrank(diff_bg(i,ses1));
    if p<0.05
        disp(x(i))
        disp(p)
    end
end


s1=27:29;
s2=42:45;

p=signrank(mean(diff_circ(s1,ses1),1))
p=signrank(mean(diff_circ(s2,ses1),1))
p=signrank(mean(diff_bg(s1,ses1),1))
p=signrank(mean(diff_bg(s2,ses1),1))

mean(mean(diff_circ(s1,ses1),1))
mean(mean(diff_circ(s2,ses1),1))
std(mean(diff_circ(s1,ses1),1))



diff_fg=diff_circ-diff_bg;
x=(20:10:1130)-240;
figure;errorbar(x,abs(mean(diff_fg(:,ses1),2)),std(diff_fg(:,ses1),0,2)/sqrt(size(diff_fg(:,ses1),2)));
hold on
plot(x,zeros(1,112),'k')
xlim([-100 250])


for i=1:57
    p=signrank(diff_fg(i,:));
    if p<0.05
        disp(x(i))
        disp(p)
    end
end

p=signrank(mean(diff_fg(s1,:),1))
p=signrank(mean(diff_fg(s2,:),1))
mean(mean(diff_fg(s1,:),1))
mean(mean(diff_fg(s2,:),1))
std(mean(diff_fg(s1,:),1))/sqrt(size(diff_fg,2))
std(mean(diff_fg(s2,:),1))/sqrt(size(diff_fg,2))




%this is for figure 4, the bar plot
cc_circ_circ2=mean(diff_circ(27,ses1),1);
cc_bg_bg2=mean(diff_bg(30:31,ses2),1);
cc_circ_bg2=mean(diff_circ_bg(27:28,:),1);
figure;bar([mean(cc_circ_circ2) mean(cc_bg_bg2) mean(cc_circ_bg2)])
hold on
errorbar([mean(cc_circ_circ2) mean(cc_bg_bg2) mean(cc_circ_bg2)],[std(cc_circ_circ2) std(cc_bg_bg2) std(cc_circ_bg2)]/sqrt(size(cc_circ_circ2,2)))

signrank(cc_circ_circ2)
signrank(cc_bg_bg2)
signrank(cc_circ_bg2)



% figure 4e



figure;bar([mean(cc_circ_circ) mean(cc_bg_bg) mean(cc_circ_bg);mean(cc_circ_circ2) mean(cc_bg_bg2) mean(cc_circ_bg2)]')
hold on
errorbar([mean(cc_circ_circ2) mean(cc_bg_bg2) mean(cc_circ_bg2)],[std(cc_circ_circ2) std(cc_bg_bg2) std(cc_circ_bg2)]/sqrt(size(cc_circ_circ2,2)))
errorbar([mean(cc_circ_circ) mean(cc_bg_bg) mean(cc_circ_bg)],[std(cc_circ_circ) std(cc_bg_bg) std(cc_circ_bg)]/sqrt(size(cc_circ_circ,2)))








