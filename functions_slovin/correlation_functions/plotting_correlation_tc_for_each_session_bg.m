cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere
load cc_bg_bg_vs_circdiff_circdiff.mat

figure;
z=1;
for i=1:8
    subplot(8,3,z)
    plot(x,cont_ccbg_bg(:,i),'LineWidth',1)
    hold on
    plot(x,non_ccbg_bg(:,i),'Color','r','LineWidth',1)
    xlim([-50 300])
    %axis off
    
    z=z+3;
end

clear all
load signal_correlation_ave
z=2;
for i=1:8
    subplot(8,3,z)
    plot(x,cont_ccbg_bg(:,i),'LineWidth',1)
    hold on
    plot(x,non_ccbg_bg(:,i),'Color','r','LineWidth',1)
    xlim([-50 300])
    %axis off
    
    z=z+3;
end

clear all
load cc_bg_bg_vs_circdiff_circdiff_no_stim.mat
z=3;
for i=1:8
    subplot(8,3,z)
    plot(x,cont_ccbg_bg(1:112,i),'LineWidth',1)
    hold on
    plot(x,non_ccbg_bg(1:112,i),'Color','r','LineWidth',1)
    xlim([-50 300])
    %axis off
    
    z=z+3;
end

clear all
load cc_bg_bg_vs_circdiff_circdiff.mat
figure;
z=1;
for i=9:16
    subplot(8,3,z)
    plot(x,cont_ccbg_bg(:,i),'LineWidth',1)
    hold on
    plot(x,non_ccbg_bg(:,i),'Color','r','LineWidth',1)
    xlim([-50 300])
    %axis off
    
    z=z+3;
end

clear all
load signal_correlation_ave
z=2;
for i=9:16
    subplot(8,3,z)
    plot(x,cont_ccbg_bg(:,i),'LineWidth',1)
    hold on
    plot(x,non_ccbg_bg(:,i),'Color','r','LineWidth',1)
    xlim([-50 300])
    %axis off
    
    z=z+3;
end

clear all
load cc_bg_bg_vs_circdiff_circdiff_no_stim.mat
z=3;
for i=9:16
    subplot(8,3,z)
    plot(x,cont_ccbg_bg(1:112,i),'LineWidth',1)
    hold on
    plot(x,non_ccbg_bg(1:112,i),'Color','r','LineWidth',1)
    xlim([-50 300])
    %axis off
    
    z=z+3;
end




clear all
load cc_bg_bg_vs_circdiff_circdiff.mat
figure;
z=1;
for i=17:23
    subplot(7,3,z)
    plot(x,cont_ccbg_bg(:,i),'LineWidth',1)
    hold on
    plot(x,non_ccbg_bg(:,i),'Color','r','LineWidth',1)
    xlim([-50 300])
    %axis off
    
    z=z+3;
end

clear all
load signal_correlation_ave
z=2;
for i=17:23
    subplot(7,3,z)
    plot(x,cont_ccbg_bg(:,i),'LineWidth',1)
    hold on
    plot(x,non_ccbg_bg(:,i),'Color','r','LineWidth',1)
    xlim([-50 300])
    %axis off
    
    z=z+3;
end

clear all
load cc_bg_bg_vs_circdiff_circdiff_no_stim.mat
z=3;
for i=17:23
    subplot(7,3,z)
    plot(x,cont_ccbg_bg(1:112,i),'LineWidth',1)
    hold on
    plot(x,non_ccbg_bg(1:112,i),'Color','r','LineWidth',1)
    xlim([-50 300])
    %axis off
    
    z=z+3;
end


%% diff
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere
load cc_bg_bg_vs_circdiff_circdiff.mat

figure;
z=1;
for i=1:8
    subplot(8,3,z)
    plot(x,diff_ccbg_bg(:,i),'LineWidth',1)
    hold on
    xlim([-50 300])
    %axis off
    plot(x,zeros(1,112),'k')
    z=z+3;
end

clear all
load signal_correlation_ave
z=2;
for i=1:8
    subplot(8,3,z)
    plot(x,diff_ccbg_bg_leg(:,i),'LineWidth',1)
    hold on
    xlim([-50 300])
    %axis off
    plot(x,zeros(1,112),'k')
    z=z+3;
end

clear all
load cc_bg_bg_vs_circdiff_circdiff_no_stim.mat
z=3;
for i=1:8
    subplot(8,3,z)
    plot(x,diff_ccbg_bg(1:112,i),'LineWidth',1)
    hold on
    xlim([-50 300])
    %axis off
    plot(x,zeros(1,112),'k')
    z=z+3;
