function RDUpdateImage(this, varargin)
% RDUpdateImage - [no description]
%
%       RDUpdateImage(this, varargin)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

o('#RDUpdateImage()', 4, this.verb);
isImageModif = false; % determines whether any change was applied to the image or not

% check for empty image
if isempty(this.GUI.rd.img); % image is empty
    o('#RDUpdateImage(): image is empty, filling with zeros.', 3, this.verb);
    this.GUI.rd.img = zeros(this.GUI.rd.defaultImDim, this.GUI.rd.defaultImDim, 3);
end;

% check for non-RGB image
if size(this.GUI.rd.img, 3) ~= 3; % image is not RGB
    o('#RDUpdateImage(): image is not RGB, converting using first channel.', 3, this.verb);
    this.GUI.rd.img = repmat(this.GUI.rd.img(:, :, 1), [1, 1, 3]);
end;

% store the function calling handle (if any) for selective processing of image corrections
h = [];

% if a handle was in the arguments, use it to make selective changes
if nargin >= 2 && ~isempty(varargin{1}) && ishandle(varargin{1});
    h = varargin{1};
end
    
% enter the ROI compare mode
if ~isempty(h) && ishandle(h) && (h == this.GUI.handles.rd.refROISet ...
         || h == this.GUI.handles.rd.refROISetASetter || h == this.GUI.handles.rd.refROISetBSetter) ...
        && get(this.GUI.handles.rd.refROISet, 'Value');
    
    RDCompareROIs(this);
    
    return;
    
% a deactivation occured, clean up markings
elseif ~isempty(h) && ishandle(h) && (h == this.GUI.handles.rd.refROISet ...
         || h == this.GUI.handles.rd.refROISetASetter || h == this.GUI.handles.rd.refROISetBSetter) ...
        && ~get(this.GUI.handles.rd.refROISet, 'Value');
    
    % clear the annotations
    try
        childHands = get(this.GUI.handles.rd.axe, 'Children');
        childTags = get(childHands, 'Tag');
        delete(childHands(strcmp('ROICompareLine', childTags)));
        delete(childHands(strcmp('ROICompareText', childTags)));
        delete(childHands(strcmp('ROICompareScatter', childTags)));
    catch e; %#ok<NASGU>
    end;
    
    return;
    
% if there is no handle (direct call of the function) and it is not an ROI repositioning call, reset the image 
%   to the orginal and re-apply each required image correction
elseif (isempty(h) && nargin < 4) || (~isempty(h) && ishandle(h) && ~isempty(get(h, 'Value')) ...
        && numel(get(h, 'Value')) == 1 && ~get(h, 'Value'));
    iRow = get(this.GUI.handles.rd.tableList, 'Value');
    if numel(iRow) > 0; iRow = iRow(1); end; % only check for first row...
    if ~isempty(iRow) && numel(this.rd.selectedTableRows) >= iRow && ~isempty(this.rd.avgImages{iRow});
        % set the right frame
        RDChangeFrame(this, -1);
    end;

    % if a handle exists, remove all applied image correction except the one that triggered the
    %   reset (needed later for message display)
    if ~isempty(h) && ishandle(h);
        this.GUI.rd.applImCorr(~strcmpi(regexprep(get(h, 'Tag'), '^RD', ''), this.GUI.rd.applImCorr)) = [];
    end;

% if change was triggered by the setter of an image correction, reset image and re-do that correction
elseif ~isempty(h) && ishandle(h) && ~isempty(strfind(get(h, 'Tag'), 'Sett'));

    iRow = get(this.GUI.handles.rd.tableList, 'Value');
    if ~isempty(iRow) && h ~= this.GUI.handles.rd.frameSetter;
        % set the right frame
        RDChangeFrame(this, -1);
    end;

    this.GUI.rd.applImCorr = {};

end;

