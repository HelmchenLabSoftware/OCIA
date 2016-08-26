function varargout = GetRoiStatsFrameJ90(config)
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
delFrame = data.proc.DelFrame;
% experiment specific info
animalID = data.hdr.animalID;
spotID = data.hdr.spotID;

config.saveName = sprintf('%s_%s',animalID,spotID);

config.img_dims = data.hdr.size(1:2);
roiSet = data.roi;
cellNo = size(roiSet,1);
config.runsNo = numel(matfiles);
config.timepoints = data.hdr.size(3);

%% low-pass filter parameters
switch config.LowPass.method
    case 'sg'
        lpFiltCutoff = config.LowPass.params(1);
        lpFiltCutoff = round(lpFiltCutoff.*data.hdr.rate);
        if ~rem(lpFiltCutoff,2)
            lpFiltCutoff = lpFiltCutoff+1;
        end
        config.LowPass.lpFiltCutoff = lpFiltCutoff;
        config.LowPass.sgolayOrder = config.LowPass.params(2); % filter order
        clear lpFiltCutoff
end

config.dataRoi = cell(cellNo,config.runsNo);
config.dataRoiNorm = cell(cellNo,config.runsNo);
config.dataNpil = cell(cellNo,config.runsNo);

%% Event detection parameters
if ~strcmp(config.EventDetect.method,'none')
    config.EventDetect.amp = 2.5;
    config.EventDetect.tau = 0.6;
    config.EventDetect.onsettau = 0.01;
    config.EventDetect.doPlot = 0; % should be switched off
    switch lower(config.EventDetect.method)
        case 'fast_oopsi'
            config.EventDetect.lam = 0.1; % firing rate
            config.EventDetect.base_frames = 10;
            config.EventDetect.oopsi_thr = 0.3;
            config.EventDetect.integral_thr = 5;
            config.EventDetect.filter = [7 2];
            config.EventDetect.minGof = 0.5;
        case 'peeling'
            config.EventDetect.schmittHi = 1.75;
            config.EventDetect.schmittLo = -0.75;
            config.EventDetect.schmittmindur = 0.3;
    end
end

% initialize some parameters
S = load(matfiles{1});
data = S.(genvarname(strrep(matfiles{1},'.mat','')));
config.frameRate = data.hdr.rate;
if isfield(data.hdr,'bits')
    bitDepth = data.hdr.bits;
else
    bitDepth = 16;
end

RoiMatAllRuns = [];
% eventMatAllRuns = [];

%% Process runs
for currentRun = 1:config.runsNo
    fprintf('\nNow processing run %1.0f\n',currentRun);
    
    S = load(matfiles{currentRun});
    data = S.(genvarname(strrep(matfiles{currentRun},'.mat','')));
    currentImgData = cell(1,length(config.channelVector));
%     currentMeanImgData = cell(1,length(config.channelVector));
    for n = 1:length(config.channelVector)
        currentImgData{n} = double(data.img_data{config.channelVector(n)});
%         currentMeanImgData{n} = mean(currentImgData{n},3);
    end
    
    if config.ch3Sound
        [config.stim{currentRun},soundT] = ...
            img2vector(double(data.img_data{3}),1/config.pixelTime,0);
    else
        config.stim{currentRun} = [];
    end
    config.stim{currentRun} = removeBlankPixels(config.stim{currentRun});
