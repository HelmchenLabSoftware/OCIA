function OCIA_startFunction_preProcessPipeline(this)
% OCIA_startFunction_preProcessPipeline - [no description]
%
%       OCIA_startFunction_preProcessPipeline(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

    % go to DataWatcher mode
    OCIAChangeMode(this, 'DataWatcher');

    % create the string showing the selected watch types
    if ischar(this.GUI.dw.DWWatchTypes);
        DWWatchTypesStr = this.GUI.dw.DWWatchTypes;
    elseif iscell(this.GUI.dw.DWWatchTypes);
        DWWatchTypesStr = ['|', sprintf('%s|', this.GUI.dw.DWWatchTypes{:})];
    else
        DWWatchTypesStr = '?';
    end;

    showMessage(this, sprintf(['Processing options: start function: %s, noGUI: %d, DWFilt: %s, ', ...
        'DWWatchTypes: %s, DWSkiptMeta: %d, preProcOptions: %s, rawOrLocal: %s.'], ...
        regexprep(mfilename(), 'OCIA_startFunction_', ''), this.GUI.noGUI, ...
        ['|', sprintf('%s|', this.GUI.dw.DWFilt{:})], DWWatchTypesStr, ...
        this.GUI.dw.DWSkiptMeta, ['|', sprintf('%s|', this.an.an.preProcOptions{:})], this.GUI.dw.DWRawOrLocal));

    % process the selected folder
    DWProcessWatchFolder(this);
    
    % check if the table is empty
    if size(this.dw.table, 1) < 2;
        showMessage(this, 'Table is empty. Aborting');
        return;
    end;

    % if there are any filters for row type or run type, select them
    GUIDWFiltH = this.GUI.handles.dw.filt;
    if ~isempty(get(GUIDWFiltH.rowtype, 'String')) || ~isempty(get(GUIDWFiltH.runtype, 'String'));
        DWFilterSelectTable(this, 'new');
    end;

    % which data to save
    set(this.GUI.handles.dw.SLRDataOpts.ROISets, 'Value', 1);
    set(this.GUI.handles.dw.SLRDataOpts.caTraces, 'Value', 1);
    set(this.GUI.handles.dw.SLRDataOpts.stim, 'Value', 1);
    set(this.GUI.handles.dw.SLRDataOpts.behav, 'Value', 1);

    % how to save the data
    set(this.GUI.handles.dw.SLROpts.SLRSelOnly, 'Value', 1);
    set(this.GUI.handles.dw.SLROpts.loadBefSave, 'Value', 1);
    set(this.GUI.handles.dw.SLROpts.preProcBefSave, 'Value', 1);

    animalID = regexprep(this.dw.animalIDs{get(GUIDWFiltH.animalID, 'Value')}, 'mou_[db]l_', '');
    dayID = this.dw.dayIDs{get(GUIDWFiltH.dayID, 'Value')};
    spotID = this.dw.spotIDs{get(GUIDWFiltH.spotID, 'Value')};
    IDs = regexprep({animalID, dayID, spotID}, '_', '');

    try
        DWSave(this, sprintf('%s%s', this.path.OCIASave, IDs{1}));
    catch err;

        showWarning(this, 'OCIA:OCIAStartFunction:saveError', sprintf('Error while saving: %s (%s)\n%s', ...
           err.message, err.identifier, getStackText(err)), 'red');
    end;
            
end
