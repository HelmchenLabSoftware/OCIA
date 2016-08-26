function RDCompareROIs(this, ~, ~)
% RDCompareROIs - [no description]
%
%       RDCompareROIs(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% do not process if not in RDCompare mode
if ~get(this.GUI.handles.rd.refROISet, 'Value');
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
end;

selRows = get(this.GUI.handles.rd.tableList, 'Value');
nSelRows = numel(selRows);
if nSelRows == 1;
    showWarning(this, 'OCIA:RD:RDCompareROIs:BadRowNumber', 'Cannot compare a single ROISet!');
    set(this.GUI.handles.rd.refROISet, 'Value', 0);
    set(this.GUI.handles.rd.refROISetASetter, 'Value', 1);
    set(this.GUI.handles.rd.refROISetBSetter, 'Value', 1);
    return;
end;

% get which ROISet should be used as reference
refTargRowNums = cellfun(@str2double, get(this.GUI.handles.rd.refROISetASetter, 'String'))';
iRef = refTargRowNums(get(this.GUI.handles.rd.refROISetASetter, 'Value'));
if isempty(iRef);
    showWarning(this, 'OCIA:RD:RDCompareROIs:NoRefSelected', sprintf('Bad reference ROISet specified (%d).', iRef));
    set(this.GUI.handles.rd.refROISet, 'Value', 0);
    set(this.GUI.handles.rd.refROISetASetter, 'Value', 1);
    set(this.GUI.handles.rd.refROISetBSetter, 'Value', 1);
    return;
elseif numel(iRef) > 1;
    showWarning(this, 'OCIA:RD:RDCompareROIs:TooManyRefSelected', 'Can only select one reference ROISet.');
    iRef = iRef(1);
    set(this.GUI.handles.rd.refROISetASetter, 'Value', iRef);
end;

% get reference's rowID
iDWRowRef = this.rd.selectedTableRows(iRef);
refRowID = DWGetRowID(this, iDWRowRef);
% get the current reference's ROISet index

% get which ROISets should be used as targets
iTargs = refTargRowNums(get(this.GUI.handles.rd.refROISetBSetter, 'Value'));
iTargs(iTargs == iRef) = []; % remove reference from selection
% no targets
if isempty(iTargs);
    
    % display reference image if possible and needed
    if ~isempty(this.rd.rc.refImgs) && numel(this.rd.rc.refImgs) >= iRef && ~isempty(this.rd.rc.refImgs{iRef}) ...
            && (isempty(this.rd.rc.displayedRef) || this.rd.rc.displayedRef ~= iRef);

        showMessage(this, sprintf('Comparing %d ROISets, image shown: %s (%d).', nSelRows, refRowID, iRef), 'yellow');

        img = this.rd.rc.refImgs{iRef};
        this.GUI.rd.img = img;
        set(this.GUI.handles.rd.img, 'CData', img);
        set(this.GUI.handles.rd.axe, 'XLim', [0 size(img, 1)], 'YLim', [0 size(img, 2)]);
        this.rd.rc.displayedRef = iRef;

    else
        showWarning(this, 'OCIA:RD:RDCompareROIs:NoTargSelected', 'Bad target ROISet specified.');
    end;

    return;

end;

% set back the updated selection, with the eventual reference excluded
set(this.GUI.handles.rd.refROISetBSetter, 'Value', find(ismember(refTargRowNums, iTargs)));

%% load ROIs and reference images
if isempty(this.rd.rc.ROISets) || numel(this.rd.rc.ROISets) < numel(this.rd.selectedTableRows) ...
        || isempty(this.rd.rc.ROISetIDs) || ~ismember(refRowID, this.rd.rc.ROISetIDs);

    showMessage(this, 'Loading ROISets...', 'yellow');

    ROISets = cell(max(selRows), 1);
    refImgs = cell(max(selRows), 1);
    ROINamesUnion = {};
    RDClearROIs(this);
    
    % get the ROISet rows
    ROISetDWRows = DWFilterTable(this, 'rowType = ROISet', this.dw.table(this.rd.selectedTableRows, :));
    this.rd.rc.ROISetIDs = DWGetRowID(this, 'all', ROISetDWRows);
    
    % go through each selected row
    for iRow = 1 : numel(this.rd.selectedTableRows);

        if ~ismember(iRow, selRows); continue; end;

        % get ROISet
        iDWRow = this.rd.selectedTableRows(iRow);
        ROISetData = getData(this, iDWRow, 'ROISets', 'data');
        ROISets{iRow} = ROISetData.ROISet;
        ROISets{iRow}(strcmp(ROISets{iRow}(:, 1), 'NPil'), :) = []; % remove NPil

        % get reference image
        refImgs{iRow} = ROISetData.refImage;
        % if it is a cell-array, turn it into RGB
        if iscell(refImgs{iRow});
            refImgs{iRow} = cell2RGB(refImgs{iRow}, this.an.img.colVect, true);
        % if it is a matrix, turn into RGB
        elseif ismatrix(refImgs{iRow});
            refImgs{iRow} = repmat(refImgs{iRow}, [1 1 3]);
        % if not an RGB image, abort
        elseif ndims(refImgs{iRow}) ~= 3;
            showWarning(this, 'OCIA:RD:RDCompareROIs:BadRefImage', ...
                sprintf('Bad reference image for %s (%02d).', this.rd.rc.ROISetIDs{iRow}, iDWRow));
            ROISets{iRow} = [];
            refImgs{iRow} = [];
            continue;
        end;
        
        % enhance the image
        refImgs{iRow} = PseudoFlatfieldCorrect(refImgs{iRow});
        % enhance each channel
        for iChan = 1 : 3;
            % auto enhance
            if get(this.GUI.handles.rd.autoImAdj, 'Value');
                refImgs{iRow}(:, :, iChan) = imadjust(refImgs{iRow}(:, :, iChan));
            % enhance with value of the GUI setters
            else
                minAdj = get(this.GUI.handles.rd.imAdjMinSetter, 'Value');
                maxAdj = get(this.GUI.handles.rd.imAdjMaxSetter, 'Value');
                refImgs{iRow}(:, :, iChan) = imadjust(refImgs{iRow}(:, :, iChan), [minAdj, maxAdj]);
            end;
        end;

        % get the union of all names
        ROINamesUnion = [ROINamesUnion; ROISets{iRow}(:, 1)]; %#ok<AGROW>
    end;

    % store so that there is no need to reload
    this.rd.rc.ROISets = ROISets;
    this.rd.rc.refImgs = refImgs;
    this.rd.rc.ROINamesUnion = ROINamesUnion;

else
    
    showMessage(this, 'ROISets already loaded ...', 'yellow');

    % reload information
    ROISets = this.rd.rc.ROISets;
    refImgs = this.rd.rc.refImgs;
    ROINamesUnion = this.rd.rc.ROINamesUnion; %#ok<NASGU>

end;

% display reference image if needed
if isempty(this.rd.rc.displayedRef) || this.rd.rc.displayedRef ~= iRef;
    img = refImgs{iRef};
    this.GUI.rd.img = img;
    set(this.GUI.handles.rd.img, 'CData', img);
    set(this.GUI.handles.rd.axe, 'XLim', [0 size(img, 1)], 'YLim', [0 size(img, 2)]);

    this.rd.rc.displayedRef = iRef;
end;

% clear the annotations
try
    childHands = get(this.GUI.handles.rd.axe, 'Children');
    childTags = get(childHands, 'Tag');
    delete(childHands(strcmp('ROICompareLine', childTags)));
    delete(childHands(strcmp('ROICompareText', childTags)));
    delete(childHands(strcmp('ROICompareScatter', childTags)));
catch e; %#ok<NASGU>        
end;

% get the drawing axe
axeH = this.GUI.handles.rd.axe;

%% calculate ROI positions and compare ROISets
ROIsAOnly = cell(1, max(selRows)); % only in reference
ROIsBOnly = cell(1, max(selRows)); % only in target
ROIsMM = cell(1, max(selRows)); % in both but with a big position difference    

args = {'FontSize', 10, 'HorizontalAlignment', 'center', 'Parent', axeH, 'Tag', 'ROICompareText'};

colAB = [0 1 0];
%     colABLine = [];
colABLine = [0 1 0];
colABMM = [1 0 0];
% colA = [1 0.2 0.5];
colA = [1 0.5 0.2];
colB = [1 1 0];

% go through each ROISet
for iTarg = 1 : numel(this.dw.selectedTableRows);

    % skip comparisons with not selected targets
    if ~ismember(iTarg, iTargs); continue; end;

    % get target's rowID
    iDWRowTarg = this.rd.selectedTableRows(iTarg);
    targRowID = DWGetRowID(this, iDWRowTarg);

    showMessage(this, sprintf('Comparing %s (%d) to %s (%d) ...', refRowID, iRef, targRowID, iTarg), 'yellow');

    % get the ROISets to compare, their names and the combined set of their names
    ROISetA = ROISets{iRef};
    ROISetB = ROISets{iTarg};
    nROIsA = size(ROISetA, 1);
    nROIsB = size(ROISetB, 1);
    ROINamesA = unique(ROISetA(:, 1));
    ROINamesB = unique(ROISetB(:, 1));
    ROINamesAB = unique([ROINamesA; ROINamesB]);
    nROIsAB = size(ROINamesAB, 1);

    % calculate the position/angles diferences
    posDiffs = nan(nROIsAB, 2);
    
    % store the unique ROI list's positions
    ROIPos = nan(nROIsAB, 2, 2);

    % go through each ROI of the combined set
    for iROI = 1 : nROIsAB;

        iROIA = 0; iROIB = 0;

        % if member of ROISet A, calculate position
        if ismember(ROINamesAB{iROI}, ROINamesA)
            iROIA = find(strcmp(ROINamesAB{iROI}, ROINamesA));
            % get ROI's position in the reference ROISet
            ROIMaskA = ROISetA{strcmp(ROINamesAB{iROI}, ROINamesA), 2}';
            [ROIPosXA, ROIPosYA] = ind2sub(size(ROIMaskA), find(ROIMaskA));
            ROISetA{iROIA, 3} = [mean(ROIPosXA), mean(ROIPosYA)]; % store position
        end;

        % if member of ROISet B, calculate position
        if ismember(ROINamesAB{iROI}, ROINamesB)
            iROIB = find(strcmp(ROINamesAB{iROI}, ROINamesB));
            % get ROI's position in the target ROISet
            ROIMaskB = ROISetB{strcmp(ROINamesAB{iROI}, ROINamesB), 2}';
            [ROIPosXB, ROIPosYB] = ind2sub(size(ROIMaskB), find(ROIMaskB));
            ROISetB{iROIB, 3} = [mean(ROIPosXB), mean(ROIPosYB)];
        end;

        % if a ROI is member of both sets, calculate position differences and store it
        if iROIA && iROIB;
            posDiffs(iROI, :) = ROISetB{iROIB, 3} - ROISetA{iROIA, 3};
            ROIPos(iROI, :, 1) = ROISetA{iROIA, 3};
            ROIPos(iROI, :, 2) = ROISetB{iROIB, 3};
        end;
    end;
    
    
%{
    % get the mean point of both ROISets
    ROISetAMeanPos = squeeze(nanmean(ROIPos(:, :, 1)));
    ROISetBMeanPos = squeeze(nanmean(ROIPos(:, :, 2)));
    
    figure('Name', 'Raw positions', 'NumberTitle', 'off', 'Position', [2019 109 1078 796]);
    hold on;
    scatter(ROIPos(:, 1, 1), ROIPos(:, 2, 1), 'bx');
    scatter(ROIPos(:, 1, 2), ROIPos(:, 2, 2), 'rx');
    legend({'A', 'B'});
    xlim([0 200]); ylim([0 200]);
%     xlim([-400 600]); ylim([-400 600]);
    xlim([-100 600]); ylim([-100 600]);
    set(gca, 'YDir', 'reverse');
    hold off;
    
    % get the positions centered around the middle of the ROIs
    ROIPosCent = nan(size(ROIPos));
    offsetCent = [100, 1000];
%     ROIPosCent(:, :, 1) = ROIPos(:, :, 1) - repmat(ROISetAMeanPos, nROIsAB, 1, 1);
%     ROIPosCent(:, :, 2) = ROIPos(:, :, 2) - repmat(ROISetBMeanPos, nROIsAB, 1, 1);
    ROIPosCent(:, :, 1) = ROIPos(:, :, 1) - repmat(offsetCent, nROIsAB, 1, 1);
    ROIPosCent(:, :, 2) = ROIPos(:, :, 2) - repmat(offsetCent, nROIsAB, 1, 1);
    meanDiff_BToA = nanmean(nanmean(abs(ROIPosCent(:, :, 2) - ROIPosCent(:, :, 1))));
    
    figure('Name', 'Centered positions', 'NumberTitle', 'off', 'Position', [2019 109 1078 796]);
    hold on;
    scatter(ROIPosCent(:, 1, 1), ROIPosCent(:, 2, 1), 'bx');
    scatter(ROIPosCent(:, 1, 2), ROIPosCent(:, 2, 2), 'rx');
    legend({'A', 'B'});
%     xlim([-100 100]); ylim([-100 100]);
    xlim([-150 150]); ylim([-1200 0]);
    set(gca, 'YDir', 'reverse');
    hold off;
    
%     rotToTest = 2;
%     ROIPosCentRot = nan(size(ROIPosCent));
%     ROIPosCentRot(:, 1, 2) = ROIPosCent(:, 1, 2) * cosd(rotToTest) - ROIPosCent(:, 1, 2) * sind(rotToTest);
%     ROIPosCentRot(:, 2, 2) = ROIPosCent(:, 2, 2) * sind(rotToTest) + ROIPosCent(:, 2, 2) * cosd(rotToTest);
    
%     hold on;
%     scatter(ROIPosCentRot(:, 1, 2), ROIPosCentRot(:, 2, 2), 'ro');
%     meanDiff_rotBToA = nanmean(nanmean(abs(ROIPosCentRot(:, :, 2) - ROIPosCent(:, :, 1))));
%     legend({'A', sprintf('B_{ori} %.3f', meanDiff_BToA), sprintf('B_{rot} %.3f', meanDiff_rotBToA)});

%}

    % calculate position threshold as the biggest of either 1.5 SD of position or 10 pixels
    meanPosDiff = nanmean(posDiffs);
    posDiffThresh = nanmax(3 * nanstd(posDiffs), 20);

    % get the ROIs that have a unusual angle difference
    badPosDiffsX = find(abs(posDiffs(:, 1) - meanPosDiff(:, 1)) > posDiffThresh(:, 1));
    badPosDiffsY = find(abs(posDiffs(:, 2) - meanPosDiff(:, 2)) > posDiffThresh(:, 2));
    badPosDiffs = unique([badPosDiffsX; badPosDiffsY]);
    badROINames = '';
    for iROILoop = 1 : numel(badPosDiffs);
        iROI = badPosDiffs(iROILoop);
        badROINames = sprintf('%s, %s [%.1f, %.1f]', badROINames, ROINamesAB{iROI}, ...
            posDiffs(iROI, 1), posDiffs(iROI, 2));
    end;
    badROINames = regexprep(badROINames, '^, ', '');

    if ~isempty(badROINames);
        showMessage(this, sprintf('Found badly positioned ROIs with target %s (%d): %s', ...
            targRowID, iTarg, badROINames));
    end;

    hold(axeH, 'on');
    
    % if no matching ROIs, use 0 0 as position difference
    if all(isnan(meanPosDiff)); meanPosDiff = [0 0]; end;
    

    for iROI = 1 : nROIsAB;

        iROIA = 0; iROIB = 0;

        if ismember(ROINamesAB{iROI}, ROINamesA)
            iROIA = find(strcmp(ROINamesAB{iROI}, ROINamesA));
            ROIPosA = ROISetA{iROIA, 3};
        end;
        if ismember(ROINamesAB{iROI}, ROINamesB)
            iROIB = find(strcmp(ROINamesAB{iROI}, ROINamesB));
            ROIPosB = ROISetB{iROIB, 3};
        end;

        % in both sets but with a position mismatch
        if iROIA && iROIB && ismember(iROI, badPosDiffs);

            ROIsMM{1, iTarg}{end + 1} = ROINamesAB{iROI};
            if ~isempty(colABMM);
                text(ROIPosA(1), ROIPosA(2), ROINamesA{iROIA}, 'Color', colABMM, args{:});
                line([ROIPosA(1) ROIPosB(1)], [ROIPosA(2) ROIPosB(2)], 'Color', colABMM, 'LineStyle', ':', ...
                    'Tag', 'ROICompareLine', 'Parent', axeH);
            end;

        % in both sets but with no position mismatch
        elseif iROIA && iROIB && ~ismember(iROI, badPosDiffs) && ~isempty(colAB);

            text(ROIPosA(1), ROIPosA(2), ROINamesA{iROIA}, 'Color', colAB, args{:});
            if ~isempty(colABLine);
                line([ROIPosA(1) ROIPosB(1)], [ROIPosA(2) ROIPosB(2)], 'Color', colABLine, 'LineStyle', ':', ...
                    'Tag', 'ROICompareLine', 'Parent', axeH);
            end;

        % only in reference  
        elseif iROIA && ~isempty(colA);

            ROIsAOnly{1, iTarg}{end + 1} = ROINamesAB{iROI};
            posOnB = ROIPosA + meanPosDiff;
            text(ROIPosA(1), ROIPosA(2), ROINamesA{iROIA}, 'Color', colA, args{:});
            line([ROIPosA(1) posOnB(1)], [ROIPosA(2) posOnB(2)], 'Color', colA, 'LineStyle', ':', ...
                'Tag', 'ROICompareLine', 'Parent', axeH);

        % only in target
        elseif iROIB && ~isempty(colB);

            ROIsBOnly{1, iTarg}{end + 1} = ROINamesAB{iROI};
            posOnA = ROIPosB - meanPosDiff;
            text(posOnA(1), posOnA(2), ROINamesB{iROIB}, 'Color', colB, args{:});
            line([ROIPosB(1) posOnA(1)], [ROIPosB(2) posOnA(2)], 'Color', colB, 'LineStyle', ':', ...
                'Tag', 'ROICompareLine', 'Parent', axeH);

        end;
    end;
end;

showMessage(this, 'Comparing ROISets done.');
    
end
