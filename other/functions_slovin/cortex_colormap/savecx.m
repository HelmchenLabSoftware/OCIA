function savecxx(filename, notes, dmns, imgmtx,offset)

% SAVECX(filename, notes, dmns, imgmtx)
%       save the image files as a cortex readable image file.
%       filename,       path should be included
%       notes,          maximume 10 characters
%       dmns=[depth, x, y, nframes], in which
%               depth,          bitmap depth (1,2,4, or 8)
%               x,              x dimension of the image
%               y,              y dimension of the image
%               nframes,        number of frames in the movie
%       imgmtx,    the image file, will be rounded to the range of 0-255.

x = dmns(2);
y = dmns(3); 
nf = dmns(4); 

imgmtx = imgmtx + offset;
fid = fopen(filename, 'w');
[fn, pp, ar] = fopen(fid);
	
fwrite(fid, notes, 'char');
fwrite(fid, dmns, 'uint16');
fwrite(fid, imgmtx, 'uchar');
fclose(fid);




