function varargout = GetRoiStatsLineScan(config)
% get ROI timecourses from images, with support for muliple ROIs and runs
% returns structure data, info and stimulus fields
% data field contains a cell array with ROI timecourses for different cells
% in rows and different runs in columns:
% [cell1_run1] [cell1_run2] ... [cell1_runN]
% [cell2_run1] [cell2_run2] ... [cell2_runN]
%     ...           ...              ...
% [cellN_run1] [cellN_run2] ... [cellN_runN]

% this file written by Henry Luetcke (hluetck@gmail.com)

config = ParseConfig(config);
matfiles = config.matfiles;

for n = 1:numel(matfiles)
   if isempty(strfind(matfiles{n},'.mat'))
       matfiles{n} = [matfiles{n} '.mat'];
   end
end

S = load(matfiles{1});
data = S.(genvarname(strrep(matfiles{1},'.mat','')));

config.imgDim = data.hdr.size(1:2);
roiSet = data.roi;
cellNo = size(roiSet,1);
config.runsNo = numel(matfiles);
config.timepoints = data.hdr.size(1);

% config.dataRoi = cell(cellNo,config.runsNo);
% config.dataRoiNorm = cell(cellNo,config.runsNo);
% config.dataNpil = cell(cellNo,config.runsNo);

% cMatFigRoi = figure('Name',sprintf('%s %s',config.statsType,'Roi'),...
%     'NumberTitle','off','color','white');
% cMatFigRoiNorm = figure('Name',sprintf('%s %s',config.statsType,'RoiNorm'),...
%     'NumberTitle','off','color','white');
% cMatFigRoiNpil = figure('Name',sprintf('%s %s',config.statsType,'RoiNpil'),...
%     'NumberTitle','off','color','white');

RoiMatAllRuns = [];
RoiMatNormAllRuns = [];
RoiMatNpilAllRuns = [];
StimVectorAllRuns = [];

%% Process runs
for currentRun = 1:config.runsNo
    fprintf('\nNow processing run %1.0f\n',currentRun);
    % for 'drr', work on both channels, for 'dff' work on ch1
    S = load(matfiles{currentRun});
    data = S.(genvarname(strrep(matfiles{currentRun},'.mat','')));
    currentImgData = cell(1,length(config.channelVector));
    currentMeanImgData = cell(1,length(config.channelVector));
    for n = 1:length(config.channelVector)
        currentImgData{n} = double(data.img_data{config.channelVector(n)});
