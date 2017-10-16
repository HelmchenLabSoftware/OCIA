function mFrames = wt_load_avi(sFile, vFrames, varargin)
% WT_LOAD_AVI
% Load specified range of frames from an AVI movie
% wt_load_avi(FILENAME, FRAMES, OPTION), where
%  FILENAME is the path and name of the AVI file
%  FRAMES   is a vector that contains framenumbers to be loaded
%  OPTION   is an optional parameter, that can be:
%     'none'      no option
%     'noresize'  don't resize frames

warning off MATLAB:mat2cell:ObsoleteSingleInput

% Access global namespace
global g_tWT

if ~isempty(varargin), sOption = varargin{1};
else, sOption = 'none'; end

% Load frames
try
    if isempty(vFrames), tFrames = aviread(sFile);
    else,tFrames = aviread(sFile, vFrames); end
catch
    wt_error(lasterr)
end

% Remove colormap data
tFrames = rmfield(tFrames, 'colormap');

M = size(tFrames(1).cdata,1); % image width
N = size(tFrames(1).cdata,2); % image height
P = size(tFrames(1).cdata,3); % number of dimensions in cdata
Q = size(tFrames, 2);         % number of frames

try
    if P == 3
        tmp = struct2cell(tFrames);
        for t = 1:length(tmp)
            tmp2 = cell2mat(tmp(t));
            tmp(t) = mat2cell(squeeze(tmp2(:,:,1)));
        end
        mFrames = reshape(cell2mat(tmp), [M N 1 Q]); % transform from struct to matrix
    elseif P == 1
        mFrames = reshape(cell2mat(struct2cell(tFrames)), [M N P Q]); % transform from struct to matrix   
    end
catch, wt_error(lasterr), end

mFrames = squeeze(mFrames(:,:,1,:)); % reduce RGB to monochrome


return
