function varargout = PsPlot2Raster(varargin)
% plot different columns (stims) in ps_plot_cell in different subplots
% in1 ... psPlot cell array (roi x stim), each cell contains trial x
% timepoints ps-matrix
% in2 ... sampling frequency
% in3 ... offset (frame of stimulus presentation)
% in4 ... optional cellstring with roi names
% in5 ... PlotType (1 ... trials-by-Rois, 2 ... Rois-by-trials), default 1
% in6 ... plot PSTH (1 or 0, only takes effect if PlotType is 1 and
% Roi count is 1); default 0
% out1 ... figure handle
% out2 ... PSTH (roi x stim cell array), always calculated trials x rois

% this file written by Henry Luetcke (hluetck@gmail.com)

inargs = varargin;
[ps_plot_cell,freq,offset,roiList,plotType,doPSTH] = ParseInputs(inargs{1:length(inargs)});

roiCount = size(ps_plot_cell,1);
maxStim = size(ps_plot_cell,2);
% roiCount = 2;
% maxStim = size(ps_plot_cell,2);
cmap = lines(roiCount);
% or we plot alternately in 1 of 2 colors
% cmap = [0 0 0; 1 0 0];
% cmap = repmat(cmap,roiCount/2,1);
% if size(cmap,1) < roiCount
%    cmap(roiCount,:) = cmap(1,:);
% end

% ytick_pos = zeros(1,roiCount);

h_fig = figure('Name','Raster plot','NumberTitle','off');
hold on
if plotType == 1
    
        psth_cell = doPlot(ps_plot_cell,roiCount,maxStim,freq,offset,cmap,...
            roiList,doPSTH);
    
    if nargout == 2
        varargout{2} = psth_cell;
    end
elseif plotType == 2
    trialNo = size(ps_plot_cell{1,1},1);
    psByTrial = cell(trialNo,maxStim);
    pos = 1;
    for stim = 1:maxStim
        for trial = 1:trialNo
            for roi = 1:roiCount
                if ~isnan(ps_plot_cell{roi,stim})
                    psByTrial{trial,stim}(roi,:) = ...
                        ps_plot_cell{roi,stim}(trial,:);
                else
                    psByTrial{trial,stim}(roi,:) = 0;
                end
            end
        end
    end
    for n = 1:trialNo
        trialList{n} = sprintf('%02g',n);
    end
    cmap = lines(trialNo);
    doPlot(psByTrial,trialNo,maxStim,freq,offset,cmap,trialList,doPSTH);
end

if nargout
    varargout{1} = h_fig;
end

%% Plot function
function varargout = doPlot(ps_plot_cell,roiCount,maxStim,freq,offset,...
    cmap,roiList,doPSTH)
psth_cell = cell(roiCount,maxStim);

% number of ps-timepoints
% while true
    doBreak = 0;
    for roi = 1:roiCount
        eventRange = unique(ps_plot_cell{roi,1});
        if ~isnan(eventRange(1))
            timepoints = size(ps_plot_cell{roi,1},2);
            doBreak = 1;
            break
        end
    end
    if ~doBreak
       error('Could not determine number of timepoints');
    end
%     if doBreak
%         break
%     end
% end
% sum rasters for all rois for stims
AllStimSum = zeros(maxStim,timepoints);
trials = zeros(1,maxStim);
for stim = 1:maxStim
    currentSum = zeros(1,timepoints);
    for roi = 1:roiCount
        currentRoiSum = nansum(ps_plot_cell{roi,stim},1);
        if isnan(currentRoiSum)
           continue 
        end
        if ~currentRoiSum
           continue 
        end
        currentSum = nansum([currentSum;currentRoiSum],1);
        if ~trials(stim)
           trials(stim) = size(ps_plot_cell{roi,stim},1);
        end
    end
    AllStimSum(stim,:) = currentSum;
end
absoluteYmax = [];
maxTrials = max(trials);
% setup subplot
if maxStim > 3
    subIdx = repmat(ceil(sqrt(maxStim)),1,2);
else
    subIdx = [1 maxStim];
end
for stim = 1:maxStim
    subplot(subIdx(1),subIdx(2),stim); hold on
    pos = 1;
    plottedRoiCount = 1; % some Rois are NaN
    min_time = inf; max_time = -inf;
    for roi = 1:roiCount
        posStart = pos;
        current_raster = ps_plot_cell{roi,stim};
        if isnan(current_raster)
            current_raster = zeros(trials(stim),timepoints);
        end
