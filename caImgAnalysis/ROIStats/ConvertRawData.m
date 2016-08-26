function varargout = ConvertRawData(varargin)
% inputs: no need to specify any inputs --> GUI-based file selection
% optional input arguments, specified as 'property' 'value' pair in
% arbitrary order, e.g. 'zoom',1.07 OR as a structure with properties as
% field names and values, e.g. config.zoom = 1.07
% for a full list of supported arguments see the end of this file

% this file written by Henry Luetcke (hluetck@gmail.com)

% current version: 2011-06-05
% 2011-01: added freeline 2D (focus) support
% 2011-06: added AOD (J90) support (Raps and frame scans)
% 2013-10: added LSM support

%% Main

dbgLevel = 0;

% RawDataDir = getGlobalParameters('RawDataDir');
% if ~RawDataDir
%    error('Raw data directory MUST be specified');
% end

o('      #ConvertRawData(): parsing inputs...', 2, dbgLevel);
args = parseInputArgs(varargin);
if min(size(args.RawFiles)) > 1
    nRuns = size(args.RawFiles, 1);
else
    nRuns = length(args.RawFiles);
    % make sure runs are in columns
    args.RawFiles = reshape(args.RawFiles, numel(args.RawFiles), 1);
end

o('      #ConvertRawData(): number of runs: %d.', nRuns, 1, dbgLevel);
structArray = cell(1, nRuns);
for iRun = 1 : nRuns;
    o('      #ConvertRawData(): run %d of %d...', iRun, nRuns, 2, dbgLevel);
    % create structure
    currStruct = initStruct(args, iRun);
    if ~isstruct(currStruct); % if an error occured
        continue;
    end;
    o('      #ConvertRawData(): run %d/%d: initialized structure.', iRun, nRuns, 3, dbgLevel);
    
    % preprocess image data
    currStruct = preprocStruct(args, iRun, currStruct);
    o('      #ConvertRawData(): run %d/%d: pre-processed structure.', iRun, nRuns, 3, dbgLevel);
    
    % save files
    saveFiles(currStruct, args.SaveDir, args);
    % assign in array
    structArray{iRun} = currStruct;
    
    o('      #ConvertRawData(): run %d/%d: saved files and assigned in array.', iRun, nRuns, 3, dbgLevel);
    
end

if nargout
   varargout{1} = structArray;
end

end

%% Parse inputs
function outStruct = parseInputArgs(inargs)

dbgLevel = 0;
o('        #ConvertRawData.parseInputArgs(): ...', 4, dbgLevel);
if ~isempty(inargs) && isstruct(inargs{1})
    % convert structure to pseudo-input cellarray
    inargs = struct2cellArray(inargs{1});
end
% RawDataDir = getGlobalParameters('RawDataDir');
% input files
SpInput = find(strcmpi(inargs, 'RawFiles'));
if numel(SpInput)
    RawFiles = inargs{SpInput+1};
    if ~iscellstr(RawFiles);
        error('Modifier for raw files property must be a cell string');
    end
else
    [FileName, PathName, ~] = uigetfile({'*.tif';'*.tiff';'*.fcs';'*.fln';'*.lsm'},...
        'Select raw file(s) to import','MultiSelect','on');
    if ~iscellstr(FileName)
        FileName = {FileName};
    end
    if ~FileName{1}; return; end
    if ~iscellstr(FileName); FileName = cellstr(FileName); end
%     if strfind(PathName,RawDataDir)
%        PathName = strrep(PathName,RawDataDir,'');
%     end
    RawFiles = cell(1,length(FileName));
    for n = 1:length(FileName) % interpret GUI-selected multiple files as different channels
        RawFiles{1, n} = fullfile(PathName, FileName{n});
    end
end
outStruct.RawFiles = RawFiles;
o('        #ConvertRawData.parseInputArgs(): RawFiles created (length: %d)...', numel(RawFiles), 5, dbgLevel);

% animal ID
SpInput = find(strcmpi(inargs, 'animalID'));
if numel(SpInput)
    animalID = inargs{SpInput+1};
else
    animalID = '';
end
outStruct.animalID = animalID;
o('        #ConvertRawData.parseInputArgs(): animalID = %s...', animalID, 5, dbgLevel);

