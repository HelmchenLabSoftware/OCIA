function img = readLSMfile(varargin)
% wrapper function to read LSM file format files (Zeiss LSM format)
% requires LSM toolbox from Matlab Central to read header
% in1 ... filename (empty or no inputs: GUI select)

% written in the month of October of the memorable year of 2013 by Henry Luetcke


if nargin
   filename = varargin{1};
else
    filename = [];
end

if isempty(filename)
    [filename,pathname] = uigetfile({'*.lsm'},'Please select LSM file');
    filename = sprintf('%s%s%s',pathname,filesep,filename);
end

[lsminf,scaninf,imfinf] = lsminfo(filename);
% hdr.dims = lsminf.DIMENSIONS;
% hdr.frames = lsminf.TIMESTACKSIZE;
% hdr.frameRate = 1./lsminf.TimeInterval;
hdr.lsminf = lsminf;
hdr.scaninf = scaninf;
tiffFrames = numel(imfinf);
if tiffFrames > lsminf.TIMESTACKSIZE
   skipFrames = tiffFrames ./ lsminf.TIMESTACKSIZE;
else
    skipFrames = 1;
end

% read image data
data = zeros([lsminf.DIMENSIONS(1) lsminf.DIMENSIONS(2) lsminf.TIMESTACKSIZE]);
for n = 1:skipFrames:tiffFrames
    data(:,:,n./2+0.5) = imread(filename,'tiff','index',n);
end


% assemble output structure
img.data = data;
img.hdr = hdr;
end