end

clear all
load cc_bg_bg_vs_circdiff_circdiff.mat
figure;
z=1;
for i=9:16
    subplot(8,3,z)
    plot(x,diff_ccbg_bg(:,i),'LineWidth',1)
    hold on
    xlim([-50 300])
    %axis off
    plot(x,zeros(1,112),'k')
    z=z+3;
end

clear all
load signal_correlation_ave
z=2;
for i=9:16
    subplot(8,3,z)
    plot(x,diff_ccbg_bg_leg(:,i),'LineWidth',1)
    hold on
    xlim([-50 300])
    %axis off
    plot(x,zeros(1,112),'k')
    z=z+3;
end

clear all
load cc_bg_bg_vs_circdiff_circdiff_no_stim.mat
z=3;
for i=9:16
    subplot(8,3,z)
    plot(x,diff_ccbg_bg(1:112,i),'LineWidth',1)
    hold on
    xlim([-50 300])
    %axis off
    plot(x,zeros(1,112),'k')
    z=z+3;
end




clear all
load cc_bg_bg_vs_circdiff_circdiff.mat
figure;
z=1;
for i=17:23
    subplot(7,3,z)
    plot(x,diff_ccbg_bg(:,i),'LineWidth',1)
    hold on
    xlim([-50 300])
    %axis off
    plot(x,zeros(1,112),'k')
    z=z+3;
end

clear all
load signal_correlation_ave
z=2;
for i=17:23
    subplot(7,3,z)
    plot(x,diff_ccbg_bg_leg(:,i),'LineWidth',1)
    hold on
    xlim([-50 300])
    %axis off
    plot(x,zeros(1,112),'k')
    z=z+3;
end

clear all
load cc_bg_bg_vs_circdiff_circdiff_no_stim.mat
z=3;
for i=17:23
    subplot(7,3,z)
    plot(x,diff_ccbg_bg(1:112,i),'LineWidth',1)
    hold on
    xlim([-50 300])
    %axis off
    plot(x,zeros(1,112),'k')
    z=z+3;
end

%% Smeagol

cd F:\Data\VSDI\Contour_integration\Smeagol
load correlations_rois_ave
figure;
z=1;
for i=1:8
    subplot(8,3,z)
    plot(x,cont_ccbg_bg(:,i),'LineWidth',1)
    hold on
    plot(x,non_ccbg_bg(:,i),'Color','r','LineWidth',1)
    xlim([-50 300])
    %axis off
    z=z+3;
end

clear all
load signal_correlation_ave.mat

z=2;
for i=1:8
    subplot(8,3,z)
    plot(x,cont_ccbg_bg(1:112,i),'LineWidth',1)
    hold on
    plot(x,non_ccbg_bg(1:112,i),'Color','r','LineWidth',1)
    xlim([-50 300])
    %axis off
    z=z+3;
end


clear all
load correlations_rois_ave_no_stim
z=3;
for i=1:8
    subplot(8,3,z)
    plot(x,cont_ccbg_bg(1:112,i),'LineWidth',1)
    hold on
    plot(x,non_ccbg_bg(1:112,i),'Color','r','LineWidth',1)
    xlim([-50 300])
    %axis off
    z=z+3;
end


xx=9:16;
cd F:\Data\VSDI\Contour_integration\Smeagol
load correlations_rois_ave
figure;
z=1;
for i=xx
    subplot(8,3,z)
    plot(x,cont_ccbg_bg(:,i),'LineWidth',1)
    hold on
    plot(x,non_ccbg_bg(:,i),'Color','r','LineWidth',1)
    xlim([-50 300])
    %axis off
    z=z+3;
end

clear all
load signal_correlation_ave.mat
xx=9:16;
z=2;
for i=xx
    subplot(8,3,z)
    plot(x,cont_ccbg_bg(1:112,i),'LineWidth',1)
    hold on
    plot(x,non_ccbg_bg(1:112,i),'Color','r','LineWidth',1)
    xlim([-50 300])
    %axis off
    z=z+3;
end


clear all
xx=9:16;
load correlations_rois_ave_no_stim
z=3;
for i=xx
    subplot(8,3,z)
    plot(x,cont_ccbg_bg(1:112,i),'LineWidth',1)
    hold on
    plot(x,non_ccbg_bg(1:112,i),'Color','r','LineWidth',1)
    xlim([-50 300])
    %axis off
    z=z+3;
end


