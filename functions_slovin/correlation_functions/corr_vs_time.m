


date='1111h';
time1=31:34;


eval(['cc',date,'=zeros(2,3);'])

eval(['cc',date,'(1,1)=mean(mean(a([roi_f1;roi_f2;roi_tar],time1)));'])
eval(['cc',date,'(1,2)=mean(mean(a(roi_contour,time1)));'])
eval(['cc',date,'(1,3)=mean(mean(a(roi_bg_in,time1)));'])
%eval(['cc',date,'(1,4)=mean(mean(a(roi_V2,time1)));'])

eval(['cc',date,'(2,1)=mean(mean(b([roi_f1;roi_f2;roi_tar],time1)));'])
eval(['cc',date,'(2,2)=mean(mean(b(roi_contour,time1)));'])
eval(['cc',date,'(2,3)=mean(mean(b(roi_bg_in,time1)));'])
%eval(['cc',date,'(2,4)=mean(mean(b(roi_V2,time1)));'])




date='0601e';
time1=25:68;


eval(['time',date,'=zeros(2,3,size(time1,2));'])

eval(['time',date,'(1,1,:)=mean(a([roi_f1;roi_f2;roi_tar],time1),1)-1;'])
eval(['time',date,'(1,2,:)=mean(a(roi_contour,time1),1)-1;'])
eval(['time',date,'(1,3,:)=mean(a(roi_bg_in,time1),1)-1;'])
%eval(['time',date,'(1,4,:)=mean(a(roi_V2,time1),1)-1;'])

eval(['time',date,'(2,1,:)=mean(b([roi_f1;roi_f2;roi_tar],time1),1)-1;'])
eval(['time',date,'(2,2,:)=mean(b(roi_contour,time1),1)-1;'])
eval(['time',date,'(2,3,:)=mean(b(roi_bg_in,time1),1)-1;'])
%eval(['time',date,'(2,4,:)=mean(b(roi_V2,time1),1)-1;'])



