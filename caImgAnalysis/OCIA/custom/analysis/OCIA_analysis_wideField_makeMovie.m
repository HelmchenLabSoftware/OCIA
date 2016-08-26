function OCIA_analysis_wideField_makeMovie(this, ~, ~)
% OCIA_analysis_wideField_makeMovie - [no description]
%
%       OCIA_analysis_wideField_makeMovie(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

iFrameHandle = this.GUI.handles.an.paramPanElems.iFrame;

iFrameMin = get(iFrameHandle, 'Min');
iFrameMax = get(iFrameHandle, 'Max');

nFrames = iFrameMax - iFrameMin + 1;

pos = [5, 125, 1170, 515];

frames(nFrames) = struct('cdata', [], 'colormap', []);
for iFrame = 1 : nFrames;
    set(iFrameHandle, 'Value', iFrame);
    frames(iFrame) = getframe(this.GUI.figH, pos);
end

frameRate = 10;

% fig = figure('Position', [10, 10, pos(3:4) .* 1.05]);
% movie(fig, frames, 1, frameRate);

iFile = get(this.GUI.handles.an.rowList, 'Value');
files = dir([this.path.intrSave '*.h5']);
if isempty(files); files = struct('name', 'unknown.h5'); end;
if numel(files) < iFile; files(iFile) = files(1); end;
fileName = files(iFile).name;

% vwh = VideoWriter([this.path.OCIASave, regexprep(fileName, '\.h5', '_trialMapsMovie.avi')]);
vwh = VideoWriter([this.path.OCIASave, regexprep(fileName, '\.h5', '_movie.avi')]);
set(vwh, 'FrameRate', frameRate);
open(vwh);
for iFrame = 1 : nFrames;
    writeVideo(vwh, frames(iFrame));
end;
close(vwh);