xx=17:24;
cd F:\Data\VSDI\Contour_integration\Smeagol
load correlations_rois_ave
figure;
z=1;
for i=xx
    subplot(8,3,z)
    plot(x,cont_ccbg_bg(:,i),'LineWidth',1)
    hold on
    plot(x,non_ccbg_bg(:,i),'Color','r','LineWidth',1)
    xlim([-50 300])
    %axis off
    z=z+3;
end

clear all
xx=17:24;
load signal_correlation_ave.mat

z=2;
for i=xx
    subplot(8,3,z)
    plot(x,cont_ccbg_bg(1:112,i),'LineWidth',1)
    hold on
    plot(x,non_ccbg_bg(1:112,i),'Color','r','LineWidth',1)
    xlim([-50 300])
    %axis off
    z=z+3;
end


clear all
xx=17:24;
load correlations_rois_ave_no_stim
z=3;
for i=xx
    subplot(8,3,z)
    plot(x,cont_ccbg_bg(1:112,i),'LineWidth',1)
    hold on
    plot(x,non_ccbg_bg(1:112,i),'Color','r','LineWidth',1)
    xlim([-50 300])
    %axis off
    z=z+3;
end



xx=25:32;
cd F:\Data\VSDI\Contour_integration\Smeagol
load correlations_rois_ave
figure;
z=1;
for i=xx
    subplot(8,3,z)
    plot(x,cont_ccbg_bg(:,i),'LineWidth',1)
    hold on
    plot(x,non_ccbg_bg(:,i),'Color','r','LineWidth',1)
    xlim([-50 300])
    %axis off
    z=z+3;
end

clear all
xx=25:32;
load signal_correlation_ave.mat

z=2;
for i=xx
    subplot(8,3,z)
    plot(x,cont_ccbg_bg(1:112,i),'LineWidth',1)
    hold on
    plot(x,non_ccbg_bg(1:112,i),'Color','r','LineWidth',1)
    xlim([-50 300])
    %axis off
    z=z+3;
end


clear all
xx=25:32;
load correlations_rois_ave_no_stim
z=3;
for i=xx
    subplot(8,3,z)
    plot(x,cont_ccbg_bg(1:112,i),'LineWidth',1)
    hold on
    plot(x,non_ccbg_bg(1:112,i),'Color','r','LineWidth',1)
    xlim([-50 300])
    %axis off
    z=z+3;
end


xx=33:37;
cd F:\Data\VSDI\Contour_integration\Smeagol
load correlations_rois_ave
figure;
z=1;
for i=xx
    subplot(5,3,z)
    plot(x,cont_ccbg_bg(:,i),'LineWidth',1)
    hold on
    plot(x,non_ccbg_bg(:,i),'Color','r','LineWidth',1)
    xlim([-50 300])
    %axis off
    z=z+3;
end

clear all
load signal_correlation_ave.mat
xx=33:37;
z=2;
for i=xx
    subplot(5,3,z)
    plot(x,cont_ccbg_bg(1:112,i),'LineWidth',1)
    hold on
    plot(x,non_ccbg_bg(1:112,i),'Color','r','LineWidth',1)
    xlim([-50 300])
    %axis off
    z=z+3;
end


clear all
xx=33:37;
load correlations_rois_ave_no_stim
z=3;
for i=xx
    subplot(5,3,z)
    plot(x,cont_ccbg_bg(1:112,i),'LineWidth',1)
    hold on
    plot(x,non_ccbg_bg(1:112,i),'Color','r','LineWidth',1)
    xlim([-50 300])
    %axis off
    z=z+3;
end


%% diff
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol
load correlations_rois_ave
figure;
diff=cont_ccbg_bg-non_ccbg_bg;
z=1;
for i=1:8
    subplot(8,3,z)
    plot(x,diff(:,i),'LineWidth',1)
    hold on
    plot(x,zeros(1,112),'k')
    xlim([-50 300])
    %axis off
    z=z+3;
end

clear all
load signal_correlation_ave.mat

z=2;
for i=1:8
    subplot(8,3,z)
    plot(x,diff_ccbg_bg_smeg(1:112,i),'LineWidth',1)
    hold on
    plot(x,zeros(1,112),'k')
    xlim([-50 300])
    %axis off
    z=z+3;
end


clear all
load correlations_rois_ave_no_stim
diff=cont_ccbg_bg-non_ccbg_bg;
z=3;
for i=1:8
    subplot(8,3,z)
    plot(x,diff(1:112,i),'LineWidth',1)
    hold on
    plot(x,zeros(1,112),'k')
    xlim([-50 300])
    %axis off
    z=z+3;
end


