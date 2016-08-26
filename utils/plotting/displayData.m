function varargout = displayData(varargin)

% this file written by Henry Luetcke

if nargin
   S = varargin{1}; % parameter structure 
else
    S = struct;
end
tic
S = parseInputs(S);

%% load data
[FilePath,FileName,FileType] = fileparts(S.RawFiles{1});
fullInfile = fullfile(FilePath,[FileName FileType]);
if exist(fullInfile,'file') ~= 2
    error('Could not find %s on absolute and relative paths',fullInfile);
end
switch FileType
    case '.fcs'
        img = import_raw(fullInfile);
        S.img_data{1} = uint8(img.ch1/255); % always save 8-bit integers
        S.img_data{2} = uint8(img.ch2/255);
        % save bit-depth for later usage
        S.hdr.bits = 8;
    case '.tif'
        % TODO: new tif-import in separate file, return data cell array and
        % header info
        img =tiffread2_wrapper(fullInfile);
        S.img_data{1} = img.data;
        S.hdr.tifHeader{1} = img.header;
        disp('Loaded channel 1');
        if exist(strrep(fullInfile,'channel00','channel01')) == 2
            img =tiffread2_wrapper(strrep(fullInfile,'channel00','channel01'));
            S.img_data{2} = img.data;
            S.hdr.tifHeader{2} = img.header;
            disp('Loaded channel 2');
        end
        if exist(strrep(fullInfile,'channel00','channel02')) == 2
            img =tiffread2_wrapper(strrep(fullInfile,'channel00','channel02'));
            S.img_data{3} = img.data;
            S.hdr.tifHeader{3} = img.header;
            disp('Loaded channel 3');
        end
        S.hdr.bits = 16;
    otherwise
        error('Unrecognized file type %s',FileType);
end

%% Delete frames
if S.del_frame
    for n = 1:length(S.img_data)
        S.img_data{n} = S.img_data{n}(:,:,S.del_frame+1:end);
    end
end
fprintf('Deleted %1.0f frame(s)\n',S.del_frame);

%% Background correction
if S.bgCorrect
    for n = 1:length(S.img_data)
        S.img_data{n} = bg_subtract_HL(S.img_data{n},S.bgCorrect,0,...
            'percentile');
        S.img_data{n}(S.img_data{n}<0) = 0;
    end
end

%% Calculate stats
switch lower(S.statsType)
    case 'dff'
        stats = S.img_data{S.channelVector==1};
        avgImg = mean(stats,3);
        intensityCutoff = prctile(avgImg(:),1);
        maskImg = ones(size(avgImg));
        maskImg(avgImg<=intensityCutoff) = 0;
    case 'drr'
        stats1 = S.img_data{S.channelVector==1};
        stats2 = S.img_data{S.channelVector==2};
        avgImg = mean(stats1,3);
        stats = stats1 ./ stats2; clear stats1 stats2
        intensityCutoff = prctile(avgImg(:),1);
        maskImg = ones(size(avgImg));
        maskImg(avgImg<=intensityCutoff) = 0; % could extend this to include second channel
end
% smooth stats image
parfor n = 1:size(stats,3)
    stats(:,:,n) = imfilter(stats(:,:,n),fspecial('gaussian',[10 10]));
end
fprintf('Smoothed image\n');

