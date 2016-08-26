function frames = INSpatialDownSample(this, frames)
% INSpatialDownSample - [no description]
%
%       INSpatialDownSample(this, frames)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get frame size
[H, W, nFrames1, nFrames2] = size(frames);
nFrames = max(nFrames1, nFrames2);

% create conversion function to right data type
dataClass = class(frames);
convertFunc = str2func(dataClass);

% bin data down by spatialDownSampleFactor
DSF = this.in.common.spatialDSFactor;

% check for down-sampling factor's consitency with image size
if mod(H, DSF) ~= 0 || mod(W, DSF) ~= 0;
    showWarning(this, 'OCIA:INRunExp_standard:BadSpatialDSFactor', ...
        'Spatial down-sampling factor is not a perfect divider for image size. Skipping down-sampling.');

% down-sampling factor is valid
else
    % down-sample height
    frames = convertFunc(sum(reshape(frames, DSF, []), 1) ./ DSF);
    frames = permute(reshape(frames, [H / DSF, W, nFrames]), [2, 1, 3]);
    % down-sample width
    frames = convertFunc(sum(reshape(frames, DSF, []), 1) ./ DSF);
    frames = permute(reshape(frames, [W / DSF, H / DSF, nFrames]), [2, 1, 3]);
    
end; 

end
