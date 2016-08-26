function OCIA_startFunction_jointtracker(this)
% OCIA_startFunction_jointtracker - [no description]
%
%       OCIA_startFunction_jointtracker(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

    % change mode
    OCIAChangeMode(this, 'DataWatcher');
    
    if ischar(this.GUI.dw.DWWatchTypes);
        DWWatchTypesStr = this.GUI.dw.DWWatchTypes;
    elseif iscell(this.GUI.dw.DWWatchTypes);
        DWWatchTypesStr = ['|', sprintf('%s|', this.GUI.dw.DWWatchTypes{:})];
    else
        DWWatchTypesStr = '?';
    end;

    % display informations
    showMessage(this, sprintf(['Processing options: start function: %s, noGUI: %d, DWFilt: %s, ', ...
        'DWWatchTypes: %s, DWSkiptMeta: %d, rawOrLocal: %s.'], regexprep(mfilename(), 'OCIA_startFunction_', ''), ...
        this.GUI.noGUI, ['|', sprintf('%s|', this.GUI.dw.DWFilt{:})], DWWatchTypesStr, this.GUI.dw.DWSkiptMeta, ...
        this.GUI.dw.DWRawOrLocal));
    
    % process the selected folder and filter the table
    DWProcessWatchFolder(this);
    DWFilterSelectTable(this, 'new');
    
    % abort if no rows selected
    if isempty(this.dw.selectedTableRows);
        return;
    end;
    
    % wait and analyse the selected movie
    pause(0.5);
    OCIA_dataWatcherProcess_trackMovies(this);
            
end
