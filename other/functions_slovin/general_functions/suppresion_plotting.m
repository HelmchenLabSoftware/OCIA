%% Plotting

for j=1:tr  
    figure
    plot(x2(2:130),squeeze(mean(cond1n_dt_bl(roi_far,2:130,j),1)))
    hold on
    plot(x2(2:130),squeeze(mean(cond1n_dt_bl(roi_inter,2:130,j),1)),'g')
    plot(x2(2:130),squeeze(mean(cond1n_dt_bl(roi_inter2,2:130,j),1)),'r')
    plot(x2(2:130),squeeze(mean(cond1n_dt_bl(roi_close,2:130,j),1)),'c')
    plot(x2(2:130),squeeze(mean(cond1n_dt_bl(roi_oppose,2:130,j),1)),'m')
    title(['trial ',int2str(j)])
    legend('far','inter','inter2','close','oppose')
end


for i=10
    figure;mimg(mfilt2(der(:,20:end,i),100,100,1,'lm'),100,100,-.8e-3,1e-3);colormap(mapgeog);
    figure;mimg(mfilt2(cond1n_dt_bl(:,20:58,i),100,100,1,'lm')-1,100,100,-.3e-3,2e-3);colormap(mapgeog);
end


for i=[5]
    figure;mimg(mfilt2(cond1n_dt_bl(:,20:50,i),100,100,1,'lm')-1,100,100,-.3e-3,2e-3);colormap(mapgeog);
end





figure
    plot(x2(2:130),mean(mean(cond1n_dt_bl(roi_maskin,2:130,:),1),3))
    hold on
    plot(x2(2:130),mean(mean(cond2n_dt_bl(roi_maskin,2:130,:),1),3),'g')
    plot(x2(2:130),mean(mean(cond4n_dt_bl(roi_maskin,2:130,:),1),3),'r')
    plot(x2(2:130),mean(mean(cond5n_dt_bl(roi_maskin,2:130,:),1),3),'c')
    
   
x1=(2:2:1280)*2-305;
x2=(1:256)*10-280;
    
   figure 
   scatter(mean(mean(b(roi_maskin,32:37,:),3),2)-1,mean(mean(a(roi_maskin,32:37,:),3),2)-1) 
   hold on  
   xlim([0 2e-3]) 
   ylim([0 2e-3]) 
   plot((0:0.0001:2e-3),(0:0.0001:2e-3)) 
   figure 
   scatter(mean(mean(b(roi_maskout,32:42,:),3),2)-1,mean(mean(a(roi_maskout,32:42,:),3),2)-1) 
   hold on  
   xlim([0 2e-3]) 
   ylim([0 2e-3]) 
   plot((0:0.0001:2e-3),(0:0.0001:2e-3)) 
   figure 
   scatter(mean(mean(b(roi_contour2,32:37,:),3),2)-1,mean(mean(a(roi_contour2,32:37,:),3),2)-1) 
   hold on  
   xlim([0 2e-3]) 
   ylim([0 2e-3]) 
   plot((0:0.0001:2e-3),(0:0.0001:2e-3)) 
   figure 
   scatter(mean(mean(b(roi_V2,32:42,:),3),2)-1,mean(mean(a(roi_V2,32:42,:),3),2)-1) 
   hold on  
   xlim([0 2e-3]) 
   ylim([0 2e-3]) 
   plot((0:0.0001:2e-3),(0:0.0001:2e-3)) 
   
   
   
   ranksum(mean(mean(cond4n_dt_bl(roi_bg_in,38:58,:),3),2)-1,mean(mean(cond1n_dt_bl(roi_bg_in,38:58,:),3),2)-1)
   ranksum(mean(mean(cond4n_dt_bl(roi_bg_out,38:58,:),3),2)-1,mean(mean(cond1n_dt_bl(roi_bg_out,38:58,:),3),2)-1)
   ranksum(mean(mean(cond4n_dt_bl(roi_contour2,32:42,:),3),2)-1,mean(mean(cond1n_dt_bl(roi_contour2,38:58,:),3),2)-1)
   ranksum(mean(mean(cond4n_dt_bl(roi_V2,38:58,:),3),2)-1,mean(mean(cond1n_dt_bl(roi_V2,38:58,:),3),2)-1)
      
   
   
x1=(2:2:1280)*2-305;
x2=(1:256)*10-280;
     
figure   
errorbar(x2(8:68),mean(mean(cond1n_dt_bl(roi_bg_in,8:68,:)-1,1),3),std(mean(cond1n_dt_bl(roi_bg_in,8:68,:)-1,1),0,3)/sqrt(size(cond1n_dt_bl,3)));
hold on
errorbar(x2(8:68),mean(mean(cond5n_dt_bl(roi_bg_in,8:68,:)-1,1),3),std(mean(cond5n_dt_bl(roi_bg_in,8:68,:)-1,1),0,3)/sqrt(size(cond5n_dt_bl,3)),'r');
errorbar(x2(8:68),mean(mean(cond2n_dt_bl(roi_bg_in,8:68,:)-1,1),3),std(mean(cond2n_dt_bl(roi_bg_in,8:68,:)-1,1),0,3)/sqrt(size(cond2n_dt_bl,3)),'g');
errorbar(x2(8:68),mean(mean(cond4n_dt_bl(roi_bg_in,8:68,:)-1,1),3),std(mean(cond4n_dt_bl(roi_bg_in,8:68,:)-1,1),0,3)/sqrt(size(cond4n_dt_bl,3)),'c');