%     [stimTable,h,toneClean] = AnalyzePureToneVector(config.stim{currentRun},...
%         1/config.pixelTime,0);
%     config.stim{currentRun} = soundTable2StimVector(stimTable,1/config.pixelTime,0);
    
    roiSet = data.roi;
    % convert to mask Roi format
    roiSet = ij_RoiSetCompression(roiSet,2);
    
    refImg = data.refImg;
    
    roiRgb = zeros(size(refImg,1),size(refImg,2),3);
    cmap = jet(size(roiSet,1));
    alpha_mat = ones(size(refImg));
    roiCounterImg = zeros(size(alpha_mat));
    roiSetActiveModel = roiSet;
    saveActiveModel = 0;
    roiLabel = roiSet(:,1);
    
    for currentRoi = 1:size(roiSet,1)
        switch class(roiSet{currentRoi,2})
            case 'uint32'
                roi = bwunpack(roiSet{currentRoi,2});
            otherwise
                roi = roiSet{currentRoi,2};
        end
        roiId = roiSet{currentRoi,1};
        if length(find(roi)) == 1
            % run Active Model segmentation on point Rois
            [cog_row, cog_col] = ind2sub(size(alpha_mat),find(roi));
            roi = ...
                doActiveModelSegment(refImg,[cog_row cog_col],config.segOptions);
            roiSetActiveModel{currentRoi,2} = roi;
            saveActiveModel = 1;
            [y,x] = find(roi==1);
            roiSetActiveModel{currentRoi,3} = [mean(y),mean(x)];
        else
            [y,x] = find(roi==1);
            roiSet{currentRoi,3} = [mean(y),mean(x)];
            roiSetActiveModel{currentRoi,3} = [mean(y),mean(x)];
        end
        
        alpha_mat(roi==1) = 0.75;
        if ~isempty(str2num(roiId))
            roiCounterImg(roi==1) = str2num(roiId);
        end
        [row, col] = ind2sub(size(alpha_mat),find(roi));
        for idx = 1:length(row)
            for color = 1:3
                roiRgb(row(idx),col(idx),color) = ...
                    cmap(currentRoi,color);
            end
        end
    end
    config.roi.roiSet = roiSet;
    if saveActiveModel
        config.roi.ActiveModel = roiSetActiveModel;
    end
    
    %% Apply registration
    tform = data.tform;
    for n = 1:length(config.channelVector)
        hiResFunc = zeros(size(refImg,1),size(refImg,2),size(currentImgData{n},3));
        for frame = 1:size(currentImgData{n},3)
           currentFrame = removeBlankPixels(currentImgData{n}(:,:,frame));
           if size(currentFrame) ~= size(refImg)
               currentFrame = imresize(currentFrame,[size(refImg,1) size(refImg,2)]);
               % imresize performs bicubic interpolation by default
           end
           if ~isempty(tform)
               currentFrame = imtransform(currentFrame,tform,'xdata',...
                   [1 size(currentFrame,2)],'ydata',[1 size(currentFrame,1)]);
           end
           hiResFunc(:,:,frame) = currentFrame;
        end
        currentImgData{n} = hiResFunc;
        clear hiResFunc
    end
    
    %% Plot Rois
    % display created Rois on mean frame in RGB multi-color
    h2 = figure('Name',sprintf('ROIs %s',matfiles{currentRun}),'NumberTitle','off');
    imshow(roiRgb); hold on
    hRef = imshow(mean(currentImgData{1},3),[],'InitialMagnification','fit');
    set(hRef,'AlphaData',alpha_mat);
    s = regionprops(roiCounterImg,roiCounterImg,'MaxIntensity','Extrema');
    hold(gca, 'on');
    for k = 1:numel(s)
        e = s(k).Extrema;
        val = s(k).MaxIntensity;
        text(e(1,1), e(1,2)-1, sprintf('%d', val), ...
            'Parent', gca, ...
            'Clipping', 'on', ...
            'Color', 'r', ...
            'FontWeight', 'bold', ...
            'Tag', 'CellLabel');
    end
    drawnow
    saveNameBase = strrep(matfiles{currentRun},'.mat','');
    saveas(h2,[saveNameBase '__RoiRgb.fig']);
    hold(gca, 'off');
    
    
    %% Neuropil interpolation
    npilFile = [saveNameBase '__NpilMovies.mat'];
    currentNpilData = cell(1,length(config.channelVector));
    currentNpilDataSave = cell(1,length(config.channelVector));
    if config.recycleNpilMovie
        try
            a = load(npilFile);
            currentNpilData = a.(genvarname(strrep(npilFile,'.mat','')));
        catch
            for n = 1:length(config.channelVector)
                currentNpilData{n} = NeuropilInterpolation(...
                    currentImgData{n},roiSetActiveModel,4,1);
                if bitDepth == 8
                    currentNpilDataSave{n} = uint8(currentNpilData{n});
                else
                    currentNpilDataSave{n} = uint16(currentNpilData{n});
                end
            end
            SaveAndAssignInBase(currentNpilDataSave,npilFile,'SaveOnly')
            clear currentNpilDataSave
        end
    else
        for n = 1:length(config.channelVector)
            currentNpilData{n} = NeuropilInterpolation(...
                currentImgData{n},roiSetActiveModel,4,1);
            if bitDepth == 8
                currentNpilDataSave{n} = uint8(currentNpilData{n});
            else
                currentNpilDataSave{n} = uint16(currentNpilData{n});
            end
        end
        SaveAndAssignInBase(currentNpilDataSave,npilFile,'SaveOnly')
        clear currentNpilDataSave
    end
    
    
    %% Neuropil analysis
    switch lower(config.statsType)
        case 'dff'
            npilStats = mean(GetRoiTimeseries(currentNpilData{1},[]),1);
        case 'drr'
            npilStats = mean(GetRoiTimeseries(currentNpilData{1},[]),1) ./...
                mean(GetRoiTimeseries(currentNpilData{2},[]),1);
    end
    % calculate F0 (use quadratic fit method)
    npilF0 = CalculateF0(npilStats,config.frameRate);
    npilStats = ((npilStats-npilF0) ./ npilF0) .* 100;
    npilStats(isinf(npilStats)) = 0;
    npilStats(isnan(npilStats)) = 0;
    config.frameNpil.data{currentRun} = npilStats;
    
    %% ROI analysis
    currentRoiMat = zeros(size(roiSetActiveModel,1),config.timepoints);
    for currentRoi = 1:size(roiSetActiveModel,1)
        roi = roiSetActiveModel{currentRoi,2};
        roiImgData = cell(1,numel(config.channelVector));
        roiNpilData = cell(1,numel(config.channelVector));
        for n = 1:numel(config.channelVector)
            roiImgData{n} = mean(GetRoiTimeseries(currentImgData{n},roi),1);
        end
        
        switch lower(config.statsType)
            case 'dff'
                roiStats = roiImgData{1};
            case 'drr'
                roiCh1 = roiImgData{1};
                roiCh2 = roiImgData{2};
                roiStats = roiCh1 ./ roiCh2;
        end
        
        % calculate F0 (use quadratic fit method)
        roiF0 = CalculateF0(roiStats,config.frameRate);
        
        % calculate stats
        roiStats = ((roiStats-roiF0) ./ roiF0) .* 100;
        roiStats(isinf(roiStats)) = 0;
        roiStats(isnan(roiStats)) = 0;
        
        % event detection on roiStats
