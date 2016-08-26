function figHand = plotROCCurves(axeH, truePX, truePY, shufPX, shufPY, ROIAUCs, ROINames, stimIDs, saveName, ...
    showAllCurves, varargin)

%% init
% get the size of the data set
[nReps, nROIs, nPoints] = size(shufPX);

% create the figure
if isempty(axeH);
    figHand = figure('Name', saveName, 'NumberTitle', 'off', 'Color', 'white');
    axeH = axes('Parent', figHand);
else
    figHand = getParentFigure(axeH);
end;

% color each trace by a specific color
colors = [1 0 0; 0 0 0];
colorsLight = colors;
colorsLight(colorsLight == 0) = 0.5;
lineStyles = {'-', '-'};

% gather infos about original axe
axeHParent = get(axeH, 'Parent');
basePos = get(axeH, 'Position');
% hide the original axe
set(axeH, 'YTick', [], 'XTick', [], 'XColor', 'white', 'YColor', 'white');

% font size can change depending on the number of ROIs plotted
fontSize = 15 - nROIs * 0.5;

% get subplot sizes
M = ceil(sqrt(nROIs)); N = iff(M * (M - 1) >= nROIs, M - 1, M);
% get the dimensions of the subplots
WPad = basePos(3) * 0.12 - nROIs * 0.005; W = (basePos(3) - (M - 1) * WPad) / M;
HPad = basePos(4) * 0.20 - nROIs * 0.005; H = (basePos(4) - (N - 1) * HPad) / N;
X = basePos(1); Y = basePos(2) + (N - 1) * (H + HPad);

% create a plot for each ROI
plotHands = nan(nROIs, 1);
for iROI = 1 : nROIs;
    
    currAxeH = axes('Parent', axeHParent, 'Color', 'white', 'Position', [X Y W H], 'Visible', 'on');
    plotHands(iROI) = currAxeH;
    X = X + W + WPad;
    if X >= basePos(1) + basePos(3);
        X = basePos(1); 
        Y = Y - H - HPad;
    end;
    
    %% plot
    lineHands = cell(1, 2);
    legHandles = zeros(1, 2);
    hold(currAxeH, 'on');
        
    % calculate mean of the shuffled trace
    meanShufPX = reshape(nanmean(shufPX(:, iROI, :), 1), 1, nPoints);
    meanShufPY = reshape(nanmean(shufPY(:, iROI, :), 1), 1, nPoints);
    
    % show all the shuffled curves if required
    if showAllCurves;

        % show all shuffled curves
        for iRep = 1 : nReps;
            plot(currAxeH, reshape(shufPX(iRep, iROI, :), 1, nPoints), reshape(shufPY(iRep, iROI, :), 1, nPoints), ...
                'LineWidth', 1, 'Color', colorsLight(2, :));
        end;

%     else
%         
%         stdShufPY = reshape(nanstd(shufPY(:, iROI, :), 1), 1, nPoints);
%         plot(currAxeH, meanShufPX, meanShufPY + stdShufPY, 'LineWidth', 2, ...
%                 'LineWidth', 1, 'Color', colorsLight(2, :));
%         plot(currAxeH, meanShufPX, meanShufPY - stdShufPY, 'LineWidth', 2, ...
%                 'LineWidth', 1, 'Color', colorsLight(2, :));

    end;
        
    % show mean of shuffled
    lineHands{2} = plot(currAxeH, meanShufPX, meanShufPY, 'LineWidth', 2);
    set(lineHands{2}, 'Color', colors(2, :), 'LineWidth', 2);
    if ~isempty(lineStyles);
        set(lineHands{2}, 'LineStyle', lineStyles{2});
    end;
    legHandles(2) = lineHands{2};
    
    % plot true curve
    lineHands{1} = plot(currAxeH, truePX(iROI, :), truePY(iROI, :), 'LineWidth', 2);
    set(lineHands{1}, 'Color', colors(1, :), 'LineWidth', 2);
    if ~isempty(lineStyles);
        set(lineHands{1}, 'LineStyle', lineStyles{1});
    end;
    legHandles(1) = lineHands{1};

    % add the legends on the first ROI's plot
    if iROI == 1;
        if nROIs == 1;
            legend(currAxeH, legHandles, {'true', 'shuffled'}, 'Location', 'NorthEast', ...
                'Orientation', 'Horizontal');
        else
            legend(currAxeH, legHandles, {'true', 'shuffled'}, 'Location', 'NorthWest', ...
                'Orientation', 'Vertical');
        end;
    end;

    % axis labels and title
    set(currAxeH, 'FontSize', fontSize);
    
    % add axis labels on the first ROI's plot
    if iROI == 1;
        if isempty(varargin) || ~ischar(varargin{1});
            ylabel(currAxeH, 'True positive rate', 'FontSize', fontSize);
        else
            ylabel(currAxeH, varargin{1}, 'FontSize', fontSize);
        end;
        xlabel(currAxeH, 'False positive rate', 'FontSize', fontSize);
    end;
    
    AUC = ROIAUCs{iROI}(1);
    shuffAUC = nanmean(ROIAUCs{iROI}(2 : end));
    trueAUC = AUC - shuffAUC + 0.5;
    title(currAxeH, sprintf('ROI %s, corAUC: %.3f', ROINames{iROI}, trueAUC), 'Interpreter', 'none', 'FontSize', fontSize);
    hold(currAxeH, 'off');
    
end;

% adjust all plot limits
set(plotHands, 'XLim', [-0.02, 1.02], 'YLim', [-0.02, 1.02]);
linkaxes(plotHands, 'xy');

end

