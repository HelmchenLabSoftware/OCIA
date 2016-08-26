function newCoords = JTFindJoint(this, img, refImg, jointMask, iJoint, iFrame, iRefFrame, imgOffsets, doPlot)
% JTFindJoint - [no description]
%
%       newCoords = JTFindJoint(this, img, refImg, jointMask, iJoint, iFrame, iRefFrame, imgOffsets, doPlot)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

findTic = tic; % for performance timing purposes
o('#JTFindJoint: iJoint: %d, iFrame: %d... ', iJoint, iFrame, 3, this.verb);

% get informations about the joint and store the original image
jointSize = this.jt.jointConfig{iJoint, 8};

%% image pre-processing
% get the method for this joint
jointFindMethod = this.jt.jointConfig{iJoint, 6};
% get the right pre-processing settings
procSteps = this.jt.findJointPreProc.(jointFindMethod).(this.jt.jointConfig{iJoint, 7});
oriImg = img; % store the original

% pre-processed images if required
if ~this.jt.skipPreProc;
    [img, imgSteps] = preProcessImage(img, procSteps, jointSize);
    refImg = preProcessImage(refImg, procSteps, jointSize);
else
    imgSteps = {};
end;

% default is [0, 0] which corresponds to not found
newCoords = [0 0];

%% cross-correlation template preparation
% process the resulting image using the specified method to find the best coordinates to place the joint
switch jointFindMethod;
                
    % use cross-correlation of pre-processed image with a template
    case 'xcorr_ref';
            
        % get a template from the reference image as the center image with more or less half of the size
        centerSize = floor(size(refImg) / 2);
        % make sure center's sides are always odd length
        for i = 1 : 2; if mod(centerSize(i), 2) == 0; centerSize(i) = centerSize(i) + 1; end; end;
        % calculate center's offset
        centerOffset = (size(refImg) - centerSize) / 2;
        % get the cropped image
        refTemplate = imcrop(refImg, [fliplr(centerOffset), fliplr(centerSize) + 1]);
            
    % use a gaussian distribution to mimic the joint's mark
    case 'xcorr_gauss';
            
        % get a template from a gaussian distribution of the joint's size
        centerSize = jointSize;
        % make sure center's sides are always odd length
        for i = 1 : 2; if mod(centerSize(i), 2) == 0; centerSize(i) = centerSize(i) + 1; end; end;
        % create the gaussian template
        gaussTemplateCenter = fspecial('gaussian', centerSize, sqrt(nanmean(centerSize)));
        % calculate the size of the reference template which should be twice as big as the joint but not bigger
        %   than the image itself
        gaussTemplateSize = centerSize * 2 + 1;
        for i = 1 : 2; if gaussTemplateSize(i) > size(img, i); gaussTemplateSize(i) = size(img, i); end; end;
        % insert this template in a field twice as big as the joint (but still odd) with the same background
        gaussTemplate = zeros(gaussTemplateSize) + min(gaussTemplateCenter(:));
        % calculate center's offset
        centerOffset = (size(gaussTemplate) - centerSize) / 2;
        gaussTemplate(centerOffset(1) + 1: end - centerOffset(1), ...
            centerOffset(2) + 1 : end - centerOffset(2)) = gaussTemplateCenter;
        % scale the template between 0 and 1
        refTemplate = linScale(gaussTemplate);
         
    % use reference frame as template combined with a gaussian distribution to mimic the joint's mark   
    case 'xcorr_comb';
            
        % get a template from the reference image as the center image with more or less half of the size
        centerSize = floor(size(refImg) / 2);
        % make sure center's sides are always odd length
        for i = 1 : 2; if mod(centerSize(i), 2) == 0; centerSize(i) = centerSize(i) + 1; end; end;
        % make sure center's sides are always at least as big as the joints
        for i = 1 : 2; if centerSize(i) < jointSize(i); centerSize(i) = jointSize(i); end; end;
        % calculate center's offset
        centerOffset = (size(refImg) - centerSize) / 2;
        % get the cropped image
        refTemplate = imcrop(refImg, [fliplr(centerOffset), fliplr(centerSize) + 1]);

        % get a template from a gaussian distribution of the joint's size
        centerSize = jointSize;
        % make sure center's sides are always odd length
        for i = 1 : 2; if mod(centerSize(i), 2) == 0; centerSize(i) = centerSize(i) + 1; end; end;
        % create the gaussian template
        gaussTemplateCenter = fspecial('gaussian', centerSize, sqrt(nanmean(centerSize)));
        % calculate the size of the reference template which should be twice as big as the joint but not bigger
        %   than the image itself
        gaussTemplateSize = size(refTemplate);
        for i = 1 : 2; if gaussTemplateSize(i) > size(img, i); gaussTemplateSize(i) = size(img, i); end; end;
        % insert this template in a field twice as big as the joint (but still odd) with the same background
        gaussTemplate = zeros(gaussTemplateSize) + min(gaussTemplateCenter(:));
        % calculate center's offset
        centerOffset = (size(gaussTemplate) - centerSize) / 2;
        % if no offset required, just use the center
        if ~all(centerOffset > 0);
            gaussTemplate = gaussTemplateCenter;
        % otherwise replace the center in the template
        else
            gaussTemplate(centerOffset(1) + 1: end - centerOffset(1), ...
                centerOffset(2) + 1 : end - centerOffset(2)) = gaussTemplateCenter;
        end;
        % scale the template between 0 and 1
        gaussTemplate = linScale(gaussTemplate);

        imgSteps = [imgSteps; { refTemplate, 'ref_template'; gaussTemplate, 'gauss_template'; }];

        % combine the two templates
        refTemplate = linScale(0.4 * refTemplate + gaussTemplate);
        
    otherwise 
        
        showWarning(this, 'OCIA:JT:JTFindJoint:UnknownMethod', ...
            sprintf('Joint finding method "%s" is unknown.', jointFindMethod));