%         if ~strcmp(config.EventDetect.method,'none')
%             %% Event detection
%             eventDetect = config.EventDetect;
%             eventDetect.ca = roiStats; % thus, we use the non-neuropil corrected trace
%             eventDetect.rate = config.frameRate{currentRun};
%             eventStruct = CalciumEventDetect(eventDetect);
%             config.EventDetect.event{currentRoi,currentRun} = eventStruct.data.spike_predict;
%             oopsi = eventStruct.data.oopsi;
%             if strcmp(eventDetect.method,'fast_oopsi')
%                 config.EventDetect.oopsi{currentRoi,currentRun} = eventStruct.data.oopsi;
%             elseif strcmp(eventDetect.method,'peeling')
%                 config.EventDetect.residual{currentRoi,currentRun} = eventStruct.data.oopsi;
%                 config.EventDetect.model{currentRoi,currentRun} = eventStruct.data.model;
%             end
%             fprintf('\n%s Roi %1.0f Run %1.0f');
%             fprintf('Events: %1.0f\n',sum(eventStruct.data.spike_predict));
%             fprintf('Residual per frame: %1.3f\n',...
%                 sum(abs(eventStruct.data.oopsi))/length(eventStruct.data.oopsi));
%             currentEventMat(currentRoi,:) = eventStruct.data.spike_predict;
%         end
        
        % low-pass filter calcium traces
        roiStats = doLowPassFilter(roiStats,config.LowPass);
        
        % save
        config.dataRoi{currentRoi,currentRun} = roiStats;
        currentRoiMat(currentRoi,:) = roiStats;
    end
    
    % lowPass filter frame neuropil
    npilStats = doLowPassFilter(npilStats,config.LowPass);
    
    % save frame neuropil in last row
    currentRoiMat(currentRoi+1,:) = npilStats;
    
    RoiMatAllRuns = [RoiMatAllRuns currentRoiMat];
    
