function OCIA_onlineAnalysis_behavExp_calcCorrAndShiftAndBleach(this, refDay, refFilt, rowsDay, rowFilt, doFlush)
% OCIA_onlineAnalysis_behavExp_calcCorrAndShiftAndBleach - [no description]
%
%       OCIA_onlineAnalysis_behavExp_calcCorrAndShiftAndBleach(this, refDay, refFilt, rowsDay, rowFilt, doFlush)
%
% Calculate correlations of reference to previous day's reference.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)


% get the reference rows of the current day
toProcRows = DWFilterTable(this, sprintf('day = %s AND rowType = Imaging data AND %s', rowsDay, rowFilt));
% go through each row
for iRow = 1 : size(toProcRows, 1);
    
    
    % get the current row's index for this spot
    iDWRow = str2double(get(this, iRow, 'rowNum', toProcRows));
    
    %% fetch rows and data
    % get the current calculated values
    corrToRefTag = get(this, iRow, 'corrToRef', toProcRows);
    shiftTag = get(this, iRow, 'shift', toProcRows);
    bleachRefTag = get(this, iRow, 'bleachRef', toProcRows);
    bleachInnerTag = get(this, iRow, 'bleachInner', toProcRows);
    % if none empty, re-calculate them
    if ~isempty(corrToRefTag) && ~isempty(shiftTag) && ~isempty(bleachRefTag) && ~isempty(bleachInnerTag);
        allColumns = { 'corrToRef', 'shift', 'bleachRef', 'bleachInner' };
        set(this, iDWRow, allColumns, '...');
        DWUpdateColumnsDisplay(this, iDWRow, allColumns, false);
    end; 
    
    % get the spotID for this row
    spotID = get(this, iRow, 'spot', toProcRows);   
    
    % get the reference row
    refRow = DWFilterTable(this, sprintf('day = %s AND %s AND spot = %s', refDay, refFilt, spotID));
    if isempty(refRow);
        showWarning(this, sprintf('OCIA:%s:NoRefRow', mfilename()), sprintf(['OnlineAnalysis: no reference row ', ...
            'found for day %s and spot %s. Skipping.'], refDay, spotID));
        continue;
    end;
    % get the reference row's index for this spot
    iDWRef = str2double(get(this, 1, 'rowNum', refRow));
    % get the average image for the reference row
    refFrames = OCIA_onlineAnalysis_behavExp_getProcessedData(this, iDWRef, 1);
    refImg = nanmean(refFrames, 3);
    
    % get the average image for the current row
    rowFrames = OCIA_onlineAnalysis_behavExp_getProcessedData(this, iDWRow, 1);
    rowImg = nanmean(rowFrames, 3);
    
    %% calculate the correlation between the row's image and the reference
    frameCorrNoAlign = getFrameCorr(refImg, rowImg);
    % store it
    set(this, iDWRow, 'corrToRef', sprintf('%.4f', frameCorrNoAlign));
    DWUpdateColumnsDisplay(this, 1 : size(this.dw.table, 1), 'corrToRef', false);
    
    %% align images to get the shift
    [~, targPoints, srcPoints] = turboReg(rowImg, refImg, 'translation', 10, [], 0);
    
    % get the non-empty reference points
    nonEmptyPoints = sum(sum(srcPoints, 1), 3) ~= 0;
    % remove the empty reference points
    srcPoints = srcPoints(:, nonEmptyPoints, :);
    targPoints = targPoints(:, nonEmptyPoints, :);
    % extract the shifts
    shifts = round(squeeze(srcPoints(:, 1, :) - targPoints(:, 1, :)));
    % store it
    set(this, iDWRow, 'shift', sprintf('%+02.0f/%+02.0f/?', shifts(1), shifts(2)));
    DWUpdateColumnsDisplay(this, 1 : size(this.dw.table, 1), 'shift', false);
    
    %% calculate the correlation between the row's image and the ministack
    % get the ministack for this spot
    miniStackRow = DWFilterTable(this, sprintf('runType = ministack AND spot = %s', spotID));
    
    % ministack not found
    if isempty(miniStackRow);
