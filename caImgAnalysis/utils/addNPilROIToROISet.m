function [ROISet, nROIs] = addNPilROIToROISet(ROISet, nPilMaskBord)

nROIs = size(ROISet, 1);
ROIMasks = ROISet(:, 2); % extract all ROISets
dimMask = size(ROIMasks{1});
NPilROIMask = true(dimMask); % create an ROIMask for the neuropil
% go through all ROIs and exclude their area
for iROIMask = 1 : nROIs; NPilROIMask(ROIMasks{iROIMask}) = false; end;
% remove borders
NPilROIMask(1 : round(dimMask(1) * nPilMaskBord), :) = false;
NPilROIMask(round(dimMask(1) * (1 - nPilMaskBord)) : dimMask(1), :) = false;
NPilROIMask(:, 1 : round(dimMask(2) * nPilMaskBord)) = false;
NPilROIMask(:, round(dimMask(2) * (1 - nPilMaskBord)) : dimMask(2)) = false;
ROISet{end + 1, 1} = 'NPil';
ROISet{end, 2} = NPilROIMask;
nROIs = nROIs + 1;
end
