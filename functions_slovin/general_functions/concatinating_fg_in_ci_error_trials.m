
cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\b\error_analysis
load fg_correct_and_error
ses=1;
fg_cont_ave(:,ses)=mean(fg_cont,2);
fg_non_ave(:,ses)=mean(fg_non,2);
if size(fg_error_cont,2)>5
    fg_cont_error_ave(:,ses)=mean(fg_error_cont,2);
else
    fg_cont_error_ave(:,ses)=nan;
end
if size(fg_error_non,2)>5
    fg_non_error_ave(:,ses)=mean(fg_error_non,2);
else
    fg_non_error_ave(:,ses)=nan;
end
clear fg_cont fg_non fg_error_cont fg_error_non

cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\c\error_analysis
load fg_correct_and_error
ses=2;
fg_cont_ave(:,ses)=mean(fg_cont,2);
fg_non_ave(:,ses)=mean(fg_non,2);
if size(fg_error_cont,2)>5
    fg_cont_error_ave(:,ses)=mean(fg_error_cont,2);
else
    fg_cont_error_ave(:,ses)=nan;
end
if size(fg_error_non,2)>5
    fg_non_error_ave(:,ses)=mean(fg_error_non,2);
else
    fg_non_error_ave(:,ses)=nan;
end
clear fg_cont fg_non fg_error_cont fg_error_non

cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\g\error_analysis
load fg_correct_and_error
ses=3;
fg_cont_ave(:,ses)=mean(fg_cont,2);
fg_non_ave(:,ses)=mean(fg_non,2);
if size(fg_error_cont,2)>5
    fg_cont_error_ave(:,ses)=mean(fg_error_cont,2);
else
    fg_cont_error_ave(:,ses)=nan;
end
if size(fg_error_non,2)>5
    fg_non_error_ave(:,ses)=mean(fg_error_non,2);
else
    fg_non_error_ave(:,ses)=nan;
end
clear fg_cont fg_non fg_error_cont fg_error_non

cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\b\error_analysis
load fg_correct_and_error
ses=4;
fg_cont_ave(:,ses)=mean(fg_cont,2);
fg_non_ave(:,ses)=mean(fg_non,2);
if size(fg_error_cont,2)>5
    fg_cont_error_ave(:,ses)=mean(fg_error_cont,2);
else
    fg_cont_error_ave(:,ses)=nan;
end
if size(fg_error_non,2)>5
    fg_non_error_ave(:,ses)=mean(fg_error_non,2);
else
    fg_non_error_ave(:,ses)=nan;
end
clear fg_cont fg_non fg_error_cont fg_error_non


cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\d\error_analysis
load fg_correct_and_error
ses=5;
fg_cont_ave(:,ses)=mean(fg_cont,2);
fg_non_ave(:,ses)=mean(fg_non,2);
if size(fg_error_cont,2)>5
    fg_cont_error_ave(:,ses)=mean(fg_error_cont,2);
else
    fg_cont_error_ave(:,ses)=nan;
end
if size(fg_error_non,2)>5
    fg_non_error_ave(:,ses)=mean(fg_error_non,2);
else
    fg_non_error_ave(:,ses)=nan;
end
clear fg_cont fg_non fg_error_cont fg_error_non


cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\f\error_analysis
load fg_correct_and_error
ses=6;
fg_cont_ave(:,ses)=mean(fg_cont,2);
fg_non_ave(:,ses)=mean(fg_non,2);
if size(fg_error_cont,2)>5
    fg_cont_error_ave(:,ses)=mean(fg_error_cont,2);
else
    fg_cont_error_ave(:,ses)=nan;
end
if size(fg_error_non,2)>5
    fg_non_error_ave(:,ses)=mean(fg_error_non,2);
else
    fg_non_error_ave(:,ses)=nan;
end
clear fg_cont fg_non fg_error_cont fg_error_non


cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\b\error_analysis
load fg_correct_and_error
ses=7;
fg_cont_ave(:,ses)=mean(fg_cont,2);
fg_non_ave(:,ses)=mean(fg_non,2);
if size(fg_error_cont,2)>5
    fg_cont_error_ave(:,ses)=mean(fg_error_cont,2);
else
    fg_cont_error_ave(:,ses)=nan;