%         showWarning(this, sprintf('OCIA:%s:NoMinistack', mfilename()), sprintf(['OnlineAnalysis: no ministack row ', ...
%             'found for spot %s. Skipping.'], spotID));
        
    % ministack found
    else
        % get the ministack's row index
        iDWMS = str2double(get(this, 1, 'rowNum', miniStackRow));
        % get the average image for the previous day's reference row
        miniStackFramesAll = OCIA_onlineAnalysis_behavExp_getProcessedData(this, iDWMS, 1);
        % group the frames of the ministack
        nFrames = size(miniStackFramesAll, 3); nFramesPerAvg = 100;
        nFramesStack = nFrames / nFramesPerAvg;
        nRemFrames = mod(nFrames, nFramesPerAvg);
        % if no remaining frames, frames can be grouped
        if nRemFrames == 0;
            miniStackFrames = nan(size(miniStackFramesAll, 1), size(miniStackFramesAll, 2), nFramesStack);
            for i = 1 : nFramesStack;
                frameRange = ((i - 1) * nFramesPerAvg + 1) : i * nFramesPerAvg;
                miniStackFrames(:, :, i) = nanmean(miniStackFramesAll(:, :, frameRange), 3);
            end;
        % otherwise keep all frames
        else
            miniStackFrames = miniStackFramesAll;
        end;
        % store the ministack frames
        setData(this, iDWMS, 'rawImg', 'data', { miniStackFrames });
        setData(this, iDWMS, 'rawImg', 'loadStatus', 'full');
        setData(this, iDWMS, 'procImg', 'data', { miniStackFrames });
        setData(this, iDWMS, 'procImg', 'loadStatus', 'full');

        % calculate correlation to each frame of the ministack
        corrRowToMS = getFrameCorr(rowImg, miniStackFrames);
        [~, maxCorrRowToMSIndexes] = max(corrRowToMS);
        corrRefToMS = getFrameCorr(refImg, miniStackFrames);
        [~, maxCorrRefToMSIndexes] = max(corrRefToMS);
        % calculate Z-shift as the difference between the peak correlation of the reference and the peak from the row image
        zShift = round(maxCorrRefToMSIndexes - maxCorrRowToMSIndexes);
        % store it
        set(this, iDWRow, 'shift', sprintf('%+02.0f/%+02.0f/%+02.0f', shifts(1), shifts(2), zShift));
        DWUpdateColumnsDisplay(this, 1 : size(this.dw.table, 1), 'shift', false);
        
    end;
    
    %% calculate bleaching
    % get the mean intensity difference between the reference's average and the row's average
    bleachToRef = 100 * (nanmean(rowImg(:)) / nanmean(refImg(:))) - 100;
    % store it
    set(this, iDWRow, 'bleachRef', sprintf('%+.2f%%', bleachToRef));
    DWUpdateColumnsDisplay(this, 1 : size(this.dw.table, 1), 'bleachRef', false);
    
    % get the mean intensity difference over the course of the movie
    rowInt = squeeze(nanmean(nanmean(rowFrames, 1), 2))';
    polyParams = polyfit(1 : numel(rowInt), rowInt, 1);
    % figure(); plot(rowInt); hold on; yFit = polyval(polyParams, 1 : numel(rowInt)); plot(yFit, 'r'); hold off;
    
    % store it
    set(this, iDWRow, 'bleachInner', sprintf('%+.2f%%', 100 * polyParams(1)));
    DWUpdateColumnsDisplay(this, 1 : size(this.dw.table, 1), 'bleachInner', false);
    
    %% flush all data for the selected row
    if doFlush;
        DWFlushData(this, iDWRow, 1);
    end;
    
end;
    
end