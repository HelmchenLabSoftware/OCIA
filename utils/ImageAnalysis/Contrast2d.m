function varargout = Contrast2d(varargin)
% in1 ... input file (tif / mat)
% in2 ... output filename (optional, default is infile_Contrast2d)
% out1 ... preprocessed image after Contrast2d
% this file written by Henry Luetcke (hluetck@gmail.com)

% calculate difference between green and red channels (0 ... no; 1 ... yes)
% if 0, only green channel is used
% difference = 0;
% 
% % kernel size for flatfield filter (kernel = dim(image) / kernel_size)
% kernel_size = 11;
% 
% if nargin == 1
%     infile = varargin{1};
%     [path name ext] = fileparts(infile);
%     outfile = strrep(infile,name,[name '_Contrast2d']);
%     outfile_tif = strrep(outfile,ext,'.tif');
%     outfile_mat = strrep(outfile,ext,'.mat');
% elseif nargin == 2
%     infile = varargin{1};
%     outfile = varargin{2};
%     [path name ext] = fileparts(outfile);
%     outfile_tif = strrep(outfile,ext,'.tif');
%     outfile_mat = strrep(outfile,ext,'.mat');
% else
%     error('Incorrect number of inputs.');
% end
% 
% if strcmpi(ext,'.mat')
%     load(infile,'img');
% elseif strcmpi(ext,'.tif') || strcmpi(ext,'.tiff')
%     img = tif2mat(infile,'nosave');
% end
% 
% % img must be a structure with (at least) the following fields
% % img.header (contains header info --> currently not used in Contrast2d)
% % img.green (green channel image data as Matlab matrix)
% % img.red (red channel image data as Matlab matrix)
% if ~isfield(img,'header') || ~isfield(img,'red') || ~isfield(img,'green')
%     error('Input file structure not consisten with this program.');
% end
% 
% green = img.green;
% red = img.red;
% clear img
green = varargin{1};
red = varargin{2};
% check if we have a timeseries
if length(size(red)) == 3
    % work with first timepoint
    %    red = red(:,:,1);
    %    green = green(:,:,1);

    % work with mean (best results?)
    red = mean(red,3);
    green = mean(green,3);

    % work with MIP
    %     red = max(red,[],3);
    %     green = max(green,[],3);
end

% ImageJ ImageCalculator plugin has 'difference' and 'subtract' operations
% not sure what is the difference, so just use subtraction here
% if difference
    diff = green - red;
% else
%     diff = green;
% end
diff = double(diff);

mean_diff = mean(mean(diff));

% ImageJ pseudo-flat-field plugin equivalent
% kernel size taken from Fritjof's Contrast3d plugin
kernel = round(size(diff,1) / varargin{3});
% filter requires odd-numbered kernel
if ~rem(kernel,2)
    kernel = kernel + 1;
end

% calculate flatmap
diff_flatmap = diff;
% mean filter with large kernel in 2D
% fastrunmean function is from Matlab Central
% www.mathworks.com/matlabcentral/fileexchange/loadFile.do?objectId=19504
% main advantage: cpu time is independent of kernel size
diff_flatmap = fastrunmean(diff,[kernel kernel],'mean');
diff_flatfield = diff ./ diff_flatmap;
diff_flatfield = diff_flatfield * mean_diff;

% scale between 0 and 255
% min_value = min(min(diff_flatfield));
% max_value = max(max(diff_flatfield));
% range_value = max_value - min_value;
% diff_flatfield_scaled = diff_flatfield;
% for x = 1:size(diff,1)
%     for y = 1:size(diff,2)
%         diff_flatfield_scaled(x,y) = (255/range_value) * ...
%             diff_flatfield(x,y) - (255/range_value) * min_value;
%     end
% end
diff_flatfield_scaled = ScaleToMinMax(diff_flatfield,0,255);

% subtract mean
diff_final = diff_flatfield_scaled - ...
    mean(mean(diff_flatfield_scaled));

% save tif / mat and return matrix
% save(outfile_mat,'diff_final');
diff_final = uint8(diff_final);
% imwrite(diff_final,outfile_tif,'Compression','none');

varargout{1} = diff_final;

% e.o.f.