end;


%% peak finding and coordinates extraction
% replace the NaNs with the minimum value
refTemplate(isnan(refTemplate)) = min(refTemplate(:));
img(isnan(img)) = min(img(:));

% calculate the normalized cross-correlation
xCorrRes = normxcorr2(refTemplate, img);

% remove the unwanted edges of the cross-correlation matrix by taking the center of the matrix:
% get center size as the size of the image and calculate the center's offset
centerSize = size(img); centerOffset = (size(xCorrRes) - centerSize) / 2;
% get the cropped cross-correlation matrix
xCorrRes = imcrop(xCorrRes, [fliplr(centerOffset) + 1, fliplr(centerSize) - 1]);

% get the pixels indices sorted by maximum cross-correlation
[maxVals, iMaxInds] = sort(-xCorrRes(:));

imgSteps = [imgSteps; { refTemplate, 'template'; img, 'img'; xCorrRes, 'normxcorr2'; }];

% for display purposes
img = xCorrRes;

% check if something was found
if isempty(iMaxInds);
    showWarning(this, 'OCIA:JT:JTFindJoint:NoCoordsFound', ...
        sprintf('Could not find any coordinates with method "%s".', jointFindMethod));
    return;
end;

%% apply distance constraints
% create the distance weighting mask
distanceWeights = zeros(numel(iMaxInds), 1);