end
if size(fg_error_non,2)>5
    fg_non_error_ave(:,ses)=mean(fg_error_non,2);
else
    fg_non_error_ave(:,ses)=nan;
end
clear fg_cont fg_non fg_error_cont fg_error_non


cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\c\error_analysis
load fg_correct_and_error
ses=8;
fg_cont_ave(:,ses)=mean(fg_cont,2);
fg_non_ave(:,ses)=mean(fg_non,2);
if size(fg_error_cont,2)>5
    fg_cont_error_ave(:,ses)=mean(fg_error_cont,2);
else
    fg_cont_error_ave(:,ses)=nan;
end
if size(fg_error_non,2)>5
    fg_non_error_ave(:,ses)=mean(fg_error_non,2);
else
    fg_non_error_ave(:,ses)=nan;
end
clear fg_cont fg_non fg_error_cont fg_error_non

cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\d\error_analysis
load fg_correct_and_error
ses=9;
fg_cont_ave(:,ses)=mean(fg_cont,2);
fg_non_ave(:,ses)=mean(fg_non,2);
if size(fg_error_cont,2)>5
    fg_cont_error_ave(:,ses)=mean(fg_error_cont,2);
else
    fg_cont_error_ave(:,ses)=nan;
end
if size(fg_error_non,2)>5
    fg_non_error_ave(:,ses)=mean(fg_error_non,2);
else
    fg_non_error_ave(:,ses)=nan;
end
clear fg_cont fg_non fg_error_cont fg_error_non

cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\e\error_analysis
load fg_correct_and_error
ses=10;
fg_cont_ave(:,ses)=mean(fg_cont,2);
fg_non_ave(:,ses)=mean(fg_non,2);
if size(fg_error_cont,2)>5
    fg_cont_error_ave(:,ses)=mean(fg_error_cont,2);
else
    fg_cont_error_ave(:,ses)=nan;
end
if size(fg_error_non,2)>5
    fg_non_error_ave(:,ses)=mean(fg_error_non,2);
else
    fg_non_error_ave(:,ses)=nan;
end
clear fg_cont fg_non fg_error_cont fg_error_non

cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\b\error_analysis
load fg_correct_and_error
ses=11;
fg_cont_ave(:,ses)=mean(fg_cont,2);
fg_non_ave(:,ses)=mean(fg_non,2);
if size(fg_error_cont,2)>5
    fg_cont_error_ave(:,ses)=mean(fg_error_cont,2);
else
    fg_cont_error_ave(:,ses)=nan;
end
if size(fg_error_non,2)>5
    fg_non_error_ave(:,ses)=mean(fg_error_non,2);
else
    fg_non_error_ave(:,ses)=nan;
end
clear fg_cont fg_non fg_error_cont fg_error_non

cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\c\error_analysis
load fg_correct_and_error
ses=12;
fg_cont_ave(:,ses)=mean(fg_cont,2);
fg_non_ave(:,ses)=mean(fg_non,2);
if size(fg_error_cont,2)>5
    fg_cont_error_ave(:,ses)=mean(fg_error_cont,2);
else
    fg_cont_error_ave(:,ses)=nan;
end
if size(fg_error_non,2)>5
    fg_non_error_ave(:,ses)=mean(fg_error_non,2);
else
    fg_non_error_ave(:,ses)=nan;
end
clear fg_cont fg_non fg_error_cont fg_error_non

cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\d\error_analysis
load fg_correct_and_error
ses=13;
fg_cont_ave(:,ses)=mean(fg_cont,2);
fg_non_ave(:,ses)=mean(fg_non,2);
if size(fg_error_cont,2)>5
    fg_cont_error_ave(:,ses)=mean(fg_error_cont,2);
else
    fg_cont_error_ave(:,ses)=nan;
end
if size(fg_error_non,2)>5
    fg_non_error_ave(:,ses)=mean(fg_error_non,2);
else
    fg_non_error_ave(:,ses)=nan;
end
clear fg_cont fg_non fg_error_cont fg_error_non

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\b\error_analysis
load fg_correct_and_error
ses=14;
fg_cont_ave(:,ses)=mean(fg_cont,2);
fg_non_ave(:,ses)=mean(fg_non,2);
if size(fg_error_cont,2)>5
    fg_cont_error_ave(:,ses)=mean(fg_error_cont,2);
