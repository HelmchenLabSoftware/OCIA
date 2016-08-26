function RDCombineROIs(this, ~, ~)
% RDCombineROIs - [no description]
%
%       RDCombineROIs(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

    nRows = numel(this.rd.selectedTableRows);
    showMessage(this, sprintf('Combining %d ROISets ...', nRows), 'yellow');
    
    %% load ROIs
    showMessage(this, 'Loading ROISets...', 'yellow');
    ROISets = cell(nRows, 1);
    refImgs = cell(nRows, 1);
    masks = cell(nRows, 1);
    ROINamesUnion = {};
    RDClearROIs(this);
    for iRow = 1 : nRows;
        RDChangeRow(this, iRow);
        RDLoadROIs(this);
        ROISets{iRow} = this.rd.ROIs;
        refImgs{iRow} = this.data.preProc{this.rd.selectedTableRows(iRow)}{this.an.img.preProcChan};
        masks{iRow} = this.rd.ROIMask;
        ROINamesUnion = [ROINamesUnion; ROISets{iRow}(:, 2)]; %#ok<AGROW>
    end;
    
    %% align the reference images to the selected reference
    iRef = get(this.GUI.handles.rd.tableList, 'Value');
    showMessage(this, sprintf('Aligning reference images to reference no %d...', iRef), 'yellow');
    % get the image's dimension
    imgDim = size(refImgs{iRef});
    refImgMat = permute(reshape(cell2mat(refImgs), imgDim(1), nRows, imgDim(2)), [1 3 2]);
    
    refImg = refImgs{iRef};
    ROISet = cell(size(ROISets{iRef}, 1), 2);
    ROISet(:, 1) = ROISets{iRef}(:, 2);
    ROISet(:, 2) = arrayfun(@(x) masks{iRef} == x, 1 : size(ROISets{iRef}, 1), 'UniformOutput', false);
    
    % get the ROISet of the brightest ROI(s)
%     nBrightROIs = 1; % number of brightest ROIs
    nBrightROIs = 3; % number of brightest ROIs
    percBoundBox = 0.04; % percent of image around the ROI's bounding box
    brightROISet = getBrightROIs(ROISet, refImg, nBrightROIs, percBoundBox, 0);
    % store the coordinates of those ROIs
    refPpoints = zeros(nBrightROIs, 2);
    for iBrightROI = 1 : nBrightROIs;
        % get the indexes of the mask and calculate the center of it
        [maskYVals, maskXVals] = ind2sub(imgDim([1, 2]), find(brightROISet{iBrightROI, 4}));
        refPpoints(iBrightROI, :) = round([nanmean(maskXVals), nanmean(maskYVals)]);
    end;
    
    % transform the coordinates into source-target pairs (src1X src1Y targ1X targ1Y src2X src2Y targ2X targ2Y ...)
    refPointsBlock = zeros(1, numel(refPpoints) * 2);
    for iBrightROI = 1 : nBrightROIs;
        refPointsBlock((iBrightROI - 1) * 4 + 1) = refPpoints(iBrightROI, 1);
        refPointsBlock((iBrightROI - 1) * 4 + 2) = refPpoints(iBrightROI, 2);
        refPointsBlock((iBrightROI - 1) * 4 + 3) = refPpoints(iBrightROI, 1);
        refPointsBlock((iBrightROI - 1) * 4 + 4) = refPpoints(iBrightROI, 2);
    end;
    
    % align references
    [alignedRefs, targPoints, srcPoints] = turboReg(refImgMat, refImg, 'rigidBody', 10, ...
        refPointsBlock, 0);
    
    showMessage(this, 'Aligning ROIs...', 'yellow');
    doPlot = 0;
    if doPlot;
        for iRef = 1 : nRows; %#ok<UNRCH>
            figure();
            subplot(1, 2, 1);
            imshow(linScale(refImgMat(:, :, iRef)));
            subplot(1, 2, 2);
            imshow(linScale(alignedRefs(:, :, iRef)));
        end;
    end;

    this.GUI.rd.img = nanmean(alignedRefs, 3);
    
    % get the tforms
    tForms = cell(1, nRows);
    for iRow = 1 : nRows;
        inPoints = squeeze(srcPoints(iRow, :, :));
        basePoints = squeeze(targPoints(iRow, :, :));
        % get the transformation matrix
        tForms{iRow} = cp2tform(inPoints, basePoints, 'affine');
    end;
    
    %% combine the ROIs
    showMessage(this, 'Combining ROIs...', 'yellow');
    ROINames = unique(ROINamesUnion); % get all names
    % create a combined ROISet with an extra column
    combinedROISet = cell(size(ROINames, 1), size(ROISets{1}, 2) + 1);
    % go through each ROI
    for iROI = 1 : size(ROINames, 1);
        % check their presence in each ROISet
        for iROISet = 1 : nRows;
            % if ROI is present in the current ROISet
            if ismember(ROINames{iROI}, ROISets{iROISet}(:, 2));
                
                % get the ROI from the ROISet
                ROIRow = ROISets{iROISet}(strcmpi(ROINames{iROI}, ROISets{iROISet}(:, 2)), :);
                ROIPos = ROIRow{3};
                
                % polygons and others
                if any(strcmp(ROIRow{4}, {'imfreehand', 'impoly'}));
                
                    % if no already in the combined ROISet
                    if ~any(strcmp(ROINames{iROI}, combinedROISet(:, 2)));
                        combinedROISet(iROI, 1 : numel(ROIRow)) = ROIRow;
                    end;
                    ROICoords = ROIPos;
                    % get the transformed frame
                    ROICoordsTransf = tformfwd(ROICoords, tForms{iROISet});
                    ROINewPos = ROICoordsTransf;

                    if ~size(combinedROISet{iROI, 7}, 1);
                        combinedROISet{iROI, 7} = ROINewPos;
                    else
                        combinedROISet{iROI, 7}(:, :, end + 1) = ROINewPos;
                    end;
                    
                % "normal" ROIs
                else
                    % if no already in the combined ROISet
                    if ~any(strcmp(ROINames{iROI}, combinedROISet(:, 2)));
                        combinedROISet(iROI, :) = [ROIRow, {ones(0, 4)}];
                    end;

                    ROICoords = [ROIPos(1 : 2); ROIPos(1 : 2) + [ROIPos(3) 0]; ...
                        ROIPos(1 : 2) + [0 ROIPos(4)]; ROIPos(1 : 2) + [ROIPos(3) ROIPos(4)]];
                    % get the transformed frame
                    ROICoordsTransf = tformfwd(ROICoords, tForms{iROISet});
                    ROINewPos = [nanmean(ROICoordsTransf([1 3], 1)), nanmean(ROICoordsTransf([1 2], 2)), ...
                        nanmean(ROICoordsTransf([2 4], 1) - ROICoordsTransf([1 3], 1)), ...
                        nanmean(ROICoordsTransf([3 4], 2) - ROICoordsTransf([1 2], 2))];

                    if ~size(combinedROISet{iROI, 7}, 1);
                        combinedROISet{iROI, 7} = ROINewPos;
                    else
                        combinedROISet{iROI, 7} = [combinedROISet{iROI, 7}; ROINewPos];
                    end;
                end;
            end;
        end;
        
        
        % use the average of the positions as the final position
        if any(strcmp(ROIRow{4}, {'imfreehand', 'impoly'}));
            combinedROISet{iROI, 3} = nanmedian(combinedROISet{iROI, 7}, 3);
        else
            combinedROISet{iROI, 3} = nanmedian(combinedROISet{iROI, 7}, 1);
        end;
        
%         % use the average of the positions as the final position
%         if strcmp(ROIRow{4}, 'imfreehand');
%             combinedROISet{iROI, 3} = squeeze(combinedROISet{iROI, 7}(:, :, 1));
%         else
%             combinedROISet{iROI, 3} = combinedROISet{iROI, 7}(1, :);
%         end;
        
    end;
    
    % clear the last row
    combinedROISet(:, end) = [];
    
    %% display the aligned reference images
    showMessage(this, 'Updating display...', 'yellow');
    for iRow = 1 : nRows;
        this.rd.avgImages{iRow} = cat(3, zeros(imgDim), linScale(squeeze(alignedRefs(:, :, iRow))), zeros(imgDim));
    end;
    
    %% display the ROIs
    RDClearROIs(this);
    
    this.rd.ROIs = combinedROISet;
    this.rd.nROIs = size(combinedROISet, 1);
    
    % recreate the imroi objects
    for iROI = 1 : this.rd.nROIs;
        % make sure name is displayed with 3 digits
        this.rd.ROIs{iROI, 2} = sprintf('%03d', str2double(this.rd.ROIs{iROI, 2}));
        % common inputs for the imrois
        inputs = {this.GUI.handles.rd.axe, this.rd.ROIs{iROI, 3}};
        % set the type of the imroi in the 4th column
        this.rd.ROIs{iROI, 4} = this.rd.ROIs{iROI, 1};
        % recreate the imroi depending on its type
        switch class(this.rd.ROIs{iROI, 1});
            case {'impoly', 'imfreehand'};
                this.rd.ROIs{iROI, 1} = impoly(inputs{:}, 'Closed', true);
                this.rd.ROIs{iROI, 1}.setVerticesDraggable(false);
            otherwise
                imroiFuncHandle = str2func(class(this.rd.ROIs{iROI, 1}));
                this.rd.ROIs{iROI, 1} = imroiFuncHandle(inputs{:});
        end;
        % add the position callback
        ROIID = this.rd.ROIs{iROI, 2};
        this.rd.ROIs{iROI, 1}.addNewPositionCallback(@(h)RDUpdateImage(this, [], [], ROIID));
        this.rd.ROIs{iROI, 6} = true; % mark as modified/created
    end;
    
    RDUpdateGUI(this);
    
    showMessage(this, 'Combining ROIs done.');
    
end
