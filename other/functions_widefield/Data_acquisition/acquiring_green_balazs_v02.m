
pix=512; nFrames = 200;
a = readDCAM('20162705_120832_1', nFrames, [pix pix]);
green=squeeze(a(:, :, 1))';
figure(100);imagesc(PseudoFlatfieldCorrect(green), [-0.05 0.3]); colormap(gray)
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