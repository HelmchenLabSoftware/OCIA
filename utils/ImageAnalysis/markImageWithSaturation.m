function imgRGB = markImageWithSaturation(img, boundaries)
% annotates an image with saturation boundaries

% convert to RGB
if size(img, 3) == 1;
    imgRGB = repmat(img, [1 1 3]);
else
    imgRGB = img;
end;

% maxValue = max(img(:));
if isa(img, 'double');
    maxValue = Inf;
else
    maxValue = intmax(class(img));
end;

% over saturated pixels
overSatPixelMask = img >= boundaries(2);
overSatPixelMaskRGB = repmat(overSatPixelMask, [1 1 3]);
overSatPixelMaskRedChan = overSatPixelMaskRGB;
overSatPixelMaskRedChan(:, :, [2 3]) = 0;
overSatPixelMaskGreenBlueChan = overSatPixelMaskRGB;
overSatPixelMaskGreenBlueChan(:, :, 1) = 0;
imgRGB(overSatPixelMaskRedChan) = maxValue;
imgRGB(overSatPixelMaskGreenBlueChan) = 0;

% under saturated pixels
underSatPixelMask = img <= boundaries(1);
underSatPixelMaskRGB = repmat(underSatPixelMask, [1 1 3]);
underSatPixelMaskGreenChan = underSatPixelMaskRGB;
underSatPixelMaskGreenChan(:, :, [1 3]) = 0;
underSatPixelMaskRedBlueChan = underSatPixelMaskRGB;
underSatPixelMaskRedBlueChan(:, :, 2) = 0;
imgRGB(underSatPixelMaskGreenChan) = maxValue;
imgRGB(underSatPixelMaskRedBlueChan) = 0;

end
