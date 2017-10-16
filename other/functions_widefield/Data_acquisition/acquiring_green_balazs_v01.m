
pix=512;
a=imread('Tiff_files/Trial1frame2');
green=im2double(a);
figure(100);imagesc(PseudoFlatfieldCorrect(green), [-0.1 0.9]); colormap(gray)
chamber = choose_polygon_imagesc(pix);      

t=zeros(pix*pix,1);
t(chamber)=1;
pixels_to_remove=find(t==0);

if exist('Matt_files', 'dir') ~= 7; mkdir('Matt_files'); end;
save('Matt_files/pixels_to_remove.mat', 'pixels_to_remove', 'chamber');

saveas(gcf, 'Matt_files/referenceWithROIs.fig');


%% down sampling
ds=2;
green_ds = imresize(green, 1/ds, 'box');

%%
figure;
imagesc(PseudoFlatfieldCorrect(green_ds));
colormap(gray)
refImg = green_ds;
save('Matt_files/refImg.mat', 'refImg')