xx=9:16;
cd F:\Data\VSDI\Contour_integration\Smeagol
load correlations_rois_ave
diff=cont_ccbg_bg-non_ccbg_bg;
figure;
z=1;
for i=xx
    subplot(8,3,z)
    plot(x,diff(:,i),'LineWidth',1)
    hold on
    plot(x,zeros(1,112),'k')
    xlim([-50 300])
    %axis off
    z=z+3;
end

clear all
load signal_correlation_ave.mat
xx=9:16;
z=2;
for i=xx
    subplot(8,3,z)
    plot(x,diff_ccbg_bg_smeg(1:112,i),'LineWidth',1)
    hold on
    plot(x,zeros(1,112),'k')
    xlim([-50 300])
    %axis off
    z=z+3;
end


clear all
xx=9:16;
load correlations_rois_ave_no_stim
diff=cont_ccbg_bg-non_ccbg_bg;
z=3;
for i=xx
    subplot(8,3,z)
    plot(x,diff(1:112,i),'LineWidth',1)
    hold on
    plot(x,zeros(1,112),'k')
    xlim([-50 300])
    %axis off
    z=z+3;
end


xx=17:24;
cd F:\Data\VSDI\Contour_integration\Smeagol
load correlations_rois_ave
diff=cont_ccbg_bg-non_ccbg_bg;
figure;
z=1;
for i=xx
    subplot(8,3,z)
    plot(x,diff(:,i),'LineWidth',1)
    hold on
    plot(x,zeros(1,112),'k')
    xlim([-50 300])
    %axis off
    z=z+3;
end

clear all
xx=17:24;
load signal_correlation_ave.mat

z=2;
for i=xx
    subplot(8,3,z)
    plot(x,diff_ccbg_bg_smeg(1:112,i),'LineWidth',1)
    hold on
    plot(x,zeros(1,112),'k')
    xlim([-50 300])
    %axis off
    z=z+3;
end


clear all
xx=17:24;
load correlations_rois_ave_no_stim
diff=cont_ccbg_bg-non_ccbg_bg;
z=3;
for i=xx
    subplot(8,3,z)
    plot(x,diff(1:112,i),'LineWidth',1)
    hold on
    plot(x,zeros(1,112),'k')
    xlim([-50 300])
    %axis off
    z=z+3;
end



xx=25:32;
cd F:\Data\VSDI\Contour_integration\Smeagol
load correlations_rois_ave
diff=cont_ccbg_bg-non_ccbg_bg;
figure;
z=1;
for i=xx
    subplot(8,3,z)
    plot(x,diff(:,i),'LineWidth',1)
    hold on
    plot(x,zeros(1,112),'k')
    xlim([-50 300])
    %axis off
    z=z+3;
end

clear all
xx=25:32;
load signal_correlation_ave.mat

z=2;
for i=xx
    subplot(8,3,z)
    plot(x,diff_ccbg_bg_smeg(1:112,i),'LineWidth',1)
    hold on
    plot(x,zeros(1,112),'k')
    xlim([-50 300])
    %axis off
    z=z+3;
end


clear all
xx=25:32;
load correlations_rois_ave_no_stim
diff=cont_ccbg_bg-non_ccbg_bg;
z=3;
for i=xx
    subplot(8,3,z)
    plot(x,diff(1:112,i),'LineWidth',1)
    hold on
    plot(x,zeros(1,112),'k')
    xlim([-50 300])
    %axis off
    z=z+3;
end


xx=33:37;
cd F:\Data\VSDI\Contour_integration\Smeagol
load correlations_rois_ave
diff=cont_ccbg_bg-non_ccbg_bg;
figure;
z=1;
for i=xx
    subplot(5,3,z)
    plot(x,diff(:,i),'LineWidth',1)
    hold on
    plot(x,zeros(1,112),'k')
    xlim([-50 300])
    %axis off
    z=z+3;
end

clear all
load signal_correlation_ave.mat
xx=33:37;
z=2;
for i=xx
    subplot(5,3,z)
    plot(x,diff_ccbg_bg_smeg(1:112,i),'LineWidth',1)
    hold on
    plot(x,zeros(1,112),'k')
    xlim([-50 300])
    %axis off
    z=z+3;
end


clear all
xx=33:37;
load correlations_rois_ave_no_stim
diff=cont_ccbg_bg-non_ccbg_bg;
z=3;
for i=xx
    subplot(5,3,z)
    plot(x,diff(1:112,i),'LineWidth',1)
    hold on
    plot(x,zeros(1,112),'k')
    xlim([-50 300])
    %axis off
    z=z+3;
end



