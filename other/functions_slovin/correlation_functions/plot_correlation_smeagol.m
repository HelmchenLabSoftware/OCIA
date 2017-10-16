%% correlations


figure;errorbar(mean(cont_cccirc_circle,2),std(cont_cccirc_circle,0,2)/sqrt(size(cont_cccirc_circle,2)));
hold on
errorbar(mean(non_cccirc_circle,2),std(non_cccirc_circle,0,2)/sqrt(size(non_cccirc_circle,2)),'r');


figure;errorbar(mean(cont_ccbg_bg,2),std(cont_ccbg_bg,0,2)/sqrt(size(cont_ccbg_bg,2)));
hold on
errorbar(mean(non_ccbg_bg,2),std(non_ccbg_bg,0,2)/sqrt(size(non_ccbg_bg,2)),'r');



diff_circ=cont_cccirc_circle-non_cccirc_circle;
diff_bg=cont_ccbg_bg-non_ccbg_bg;
diff_circ_bg=cont_cccirc_bg-non_cccirc_bg;




x=(20:10:1130)-240;
figure;errorbar(x,mean(diff_circ(:,[24:37]),2),std(diff_circ(:,[24:37]),0,2)/sqrt(size(diff_circ(:,[24:37]),2)));
hold on
errorbar(x,mean(diff_bg(:,[24 25 28:35]),2),std(diff_bg(:,[24 25 28:35]),0,2)/sqrt(size(diff_bg(:,[24 25 28:35]),2)),'r');
%errorbar(x,mean(diff_circ_bg(:,:),2),std(diff_circ_bg(:,:),0,2)/sqrt(size(diff_circ_bg(:,:),2)),'g');
plot(x,zeros(1,112),'k')
xlim([-100 250])



diff=diff_circ-diff_bg;
x=(20:10:1130)-240;
figure;errorbar(x,abs(mean(diff,2)),std(diff,0,2)/sqrt(size(diff,2)));
hold on
plot(x,zeros(1,112),'k')
xlim([-100 250])

for i=1:112
    p1(i)=signrank(diff_circ(i,:));
    p2(i)=signrank(diff_bg(i,[24 25 28:35]));
    p3(i)=signrank(diff(i,:));
end    

x(p1<0.05)
x(p2<0.05)
x(p3<0.05)


for i=1:37
    figure;plot(x,diff_circ(:,i))
    hold on
    plot(x,diff_bg(:,i),'r')
    plot(x,zeros(1,112),'k')
    xlim([-100 250])
end

x=(20:10:1130)-240;
figure;errorbar(x,mean(cc_circ_circ,2),std(cc_circ_circ,0,2)/sqrt(size(cc_circ_circ,2)));
hold on
errorbar(x,mean(cc_bg_bg,2),std(cc_bg_bg,0,2)/sqrt(size(cc_bg_bg,2)),'r');
plot(x,zeros(1,112),'k')
xlim([-100 250])

diff=cc_circ_circ-cc_bg_bg;
x=(20:10:1130)-240;
figure;errorbar(x,abs(mean(diff,2)),std(diff,0,2)/sqrt(size(diff,2)));
hold on
plot(x,zeros(1,112),'k')
xlim([-100 250])
ranksum(mean(diff_circ(s2,:),1),mean(diff_bg(s2,[24 25 28:35]),1))



%% stages
s1=26:27;
s2=42:45;


m1=[mean(mean(diff_circ(s1,[1:21 24:37]))) mean(mean(diff_bg(s1,[24 25 28:35]))) mean(mean(diff_circ_bg(s1,:)))];
sd1=[std(mean(diff_circ(s1,[1:21 24:37]),1),0,2)/sqrt(size(diff_circ,2)) std(mean(diff_bg(s1,[24 25 28:35]),1),0,2)/sqrt(size(diff_bg(s1,[24 25 28:35]),2)) std(mean(diff_circ_bg(s1,:),1),0,2)/sqrt(size(diff_circ_bg,2))];

figure;bar(m1)
hold on
errorbar(m1,sd1)

signrank(mean(diff_circ(s1,[1:21 24:37]),1))
signrank(mean(diff_bg(s1,[24 25 28:35]),1))
signrank(mean(diff_circ_bg(s1,:),1))
ranksum(mean(diff_circ(s1,:),1),mean(diff_bg(s1,[24 25 28:35]),1))
ranksum(mean(diff_circ(s1,:),1),mean(diff_circ_bg(s1,:),1))
ranksum(mean(diff_circ_bg(s1,:),1),mean(diff_bg(s1,[24 25 28:35]),1))


m2=[mean(mean(diff_circ(s2,:))) mean(mean(diff_bg(s2,[24 25 28:35]))) mean(mean(diff_circ_bg(s2,:)))];
sd2=[std(mean(diff_circ(s2,:),1),0,2)/sqrt(size(diff_circ,2)) std(mean(diff_bg(s2,[24 25 28:35]),1),0,2)/sqrt(size(diff_bg(s2,[24 25 28:35]),2)) std(mean(diff_circ_bg(s2,:),1),0,2)/sqrt(size(diff_circ_bg,2))];

figure;bar(m2)
hold on
errorbar(m2,sd2)