% if an ROI index was given as input, set the modified flag of that ROI to true
if nargin >= 4;
    this.rd.ROIs(strcmp(this.rd.ROIs(:, 2), varargin{3}), 6) = { true };
    o('#RDUpdateImage(): update ROI %s', varargin{3}, 4, this.verb);
end;

% apply pseudo flat field if required
if get(this.GUI.handles.rd.pseudFF, 'Value') && ~ismember('pseudFF', this.GUI.rd.applImCorr);

    showMessage(this, 'Applying flat-field correction ...', 'yellow');
    pseudFFTic = tic; % for performance timing purposes
    this.GUI.rd.img = PseudoFlatfieldCorrect(this.GUI.rd.img);
    isImageModif = true;
    % add this correction to the list of applied image corrections
    this.GUI.rd.applImCorr{end + 1} = 'pseudFF';
    showMessage(this, sprintf('Flat-field correction done (%5.3f sec).', toc(pseudFFTic)));

% remove flat field if required  
elseif ~get(this.GUI.handles.rd.pseudFF, 'Value');

    % only display message if image correction was removed now
    if ismember('pseudFF', this.GUI.rd.applImCorr);
        showMessage(this, 'Flat-field correction removed.');
    end;
    this.GUI.rd.applImCorr(strcmp(this.GUI.rd.applImCorr, 'pseudFF')) = []; % remove from the list

end;

% apply image adjustment if required
if get(this.GUI.handles.rd.imAdj, 'Value') && ~ismember('imAdj', this.GUI.rd.applImCorr);

    showMessage(this, 'Image intensity adjustment ...', 'yellow');
    applyImAdjTic = tic; % for performance timing purposes

    % get the values
    minAdj = get(this.GUI.handles.rd.imAdjMinSetter, 'Value');
    maxAdj = get(this.GUI.handles.rd.imAdjMaxSetter, 'Value');

    % make sure there are no nans because they interfere with the imadjust
    this.GUI.rd.img(isnan(this.GUI.rd.img)) = 0;

    % correct the intensity in the required channels
    for iRGB = 1 : 3;
        if this.an.img.colVect(iRGB);
%                 if get(this.GUI.handles.rd.autoImAdj, 'Value');
%                     this.GUI.rd.img(:, :, iRGB) = imadjust(this.GUI.rd.img(:, :, iRGB));
%                 else
                this.GUI.rd.img(:, :, iRGB) = imadjust(this.GUI.rd.img(:, :, iRGB), [minAdj, maxAdj]);
%                 end;
        end;
    end;
    isImageModif = true;

    % add this correction to the list of applied image corrections
    this.GUI.rd.applImCorr{end + 1} = 'imAdj';

    showMessage(this, sprintf('Image intensity adjustment done (%5.3f sec).', toc(applyImAdjTic)));

% remove image adjustment if required  
elseif ~get(this.GUI.handles.rd.imAdj, 'Value');

    % only display message if image correction was removed now
    if ismember('imAdj', this.GUI.rd.applImCorr);
        showMessage(this, 'Image intensity adjustment removed.');
    end;
    this.GUI.rd.applImCorr(strcmp(this.GUI.rd.applImCorr, 'imAdj')) = []; % remove from the list

end;

