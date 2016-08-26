function ANSavePlot(this, savePath, varargin)
% ANSavePlot - [no description]
%
%       ANSavePlot(this, savePath, varargin)
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
showMessage(this, sprintf('Saving analyser plot to "%s" ...', savePath), 'yellow');
saveTic = tic; % for performance timing purposes

figName = saveName;
if numel(varargin) > 0 && ~isempty(varargin{1}); figName = varargin{1}; end;
saveFig = figure('Name', figName, 'NumberTitle', 'off', 'Color', 'white', 'Units', 'pixels', ...
    'Position', get(this.GUI.figH, 'Position'), 'Visible', 'off', 'MenuBar', 'none', 'Toolbar', 'none');

anAxe = this.GUI.handles.an.axe;
anPanelChild = get(this.GUI.handles.panels.AnalyserPanel, 'Children');
% gather everything that doesn't belong to the Analyser panel's GUI (buttons)
anPanelChild(~cellfun(@isempty, regexp(get(anPanelChild, 'Tag'), '^AN')) & anPanelChild ~= anAxe) = [];

% if the panel has no child or only the Analyser's axe but it's hidden, then do not save anything
if isempty(anPanelChild) || (numel(anPanelChild) == 1 && anPanelChild(1) == anAxe && strcmp(get(anAxe, 'Visible'), 'off'));
    % get the empty or hidden plot reason
    statusTextReason = get(this.GUI.handles.an.message, 'String');
    if isempty(statusTextReason); statusTextReason = 'unknown'; end;
    statusTextReason(1) = lower(statusTextReason(1));
    statusTextReason = regexprep(statusTextReason, '\.$', '');
    % show warning
    showWarning(this, 'OCIA:ANSavePlot:NothingToSave', ...
        sprintf('Cannot save analyser plot "%s" to "%s" because there is no plot to save. Possible cause: %s.', ...
        figName, savePath, statusTextReason));
    return;
end;

if ~verLessThan('matlab', '8.4.0');
    
    % remove colorbar if a legend is present because of weird saving system
    if any(arrayfun(@(i)isa(i, 'matlab.graphics.illustration.ColorBar'), anPanelChild)) ...
        && any(arrayfun(@(i)isa(i, 'matlab.graphics.illustration.Legend'), anPanelChild));
        anPanelChild(arrayfun(@(i)isa(i, 'matlab.graphics.illustration.ColorBar'), anPanelChild)) = [];
    end;
    
    % copy objects one by one starting from the last one
    for iObj = fliplr(1 : numel(anPanelChild));
        % do not copy axes if next one is a colorbar
        if isa(anPanelChild(iObj), 'matlab.graphics.axis.Axes') && iObj > 1 ...
                && (isa(anPanelChild(iObj - 1), 'matlab.graphics.illustration.ColorBar') ...
                ||  isa(anPanelChild(iObj - 1), 'matlab.graphics.illustration.Legend'));
            continue;
        % copy colorbar AND its axes
        elseif isa(anPanelChild(iObj), 'matlab.graphics.illustration.ColorBar') && iObj < numel(anPanelChild) ...
            && isa(anPanelChild(iObj + 1), 'matlab.graphics.axis.Axes');
            removeCallbacks(anPanelChild(iObj));
            removeCallbacks(anPanelChild(iObj + 1));
            copyobj([anPanelChild(iObj), anPanelChild(iObj + 1)], saveFig);
        % copy legend AND its axes
        elseif isa(anPanelChild(iObj), 'matlab.graphics.illustration.Legend') && iObj < numel(anPanelChild) ...
            && isa(anPanelChild(iObj + 1), 'matlab.graphics.axis.Axes');
            removeCallbacks(anPanelChild(iObj));
            removeCallbacks(anPanelChild(iObj + 1));
            copyobj([anPanelChild(iObj), anPanelChild(iObj + 1)], saveFig);
        else
            % do not copy invisible stuff
            if strcmp(get(anPanelChild(iObj), 'Visible'), 'off'); continue; end;
            removeCallbacks(anPanelChild(iObj));
            copyobj(anPanelChild(iObj), saveFig);
        end;
    end;
else
    % copy objects one by one starting from the last one
    for iObj = fliplr(1 : numel(anPanelChild));
        removeCallbacks(anPanelChild(iObj));
        copyobj(anPanelChild(iObj), saveFig);
    end;
end;

% copy the colormap
set(saveFig, 'Colormap', get(this.GUI.figH, 'Colormap'));

saveFolder = regexprep(savePath, '/[\w\.]+$', '');
if exist(saveFolder, 'dir') ~= 7; mkdir(saveFolder); end;

% get extension
ext = regexprep(regexp(savePath, '\.(\w+)$', 'match'), '^\.', '');
% if extension is supported by the export_fig function, use that
if ~isempty(ext) && ~strcmp(ext, 'fig') && ~isempty(regexp(ext, 'png|pdf|jpg|eps|tif|bmp', 'once'));
    if numel(varargin) > 1 && isnumeric(varargin{2});
        resolution = sprintf('-r%d', varargin{2});
    else
    	resolution = this.an.plotSaveResolution;
    end;
    warning('off', 'MATLAB:LargeImage');
    if numel(varargin) > 2 && strcmpi(varargin{3}, 'noCrop');
        export_fig(savePath, ['-' ext], resolution, '-nocrop', saveFig);
    else
        export_fig(savePath, ['-' ext], resolution, saveFig);
    end;
    warning('on', 'MATLAB:LargeImage');
    
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
