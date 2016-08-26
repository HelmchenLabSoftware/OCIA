function [ROISet, nROIs] = createFakeROISet(imgDim, ROISize, nMinROIs, nMaxROIs)
%createFakeROISet create a fake ROISet with random ROIs

% get the number of ROIs
nROIs = rand() * (nMaxROIs - nMinROIs) + nMinROIs;

% cell-array of nROIs x 2 columns, where columns are: { ROI name, ROI mask }
ROISet = cell(nROIs, 3);

figH = figure('Visible', 'off');
imagesc(zeros(imgDim));
set(figH, 'Visible', 'off');

% create each ROI
for iROI = 1 : nROIs;

    % create name
    ROISet{iROI, 1} = sprintf('%03d', iROI);
    
    % create position vector
    yCenter = (rand() * 0.9 + 0.1) * imgDim(1);
    xCenter = (rand() * 0.9 + 0.1) * imgDim(2);
    ROIPos = [xCenter, yCenter, ROISize, ROISize];

    ROIH = imellipse(gca, ROIPos);
    ROISet{iROI, 2} = ROIH.createMask();
    delete(ROIH);
end

close(figH);


% % cell-array of nROIs x 4 columns, where columns are: { ROI type, ROI name, ROI position }
% ROISet = cell(nROIs, 3);
% 
% % create each ROI
% for iROI = 1 : nROIs;
% 
%     % create type and name
%     ROISet{iROI, 1} = 'imellipse';
%     ROISet{iROI, 2} = sprintf('%03d', iROI);
%     
%     % create position vector
%     yCenter = (rand() * 0.9 + 0.1) * imgDim(1);
%     xCenter = (rand() * 0.9 + 0.1) * imgDim(2);
%     ROISet{iROI, 3} = [xCenter, yCenter, ROISize, ROISize];
% 
% end

