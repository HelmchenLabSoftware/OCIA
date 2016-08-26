function ANUpdatePlot(this, varargin)
% ANUpdatePlot - [no description]
%
%       ANUpdatePlot(this, varargin)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% process the inputs
h = [];
if numel(varargin) > 0; h = varargin{1}; end;
isHand = ~isempty(h) && numel(h) == 1 && ishandle(h);
isAutoUp = get(this.GUI.handles.an.autoUpPlot, 'Value');
paramOnly = false;

if isHand && h == this.GUI.handles.an.upPlot;
    % update plot anyways since the update plot button was pushed
elseif ~isHand && ischar(h) && strcmp(h, 'force');
    % update plot anyways since the force command was sent
elseif ~isHand && ischar(h) && strcmp(h, 'params');
    % update only parameters
    paramOnly = true;
elseif isAutoUp;
    % update plot since auto-update of the plot is activated
else
    % do not auto-update
    return;
end;

% disable the Analyser panel's GUI
OCIAToggleGUIEnableState(this, 'Analyser', 0);

% update the stored parameters from the parameter panel
if ~paramOnly;
    OCIAUpdateVariablesFromParamPanel(this, 'an');
    
    % clear the parameters panel configurating table
    if ~isempty(this.GUI.an.paramPanConfig);
        this.GUI.an.paramPanConfig(:, :) = [];

    % if the cell-array is empty, reset it to the default empty
    else
        showWarning(this, 'OCIA:AN:ANUpdatePlot:ParamPanReset', 'Parameter panel configuration reset ...');
        this.GUI.an.paramPanConfig = table({}, {}, {}, {}, [], [], {}, {}, 'VariableNames', ...
            { 'categ', 'id', 'UIType', 'valueType', 'UISize', 'isLabelAbove', 'label', 'tooltip' });

    end;

    % clear the plot and show a message
    ANShowHideMessage(this, 1, 'Loading ...');
    ANClearPlot(this);

    % get the selected analysis
    selectedAnalysisIndex = get(this.GUI.handles.an.plotList, 'Value');
    % if no exactly one analysis type is selected
    if numel(selectedAnalysisIndex) ~= 1;
        % if more that one analysis is selected, only take the first selected one
        if numel(selectedAnalysisIndex) > 1;  selectedAnalysisIndex = selectedAnalysisIndex(1);
        % if no plot is selected, take the first one
        else    selectedAnalysisIndex = 1;
        end;
        % update the selected plot in the GUI
        set(this.GUI.handles.an.plotList, 'Value', selectedAnalysisIndex);
    end;

    % get the selected rows
    selectedRowIndexes = get(this.GUI.handles.an.rowList, 'Value');
    % if no exactly one analysis type is selected
    if isempty(selectedRowIndexes);
        % select the first row
        selectedRowIndexes = 1;
        % update the selected plot in the GUI
        set(this.GUI.handles.an.rowList, 'Value', selectedRowIndexes);
    end;
    
    %OCIA_analysis_FAKE_createParamPanConfigUIControls(this);

    %%{
    
    if isempty(this.an.selectedTableRows);
        ANShowHideMessage(this, 1, 'No rows selected.');

    else

        % get the DataWatcher table's row indexes for the row selection
        iDWRows = this.an.selectedTableRows(selectedRowIndexes);

        o('#OCIA:AN:ANUpdatePlot(): updating plot / running analysis.', 3, this.verb);

        % catch errors to never end up stuck with the GUI elements disabled
        try    
            funcHandle = OCIAGetCallCustomFile(this, 'analysis', this.an.analysisTypes.id{selectedAnalysisIndex}, 1, ...
                { this, iDWRows }, 0);
        catch err;
            % show message and error
            ANShowHideMessage(this, 1, 'An error occured during the plotting. Sorry about that.');
            showWarning(this, 'OCIA:ANUpdatePlot:PlotError', ...
                sprintf('%s (%s)\n%s', err.message, err.identifier, getStackText(err)), 'red');
        end;

        % if the analysis function was not found, display a message
        if isempty(funcHandle);
            ANShowHideMessage(this, 1, 'The analysis function could not be found.');
        end;

    end;

    %}
    
end;

% create the parameter panel and its controls, using specific parameters
%   for each plot (stored in this.GUI.an.paramPanConfig)
OCIACreateParamPanelControls(this, 'an');

% if they are still valid, store the enable/disable state of the navigating buttons
if isfield(this.GUI.handles.an, 'prevParams') && ishandle(this.GUI.handles.an.prevParams);
    prevEnableState = get(this.GUI.handles.an.prevParams, 'Enable');
    nextEnableState = get(this.GUI.handles.an.nextParams, 'Enable');
end;

% enable the Analyser panel's GUI
OCIAToggleGUIEnableState(this, 'Analyser', 1);

% if they are still valid, set back the enable/disable state of the navigating buttons
if isfield(this.GUI.handles.an, 'prevParams') && ishandle(this.GUI.handles.an.prevParams);
    set(this.GUI.handles.an.prevParams, 'Enable', prevEnableState);
    set(this.GUI.handles.an.nextParams, 'Enable', nextEnableState);
end;

end
