function imgCorrectScale = PseudoFlatfieldCorrect(img,varargin)
% img ... 2D array
% varargin{1} ... filter size (default: image dimensions / 4)
% varargin{2} ... plot (default: 0)
% imgCorrect ... corrected image (uint8)

% this file written by Henry Luetcke (hluetck@gmail.com)

if nargin > 1 && ~isempty(varargin{1})
    filterDims = varargin{1};
else
    filterDims = [round(size(img,1)/4) round(size(img,2)/4)];
end

if nargin > 2 && ~isempty(varargin{2})
    doPlot = varargin{2};
else
    doPlot = 0;
end

% make the filter with dims
h = fspecial('gaussian',filterDims(1),filterDims(2));

% remove nans
img(isnan(img(:))) = min(img(:));

% apply the filter to get flat field (boundary option must be 'replicate')
flatField = imfilter(img, h, 'replicate');
% remove nans
flatField(isnan(flatField)) = 0;

% subtract the flat field
imgCorrect = img - flatField;

% multiple channels: correct each channel individually
if size(imgCorrect, 3) > 1;
    imgCorrectScale = cat(3, ...
        linScale(imgCorrect(:, :, 1)), linScale(imgCorrect(:, :, 2)), linScale(imgCorrect(:, :, 3)));
% single channel: correct the image
else
    imgCorrectScale = linScale(imgCorrect);
end;

if doPlot > 0;
   figure('Name','Flatfield correction','NumberTitle','off','color','white')
   subplot(2,2,1)
   imshow(img,[])
   title('Original')
   subplot(2,2,2)
   imshow(flatField,[])
   title('Flatfield')
   subplot(2,2,3)
   imshow(imgCorrect,[])
   title('Corrected')
   subplot(2,2,4)
   imshow(linScale(imgCorrect),[])
   title('CorrectedScaled')
end

