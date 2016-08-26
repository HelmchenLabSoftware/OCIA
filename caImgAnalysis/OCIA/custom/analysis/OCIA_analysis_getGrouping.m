% get the grouping from the different variables
function [grouping, groupLabels] = OCIA_analysis_getGrouping(this, iDWRows, stimIDIndexes, selDispStimIDs, groupBy, ROINames, ROIPhases)

% create the grouping variable
switch groupBy;
    case 'ROI';

        % remove the ROISet tag
        cleanROINames = regexprep(ROINames, 'RS\d+_', '');
        uniqueCleanROINames = unique(cleanROINames, 'stable');
        % get the grouping from ROISet number
        grouping = cellfun(@(ROIName)find(strcmp(ROIName, uniqueCleanROINames)), cleanROINames);
        % expand the matrix for the stimulus types
        grouping = repmat(grouping, 1, numel(stimIDIndexes));
        % linearize the matrix
        grouping = grouping(:);
        % use the ROINames as group labels
        groupLabels = uniqueCleanROINames';

    case 'day';

        % use the "ROIPhases" cell-array if provided and no DataWatcher row indexes provided
        if exist('ROIPhases', 'var') && ~isempty(ROIPhases) && isempty(iDWRows);
            
            % remove the ROISet tag
            uniquePhases = unique(ROIPhases, 'stable');
            % get the grouping from ROI phase
            grouping = cellfun(@(ROIPhase)find(strcmp(ROIPhase, uniquePhases)), ROIPhases);
            % expand the matrix for the stimulus types
            grouping = repmat(grouping, 1, numel(stimIDIndexes));
            % linearize the matrix
            grouping = grouping(:);
            % use the ROINames as group labels
            groupLabels = uniquePhases;
            
        else
            
            % get the grouping from ROISet number
            grouping = cellfun(@(ROIName)str2double(regexprep(regexp(ROIName, 'RS\d+_', 'match'), '[^\d]', '')), ROINames);
            % get the days from the rows and from the ROISet IDs
            allDays = regexprep(unique(get(this, iDWRows, 'day')), '_', '');
            allROISetsDays = regexprep(unique(get(this, iDWRows, 'ROISet')), '_\d+$', '');
            % re-map the grouping using the actual unique days
            for iROISetDay = 1 : numel(allROISetsDays);
                grouping(grouping == iROISetDay) = find(strcmp(allROISetsDays{iROISetDay}, allDays));    
            end;

            % expand the matrix for the stimulus types
            grouping = repmat(grouping, 1, numel(stimIDIndexes));
            % linearize the matrix
            grouping = grouping(:);

            % use different labels for the day groups
%             groupLabels = this.an.img.groupNames(unique(grouping));
            groupLabels = allROISetsDays(unique(grouping));
            
        end;

    case 'stimType';

        % split the stimulus IDs into stimulus ID and PSPerID
        splitStimIDs = cell(2, numel(selDispStimIDs));
        for iStimType = 1 : numel(selDispStimIDs);
            parts = regexp(selDispStimIDs{iStimType}, ' ', 'split');
            if numel(parts) > 2;
                partsString = regexprep(sprintf('%s-', parts{1 : end - 1}), '-$', '');
                parts = [partsString, parts(end)];
            end;
            splitStimIDs(:, iStimType) = parts;
        end;
        % extract the unique stimuli / PSPerID
        uniqueStims = unique(splitStimIDs(1, :), 'stable');
        
        % create a grouping for each stimulus type
        grouping = repmat((1 : numel(stimIDIndexes)), numel(ROINames), 1);
        % linearize the matrix
        grouping = grouping(:);
        
        % re-map the grouping indexes to make it only about the stimulus IDs and not the PSPerID
        for iStimType = 1 : numel(selDispStimIDs);
            grouping(grouping == iStimType) = find(strcmp(splitStimIDs(1, iStimType), uniqueStims));
        end;
        
        % use the stimulus IDs as group labels
        groupLabels = uniqueStims;

    case 'PSPer';

        % split the stimulus IDs into stimulus ID and PSPerID
        splitStimIDs = cell(2, numel(selDispStimIDs));
        for iStimType = 1 : numel(selDispStimIDs);
            parts = regexp(selDispStimIDs{iStimType}, ' ', 'split');
            if numel(parts) > 2;
                partsString = regexprep(sprintf('%s-', parts{1 : end - 1}), '-$', '');
                parts = [partsString, parts(end)];
            end;
            splitStimIDs(:, iStimType) = parts;
        end;
        % extract the unique stimuli / PSPerID
        uniquePSPer = unique(splitStimIDs(2, :), 'stable');
        
        % create a grouping for each stimulus type
        grouping = repmat((1 : numel(stimIDIndexes)), numel(ROINames), 1);
        % linearize the matrix
        grouping = grouping(:);
        
        % re-map the grouping indexes to make it only about the PSPerID and not the stimulus IDs
        for iStimType = 1 : numel(selDispStimIDs);
            grouping(grouping == iStimType) = find(strcmp(splitStimIDs(2, iStimType), uniquePSPer));
        end;
        
        % use the stimulus IDs as group labels
        groupLabels = uniquePSPer;

    case 'stimTypePSPer';

        % create a grouping for each stimulus type
        grouping = repmat((1 : numel(stimIDIndexes)), numel(ROINames), 1);
        % linearize the matrix
        grouping = grouping(:);
        % use the stimulus IDs as group labels
        groupLabels = selDispStimIDs';

    case 'none';

        % return empty vectors
        grouping = [];
        groupLabels = [];

end;

end
