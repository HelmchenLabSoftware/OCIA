%% image all the spectograms for all the rois for all conditions
x=(-8:214)*5;
y=1:100/64:100;
cd /fat2/Ariel_Gilad/Matlab_analysis/25oct2006/cond_data_b
load spect_pixel_wise_cond1_res_64_bl8_bl
figure(1);h = gcf;set(h,'Name','spectograms V1');
subplot(3,2,1);
imagesc(x,y,mean(spect_pixel_wise_cond1(:,:,roi_V1),3),[-0.25 5]);colorbar(mapgeog);%title('cond 1 s/n 4');
figure(2);h = gcf;set(h,'Name','spectograms V2');
subplot(3,2,1);
imagesc(x,y,mean(spect_pixel_wise_cond1(:,:,roi_V2),3),[-0.25 5]);colorbar(mapgeog);%title('cond 1 s/n 4');
figure(3);h = gcf;set(h,'Name','spectograms V4');
subplot(3,2,1);
imagesc(x,y,mean(spect_pixel_wise_cond1(:,:,roi_V4),3),[-0.25 5]);colorbar(mapgeog);%title('cond 1 s/n 4');
clear spect_pixel_wise_cond1
load spect_pixel_wise_cond2_res_64_bl8_bl
figure(1);subplot(3,2,2);
imagesc(x,y,mean(spect_pixel_wise_cond2(:,:,roi_V1),3),[-0.25 5]);colorbar(mapgeog);%title('cond 2 s/n 9');
figure(2);subplot(3,2,2);
imagesc(x,y,mean(spect_pixel_wise_cond2(:,:,roi_V2),3),[-0.25 5]);colorbar(mapgeog);%title('cond 2 s/n 9');
figure(3);subplot(3,2,2);
imagesc(x,y,mean(spect_pixel_wise_cond2(:,:,roi_V4),3),[-0.25 5]);colorbar(mapgeog);%title('cond 2 s/n 9');
clear spect_pixel_wise_cond2
load spect_pixel_wise_cond3_res_64_bl8_bl
figure(1);subplot(3,2,3);
imagesc(x,y,mean(spect_pixel_wise_cond3(:,:,roi_V1),3),[-0.25 5]);colorbar(mapgeog);%title('cond 3 s/n -1');
figure(2);subplot(3,2,3);
imagesc(x,y,mean(spect_pixel_wise_cond3(:,:,roi_V2),3),[-0.25 5]);colorbar(mapgeog);%title('cond 3 s/n -1');
figure(3);subplot(3,2,3);
imagesc(x,y,mean(spect_pixel_wise_cond3(:,:,roi_V4),3),[-0.25 5]);colorbar(mapgeog);%title('cond 3 s/n -1');
clear spect_pixel_wise_cond3
load spect_pixel_wise_cond4_res_64_bl8_bl
figure(1);subplot(3,2,4);
imagesc(x,y,mean(spect_pixel_wise_cond4(:,:,roi_V1),3),[-0.25 5]);colorbar(mapgeog);%title('cond 4 s/n 10');
figure(2);subplot(3,2,4);
imagesc(x,y,mean(spect_pixel_wise_cond4(:,:,roi_V2),3),[-0.25 5]);colorbar(mapgeog);%title('cond 4 s/n 10');
figure(3);subplot(3,2,4);
imagesc(x,y,mean(spect_pixel_wise_cond4(:,:,roi_V4),3),[-0.25 5]);colorbar(mapgeog);%title('cond 4 s/n 10');
clear spect_pixel_wise_cond4
load spect_pixel_wise_cond5_res_64_bl8_bl
figure(1);subplot(3,2,5);
imagesc(x,y,mean(spect_pixel_wise_cond5(:,:,roi_V1),3),[-0.25 5]);colorbar(mapgeog);%title('cond 5 monkey 8');
figure(2);subplot(3,2,5);
imagesc(x,y,mean(spect_pixel_wise_cond5(:,:,roi_V2),3),[-0.25 5]);colorbar(mapgeog);%title('cond 5 monkey 8');
figure(3);subplot(3,2,5);
imagesc(x,y,mean(spect_pixel_wise_cond5(:,:,roi_V4),3),[-0.25 5]);colorbar(mapgeog);%title('cond 5 monkey 8');
clear spect_pixel_wise_cond5
load spect_pixel_wise_cond6_res_64_bl8_bl
figure(1);subplot(3,2,6);
imagesc(x,y,mean(spect_pixel_wise_cond6(:,:,roi_V1),3),[-0.25 5]);colorbar(mapgeog);%title('cond 6 blank');
figure(2);subplot(3,2,6);
imagesc(x,y,mean(spect_pixel_wise_cond6(:,:,roi_V2),3),[-0.25 5]);colorbar(mapgeog);%title('cond 6 blank');
figure(3);subplot(3,2,6);
imagesc(x,y,mean(spect_pixel_wise_cond6(:,:,roi_V4),3),[-0.25 5]);colorbar(mapgeog);%title('cond 6 blank');
clear spect_pixel_wise_cond6