% spot ID
SpInput = find(strcmpi(inargs, 'spotID'));
if numel(SpInput)
    spotID = inargs{SpInput+1};
else
    spotID = '';
end
outStruct.spotID = spotID;
o('        #ConvertRawData.parseInputArgs(): spotID = %s...', spotID, 5, dbgLevel);

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
    frame_rate = [];
end
outStruct.frame_rate = frame_rate;

% zoom
SpInput = find(strcmpi(inargs, 'zoom'));
if numel(SpInput)
    zoom_factor = inargs{SpInput+1};
    if isscalar(zoom_factor)
        zoom_factor = repmat(zoom_factor,1,length(RawFiles));
    else
        if length(zoom_factor) ~= length(RawFiles)
            error('Zoom must be a scalar or vector of length input file number');
        end
    end
else
    zoom_factor = [];
end
outStruct.zoom_factor = zoom_factor;

% laser power
SpInput = find(strcmpi(inargs, 'laserPower'));
if numel(SpInput)
    laserPower = inargs{SpInput+1};
    if isscalar(laserPower)
       laserPower = repmat(laserPower,1,length(RawFiles));
    else
        if length(laserPower) ~= length(RawFiles)
            error('Laser power must be a scalar or vector of length input file number');
        end
    end
else
    laserPower = [];
end
outStruct.laserPower = laserPower;

% image type
SpInput = find(strcmpi(inargs, 'type'));
if numel(SpInput)
    img_type = inargs{SpInput+1};
    if ~iscellstr(img_type); img_type = cellstr(img_type); end
    if length(img_type) == 1
        img_type = repmat(img_type,1,length(RawFiles));
    elseif length(img_type) ~= length(RawFiles)
        error('Image type must be a cell string of length 1 or input file number');
    end
else
    img_type = {'movie'};
    img_type = repmat(img_type,1,length(RawFiles));
%     img_type = cell(1,length(RawFiles));
end
outStruct.img_type = img_type;

% Roi set
SpInput = find(strcmpi(inargs, 'RoiSet'));
if numel(SpInput)
    roi_set = inargs{SpInput+1};
    if iscell(roi_set) && size(roi_set, 2) == 2;
        % all okay, ROISet with 2 columns: names and ROIMasks for each ROI
    else
        if ~iscellstr(roi_set); roi_set = cellstr(roi_set); end
        if length(roi_set) == 1
            roi_set = repmat(roi_set,1,length(RawFiles));
        elseif length(roi_set) ~= length(RawFiles)
            error('RoiSet must be a cell string of length 1 or input file number');
        end
    end;
else
    roi_set = cell(1,length(RawFiles));
end
outStruct.roi_set = roi_set;


% Reference image
SpInput = find(strcmpi(inargs, 'RefImg'));
if numel(SpInput)
    refImg = inargs{SpInput + 1};
    if ischar(refImg); % okay will be loaded later
    elseif isnumeric(refImg); % already loaded image
    else
        error('refImg must be a file name or a loaded reference image !');
    end
else
    refImg = '';
end
outStruct.refImg = refImg;

% Stimulus
SpInput = find(strcmpi(inargs, 'Stim'));
if numel(SpInput)
    stim = inargs{SpInput+1};
    if ~iscell(stim); stim = {stim}; end
    if length(stim) == 1 && length(RawFiles) > 1
        stim = repmat(stim,1,length(RawFiles));
    elseif length(stim) ~= length(RawFiles)
        error('Stimulation must be a cell array of length 1 or input file number');
    end
else
    stim = cell(1,length(RawFiles));
end
outStruct.stim = stim;

% Ephys
SpInput = find(strcmpi(inargs, 'Ephys'));
if numel(SpInput)
    ephys = inargs{SpInput+1};
    if ~iscell(ephys) || length(ephys) ~= length(RawFiles)
        error('Ephys must be a cell array of length input file number');
    end
    outStruct.ephys = ephys;
end

% Output directory
SpInput = find(strcmpi(inargs, 'SaveDir'));
if numel(SpInput)
    SaveDir = inargs{SpInput+1};
    if exist(SaveDir,'dir') ~= 7
       try
          mkdir(SaveDir);
       catch e
           error('Failed to create directory %s',SaveDir);
       end
    end
