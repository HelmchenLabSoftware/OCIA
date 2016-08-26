    function ij_RoiSetSeedPointSegment(varargin)
% segment cell Rois from ImageJ single point RoiSet and save as new ImageJ
% RoiSet
% in1 ... configuration structure for this program 
% may be called without input arguments --> GUI file selection and default
% parameters (c.f. below)
% uses ActiveModel segmentation provided by Parametric Active Model Toolbox
% http://www.mathworks.ch/matlabcentral/fileexchange/22871
% (c) Copyright Bing Li 2005 - 2009.

% this file written by Henry Luetcke (hluetck@gmail.com)

%% Input and default parameters
if nargin
    config = varargin{1};
else
    config = struct;
end

config = ParseConfigStruct(config);

%% Do segmentation
for n = 1:length(config.roi_files)
    
    % support tiff only at this stage
    img = tif2mat(config.img_files{n},'nosave');
    img = img.data;
    img = mean(img,3);
    
    roiSet = ij_roiDecoder(config.roi_files{n},size(img));
    roiSet_seg = roiSet;
    
    % run segmentation for each point Roi
    for roi = 1:size(roiSet,1)
        point_mask = bwunpack(roiSet{roi,2});
        [x,y] = ind2sub(size(img),find(point_mask==1));
        if length(x) > 1
            warning('Found more than 1 point in Roi %s of RoiSet %s',...
                roiSet{roi,1},config.roi_files{n});
        elseif isempty(x) || isempty(y)
            warning('Found no points in Roi %s of RoiSet %s',...
                roiSet{roi,1},config.roi_files{n});
            roiSet_seg{roi} = [];
            continue
        end
        config.cog = [x y];
        roiSet_seg{roi,2} = ActiveModel_segment(img,config);
    end
    % save as new ImageJ RoiSet
    tmpdir = datestr(clock,30);
    mkdir(tmpdir);
    zip_filename = strrep(config.roi_files{n},'.zip','_Cells.zip');
    start_dir = pwd;
    cd(tmpdir);
    for roi = 1:size(roiSet_seg,1)
       status = ij_roiEncoder(roiSet_seg{roi,2},roiSet{roi,1});
    end
    % create neuropil Rois (either none or 4)
    if config.npil_rois
        roi_img = zeros(size(img));
        for roi = 1:size(roiSet_seg,1)
            roi_img(roiSet_seg{roi,2}==1) = 1;
        end
        roi1 = repmat(1,round(size(roi_img,1)/2),round(size(roi_img,2)/2));
        roi2 = repmat(2,size(roi_img,1)-round(size(roi_img,1)/2),...
            round(size(roi_img,2)/2));
        roi3 = repmat(3,round(size(roi_img,1)/2),size(roi_img,2)-...
            round(size(roi_img,2)/2));
        roi4 = repmat(4,size(roi_img,1)-round(size(roi_img,1)/2),...
            size(roi_img,2)-round(size(roi_img,2)/2));
        npil_rois = [roi1 roi3; roi2 roi4];
        npil_rois(roi_img~=0) = 0;
        for npil_no = 1:4
            roi = zeros(size(roi_img));
            roi(npil_rois==npil_no&img>20) = 1;
            status = ij_roiEncoder(roi,sprintf('n%1.0f.roi',npil_no));
            roiSet_seg{size(roiSet_seg,1)+1,1} = sprintf('n%1.0f.roi',npil_no);
            roiSet_seg{size(roiSet_seg,1),2} = roi;
        end
    end
    zip(zip_filename,roiSet_seg(:,1));
    [path, zip_filename] = fileparts(zip_filename);
    cd(start_dir);
    rmdir(tmpdir,'s');
    mat_filename = strrep(zip_filename,'.zip','.mat');
    roiSet = roiSet_seg;
    roiSet(:,1) = strrep(roiSet(:,1),'.roi','');
    save(mat_filename,'roiSet');
end


%% Parse config structure
function config = ParseConfigStruct(config)

% input file(s)
if ~isfield(config,'roi_files')
    [config.roi_files,PathName] = uigetfile('*.zip','MultiSelect','on');
    if isstr(config.roi_files)
       config.roi_files = {config.roi_files};
    end
    for n = 1:length(config.roi_files)
       config.roi_files{n} = fullfile(PathName,config.roi_files{n});
    end
elseif isstr(config.roi_files)
    config.roi_files = {config.roi_files};
end

if ~isfield(config,'img_files')
   [config.img_files,PathName] = uigetfile({'*.tif';'*.tiff'},'MultiSelect','on');
   if isstr(config.img_files)
       config.img_files = {config.img_files};
    end
    for n = 1:length(config.img_files)
       config.img_files{n} = fullfile(PathName,config.img_files{n});
    end
elseif isstr(config.img_files)
    config.img_files = {config.img_files};
end

if length(config.roi_files) ~= length(config.img_files)
   error('You MUST specify the same number of image and roi files!');
end

% required field names and their values
config_fields = {'cellsize' 'snake_iter1' 'snake_iter' ...
    'alpha' 'beta' 'tau' 'filt_range' 'filt_order' 'canny_lo' ...
    'canny_hi' 'alt_radius' 'npil_rois' 'doPlot' 'verbosity'};
config_vals = {7 100 10 1 0 0.1 [3 3] 1 [0.1 0.05 0.01] ...
    [0.25 0.15 0.05] 3 0 0 0};

for n = 1:length(config_fields)
    if ~isfield(config,config_fields{n})
        config.(config_fields{n}) = config_vals{n};
    end
end
config_savename = ['AMsegment_config.html'];
print2html(config,5,config_savename);
config_savename = strrep(config_savename,'.html','.mat');
save(config_savename,'config');
config_savename = strrep(config_savename,'.mat','');
fprintf('\nCurrent configuration saved in %s\n',config_savename);






% e.o.f.