% calculate stats
fprintf('Calculating %s image\n',upper(S.statsType));
statsImg = zeros(size(stats));
parfor x1 = 1:size(stats,1)
%     fprintf('Processing row %1.0f of %1.0f\n',x1,size(stats,1));
    currentRow = shiftdim(stats(x1,:,:))';
    currentRow = doStats(currentRow,maskImg(x1,:),S.frame_rate,5,25);
    statsImg(x1,:,:) = reshape(currentRow',size(stats,2),size(stats,3));
%     for x2 = 1:size(stats,2)
%         if maskImg(x1,x2)
%             fVector = reshape(stats(x1,x2,:),1,size(stats,3));
%             % 5 s segements; background at 25th percentile
%             f0Vector = findF0(fVector,S.frame_rate,5,25);
%             statsImg(x1,x2,:) = ...
%                 ((fVector-f0Vector) ./ f0Vector) .* 100;
%         else
%             statsImg(x1,x2,:) = NaN;
%         end
%     end
end
stats = statsImg; clear statsImg

frameNpil = nanmean(GetRoiTimeseries(stats,[]));

%% Average image
figure('Name','Average image','NumberTitle','off','Color','white');
imagesc(avgImg), colormap(gray), colorbar
set(gca,'xtick',[],'ytick',[])

%% Activity image
imgActive = FindActiveCells(stats,1);
% normalize by neuropil skewness
imgActive = imgActive ./ skewness(frameNpil);
figure('Name','Activity image','NumberTitle','off','Color','white');
imagesc(imgActive), colorbar
set(gca,'xtick',[],'ytick',[])

%% Frame neuropil plot
figure('Name','Frame neuropil','NumberTitle','off','Color','white');
time = 1/S.frame_rate:1/S.frame_rate:size(stats,3)/S.frame_rate;
plot(time,frameNpil)
xlabel('Time / s')
ylabel(sprintf('%s / %%',S.statsType));

tilefigs
% toc
% return

windowSize = 5;
for x1 = 1:size(stats,1)
    for x2 = 1:size(stats,2)
        stats(x1,x2,:) = filtfilt(ones(1,windowSize)/windowSize,1,...
            stats(x1,x2,:));
    end
end

%% Activity movie
% figure('Name','Activity Movie','NumberTitle','off','Color','white');
% true-color grayscale image
avgMovie = gray2rgb(avgImg,512,'gray');
avgMovie = repmat(avgMovie,[1 1 1 size(stats,3)]);
avgIntensity = zeros(1,3);
cmap = hot(256);
statsScale = [10 30];
statsLUT = statsScale(1):(statsScale(2)-statsScale(1))/255:statsScale(2);
disp('Making movie...')
for n = 1:size(stats,3)
    fprintf('Frame %1.0f / %1.0f\n',n,size(stats,3));
    stats(:,:,n) = imfilter(stats(:,:,n),fspecial('gaussian',[10 10]));
    currentAvgMovie = avgMovie(:,:,1:3,n);
    currentStats = stats(:,:,n);
    currentRGB = zeros(size(stats,1),size(stats,2),3);
    for x1 = 1:size(currentStats,1)
        for x2 = 1:size(currentStats,2)
            if currentStats(x1,x2) > statsScale(1)
                avgIntensity = reshape(currentAvgMovie(x1,x2,:),1,3);
                [val,idx] = min(abs(statsLUT-currentStats(x1,x2)));
                if idx > size(cmap,1)
                    idx =  size(cmap,1);
                end
                currentStatsRGB = cmap(idx,:);
                currentRGB(x1,x2,:) = nanmean([avgIntensity; currentStatsRGB]);
            else
                currentRGB(x1,x2,:) = currentAvgMovie(x1,x2,1:3);
            end
        end
    end
    avgMovie(:,:,1:3,n) = currentRGB;
end
avgMovie(avgMovie>1) = 1;
avgMovie(avgMovie<0) = 0;
implay(avgMovie,25)
toc

function statsImg = doStats(stats,maskImg,frameRate,segmentDur,f0cutoff)
statsImg = zeros(size(stats));
for n = 1:size(stats,2)
    if ~maskImg(n)
        statsImg(:,n) = nan(size(stats,1),1);
    else
        fVector = stats(:,n)';
        % 5 s segements; background at 25th percentile
        f0Vector = findF0(fVector,frameRate,segmentDur,f0cutoff);
        fVector = ((fVector-f0Vector) ./ f0Vector) .* 100;
        statsImg(:,n) = fVector';
    end
end
% statsImg(:,~maskImg) = NaN;

%% ParseInputs - function
function S = parseInputs(inargs)
if ~isempty(inargs) && isstruct(inargs)
    % convert structure to pseudo-input cellarray
    inargs = struct2cellArray(inargs);
end

% input files - usually Gui-select
SpInput = find(strcmpi(inargs, 'RawFiles'));
if numel(SpInput)
    RawFiles = inargs{SpInput+1};
    if ~iscellstr(RawFiles)
        error('Modifier for raw files property must be a cell string');
    end
else
    [FileName,PathName,FilterIndex] = uigetfile({'*.tif';'*.tiff';'*.fcs'},...
        'Select raw file(s) - only 1 channel','MultiSelect','off');
    if ~iscellstr(FileName)
        FileName = {FileName};
    end
    if ~FileName{1}; return; end
    if ~iscellstr(FileName); FileName = cellstr(FileName); end
%     if strfind(PathName,RawDataDir)
%        PathName = strrep(PathName,RawDataDir,'');
%     end
    for n = 1:length(FileName) % interpret GUI-selected multiple files as different channels
        RawFiles{1,n} = fullfile(PathName,FileName{n});
    end
end
S.RawFiles = RawFiles;

% frame rate
SpInput = find(strcmpi(inargs, 'frame_rate'));
if numel(SpInput)
    frame_rate = inargs{SpInput+1};
    if isscalar(frame_rate)
        frame_rate = repmat(frame_rate,1,length(RawFiles));
    else
        if length(frame_rate) ~= length(RawFiles)
            error('Frame rate must be a scalar or vector of length input file number');
        end
    end
else
    frame_rate = 9.16;
end
S.frame_rate = frame_rate;

% Preprocessing options - delete frame
SpInput = find(strcmpi(inargs, 'DelFrame'));
if numel(SpInput)
    del_frame = inargs{SpInput+1};
    if isscalar(del_frame)
        del_frame = repmat(del_frame,1,length(RawFiles));
    else
        if length(del_frame) ~= length(RawFiles)
            error('DelFrame must be a scalar or vector of length input file number');
        end
    end
else
    del_frame = 1;
end
S.del_frame = del_frame;
% bg. correction - only specify cutoff for percentile method here (default
% 1)
SpInput = find(strcmpi(inargs, 'BgCorrect'));
if numel(SpInput)
    bgCorrect = inargs{SpInput+1};
else
    bgCorrect = 1;
end
S.bgCorrect = bgCorrect;

if ~isfield(S,'statsType')
    S.statsType = 'dff';
end

% channels for stats calculation
% DFF is calculated on the channel specified by config.channelVector(1)
% DRR is calculated on the channels specified by config.channelVector(1)
% and config.channelVector(2)
if ~isfield(S,'channelVector')
    S.channelVector = [1 2];
end

if strcmpi(S.statsType,'drr') && numel(S.channelVector) < 2
    error('channelVector must specify at least 2 channels for DRR stats!');
end