else
    SaveDir = pwd;
end
outStruct.SaveDir = SaveDir;

% color vector
SpInput = find(strcmpi(inargs, 'ColorVector'));
if numel(SpInput)
    outStruct.ColorVector = inargs{SpInput+1};
else
    outStruct.ColorVector = [2 1 0];
end

% Dimensions - usually not necessary to specify, except for freeline 2d
% focus in which case dims should be specified as [columns rows]
SpInput = find(strcmpi(inargs, 'Dims'));
if numel(SpInput)
    outStruct.dims = inargs{SpInput+1};
else
    switch outStruct.img_type{1}
        case 'free2d_focus'
          error('Must always specify image dimensions for freeline 2D focus.');
    end
end

% Position - can be created with makePositionStructure
SpInput = find(strcmpi(inargs, 'Position'));
if numel(SpInput)
    outStruct.position = inargs{SpInput+1};
else
    outStruct.position = makePositionStructure;
end

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
    del_frame = [];
end
outStruct.del_frame = del_frame;
% bg. correction
SpInput = find(strcmpi(inargs, 'BgCorrect'));
if numel(SpInput)
    bgCorrect = inargs{SpInput+1};
else
    bgCorrect = [];
end
outStruct.bgCorrect = bgCorrect;

end

%% Structure initialization
function S = initStruct(inargs, iRun)

dbgLevel = 0;
o('        #ConvertRawData#initStruct(): run %d...', iRun, 4, dbgLevel);
infile = inargs.RawFiles(iRun, :);
[FilePath,FileName,FileType] = fileparts(infile{1});
% if the file cannot be found with the absolute path, try the relative path
% instead
if exist(infile{1},'file') ~= 2
    infile_full = fullfile(FilePath,[FileName FileType]);
    if exist(infile_full,'file') ~= 2
       warning('initStruct:FileNotFound', 'Could not find %s on absolute and relative paths', infile_full);
       S = [];
       return;
%        error('Could not find %s on absolute and relative paths',infile_full);
    end
else
    infile_full = infile;
end

S.hdr.animalID = inargs.animalID;
S.hdr.spotID = inargs.spotID;
S.hdr.laserPower = inargs.laserPower;
S.hdr.refImg = inargs.refImg;
S.hdr.frame_rate = inargs.frame_rate;

S.hdr.position = inargs.position;