figure   
errorbar(x2(8:68),mean(mean(cond1n_dt_bl(roi_contour,8:68,:)-1,1),3),std(mean(cond1n_dt_bl(roi_contour,8:68,:)-1,1),0,3)/sqrt(size(cond1n_dt_bl,3)));
hold on
errorbar(x2(8:68),mean(mean(cond5n_dt_bl(roi_contour,8:68,:)-1,1),3),std(mean(cond5n_dt_bl(roi_contour,8:68,:)-1,1),0,3)/sqrt(size(cond5n_dt_bl,3)),'r');
errorbar(x2(8:68),mean(mean(cond2n_dt_bl(roi_contour,8:68,:)-1,1),3),std(mean(cond2n_dt_bl(roi_contour,8:68,:)-1,1),0,3)/sqrt(size(cond2n_dt_bl,3)),'g');
errorbar(x2(8:68),mean(mean(cond4n_dt_bl(roi_contour,8:68,:)-1,1),3),std(mean(cond4n_dt_bl(roi_contour,8:68,:)-1,1),0,3)/sqrt(size(cond4n_dt_bl,3)),'c');

figure   
errorbar(x2(8:68),mean(mean(cond1n_dt_bl(roi_V2,8:68,:)-1,1),3),std(mean(cond1n_dt_bl(roi_V2,8:68,:)-1,1),0,3)/sqrt(size(cond1n_dt_bl,3)));
hold on
errorbar(x2(8:68),mean(mean(cond5n_dt_bl(roi_V2,8:68,:)-1,1),3),std(mean(cond5n_dt_bl(roi_V2,8:68,:)-1,1),0,3)/sqrt(size(cond5n_dt_bl,3)),'r');
errorbar(x2(8:68),mean(mean(cond2n_dt_bl(roi_V2,8:68,:)-1,1),3),std(mean(cond2n_dt_bl(roi_V2,8:68,:)-1,1),0,3)/sqrt(size(cond2n_dt_bl,3)),'g');
errorbar(x2(8:68),mean(mean(cond4n_dt_bl(roi_V2,8:68,:)-1,1),3),std(mean(cond4n_dt_bl(roi_V2,8:68,:)-1,1),0,3)/sqrt(size(cond4n_dt_bl,3)),'c');

   
   
   
   
   
figure   
plot(x2(8:68),mean(mean(cond1n_dt_bl(roi_V2,8:68,:),1),3));
hold on
plot(x2(8:68),mean(mean(cond5n_dt_bl(roi_V2,8:68,:),1),3),'r');
plot(x2(8:68),mean(mean(cond2n_dt_bl(roi_V2,8:68,:),1),3),'g');
plot(x2(8:68),mean(mean(cond4n_dt_bl(roi_V2,8:68,:),1),3),'c');

 

%% normalized

%background
a=mean(mean(cond1n_dt_bl(roi_bg_in,8:68,:)-1,1),3)/max(mean(mean(cond1n_dt_bl(roi_bg_in,8:43,:)-1,1),3));
as=(std(mean(cond1n_dt_bl(roi_bg_in,8:68,:)-1,1),0,3)/max(mean(mean(cond1n_dt_bl(roi_bg_in,8:43,:)-1,1),3)))/sqrt(size(cond1n_dt_bl,3));
b=mean(mean(cond2n_dt_bl(roi_bg_in,8:68,:)-1,1),3)/max(mean(mean(cond2n_dt_bl(roi_bg_in,8:43,:)-1,1),3));
bs=(std(mean(cond2n_dt_bl(roi_bg_in,8:68,:)-1,1),0,3)/max(mean(mean(cond2n_dt_bl(roi_bg_in,8:43,:)-1,1),3)))/sqrt(size(cond2n_dt_bl,3));
c=mean(mean(cond4n_dt_bl(roi_bg_in,8:68,:)-1,1),3)/max(mean(mean(cond4n_dt_bl(roi_bg_in,8:43,:)-1,1),3));
cs=(std(mean(cond4n_dt_bl(roi_bg_in,8:68,:)-1,1),0,3)/max(mean(mean(cond4n_dt_bl(roi_bg_in,8:43,:)-1,1),3)))/sqrt(size(cond4n_dt_bl,3));
d=mean(mean(cond5n_dt_bl(roi_bg_in,8:68,:)-1,1),3)/max(mean(mean(cond5n_dt_bl(roi_bg_in,8:43,:)-1,1),3));
ds=(std(mean(cond5n_dt_bl(roi_bg_in,8:68,:)-1,1),0,3)/max(mean(mean(cond5n_dt_bl(roi_bg_in,8:43,:)-1,1),3)))/sqrt(size(cond5n_dt_bl,3));

