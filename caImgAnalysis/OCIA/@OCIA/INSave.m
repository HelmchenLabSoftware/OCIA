function INSave(this, savePath)
% INSave - [no description]
%
%       INSave(this, savePath)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% if no save path provided, generate it
if isempty(savePath);
    % get the save path
    savePath = sprintf('%s%s.mat', this.path.intrSave, INGetSaveName(this));
end;

% check if a file already exists
if exist(savePath, 'file');
    % open a confirmation dialog
    doOverWrite = questdlg(sprintf('Intrinsic saving: an existing file has been found at "%s". Do you want to overwrite it?', ...
        savePath), '/!\ Warning !', 'Yes', 'No', 'No');    
    % if the decision is to not overwrite
    if ~strcmp(doOverWrite, 'Yes');
        showMessage(this, sprintf('Intrinsic: *NOT* overwriting file at "%s". Saving aborted !', savePath), 'red');        
        return;        
    end;
    
    showMessage(this, sprintf('Intrinsic: overwriting file at "%s" ...', savePath), 'yellow');
    pause(0.1);
end;

% create directory if it does not exist
if exist(this.path.intrSave, 'dir') ~= 7; mkdir(this.path.intrSave); end;

% create the save structure
intrSave = struct();
intrSave.data = this.in.data;
% erase useless stuff
if strcmp(this.in.expMode, 'standard');
    intrSave.data.baseline1Frames = {};
    intrSave.data.baseline2Frames = {};
    intrSave.data.stimulusFrames = {};
elseif strcmp(this.in.expMode, 'fourier');
    intrSave.data.baseline1Frames = {};
    intrSave.data.baseline2Frames = {};
    intrSave.data.baselineDFFAvg = {};
    intrSave.data.stimulusDFFAvg = {};
    intrSave.data.includeInAverage = {};
end;
% remove useless params
intrSave.params = this.in;
if isfield(intrSave.params, 'daq');
    if isfield(intrSave.params.daq, 'sessHandle');
        intrSave.params = rmfield(intrSave.params.daq, 'sessHandle');
    end;
end;
rmParams = { 'data', 'camH', 'RP', 'audioplayer' };
for iParam = numel(rmParams);
    if isfield(intrSave, rmParams{iParam});
        intrSave = rmfield(intrSave, rmParams{iParam});
    end;
end;
if ~isempty(this.GUI.in.ROIHandle);
    intrSave.params.ROIPos = this.GUI.in.ROIHandle{1}.getPosition(); %#ok<STRNU>
end;


s = whos('intrSave');
sizeInMegaBytes = s.bytes / 1024 / 1024;

showMessage(this, sprintf('Intrinsic: saving intrinsic data to "%s" (~%.1f MB) ...', savePath, sizeInMegaBytes), 'yellow');  
pause(0.1);

% save the file
save(savePath, 'intrSave');

showMessage(this, sprintf('Intrinsic: saving intrinsic data to "%s" done !', savePath));

end