switch FileType
    case {'.fcs','.fln'}
        switch inargs.img_type{iRun}
            case 'free2d_focus'
                img = import_raw(infile_full,inargs.dims(1),inargs.dims(2),768);
                S.img_data{1} = uint8(img.ch1/255); % always save 8-bit integers
                S.img_data{2} = uint8(img.ch2/255);
            otherwise
                img = import_raw(infile_full);
                S.img_data{1} = uint8(img.ch1/255); % always save 8-bit integers
                S.img_data{2} = uint8(img.ch2/255);
                % try to decode parts of header
        end
        % save bit-depth for later usage
        S.hdr.bits = 8;
    case '.tif'
        % TODO: new tif-import in separate file, return data cell array and
        % header info
        for m = 1:numel(infile)
            [FilePath,FileName,FileType] = fileparts(infile{m});
            if exist(infile{m},'file') ~= 2
                infile_full = fullfile(FilePath,[FileName FileType]);
                if exist(infile_full,'file') ~= 2
                    error('Could not find %s on absolute and relative paths',infile{iRun});
                end
            else
                infile_full = infile{iRun};
            end
            img =tiffread2_wrapper(infile_full);
            S.img_data{m} = img.data;
            S.hdr.tifHeader{m} = img.header;
            if ~isempty(strfind(infile_full,'channel00'))
                if exist(strrep(infile_full,'channel00','channel01'), 'file') == 2
                    img =tiffread2_wrapper(strrep(infile_full,'channel00','channel01'));
                    S.img_data{m+1} = img.data;
                    S.hdr.tifHeader{m+1} = img.header;
                end
                if exist(strrep(infile_full,'channel00','channel02'), 'file') == 2
                    img =tiffread2_wrapper(strrep(infile_full,'channel00','channel02'));
                    S.img_data{m+2} = img.data;
                    S.hdr.tifHeader{m+2} = img.header;
                end
            end
            clear img
            % additional files - AOD J90
            switch inargs.img_type{m}
                case {'aod_raps','aod_frame'}
                    dims = size(S.img_data{m});
                    % split up channels (assume 3 channels are stored)
                    FramesPerChannel = dims(3) / 3;
                    currentChannel = 1;
                    pos = 0;
                    switch inargs.img_type{m}
                        case {'aod_raps'}
                            imgData = {zeros(dims(1)*FramesPerChannel,dims(2))};
                        otherwise
                            imgData = {zeros(dims(1),dims(2),FramesPerChannel)};
                    end
                    imgData = repmat(imgData,1,3);
                    for frame = 1:dims(3)
                        if pos == FramesPerChannel
                            currentChannel = currentChannel + 1;
                            pos = 1;
                        else
                            pos = pos + 1;
                        end
                        switch inargs.img_type{m}
                            case {'aod_raps'}
                                imgData{currentChannel}((dims(1)*(pos-1))+1:dims(1)*pos,:) = ...
                                    S.img_data{m}(:,:,frame);
                            otherwise
                                imgData{currentChannel}(:,:,pos) = ...
                                    S.img_data{m}(:,:,frame);
                        end
                    end
                    S.img_data = imgData;
                    clear imgData
                    
                    if exist(strrep(infile_full,'.tif','_RAData.txt'), 'file') == 2
                        S.hdr.RAData = importdata(strrep(infile_full,'.tif','_RAData.txt'));
                    end
                    if exist(strrep(infile_full,'.tif','_FOV.png'), 'file') == 2
                        S.hdr.FOV = importdata(strrep(infile_full,'.tif','_FOV.png'));
                    end
            end
        end
        S.hdr.bits = 16;
    case '.lsm' % Zeiss LSM file format
        for m = 1:numel(infile)
            [FilePath,FileName,FileType] = fileparts(infile{m});
            if exist(infile{m},'file') ~= 2
                infile_full = fullfile(FilePath,[FileName FileType]);
                if exist(infile_full,'file') ~= 2
                    error('Could not find %s on absolute and relative paths',infile{iRun});
                end
            else
                infile_full = infile{iRun};
            end
            img = readLSMfile(infile_full);
            S.img_data{m} = img.data;
            S.hdr.tifHeader{m} = img.hdr;
            % header info
            S.hdr.bits = img.hdr.scaninf.BITS_PER_SAMPLE;
            S.hdr.frame_rate = 1./img.hdr.lsminf.TimeInterval;
            S.hdr.laserPower = img.hdr.scaninf.LASER_POWER;
            clear img
        end
    otherwise
        error('Unrecognized file type %s',FileType);
end

% creation date for infile
if ~iscellstr(infile_full)
   dummy{1} = infile_full;
   infile_full = dummy;
end
file_pars = dir(infile_full{1});
S.hdr.createDate = file_pars.date;

% other header info
S.hdr.size = size(S.img_data{1});
% if isempty(inargs.frame_rate)
%     S.hdr.rate = [];
%     if isfield(S.hdr,'tifHeader') && isfield(S.hdr.tifHeader{1,1},'info')
%         if isempty(strcmp(S.hdr.tifHeader{1,1}.info,'Failed to read XML header'))
%             S.hdr.rate = 1 / str2double(S.hdr.tifHeader{1,1}.info.TimeIncrement);
%         end
%     end
% else
%     S.hdr.rate = inargs.frame_rate(iRun);
% end
if isempty(inargs.zoom_factor)
    S.hdr.zoom = [];
else
    S.hdr.zoom = inargs.zoom_factor(iRun);
end
S.hdr.type = inargs.img_type{iRun};
S.hdr.fileorigin = infile{1};

% channel ID
S.hdr.channelID = cell(1,length(S.img_data));

S.hdr = orderfields(S.hdr);

% RoiSet decoder
if isempty(inargs.roi_set{iRun})
    S.roi = [];
elseif exist(inargs.roi_set{iRun}, 'file');
   S.roi = ij_roiDecoder(inargs.roi_set{iRun},[S.hdr.size(1) S.hdr.size(2)]);
   S.roi = ij_RoiSetCompression(S.roi,1);