else
    fg_cont_error_ave(:,ses)=nan;
end
if size(fg_error_non,2)>5
    fg_non_error_ave(:,ses)=mean(fg_error_non,2);
else
    fg_non_error_ave(:,ses)=nan;
end
clear fg_cont fg_non fg_error_cont fg_error_non


cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c\error_analysis
load fg_correct_and_error
ses=15;
fg_cont_ave(:,ses)=mean(fg_cont,2);
fg_non_ave(:,ses)=mean(fg_non,2);
if size(fg_error_cont,2)>5
    fg_cont_error_ave(:,ses)=mean(fg_error_cont,2);
else
    fg_cont_error_ave(:,ses)=nan;
end
if size(fg_error_non,2)>5
    fg_non_error_ave(:,ses)=mean(fg_error_non,2);
else
    fg_non_error_ave(:,ses)=nan;
end
clear fg_cont fg_non fg_error_cont fg_error_non


cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\d\error_analysis
load fg_correct_and_error
ses=16;
fg_cont_ave(:,ses)=mean(fg_cont,2);
fg_non_ave(:,ses)=mean(fg_non,2);
if size(fg_error_cont,2)>5
    fg_cont_error_ave(:,ses)=mean(fg_error_cont,2);
else
    fg_cont_error_ave(:,ses)=nan;
end
if size(fg_error_non,2)>5
    fg_non_error_ave(:,ses)=mean(fg_error_non,2);
else
    fg_non_error_ave(:,ses)=nan;
end
clear fg_cont fg_non fg_error_cont fg_error_non


cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\e\error_analysis
load fg_correct_and_error
ses=17;
fg_cont_ave(:,ses)=mean(fg_cont,2);
fg_non_ave(:,ses)=mean(fg_non,2);
if size(fg_error_cont,2)>5
    fg_cont_error_ave(:,ses)=mean(fg_error_cont,2);
else
    fg_cont_error_ave(:,ses)=nan;
end
if size(fg_error_non,2)>5
    fg_non_error_ave(:,ses)=mean(fg_error_non,2);
else
    fg_non_error_ave(:,ses)=nan;
end
clear fg_cont fg_non fg_error_cont fg_error_non


cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\k\error_analysis
load fg_correct_and_error
ses=18;
fg_cont_ave(:,ses)=mean(fg_cont,2);
fg_non_ave(:,ses)=mean(fg_non,2);
fg_cont_error_ave(:,ses)=nan;
if size(fg_error_non,2)>5
    fg_non_error_ave(:,ses)=mean(fg_error_non,2);
else
    fg_non_error_ave(:,ses)=nan;
end
clear fg_cont fg_non fg_error_cont fg_error_non


cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\b\error_analysis
load fg_correct_and_error
ses=19;
fg_cont_ave(:,ses)=mean(fg_cont,2);
fg_non_ave(:,ses)=mean(fg_non,2);
if size(fg_error_cont,2)>5
    fg_cont_error_ave(:,ses)=mean(fg_error_cont,2);
else
    fg_cont_error_ave(:,ses)=nan;
end
if size(fg_error_non,2)>5
    fg_non_error_ave(:,ses)=mean(fg_error_non,2);
else
    fg_non_error_ave(:,ses)=nan;
end
clear fg_cont fg_non fg_error_cont fg_error_non

cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\c\error_analysis
load fg_correct_and_error
ses=20;
fg_cont_ave(:,ses)=mean(fg_cont,2);
fg_non_ave(:,ses)=mean(fg_non,2);
if size(fg_error_cont,2)>5
    fg_cont_error_ave(:,ses)=mean(fg_error_cont,2);
else
    fg_cont_error_ave(:,ses)=nan;
end
if size(fg_error_non,2)>5
    fg_non_error_ave(:,ses)=mean(fg_error_non,2);
else
    fg_non_error_ave(:,ses)=nan;
end
clear fg_cont fg_non fg_error_cont fg_error_non

cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\d\error_analysis
load fg_correct_and_error
ses=21;
fg_cont_ave(:,ses)=mean(fg_cont,2);
fg_non_ave(:,ses)=mean(fg_non,2);
if size(fg_error_cont,2)>5
    fg_cont_error_ave(:,ses)=mean(fg_error_cont,2);
else
    fg_cont_error_ave(:,ses)=nan;
