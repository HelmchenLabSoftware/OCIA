
%legolas


x=(20:10:1120)-280;
figure;errorbar(x,nanmean(diff_circ_diff(:,:),2),nanstd(diff_circ_diff(:,:),0,2)/sqrt(size(diff_circ_diff(:,:),2)));
hold on
errorbar(x,nanmean(diff_bg_in(:,:),2),nanstd(diff_bg_in(:,:),0,2)/sqrt(size(diff_bg_in(:,:),2)),'r');
%errorbar(x,nanmean(diff_bg_out(:,:),2),nanstd(diff_bg_out(:,:),0,2)/sqrt(size(diff_bg_in(:,:),2)),'g');
plot(x,zeros(1,111),'k')
xlim([-100 300])



%smeagol

x=(20:10:1120)-280;
figure;errorbar(x,mean(diff_circ_out,2),std(diff_circ_out,0,2)/sqrt(size(diff_circ_out,2)));
hold on
errorbar(x,mean(diff_bg_out,2),std(diff_bg_out,0,2)/sqrt(size(diff_bg_out,2)),'r');
plot(x,zeros(1,111),'k')
xlim([-100 300])

% figure ground both monkeys
x=(20:10:1120)-280;
figure;errorbar(x,nanmean(fg_leg,2),nanstd(fg_leg,0,2)/sqrt(size(fg_leg,2)));
hold on
errorbar(x,nanmean(fg_smeg,2),nanstd(fg_smeg,0,2)/sqrt(size(fg_smeg,2)),'r');
plot(x,zeros(1,111),'k')
xlim([-100 300])


%fg in stages
s1s=mean(fg_smeg(31:41,:),1);
s2s=mean(fg_smeg(42:52,:),1);
s1l=mean(fg_leg(31:41,:),1);
s2l=mean(fg_leg(42:52,:),1);


leg=[s1l;s2l];
smeg=[s1s;s2s];

figure;bar([mean(s1s);mean(s2s)])
hold on
errorbar(mean(smeg,2),std(smeg,0,2)/sqrt(size(smeg,2)))

figure;bar([mean(s1l);mean(s2l)])
hold on
errorbar(mean(leg,2),std(leg,0,2)/sqrt(size(leg,2)))


% amp diffs in stages

s1sb=mean(diff_bg_out(31:41,:),1);
s2sb=mean(diff_bg_out(42:52,:),1);
s1sc=mean(diff_circ_out(31:41,:),1);
s2sc=mean(diff_circ_out(42:52,:),1);

s1lb=mean(diff_bg_in(31:41,:),1);
s2lb=mean(diff_bg_in(42:52,:),1);
s1lc=mean(diff_circ_diff(31:41,:),1);
s2lc=mean(diff_circ_diff(42:52,:),1);


figure;bar([mean(s1sc);mean(s1sb);mean(s2sc);mean(s2sb)])

figure;bar([mean(s1lc);mean(s1lb);mean(s2lc);mean(s2lb)])


ranksum(s2sb,s2lb)
ranksum(s2sc,s2lc)
ranksum(s2s,s2l)