elseif iscell(inargs.roi_set) && size(inargs.roi_set, 2) == 2;
    S.roi = inargs.roi_set;
end

% Stimulation
if isempty(inargs.stim{iRun})
    S.stim = [];
else
   S.stim = inargs.stim{iRun};
   % only display warning if stim is a vector, not a structure.
   if ~isstruct(S.stim) && length(S.stim) ~= S.hdr.size(3);
      warning('Stim vector length does not agree with timepoints for run %s',...
          int2str(iRun));
   end
end

if isfield(inargs,'ephys')
    S.ephys = inargs.ephys{iRun};
end

S = orderfields(S);

end

%% Preprocessing
function S = preprocStruct(inargs,n,S)
% Delete frame
if isempty(inargs.del_frame)
   if size(S.img_data{1},3) > 3
      del_frame = 1;
   else
       del_frame = 0;
   end
else
    del_frame = inargs.del_frame(n);
end
for channel = 1:length(S.img_data)
    switch inargs.img_type{n}
        case {'free2d_focus','aod_raps'}
            S.img_data{channel} = S.img_data{channel}(del_frame+1:end,:);
        otherwise
            S.img_data{channel} = S.img_data{channel}(:,:,del_frame+1:end);
    end
end
% adjust stimulus protocol
% if ~isempty(S.stim)
%     if isstruct(S.stim)
%         S.stim.vector(1:round(1/S.hdr.rate*del_frame*S.stim.rate)) = [];
%     elseif isvector(S.stim) % assume vector already converted to frames
%         S.stim = S.stim(del_frame+1:end);
%     end
% end
switch inargs.img_type{n}
    case 'free2d_focus'
        S.hdr.size(1) = S.hdr.size(1) - del_frame;
    otherwise
        if length(S.hdr.size) > 2
            S.hdr.size(3) = S.hdr.size(3) - del_frame;
        end
end
% adjust ephys
if isfield(S,'ephys')
    S.ephys.data(1:round(1/S.hdr.rate*del_frame*S.ephys.rate)) = [];
end

S.proc.DelFrame = del_frame;

% Bg. correct
if ~isempty(inargs.bgCorrect)
    method = inargs.bgCorrect{1};
    switch method
        case 'roi' % need to have inargs.bgCorrect{2} in roi set
            roiID = inargs.bgCorrect{2};
            if ~isempty(S.roi) && strcmp(S.roi(:,1),roiID)
                arg2 = bwunpack(S.roi{strcmp(S.roi(:,1),roiID),2});
            else
                error('Could not find Roi for bg. correction');
            end
        otherwise
            arg2 = inargs.bgCorrect{2};
    end
    for channel = 1:length(S.img_data)
        S.img_data{channel} = bg_subtract_HL(S.img_data{channel},arg2,...
            inargs.bgCorrect{3},method);
    end
end
S.proc.bgCorrect = inargs.bgCorrect;

S = orderfields(S);

end

%% save files
function saveFiles(currentS,SaveDir,args)
saveName = currentS.hdr.fileorigin;
[~, saveName, ext] = fileparts(saveName);
saveName_mean = fullfile(SaveDir,[saveName '__avg']);
saveName = fullfile(SaveDir,saveName);
saveName = strrep(saveName,'__channel00','');
% saveName_mean = strrep(saveName_mean,'__channel00','');
if currentS.hdr.bits == 8
    for n = 1:numel(currentS.img_data)
        currentS.img_data{n} = uint8(currentS.img_data{n});
    end
else
    for n = 1:numel(currentS.img_data)
        currentS.img_data{n} = uint16(currentS.img_data{n});
    end
end

% save mat-format
SaveAndAssignInBase(currentS,saveName,'SaveOnly');

