function varargout = ConvertRawData(varargin)
% inputs: no need to specify any inputs --> GUI-based file selection
% optional input arguments, specified as 'property' 'value' pair in
% arbitrary order, e.g. 'zoom',1.07 OR as a structure with properties as
% field names and values, e.g. config.zoom = 1.07
% for a full list of supported arguments see the end of this file

% License: this file may only be used with agreement to the license terms
% outlined in the accompanying license.txt
% if you do not agree with these terms, you MUST NOT use this file or any
% part thereof in any way

% this file written by Henry Luetcke (hluetck@gmail.com)

% current version: 2010-04-14

%% Main

RawDataDir = getGlobalParameters('RawDataDir');
if ~RawDataDir
   error('Raw data directory MUST be specified');
end

args = parseInputArgs(varargin);
if min(size(args.RawFiles)) > 1
    runs = size(args.RawFiles,1);
else
    runs = length(args.RawFiles);
    % make sure runs are in columns
    args.RawFiles = reshape(args.RawFiles,numel(args.RawFiles),1);
end

for n = 1:runs
    % create structure
    currentS = initStruct(args,n,RawDataDir);
    
    % preprocess image data
    currentS = preprocStruct(args,n,currentS);
    
    % save files
    saveFiles(currentS,args.SaveDir);
    
    S{n} = currentS;
end

if nargout
   varargout{1} = S;
end


%% Parse inputs
function S = parseInputArgs(inargs)
if ~isempty(inargs) && isstruct(inargs{1})
    % convert structure to pseudo-input cellarray
    inargs = struct2cellArray(inargs{1});
end
RawDataDir = getGlobalParameters('RawDataDir');
% input files
SpInput = find(strcmpi(inargs, 'RawFiles'));
if numel(SpInput)
    RawFiles = inargs{SpInput+1};
    if ~iscellstr(RawFiles)
        error('Modifier for raw files property must be a cell string');
    end
else
    [FileName,PathName,FilterIndex] = uigetfile({'*.fcs';'*.tif';'*.tiff'},...
        'Select raw file(s) to import','MultiSelect','on');
    if ~iscellstr(FileName)
        FileName = {FileName};
    end
    if ~FileName{1}; return; end
    if ~iscellstr(FileName); FileName = cellstr(FileName); end
    if strfind(PathName,RawDataDir)
       PathName = strrep(PathName,RawDataDir,'');
    end
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
    frame_rate = [];
end
S.frame_rate = frame_rate;
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
S.zoom_factor = zoom_factor;
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
    img_type = cell(1,length(RawFiles));
end
S.img_type = img_type;
% Roi set
SpInput = find(strcmpi(inargs, 'RoiSet'));
if numel(SpInput)
    roi_set = inargs{SpInput+1};
    if ~iscellstr(roi_set); roi_set = cellstr(roi_set); end
    if length(roi_set) == 1
        roi_set = repmat(roi_set,1,length(RawFiles));
    elseif length(roi_set) ~= length(RawFiles)
        error('RoiSet must be a cell string of length 1 or input file number');
    end
else
    roi_set = cell(1,length(RawFiles));
end
S.roi_set = roi_set;
% Stimulus
SpInput = find(strcmpi(inargs, 'Stim'));
if numel(SpInput)
    stim = inargs{SpInput+1};
    if ~iscell(stim); stim = {stim}; end
    if length(stim) == 1
        stim = repmat(stim,1,length(RawFiles));
    elseif length(stim) ~= length(RawFiles)
        error('Stimulation must be a cell array of length 1 or input file number');
    end
else
    stim = cell(1,length(RawFiles));
end
S.stim = stim;
% Output directory
SpInput = find(strcmpi(inargs, 'SaveDir'));
if numel(SpInput)
    SaveDir = inargs{SpInput+1};
    if exist(SaveDir,'dir') ~= 7
       try
          mkdir(SaveDir);
       catch
           error('Failed to create directory %s',SaveDir);
       end
    end
else
    SaveDir = pwd;
end
S.SaveDir = SaveDir;

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
S.del_frame = del_frame;
% bg. correction
SpInput = find(strcmpi(inargs, 'BgCorrect'));
if numel(SpInput)
    bgCorrect = inargs{SpInput+1};
else
    bgCorrect = [];
end
S.bgCorrect = bgCorrect;

%% Structure initialization
function S = initStruct(inargs,n,RawDataDir)
infile = inargs.RawFiles(n,:);
[FilePath,FileName,FileType] = fileparts(infile{1});
% if the file cannot be found with the absolute path, try the relative path
% instead
if exist(infile{1},'file') ~= 2
    infile_full = fullfile(RawDataDir,FilePath,[FileName FileType]);
    if exist(infile_full,'file') ~= 2
       error('Could not find %s on absolute and relative paths',infile_full);
    end
