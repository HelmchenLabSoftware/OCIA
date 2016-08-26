% get the grouping from the different variables
function [ROIStat, description] = OCIA_analysis_getROIStat(ROIStatToCalc, respMethod, PSCaTracesStats, ...
    stimIDIndexes, stimIDs)
    
% get the average responsiveness to all trials
ROIResps = reshape(nanmean(PSCaTracesStats.ROIRespTrial, 2), ...
    size(PSCaTracesStats.ROIRespTrial, 1), size(PSCaTracesStats.ROIRespTrial, 3));
        
% select which ROI statistic to analyse
switch ROIStatToCalc;
    
    case 'responsiveness';
        ROIStat = ROIResps(stimIDIndexes, :)';
        % linearize the matrix
        ROIStat = ROIStat(:);

        description = sprintf('Responsiveness (%s %%DRR)', respMethod);
        
    case 'response time';
        
        ROIStat = PSCaTracesStats.ROIRespTime(stimIDIndexes, :)';
        % linearize the matrix
        ROIStat = ROIStat(:);
        description = 'Response time (sec)';
        
    case 'SI';
        
        % calculate SI
        ROIStat = (ROIResps(stimIDIndexes(2), :) - ROIResps(stimIDIndexes(1), :)) ...
            ./ (ROIResps(stimIDIndexes(1), :) + ROIResps(stimIDIndexes(2), :));
        description = sprintf('SI: %s (neg.) - %s (pos.)', stimIDs{stimIDIndexes});
        
    case 'd''';
        
        % calculate d''
        ROIStat = squeeze(...
            ( ...
                nanmean(PSCaTracesStats.ROIRespTrial(stimIDIndexes(2), :, :), 2) ...
                - nanmean(PSCaTracesStats.ROIRespTrial(stimIDIndexes(1), :, :), 2) ...
            ) ...
            ./ ...
            sqrt( ...
                0.5 * nanstd(PSCaTracesStats.ROIRespTrial(stimIDIndexes(1), :, :), [], 2) .^ 2 ...
                + 0.5 * nanstd(PSCaTracesStats.ROIRespTrial(stimIDIndexes(2), :, :), [], 2) .^ 2) ...
            );
        description = sprintf('d'': %s (neg.) - %s (pos.)', stimIDs{stimIDIndexes});
    
end;

end