%% plot the different frequency bands
cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/cond_data
load spect_pixel_wise_cond1_res_64_bl8_hb
figure(4);h = gcf;set(h,'Name','frequency band 1-14 Hz');
subplot(3,2,1);
plot(mean(mean(spect_pixel_wise_cond1(1:7,:,roi_V1),1),3));
hold on;title('cond1');axis([1 256 -0.5 0.5]);
figure(5);h = gcf;set(h,'Name','frequency band 15-25 Hz');
subplot(3,2,1);
plot(mean(mean(spect_pixel_wise_cond1(8:13,:,roi_V1),1),3));
hold on;title('cond1');axis([1 256 -0.5 0.5]);
figure(6);h = gcf;set(h,'Name','frequency band 26-40 Hz');
subplot(3,2,1);
plot(mean(mean(spect_pixel_wise_cond1(13:20,:,roi_V1),1),3));
hold on;title('cond1');axis([1 256 -0.5 0.5]);
figure(7);h = gcf;set(h,'Name','frequency band 41-60 Hz');
subplot(3,2,1);
plot(mean(mean(spect_pixel_wise_cond1(21:30,:,roi_V1),1),3));
hold on;title('cond1');axis([1 256 -0.5 0.5]);
figure(8);h = gcf;set(h,'Name','frequency band 61-90 Hz');
subplot(3,2,1);
plot(mean(mean(spect_pixel_wise_cond1(31:45,:,roi_V1),1),3));
hold on;title('cond1');axis([1 256 -0.5 0.5]);
figure(9);h = gcf;set(h,'Name','frequency band 61-110 Hz');
subplot(3,2,1);
plot(mean(mean(spect_pixel_wise_cond1(31:55,:,roi_V1),1),3));
hold on;title('cond1');axis([1 256 -0.5 0.5]);
figure(4);subplot(3,2,1)
plot(mean(mean(spect_pixel_wise_cond1(1:7,:,roi_V2),1),3),'r');
hold on;
figure(5);subplot(3,2,1)
plot(mean(mean(spect_pixel_wise_cond1(8:13,:,roi_V2),1),3),'r');
hold on;
figure(6);subplot(3,2,1)
plot(mean(mean(spect_pixel_wise_cond1(13:20,:,roi_V2),1),3),'r');
hold on;
figure(7);subplot(3,2,1)
plot(mean(mean(spect_pixel_wise_cond1(21:30,:,roi_V2),1),3),'r');
hold on;
figure(8);subplot(3,2,1)
plot(mean(mean(spect_pixel_wise_cond1(31:45,:,roi_V2),1),3),'r');
hold on;
figure(9);subplot(3,2,1)
plot(mean(mean(spect_pixel_wise_cond1(31:55,:,roi_V2),1),3),'r');
hold on;
figure(4);subplot(3,2,1)
plot(mean(mean(spect_pixel_wise_cond1(1:7,:,roi_V4),1),3),'g');
hold on;
figure(5);subplot(3,2,1)
plot(mean(mean(spect_pixel_wise_cond1(8:13,:,roi_V4),1),3),'g');
hold on;
figure(6);subplot(3,2,1)
plot(mean(mean(spect_pixel_wise_cond1(13:20,:,roi_V4),1),3),'g');
hold on;
figure(7);subplot(3,2,1)
plot(mean(mean(spect_pixel_wise_cond1(21:30,:,roi_V4),1),3),'g');
hold on;
figure(8);subplot(3,2,1)
plot(mean(mean(spect_pixel_wise_cond1(31:45,:,roi_V4),1),3),'g');
hold on;
figure(9);subplot(3,2,1)
plot(mean(mean(spect_pixel_wise_cond1(31:55,:,roi_V4),1),3),'g');
hold on;
clear spect_pixel_wise_cond1
load spect_pixel_wise_cond2_res_64_bl8_hb
figure(4);subplot(3,2,2)
plot(mean(mean(spect_pixel_wise_cond2(1:7,:,roi_V1),1),3));
hold on;title('cond2');axis([1 256 -0.5 0.5]);
figure(5);subplot(3,2,2)
plot(mean(mean(spect_pixel_wise_cond2(8:13,:,roi_V1),1),3));
hold on;title('cond2');axis([1 256 -0.5 0.5]);
figure(6);subplot(3,2,2)
plot(mean(mean(spect_pixel_wise_cond2(13:20,:,roi_V1),1),3));
hold on;title('cond2');axis([1 256 -0.5 0.5]);
figure(7);subplot(3,2,2)
plot(mean(mean(spect_pixel_wise_cond2(21:30,:,roi_V1),1),3));
hold on;title('cond2');axis([1 256 -0.5 0.5]);
figure(8);subplot(3,2,2)
plot(mean(mean(spect_pixel_wise_cond2(31:45,:,roi_V1),1),3));
hold on;title('cond2');axis([1 256 -0.5 0.5]);
figure(9);subplot(3,2,2)
plot(mean(mean(spect_pixel_wise_cond2(31:55,:,roi_V1),1),3));
hold on;title('cond2');axis([1 256 -0.5 0.5]);
figure(4);subplot(3,2,2)
plot(mean(mean(spect_pixel_wise_cond2(1:7,:,roi_V2),1),3),'r');
hold on;
figure(5);subplot(3,2,2)
plot(mean(mean(spect_pixel_wise_cond2(8:13,:,roi_V2),1),3),'r');
hold on;
figure(6);subplot(3,2,2)
plot(mean(mean(spect_pixel_wise_cond2(13:20,:,roi_V2),1),3),'r');
hold on;
figure(7);subplot(3,2,2)
plot(mean(mean(spect_pixel_wise_cond2(21:30,:,roi_V2),1),3),'r');
hold on;
figure(8);subplot(3,2,2)
plot(mean(mean(spect_pixel_wise_cond2(31:45,:,roi_V2),1),3),'r');
hold on;
figure(9);subplot(3,2,2)
plot(mean(mean(spect_pixel_wise_cond2(31:55,:,roi_V2),1),3),'r');
hold on;
figure(4);subplot(3,2,2)
plot(mean(mean(spect_pixel_wise_cond2(1:7,:,roi_V4),1),3),'g');
hold on;
figure(5);subplot(3,2,2)
plot(mean(mean(spect_pixel_wise_cond2(8:13,:,roi_V4),1),3),'g');
hold on;
figure(6);subplot(3,2,2)
plot(mean(mean(spect_pixel_wise_cond2(13:20,:,roi_V4),1),3),'g');
hold on;
figure(7);subplot(3,2,2)
plot(mean(mean(spect_pixel_wise_cond2(21:30,:,roi_V4),1),3),'g');
hold on;
figure(8);subplot(3,2,2)
plot(mean(mean(spect_pixel_wise_cond2(31:45,:,roi_V4),1),3),'g');
hold on;
figure(9);subplot(3,2,2)
plot(mean(mean(spect_pixel_wise_cond2(31:55,:,roi_V4),1),3),'g');
hold on;
clear spect_pixel_wise_cond2
load spect_pixel_wise_cond3_res_64_bl8_hb
figure(4);subplot(3,2,3)
plot(mean(mean(spect_pixel_wise_cond3(1:7,:,roi_V1),1),3));
hold on;title('cond3');axis([1 256 -0.5 0.5]);
figure(5);subplot(3,2,3)
plot(mean(mean(spect_pixel_wise_cond3(8:13,:,roi_V1),1),3));
hold on;title('cond3');axis([1 256 -0.5 0.5]);
figure(6);subplot(3,2,3)
plot(mean(mean(spect_pixel_wise_cond3(13:20,:,roi_V1),1),3));
hold on;title('cond3');axis([1 256 -0.5 0.5]);
figure(7);subplot(3,2,3)
plot(mean(mean(spect_pixel_wise_cond3(21:30,:,roi_V1),1),3));
hold on;title('cond3');axis([1 256 -0.5 0.5]);
figure(8);subplot(3,2,3)
plot(mean(mean(spect_pixel_wise_cond3(31:45,:,roi_V1),1),3));
hold on;title('cond3');axis([1 256 -0.5 0.5]);
figure(9);subplot(3,2,3)
plot(mean(mean(spect_pixel_wise_cond3(31:55,:,roi_V1),1),3));
hold on;title('cond3');axis([1 256 -0.5 0.5]);
figure(4);subplot(3,2,3)
plot(mean(mean(spect_pixel_wise_cond3(1:7,:,roi_V2),1),3),'r');
hold on;
figure(5);subplot(3,2,3)
plot(mean(mean(spect_pixel_wise_cond3(8:13,:,roi_V2),1),3),'r');
hold on;
figure(6);subplot(3,2,3)
plot(mean(mean(spect_pixel_wise_cond3(13:20,:,roi_V2),1),3),'r');
hold on;
figure(7);subplot(3,2,3)
plot(mean(mean(spect_pixel_wise_cond3(21:30,:,roi_V2),1),3),'r');
hold on;
figure(8);subplot(3,2,3)
plot(mean(mean(spect_pixel_wise_cond3(31:45,:,roi_V2),1),3),'r');
hold on;
figure(9);subplot(3,2,3)
plot(mean(mean(spect_pixel_wise_cond3(31:55,:,roi_V2),1),3),'r');
hold on;
figure(4);subplot(3,2,3)
plot(mean(mean(spect_pixel_wise_cond3(1:7,:,roi_V4),1),3),'g');
hold on;
figure(5);subplot(3,2,3)
plot(mean(mean(spect_pixel_wise_cond3(8:13,:,roi_V4),1),3),'g');
hold on;
figure(6);subplot(3,2,3)
plot(mean(mean(spect_pixel_wise_cond3(13:20,:,roi_V4),1),3),'g');
hold on;
figure(7);subplot(3,2,3)
plot(mean(mean(spect_pixel_wise_cond3(21:30,:,roi_V4),1),3),'g');
hold on;
figure(8);subplot(3,2,3)
plot(mean(mean(spect_pixel_wise_cond3(31:45,:,roi_V4),1),3),'g');
hold on;
figure(9);subplot(3,2,3)
plot(mean(mean(spect_pixel_wise_cond3(31:55,:,roi_V4),1),3),'g');
hold on;
clear spect_pixel_wise_cond3
load spect_pixel_wise_cond4_res_64_bl8_hb
figure(4);subplot(3,2,4)
plot(mean(mean(spect_pixel_wise_cond4(1:7,:,roi_V1),1),3));
hold on;title('cond4');axis([1 256 -0.5 0.5]);
figure(5);subplot(3,2,4)
plot(mean(mean(spect_pixel_wise_cond4(8:13,:,roi_V1),1),3));
hold on;title('cond4');axis([1 256 -0.5 0.5]);
figure(6);subplot(3,2,4)
plot(mean(mean(spect_pixel_wise_cond4(13:20,:,roi_V1),1),3));
hold on;title('cond4');axis([1 256 -0.5 0.5]);
figure(7);subplot(3,2,4)
plot(mean(mean(spect_pixel_wise_cond4(21:30,:,roi_V1),1),3));
hold on;title('cond4');axis([1 256 -0.5 0.5]);
figure(8);subplot(3,2,4)
plot(mean(mean(spect_pixel_wise_cond4(31:45,:,roi_V1),1),3));
hold on;title('cond4');axis([1 256 -0.5 0.5]);
figure(9);subplot(3,2,4)
plot(mean(mean(spect_pixel_wise_cond4(31:55,:,roi_V1),1),3));
hold on;title('cond4');axis([1 256 -0.5 0.5]);
figure(4);subplot(3,2,4)
plot(mean(mean(spect_pixel_wise_cond4(1:7,:,roi_V2),1),3),'r');
hold on;
figure(5);subplot(3,2,4)
plot(mean(mean(spect_pixel_wise_cond4(8:13,:,roi_V2),1),3),'r');
hold on;
figure(6);subplot(3,2,4)
plot(mean(mean(spect_pixel_wise_cond4(13:20,:,roi_V2),1),3),'r');
hold on;
figure(7);subplot(3,2,4)
plot(mean(mean(spect_pixel_wise_cond4(21:30,:,roi_V2),1),3),'r');
hold on;
figure(8);subplot(3,2,4)
plot(mean(mean(spect_pixel_wise_cond4(31:45,:,roi_V2),1),3),'r');
hold on;
figure(9);subplot(3,2,4)
plot(mean(mean(spect_pixel_wise_cond4(31:55,:,roi_V2),1),3),'r');
hold on;
figure(4);subplot(3,2,4)
plot(mean(mean(spect_pixel_wise_cond4(1:7,:,roi_V4),1),3),'g');
hold on;
figure(5);subplot(3,2,4)
plot(mean(mean(spect_pixel_wise_cond4(8:13,:,roi_V4),1),3),'g');
hold on;
figure(6);subplot(3,2,4)
plot(mean(mean(spect_pixel_wise_cond4(13:20,:,roi_V4),1),3),'g');
hold on;
figure(7);subplot(3,2,4)
plot(mean(mean(spect_pixel_wise_cond4(21:30,:,roi_V4),1),3),'g');
hold on;
figure(8);subplot(3,2,4)
plot(mean(mean(spect_pixel_wise_cond4(31:45,:,roi_V4),1),3),'g');
hold on;
figure(9);subplot(3,2,4)
plot(mean(mean(spect_pixel_wise_cond4(31:55,:,roi_V4),1),3),'g');
hold on;
clear spect_pixel_wise_cond4
load spect_pixel_wise_cond5_res_64_bl8_hb
figure(4);subplot(3,2,5)
plot(mean(mean(spect_pixel_wise_cond5(1:7,:,roi_V1),1),3));
hold on;title('cond5');axis([1 256 -0.5 0.5]);
figure(5);subplot(3,2,5)
plot(mean(mean(spect_pixel_wise_cond5(8:13,:,roi_V1),1),3));
hold on;title('cond5');axis([1 256 -0.5 0.5]);
figure(6);subplot(3,2,5)
plot(mean(mean(spect_pixel_wise_cond5(13:20,:,roi_V1),1),3));
hold on;title('cond5');axis([1 256 -0.5 0.5]);
figure(7);subplot(3,2,5)
plot(mean(mean(spect_pixel_wise_cond5(21:30,:,roi_V1),1),3));
hold on;title('cond5');axis([1 256 -0.5 0.5]);
figure(8);subplot(3,2,5)
plot(mean(mean(spect_pixel_wise_cond5(31:45,:,roi_V1),1),3));
hold on;title('cond5');axis([1 256 -0.5 0.5]);
figure(9);subplot(3,2,5)
plot(mean(mean(spect_pixel_wise_cond5(31:55,:,roi_V1),1),3));
hold on;title('cond5');axis([1 256 -0.5 0.5]);
figure(4);subplot(3,2,5)
plot(mean(mean(spect_pixel_wise_cond5(1:7,:,roi_V2),1),3),'r');
hold on;
figure(5);subplot(3,2,5)
plot(mean(mean(spect_pixel_wise_cond5(8:13,:,roi_V2),1),3),'r');
hold on;
figure(6);subplot(3,2,5)
plot(mean(mean(spect_pixel_wise_cond5(13:20,:,roi_V2),1),3),'r');
hold on;
figure(7);subplot(3,2,5)
plot(mean(mean(spect_pixel_wise_cond5(21:30,:,roi_V2),1),3),'r');
hold on;
figure(8);subplot(3,2,5)
plot(mean(mean(spect_pixel_wise_cond5(31:45,:,roi_V2),1),3),'r');
hold on;
figure(9);subplot(3,2,5)
plot(mean(mean(spect_pixel_wise_cond5(31:55,:,roi_V2),1),3),'r');
hold on;
figure(4);subplot(3,2,5)
plot(mean(mean(spect_pixel_wise_cond5(1:7,:,roi_V4),1),3),'g');
hold on;
figure(5);subplot(3,2,5)
plot(mean(mean(spect_pixel_wise_cond5(8:13,:,roi_V4),1),3),'g');
hold on;
figure(6);subplot(3,2,5)
plot(mean(mean(spect_pixel_wise_cond5(13:20,:,roi_V4),1),3),'g');
hold on;
figure(7);subplot(3,2,5)
plot(mean(mean(spect_pixel_wise_cond5(21:30,:,roi_V4),1),3),'g');
hold on;
figure(8);subplot(3,2,5)
plot(mean(mean(spect_pixel_wise_cond5(31:45,:,roi_V4),1),3),'g');
hold on;
figure(9);subplot(3,2,5)
plot(mean(mean(spect_pixel_wise_cond5(31:55,:,roi_V4),1),3),'g');
hold on;
clear spect_pixel_wise_cond5
load spect_pixel_wise_cond6_res_64_bl8_hb
figure(4);subplot(3,2,6)
plot(mean(mean(spect_pixel_wise_cond6(1:7,:,roi_V1),1),3));
hold on;title('cond6');axis([1 256 -0.5 0.5]);
figure(5);subplot(3,2,6)
plot(mean(mean(spect_pixel_wise_cond6(8:13,:,roi_V1),1),3));
hold on;title('cond6');axis([1 256 -0.5 0.5]);
figure(6);subplot(3,2,6)
plot(mean(mean(spect_pixel_wise_cond6(13:20,:,roi_V1),1),3));
hold on;title('cond6');axis([1 256 -0.5 0.5]);
figure(7);subplot(3,2,6)
plot(mean(mean(spect_pixel_wise_cond6(21:30,:,roi_V1),1),3));
hold on;title('cond6');axis([1 256 -0.5 0.5]);
figure(8);subplot(3,2,6)
plot(mean(mean(spect_pixel_wise_cond6(31:45,:,roi_V1),1),3));
hold on;title('cond6');axis([1 256 -0.5 0.5]);
figure(9);subplot(3,2,6)
plot(mean(mean(spect_pixel_wise_cond6(31:55,:,roi_V1),1),3));
hold on;title('cond6');axis([1 256 -0.5 0.5]);
figure(4);subplot(3,2,6)
plot(mean(mean(spect_pixel_wise_cond6(1:7,:,roi_V2),1),3),'r');
hold on;title('cond6');
figure(5);subplot(3,2,6)
plot(mean(mean(spect_pixel_wise_cond6(8:13,:,roi_V2),1),3),'r');
hold on;title('cond6');
figure(6);subplot(3,2,6)
plot(mean(mean(spect_pixel_wise_cond6(13:20,:,roi_V2),1),3),'r');
hold on;title('cond6');
figure(7);subplot(3,2,6)
plot(mean(mean(spect_pixel_wise_cond6(21:30,:,roi_V2),1),3),'r');
hold on;title('cond6');
figure(8);subplot(3,2,6)
plot(mean(mean(spect_pixel_wise_cond6(31:45,:,roi_V2),1),3),'r');
hold on;title('cond6');
figure(9);subplot(3,2,6)
plot(mean(mean(spect_pixel_wise_cond6(31:55,:,roi_V2),1),3),'r');
hold on;title('cond6');
figure(4);subplot(3,2,6)
plot(mean(mean(spect_pixel_wise_cond6(1:7,:,roi_V4),1),3),'g');
hold on;legend('V1','V2','V4');
figure(5);subplot(3,2,6)
plot(mean(mean(spect_pixel_wise_cond6(8:13,:,roi_V4),1),3),'g');
hold on;legend('V1','V2','V4');
figure(6);subplot(3,2,6)
plot(mean(mean(spect_pixel_wise_cond6(13:20,:,roi_V4),1),3),'g');
hold on;legend('V1','V2','V4');
figure(7);subplot(3,2,6)
plot(mean(mean(spect_pixel_wise_cond6(21:30,:,roi_V4),1),3),'g');
hold on;legend('V1','V2','V4');
figure(8);subplot(3,2,6)
plot(mean(mean(spect_pixel_wise_cond6(31:45,:,roi_V4),1),3),'g');
hold on;legend('V1','V2','V4');
figure(9);subplot(3,2,6)
plot(mean(mean(spect_pixel_wise_cond6(31:55,:,roi_V4),1),3),'g');
hold on;legend('V1','V2','V4');
clear spect_pixel_wise_cond6

