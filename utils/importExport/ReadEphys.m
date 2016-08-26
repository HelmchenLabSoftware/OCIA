function [ephys,FrameClock] = ReadEphys(varargin)
% read binary data files written by LabView E-phys acquisition program in
% H45
% requires file name of file to read and number of timepoints
% returns e-phys trace and frame clock

% this file written by Henry Luetcke (hluetck@gmail.com)
if nargin == 2
    filename = varargin{1};
    timepoints = varargin{2};
elseif nargin == 1
    filename = varargin{1};
    timepoints = getTimePointDialog;
else
    [FileName, PathName] = uigetfile('*.*','Select file for reading');
    filename = fullfile(PathName,FileName);
    timepoints = getTimePointDialog;
end
fid = fopen(filename);
if ~timepoints
    % read till end of file, FrameClock empty
%     hdr1 = fread(fid,96,'float32','ieee-be');
    ephys = fread(fid,'float32','ieee-be');
    FrameClock = [];
else
    hdr1 = fread(fid,96,'float32','ieee-be');
    ephys = fread(fid,timepoints,'float32','ieee-be');
    hdr2 = fread(fid,96,'float32','ieee-be');
    FrameClock = fread(fid,timepoints,'float32','ieee-be');
end
fclose(fid);

function timepoints = getTimePointDialog
prompt = {'Timepoints in file:'};
dlg_title = 'Specify timepoints';
num_lines = 1;
answer = inputdlg(prompt,dlg_title,num_lines,{''});
timepoints = str2double(answer{1});