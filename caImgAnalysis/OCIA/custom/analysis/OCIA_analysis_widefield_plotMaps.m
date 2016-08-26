function axeHandles = OCIA_analysis_widefield_plotMaps(this, M, N, axeConfig, imgW, imgH, recordDur, varargin)
% OCIA_analysis_widefield_plotMaps - [no description]
%
%       axeHandles = OCIA_analysis_widefield_plotMaps(this, M, N, axeConfig, imgW, imgH, recordDur)
%       axeHandles = OCIA_analysis_widefield_plotMaps(this, M, N, axeConfig, imgW, imgH, recordDur, pads)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if ~isempty(varargin);
    pads = varargin{1};
else
    pads = [0.05, 0.1];
end;

% get plotting axe
anAxeH = this.GUI.handles.an.axe;

% gather infos about original axe
axeHParent = get(anAxeH, 'Parent');
basePos = get(anAxeH, 'Position');
basePos(1) = 0.03;
basePos(3) = 0.95;
% hide the original axe
set(anAxeH, 'YTick', [], 'XTick', [], 'XColor', 'white', 'YColor', 'white', 'Visible', 'off');

% get the dimensions of the subplots
WPad = basePos(3) * pads(1); W = (basePos(3) - (M - 1) * WPad) / M;
HPad = basePos(4) * pads(2); H = (basePos(4) - (N - 1) * HPad) / N;
[X, baseX] = deal(basePos(1)); %#ok<ASGLU>
[Y, baseY] = deal(basePos(2) + (N - 1) * (H + HPad));

% stimulus frequency string and clipping limits
stimFreqStr = sprintf('\\rm\\bf\\fontsize{9} @ %.3f Hz%s, %d sec.', this.an.wf.stimFreq, ...
    iff(this.an.wf.stimFreqInterval == 0, '', sprintf(' (\\pm %.3f Hz)', this.an.wf.stimFreqInterval)), ...
    round(recordDur));

% plot each axe
axeHandles = zeros(size(axeConfig, 1), 1);
iY = 1;
for iAxe = 1 : size(axeConfig, 1);
    
    % only proceed to plot if there is something to plot
    if any(~cellfun(@isempty, axeConfig(iAxe, :)));
    
        % get parameters
        [img, titleStr, cMap, cBarLabel, showTicks, showDir, addStimFreqStr, threshCBar, cLim, cLimInd, ...
            cBarYTicks, cBarYTickLabels] = axeConfig{iAxe, :};
        if iscell(img); img = img{1}; end;

        % create axe
        axeH = axes('Parent', axeHParent, 'Color', 'white', 'Position', [X Y W H], 'Visible', 'on');
        axeHandles(iAxe) = axeH;
        if isempty(img); img = zeros(256, 256); end;
        if imgW == 0 && imgH == 0;
            [imgW, imgH] = size(img);
        end;
        % plot image
        imagesc([1 imgW], [1 imgH], img, 'Parent', axeH);
        % set limits
        if ~isempty(cLim); set(axeH, 'CLim', cLim(iff(numel(cLim) >= cLimInd(2), cLimInd, 1:2))); end;
        % show antero-posterior/medial-lateral arrow
        if showDir;
            text(imgW * 0.95, imgH * 0.9, '\bf\leftarrow A', 'Color', 'white', 'FontSize', 10, ...
                'HorizontalAlignment', 'right', 'Parent', axeH);
            text(imgW * 0.95, imgH * 0.95, '\bf\downarrow L', 'Color', 'white', 'FontSize', 10, ...
                'HorizontalAlignment', 'right', 'Parent', axeH);
        end;
        % annotate axes
        axis(axeH, 'equal');
        set(axeH, 'XLim', [1 imgW], 'YLim', [1 imgH], 'XAxisLocation', 'top');
        if ~showTicks; set(axeH, 'XTick', [], 'YTick', []); end;
        title(axeH, [titleStr iff(addStimFreqStr, stimFreqStr, '')], 'FontSize', 13);
        % create colorbar
        hCBar = colorbar('EastOutside', 'peer', axeH);
        if ~isempty(cBarLabel);
            set(hCBar, 'FontSize', 10);
            xlabel(hCBar, cBarLabel, 'FontSize', 13);
            if ~isempty(cBarYTicks); set(hCBar, 'YTick', cBarYTicks); end;
            if ~isempty(cBarYTickLabels); set(hCBar, 'YTickLabel', cBarYTickLabels); end;
        else
            set(hCBar, 'Visible', 'off');
        end;
        % set colormap with NaNs in black
        if ~isempty(cMap);
            colormap(axeH, cMap); figH = gcf;
            if figH ~= this.GUI.figH && ~strcmp(get(figH, 'Name'), 'ChunkFrames');
                close(figH);
            end;
            cMap = colormap(axeH);
            cMap(1, :) = [0 0 0];
            colormap(axeH, cMap);
        end;
        if ~isempty(threshCBar);
            cBarYTicks = get(hCBar, 'YTick');
            cBarYTickLabels = get(hCBar, 'YTickLabel');
            if ismember(threshCBar(1), cBarYTicks);
                cBarYTickLabels{cBarYTicks == threshCBar(1)} = '\fontsize{15}\bf\leftarrow';
            else
                [cBarYTicks, iSort] = sort([cBarYTicks, threshCBar(1)]);
                cBarYTickLabels = [cBarYTickLabels; '\fontsize{15}\bf\leftarrow']; %#ok<AGROW>
                cBarYTickLabels = cBarYTickLabels(iSort);            
            end;
            set(hCBar, 'YTick', cBarYTicks);
            set(hCBar, 'YTickLabel', cBarYTickLabels);
        end;
        
    end;
    
    % update position
    Y = Y - H - HPad;
    iY = iY + 1;
    if iY > N;
        X = X + W + WPad;
        Y = baseY;
        iY = 1;
    end;
end;

%% link all axes
linkaxes(axeHandles(axeHandles > 0), 'xy');

end
