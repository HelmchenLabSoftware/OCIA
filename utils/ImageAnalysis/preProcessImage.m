function [img, imgSteps] = preProcessImage(img, procSteps, varargin)
% pre-process "img" based on the settings provided by the cell array "procSteps". Can optionally take
% a variable to scale some of the settings

% holds the different steps in which the image goes through (column 1) and their name (column 2)
imgSteps = cell(0, 2);
iPlotStep = 1;
oriImg = img;

if isempty(varargin);   scaleValue = [1 1];
else                    scaleValue = varargin{1};
end;
% make sure scale value has 2 elements
if numel(scaleValue) == 1; scaleValue = repmat(scaleValue, 1, 2); end;

% successively apply each pre-processing step
for iProcStep = 1 : size(procSteps, 1);
    
    % get step informations
    stepName = procSteps{iProcStep, 1};
    stepParam = procSteps{iProcStep, 2};
    doPlotForStep = procSteps{iProcStep, 3};
    
    % step depends on the step name
    switch stepName;
        
        % display the original image
        case {'original', 'finalOri'};
            % store the image and update the counter
            imgSteps(iPlotStep, :) = {oriImg, stepName}; iPlotStep = iPlotStep + 1;
            
        % display the current image
        case 'finalPreProc';
            % store the image and update the counter
            imgSteps(iPlotStep, :) = {img, stepName}; iPlotStep = iPlotStep + 1;
        
        % invert the image
        case 'invert';
            img = linScale(img, max(img(:)), min(img(:)));
            
        % scale the image
        case 'linScale';
            img = linScale(img, stepParam(1), stepParam(2));
            
        % correct the image with a pseudo flat-field
        case 'flatField';
            img = PseudoFlatfieldCorrect(img, round(size(img) / stepParam));
            
        % apply a 2D-median filter with defined size
        case 'median';
            img = medfilt2(img, round([stepParam(1), stepParam(2)]));
            
        % apply a 2D-median filter with defined size compared to joint size
        case 'medianJS';
            img = medfilt2(img, round(scaleValue ./ stepParam));
            
        % apply intensity adjustment with automatic settings
        case 'imadjustAuto';
            img = imadjust(img);
            
        % apply intensity adjustment with percentile boundaries
        case 'imadjustPrctile';
            r = [prctile(img(:), stepParam(1)), prctile(img(:), stepParam(2))];
            if r(1) == r(2);
                stepName = sprintf('%s - ERROR', stepName);
            else
                img = imadjust(img, r);
            end;
            
        % minimum-threshold the peaks of the image with a percentile value
        case 'threshMinPeakPrctle';
            nanMask = isnan(img);
            img(nanMask) = 0;
            img = imhmin(img, prctile(img(:), stepParam(1)));
            img(nanMask) = NaN;
            
        % minimum-threshold the image with a percentile value
        case 'threshMinPrctle';
            prctileValue = prctile(img(:), stepParam(1));
            img(img < prctileValue) = prctileValue;
            
        % maximum-threshold the image with a percentile value
        case 'threshMaxPrctle';
            prctileValue = prctile(img(:), stepParam(1));
            img(img > prctileValue) = prctileValue;
            
        % subtract a 2D-convolution to filter the image
        case 'convolFilter';
            % get the convoluted image
            g1 = round(scaleValue(1) * stepParam(1)); g2 = round(scaleValue(2) * stepParam(2));
            convImg = conv2(img, fspecial('gaussian', g1, g2), 'same');
            % get the size of the valid area
            [ma, na] = size(img); validSize = max([ma - max(0, stepParam(1) - 1), na - max(0, stepParam(2) - 1)], 0);
            sizeDiff = round((size(convImg) - validSize) / 2);
            % normalize edge values by setting them to the mean of the valid area
            validAreaMask = false(size(convImg)); % create a valid area mask
            validAreaMask(sizeDiff(1) + 1 : end - sizeDiff(1), sizeDiff(2) + 1 : end - sizeDiff(2)) = true;
            convImg(~validAreaMask) = NaN;
            img = img - convImg; % create the subtracted convoluted mask
            % add the convolution filter to the plot list if required
            if doPlotForStep;
                % store the image and update the counter
                imgSteps(iPlotStep, :) = {convImg, 'conv. mask'}; iPlotStep = iPlotStep + 1;
            end;
            
        otherwise
            % ignore
        
    end;
    
    % add the processing step to the plot list if required
    if doPlotForStep;
        % store the image and update the counter
        imgSteps(iPlotStep, :) = {img, stepName}; iPlotStep = iPlotStep + 1;
    end;
end;

end
