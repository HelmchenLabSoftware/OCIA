function OCIA_startFunction_drawer(this)
% OCIA_startFunction_drawer - [no description]
%
%       OCIA_startFunction_drawer(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

   % go to DataWatcher mode
    OCIAChangeMode(this, 'DataWatcher');

    % process the selected folder and extract the notebook informations
    DWProcessWatchFolder(this);

    % if there is no filters for row type, set it to 'imgData'
    GUIDWFiltH = this.GUI.handles.dw.filt;
    if isempty(get(GUIDWFiltH.rowtype, 'String'));
        set(GUIDWFiltH.rowtype, 'String', 'imgData');
    end;

    % if there is no filters for run type, set it to 'B' (any imaging data with a behavior data associated)
    if isempty(get(GUIDWFiltH.runtype, 'String'));
        set(GUIDWFiltH.runtype, 'String', 'B');
    end;

    % select the rows
    DWFilterSelectTable(this, 'new');

    % draw ROIs for rows
    RDDrawROIsForRows(this);
            
end
