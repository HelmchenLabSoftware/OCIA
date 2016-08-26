function INSavePlot(this, savePath, plotToSave, varargin)
% INSavePlot - [no description]
%
%       INSavePlot(this, savePath, plotToSave, varargin)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% if no save path has been provided, create a dialog to request one
if isempty(savePath);
    % create the folder if it does not exist yet
    if exist(this.path.OCIASave, 'dir') ~= 7; mkdir(this.path.OCIASave); end;
    % create the dialog
    [saveName, savePath] = uiputfile('*.*', 'Select a path where to save the plot', this.path.OCIASave);
    if ischar(saveName)
        savePath = [savePath saveName];
        saveName = regexprep(saveName, '(\.\w{3})?$', '');
    else % otherwise abort the saving
        return;
    end;
else
    saveName = savePath;
end;
% clean up path and show message
savePath = strrep(savePath, '\', '/');
showMessage(this, sprintf('Saving intrinsic plot to "%s" ...', savePath), 'yellow');
saveTic = tic; % for performance timing purposes

figName = saveName;
saveFig = figure('Name', figName, 'NumberTitle', 'off', 'Color', 'white', 'Units', 'pixels', ...
    'Position', get(this.GUI.figH, 'Position'), 'Visible', 'off', 'MenuBar', 'none', 'Toolbar', 'none');

anAxe = this.GUI.in.fouSubAxeHands.(plotToSave);
inPanelChild = get(get(anAxe, 'Parent'), 'Children');
% gather everything that doesn't belong to the Intrinsic panel's GUI (buttons)
inPanelChild(~cellfun(@isempty, regexp(get(inPanelChild, 'Tag'), '^IN')) & inPanelChild ~= anAxe) = [];

% if the panel has no child or only the Intrinsic's axe but it's hidden, then do not save anything
if isempty(inPanelChild) || (numel(inPanelChild) == 1 && inPanelChild(1) == anAxe && strcmp(get(anAxe, 'Visible'), 'off'));
    showWarning(this, 'OCIA:INSavePlot:NothingToSave', ...
        sprintf('Cannot save analyser plot "%s" to "%s" because there is no plot to save.', figName, savePath));
    return;
end;

% copy objects one by one starting from the last one
for iObj = fliplr(1 : numel(inPanelChild));
    removeCallbacks(inPanelChild(iObj));
    copyobj(inPanelChild(iObj), saveFig);
end;

% copy the colormap
set(saveFig, 'Colormap', get(this.GUI.figH, 'Colormap'));

saveFolder = regexprep(savePath, '/[\w\.]+$', '');
if exist(saveFolder, 'dir') ~= 7; mkdir(saveFolder); end;

% get extension
ext = regexprep(regexp(savePath, '\.(\w+)$', 'match'), '^\.', '');
% if extension is supported by the export_fig function, use that
if ~isempty(ext) && ~strcmp(ext, 'fig') && ~isempty(regexp(ext, 'png|pdf|jpg|eps|tif|bmp', 'once'));
    if numel(varargin) > 0 && isnumeric(varargin{1});
        resolution = sprintf('-r%d', varargin{1});
    else
    	resolution = '-r150';
    end;
    if numel(varargin) > 1 && strcmpi(varargin{2}, 'noCrop');
        export_fig(savePath, ['-' ext], resolution, '-nocrop', saveFig);
    else
        export_fig(savePath, ['-' ext], resolution, saveFig);
    end;
    
% otherwise save as figure
else                      
    savePath = [regexprep(savePath, ['\.' ext '$'], ''), '.fig'];
    set(saveFig, 'Visible', 'on');
    saveas(saveFig, savePath);
    
end;
close(saveFig);

showMessage(this, sprintf('Saving analyser plot to "%s" done (%.3f sec).', savePath, toc(saveTic)));
    
end

function removeCallbacks(elem)
    if isprop(elem, 'Callback'); set(elem, 'Callback', []); end;
    if isprop(elem, 'ButtonDownFcn'); set(elem, 'ButtonDownFcn', []); end;
    childElems = get(elem, 'Children');
    for iElem = 1 : numel(childElems);
        removeCallbacks(childElems(iElem));
    end;
end
