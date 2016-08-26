
% PSROIStatsData;

nROI = size(PSROIStatsData, 1);
nStim = size(PSROIStatsData, 2);
PSROIStatsDataBLN = cell(nROI, 10);
PSROIStatsDataPureTones = cell(nROI, nStim);

for iROI = 1 : nROI;
    for iStim = 1 : nStim;
        if iStim <= 10;
            PSROIStatsDataBLN{iROI, iStim} = PSROIStatsData{iROI, iStim}(1:15, :);
            PSROIStatsDataPureTones{iROI, iStim} = PSROIStatsData{iROI, iStim}(16:25, :);
        else
            PSROIStatsDataPureTones{iROI, iStim} = PSROIStatsData{iROI, iStim};
        end;
    end;
end;