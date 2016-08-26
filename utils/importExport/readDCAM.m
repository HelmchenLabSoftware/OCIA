function [frames, hdr] = readDCAM(filePath, nFrames, imgDims)
% Read DCAM binary image format

% open file for reading
fid = fopen(filePath, 'r');

% 232 bytes offset
hdr = fread(fid, 232, 'char*1', 'ieee-le');

% read data
v = fread(fid, 'uint16', 'ieee-le');

% close file handle
fclose(fid);

% some additional data points at the end?
v_img = v(1:(nFrames*prod(imgDims)));
v(1:(nFrames*prod(imgDims))) = [];

% arrange in Matlab matrix
frames = reshape(v_img, [imgDims(1), imgDims(2), nFrames]);

end