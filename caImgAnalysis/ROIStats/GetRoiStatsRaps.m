function varargout = GetRoiStatsRaps(config)
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

% run in parallel (matlabpool should be available)?
if matlabpool('size')
   doParallel = 1;
else
    doParallel = 0;
end
% doParallel = 0;

for n = 1:numel(matfiles)
    if isempty(strfind(matfiles{n},'.mat'))
        matfiles{n} = [matfiles{n} '.mat'];
    end
end

S = load(matfiles{1});
data = S.(genvarname(strrep(matfiles{1},'.mat','')));

samplingRate = data.hdr.rate;
delFrame = data.proc.DelFrame;
% number of points
fIdx = strfind(matfiles{1},'pts');
for i = fIdx-1:-1:1
    if strcmp(matfiles{1}(i),'_')
        config.points = str2num(matfiles{1}(i+1:fIdx-1));
        break
    end
end

% experiment specific info
animalID = data.hdr.animalID;
spotID = data.hdr.spotID;

saveName = sprintf('%s_%s_RoiStats',animalID,spotID);

% print out some experiment details
fprintf('%s - %s\n',animalID,spotID);
fprintf('Total Points: %1.0f Sampling frequency: %1.2f\n',config.points,samplingRate);
fprintf('Total cells: %1.0f\n',config.points/config.pointsPerCell);
fprintf('Background vector: %s\n',num2str(config.bgVector));

config.totalCells = config.points/config.pointsPerCell;

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

%% Setup event detection - Peeling
config.runsNo = numel(matfiles);
switch lower(config.EventDetect.method)
    case 'peeling'
        % setup generic input structure for doPeeling
        % required fields should be defined in calling script (see
        % doPeeling for documentation)
        eventS = config.EventDetect;
        eventS.rate = samplingRate;
    case 'none'
        % nothing to do here
    otherwise
        error('Unknow event detection method: %s',config.EventDetect.method)
end

out.roiData = cell(1,config.runsNo);
out.eventData = cell(1,config.runsNo);
out.modelData = cell(1,config.runsNo);
out.residualData = cell(1,config.runsNo);
out.stim = cell(1,config.runsNo);
out.hdr = cell(1,config.runsNo);
out.proc = cell(1,config.runsNo);

%% Process runs
for currentRun = 1:config.runsNo
    fprintf('\nNow processing run %1.0f\n',currentRun);
    % for 'drr', work on both channels, for 'dff' work on ch1
    S = load(matfiles{currentRun});
    data = S.(genvarname(strrep(matfiles{currentRun},'.mat','')));
    
    out.hdr{currentRun} = data.hdr;
    out.proc{currentRun} = data.proc;
    
    rapsData = cell(1,length(config.channelVector));
    for n = 1:length(config.channelVector)
        A = data.img_data{config.channelVector(n)};
        A(:,end+1) = A(:,1); A(:,1) = []; % first column last
        rapsData{n} = A;
    end
    
    timepoints = size(rapsData{1},1);
    
    if isempty(data.stim)
        if config.ch3Sound
            [config.stim{currentRun},soundT] = ...
                img2vector(double(data.img_data{3}),1/config.pixelTime,0);
        else
            config.stim{currentRun} = [];
        end
        config.stim{currentRun} = removeBlankPixels(config.stim{currentRun});
        [stimTable,~,toneClean] = AnalyzePureToneVector(config.stim{currentRun},...
            1/config.pixelTime,0);
        %     [stimTable,toneClean] =  cleanUpBadSound(config.stim{currentRun},...
        %         1/config.pixelTime,0);
        plotSoundVector = 1;
    else
        stimTable = data.stim;
        plotSoundVector = 0;
    end
    [stim,stimTime,stimID] = soundTable2StimVector(stimTable,1/config.pixelTime,0);
    
    out.stim{currentRun} = stimTable;
    
    % average columns for each cell
    ch1ByCell = zeros(size(rapsData{1},1),...
        config.points/config.pointsPerCell);
    ch2ByCell = zeros(size(rapsData{2},1),...
        config.points/config.pointsPerCell);
    
    pos = 1;
    for n = 1:config.pointsPerCell:size(rapsData{1},2)
        currentCell = double(rapsData{1}(:,n:n+config.pointsPerCell-1));
        currentCell = removeBlankPixels(currentCell,1);
%         currentCell(:,end) = currentCell(:,end) + ...
%             (mean(mean(currentCell(:,1:config.pointsPerCell-1)))-mean(currentCell(:,end)));
        ch1ByCell(:,pos) = mean(currentCell,2);
        currentCell = double(rapsData{2}(:,n:n+config.pointsPerCell-1));
        currentCell = removeBlankPixels(currentCell,1);
