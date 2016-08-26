function comparingReferences

load('refImg_fromMapping');
refImgMapping = refImg;
load('refImg');
load('ROIs');

figure('NumberTitle', 'off', 'Name', 'Reference compare', 'Position', [30, 80, 1850, 910], 'Color', 'white');

makeSubplot(1, refImg, 'Reference from session', ROIs, [-0.05, 1.05]); %#ok<*USENS,*NODEF>
makeSubplot(2, refImgMapping, 'Reference from mapping (ROIs)', ROIs, [-0.05, 1.05]);

corrCoeffs = corrcoef(refImg, refImgMapping, 'rows', 'pairwise');
makeSubplot(3, refImgMapping - refImg, sprintf('Ref_{session} - Ref_{mapping}, corr: %.3f', corrCoeffs(2, 1)), ROIs, [-0.5 0.2]);

% register reference onto local session reference
CP = fix(256 / 2); % center point
TTP = fix(2 * 256 / 3); % two third point
refPoints = [CP TTP CP TTP TTP CP TTP CP CP CP CP CP];
[~, targPoints, srcPoints] = turboReg(refImgMapping, refImg, 'rigidBody', 3, refPoints, 0);
% get the transformation matrix
tForm = cp2tform(squeeze(srcPoints), squeeze(targPoints), 'affine'); %#ok<DCPTF>
% get the transformed frame
refImgMappingReg = imtransform(refImgMapping, tForm, 'XData', [1, 256], 'YData', [1, 256], 'FillValues', NaN); %#ok<DIMTRNS>

% shift ROIs
ROIsShift = ROIs;
translationShifts = squeeze(srcPoints(:, 1, :) - targPoints(:, 1, :));
for iROI = 1 : size(ROIs, 1);
    % adjust mask
    ROIsShift{iROI, 3} = imtransform(ROIs{iROI, 3}, tForm, 'XData', [1, 256], 'YData', [1, 256], 'FillValues', NaN) == 1; %#ok<DIMTRNS>
    % adjust coordinates
    ROIsShift{iROI, 2} = round(ROIsShift{iROI, 2} + repmat(translationShifts', size(ROIsShift{iROI, 2}, 1), 1));
end;


corrCoeffs = corrcoef(refImg, refImgMappingReg, 'rows', 'pairwise');
makeSubplot(4, refImgMappingReg - refImg, sprintf('Ref_{mapReg} - Ref_{session}, corr: %.3f', corrCoeffs(2, 1)), ROIsShift, [-0.5 0.2]);

corrCoeffs = corrcoef(refImgMapping, refImgMappingReg, 'rows', 'pairwise');
makeSubplot(5, refImgMappingReg - refImgMapping, sprintf('Ref_{mapReg} - Ref_{mapping}, corr: %.3f', corrCoeffs(2, 1)), ROIsShift, [-0.5 0.2]);

makeSubplot(6, refImgMappingReg, 'Reference from mapping registered', ROIsShift, [-0.05, 1.05]); %#ok<*NODEF>

ROIsOri = ROIs; %#ok<NASGU>
ROIs = ROIsShift; %#ok<NASGU>
save('ROIs_registered', 'ROIs');
clear ROIs iROI CP TTP corrCoeffs;

save('registration');
export_fig('registration.fig', gcf);
export_fig('registration.png', '-r300', gcf);

end

function makeSubplot(iSubPlot, data, titleStr, ROIs, cLim)

    subplot(2, 3, iSubPlot);
    imagesc(1 : 256, 1 : 256, data);
    title(titleStr);
    colormap('gray');
    set(gca, 'CLim', cLim);
    % axis('square');
    hold('on');
    ROIColors = [0 1 1; 1 0 1; 0 1 0; 1 1 0; 1 0 0; 0 0 1];
    for iROI = 1 : size(ROIs, 1);
        contour(ROIs{iROI, 3}, 'Color', ROIColors(iROI, :), 'LineStyle', '-');
    end;
    legend(ROIs(:, 1));
    hold('off');

end

% export_fig('analysis/ref_withROIs.png', '-r300', gcf);
% export_fig('analysis/ref_withROIs.fig', gcf);