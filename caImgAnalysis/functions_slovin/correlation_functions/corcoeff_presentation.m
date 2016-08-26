


figure;plotspconds(cat(3,a,b,c),100,100,10);
figure
subplot(3,3,1);plot(cat(2,squeeze(mean(a(roi_dip,:),1)).',squeeze(mean(b(roi_dip,:),1)).',squeeze(mean(c(roi_dip,:),1)).'));xlim([0 112]);title('dip');%ylim([-0.2 0.8]);
subplot(3,3,2);plot(cat(2,squeeze(mean(a(roi_f3,:),1)).',squeeze(mean(b(roi_f3,:),1)).',squeeze(mean(c(roi_f3,:),1)).'));xlim([0 112]);title('f3');%ylim([-0.2 0.8]);
%subplot(3,3,3);plot(cat(2,squeeze(mean(a(roi_f4,:),1)).',squeeze(mean(b(roi_f4,:),1)).',squeeze(mean(c(roi_f4,:),1)).'));xlim([0 112]);title('f4');%ylim([-0.2 0.8]);
subplot(3,3,4);plot(cat(2,squeeze(mean(a(roi_f5,:),1)).',squeeze(mean(b(roi_f5,:),1)).',squeeze(mean(c(roi_f5,:),1)).'));xlim([0 112]);title('f5');ylim([-0.2 0.8]);
%subplot(3,3,5);plot(cat(2,squeeze(mean(a(roi_f6,:),1)).',squeeze(mean(b(roi_f6,:),1)).',squeeze(mean(c(roi_f6,:),1)).'));xlim([0 112]);title('f6');%ylim([-0.2 0.8]);
subplot(3,3,7);plot(cat(2,squeeze(mean(a(roi_tar,:),1)).',squeeze(mean(b(roi_tar,:),1)).',squeeze(mean(c(roi_tar,:),1)).'));xlim([0 112]);title('tar');%ylim([-0.2 0.8]);
subplot(3,3,8);plot(cat(2,squeeze(mean(a(roi_f1,:),1)).',squeeze(mean(b(roi_f1,:),1)).',squeeze(mean(c(roi_f1,:),1)).'));xlim([0 112]);title('f1');%ylim([-0.2 0.8]);
subplot(3,3,9);plot(cat(2,squeeze(mean(a(roi_f2,:),1)).',squeeze(mean(b(roi_f2,:),1)).',squeeze(mean(c(roi_f2,:),1)).'));xlim([0 112]);title('f2');%ylim([-0.2 0.8]);

figure
subplot(3,3,1);plot(cat(2,squeeze(mean(a(roi_dip,:),1)).',squeeze(mean(b(roi_dip,:),1)).',squeeze(mean(c(roi_dip,:),1)).'));xlim([0 112]);title('dip');%ylim([-0.2 0.8]);
subplot(3,3,2);plot(cat(2,squeeze(mean(a(roi_f398,:),1)).',squeeze(mean(b(roi_f398,:),1)).',squeeze(mean(c(roi_f398,:),1)).'));xlim([0 112]);title('f3');%ylim([-0.2 0.8]);
subplot(3,3,3);plot(cat(2,squeeze(mean(a(roi_f498,:),1)).',squeeze(mean(b(roi_f498,:),1)).',squeeze(mean(c(roi_f498,:),1)).'));xlim([0 112]);title('f4');%ylim([-0.2 0.8]);
subplot(3,3,4);plot(cat(2,squeeze(mean(a(roi_f598,:),1)).',squeeze(mean(b(roi_f598,:),1)).',squeeze(mean(c(roi_f598,:),1)).'));xlim([0 112]);title('f5');ylim([-0.2 0.8]);
%subplot(3,3,5);plot(cat(2,squeeze(mean(a(roi_f698,:),1)).',squeeze(mean(b(roi_f698,:),1)).',squeeze(mean(c(roi_f698,:),1)).'));xlim([0 112]);title('f6');%ylim([-0.2 0.8]);
subplot(3,3,7);plot(cat(2,squeeze(mean(a(roi_tar98,:),1)).',squeeze(mean(b(roi_tar98,:),1)).',squeeze(mean(c(roi_tar98,:),1)).'));xlim([0 112]);title('tar');%ylim([-0.2 0.8]);
subplot(3,3,8);plot(cat(2,squeeze(mean(a(roi_f198,:),1)).',squeeze(mean(b(roi_f198,:),1)).',squeeze(mean(c(roi_f198,:),1)).'));xlim([0 112]);title('f1');%ylim([-0.2 0.8]);
subplot(3,3,9);plot(cat(2,squeeze(mean(a(roi_f298,:),1)).',squeeze(mean(b(roi_f298,:),1)).',squeeze(mean(c(roi_f298,:),1)).'));xlim([0 112]);title('f2');%ylim([-0.2 0.8]);

figure
subplot(3,3,1);plot(cat(2,squeeze(mean(a(roi_V2tar,:),1)).',squeeze(mean(b(roi_V2tar,:),1)).',squeeze(mean(c(roi_V2tar,:),1)).'));xlim([0 112]);title('dip');%ylim([-0.2 0.8]);
subplot(3,3,2);plot(cat(2,squeeze(mean(a(roi_maskin,:),1)).',squeeze(mean(b(roi_maskin,:),1)).',squeeze(mean(c(roi_maskin,:),1)).'));xlim([0 112]);title('maskin');%ylim([-0.2 0.8]);
subplot(3,3,3);plot(cat(2,squeeze(mean(a(roi_maskout,:),1)).',squeeze(mean(b(roi_maskout,:),1)).',squeeze(mean(c(roi_maskout,:),1)).'));xlim([0 112]);title('maskout');%ylim([-0.2 0.8]);
subplot(3,3,4);plot(cat(2,squeeze(mean(a(roi_space_tarf1,:),1)).',squeeze(mean(b(roi_space_tarf1,:),1)).',squeeze(mean(c(roi_space_tarf1,:),1)).'));xlim([0 112]);title('space_tarf1');ylim([-0.2 0.8]);
subplot(3,3,5);plot(cat(2,squeeze(mean(a(roi_tar98,:),1)).',squeeze(mean(b(roi_tar98,:),1)).',squeeze(mean(c(roi_tar98,:),1)).'));xlim([0 112]);title('tar98');%ylim([-0.2 0.8]);
subplot(3,3,7);plot(cat(2,squeeze(mean(a(roi_space_f2tar,:),1)).',squeeze(mean(b(roi_space_f2tar,:),1)).',squeeze(mean(c(roi_space_f2tar,:),1)).'));xlim([0 112]);title('space_f2tar');%ylim([-0.2 0.8]);
subplot(3,3,8);plot(cat(2,squeeze(mean(a(roi_V2corco,:),1)).',squeeze(mean(b(roi_V2corco,:),1)).',squeeze(mean(c(roi_V2corco,:),1)).'));xlim([0 112]);title('V2corco');%ylim([-0.2 0.8]);
subplot(3,3,9);plot(cat(2,squeeze(mean(a(roi_V4,:),1)).',squeeze(mean(b(roi_V4,:),1)).',squeeze(mean(c(roi_V4,:),1)).'));xlim([0 112]);title('V4');%ylim([-0.2 0.8]);

figure;plotspconds(cat(3,a(:,2:112),b(:,2:112),c(:,2:112)),100,100,10);
figure
subplot(3,3,1);plot(cat(2,squeeze(mean(a(roi_dip,2:112),1)).',squeeze(mean(b(roi_dip,2:112),1)).',squeeze(mean(c(roi_dip,2:112),1)).'));xlim([0 112]);title('dip');ylim([1-0.2e-3 1+1e-3]);
subplot(3,3,2);plot(cat(2,squeeze(mean(a(roi_f3,2:112),1)).',squeeze(mean(b(roi_f3,2:112),1)).',squeeze(mean(c(roi_f3,2:112),1)).'));xlim([0 112]);title('f3');ylim([1-0.2e-3 1+1e-3]);
subplot(3,3,3);plot(cat(2,squeeze(mean(a(roi_f4,2:112),1)).',squeeze(mean(b(roi_f4,2:112),1)).',squeeze(mean(c(roi_f4,2:112),1)).'));xlim([0 112]);title('f4');ylim([1-0.2e-3 1+1e-3]);
subplot(3,3,4);plot(cat(2,squeeze(mean(a(roi_f5,2:112),1)).',squeeze(mean(b(roi_f5,2:112),1)).',squeeze(mean(c(roi_f5,2:112),1)).'));xlim([0 112]);title('f5');ylim([1-0.2e-3 1+1e-3]);
%subplot(3,3,5);plot(cat(2,squeeze(mean(a(roi_f6,2:112),1)).',squeeze(mean(b(roi_f6,2:112),1)).',squeeze(mean(c(roi_f6,2:112),1)).'));xlim([0 112]);title('f6');ylim([1-0.2e-3 1+1e-3]);
subplot(3,3,7);plot(cat(2,squeeze(mean(a(roi_tar,2:112),1)).',squeeze(mean(b(roi_tar,2:112),1)).',squeeze(mean(c(roi_tar,2:112),1)).'));xlim([0 112]);title('tar');ylim([1-0.2e-3 1+1e-3]);
subplot(3,3,8);plot(cat(2,squeeze(mean(a(roi_f1,2:112),1)).',squeeze(mean(b(roi_f1,2:112),1)).',squeeze(mean(c(roi_f1,2:112),1)).'));xlim([0 112]);title('f1');ylim([1-0.2e-3 1+1e-3]);
subplot(3,3,9);plot(cat(2,squeeze(mean(a(roi_f2,2:112),1)).',squeeze(mean(b(roi_f2,2:112),1)).',squeeze(mean(c(roi_f2,2:112),1)).'));xlim([0 112]);title('f2');ylim([1-0.2e-3 1+1e-3]);



figure;mimg(mfilt2(squeeze(a(:,20:60)),100,100,1,'lm')-mfilt2(squeeze(b(:,20:60)),100,100,1,'lm'),100,100,-.1,.1);colormap(mapgeog);
time1=28:32;
time2=48:53;
time3=58:63;
figure;mimg(mfilt2(squeeze(a(:,time1)),100,100,1,'lm')-mfilt2(squeeze(b(:,time1)),100,100,1,'lm'),100,100,-.1,.1);colormap(mapgeog);
figure;mimg(mfilt2(squeeze(a(:,time2)),100,100,1,'lm')-mfilt2(squeeze(b(:,time2)),100,100,1,'lm'),100,100,-.1,.1);colormap(mapgeog);
figure;mimg(mfilt2(squeeze(a(:,time3)),100,100,1,'lm')-mfilt2(squeeze(b(:,time3)),100,100,1,'lm'),100,100,-.1,.1);colormap(mapgeog);


figure(100);mimg(mean(mfilt2(squeeze(a(:,time1)),100,100,1,'lm')-mfilt2(squeeze(b(:,time1)),100,100,1,'lm'),2),100,100,-.2,.2);colormap(mapgeog);
roi_V2corco= choose_polygon(100);

figure
subplot(3,1,1);plot(cat(2,squeeze(mean(a(roi_V2corco,:),1)).',squeeze(mean(b(roi_V2corco,:),1)).',squeeze(mean(c(roi_V2corco,:),1)).'));xlim([0 112]);title('dip-V2corco');ylim([-0.2 0.8]);
subplot(3,1,2);plot(cat(2,squeeze(mean(a(roi_dip,2:112),1)).',squeeze(mean(b(roi_f2,2:112),1)).',squeeze(mean(c(roi_dip,2:112),1)).'));xlim([0 112]);title('dip');ylim([1-0.2e-3 1+1e-3]);
subplot(3,1,3);plot(cat(2,squeeze(mean(a(roi_V2corco,2:112),1)).',squeeze(mean(b(roi_f2,2:112),1)).',squeeze(mean(c(roi_V2corco,2:112),1)).'));xlim([0 112]);title('V2corco');ylim([1-0.2e-3 1+1e-3]);