%         currentMeanImgData{n} = mean(currentImgData{n},3);
    end
    config.stim{currentRun} = data.stim;
    config.frameRate{currentRun} = data.hdr.rate;
    roiSet = data.roi;
    roiLabel = roiSet(:,1);
    
    if isfield(data.hdr,'bits')
        bitDepth = data.hdr.bits;
    else
        bitDepth = 16;
    end
    
    if islogical(roiSet{1,2})
       roiSet = ij_RoiSetCompression(roiSet,1);
    end
    
    for currentRoi = 1:size(roiSet,1)
        roi = roiSet{currentRoi,2};
        roiId = roiSet{currentRoi,1};
        % we only need the columns for each roi
        roiSet{currentRoi,2} = unique(roi(:,2));
    end
    config.roi = roiSet(:,1:2);
    
    stim = config.stim{currentRun};
    
    if isempty(stim)
        stimVectorFrameRate = zeros(1,config.timepoints);
    else
        if isstruct(stim)
            if stim.rate ~= config.frameRate{currentRun}
                % compute stimVectorFrameRate
                stimVectorFrameRate = ResampleStimVector(stim.vector,stim.rate,...
                    config.timepoints,config.frameRate{currentRun});
            else
                stimVectorFrameRate = stim.vector;
            end
        elseif isvector(stim) % assume stim vector already converted to frames
            stimVectorFrameRate = stim;
        end
    end
    
    if numel(stimVectorFrameRate) > config.timepoints
        stimVectorFrameRate(config.timepoints+1:end) = [];
    elseif numel(stimVectorFrameRate) < config.timepoints
        stimVectorFrameRate(end:config.timepoints) = 0;
    end
    
    StimVectorAllRuns = [StimVectorAllRuns stimVectorFrameRate];
    
    if config.forceIJf0
        stimVectorFrameRate = zeros(1,config.timepoints);
    end
    
    %% LowPass filter
    points = round(config.lowPass*config.frameRate{currentRun});
    
    %% Calculate stats
    for currentRoi = 1:size(config.roi,1)
        currentColumns = config.roi{currentRoi,2};
        roiData = cell(1,numel(config.channelVector));
        for n = 1:numel(config.channelVector)
            roiData{n} = currentImgData{n}(:,currentColumns);
            roiData{n} = nanmean(roiData{n},2);
            roiData{n} = filter(ones(1,points)/points,1,roiData{n});
            roiData{n}(1:points,:) = [];
        end
        switch lower(config.statsType)
            case 'dff'
                roiStats = roiData{1};
                
            case 'drr'
                roiStats = roiData{1} ./ roiData{2};
        end
        roiStats = roiStats';
        % calculate F0
        %         roiF0 = CalculateF0(roiStats,stimVectorFrameRate,config.baseFrames);
        roiF0 = findF0(roiStats,config.frameRate{currentRun},1,10);
        % calculate stats
        roiStats = ((roiStats-roiF0) ./ roiF0) .* 100;
        roiStats(isinf(roiStats)) = 0;
        roiStats(isnan(roiStats)) = 0;
        
        % save mean stats timecourse
        config.dataRoi{currentRoi,currentRun} = roiStats;
        currentRoiMat(currentRoi,:) = roiStats;
        
    end
    RoiMatAllRuns = [RoiMatAllRuns currentRoiMat];
    
end

% plot all Rois with stim in stacked plot
titleStr = sprintf('%s',config.saveName);
fig = figure('Name',titleStr,'NumberTitle','off'); hold all
currentOffset = 0;
time = (1:size(RoiMatAllRuns,2))/config.frameRate{1};
for roi = 1:size(RoiMatAllRuns,1)
    id = sprintf('%1.0f',roi);
    data = RoiMatAllRuns(roi,:);
    data = data + (min(data)*-1);
    dataPlot = data + currentOffset;
    plot(time,dataPlot)
    currentOffset = max(dataPlot);
    text(max(time),mean(dataPlot),id)
end
for n = 1:numel(StimVectorAllRuns)
    if StimVectorAllRuns(n) == 1
        plot([time(n) time(n)],[0 currentOffset],'LineStyle','--',...
            'Color',[0.8 0.8 0.8])
    elseif StimVectorAllRuns(n) == 2
        plot([time(n) time(n)],[0 currentOffset],'LineStyle','--',...
            'Color',[0.3 0.3 0.3])
    end
end
set(gca,'ylim',[0 currentOffset],'xlim',[min(time) max(time)+0.1*max(time)])
xlabel('Time / s')
title(titleStr,'Interpreter','none')
ylabel(sprintf('%% %s',upper(config.statsType)))

saveas(fig,config.saveName)

SaveAndAssignInBase(config,config.saveName)

if nargout
    varargout{1} = config;
end

%% Function - pcolorPlot
function pcolorPlot(fig,runs,currentRun,roiMat,stimVector,roiLabel)
figure(fig)
subplot(runs,1,currentRun)
roiMat = [ScaleToMinMax(stimVector,0,25);roiMat];
colorMat = padarray(roiMat,[1 1]);
pFig = pcolor([-0.5:(size(colorMat,2)-1.5)],...
    [-0.5:(size(colorMat,1)-1.5)],colorMat);
set(pFig,'EdgeAlpha',0);
xAxis = get(gca,'XLim'); yAxis = get(gca,'YLim');
caxis([-5 25]);
set(gca,'XLim',[0.5 xAxis(2)],'YLim',[0.5 yAxis(2)]);
roiLabel = ['stim'; roiLabel; 'npil'];
set(gca,'YTick',[1:length(roiLabel)],'XTick',[]);
set(gca,'YTickLabel',roiLabel,'FontSize',8);
colorbar