%         currentCell(:,end) = currentCell(:,end) + ...
%             (mean(mean(currentCell(:,1:config.pointsPerCell-1)))-mean(currentCell(:,end)));
        ch2ByCell(:,pos) = mean(currentCell,2);
        pos = pos + 1;
    end
    
    % subtract background
    ch1_bg = mean(ch1ByCell(:,config.bgVector),2);
    ch2_bg = mean(ch2ByCell(:,config.bgVector),2);
    for n = 1:size(ch1ByCell,2)
        ch1ByCell(:,n) = ch1ByCell(:,n) - ch1_bg;
        ch2ByCell(:,n) = ch2ByCell(:,n) - ch2_bg;
    end
    disp('Subtracted background');
    % remove background columns
    ch1ByCell(:,config.bgVector) = [];
    ch2ByCell(:,config.bgVector) = [];
    
    switch config.statsType
        case 'drr'
            ratio = ch1ByCell ./ ch2ByCell;
        case 'dff'
            ratio = ch1ByCell;
    end
    
    % DRR
    DRR = zeros(size(ratio));
    for n = 1:size(ch1ByCell,2)
%         r0 = findF0_prctile(ratio(:,n),samplingRate,5,10);
        % calculate F0 (use quadratic fit method)
        r0 = CalculateF0(ratio(:,n),samplingRate);
        DRR(:,n) = ((ratio(:,n) - r0) ./ r0)*100;
    end
    fprintf('Calculated relative fluorescence (%s)\n',...
        upper(config.statsType));
    
    DRRsmooth = zeros(size(DRR));
    for n = 1:size(DRR,2)
        DRRsmooth(:,n) = doLowPassFilter(DRR(:,n),config.LowPass);
    end
    
    % notch filter
    if config.notchF
        fprintf('Fluorescence notch filter %1.2fHz (Q=%1.1f)\n',...
            config.notchF,config.notchQ);
        for n = 1:size(DRR,2)
            DRRsmooth(:,n) = notchFilter(DRRsmooth(:,n),samplingRate,...
                config.notchF,config.notchQ);
        end
    end
    RoiMatAllRuns = DRRsmooth';
    
    out.roiData{currentRun} = RoiMatAllRuns;
    
    %% Event detection
    switch lower(config.EventDetect.method)
        case 'peeling'
            fprintf('Started Peeling for %s %s run %1.0f (%1.0f cells)\n',...
                animalID,spotID,currentRun,size(RoiMatAllRuns,1))
            t = tic;
            eventData = zeros(size(RoiMatAllRuns));
            modelData = zeros(size(RoiMatAllRuns));
            residualData = zeros(size(RoiMatAllRuns));
            if doParallel
                spiketrainCell = cell(1,size(RoiMatAllRuns,1));
                modelCell = cell(1,size(RoiMatAllRuns,1));
                peelCell = cell(1,size(RoiMatAllRuns,1));
                parfor roi2 = 1:size(RoiMatAllRuns,1)
                    Sin = eventS; Sin.dff = RoiMatAllRuns(roi2,:);
                    outS = doPeeling(Sin);
                    spiketrainCell{1,roi2} = outS.data.spiketrain;
                    modelCell{1,roi2} = outS.data.model;
                    peelCell{1,roi2} = outS.data.peel;
                end
                for roi2 = 1:size(RoiMatAllRuns,1)
                    eventData(roi2,:) = spiketrainCell{roi2};
                    modelData(roi2,:) = modelCell{roi2};
                    residualData(roi2,:) = peelCell{roi2};
                end
                clear spiketrainCell modelCell peelCell
            else
                for roi2 = 1:size(RoiMatAllRuns,1)
                    fprintf('.')
                    eventS.dff = RoiMatAllRuns(roi2,:);
                    outS = doPeeling(eventS);
                    eventData(roi2,:) = outS.data.spiketrain;
                    modelData(roi2,:) = outS.data.model;
                    residualData(roi2,:) = outS.data.peel;
                end
            end
            t = toc(t);
            fprintf('\nFinished Peeling (t=%1.2f s)\n',t)
    end
    
    out.eventData{currentRun} = eventData;
    out.modelData{currentRun} = modelData;
    out.residualData{currentRun} = residualData;
    
    % plot all Rois with stim in stacked plot
    titleStr = (strrep(matfiles{currentRun},'.mat',''));
    fig = figure('Name',titleStr,'NumberTitle','off'); hold all
    currentOffset = 0;
    time = (1:size(RoiMatAllRuns,2))/samplingRate;
    cellIDaxes = cell(size(RoiMatAllRuns,1),1);
    meanYpos = zeros(size(RoiMatAllRuns,1),1);
    
    for roi = 1:size(RoiMatAllRuns,1)
        data = RoiMatAllRuns(roi,:);
        currentSD = std(data);
        data = data + (min(data)*-1);
        dataPlot = data + currentOffset;
        currentOffset = max(dataPlot);
        cellIDaxes{roi} = sprintf('%1.0f (%1.2f)',roi,currentSD);
        meanYpos(roi) = mean(dataPlot);
        switch lower(config.EventDetect.method)
            case 'fast_oopsi'
                events = eventData(roi,:)*30;
                events = events + currentOffset;
                currentOffset = max(events);
        end
    end
    
    if config.ch3Sound && plotSoundVector
        cellIDaxes{roi+1} = 'sound';
        dataPlot = ScaleToMinMax(config.stim{currentRun},0,50);
        dataPlot = dataPlot + currentOffset;
        meanYpos(roi+1) = mean(dataPlot);
        currentOffset = max(dataPlot);
    end
    hold all
    set(gca,'ylim',[0 currentOffset],'xlim',[min(time) ...
        max(time)+0.1*max(time)])
    set(gca,'XTick',[])
    ax1 = gca;
    saveStr = titleStr;
    try
        titleStr = sprintf('%s\nStandard: %1.0f kHz Deviant: %1.0f kHz',...
            titleStr,stimID(1),stimID(2));
    end
    title(titleStr,'Interpreter','none')
    ylabel(sprintf('%% %s',upper(config.statsType)))
    ax2 = axes('Position',get(gca,'Position'),'YAxisLocation','right');
    set(ax2,'ylim',[0 currentOffset],'xlim',[min(time) max(time)],...
        'YTick',meanYpos,'YTickLabel',cellIDaxes)
    xlabel('Time / s')
    hold all
    stimTimes1 = stimTime(stim==1);
    stimTimes2 = stimTime(stim==2);
    for n = 1:numel(stimTimes1)
        plot([stimTimes1(n) stimTimes1(n)],[0 currentOffset],'--','Color',[0.5 0.5 0.5]), hold all
    end
    for n = 1:numel(stimTimes2)
        plot([stimTimes2(n) stimTimes2(n)],[0 currentOffset],'--r'), hold all
    end
    
    hold all
    currentOffset = 0;
    for roi = 1:size(RoiMatAllRuns,1)
        data = RoiMatAllRuns(roi,:);
        data = data + (min(data)*-1);
        dataPlot = data + currentOffset;
        plot(time,dataPlot,'k')
        currentOffset = max(dataPlot);
        events = eventData(roi,:);
        switch lower(config.EventDetect.method)
            case 'fast_oopsi'
                events = events * 30;
                events = events + currentOffset;
                plot(time,events,'Color',[0.5 0.5 0.5])
                currentOffset = max(events);
            case 'peeling'
                spikeTimes = time(events>0);
                scatter(spikeTimes,repmat(min(dataPlot),1,numel(spikeTimes)),'.',...
                    'MarkerEdgeColor',[0.5 0.5 0.5])
        end
    end
    if config.ch3Sound && plotSoundVector
        dataPlot = ScaleToMinMax(config.stim{currentRun},0,50);
        dataPlot = dataPlot + currentOffset;
        plot(soundT,dataPlot,'Color',[0.5 0.5 0.5])
    end
    
    linkaxes([ax1,ax2],'y')
    
    saveas(gcf,[saveStr '.fig'])
    
