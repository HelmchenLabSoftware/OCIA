%%
load('refImg.mat');
load('ROIs.mat');
load('cond_CR_trial1.mat');
load('first_move_in_delay.mat');
load('trials_with_and_wo_initial_moves_OCIA_from_movie.mat');
load('move_vectors_from_movie.mat');
load('behaviorVectors.mat');

cropDims = [18, 22, 215 215];
% cropDims = [09, 29, 223 223];

figProps = { 'NumberTitle', 'off', 'Color', 'white', 'Position', [50 50 1150 880]};
% figProps = { 'NumberTitle', 'off', 'Color', 'white', 'Position', [10 10 1900 1100]};

exportArgsPNG = { '-r500' };

sessID = sprintf('%08d', round(rand * 10000000));
currPath = pwd;
nameHits = regexp(currPath, '(?<date>\d{4}_\d{2}_\d{2}).+(?<sess>session\d{2}_\d{6})', 'names');
if ~isempty(nameHits);
    sessID = sprintf('%s_%s', regexprep(nameHits.date, '_', ''), regexprep(nameHits.sess, 'session', 'S'));
end;

%%
ROIsToPlot = { 'M2', 'S1BC', 'S1FL', 'A1', 'V1', 'PPC' };

caROIs = find(strcmp(ROIs.axeH, 'wf') & ismember(ROIs.ROINames, ROIsToPlot));
ROINames = ROIs.ROINames(caROIs);
[~, ROISortInds] = ismember(ROIsToPlot, ROINames);
nROIs = numel(ROINames);
ROIMasks = ROIs.ROIMasks(caROIs(ROISortInds));
ROINames = ROINames(ROISortInds);

%%
figure('Name', sprintf('Reference image %s', sessID), figProps{:});
                            
refImg = PseudoFlatfieldCorrect(refImg);
refImg = PseudoFlatfieldCorrect(refImg);
trialMask = isnan(tr(:, :, 100));
refImg(trialMask) = NaN;
refImg = refImg((cropDims(2) + 1) : (cropDims(2) + cropDims(4)), ...
    (cropDims(1) + 1) : (cropDims(1) + cropDims(3)));
imagesc(1 : size(refImg, 1), 1 : size(refImg, 2), refImg, [0.1 0.5]);
colormap('gray');
axis('square');
set(gca, 'XTick', [], 'YTick', []);

%%
hold('on');
lineColors = lines(nROIs);
h = zeros(nROIs, 1);
for iROI = 1 : nROIs;
    ROIMask = ROIMasks{iROI};
    ROIMask = ROIMask((cropDims(2) + 1) : (cropDims(2) + cropDims(4)), ...
        (cropDims(1) + 1) : (cropDims(1) + cropDims(3)));
    contour(ROIMask, '-', 'Color', 'black', 'LineWidth', 3);
%     [~, h(iROI)] = contour(ROIMask, '-', 'Color', lineColors(iROI, :), 'LineWidth', 1);
    contour(ROIMask, '-', 'Color', lineColors(iROI, :), 'LineWidth', 1);
    h(iROI) = plot(-1000, -1000, '-', 'Color', lineColors(iROI, :), 'LineWidth', 20);
end;
legend(h, ROINames, 'Location', 'EastOutside', 'FontSize', 40);
hold('off');

export_fig([sessID, '_refImgWithROIs.png'], '-r300', gcf);
export_fig([sessID, '_refImgWithROIs.fig'], gcf);
