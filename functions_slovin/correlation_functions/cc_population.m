


date='1111';
time1=31:34;
time2=50:57;

eval(['cc',date,'=zeros(2,4);'])

eval(['cc',date,'(1,1)=mean(mean(a([roi_f1;roi_f2;roi_tar],time1)))-mean(mean(b([roi_f1;roi_f2;roi_tar],time1)));'])
eval(['cc',date,'(1,2)=mean(mean(a(roi_contour2,time1)))-mean(mean(b(roi_contour2,time1)));'])
eval(['cc',date,'(1,3)=mean(mean(a(roi_maskin,time1)))-mean(mean(b(roi_maskin,time1)));'])
eval(['cc',date,'(1,4)=mean(mean(a(roi_maskout,time1)))-mean(mean(b(roi_maskout,time1)));'])

eval(['cc',date,'(2,1)=mean(mean(a([roi_f1;roi_f2;roi_tar],time2)))-mean(mean(b([roi_f1;roi_f2;roi_tar],time2)));'])
eval(['cc',date,'(2,2)=mean(mean(a(roi_contour2,time2)))-mean(mean(b(roi_contour2,time2)));'])
eval(['cc',date,'(2,3)=mean(mean(a(roi_maskin,time2)))-mean(mean(b(roi_maskin,time2)));'])
eval(['cc',date,'(2,4)=mean(mean(a(roi_maskout,time2)))-mean(mean(b(roi_maskout,time2)));'])

