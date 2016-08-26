
%1111

% old border used in the first contour integration paper
% hold on
%     line([11 97],[29 40],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
%     line([16 94],[21 29],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
%     text(100,46,'V1','FontSize',16)
%     text(100,35,'V2','FontSize',16)
%     text(96,22,'V4','FontSize',16)

% new border used in the rest of the contour integration papers
    hold on
    line([9 97],[29 45],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([16 94],[21 29],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    text(100,46,'V1','FontSize',16)
    text(100,35,'V2','FontSize',16)
    text(96,22,'V4','FontSize',16)

%2511
    
    
hold on
    line([14 92],[19 31],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
    line([7 96],[31 46],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
    text(100,46,'V1','FontSize',16)
    text(100,35,'V2','FontSize',16)
    text(96,22,'V4','FontSize',16)

 
%smeagol left
    
    
hold on
    line([1 46],[54 67],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([46 100],[67 66],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    %text(100,46,'V1','FontSize',16)
    %text(100,35,'V2','FontSize',16)
    %text(96,22,'V4','FontSize',16)

    
%16may2012
hold on
    line([13 26],[47 52],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([26 34],[52 53],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([34 59],[53 56],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([59 66],[56 57],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([66 87],[57 57],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
        
%22may2012
hold on
    line([19 36],[56 61],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([36 43],[61 62],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([43 69],[62 65],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([69 76],[65 66],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([76 97],[66 66],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    
    
%06june2012
hold on
    line([6 16],[65 65],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([16 24],[65 66],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([24 51],[66 66],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([51 58],[66 66],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([58 83],[66 63],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    
%02aug2012
hold on
    line([10 20],[61 60],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([20 28],[60 62],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([28 55],[62 62],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([55 62],[62 62],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([62 84],[62 60],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    
%09aug2012 and 15aug2012    
hold on
    line([4 18],[58 57],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([18 25],[57 59],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([25 54],[59 59],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([54 61],[59 59],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([61 87],[59 55],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    
%smeagol right
    
%2912e    
hold on
    line([1 72],[40 41],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([72 94],[41 30],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([1 65],[50 52],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')
    line([65 96],[52 43],'Marker','.','LineStyle','-','LineWidth',3,'Color','r')   
    text(100,46,'V1','FontSize',16)
    text(100,35,'V2','FontSize',16)
    text(96,22,'V4','FontSize',16)
    
    
        
    
k=0;    
for i=38
  k=k+1;
  figure;scatter(b(roi_V2,i)-1,a(roi_V2,i)-1)  
  hold on  
  xlim([-0.2e-3 2.5e-3]);ylim([-0.2e-3 2.5e-3])  
  plot(-1:0.0001:1,-1:0.0001:1,'k') 
  ranksum(b(roi_V2,i)-1,a(roi_V2,i)-1)
end    



x=-200:10:200;
figure;
errorbar(x,mean(crosscov_cond1,2),std(crosscov_cond1,0,2)./sqrt(size(crosscov_cond1,2)));
hold on
errorbar(x,mean(crosscov_cond5,2),std(crosscov_cond5,0,2)./sqrt(size(crosscov_cond5,2)),'r');

figure;
errorbar(x,mean(crosscov_cond2,2),std(crosscov_cond2,0,2)./sqrt(size(crosscov_cond2,2)));
hold on
errorbar(x,mean(crosscov_cond5,2),std(crosscov_cond5,0,2)./sqrt(size(crosscov_cond5,2)),'r');


figure;
plot(x,mean(crosscov_cond1,2)-mean(crosscov_cond4,2));
figure;
plot(x,mean(crosscov_cond2,2)-mean(crosscov_cond5,2));








