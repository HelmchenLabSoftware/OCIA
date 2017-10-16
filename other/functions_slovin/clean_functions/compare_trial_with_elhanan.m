

tr=17;
for i=20
    figure
    plot(squeeze(mean(cond22n_dt_bl(roi_contour2,2:112,tr),1)))
    hold on
    plot(squeeze(mean(cond2n_dt_bl(roi_contour2,2:112,i),1)))
end
    
    
    
    