x1=(2:2:1280)*2-305;
x2=(1:256)*10-280;
     
figure   
errorbar(x2(8:68),a,as);
hold on
errorbar(x2(8:68),b,bs,'g');
errorbar(x2(8:68),c,cs,'c');
errorbar(x2(8:68),d,ds,'r');

% circle   
a=mean(mean(cond1n_dt_bl(roi_contour,8:68,:)-1,1),3)/max(mean(mean(cond1n_dt_bl(roi_contour,8:43,:)-1,1),3));
as=(std(mean(cond1n_dt_bl(roi_contour,8:68,:)-1,1),0,3)/max(mean(mean(cond1n_dt_bl(roi_contour,8:43,:)-1,1),3)))/sqrt(size(cond1n_dt_bl,3));
b=mean(mean(cond2n_dt_bl(roi_contour,8:68,:)-1,1),3)/max(mean(mean(cond2n_dt_bl(roi_contour,8:43,:)-1,1),3));
bs=(std(mean(cond2n_dt_bl(roi_contour,8:68,:)-1,1),0,3)/max(mean(mean(cond2n_dt_bl(roi_contour,8:43,:)-1,1),3)))/sqrt(size(cond2n_dt_bl,3));
c=mean(mean(cond4n_dt_bl(roi_contour,8:68,:)-1,1),3)/max(mean(mean(cond4n_dt_bl(roi_contour,8:43,:)-1,1),3));
cs=(std(mean(cond4n_dt_bl(roi_contour,8:68,:)-1,1),0,3)/max(mean(mean(cond4n_dt_bl(roi_contour,8:43,:)-1,1),3)))/sqrt(size(cond4n_dt_bl,3));
d=mean(mean(cond5n_dt_bl(roi_contour,8:68,:)-1,1),3)/max(mean(mean(cond5n_dt_bl(roi_contour,8:43,:)-1,1),3));
ds=(std(mean(cond5n_dt_bl(roi_contour,8:68,:)-1,1),0,3)/max(mean(mean(cond5n_dt_bl(roi_contour,8:43,:)-1,1),3)))/sqrt(size(cond5n_dt_bl,3));

x1=(2:2:1280)*2-305;
x2=(1:256)*10-280;
     
figure   
errorbar(x2(8:68),a,as);
hold on
errorbar(x2(8:68),b,bs,'g');
errorbar(x2(8:68),c,cs,'c');
errorbar(x2(8:68),d,ds,'r');

   
      
% V2   
a=mean(mean(cond1n_dt_bl(roi_V2,8:68,:)-1,1),3)/max(mean(mean(cond1n_dt_bl(roi_V2,8:43,:)-1,1),3));
as=(std(mean(cond1n_dt_bl(roi_V2,8:68,:)-1,1),0,3)/max(mean(mean(cond1n_dt_bl(roi_V2,8:43,:)-1,1),3)))/sqrt(size(cond1n_dt_bl,3));
b=mean(mean(cond2n_dt_bl(roi_V2,8:68,:)-1,1),3)/max(mean(mean(cond2n_dt_bl(roi_V2,8:43,:)-1,1),3));
bs=(std(mean(cond2n_dt_bl(roi_V2,8:68,:)-1,1),0,3)/max(mean(mean(cond2n_dt_bl(roi_V2,8:43,:)-1,1),3)))/sqrt(size(cond2n_dt_bl,3));
c=mean(mean(cond4n_dt_bl(roi_V2,8:68,:)-1,1),3)/max(mean(mean(cond4n_dt_bl(roi_V2,8:43,:)-1,1),3));
cs=(std(mean(cond4n_dt_bl(roi_V2,8:68,:)-1,1),0,3)/max(mean(mean(cond4n_dt_bl(roi_V2,8:43,:)-1,1),3)))/sqrt(size(cond4n_dt_bl,3));
d=mean(mean(cond5n_dt_bl(roi_V2,8:68,:)-1,1),3)/max(mean(mean(cond5n_dt_bl(roi_V2,8:43,:)-1,1),3));
ds=(std(mean(cond5n_dt_bl(roi_V2,8:68,:)-1,1),0,3)/max(mean(mean(cond5n_dt_bl(roi_V2,8:43,:)-1,1),3)))/sqrt(size(cond5n_dt_bl,3));

x1=(2:2:1280)*2-305;
x2=(1:256)*10-280;
     
figure   
errorbar(x2(8:68),a,as);
hold on
errorbar(x2(8:68),b,bs,'g');
errorbar(x2(8:68),c,cs,'c');
errorbar(x2(8:68),d,ds,'r');

      
   