% go through the two possibilities: previous and next joint
for iLoopRefJoint = [-1 1];
    
    % get the "reference" joint
    iRefJoint = iJoint + iLoopRefJoint;
    
    % if the reference joint is not valid (oustide the of the joint number boundaries or virtual), skip
    if iRefJoint > this.jt.nJoints || iRefJoint < 1 || this.jt.jointConfig{iRefJoint, 2}; continue; end;
    
    % get the coordinates of the reference joint
    refJointCurrFrame = squeeze(this.jt.joints(iRefJoint, iFrame, :, this.GUI.jt.iJointType));
    refJointDistance = this.jt.jointConfig{iJoint, 4}(1.5 + iLoopRefJoint * 0.5); % index is either 1 or 2
    currJointPrevFrame = squeeze(this.jt.joints(iJoint, iFrame - 1, :, this.GUI.jt.iJointType));
    refJointPrevFrame = squeeze(this.jt.joints(iRefJoint, iFrame - 1, :, this.GUI.jt.iJointType));
    
    % if the reference joint is not set on the current frame, skip
    if ~all(refJointCurrFrame); continue; end;
    
    % go through each pixel and add the weighted euclidian distance to the current reference joint
    jointDistFlexibility = this.jt.jointConfig{iJoint, 5}; % get the distance flexibility
        
    parfor iPixel = 1 : size(iMaxInds, 1);
        % get the real coordinates of this pixel
        [i, j] = ind2sub(size(img), iMaxInds(iPixel));
        realCoords = [i, j] + imgOffsets;
        % get the distance to the reference joint, taking into account the offset of the sub-image
        pixJointDistance = dist(realCoords, refJointCurrFrame);
        % calculate the distance difference weighted by the maximum allowed distance difference
        weightedDistDiff = (abs(pixJointDistance - refJointDistance) ^ jointDistFlexibility) / refJointDistance;
        % add the weighted distance to the pixel's weights
        distanceWeights(iPixel) = distanceWeights(iPixel) + weightedDistDiff;
        
        %{
        midPointPrev = [currJointPrevFrame(1, :); refJointPrevFrame(2, :)];
        midPointCurr = [realCoords(:, 1)'; refJointCurrFrame(2, :)];
        % get the angle between the reference joint, this joint and the horizontal on the *previous* frame
        angleOnPrev = atan2(det([midPointPrev' - refJointPrevFrame'; currJointPrevFrame' - refJointPrevFrame']), ...
            dot(midPointPrev' - refJointPrevFrame', currJointPrevFrame' - refJointPrevFrame'));
        % get the angle between the reference joint, this joint and the horizontal on the *current* frame
        angleOnCurr = atan2(det([midPointCurr' - refJointCurrFrame'; realCoords - refJointCurrFrame']), ...
            dot(midPointCurr'- refJointCurrFrame', realCoords - refJointCurrFrame'));
        % get the normalized angle difference
        angleDiff = abs(angleOnPrev - angleOnCurr) * 0.5;
        % add the weighted distance's angle componenet to the pixel's weights
        distanceWeights(iPixel) = distanceWeights(iPixel) + angleDiff;
        %}
        
    end;
    
    % put the weights as an image for display if required
    if doPlot;
        distanceWeightsMask = zeros(size(img));
        for iPixel = 1 : size(iMaxInds, 1);
            [i, j] = ind2sub(size(img), iMaxInds(iPixel));
            distanceWeightsMask(i, j) = distanceWeights(iPixel);
        end;
        distanceWeightsMask = linScale(distanceWeightsMask);
        imgSteps = [imgSteps; { distanceWeightsMask, 'showPoints_distWeightMask'; ...
            img - distanceWeightsMask, 'showPoints_weightedImg'; }]; %#ok<AGROW>
    end;
end;

% weight the values by the distance weights
maxValsWeighted = maxVals + linScale(distanceWeights);
% re-sort the values with the weighting
[maxValsWeightedSorted, weightingSortingIndexes] = sort(maxValsWeighted);
% get the ordering of the original indexes
iMaxIndsSorted = iMaxInds(weightingSortingIndexes);
% get the indices as coordinates
[iMaxYs, iMaxXs] = ind2sub(size(img), iMaxIndsSorted);

%% apply ROI mask constraints
% if the mask is not empty, apply the ROI mask's constraint on the coordinates
if ~isempty(jointMask);
    
    % remove points outside the joint's mask range
    outOfRange = iMaxYs > size(jointMask, 1) | iMaxXs > size(jointMask, 2);
    iMaxYs(outOfRange) = [];
    iMaxXs(outOfRange) = [];

    % get a list of booleans defining whether the coordinates are within the mask or not
    isInMask = arrayfun(@(iInd) jointMask(iMaxYs(iInd), iMaxXs(iInd)), 1 : numel(iMaxYs));
    imgSteps = [imgSteps; {jointMask, 'jointMask';} ];

    % remove all the coordinates that are not within the mask
    iMaxXs(~isInMask) = [];
    iMaxYs(~isInMask) = [];
    maxValsWeightedSorted(~isInMask) = [];
end;

% add some images to the debug display
if doPlot;
    imgSteps = [imgSteps; {img, 'showPoints_img'; oriImg, 'showPoints_ori'} ];
    imgSteps = [imgSteps; {img, 'showGroups_img'; oriImg, 'showGroups_ori'} ];
end;

% check if something was found
if isempty(iMaxXs);
    showWarning(this, 'OCIA:JT:JTFindJoint:NoCoordsFound', ...
        'Could not find any coordinates after distance and mask filtering.');
    return;
end;

% get the final coordinates as the best option
iMaxX = iMaxXs(1); iMaxY = iMaxYs(1); maxVal = -maxValsWeightedSorted(1);
newCoords = [iMaxX, iMaxY] + imgOffsets;

o('#JTFindJoint: found coords [%.1f,%.1f] for joint %d with max at %.4f ...', iMaxX, iMaxY, iJoint, maxVal, ...
    2, this.verb);

%% plotting
% do plots if required
if doPlot;
        
    % create figure
    figH = figure('Name', sprintf('%s (%d) - frame: %d, refFrame: %d, ', this.jt.jointConfig{iJoint, 1}, ...
            iJoint, iFrame, iRefFrame), 'NumberTitle', 'off', 'Tag', 'JTFindJointDebugPlots');

    % get the best indices for subplots
    nImgs = size(imgSteps, 1); N = ceil(sqrt(nImgs)); M = N;
    while nImgs && (M - 1) * N >= nImgs; M = M - 1; end;

    % plot all steps of the image
    axeHandles = nan(nImgs, 1); % holder for the axe handles
    for iPlot = 1 : nImgs;

        % get step informations and set the subplot
        stepImg = imgSteps{iPlot, 1};
        stepName = imgSteps{iPlot, 2};
        subplot(M, N, iPlot);
        axeHandles(iPlot) = gca;

        % if showing the points is required
        if ~isempty(regexp(stepName, '^showPoints', 'once'));
            if ~isempty(stepImg); imagesc(stepImg); end;
            hold on;
            r = jointSize; rectPos = [[iMaxX, iMaxY] - r / 2, r];
            rectangle('Position', rectPos, 'EdgeColor', [0 0 1], 'Curvature', [1, 1]);
            r = jointSize / 10; rectPos = [[iMaxX, iMaxY] - r / 2, r];
            rectangle('Position', rectPos, 'EdgeColor', [1 0 0], 'FaceColor', [1 0 0], 'Curvature', [1, 1]);
            hold off;
            title(sprintf('%d: %s - max:%.2f', iPlot, stepName, maxVal), 'Interpreter', 'none');

        % if showing the groups is required
        elseif ~isempty(regexp(stepName, '^showGroups', 'once'));
            
            % debug
%             nGoupPoints = round(numel(stepImg) / 20);
            nGoupPoints = 50;
            pointRange = 1 : nGoupPoints;
            groupInds = clusterdata([iMaxXs(pointRange), iMaxYs(pointRange)], 'cutoff', 1);
            axeHandles(iPlot) = gca;
            if ~isempty(stepImg); imagesc(stepImg); end;
            hold on;
            scatter(iMaxXs(pointRange), iMaxYs(pointRange), 20, groupInds, 'filled');
            hold off;

%             meanVals = arrayfun(@(iGroup) mean(maxValsWeightedSorted(groupInds == iGroup)), 1 : max(groupInds));
%             center = arrayfun(@(iGroup) mean(maxValsWeightedSorted(groupInds == iGroup)), 1 : max(groupInds));
%             sumVals = arrayfun(@(iGroup) sum(maxValsWeightedSorted(groupInds == iGroup)), 1 : max(groupInds));
%             nVals = arrayfun(@(iGroup) numel(maxValsWeightedSorted(groupInds == iGroup)), 1 : max(groupInds));
            title(sprintf('%d: %s', iPlot, stepName), 'Interpreter', 'none');
            
        % if showing the points is *not* required
        else
            if ~isempty(stepImg); imagesc(stepImg); end;
            title(sprintf('%d: %s', iPlot, stepName), 'Interpreter', 'none');

        end;
        
        
    end;

    % figure settings: link all the valid axes, change colormap and make tight figures
    axeHandles(isnan(axeHandles)) = [];
    if ~isempty(axeHandles);
        linkaxes(axeHandles, 'xy');
    end;
    colormap(this.GUI.jt.preProcDebugColormap);
    tightfig(figH);
    
end;
    
o('#JTFindJoint: done (%.4f sec).', toc(findTic), 3, this.verb);

end