%% Function - ParseConfig
function config = ParseConfig(config)
% check for missing fields in config structure and add them with
% default values

if ~isfield(config,'matfiles')
    matfiles = uigetfile('*.mat','Select Mat Files','MultiSelect','on');
    if ~iscell(matfiles)
        matfiles = {matfiles};
    end
    config.matfiles = strrep(matfiles,'.mat','');
end

if ~isfield(config,'saveName')
   config.saveName = [config.matfiles{1} '__RoiStats'];
end

% force f0 calculation as in ImageJ
if ~isfield(config,'forceIJf0')
    config.forceIJf0 = 0;
end
if isempty(config.forceIJf0)
    config.forceIJf0 = 0;
end

% number of initial frames for normalization (forceImageJf0) OR the number
% of frames before a stimulus used for renormalization
if ~isfield(config,'baseFrames')
    config.baseFrames = 10;
end
if isempty(config.baseFrames)
    config.baseFrames = 10;
end

if ~isfield(config,'statsType')
    config.statsType = 'dff';
end

% channels for stats calculation
% DFF is calculated on the channel specified by config.channelVector(1)
% DRR is calculated on the channels specified by config.channelVector(1)
% and config.channelVector(2)
if ~isfield(config,'channelVector')
    config.channelVector = [1 2];
end

if strcmpi(config.statsType,'drr') && numel(config.channelVector) < 2
    error('config.channelVector must specify at least 2 channels for DRR stats!');
end

if ~isfield(config,'psConfig')
    config.psConfig = struct;
    config.psConfig.baseFrames = 5;
    config.psConfig.evokedFrames = 15;
end

if ~isfield(config,'lowPass')
    config.lowPass = 1/30; % in s
end

%% Function - CalculateF0
function f0_mat = CalculateF0(roi_mat,stim,base)
if ~max(stim)
    f0_mat = roi_mat(:,1:base);
    f0_mat = nanmean(f0_mat,2);
    f0_mat = repmat(f0_mat,1,size(roi_mat,2));
    return
end
% binarise stim vector (each stimulus type leads to
% renormalization)
stim(stim>0)=1;
% define frames of stimulus onset
stim_onset = zeros(size(stim));
for n = 2:length(stim)
    if stim(n) == 1 && stim(n-1) == 0
        stim_onset(n) = 1;
    end
end
% designate the base frames BEFORE stimulus onset as baseline
stim_base = zeros(size(stim));
for n = base+1:length(stim)
    if stim_onset(n) == 1
        stim_base(n-base:n-1) = 1;
    end
end
f0_mat = zeros(size(roi_mat));
for n = 1:length(stim)
    if stim_base(n) == 1
        stim_base(n:n+base-1) = 0;
        % find endpoint of current F0 interval (the frame before
        % next normalization interval start)
        f0_stop = find(stim_base==1,1,'first')-1;
        if isempty(f0_stop)
            f0_stop = length(stim);
        end
        for pixel = 1:size(f0_mat,1)
            current_mean = mean(roi_mat(pixel,n:n+base-1));
            f0_mat(pixel,n:f0_stop) = current_mean;
        end
    end
end
% timepoints before first stimulus get F0 value for first
% pre-stimulus baseline
pre_stim1 = find(f0_mat(1,:)~=0,1,'first');
for pixel = 1:size(f0_mat,1)
    f0_mat(pixel,1:pre_stim1-1) = f0_mat(pixel,pre_stim1);
end



%% Function - ResampleStimVector
function stimVectorFrameRate = ResampleStimVector(stim,stimRate,timepoints,frameRate)
stimVectorFrameRate = zeros(1,timepoints);
for n = 1:timepoints
    startT = (n-1)/frameRate; stopT = n/frameRate;
    startStim = round(startT*stimRate);
    if startStim == 0
        startStim = 1;
    end
    stopStim = round(stopT*stimRate);
    if startStim > length(stim) || stopStim > length(stim)
        stimVectorFrameRate(n) = 0;
    else
        stimVectorFrameRate(n) = round(mean(stim(startStim:stopStim)));
    end
end







% e.o.f.