function INUpdateGUI(this, ~, ~)
% INUpdateGUI - [no description]
%
%       INUpdateGUI(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

updateGUITic = tic;
o('#%s ...', mfilename, 3, this.verb);

%% fourier mode
if strcmp(this.in.expMode, 'fourier');
    
    if isfield(this.GUI.in.fouSubAxeHands, 'pixTC');
        set(this.GUI.in.fouSubAxeHands.pixTC, 'YLim', this.in.fourier.pixTCYLim);
    end;
    if isfield(this.GUI.in.fouSubAxeHands, 'spectr');
        set(this.GUI.in.fouSubAxeHands.spectr, 'YLim', this.in.fourier.spectrYLim);
        pos = get(this.GUI.in.fouSubAxeHands.spectrArrow, 'Position');
        set(this.GUI.in.fouSubAxeHands.spectrArrow, 'Position', [pos(1) this.in.fourier.spectrYLim(end) * 0.95 0]);
        pos = get(this.GUI.in.fouSubAxeHands.spectrArrowTxt, 'Position');
        set(this.GUI.in.fouSubAxeHands.spectrArrowTxt, 'Position', [pos(1) this.in.fourier.spectrYLim(end) 0]);
    end;
    if isfield(this.GUI.in.fouSubAxeHands, 'powerMap');
        if all(this.in.fourier.powerMapCLim == 0);
            cData = get(this.GUI.in.fouSubAxeHands.powerMapImg, 'CData');
            this.in.fourier.powerMapCLim = [min(cData(:)), max(cData(:))];
            if all(this.in.fourier.powerMapCLim == 0) || diff(this.in.fourier.powerMapCLim) == 0;
                this.in.fourier.powerMapCLim = [0 1000];
            end;
            set(this.GUI.handles.in.paramPanElems.powerMapCLim, 'String', ...
                ['[' regexprep(num2str(this.in.fourier.powerMapCLim), ' +', ' ') ']']);
        end;
%         cLim = log10(this.in.fourier.powerMapCLim + eps);
        cLim = this.in.fourier.powerMapCLim;
        set(this.GUI.in.fouSubAxeHands.powerMap, 'CLim', cLim);
%         YTick = cLim(1) : diff(cLim([1, end])) / 10 : cLim(end);
%         YTickLabel = round(10 .^ YTick);
%         YTickLabel = YTick;
%         set(this.GUI.in.fouSubAxeHands.powerMapColBar, 'YTick', YTick, 'YTickLabel', YTickLabel);
    end;
    if isfield(this.GUI.in.fouSubAxeHands, 'phaseMap');
        if all(this.in.fourier.phaseMapCLim == 0);
            cData = get(this.GUI.in.fouSubAxeHands.phaseMapImg, 'CData');
            this.in.fourier.phaseMapCLim = [min(cData(:)), max(cData(:))] + eps;
            if all(this.in.fourier.phaseMapCLim == 0) || diff(this.in.fourier.phaseMapCLim) == 0;
                this.in.fourier.phaseMapCLim = [-pi pi];
            end;
            set(this.GUI.handles.in.paramPanElems.phaseMapCLim, 'String', ...
                ['[' regexprep(num2str(this.in.fourier.phaseMapCLim), ' +', ' ') ']']);
        end;
        set(this.GUI.in.fouSubAxeHands.phaseMap, 'CLim', this.in.fourier.phaseMapCLim);
    end;


%% standard mode
elseif strcmp(this.in.expMode, 'standard');

    % check if there is anything to display
    if isempty(this.in.data.baseDFFAvg); return; end;

    % get dimensions
    H = this.GUI.in.imDim(1);
    W = this.GUI.in.imDim(2);

    % get the number of images already collected
    arrayBaseline = cell2mat(this.in.data.baseDFFAvg');
    nBaselineAvgs = size(arrayBaseline, 2) / W;
    arrayStimulus = cell2mat(this.in.data.stimDFFAvg');
    nStimulusAvg = size(arrayStimulus, 2) / W;

    % if average image is requested
    if get(this.GUI.handles.in.standard.showAvg, 'Value');

        % disable the run chooser
        set(this.GUI.handles.in.standard.runChooser, 'Enable', 'off');
        set(this.GUI.handles.in.standard.inclRun, 'Enable', 'off');

        % calculate average for baseline frames
        baseDFFAvgAllRuns = reshape(arrayBaseline, H, W, nBaselineAvgs);
        baseDFFAvgAllRuns(:, :, ~this.in.data.includeInAvg) = [];
        baseDFFAvgAll = nanmean(baseDFFAvgAllRuns, 3);
        baseDFFAvgAll = imfilter(baseDFFAvgAll, this.GUI.in.filt);
        % set the image
        set(this.GUI.handles.in.expLeftImg, 'CData', 100 * baseDFFAvgAll);
%         set(this.GUI.handles.in.expAxeLeft, 'XLim', [0 W], 'YLim', [0 H]);

        % calculate average for stimulus frames
        stimDFFAvgAllRuns = reshape(arrayStimulus, H, W, nStimulusAvg);
        stimDFFAvgAllRuns(:, :, ~this.in.data.includeInAvg) = [];
        stimDFFAvgAll = nanmean(stimDFFAvgAllRuns, 3);
        stimDFFAvgAll = imfilter(stimDFFAvgAll, this.GUI.in.filt);
        % set the image
        set(this.GUI.handles.in.expRightImg, 'CData', 100 * stimDFFAvgAll);
%         set(this.GUI.handles.in.expAxeRight, 'XLim', [0 W], 'YLim', [0 H]);

    % no averaging
    else

        nRuns = max(max(nBaselineAvgs, nStimulusAvg), 2);
        set(this.GUI.handles.in.standard.runChooser, 'Enable', 'on', 'Min', 1, 'Max', nRuns, ...
            'SliderStep', [1 / (nRuns - 1) 1 / (nRuns - 1)]);
        runChooserValue = get(this.GUI.handles.in.standard.runChooser, 'Value');
        iRun = round(runChooserValue);
        iRun = min(max(iRun, 1), nRuns); % make sure iRun does not exceed limits
        o('#%s: iRun: %.1f, value: %.1f', mfilename, iRun, runChooserValue, 4, this.verb);
        set(this.GUI.handles.in.standard.runChooser, 'Value', iRun);
        showMessage(this, sprintf('Intrinsic: showing run %02d/%02d', iRun, nRuns));

        % set the include check box state
        set(this.GUI.handles.in.standard.inclRun, 'Enable', 'on', 'Value', this.in.data.includeInAvg(iRun));

        % set the image
        baseDFFAvgForRun = 100 * imfilter(this.in.data.baseDFFAvg{iRun}, this.GUI.in.filt);
        set(this.GUI.handles.in.expLeftImg, 'CData', baseDFFAvgForRun);
%         set(this.GUI.handles.in.expAxeLeft, 'XLim', [0 W], 'YLim', [0 H]);
        % set the image
        stimDFFAvgForRun = 100 * imfilter(this.in.data.stimDFFAvg{iRun}, this.GUI.in.filt);
        set(this.GUI.handles.in.expRightImg, 'CData', stimDFFAvgForRun);
%         set(this.GUI.handles.in.expAxeRight, 'XLim', [0 W], 'YLim', [0 H]);

    end;

    % update color limits
    cLim = this.in.standard.cLim;
    if numel(cLim) == 1; cLim = [-abs(cLim) abs(cLim)]; end;
    if cLim(1) >= cLim(2);
        cLim(1) = cLim(2) - 0.01;
        set(this.GUI.handles.in.paramPanElems.cLim, 'String', sprintf('[%.2f, %.2f]', cLim));
    end;
    set(this.GUI.handles.in.expAxeLeft, 'CLim', cLim);
    set(this.GUI.handles.in.expAxeRight, 'CLim', cLim);
    
end;

% set back the reference image
if ~isempty(this.in.data.refImg);
    set(this.GUI.handles.in.refImg, 'CData', this.in.data.refImg);
%     set(this.GUI.handles.in.refAxe, 'XLim', [1 size(this.in.data.refImg, 2)], ...
%         'YLim', [1, size(this.in.data.refImg, 1)]);
end;

o('#%s: updating GUI done: %.1f sec', mfilename, toc(updateGUITic), 3, this.verb);

end
