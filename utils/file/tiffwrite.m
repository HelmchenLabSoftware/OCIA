function tiffwrite(stack,fname)
%writes a stack of integer to a 16 bit tiff file 
%fname is the file name of the stored tiff file

nframes = size(stack,3);

for j = 1:nframes
    if j == 1
       %disp(['Writing ',fname]);
       imwrite(stack(:,:,j),fname,'WriteMode','overwrite','compression','none');
    else
       %disp(['Appending to ', fname]);
       imwrite(stack(:,:,j),fname,'WriteMode','append','compression','none');
    end
end    