function img = tif2mat(varargin)
% convert tif-file to Matlab matrix
% optional 2nd argument: 'nosave' (no .mat file will be written)
infile = varargin{1};

if nargin == 2 && strcmp(varargin{2},'nosave')
    nosave = 1;
else
    nosave = 0;
end
% get the file header
img.header = imfinfo(infile);
if numel(img.header) > 1
    % multi-page tiff
    multi = 1;
    stacks = numel(img.header);
    img.header = img.header(1);
else
    % single-page tif
    multi = 0;
    stacks = 1;
end

% determine image type from header (currently, only supported types are
% grayscale [1] and RGB [2] images)
if strcmp(img.header.ColorType,'grayscale')
    ctype = 1;
elseif strcmp(img.header.ColorType,'truecolor')
    if strcmp(img.header.PhotometricInterpretation,'RGB')
       ctype = 2;
    else
        error(...
            'Unknown header tag value %s in field PhotometricInterpretation',...
            img.header.PhotometricInterpretation);
    end
else
    ctype = 1;
%     error(...
%             'Unknown header tag value %s in field ColorType',...
%             img.header.ColorType);
end

% determine image width and height from header
xsize = img.header.Height;
ysize = img.header.Width;

% grayscale 2d image (1 stack)
if multi == 0 && ctype == 1
    fprintf('2D grayscale image detected\nImporting ...\n');
    img.data = imread(infile);
    % RGB 2d image (1 stack)
elseif multi == 0 && ctype == 2
    fprintf('2D RGB image detected\nImporting ...\n');
    temp = imread(infile);
    img.red = temp(:,:,1);
    img.green = temp(:,:,2);
    img.blue = temp(:,:,3);
    clear temp;
    % grayscale 3d image
elseif multi == 1 && ctype == 1
    fprintf('3D grayscale image detected\nImporting ...\n');
    img.data = zeros(xsize,ysize,stacks);
    for n = 1:stacks
        img.data(:,:,n) = imread(infile,n);
    end
    % RGB 3d image
elseif multi == 1 && ctype == 2
    fprintf('3D RGB image detected\nImporting ...\n');
    img.red = zeros(xsize,ysize,stacks);
    img.green = zeros(xsize,ysize,stacks);
    img.blue = zeros(xsize,ysize,stacks);
    for n = 1:stacks
        temp = imread(infile,n);
        img.red(:,:,n) = temp(:,:,1);
        img.green(:,:,n) = temp(:,:,2);
        img.blue(:,:,n) = temp(:,:,3);
    end
    clear temp;
end

% convert to 8-bit
% if isfield(img,'data')
%     img.data = uint16(img.data);
% end
% if isfield(img,'red')
%     img.red = uint8(img.red);
% end
% if isfield(img,'green')
%     img.green = uint8(img.green);
% end
% if isfield(img,'blue')
%     img.blue = uint8(img.blue);
% end

if ~nosave
    [path name ext vers] = fileparts(infile);
    savename = strrep(infile,ext,'.mat');
    save(savename,'img');
end

% clear all
