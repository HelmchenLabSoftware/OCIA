function JTSaveJoints(this, ~, ~)
% JTSaveJoints - [no description]
%
%       JTSaveJoints(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

saveTic = tic; % for performance timing purposes
showMessage(this, 'Saving joints ...', 'yellow');

% get what to save
jointCoords = this.jt.joints; %#ok<NASGU>

% save joints data as a file with the same name and a different extension
moviePath = this.path.moviePath;
savePath = regexprep(moviePath, '\.[^\.]+$', '.mat');
save(savePath, 'jointCoords');

% % create save directory path and save path
% moviePath = DWGetFullPath(this, this.dw.selectedTableRows(1));
% % extract file name and change extension
% fileName = regexprep(regexp(moviePath, '/[^/]+$', 'match'), '\.[^\.]+$', '.mat');
% day = this.dw.table{this.dw.selectedTableRows(1), 2};
% saveDirPath = sprintf('%s%s', this.path.OCIASave, day);
% savePath = sprintf('%s%s', saveDirPath, fileName{1});

% % create save directory if not existing and save data
% if exist(saveDirPath, 'dir') ~= 7; mkdir(saveDirPath); end;
% save(savePath, 'jointCoords');

showMessage(this, sprintf('Saving joints to "%s" done. (%.1f sec)', savePath, toc(saveTic)));

% set the focus to the frame setter
uicontrol(this.GUI.handles.jt.frameSetter);

end
