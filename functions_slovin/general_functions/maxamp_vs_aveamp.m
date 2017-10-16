



figure 
   scatter(mean(mean(b(roi_contour2,32:42,:),3),2)-1,mean(mean(a(roi_contour2,32:42,:),3),2)-1) 
   hold on  
   xlim([0 2e-3]) 
   ylim([0 2e-3]) 
   plot((0:0.0001:2e-3),(0:0.0001:2e-3)) 
 


    
   figure 
   scatter(max(b(roi_contour2,32:42),[],2)-1,max(a(roi_contour2,32:42),[],2)-1) 
   hold on  
   xlim([0 2e-3]) 
   ylim([0 2e-3]) 
   plot((0:0.0001:2e-3),(0:0.0001:2e-3))
   
   ranksum(max(b(roi_contour2,32:42),[],2)-1,max(a(roi_contour2,32:42),[],2)-1)
   
   
   
   
   
   
   
   