%     eventMatAllRuns = [eventMatAllRuns currentEventMat];
end

stimVectorAllRuns = cell2mat(config.stim);
stimTimeAllRuns = (1:length(stimVectorAllRuns)).*config.pixelTime;

%% Calcium Event Plot
% plot all Rois with stim in stacked plot
titleStr = sprintf('%s',config.saveName);
fig = figure('Name',titleStr,'NumberTitle','off'); hold all
currentOffset = 0;
time = (1:size(RoiMatAllRuns,2))/config.frameRate;
cellIDaxes = cell(size(RoiMatAllRuns,1),1);
meanYpos = zeros(size(RoiMatAllRuns,1),1);

for roi = 1:size(RoiMatAllRuns,1)
    if roi == size(RoiMatAllRuns,1)
        id = 'npil';
    else
        id = roiLabel{roi};
    end
    data = RoiMatAllRuns(roi,:);
    data = data + (min(data)*-1);
    dataPlot = data + currentOffset;
    currentOffset = max(dataPlot);
    cellIDaxes{roi} = id;
    meanYpos(roi) = mean(dataPlot);
end
stimVectorPlot = ScaleToMinMax(stimVectorAllRuns,0,max(RoiMatAllRuns(end,:)));
stimVectorPlot = (stimVectorPlot - min(stimVectorPlot)) + currentOffset;

currentOffset = max (stimVectorPlot);

roiLabel{end+1} = 'sound';

set(gca,'ylim',[0 currentOffset],'xlim',[min(time) max(time)+0.1*max(time)])
set(gca,'XTick',[])
ax1 = gca;
title(titleStr,'Interpreter','none')
ylabel(sprintf('%% %s',upper(config.statsType)))
ax2 = axes('Position',get(gca,'Position'),'YAxisLocation','right');
set(ax2,'ylim',[0 currentOffset],'xlim',[min(time) max(time)],...
    'YTick',meanYpos,'YTickLabel',cellIDaxes)
xlabel('Time / s')
hold all
currentOffset = 0;
for roi = 1:size(RoiMatAllRuns,1)
    data = RoiMatAllRuns(roi,:);
    data = data + (min(data)*-1);
    dataPlot = data + currentOffset;
    plot(time,dataPlot)
    currentOffset = max(dataPlot);
%     if roi == size(RoiMatAllRuns,1)
%         break
%     end
%     eventData = eventMatAllRuns(roi,:);
%     spkTimes = [];
%     for m = 1:length(eventData)
%         if eventData(m)
%             h_err = errorbar(time(m),min(dataPlot),0,...
%                 config.EventDetect.amp,'Color','black');
%             removeErrorBarEnds(h_err)
%             set(h_err,'LineWidth',2)
%         end
%     end
end

plot(stimTimeAllRuns,stimVectorPlot,'k')

% for n = 1:numel(StimVectorAllRuns)
%     if StimVectorAllRuns(n) == 1
%         plot([time(n) time(n)],[0 currentOffset],'LineStyle','--',...
%             'Color',[0.8 0.8 0.8])
%     elseif StimVectorAllRuns(n) == 2
%         plot([time(n) time(n)],[0 currentOffset],'LineStyle','--',...
%             'Color',[0.3 0.3 0.3])
%     end
% end
linkaxes([ax1,ax2],'y')
saveas(fig,sprintf('%s_RoiCalciumEvents',config.saveName))

matfileName = sprintf('%s_RoiStats.mat',config.saveName);
save(matfileName,'config')