end

SaveAndAssignInBase(out,saveName,'SaveOnly')

if nargout
    varargout{1} = out;
end


%% Function - doLowPassFilter
function v = doLowPassFilter(v,S)
switch S.method
    case 'sg'
        v = sgolayfilt(v,S.sgolayOrder,S.lpFiltCutoff);
end

function f0_mat = CalculateF0(roi_mat,f)
t = (1/f:1/f:length(roi_mat)./f)';
p = polyfit(t,roi_mat,2);
f0_mat = p(1).*t.^2 + p(2).*t + p(3);

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

if ~isfield(config,'pointsPerCell')
    config.pointsPerCell = 9;
end

if ~isfield(config,'bgVector')
    config.bgVector = [1 2 3];
end

if ~isfield(config,'ch3Sound')
    config.ch3Sound = 1;
end

if ~isfield(config,'pixelTime')
    config.pixelTime = 12;
end
config.pixelTime = config.pixelTime / 1000000;

if ~isfield(config,'statsType')
    config.statsType = 'dff';
end

if ~isfield(config,'notchF')
    config.notchF = 0;
end

if ~isfield(config,'notchQ')
    config.notchQ = 1;
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

% event detection
if ~isfield(config,'EventDetect')
    config.EventDetect.method = 'none';
end

% low-pass filter
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




% e.o.f.