% save average images
if isempty(strfind(args.img_type{1},'aod_raps'))
    mean_img = cell(1, numel(currentS.img_data));
    for n = 1:numel(currentS.img_data)
        chID = sprintf('ch%s',int2str(n));
        mean_img{n} = currentS.img_data{n};
        switch args.img_type{1}
            case 'free2d_focus'
                mean_img{n} = mean(mean_img{n});
                mean_img{n} = repmat(mean_img{n},numel(mean_img{n}),1);
            otherwise
                mean_img{n} = mean(mean_img{n},3);
        end
        if strcmp(ext,'.tif')
            avg_img.img = mean_img{n};
            chID = sprintf('channel%02.0f',n-1);
            currentSaveName_mean = strrep(saveName_mean,'channel00',chID);
            if isempty(strfind(args.img_type{1},'aod_frame'))
                write_to_tif(avg_img,currentSaveName_mean);
            end
        else
            avg_img.(chID) = mean_img{n}; % write below
        end
    end
end

% RGB merge (multi-channel only)
if ~strcmp(args.img_type{1},'aod_raps') && numel(mean_img) > 1
    if args.ColorVector(1)
        red = linScale(mean_img{args.ColorVector(1)});
    else
        red = zeros(size(mean_img{1}));
    end
    
    if args.ColorVector(2)
        green = linScale(mean_img{args.ColorVector(2)});
    else
        green = zeros(size(mean_img{1}));
    end
    
    if args.ColorVector(3)
        blue = linScale(mean_img{args.ColorVector(3)});
    else
        blue = zeros(size(mean_img{1}));
    end
    rgb.data = cat(3,red,green,blue);
    if isempty(strfind(saveName_mean,'channel00__'))
        currentSaveName_mean = [saveName_mean '_RGB'];
    else
        currentSaveName_mean = strrep(saveName_mean,'channel00__','RGB');
    end
    write_to_tif(rgb,currentSaveName_mean)
end

% save tiff-format (1 file per channel) for fcs files
if strcmp(strtrim(ext),'.fcs')
    for n = 1:length(currentS.img_data)
        chID = sprintf('ch%s',int2str(n));
        img.(chID) = currentS.img_data{n};
    end
    clear currentS
    write_to_tif(img,saveName,8); % save as 8-bit tiff
    saveName = [saveName '__avg'];
    write_to_tif(avg_img,saveName,8);
end;

end

%% Documentation
% 'RawFiles' - a cellstring with relative path to any of the supported input
% filetypes, supports several files, e.g. batch mode
% path should be relative to the RawDataDir path specified in the .config
% located in matlabroot\work (platform-independent)
% or full path to files (platform-dependent)
% for TIF files, mutliple channels are encoded in columns and multiple
% files in rows, e.g.: 
% {'file1_ch1.tif' 'file1_ch2.tif'; 'file2_ch1.tif' 'file2_ch2.tif'}
% 'frame_rate' - frame rate of the image acquisition (scalar or vector with
% 1 value per file)
% 'zoom' - zoom factor (scalar or vector)
% 'type' - cellstring with image type descriptions, e.g. 'stack', 'movie',
% 'frame' or 'linescan'
% 'RoiSet' - cellstring with full path to IJ RoiSet.zip files for all runs
%            OR ROISet cell array with 2 columns: names and ROIMasks
% 'SaveDir' - specifies directory for saving converted files (current
% directory is used if this is not specified)
% 'Stim' - stimulation info as cell array with one entry per run or one
% entry for all runs (default: empty)
% interpretation of the stimulation protocol depends on later routines,
% here we will only add the provided values to the structure
% 'animalID'
% 'spotID'
% 'zoom'
% 'laserPower'
% 'Position' - Position structure with fields of 'units' (e.g.
% 'pixel','um'), spotCoordinates (1x3 vector), refCoordinates (nx3 matrix),
% refID (cellstring with ID for n reference coordinates), specifiy NaN for
% coordinates that are not available - use makePositionStructure to create
% 'ephys' - ephys as cell array with one entry per run; provide ephys data
% structure for each run with (at least) two fields:
% ephys.data ... the recorded data as vector
% ephys.rate ... the sampling rate for ephys recording

% Preprocessing options
% 'DelFrame' - number of frames to delete (defaults to 0 for all images
% with 3 or less frames, otherwise defaults to 1), also apply to stim
% vector, if any, to size vector and to ephys, if any
% 'BgCorrect' - background correction specification as cell array with 
% {'method', param, plotFlag} --> applied with these parameters to all
% movies
% see bg_subtract_HL for details

