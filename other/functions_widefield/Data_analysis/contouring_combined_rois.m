cd D:\intrinsic\20150520
load('rois_combined.mat')
hold on
h=zeros(205*205,1);
h(roi_s1)=1;
h(roi_s2)=1;
h(roi_ppc)=1;
contour(reshape(h,205,205),'c')

h=zeros(205*205,1);
h(roi_m1)=1;
contour(reshape(h,205,205),'r')
h=zeros(205*205,1);
h(roi_m2)=1;
contour(reshape(h,205,205),'r')

h=zeros(205*205,1);
h(roi_sc)=1;
contour(reshape(h,205,205),'m')
h=zeros(205*205,1);
h(roi_ic)=1;
contour(reshape(h,205,205),'m')

h=zeros(205*205,1);
h(roi_a1)=1;
contour(reshape(h,205,205),'g')

h=zeros(205*205,1);
h(roi_fl)=1;
h(roi_hl)=1;
contour(reshape(h,205,205),'y')

