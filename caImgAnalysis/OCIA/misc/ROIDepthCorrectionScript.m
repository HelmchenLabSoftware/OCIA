% ROIDepthCorrectionScript

tic;

RCaMPProjectRoot = 'W:\Neurophysiology\Projects\RUNNING\RCaMP\';
ROIDepthFilePath = [RCaMPProjectRoot 'ROI depth correction\ROI depth correction.xlsx'];
ROITableFilePath = [RCaMPProjectRoot 'Analysis\2015_07_17__Balazs_whiskerAngleAnalysis\ROITable.mat'];

load(ROITableFilePath);

for iAnim = 0 : 7;
    
    animID = sprintf('Mouse %d', iAnim);
    o('Processing "%s" ...', animID, 0, 0);
    try
        [~, ~, raw] = xlsread(ROIDepthFilePath, animID, '', 'basic');
    catch err;
        if strcmp(err.identifier, 'MATLAB:xlsread:WorksheetNotFound');
            o('"%s" not found in excel file, skipping...', animID, 0, 0);
            continue;
        else
            rethrow(err);
        end;
    end;
    
    animalMask = strcmp(ROITable.animal, animID);
    for iRow = 2 : size(raw, 1);
        [dayID, spotNum, spotDepth, ROIID, ROIDepth] = raw{iRow, [1 2 4 3 9]};
        spotName = sprintf('Spot%d_%d', spotNum, spotDepth);
        ROITableIndex = find(animalMask & strcmp(ROITable.day, dayID) ...
            & strcmp(ROITable.spot, spotName) & strcmp(ROITable.ROIID, ROIID));
        if isempty(ROITableIndex);
            o(' - Warning: ROI not found in ROITable: ROI %s - %s - %s - %s', ROIID, dayID, spotName, animID, 0, 0);
        elseif numel(ROITableIndex) > 1;
            o(' - Warning: ROI with multiple matches: ROI %s - %s - %s - %s', ROIID, dayID, spotName, animID, 0, 0);
        else
            ROITable{ROITableIndex, 'depth'} = ROIDepth; %#ok<SAGROW>
        end;
    end;
    
    o('Processing "%s" done.', animID, 0, 0);
    
end;

o('Checking ROITable ...', 0, 0);
for iRow = 1 : size(ROITable, 1);
    ROIDepth = ROITable{iRow, 'depth'};
    ROIID = ROITable{iRow, 'ROIID'};
    if ROIDepth == 0 && strcmp(ROIID, 'NPil');
        ROITable{iRow, 'depth'} = str2double(regexprep(ROITable{iRow, 'spot'}, 'Spot\d_', '')); %#ok<SAGROW>
    elseif ROIDepth == 0;
        o(' - Warning: ROI not found in excel file: ROI %s - %s - %s - %s', ROIID, ROITable{iRow, 'day'}, ...
            ROITable{iRow, 'spot'}, ROITable{iRow, 'animal'}, 0, 0);
    else
        ROITable{ROITableIndex, 'depth'} = ROIDepth; %#ok<SAGROW>
    end;
end;

o('Saving new ROITable ...', 0, 0);
save(regexprep(ROITableFilePath, '.mat', '_depthCorrected.mat'), 'ROITable');

o('Done ! (%.3f sec)', toc, 0, 0);