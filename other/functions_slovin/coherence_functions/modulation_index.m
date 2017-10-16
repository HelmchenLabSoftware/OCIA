%% modulation index


mia=(max(mean(mean(a(roi_V1,4:9,20:40),2),1))-max(mean(mean(b(roi_V1,4:9,20:40),2),1)))/(max(mean(mean(a(roi_V1,4:9,20:40),2),1))+max(mean(mean(b(roi_V1,4:9,20:40),2),1)));
mib=(max(mean(mean(a(roi_V1,10:15,20:40),2),1))-max(mean(mean(b(roi_V1,10:15,20:40),2),1)))/(max(mean(mean(a(roi_V1,10:15,20:40),2),1))+max(mean(mean(b(roi_V1,10:15,20:40),2),1)));
mig=(max(mean(mean(a(roi_V1,16:25,20:40),2),1))-max(mean(mean(b(roi_V1,16:25,20:40),2),1)))/(max(mean(mean(a(roi_V1,16:25,20:40),2),1))+max(mean(mean(b(roi_V1,16:25,20:40),2),1)));

mia2=(max(mean(mean(a(roi_V1,4:9,20:40),2),1))-max(mean(mean(b(roi_V1,4:9,20:40),2),1)))/(max(mean(mean(a(roi_V1,4:9,20:40),2),1))+max(mean(mean(b(roi_V1,4:9,20:40),2),1)));
mib2=(max(mean(mean(a(roi_V1,10:15,20:40),2),1))-max(mean(mean(b(roi_V1,10:15,20:40),2),1)))/(max(mean(mean(a(roi_V1,10:15,20:40),2),1))+max(mean(mean(b(roi_V1,10:15,20:40),2),1)));
mig2=(max(mean(mean(a(roi_V1,16:25,20:40),2),1))-max(mean(mean(b(roi_V1,16:25,20:40),2),1)))/(max(mean(mean(a(roi_V1,16:25,20:40),2),1))+max(mean(mean(b(roi_V1,16:25,20:40),2),1)));

alpha_change=(mia2/mia)*100;
beta_change=(mib2/mib)*100;
gamma_change=(mig2/mig)*100;

i=5;
MI(i,1)=2011;
MI(i,2)=mia;
MI(i,3)=mia2;
MI(i,4)=alpha_change;
MI(i,5)=mib;
MI(i,6)=mib2;
MI(i,7)=beta_change;
MI(i,8)=mig;
MI(i,9)=mig2;
MI(i,10)=gamma_change;