if nargout
    varargout{1} = config;
end

%% Function - ParseConfig
function config = ParseConfig(config)
% check for missing fields in config structure and add them with
% default values

if ~isfield(config,'matfiles')
    matFiles = sort(uigetfile(...
        '*.mat','Select Mat Files','MultiSelect','on'));
    config.matfiles = strrep(matFiles,'.mat','');
else
    matfiles = config.matfiles;
end

if ~isfield(config,'saveName')
    config.saveName = [matfiles{1} '__RoiStats'];
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

if ~isfield(config,'npilCorrect')
    config.npilCorrect = 0.2;
end
if ~isfield(config,'recycleNpilMovie')
    config.recycleNpilMovie = 0;
end
if ~isfield(config,'doOgbSRsegmentation')
    config.doOgbSRsegmentation = 0;
end
if config.doOgbSRsegmentation
    if ~isfield(config,'OgbChannel')
        config.OgbChannel = 1;
    end
    if ~isfield(config,'SrChannel')
        config.SrChannel = 2;
    end
end
if ~isfield(config,'segOptions')
    config.segOptions = struct;
end

if ~isfield(config,'psConfig')
    config.psConfig = struct;
    config.psConfig.baseFrames = 5;
    config.psConfig.evokedFrames = 15;
end

% event detection
if ~isfield(config,'EventDetect')
    config.EventDetect.method = 'none';
end

% low-pass filter (applied to the calcium trace AFTER event detection)
% also applied to GLM model
if ~isfield(config,'LowPass')
    config.LowPass.method = 'none';
    config.LowPass.params = [];
end
% LowPass.method may take the following values:
% 'none' ... no low-pass filtering is applied
% 'sg' ... savitzky-golay filter, as implemented in ML
% LowPass.params is a vector with filter parameters, depending on the
% specific filter (all cutoffs should be defined in s)
% for SG, params are [lpFilterCutoff filterOrder]

if ~isfield(config,'ch3Sound')
    config.ch3Sound = 1;
end

if ~isfield(config,'pixelTime')
    config.pixelTime = 12;
end
config.pixelTime = config.pixelTime / 1000000;

%% Function - CalculateF0
function f0_mat = CalculateF0(roi_mat,f)
t = 1/f:1/f:length(roi_mat)./f;
p = polyfit(t',roi_mat',2);
f0_mat = p(1).*t.^2 + p(2).*t + p(3);

%% Function - doLowPassFilter
function v = doLowPassFilter(v,S)
switch S.method
    case 'sg'
        v = sgolayfilt(v,S.sgolayOrder,S.lpFiltCutoff);
end

%% Function - doActiveModelSegment
function roi = doActiveModelSegment(img,cog,options)
options.cog = cog;
if ~isfield(options,'cellsize')
    options.cellsize = 7; end
if ~isfield(options,'minMaskSize')
    options.minMaskSize = 20; end
if ~isfield(options,'snake_iter1')
    options.snake_iter1 = 100; end
if ~isfield(options,'snake_iter')
    options.snake_iter = 10; end
if ~isfield(options,'alpha')
    options.alpha = 1; end
if ~isfield(options,'beta')
    options.beta = 0; end
if ~isfield(options,'tau')
    options.tau = 0.1; end
if ~isfield(options,'filt_range')
    options.filt_range = [3 3]; end
if ~isfield(options,'filt_order')
    options.filt_order = 1; end
if ~isfield(options,'canny_lo')
    options.canny_lo = [0.1 0.05 0.01]; end
if ~isfield(options,'canny_hi')
    options.canny_hi = [0.25 0.15 0.05]; end
if ~isfield(options,'alt_radius')
    options.alt_radius = 2; end
if ~isfield(options,'doPlot')
    options.doPlot = 0; end
if ~isfield(options,'enlarge')
    options.enlarge = 0; end
if ~isfield(options,'erode')
    options.erode = 0; end

try
    roi = ActiveModel_segment(img,options);
catch
    roi = zeros(size(img,1),size(img,2));
    rethrow(lasterror);
end



% e.o.f.