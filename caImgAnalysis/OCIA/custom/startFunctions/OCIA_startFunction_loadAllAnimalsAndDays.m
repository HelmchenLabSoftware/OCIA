function OCIA_startFunction_loadAllAnimalsAndDays(this)
% OCIA_startFunction_loadAllAnimalsAndDays - [no description]
%
%       OCIA_startFunction_loadAllAnimalsAndDays(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% get all the imaging data
OCIAChangeMode(this, 'DataWatcher');

% get the DataWatcher's GUI handle
dwh = this.GUI.handles.dw;

% set the watch types
set(dwh.watchTypes.animal,      'Value', 1);
set(dwh.watchTypes.day,         'Value', 1);
set(dwh.watchTypes.wfLV,        'Value', 0);
set(dwh.watchTypes.wfLVSess,    'Value', 0);
set(dwh.watchTypes.wfLVMat,     'Value', 0);
set(dwh.watchTypes.wfAn,        'Value', 0);
set(dwh.watchTypes.behav,       'Value', 0);

% set the filters
set(dwh.filt.animalID,          'Value', 1, 'String', { '-' });
set(dwh.filt.dayID,             'Value', 1, 'String', { '-' });
set(dwh.filt.wfLVSessID,        'Value', 1, 'String', { '-' });
set(dwh.filt.rowTypeID,         'Value', 1, 'String', { '-' });
set(dwh.filt.dataLoadStatus,    'Value', 0, 'String', '');
set(dwh.filt.rowNum,            'Value', 0, 'String', '');
set(dwh.filt.runNum,            'Value', 0, 'String', '');
set(dwh.filt.all,               'Value', 0, 'String', '');

% update the table
DWProcessWatchFolder(this);
    
end  
