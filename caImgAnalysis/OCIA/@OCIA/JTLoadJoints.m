function JTLoadJoints(this, ~, ~)
% JTLoadJoints - [no description]
%
%       JTLoadJoints(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

loadTic = tic; % for performance timing purposes
showMessage(this, 'Loading joints ...', 'yellow');

% create load path
moviePath = DWGetFullPath(this, this.dw.selectedTableRows(1));
% extract file name and change extension
fileName = regexprep(regexp(moviePath, '/[^/]+$', 'match'), '\.[^\.]+$', '.mat');
day = this.dw.table{this.dw.selectedTableRows(1), 2};
loadPath = sprintf('%s%s%s', this.path.OCIASave, day, fileName{1});

if ~exist(loadPath, 'file');
    showWarning(this, 'OCIA:JT:JTLoadJoints:FileNotFound', ...
        sprintf('Cannot load joints from file "%s": file not found.', loadPath));
    return;
end;

% load data
data = load(loadPath, 'jointCoords');
dim = size(data.jointCoords);
this.jt.joints(1 : dim(1), 1 : dim(2), 1 : dim(3), 1 : dim(4)) = data.jointCoords;

% show message and update the display if necessary
showMessage(this, sprintf('Loading joints from "%s" done. (%.1f sec)', loadPath, toc(loadTic)));
if this.GUI.jt.iFrame; % if a frame was already set
    JTUpdateGUI(this);
    % set the focus to the frame setter
    uicontrol(this.GUI.handles.jt.frameSetter);
end;

end