else
    infile_full = infile;
end

switch FileType
    case '.fcs'
        img = import_raw(infile_full);
        S.img_data{1} = uint8(img.ch1/255); % always save 8-bit integers
        S.img_data{2} = uint8(img.ch2/255);
        % try to decode parts of header
        
        % save bit-depth for later usage
        S.bits = 8;
    case '.tif'
        % TODO: new tif-import in separate file, return data cell array and
        % header info
        for n = 1:numel(infile)
            [FilePath,FileName,FileType] = fileparts(infile{n});
            if exist(infile{n},'file') ~= 2
                infile_full = fullfile(RawDataDir,FilePath,[FileName FileType]);
                if exist(infile_full,'file') ~= 2
                    error('Could not find %s on absolute and relative paths',infile{n});
                end
            else
                infile_full = infile{n};
            end
            img =tiffread2_wrapper(infile_full);
            S.img_data{n} = img.data;
            S.hdr.tifHeader{n} = img.header;
            if exist(strrep(infile_full,'channel00','channel01')) == 2
                img =tiffread2_wrapper(strrep(infile_full,'channel00','channel01'));
                S.img_data{n+1} = img.data;
                S.hdr.tifHeader{n+1} = img.header;
            end
            if exist(strrep(infile_full,'channel00','channel02')) == 2
                img =tiffread2_wrapper(strrep(infile_full,'channel00','channel02'));
                S.img_data{n+2} = img.data;
                S.hdr.tifHeader{n+2} = img.header;
            end
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
if isempty(inargs.frame_rate)
    S.hdr.rate = [];
else
    S.hdr.rate = inargs.frame_rate(n);
end
if isempty(inargs.zoom_factor)
    S.hdr.zoom = [];
else
    S.hdr.zoom = inargs.zoom_factor(n);
end
S.hdr.type = inargs.img_type{n};
S.hdr.fileorigin = infile{1};

% channel ID
S.hdr.channelID = cell(1,length(S.img_data));

S.hdr = orderfields(S.hdr);

% RoiSet decoder
if isempty(inargs.roi_set{n})
    S.roi = [];
else
   S.roi = ij_roiDecoder(inargs.roi_set{n},[S.hdr.size(1) S.hdr.size(2)]);
end

% Stimulation
if isempty(inargs.stim{n})
    S.stim = [];
else
   S.stim = inargs.stim{n};
   if length(S.stim) ~= S.hdr.size(3)
      warning('Stim vector length does not agree with timepoints for run %s',...
          int2str(n));
   end
end


S = orderfields(S);

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
    S.img_data{channel} = S.img_data{channel}(:,:,del_frame+1:end);
    if ~isempty(S.stim) && channel == 1
       S.stim = S.stim(del_frame+1:end);
       S.hdr.size(3) = S.hdr.size(3) - del_frame;
    end
end
S.proc.DelFrame = del_frame;

% Bg. correct (on movies only)
if ~isempty(inargs.bgCorrect) && strcmp(S.hdr.type,'movie')
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

%% save files
function saveFiles(currentS,SaveDir)
saveName = currentS.hdr.fileorigin;
[PathName,saveName,ext] = fileparts(saveName);
saveName_mean = fullfile(SaveDir,['avg_' saveName]);
% saveName = fullfile(SaveDir,saveName);
% save mat-format
currentDir = pwd;
cd(SaveDir)
SaveAndAssignInBase(currentS,genvarname(saveName),'SaveOnly');
cd(currentDir)

% save tiff-format (1 file per channel)
if ~strcmp(ext,'.tif')
    for n = 1:length(currentS.img_data)
        chID = sprintf('ch%s',int2str(n));
        img.(chID) = currentS.img_data{n};
        if n == 1 % save average image for first channel only
            mean_img = img.(chID);
            mean_img = mean(mean_img,3);
            avg_img.img = mean_img;
            write_to_tif(avg_img,saveName_mean,8);
        end
    end
    clear currentS
    write_to_tif(img,saveName,8); % save as 8-bit tiff
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
% 'SaveDir' - specifies directory for saving converted files (current
% directory is used if this is not specified)
% 'Stim' - stimulation info as cell array with one entry per run or one
% entry for all runs (default: empty)
% interpretation of the stimulation protocol depends on later routines,
% here we will only add the provided values to the structure


% Preprocessing options
% 'DelFrame' - number of frames to delete (defaults to 0 for all images
% with 3 or less frames, otherwise defaults to 1), also apply to stim
% vector, if any and to size vector
% 'BgCorrect' - background correction specification as cell array with 
% {'method', param, plotFlag} --> applied with these parameters to all
% movies
% see bg_subtract_HL for details
% 

