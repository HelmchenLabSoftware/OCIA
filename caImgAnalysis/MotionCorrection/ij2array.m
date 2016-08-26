function array = ij2array(ImagePlus)


ijstack=ImagePlus.getImageStack();

slices=ijstack.getSize();
width=ijstack.getWidth();
height=ijstack.getHeight();

pixelarray = ijstack.getImageArray();
cellarray=cell(pixelarray);
array=cell2mat(cellarray(1:slices));
array=reshape(array,width,height,slices);
array=permute(array,[2 1 3]);