signrank(mean(diff_circ(s2,:),1))
signrank(mean(diff_bg(s2,[24 25 28:35]),1))
signrank(mean(diff_circ_bg(s2,:),1))
ranksum(mean(diff_circ(s2,:),1),mean(diff_bg(s2,[24 25 28:35]),1))
ranksum(mean(diff_circ(s2,:),1),mean(diff_circ_bg(s2,:),1))
ranksum(mean(diff_circ_bg(s2,:),1),mean(diff_bg(s2,[24 25 28:35]),1))




m_smeg=[abs(mean(mean(diff(s1,:)))) abs(mean(mean(diff(s2,:))))];
s_smeg=[std(mean(diff(s1,:),1),0,2)/sqrt(size(diff,2)) std(mean(diff(s2,:),1),0,2)/sqrt(size(diff,2))];
figure;bar(m_smeg)
hold on
errorbar(m_smeg,s_smeg)

signrank(mean(diff(s1,:),1))
signrank(mean(diff(s2,:),1))


fg1=cat(1,m_smeg,m_leg);
fgs1=cat(1,s_smeg,s_leg);

figure;bar(fg1')
hold on
errorbar(fg1',fgs1')


m_leg=[abs(mean(mean(diff(s1,:)))) abs(mean(mean(diff(s2,:))))];
s_leg=[std(mean(diff(s1,:),1),0,2)/sqrt(size(diff,2)) std(mean(diff(s2,:),1),0,2)/sqrt(size(diff,2))];
figure;bar(m_leg)
hold on
errorbar(m_leg,s_leg)

signrank(mean(diff(s1,:),1))
signrank(mean(diff(s2,:),1))





s1=31:34;
s2=42:45;


m1l=[mean(mean(cc_circ_circ(s1,:))) mean(mean(cc_bg_bg(s1,:))) mean(mean(cc_circ_bg(s1,:)))];
sd1l=[std(mean(cc_circ_circ(s1,:),1),0,2)/sqrt(size(cc_circ_circ,2)) std(mean(cc_bg_bg(s1,:),1),0,2)/sqrt(size(cc_bg_bg,2)) std(mean(cc_circ_bg(s1,:),1),0,2)/sqrt(size(cc_circ_bg,2))];

figure;bar(m1l)
hold on
errorbar(m1l,sd1l)

signrank(mean(cc_circ_circ(s1,:),1))
signrank(mean(cc_bg_bg(s1,:),1))
signrank(mean(cc_circ_bg(s1,:),1))
ranksum(mean(cc_circ_circ(s1,:),1),mean(cc_bg_bg(s1,:),1))


m2l=[mean(mean(cc_circ_circ(s2,:))) mean(mean(cc_bg_bg(s2,:))) mean(mean(cc_circ_bg(s2,:)))];
sd2l=[std(mean(cc_circ_circ(s2,:),1),0,2)/sqrt(size(cc_circ_circ,2)) std(mean(cc_bg_bg(s2,:),1),0,2)/sqrt(size(cc_bg_bg,2)) std(mean(cc_circ_bg(s2,:),1),0,2)/sqrt(size(cc_circ_bg,2))];

figure;bar(m2l)
hold on
errorbar(m2l,sd2l)

signrank(mean(cc_circ_circ(s2,:),1))
signrank(mean(cc_bg_bg(s2,:),1))
signrank(mean(cc_circ_bg(s2,:),1))
ranksum(mean(cc_circ_circ(s2,:),1),mean(cc_bg_bg(s2,:),1))

%both
m1_both=cat(1,m1,m1l);
sd1_both=cat(1,sd1,sd1l);
figure;bar(m1_both')
hold on
errorbar(m1_both',sd1_both')


m2_both=cat(1,m2,m2l);
sd2_both=cat(1,sd2,sd2l);
figure;bar(m2_both')
hold on
errorbar(m2_both',sd2_both')



%%


figure;errorbar(x,mean(c1_0501c_cccirc_circle,2),std(c1_0501c_cccirc_circle,0,2)/sqrt(size(c1_0501c_cccirc_circle,2)))
hold on
errorbar(x,mean(c5_0501c_cccirc_circle,2),std(c5_0501c_cccirc_circle,0,2)/sqrt(size(c5_0501c_cccirc_circle,2)),'r')
plot(x,zeros(1,112),'k')
xlim([-100 250])


figure;errorbar(x,mean(c1_0501c_cccirc_circle-c5_0501c_cccirc_circle,2),std(c1_0501c_cccirc_circle-c5_0501c_cccirc_circle,0,2)/sqrt(size(c1_0501c_cccirc_circle,2)))
hold on
plot(x,zeros(1,112),'k')
xlim([-100 250])




figure;plot(x,mean(c1_0501c_cccirc_circle,2))
hold on
plot(x,mean(c2_0501c_cccirc_circle,2),'c')
plot(x,mean(c4_0501c_cccirc_circle,2),'m')
plot(x,mean(c5_0501c_cccirc_circle,2),'r')
plot(x,zeros(1,112),'k')
xlim([-100 250])


figure;plot(x,mean(c1_0501d_cccirc_circle,2))
hold on
plot(x,mean(c2_0501d_cccirc_circle,2),'c')
plot(x,mean(c4_0501d_cccirc_circle,2),'m')
plot(x,mean(c5_0501d_cccirc_circle,2),'r')
plot(x,zeros(1,112),'k')
xlim([-100 250])






