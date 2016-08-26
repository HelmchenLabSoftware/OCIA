cd D:\intrinsic\ruler_nov2015\Tiff_files
pix=512;
a=imread('Trial1frame2');
green=im2double(a);
figure(100);imagesc(green,[-0.1 0.9]);colormap(gray)
chamber_length=512/sqrt((357-305)^2+(208-211)^2)

chamber_length/205

chamber_length/256


1/(chamber_length/205)
1/(chamber_length/256)


res_vec_205=(1:205)*chamber_length/205;
res_vec_256=(1:256)*chamber_length/256;

cd D:\intrinsic\ruler_nov2015
save resolution_vectors res_*




%% another ruler test

cd D:\intrinsic\ruler_jan2016\Tiff_files
pix=512;
a=imread('Trial1frame2');
green=im2double(a);
figure;imagesc(green,[-0.1 0.9]);colormap(gray)
chamber_length=512/sqrt((216-272)^2+(283-280)^2)

chamber_length/205

chamber_length/256


1/(chamber_length/205)
1/(chamber_length/256)


res_vec_205=(1:205)*chamber_length/205;
res_vec_256=(1:256)*chamber_length/256;


a=imread('Trial2frame2');
green=im2double(a);
figure;imagesc(green,[-0.1 0.9]);colormap(gray)
chamber_length=512/sqrt((269-280)^2+(401-455)^2)

chamber_length/205

chamber_length/256


1/(chamber_length/205)
1/(chamber_length/256)


res_vec_205_2=(1:205)*chamber_length/205;
res_vec_256_2=(1:256)*chamber_length/256;

cd D:\intrinsic\ruler_jan2016
save resolution_vectors res_*





