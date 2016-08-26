function varargout = PlotRoiTimecourse(varargin)
% plot timecourses of Rois in RoiSet
% in1 ... fcs-file / cell-array of tiff-files (max. 2)
% in2 ... RoiSet
% returns structure with fields time (adjusted by Roi location), stats type
% and value and roi ID
% return time axis in varargout{1}
% return timeseries as cell in varargout{2}
% return Roi IDs as cell in varargout{3}

% this file written by Henry Luetcke (hluetck@gmail.com)

filename = varargin{1};
roifile = varargin{2};


%% Parameters
% imaging frequency
freq = 7.81;
% no. of slices to delete
del_slice = 1;
% bg. threshold in percentile
bg_thresh = 1;
% smoothing span (0 for none)
% smoothing is performed by local regression using weighted linear least
% squares and a 2nd degree polynomial model
% span is provided in percentage of total number of data points (<=1)
smooth_span = 0;
% highpass filter cutoff in Hz (0 for none)
% this is an experimental highpass filter that works in the fourier domain
% and attemts to remove frequency components slower than the cutoff
hp_cutoff = 0;

% run single channel analysis on channel 2
SwitchChannels = 0;

% type of stats image ('none','dff','drr')
stats_type = 'drr';
ts.stats_type = stats_type;
switch stats_type
    case 'none'
        stats_type = 1;
    case 'drr'
        stats_type = 2;
    case 'dff'
        stats_type = 3;
end
% baseline (e.g. no. of baseline frames)
base = 10;
% stimulus description in vector format (0 0 0 1 1 0 0 ...)
% empty to use base frames for stats calculation
stim_vector = [];

%% Load data and preprocess
if ~isnumeric(filename)
    if ~iscellstr(filename)
        files{1} = filename;
    else
        files = filename;
    end
    
    
    % figure title
    fig_title = strrep(files{1},'.fcs','');
    fig_title = strrep(fig_title,'.tif','');
    
    if ~isempty(strfind(files{1},'.fcs'))
        img = import_raw(filename);
    else
        img_data = tif2mat(files{1},'nosave');
        img.ch1 = img_data.data;
        if length(files) > 1
            img_data = tif2mat(files{2},'nosave');
            img.ch2 = img_data.data;
            clear img_data
        end
    end
else
    fig_title = 'workspace variable';
    img.ch1 = filename;
end
pixel_time = (1/freq)/(size(img.ch1,1)*size(img.ch1,2));
% load roi set
if ~iscell(roifile)
    roi_set = ij_roiDecoder(roifile,[size(img.ch1,1) size(img.ch1,2)]);
else
    roi_set = roifile;
    % format from roi timecourse extractor???
    if size(roi_set,2) == 3
        for n = 1:size(roi_set,1)
           a = zeros(roi_set{n,2});
           for m = 1:size(roi_set{n,3})
              a(roi_set{n,3}(m)) = 1;
           end
           roi_set{n,4} = bwpack(a);
        end
        roi_set(:,2:3) = [];
    end
end

% background Rois are named bg.roi
if sum(strcmp(roi_set(:,1),'bg.roi'))
    bg_mask = bwunpack(roi_set{strcmp(roi_set(:,1),'bg.roi'),2});
    roi_set(strcmp(roi_set(:,1),'bg.roi'),:)=[];
else
    bg_mask = [];
end

% big bad coding practice disregard here
% switch channels
% this can be used to do single channel analysis on channel 2
if SwitchChannels
    img.ch1 = img.ch2;
    warning('Switched channels 1 and 2. Now evaluating channel 2.');
end

if isempty(bg_mask)
    img.ch1 = double(PreprocImageData(img.ch1,del_slice,bg_thresh));
else
    img.ch1 = double(PreprocImageData(img.ch1,del_slice,bg_mask));
end
if stats_type == 2
    if isempty(bg_mask)
        img.ch2 = double(PreprocImageData(img.ch2,del_slice,bg_thresh));
    else
        img.ch2 = double(PreprocImageData(img.ch2,del_slice,bg_mask));
    end
else
    if isfield(img,'ch2')
        img = rmfield(img,'ch2');
    end
end
[dur,time] = gui_CalculateTimeVector(1:size(img.ch1,3),freq,[]);


figure('Name',fig_title,'NumberTitle','off'); hold all

for n = 1:size(roi_set,1)
    fprintf('\nRoi %s\n',roi_set{n,1});
    mask = bwunpack(roi_set{n,2});
    ts.ch1{n} = mean(GetRoiTimeseries(img.ch1,mask),1);
    if stats_type == 2
        ts.ch2{n} = mean(GetRoiTimeseries(img.ch2,mask),1);
        % calculate DRR
        stats = ts.ch1{n} ./ ts.ch2{n};
    elseif stats_type == 1 || stats_type == 3
        stats = ts.ch1{n};
    end
    if stats_type == 2 || stats_type == 3
        % estimate baseline values (according to stimulus protocol)
        % without stim. protocol, choose first 10 timepoints
        f0_mat = CalculateF0(stats,stim_vector,base);
        % calculate stats
        stats = ((stats-f0_mat) ./ f0_mat).* 100;
        stats(stats==Inf) = 0;
        stats(stats==-Inf) = 0;
        stats(stats==NaN) = 0;
    end
    % smoothing
    if smooth_span
        stats = smooth(stats,smooth_span,'loess');
    end
    % highpass filter
    if hp_cutoff
        stats = mpi_BandPassFilterTimeSeries(stats,1/freq,hp_cutoff,freq*2);
    end
    ca_shift = mean(find(mask'==1)) * pixel_time;
    ca_shift = (1/freq) - ca_shift;
    ts.time{n} = time - ca_shift;
    fprintf('\nAdjusted Roi time by %1.2f frames based on mean ROI location\n',...
        ca_shift/(1/freq));
    ts.stats{n} = stats;
    ts.roi_id{n} = roi_set{n,1};
    plot(ts.time{n},stats);
    clear stats
end

legend(ts.roi_id);

varargout{1} = ts;


%% Image preprocessing
function img_data = PreprocImageData(img_data,del_slice,bg_thresh)
% in1 ... raw image matrix
% in2 ... number of initial slices to delete
% in3 ... background subtraction threshold (percentile)
img_data(:,:,1:del_slice) = [];
if max(reshape(img_data,1,numel(img_data))) > 256
    img_data = img_data./255;
end
img_data = uint8(img_data);
if ~isempty(bg_thresh)
    if size(bg_thresh,1) > 1
        img_data = bg_subtract_HL(img_data,bg_thresh,1,'roi');
    else
        img_data = bg_subtract_HL(img_data,bg_thresh,1,'percentile');
    end
end
img_data(img_data<0)=0;

function f0_mat = CalculateF0(roi_mat,stim,base)
if isempty(stim)
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


