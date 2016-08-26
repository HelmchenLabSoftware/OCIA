function OCIA_startFunction_alex(this)
% OCIA_startFunction_alex - [no description]
%
%       OCIA_startFunction_alex(this)
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
        'DWWatchTypes: %s, DWSkiptMeta: %d, preProcOptions: %s, rawOrLocal: %s.'],  ...
        regexprep(mfilename(), 'OCIA_startFunction_', ''), this.GUI.noGUI, ...
        ['|', sprintf('%s|', this.GUI.dw.DWFilt{:})], DWWatchTypesStr, ...
        this.GUI.dw.DWSkiptMeta, ['|', sprintf('%s|', this.an.an.preProcOptions{:})], this.GUI.dw.DWRawOrLocal));

    % process the selected folder and extract the notebook informations
    DWProcessWatchFolder(this);
    
end