%% sum

cd /fat2/Ariel_Gilad/Matlab_analysis/2008_01_15/cond_data
load spect_pixel_wise_cond1_res_64_bl8_hb
figure(14);h = gcf;set(h,'Name','frequency band 1-14 Hz');
subplot(3,2,1);
plot(mean(sum(spect_pixel_wise_cond1(1:7,:,roi_V1),1),3));
hold on;title('cond1');%axis([1 100 -0.5 0.5]);
figure(15);h = gcf;set(h,'Name','frequency band 15-25 Hz');
subplot(3,2,1);
plot(mean(sum(spect_pixel_wise_cond1(8:13,:,roi_V1),1),3));
hold on;title('cond1');%axis([1 100 -0.5 0.5]);
figure(16);h = gcf;set(h,'Name','frequency band 26-40 Hz');
subplot(3,2,1);
plot(mean(sum(spect_pixel_wise_cond1(13:20,:,roi_V1),1),3));
hold on;title('cond1');%axis([1 100 -0.5 0.5]);
figure(17);h = gcf;set(h,'Name','frequency band 41-60 Hz');
subplot(3,2,1);
plot(mean(sum(spect_pixel_wise_cond1(21:30,:,roi_V1),1),3));
hold on;title('cond1');%axis([1 256 -0.5 0.5]);
figure(18);h = gcf;set(h,'Name','frequency band 61-90 Hz');
subplot(3,2,1);
plot(mean(sum(spect_pixel_wise_cond1(31:45,:,roi_V1),1),3));
hold on;title('cond1');%axis([1 100 -0.5 0.5]);
figure(19);h = gcf;set(h,'Name','frequency band 61-110 Hz');
subplot(3,2,1);
plot(mean(sum(spect_pixel_wise_cond1(31:55,:,roi_V1),1),3));
hold on;title('cond1');%axis([1 100 -0.5 0.5]);
figure(14);subplot(3,2,1)
plot(mean(sum(spect_pixel_wise_cond1(1:7,:,roi_V2),1),3),'r');
hold on;
figure(15);subplot(3,2,1)
plot(mean(sum(spect_pixel_wise_cond1(8:13,:,roi_V2),1),3),'r');
hold on;
figure(16);subplot(3,2,1)
plot(mean(sum(spect_pixel_wise_cond1(13:20,:,roi_V2),1),3),'r');
hold on;
figure(17);subplot(3,2,1)
plot(mean(sum(spect_pixel_wise_cond1(21:30,:,roi_V2),1),3),'r');
hold on;
figure(18);subplot(3,2,1)
plot(mean(sum(spect_pixel_wise_cond1(31:45,:,roi_V2),1),3),'r');
hold on;
figure(19);subplot(3,2,1)
plot(mean(sum(spect_pixel_wise_cond1(31:55,:,roi_V2),1),3),'r');
hold on;
figure(14);subplot(3,2,1)
plot(mean(sum(spect_pixel_wise_cond1(1:7,:,roi_V4),1),3),'g');
hold on;
figure(15);subplot(3,2,1)
plot(mean(sum(spect_pixel_wise_cond1(8:13,:,roi_V4),1),3),'g');
hold on;
figure(16);subplot(3,2,1)
plot(mean(sum(spect_pixel_wise_cond1(13:20,:,roi_V4),1),3),'g');
hold on;
figure(17);subplot(3,2,1)
plot(mean(sum(spect_pixel_wise_cond1(21:30,:,roi_V4),1),3),'g');
hold on;
figure(18);subplot(3,2,1)
plot(mean(sum(spect_pixel_wise_cond1(31:45,:,roi_V4),1),3),'g');
hold on;
figure(19);subplot(3,2,1)
plot(mean(sum(spect_pixel_wise_cond1(31:55,:,roi_V4),1),3),'g');
hold on;
clear spect_pixel_wise_cond1
load spect_pixel_wise_cond2_res_64_bl8_hb
figure(14);subplot(3,2,2)
plot(mean(sum(spect_pixel_wise_cond2(1:7,:,roi_V1),1),3));
hold on;title('cond2');%axis([1 256 -0.5 0.5]);
figure(15);subplot(3,2,2)
plot(mean(sum(spect_pixel_wise_cond2(8:13,:,roi_V1),1),3));
hold on;title('cond2');%axis([1 256 -0.5 0.5]);
figure(16);subplot(3,2,2)
plot(mean(sum(spect_pixel_wise_cond2(13:20,:,roi_V1),1),3));
hold on;title('cond2');%axis([1 256 -0.5 0.5]);
figure(17);subplot(3,2,2)
plot(mean(sum(spect_pixel_wise_cond2(21:30,:,roi_V1),1),3));
hold on;title('cond2');%axis([1 256 -0.5 0.5]);
figure(18);subplot(3,2,2)
plot(mean(sum(spect_pixel_wise_cond2(31:45,:,roi_V1),1),3));
hold on;title('cond2');%axis([1 256 -0.5 0.5]);
figure(19);subplot(3,2,2)
plot(mean(sum(spect_pixel_wise_cond2(31:55,:,roi_V1),1),3));
hold on;title('cond2');%axis([1 256 -0.5 0.5]);
figure(14);subplot(3,2,2)
plot(mean(sum(spect_pixel_wise_cond2(1:7,:,roi_V2),1),3),'r');
hold on;
figure(15);subplot(3,2,2)
plot(mean(sum(spect_pixel_wise_cond2(8:13,:,roi_V2),1),3),'r');
hold on;
figure(16);subplot(3,2,2)
plot(mean(sum(spect_pixel_wise_cond2(13:20,:,roi_V2),1),3),'r');
hold on;
figure(17);subplot(3,2,2)
plot(mean(sum(spect_pixel_wise_cond2(21:30,:,roi_V2),1),3),'r');
hold on;
figure(18);subplot(3,2,2)
plot(mean(sum(spect_pixel_wise_cond2(31:45,:,roi_V2),1),3),'r');
hold on;
figure(19);subplot(3,2,2)
plot(mean(sum(spect_pixel_wise_cond2(31:55,:,roi_V2),1),3),'r');
hold on;
figure(14);subplot(3,2,2)
plot(mean(sum(spect_pixel_wise_cond2(1:7,:,roi_V4),1),3),'g');
hold on;
figure(15);subplot(3,2,2)
plot(mean(sum(spect_pixel_wise_cond2(8:13,:,roi_V4),1),3),'g');
hold on;
figure(16);subplot(3,2,2)
plot(mean(sum(spect_pixel_wise_cond2(13:20,:,roi_V4),1),3),'g');
hold on;
figure(17);subplot(3,2,2)
plot(mean(sum(spect_pixel_wise_cond2(21:30,:,roi_V4),1),3),'g');
hold on;
figure(18);subplot(3,2,2)
plot(mean(sum(spect_pixel_wise_cond2(31:45,:,roi_V4),1),3),'g');
hold on;
figure(19);subplot(3,2,2)
plot(mean(sum(spect_pixel_wise_cond2(31:55,:,roi_V4),1),3),'g');
hold on;
clear spect_pixel_wise_cond2
load spect_pixel_wise_cond3_res_64_bl8_hb
figure(14);subplot(3,2,3)
plot(mean(sum(spect_pixel_wise_cond3(1:7,:,roi_V1),1),3));
hold on;title('cond3');%axis([1 256 -0.5 0.5]);
figure(15);subplot(3,2,3)
plot(mean(sum(spect_pixel_wise_cond3(8:13,:,roi_V1),1),3));
hold on;title('cond3');%axis([1 256 -0.5 0.5]);
figure(16);subplot(3,2,3)
plot(mean(sum(spect_pixel_wise_cond3(13:20,:,roi_V1),1),3));
hold on;title('cond3');%axis([1 256 -0.5 0.5]);
figure(17);subplot(3,2,3)
plot(mean(sum(spect_pixel_wise_cond3(21:30,:,roi_V1),1),3));
hold on;title('cond3');%axis([1 256 -0.5 0.5]);
figure(18);subplot(3,2,3)
plot(mean(sum(spect_pixel_wise_cond3(31:45,:,roi_V1),1),3));
hold on;title('cond3');%axis([1 256 -0.5 0.5]);
figure(19);subplot(3,2,3)
plot(mean(sum(spect_pixel_wise_cond3(31:55,:,roi_V1),1),3));
hold on;title('cond3');%axis([1 256 -0.5 0.5]);
figure(14);subplot(3,2,3)
plot(mean(sum(spect_pixel_wise_cond3(1:7,:,roi_V2),1),3),'r');
hold on;
figure(15);subplot(3,2,3)
plot(mean(sum(spect_pixel_wise_cond3(8:13,:,roi_V2),1),3),'r');
hold on;
figure(16);subplot(3,2,3)
plot(mean(sum(spect_pixel_wise_cond3(13:20,:,roi_V2),1),3),'r');
hold on;
figure(17);subplot(3,2,3)
plot(mean(sum(spect_pixel_wise_cond3(21:30,:,roi_V2),1),3),'r');
hold on;
figure(18);subplot(3,2,3)
plot(mean(sum(spect_pixel_wise_cond3(31:45,:,roi_V2),1),3),'r');
hold on;
figure(19);subplot(3,2,3)
plot(mean(sum(spect_pixel_wise_cond3(31:55,:,roi_V2),1),3),'r');
hold on;
figure(14);subplot(3,2,3)
plot(mean(sum(spect_pixel_wise_cond3(1:7,:,roi_V4),1),3),'g');
hold on;
figure(15);subplot(3,2,3)
plot(mean(sum(spect_pixel_wise_cond3(8:13,:,roi_V4),1),3),'g');
hold on;
figure(16);subplot(3,2,3)
plot(mean(sum(spect_pixel_wise_cond3(13:20,:,roi_V4),1),3),'g');
hold on;
figure(17);subplot(3,2,3)
plot(mean(sum(spect_pixel_wise_cond3(21:30,:,roi_V4),1),3),'g');
hold on;
figure(18);subplot(3,2,3)
plot(mean(sum(spect_pixel_wise_cond3(31:45,:,roi_V4),1),3),'g');
hold on;
figure(19);subplot(3,2,3)
plot(mean(sum(spect_pixel_wise_cond3(31:55,:,roi_V4),1),3),'g');
hold on;
clear spect_pixel_wise_cond3
load spect_pixel_wise_cond4_res_64_bl8_hb
figure(14);subplot(3,2,4)
plot(mean(sum(spect_pixel_wise_cond4(1:7,:,roi_V1),1),3));
hold on;title('cond4');%axis([1 256 -0.5 0.5]);
figure(15);subplot(3,2,4)
plot(mean(sum(spect_pixel_wise_cond4(8:13,:,roi_V1),1),3));
hold on;title('cond4');%axis([1 256 -0.5 0.5]);
figure(16);subplot(3,2,4)
plot(mean(sum(spect_pixel_wise_cond4(13:20,:,roi_V1),1),3));
hold on;title('cond4');%axis([1 256 -0.5 0.5]);
figure(17);subplot(3,2,4)
plot(mean(sum(spect_pixel_wise_cond4(21:30,:,roi_V1),1),3));
hold on;title('cond4');%axis([1 256 -0.5 0.5]);
figure(18);subplot(3,2,4)
plot(mean(sum(spect_pixel_wise_cond4(31:45,:,roi_V1),1),3));
hold on;title('cond4');%axis([1 256 -0.5 0.5]);
figure(19);subplot(3,2,4)
plot(mean(sum(spect_pixel_wise_cond4(31:55,:,roi_V1),1),3));
hold on;title('cond4');%axis([1 256 -0.5 0.5]);
figure(14);subplot(3,2,4)
plot(mean(sum(spect_pixel_wise_cond4(1:7,:,roi_V2),1),3),'r');
hold on;
figure(15);subplot(3,2,4)
plot(mean(sum(spect_pixel_wise_cond4(8:13,:,roi_V2),1),3),'r');
hold on;
figure(16);subplot(3,2,4)
plot(mean(sum(spect_pixel_wise_cond4(13:20,:,roi_V2),1),3),'r');
hold on;
figure(17);subplot(3,2,4)
plot(mean(sum(spect_pixel_wise_cond4(21:30,:,roi_V2),1),3),'r');
hold on;
figure(18);subplot(3,2,4)
plot(mean(sum(spect_pixel_wise_cond4(31:45,:,roi_V2),1),3),'r');
hold on;
figure(19);subplot(3,2,4)
plot(mean(sum(spect_pixel_wise_cond4(31:55,:,roi_V2),1),3),'r');
hold on;
figure(14);subplot(3,2,4)
plot(mean(sum(spect_pixel_wise_cond4(1:7,:,roi_V4),1),3),'g');
hold on;
figure(15);subplot(3,2,4)
plot(mean(sum(spect_pixel_wise_cond4(8:13,:,roi_V4),1),3),'g');
hold on;
figure(16);subplot(3,2,4)
plot(mean(sum(spect_pixel_wise_cond4(13:20,:,roi_V4),1),3),'g');
hold on;
figure(17);subplot(3,2,4)
plot(mean(sum(spect_pixel_wise_cond4(21:30,:,roi_V4),1),3),'g');
hold on;
figure(18);subplot(3,2,4)
plot(mean(sum(spect_pixel_wise_cond4(31:45,:,roi_V4),1),3),'g');
hold on;
figure(19);subplot(3,2,4)
plot(mean(sum(spect_pixel_wise_cond4(31:55,:,roi_V4),1),3),'g');
hold on;
clear spect_pixel_wise_cond4
load spect_pixel_wise_cond5_res_64_bl8_hb
figure(14);subplot(3,2,5)
plot(mean(sum(spect_pixel_wise_cond5(1:7,:,roi_V1),1),3));
hold on;title('cond5');axis([1 256 -0.5 0.5]);
figure(15);subplot(3,2,5)
plot(mean(sum(spect_pixel_wise_cond5(8:13,:,roi_V1),1),3));
hold on;title('cond5');%axis([1 256 -0.5 0.5]);
figure(16);subplot(3,2,5)
plot(mean(sum(spect_pixel_wise_cond5(13:20,:,roi_V1),1),3));
hold on;title('cond5');%axis([1 256 -0.5 0.5]);
figure(17);subplot(3,2,5)
plot(mean(sum(spect_pixel_wise_cond5(21:30,:,roi_V1),1),3));
hold on;title('cond5');%axis([1 256 -0.5 0.5]);
figure(18);subplot(3,2,5)
plot(mean(sum(spect_pixel_wise_cond5(31:45,:,roi_V1),1),3));
hold on;title('cond5');%axis([1 256 -0.5 0.5]);
figure(19);subplot(3,2,5)
plot(mean(sum(spect_pixel_wise_cond5(31:55,:,roi_V1),1),3));
hold on;title('cond5');%axis([1 256 -0.5 0.5]);
figure(14);subplot(3,2,5)
plot(mean(sum(spect_pixel_wise_cond5(1:7,:,roi_V2),1),3),'r');
hold on;
figure(15);subplot(3,2,5)
plot(mean(sum(spect_pixel_wise_cond5(8:13,:,roi_V2),1),3),'r');
hold on;
figure(16);subplot(3,2,5)
plot(mean(sum(spect_pixel_wise_cond5(13:20,:,roi_V2),1),3),'r');
hold on;
figure(17);subplot(3,2,5)
plot(mean(sum(spect_pixel_wise_cond5(21:30,:,roi_V2),1),3),'r');
hold on;
figure(18);subplot(3,2,5)
plot(mean(sum(spect_pixel_wise_cond5(31:45,:,roi_V2),1),3),'r');
hold on;
figure(19);subplot(3,2,5)
plot(mean(sum(spect_pixel_wise_cond5(31:55,:,roi_V2),1),3),'r');
hold on;
figure(14);subplot(3,2,5)
plot(mean(sum(spect_pixel_wise_cond5(1:7,:,roi_V4),1),3),'g');
hold on;
figure(15);subplot(3,2,5)
plot(mean(sum(spect_pixel_wise_cond5(8:13,:,roi_V4),1),3),'g');
hold on;
figure(16);subplot(3,2,5)
plot(mean(sum(spect_pixel_wise_cond5(13:20,:,roi_V4),1),3),'g');
hold on;
figure(17);subplot(3,2,5)
plot(mean(sum(spect_pixel_wise_cond5(21:30,:,roi_V4),1),3),'g');
hold on;
figure(18);subplot(3,2,5)
plot(mean(sum(spect_pixel_wise_cond5(31:45,:,roi_V4),1),3),'g');
hold on;
figure(19);subplot(3,2,5)
plot(mean(sum(spect_pixel_wise_cond5(31:55,:,roi_V4),1),3),'g');
hold on;
clear spect_pixel_wise_cond5
load spect_pixel_wise_cond6_res_64_bl8_hb
figure(14);subplot(3,2,6)
plot(mean(sum(spect_pixel_wise_cond6(1:7,:,roi_V1),1),3));
hold on;title('cond6');%axis([1 256 -0.5 0.5]);
figure(15);subplot(3,2,6)
plot(mean(sum(spect_pixel_wise_cond6(8:13,:,roi_V1),1),3));
hold on;title('cond6');%axis([1 256 -0.5 0.5]);
figure(16);subplot(3,2,6)
plot(mean(sum(spect_pixel_wise_cond6(13:20,:,roi_V1),1),3));
hold on;title('cond6');%axis([1 256 -0.5 0.5]);
figure(17);subplot(3,2,6)
plot(mean(sum(spect_pixel_wise_cond6(21:30,:,roi_V1),1),3));
hold on;title('cond6');%axis([1 256 -0.5 0.5]);
figure(18);subplot(3,2,6)
plot(mean(sum(spect_pixel_wise_cond6(31:45,:,roi_V1),1),3));
hold on;title('cond6');%axis([1 256 -0.5 0.5]);
figure(19);subplot(3,2,6)
plot(mean(sum(spect_pixel_wise_cond6(31:55,:,roi_V1),1),3));
hold on;title('cond6');%axis([1 256 -0.5 0.5]);
figure(14);subplot(3,2,6)
plot(mean(sum(spect_pixel_wise_cond6(1:7,:,roi_V2),1),3),'r');
hold on;title('cond6');
figure(15);subplot(3,2,6)
plot(mean(sum(spect_pixel_wise_cond6(8:13,:,roi_V2),1),3),'r');
hold on;title('cond6');
figure(16);subplot(3,2,6)
plot(mean(sum(spect_pixel_wise_cond6(13:20,:,roi_V2),1),3),'r');
hold on;title('cond6');
figure(17);subplot(3,2,6)
plot(mean(sum(spect_pixel_wise_cond6(21:30,:,roi_V2),1),3),'r');
hold on;title('cond6');
figure(18);subplot(3,2,6)
plot(mean(sum(spect_pixel_wise_cond6(31:45,:,roi_V2),1),3),'r');
hold on;title('cond6');
figure(19);subplot(3,2,6)
plot(mean(sum(spect_pixel_wise_cond6(31:55,:,roi_V2),1),3),'r');
hold on;title('cond6');
figure(14);subplot(3,2,6)
plot(mean(sum(spect_pixel_wise_cond6(1:7,:,roi_V4),1),3),'g');
hold on;legend('V1','V2','V4');
figure(15);subplot(3,2,6)
plot(mean(sum(spect_pixel_wise_cond6(8:13,:,roi_V4),1),3),'g');
hold on;legend('V1','V2','V4');
figure(16);subplot(3,2,6)
plot(mean(sum(spect_pixel_wise_cond6(13:20,:,roi_V4),1),3),'g');
hold on;legend('V1','V2','V4');
figure(17);subplot(3,2,6)
plot(mean(sum(spect_pixel_wise_cond6(21:30,:,roi_V4),1),3),'g');
hold on;legend('V1','V2','V4');
figure(18);subplot(3,2,6)
plot(mean(sum(spect_pixel_wise_cond6(31:45,:,roi_V4),1),3),'g');
hold on;legend('V1','V2','V4');
figure(19);subplot(3,2,6)
plot(mean(sum(spect_pixel_wise_cond6(31:55,:,roi_V4),1),3),'g');
hold on;legend('V1','V2','V4');
clear spect_pixel_wise_cond6