end
if size(fg_error_non,2)>5
    fg_non_error_ave(:,ses)=mean(fg_error_non,2);
else
    fg_non_error_ave(:,ses)=nan;
end
clear fg_cont fg_non fg_error_cont fg_error_non

cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\e\error_analysis
load fg_correct_and_error
ses=22;
fg_cont_ave(:,ses)=mean(fg_cont,2);
fg_non_ave(:,ses)=mean(fg_non,2);
if size(fg_error_cont,2)>5
    fg_cont_error_ave(:,ses)=mean(fg_error_cont,2);
else
    fg_cont_error_ave(:,ses)=nan;
end
if size(fg_error_non,2)>5
    fg_non_error_ave(:,ses)=mean(fg_error_non,2);
else
    fg_non_error_ave(:,ses)=nan;
end
clear fg_cont fg_non fg_error_cont fg_error_non





%%
ttt=1:22;
x=(10:10:2560)-280;
figure;errorbar(x(18:68),mean(fg_cont_ave(18:68,ttt),2),std(fg_cont_ave(18:68,ttt),0,2)/sqrt(size(fg_cont_ave,2)))
hold on
errorbar(x(18:68),nanmean(fg_cont_error_ave(18:68,ttt),2),nanstd(fg_cont_error_ave(18:68,ttt),0,2)/sqrt(size(fg_cont_error_ave,2)),'r')
xlim([-100 300])
fg_cont_diff=fg_cont_ave-fg_cont_error_ave;
figure;errorbar(x(18:68),nanmean(fg_cont_diff(18:68,ttt),2),nanstd(fg_cont_diff(18:68,ttt),0,2)/sqrt(size(fg_cont_diff,2)))
xlim([-100 300])



MI_reg=fg_cont_ave-fg_non_ave;
MI_error=fg_non_error_ave-fg_non_ave;
MI_error2=fg_cont_ave-fg_non_error_ave;
MI_error3=fg_cont_error_ave-fg_non_ave;
MI_error4=fg_cont_error_ave-fg_non_error_ave;

figure;errorbar(x(18:68),mean(MI_reg(18:68,ttt),2),std(MI_reg(18:68,ttt),0,2)/sqrt(size(MI_reg,2)))
hold on
errorbar(x(18:68),mean(MI_error(18:68,ttt),2),std(MI_error(18:68,ttt),0,2)/sqrt(size(MI_error,2)),'r')
xlim([-100 300])

figure;errorbar(x(18:68),mean(MI_reg(18:68,ttt),2),std(MI_reg(18:68,ttt),0,2)/sqrt(size(MI_reg,2)))
hold on
errorbar(x(18:68),mean(MI_error2(18:68,ttt),2),std(MI_error2(18:68,ttt),0,2)/sqrt(size(MI_error2,2)),'r')
xlim([-100 300])

figure;errorbar(x(18:68),mean(MI_reg(18:68,ttt),2),std(MI_reg(18:68,ttt),0,2)/sqrt(size(MI_reg,2)))
hold on
errorbar(x(18:68),nanmean(MI_error3(18:68,ttt),2),nanstd(MI_error3(18:68,ttt),0,2)/sqrt(size(MI_error3,2)),'r')
xlim([-100 300])

figure;errorbar(x(18:68),mean(MI_reg(18:68,ttt),2),std(MI_reg(18:68,ttt),0,2)/sqrt(size(MI_reg,2)))
hold on
errorbar(x(18:68),nanmean(MI_error4(18:68,ttt),2),nanstd(MI_error4(18:68,ttt),0,2)/sqrt(size(MI_error4,2)),'r')
xlim([-100 300])

MI_diff=MI_reg-MI_error4;
figure;errorbar(x(18:68),nanmean(MI_diff(18:68,ttt),2),nanstd(MI_diff(18:68,ttt),0,2)/sqrt(size(MI_diff,2)))
hold on
plot(x(18:68),zeros(1,51),'k')
xlim([-100 400])

t=nanmean(MI_error3(51:57,ttt),1);
t(isnan(t))=[];
ranksum(mean(MI_reg(51:57,ttt),1),t)

t=nanmean(MI_reg(51:57,ttt)-MI_error3(51:57,ttt),1);
t(isnan(t))=[];
signrank(t)