% apply mask if required or if there is no mask yet
if (get(this.GUI.handles.rd.mask, 'Value') && ~ismember('mask', this.GUI.rd.applImCorr)) ...
        || isempty(this.rd.ROIMask);

    applyMaskTic = tic; % for performance timing purposes
    maskInitTic = tic; % for performance timing purposes
    % use 8-bit ints to reduce size
    this.rd.ROIMask = int8(zeros(size(this.GUI.rd.img, 1), size(this.GUI.rd.img, 2)));
    o('#RDUpdateImage(): maskInit done (%5.3f sec).', toc(maskInitTic), 4, this.verb);

    maskCreateTic = tic; % for performance timing purposes
    for iROI = 1 : this.rd.nROIs;
       singleROIMask = this.rd.ROIs{iROI, 1}.createMask(this.GUI.handles.rd.img) * iROI;
       this.rd.ROIMask(singleROIMask ~= 0) = iROI;
    end;
    o('#RDUpdateImage(): ROI mask created (%5.3f sec).', toc(maskCreateTic), 4, this.verb);

    if get(this.GUI.handles.rd.mask, 'Value') && ~ismember('mask', this.GUI.rd.applImCorr);

        logicalCreateTic = tic; % for performance timing purposes
        if get(this.GUI.handles.rd.mask, 'Value');
            logicalROIMask = this.rd.ROIMask ~= 0;
        else
            logicalROIMask = true(size(this.rd.ROIMask));
        end;
        o('#RDUpdateImage(): logical mask created created (%5.3f sec).', toc(logicalCreateTic), 4, this.verb);

        % make sure at least one pixel is labeled as ROI, otherwise scaling will remove the mask effect when no ROI
        if ~any(logicalROIMask(:));
            logicalROIMask(1) = 1;
        end;

        createMaskTic = tic; % for performance timing purposes
        opacity = get(this.GUI.handles.rd.maskSetter, 'Value');
        RGBROIMask = double(repmat(logicalROIMask, [1 1 3]));
        this.GUI.rd.img = this.GUI.rd.img .* (RGBROIMask + ~RGBROIMask * opacity);
        isImageModif = true;

        o('#RDUpdateImage(): mask created (%5.3f sec).', toc(createMaskTic), 4, this.verb);

        % add this correction to the list of applied image corrections
        this.GUI.rd.applImCorr{end + 1} = 'mask';

        showMessage(this, sprintf('Mask applied (%5.3f sec).', toc(applyMaskTic)));

    end;

% remove mask if required  
elseif ~get(this.GUI.handles.rd.mask, 'Value');

    % only display message if image correction was removed now
    if ismember('mask', this.GUI.rd.applImCorr);
        showMessage(this, 'Mask removed.');
    end;
    this.GUI.rd.applImCorr(strcmp(this.GUI.rd.applImCorr, 'mask')) = []; % remove from the list

end;

% check for empty image
if isempty(this.GUI.rd.img); % image is empty
    o('#RDUpdateImage(): image is empty (2), filling with zeros.', 3, this.verb);
    this.GUI.rd.img = zeros(this.GUI.rd.defaultImDim, this.GUI.rd.defaultImDim, 3);
end;

% if image was modified, scale each channel for a range between 0 and 1
if isImageModif;
    for iRGB = 1 : 3;
        if this.an.img.colVect(iRGB);
            this.GUI.rd.img(:, :, iRGB) = linScale(this.GUI.rd.img(:, :, iRGB));
        else
            this.GUI.rd.img(:, :, iRGB) = linScale(this.GUI.rd.img(:, :, iRGB), 0, 0.00001);
        end;
    end;
%         this.GUI.rd.img = linScale(this.GUI.rd.img);
end;


% load the images into the imshow axes by updating the CData
cDataLoadTic = tic; % for performance timing purposes
% restrict the image between 0 and 1 and remove nans or infinites
img = this.GUI.rd.img; img(img < 0) = 0; img(img > 1) = 1; img(isnan(img) | isinf(img)) = 0;
% if only one channel is actually used, use grayscale images
chanEmptiness = arrayfun(@(iChan)nansum(nansum(img(:, :, iChan))), 1 : 3) > 0;
if sum(chanEmptiness) == 1;
    img(:, :, ~chanEmptiness) = repmat(img(:, :, chanEmptiness), [1, 1, 2]);
end;

for iChan = 1 : 3;
    if ~ismember(iChan, get(this.GUI.handles.rd.colorChannels, 'Value'));
        img(:, :, iChan) = 0;
    end;
end;

set(this.GUI.handles.rd.img, 'CData', img);
o('#RDUpdateImage(): loaded CData in image (%5.3f sec).', toc(cDataLoadTic), 3, this.verb);

end
