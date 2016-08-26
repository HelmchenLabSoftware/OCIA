%% LEGOLAS
nt=4;
% 1111

%c
c1=find(sum(~isnan(circ_cont_1111c1)')<nt,1,'first');
c2=find(sum(~isnan(circ_cont_1111c2)')<nt,1,'first');
c4=find(sum(~isnan(circ_cont_1111c4)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_1111c5)')<nt,1,'first');
lim14=min([c1 c4]);
lim25=min([c2 c5]);

fg_1111c14=nanmean(circ_cont_1111c1-bg_cont_1111c1,2)-nanmean(circ_cont_1111c4-bg_cont_1111c4,2);
fg_1111c14(lim14:end)=nan;
fg_1111c25=nanmean(circ_cont_1111c2-bg_cont_1111c2,2)-nanmean(circ_cont_1111c5-bg_cont_1111c5,2);
fg_1111c25(lim25:end)=nan;


%d
c1=find(sum(~isnan(circ_cont_1111d1)')<nt,1,'first');
c2=find(sum(~isnan(circ_cont_1111d2)')<nt,1,'first');
c4=find(sum(~isnan(circ_cont_1111d4)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_1111d5)')<nt,1,'first');
lim14=min([c1 c4]);
lim25=min([c2 c5]);

fg_1111d14=nanmean(circ_cont_1111d1-bg_cont_1111d1,2)-nanmean(circ_cont_1111d4-bg_cont_1111d4,2);
fg_1111d14(lim14:end)=nan;
fg_1111d25=nanmean(circ_cont_1111d2-bg_cont_1111d2,2)-nanmean(circ_cont_1111d5-bg_cont_1111d5,2);
fg_1111d25(lim25:end)=nan;

%h
c1=find(sum(~isnan(circ_cont_1111h1)')<nt,1,'first');
c2=find(sum(~isnan(circ_cont_1111h2)')<nt,1,'first');
c4=find(sum(~isnan(circ_cont_1111h4)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_1111h5)')<nt,1,'first');
lim14=min([c1 c4]);
lim25=min([c2 c5]);

fg_1111h14=nanmean(circ_cont_1111h1-bg_cont_1111h1,2)-nanmean(circ_cont_1111h4-bg_cont_1111h4,2);
fg_1111h14(lim14:end)=nan;
fg_1111h25=nanmean(circ_cont_1111h2-bg_cont_1111h2,2)-nanmean(circ_cont_1111h5-bg_cont_1111h5,2);
fg_1111h25(lim25:end)=nan;


% 1811

%c
c1=find(sum(~isnan(circ_cont_1811c1)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_1811c5)')<nt,1,'first');
lim15=min([c1 c5]);

fg_1811c15=nanmean(circ_cont_1811c1-bg_cont_1811c1,2)-nanmean(circ_cont_1811c5-bg_cont_1811c5,2);
fg_1811c15(lim15:end)=nan;


%d
c1=find(sum(~isnan(circ_cont_1811d1)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_1811d5)')<nt,1,'first');
lim15=min([c1 c5]);

fg_1811d15=nanmean(circ_cont_1811d1-bg_cont_1811d1,2)-nanmean(circ_cont_1811d5-bg_cont_1811d5,2);
fg_1811d15(lim15:end)=nan;


%e
c1=find(sum(~isnan(circ_cont_1811e1)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_1811e5)')<nt,1,'first');
lim15=min([c1 c5]);

fg_1811e15=nanmean(circ_cont_1811e1-bg_cont_1811e1,2)-nanmean(circ_cont_1811e5-bg_cont_1811e5,2);
fg_1811e15(lim15:end)=nan;



% 2511


%d
c1=find(sum(~isnan(circ_cont_2511d1)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_2511d5)')<nt,1,'first');
lim15=min([c1 c5]);

fg_2511d15=nanmean(circ_cont_2511d1-bg_cont_2511d1,2)-nanmean(circ_cont_2511d5-bg_cont_2511d5,2);
fg_2511d15(lim15:end)=nan;


%e
c1=find(sum(~isnan(circ_cont_2511e1)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_2511e5)')<nt,1,'first');
lim15=min([c1 c5]);

fg_2511e15=nanmean(circ_cont_2511e1-bg_cont_2511e1,2)-nanmean(circ_cont_2511e5-bg_cont_2511e5,2);
fg_2511e15(lim15:end)=nan;


%f
c1=find(sum(~isnan(circ_cont_2511f1)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_2511f5)')<nt,1,'first');
lim15=min([c1 c5]);

fg_2511f15=nanmean(circ_cont_2511f1-bg_cont_2511f1,2)-nanmean(circ_cont_2511f5-bg_cont_2511f5,2);
fg_2511f15(lim15:end)=nan;




% 1203


%d
c1=find(sum(~isnan(circ_cont_1203d1)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_1203d5)')<nt,1,'first');
lim15=min([c1 c5]);

fg_1203d15=nanmean(circ_cont_1203d1-bg_cont_1203d1,2)-nanmean(circ_cont_1203d5-bg_cont_1203d5,2);
fg_1203d15(lim15:end)=nan;


%e
c1=find(sum(~isnan(circ_cont_1203e1)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_1203e5)')<nt,1,'first');
lim15=min([c1 c5]);

fg_1203e15=nanmean(circ_cont_1203e1-bg_cont_1203e1,2)-nanmean(circ_cont_1203e5-bg_cont_1203e5,2);
fg_1203e15(lim15:end)=nan;


%f
c1=find(sum(~isnan(circ_cont_1203f1)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_1203f5)')<nt,1,'first');
lim15=min([c1 c5]);

fg_1203f15=nanmean(circ_cont_1203f1-bg_cont_1203f1,2)-nanmean(circ_cont_1203f5-bg_cont_1203f5,2);
fg_1203f15(lim15:end)=nan;


%

fg=cat(2,fg_1111c14,fg_1111c25,fg_1111d14,fg_1111d25,fg_1111h14,fg_1111h25 ...
    ,fg_1811c15,fg_1811d15,fg_1811e15,fg_2511d15,fg_2511e15,fg_2511f15 ...
    ,fg_1203d15,fg_1203e15,fg_1203f15);

for i=1:256
    n1(i)=sum(~isnan(fg(i,:)));
end
x=(10:10:2560)-280;
figure;errorbar(x(18:88),nanmean(fg(18:88,:),2),nanstd(fg(18:88,:),0,2)./sqrt(n1(18:88)'))
hold on
xlim([-100 400])
plot(x(18:138),zeros(size(x(18:138),2),1),'k')



%% SMEAGOL
nt=4;
% 1711

%b
c1=find(sum(~isnan(circ_cont_1711b1)')<nt,1,'first');
c2=find(sum(~isnan(circ_cont_1711b2)')<nt,1,'first');
c4=find(sum(~isnan(circ_cont_1711b4)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_1711b5)')<nt,1,'first');
lim14=min([c1 c4]);
lim25=min([c2 c5]);

fg_1711b14=nanmean(circ_cont_1711b1-bg_cont_1711b1,2)-nanmean(circ_cont_1711b4-bg_cont_1711b4,2);
fg_1711b14(lim14:end)=nan;
fg_1711b25=nanmean(circ_cont_1711b2-bg_cont_1711b2,2)-nanmean(circ_cont_1711b5-bg_cont_1711b5,2);
fg_1711b25(lim25:end)=nan;


%c
c1=find(sum(~isnan(circ_cont_1711c1)')<nt,1,'first');
c2=find(sum(~isnan(circ_cont_1711c2)')<nt,1,'first');
c4=find(sum(~isnan(circ_cont_1711c4)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_1711c5)')<nt,1,'first');
lim14=min([c1 c4]);
lim25=min([c2 c5]);

fg_1711c14=nanmean(circ_cont_1711c1-bg_cont_1711c1,2)-nanmean(circ_cont_1711c4-bg_cont_1711c4,2);
fg_1711c14(lim14:end)=nan;
fg_1711c25=nanmean(circ_cont_1711c2-bg_cont_1711c2,2)-nanmean(circ_cont_1711c5-bg_cont_1711c5,2);
fg_1711c25(lim25:end)=nan;


%g
c1=find(sum(~isnan(circ_cont_1711g1)')<nt,1,'first');
c2=find(sum(~isnan(circ_cont_1711g2)')<nt,1,'first');
c4=find(sum(~isnan(circ_cont_1711g4)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_1711g5)')<nt,1,'first');
lim14=min([c1 c4]);
lim25=min([c2 c5]);

fg_1711g14=nanmean(circ_cont_1711g1-bg_cont_1711g1,2)-nanmean(circ_cont_1711g4-bg_cont_1711g4,2);
fg_1711g14(lim14:end)=nan;
fg_1711g25=nanmean(circ_cont_1711g2-bg_cont_1711g2,2)-nanmean(circ_cont_1711g5-bg_cont_1711g5,2);
fg_1711g25(lim25:end)=nan;


% 2411

%b
c1=find(sum(~isnan(circ_cont_2411b1)')<nt,1,'first');
c2=find(sum(~isnan(circ_cont_2411b2)')<nt,1,'first');
c4=find(sum(~isnan(circ_cont_2411b4)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_2411b5)')<nt,1,'first');
lim14=min([c1 c4]);
lim25=min([c2 c5]);

fg_2411b14=nanmean(circ_cont_2411b1-bg_cont_2411b1,2)-nanmean(circ_cont_2411b4-bg_cont_2411b4,2);
fg_2411b14(lim14:end)=nan;
fg_2411b25=nanmean(circ_cont_2411b2-bg_cont_2411b2,2)-nanmean(circ_cont_2411b5-bg_cont_2411b5,2);
fg_2411b25(lim25:end)=nan;


%d
c1=find(sum(~isnan(circ_cont_2411d1)')<nt,1,'first');
c2=find(sum(~isnan(circ_cont_2411d2)')<nt,1,'first');
c4=find(sum(~isnan(circ_cont_2411d4)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_2411d5)')<nt,1,'first');
lim14=min([c1 c4]);
lim25=min([c2 c5]);

fg_2411d14=nanmean(circ_cont_2411d1-bg_cont_2411d1,2)-nanmean(circ_cont_2411d4-bg_cont_2411d4,2);
fg_2411d14(lim14:end)=nan;
fg_2411d25=nanmean(circ_cont_2411d2-bg_cont_2411d2,2)-nanmean(circ_cont_2411d5-bg_cont_2411d5,2);
fg_2411d25(lim25:end)=nan;

%f
c1=find(sum(~isnan(circ_cont_2411f1)')<nt,1,'first');
c2=find(sum(~isnan(circ_cont_2411f2)')<nt,1,'first');
c4=find(sum(~isnan(circ_cont_2411f4)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_2411f5)')<nt,1,'first');
lim14=min([c1 c4]);
lim25=min([c2 c5]);

fg_2411f14=nanmean(circ_cont_2411f1-bg_cont_2411f1,2)-nanmean(circ_cont_2411f4-bg_cont_2411f4,2);
fg_2411f14(lim14:end)=nan;
fg_2411f25=nanmean(circ_cont_2411f2-bg_cont_2411f2,2)-nanmean(circ_cont_2411f5-bg_cont_2411f5,2);
fg_2411f25(lim25:end)=nan;


% 1412

%b
c1=find(sum(~isnan(circ_cont_1412b1)')<nt,1,'first');
c2=find(sum(~isnan(circ_cont_1412b2)')<nt,1,'first');
c4=find(sum(~isnan(circ_cont_1412b4)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_1412b5)')<nt,1,'first');
lim14=min([c1 c4]);
lim25=min([c2 c5]);

fg_1412b14=nanmean(circ_cont_1412b1-bg_cont_1412b1,2)-nanmean(circ_cont_1412b4-bg_cont_1412b4,2);
fg_1412b14(lim14:end)=nan;
fg_1412b25=nanmean(circ_cont_1412b2-bg_cont_1412b2,2)-nanmean(circ_cont_1412b5-bg_cont_1412b5,2);
fg_1412b25(lim25:end)=nan;


%c
c1=find(sum(~isnan(circ_cont_1412c1)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_1412c5)')<nt,1,'first');
lim15=min([c1 c5]);

fg_1412c15=nanmean(circ_cont_1412c1-bg_cont_1412c1,2)-nanmean(circ_cont_1412c5-bg_cont_1412c5,2);
fg_1412c15(lim14:end)=nan;

%d
c1=find(sum(~isnan(circ_cont_1412d1)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_1412d5)')<nt,1,'first');
lim15=min([c1 c5]);

fg_1412d15=nanmean(circ_cont_1412d1-bg_cont_1412d1,2)-nanmean(circ_cont_1412d5-bg_cont_1412d5,2);
fg_1412d15(lim14:end)=nan;



% 2212

%b
c1=find(sum(~isnan(circ_cont_2212b1)')<nt,1,'first');
c2=find(sum(~isnan(circ_cont_2212b2)')<nt,1,'first');
c4=find(sum(~isnan(circ_cont_2212b4)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_2212b5)')<nt,1,'first');
lim14=min([c1 c4]);
lim25=min([c2 c5]);

fg_2212b14=nanmean(circ_cont_2212b1-bg_cont_2212b1,2)-nanmean(circ_cont_2212b4-bg_cont_2212b4,2);
fg_2212b14(lim14:end)=nan;
fg_2212b25=nanmean(circ_cont_2212b2-bg_cont_2212b2,2)-nanmean(circ_cont_2212b5-bg_cont_2212b5,2);
fg_2212b25(lim25:end)=nan;


%c
c1=find(sum(~isnan(circ_cont_2212c1)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_2212c5)')<nt,1,'first');
lim15=min([c1 c5]);

fg_2212c15=nanmean(circ_cont_2212c1-bg_cont_2212c1,2)-nanmean(circ_cont_2212c5-bg_cont_2212c5,2);
fg_2212c15(lim14:end)=nan;

%d
c1=find(sum(~isnan(circ_cont_2212d1)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_2212d5)')<nt,1,'first');
lim15=min([c1 c5]);

fg_2212d15=nanmean(circ_cont_2212d1-bg_cont_2212d1,2)-nanmean(circ_cont_2212d5-bg_cont_2212d5,2);
fg_2212d15(lim14:end)=nan;


% 2912

%b
c1=find(sum(~isnan(circ_cont_2912b1)')<nt,1,'first');
c2=find(sum(~isnan(circ_cont_2912b2)')<nt,1,'first');
c4=find(sum(~isnan(circ_cont_2912b4)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_2912b5)')<nt,1,'first');
lim14=min([c1 c4]);
lim25=min([c2 c5]);

fg_2912b14=nanmean(circ_cont_2912b1-bg_cont_2912b1,2)-nanmean(circ_cont_2912b4-bg_cont_2912b4,2);
fg_2912b14(lim14:end)=nan;
fg_2912b25=nanmean(circ_cont_2912b2-bg_cont_2912b2,2)-nanmean(circ_cont_2912b5-bg_cont_2912b5,2);
fg_2912b25(lim25:end)=nan;


%c
c1=find(sum(~isnan(circ_cont_2912c1)')<nt,1,'first');
c2=find(sum(~isnan(circ_cont_2912c2)')<nt,1,'first');
c4=find(sum(~isnan(circ_cont_2912c4)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_2912c5)')<nt,1,'first');
lim14=min([c1 c4]);
lim25=min([c2 c5]);

fg_2912c14=nanmean(circ_cont_2912c1-bg_cont_2912c1,2)-nanmean(circ_cont_2912c4-bg_cont_2912c4,2);
fg_2912c14(lim14:end)=nan;
fg_2912c25=nanmean(circ_cont_2912c2-bg_cont_2912c2,2)-nanmean(circ_cont_2912c5-bg_cont_2912c5,2);
fg_2912c25(lim25:end)=nan;



%d
c1=find(sum(~isnan(circ_cont_2912d1)')<nt,1,'first');
c2=find(sum(~isnan(circ_cont_2912d2)')<nt,1,'first');
c4=find(sum(~isnan(circ_cont_2912d4)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_2912d5)')<nt,1,'first');
lim14=min([c1 c4]);
lim25=min([c2 c5]);

fg_2912d14=nanmean(circ_cont_2912d1-bg_cont_2912d1,2)-nanmean(circ_cont_2912d4-bg_cont_2912d4,2);
fg_2912d14(lim14:end)=nan;
fg_2912d25=nanmean(circ_cont_2912d2-bg_cont_2912d2,2)-nanmean(circ_cont_2912d5-bg_cont_2912d5,2);
fg_2912d25(lim25:end)=nan;



%e
c1=find(sum(~isnan(circ_cont_2912e1)')<nt,1,'first');
c2=find(sum(~isnan(circ_cont_2912e2)')<nt,1,'first');
c4=find(sum(~isnan(circ_cont_2912e4)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_2912e5)')<nt,1,'first');
lim14=min([c1 c4]);
lim25=min([c2 c5]);

fg_2912e14=nanmean(circ_cont_2912e1-bg_cont_2912e1,2)-nanmean(circ_cont_2912e4-bg_cont_2912e4,2);
fg_2912e14(lim14:end)=nan;
fg_2912e25=nanmean(circ_cont_2912e2-bg_cont_2912e2,2)-nanmean(circ_cont_2912e5-bg_cont_2912e5,2);
fg_2912e25(lim25:end)=nan;



%k
c1=find(sum(~isnan(circ_cont_2912k1)')<nt,1,'first');
c2=find(sum(~isnan(circ_cont_2912k2)')<nt,1,'first');
c4=find(sum(~isnan(circ_cont_2912k4)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_2912k5)')<nt,1,'first');
lim14=min([c1 c4]);
lim25=min([c2 c5]);

fg_2912k14=nanmean(circ_cont_2912k1-bg_cont_2912k1,2)-nanmean(circ_cont_2912k4-bg_cont_2912k4,2);
fg_2912k14(lim14:end)=nan;
fg_2912k25=nanmean(circ_cont_2912k2-bg_cont_2912k2,2)-nanmean(circ_cont_2912k5-bg_cont_2912k5,2);
fg_2912k25(lim25:end)=nan;



% 0501

%b
c1=find(sum(~isnan(circ_cont_0501b1)')<nt,1,'first');
c2=find(sum(~isnan(circ_cont_0501b2)')<nt,1,'first');
c4=find(sum(~isnan(circ_cont_0501b4)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_0501b5)')<nt,1,'first');
lim14=min([c1 c4]);
lim25=min([c2 c5]);

fg_0501b14=nanmean(circ_cont_0501b1-bg_cont_0501b1,2)-nanmean(circ_cont_0501b4-bg_cont_0501b4,2);
fg_0501b14(lim14:end)=nan;
fg_0501b25=nanmean(circ_cont_0501b2-bg_cont_0501b2,2)-nanmean(circ_cont_0501b5-bg_cont_0501b5,2);
fg_0501b25(lim25:end)=nan;


%c
c1=find(sum(~isnan(circ_cont_0501c1)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_0501c5)')<nt,1,'first');
lim15=min([c1 c5]);

fg_0501c15=nanmean(circ_cont_0501c1-bg_cont_0501c1,2)-nanmean(circ_cont_0501c5-bg_cont_0501c5,2);
fg_0501c15(lim15:end)=nan;


%d
c1=find(sum(~isnan(circ_cont_0501d1)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_0501d5)')<nt,1,'first');
lim15=min([c1 c5]);

fg_0501d15=nanmean(circ_cont_0501d1-bg_cont_0501d1,2)-nanmean(circ_cont_0501d5-bg_cont_0501d5,2);
fg_0501d15(lim15:end)=nan;


%e
c1=find(sum(~isnan(circ_cont_0501e1)')<nt,1,'first');
c2=find(sum(~isnan(circ_cont_0501e2)')<nt,1,'first');
c4=find(sum(~isnan(circ_cont_0501e4)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_0501e5)')<nt,1,'first'); 
lim14=min([c1 c4]);
lim25=min([c2 c5]);

fg_0501e14=nanmean(circ_cont_0501e1-bg_cont_0501e1,2)-nanmean(circ_cont_0501e4-bg_cont_0501e4,2);
fg_0501e14(lim14:end)=nan;
fg_0501e25=nanmean(circ_cont_0501e2-bg_cont_0501e2,2)-nanmean(circ_cont_0501e5-bg_cont_0501e5,2);
fg_0501e25(lim25:end)=nan;



%

fg=cat(2,fg_1711b14,fg_1711b25,fg_1711c14,fg_1711c25,fg_1711g14,fg_1711g25 ...
    ,fg_2411b14,fg_2411b25,fg_2411d14,fg_2411d25,fg_2411f14,fg_2411f25 ...
    ,fg_1412b14,fg_1412b25,fg_1412c15,fg_1412d15,fg_2212b14,fg_2212b25 ...
    ,fg_2212c15,fg_2212d15,fg_2912b14,fg_2912b25,fg_2912c14,fg_2912c25 ...
    ,fg_2912d14,fg_2912d25,fg_2912e14,fg_2912e25,fg_2912k14,fg_2912k25 ...
    ,fg_0501b14,fg_0501b25,fg_0501c15,fg_0501d15,fg_0501e14,fg_0501e25);
% 
% fg=cat(2,fg_2912c14,fg_2912c25,fg_2912e14,fg_2912e25,fg_2912k14,fg_2912k25 ...
%     ,fg_0501b14,fg_0501b25,fg_0501c15,fg_0501d15);




for i=1:256
    n1(i)=sum(~isnan(fg(i,:)));
end

x=(10:10:2560)-280;
figure;errorbar(x(2:112),nanmean(fg(2:112,:),2),nanstd(fg(2:112,:),0,2)./sqrt(n1(2:112)'))
hold on
plot(x(2:112),zeros(size(x(2:112),2),1),'k')
xlim([-100 400])
ylim([-.5e-4 2e-4])





%% TOLKIN
nt=4;
% 0812

%c
c1=find(sum(~isnan(circ_cont_0812c1)')<nt,1,'first');
c2=find(sum(~isnan(circ_cont_0812c2)')<nt,1,'first');
c4=find(sum(~isnan(circ_cont_0812c4)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_0812c5)')<nt,1,'first');
lim14=min([c1 c4]);
lim25=min([c2 c5]);

fg_0812c14=nanmean(circ_cont_0812c1-bg_cont_0812c1,2)-nanmean(circ_cont_0812c4-bg_cont_0812c4,2);
fg_0812c14(lim14:end)=nan;
fg_0812c25=nanmean(circ_cont_0812c2-bg_cont_0812c2,2)-nanmean(circ_cont_0812c5-bg_cont_0812c5,2);
fg_0812c25(lim25:end)=nan;


%e
c1=find(sum(~isnan(circ_cont_0812e1)')<nt,1,'first');
c2=find(sum(~isnan(circ_cont_0812e2)')<nt,1,'first');
c4=find(sum(~isnan(circ_cont_0812e4)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_0812e5)')<nt,1,'first');
lim14=min([c1 c4]);
lim25=min([c2 c5]);

fg_0812e14=nanmean(circ_cont_0812e1-bg_cont_0812e1,2)-nanmean(circ_cont_0812e4-bg_cont_0812e4,2);
fg_0812e14(lim14:end)=nan;
fg_0812e25=nanmean(circ_cont_0812e2-bg_cont_0812e2,2)-nanmean(circ_cont_0812e5-bg_cont_0812e5,2);
fg_0812e25(lim25:end)=nan;




% 1512

%b
c1=find(sum(~isnan(circ_cont_1512b1)')<nt,1,'first');
c2=find(sum(~isnan(circ_cont_1512b2)')<nt,1,'first');
c4=find(sum(~isnan(circ_cont_1512b4)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_1512b5)')<nt,1,'first');
lim14=min([c1 c4]);
lim25=min([c2 c5]);

fg_1512b14=nanmean(circ_cont_1512b1-bg_cont_1512b1,2)-nanmean(circ_cont_1512b4-bg_cont_1512b4,2);
fg_1512b14(lim14:end)=nan;
fg_1512b25=nanmean(circ_cont_1512b2-bg_cont_1512b2,2)-nanmean(circ_cont_1512b5-bg_cont_1512b5,2);
fg_1512b25(lim25:end)=nan;


%c
c1=find(sum(~isnan(circ_cont_1512c1)')<nt,1,'first');
c2=find(sum(~isnan(circ_cont_1512c2)')<nt,1,'first');
c4=find(sum(~isnan(circ_cont_1512c4)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_1512c5)')<nt,1,'first');
lim14=min([c1 c4]);
lim25=min([c2 c5]);

fg_1512c14=nanmean(circ_cont_1512c1-bg_cont_1512c1,2)-nanmean(circ_cont_1512c4-bg_cont_1512c4,2);
fg_1512c14(lim14:end)=nan;
fg_1512c25=nanmean(circ_cont_1512c2-bg_cont_1512c2,2)-nanmean(circ_cont_1512c5-bg_cont_1512c5,2);
fg_1512c25(lim25:end)=nan;




% 2812

%b
c1=find(sum(~isnan(circ_cont_2812b1)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_2812b5)')<nt,1,'first');
lim15=min([c1 c5]);

fg_2812b15=nanmean(circ_cont_2812b1-bg_cont_2812b1,2)-nanmean(circ_cont_2812b5-bg_cont_2812b5,2);
fg_2812b15(lim15:end)=nan;


%c
c1=find(sum(~isnan(circ_cont_2812c1)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_2812c5)')<nt,1,'first');
lim15=min([c1 c5]);

fg_2812c15=nanmean(circ_cont_2812c1-bg_cont_2812c1,2)-nanmean(circ_cont_2812c5-bg_cont_2812c5,2);
fg_2812c15(lim15:end)=nan;


%d
c1=find(sum(~isnan(circ_cont_2812d1)')<nt,1,'first');
c5=find(sum(~isnan(circ_cont_2812d5)')<nt,1,'first');
lim15=min([c1 c5]);

fg_2812d15=nanmean(circ_cont_2812d1-bg_cont_2812d1,2)-nanmean(circ_cont_2812d5-bg_cont_2812d5,2);
fg_2812d15(lim15:end)=nan;



%
fg=cat(2,fg_0812c14,fg_0812c25,fg_0812e14,fg_0812e25,fg_1512b14 ...
    ,fg_1512b25,fg_1512c14,fg_1512c25,fg_2812b15,fg_2812c15,fg_2812d15);

for i=1:256
    n1(i)=sum(~isnan(fg(i,:)));
end

x=(10:10:2560)-280;
figure;errorbar(x(2:112),nanmean(fg(2:112,:),2),nanstd(fg(2:112,:),0,2)./sqrt(n1(2:112)'))
hold on
xlim([-100 500])
plot(x(2:112),zeros(size(x(2:112),2),1),'k')
ylim([-.5e-4 3e-4])