%         roiList2{plottedRoiCount} = roiList{roi};
        plottedRoiCount = plottedRoiCount + 1;
        timepoints = size(current_raster,2);
        if min_time > ((1-offset) / freq)-1/freq;
            min_time = ((1-offset) / freq)-1/freq;
        end
        if max_time < ((size(current_raster,2)-offset) / freq)+1/freq;
            max_time = ((size(current_raster,2)-offset) / freq)+1/freq;
        end
        lastTrialEmpty = 0;
        for current_run = 1:maxTrials
            if current_run > trials(stim)
                current_sweep = zeros(1,size(current_raster,2));
            else
                current_sweep = current_raster(current_run,:);
            end
            spikeTimes = find(current_sweep);
            if isempty(spikeTimes)
                lastTrialEmpty = 1;
            else
                lastTrialEmpty = 0;
            end
            spikeTimes = (spikeTimes-offset) / freq;
            h_err = errorbar(spikeTimes,repmat(pos,1,length(spikeTimes)),...
                repmat(1/(freq*2),1,length(spikeTimes)),...
                repmat(1/(freq*2),1,length(spikeTimes)),'.k'); hold on
            set(h_err,'Color',cmap(roi,:),'Marker','none');
            pos = pos + 1;
        end
        % if last trial was empty, plot white point at 0,pos-1
        %                 if lastTrialEmpty
        %                     herrorbar(0,pos-1,0,0,'.w'); hold on
        %                 end
        posStop = pos;
        ytick_pos(plottedRoiCount) = round(mean([posStart posStop]));
        ylims = get(gca,'ylim');
        psth = nansum(current_raster,1);
        % 0.5 s moving average filter
%         windowSize = ceil(0.5 * 0.5 * freq);
%         psth = filtfilt(ones(1,windowSize)/windowSize,1,psth);
        if doPSTH
            psth_scaled = linScale(psth,posStart,posStop);
            psth_time = (min_time+1/freq):1/freq:(max_time-1/freq);
            plot(psth_time,psth_scaled,':k','LineWidth',1.5)
        end
        psth = psth ./ size(current_raster,1);
        psth_cell{roi,stim} = reshape(psth,1,numel(psth));
    end
    % plot the summed PSTH for all Rois for this stimulus
    % normalize between 0 and pos/10, then offset by pos
    if stim == 1
        AllStimSum = linScale(AllStimSum,0,pos/10);
    end
    currentSum = AllStimSum(stim,:);
    currentSum = currentSum + pos;
%     currentSum = filtfilt(ones(1,windowSize)/windowSize,1,currentSum);
    currentSum_time = (min_time+1/freq):1/freq:(max_time-1/freq);
    plot(currentSum_time,currentSum,':k','LineWidth',1.5)
    ytick_pos(length(ytick_pos)+1) = mean(currentSum);
    ytick_pos(1) = [];
    if isempty(absoluteYmax)
        absoluteYmax = max(currentSum);
    else
        currentYmax = max(currentSum);
        if currentYmax > absoluteYmax
            absoluteYmax = currentYmax;
        end
    end
    
    set(gca,'xlim',[min_time max_time])
    if stim == 1
        roiList = reshape(roiList,1,numel(roiList));
        set(gca,'ytick',ytick_pos,'yticklabel',[roiList 'sum'])
    else
        set(gca,'ytick',[])
    end
    set(gca,'TickLength',[0 0])
    title(['Stim ' int2str(stim)])
    axisHandle(stim) = gca;
end

for n = 1:length(axisHandle)
    set(axisHandle(n),'ylim',[0 absoluteYmax]);
end

if nargout
    varargout{1} = psth_cell;
end

% fprintf('\nPlotted %s total runs from %s Rois\n',...
%     int2str(pos-1),int2str(size(ps_plot_cell,1)));

%% Parse inputs
function [ps_plot_cell,freq,offset,roiList,plotType,doPSTH] = ...
    ParseInputs(varargin)
error(nargchk(3,6,nargin))
ps_plot_cell = varargin{1};
if ~iscell(ps_plot_cell)
    ps_plot_cell = {ps_plot_cell};
end
freq = varargin{2};
offset = varargin{3};

roiCount = size(ps_plot_cell,1);

if nargin >= 4 && ~isempty(varargin{4})
    roiList = varargin{4};
else
    for n = 1:roiCount
        roiList{n} = sprintf('%02g',n);
    end
end
if nargin >= 5 && ~isempty(varargin{5})
    plotType = varargin{5};
else
    plotType = 1;
end
doPSTH = 0;
if nargin >= 6 && plotType == 1 && ~isempty(varargin{6})
    doPSTH = varargin{6};
end

