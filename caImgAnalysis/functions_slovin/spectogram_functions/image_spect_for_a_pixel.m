%% image two conditions of a specific pixel
clear all
r='roi_V2';  %choose region of interest
pixel=4503;  %choose a pixel
first_cond='cond1';  %choose a first condition
second_cond='cond6';   %choose a second condition
clip=[-1 2];  %choose clipping for imagesc
clip2=[-1.5e-3 1.5e-3]; %choose clipping for time course
figure;

cd /fat2/Ariel_Gilad/Matlab_analysis/2008_02_19/rois   %directory of rois
load (r)   %load region of interest

cd /fat2/Ariel_Gilad/Matlab_analysis/2008_02_19/cond_data_a  %directory of time courses and spectograms


eval(['ind_pix=find(',r,'==pixel);'])    %find index of pixel

if ~isempty(ind_pix)
    eval(['load spect_pixel_wise_',first_cond,'_',r])    %load the first condition
    eval(['load spect_pixel_wise_',second_cond,'_',r])   %load the second condition

    x=(-30:(479-31))*4;
    y=1:125/64:125;
    
    subplot(3,2,1)
    eval(['imagesc(x,y,spect_pixel_wise_',first_cond,'_',r,'(:,:,ind_pix),clip);colormap(mapgeog);'])  %image the first condition
    %colorbar;
    xlabel('time (msec)');ylabel('Frequency (Hz)');
    title(first_cond)
    subplot(3,2,2)
    eval(['imagesc(x,y,spect_pixel_wise_',second_cond,'_',r,'(:,:,ind_pix),clip);colormap(mapgeog);'])  %image the second condition
    %colorbar;
    xlabel('time (msec)');ylabel('Frequency (Hz)');
    title(second_cond)

    eval(['clear spect_pixel_wise_',first_cond,'_',r])
    eval(['clear spect_pixel_wise_',second_cond,'_',r])

    eval(['load ',first_cond,'n_dt_hb'])  %load the first condition
    eval(['load ',second_cond,'n_dt_hb'])  %load the second condition

    x=(1:511)*4;
    subplot(3,2,3)
    eval(['plot(x,mean(',first_cond,'n_dt_hb(pixel,2:end,:)-1,3))'])  %plot time course of first condition
    title(['time course ',first_cond])
    xlabel('time (msec)');xlim([1 512*4]);ylim(clip); 
    
    subplot(3,2,4)
    eval(['plot(x,mean(',second_cond,'n_dt_hb(pixel,2:end,:)-1,3))'])  %plot time course of second condition
    title(['time course ',second_cond])
    xlabel('time (msec)');xlim([1 511*4]);ylim(clip2);
    
    
    eval(['clear ',first_cond,'n_dt_hb'])
    eval(['clear ',second_cond,'n_dt_hb'])
else
    disp(['pixel #',int2str(pixel),' is not in ',r])
end;
