function OCIA_startFunction_onlineAnalysis(this)
% OCIA_startFunction_onlineAnalysis - [no description]
%
%       OCIA_startFunction_onlineAnalysis(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

    % go to DataWatcher mode
    OCIAChangeMode(this, 'DataWatcher');

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

    onlineMonitorPauseTime = 1;
    doOnlineMonitor = true;
    set(this.GUI.handles.dw.addNewRows, 'Value', 1);
    
    while doOnlineMonitor;

        % process the selected folder and extract the notebook informations
        DWProcessWatchFolder(this);

        % check if there is more than one spot selected, if so select only one
        GUIDWFiltH = this.GUI.handles.dw.filt;
        if get(GUIDWFiltH.spotID, 'Value') < 2;
            if numel(get(GUIDWFiltH.spotID, 'String')) < 2;
                showWarning(this, 'OCIA:OCIAStartFunction:onlineAnalysis:NoSpot', 'No spot !');
                pause(onlineMonitorPauseTime);
                continue;
            else
                set(GUIDWFiltH.spotID, 'Value', 2);
            end;
        end;

        % if there are any filters for row type or run type, select them
        if ~isempty(get(GUIDWFiltH.rowtype, 'String')) || ~isempty(get(GUIDWFiltH.runtype, 'String'));
            DWFilterSelectTable(this, 'new');
        end;

        % check if there is a ROISet for the selected lines
        ROISetMatches = this.dw.table(this.dw.selectedTableRows, 16);
        if any(cellfun(@isempty, ROISetMatches));

            showMessage(this, 'No ROISet found, switching to ROIDrawer mode...');
            RDDrawROIsForRows(this);
            break;

        else
            
            ANAnalyseRows(this);
            break;
        end;
        
%         pause(onlineMonitorPauseTime);
        
    end;
            
end
