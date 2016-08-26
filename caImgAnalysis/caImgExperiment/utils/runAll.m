% o('================== 1a - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try convertAllRawDataForMouse('mou_bl_130923_02', 1 : 4, 0, 0);
% catch e; o('ERROR AT 1a: %s', e.message, 0, 0); end;
% o('================== 1b - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try roiStatsAllDataForMouse('mou_bl_130923_02', 1 : 4, 0, 0);
% catch e; o('ERROR AT 1b: %s', e.message, 0, 0); end;
% o('================== 1c - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try analyseROIStatsMultiDay('mou_bl_130923_02', 1 : 4, 0);
% catch e; o('ERROR AT 1c: %s', e.message, 0, 0); end;

% o('================== 2aB - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try convertAllRawDataForMouse('mou_bl_130923_02', 5, 2 : 3, 0);
% catch e; o('ERROR AT 2aB: %s', e.message, 0, 0); end;
o('================== 2bB - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
try roiStatsAllDataForMouse('mou_bl_130923_02', 5, 2 : 3, 0);
catch e; o('ERROR AT 2bB: %s', e.message, 0, 0); end;
o('================== 2cB - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
try analyseROIStatsMultiDay('mou_bl_130923_02', 5, 2 : 3);
catch e; o('ERROR AT 2cB: %s', e.message, 0, 0); end;

% o('================== 2a - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try convertAllRawDataForMouse('mou_bl_130923_02', 6, 1, 0);
% catch e; o('ERROR AT 2a: %s', e.message, 0, 0); end;
% o('================== 2b - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try roiStatsAllDataForMouse('mou_bl_130923_02', 6, 1, 0);
% catch e; o('ERROR AT 2b: %s', e.message, 0, 0); end;
% o('================== 2c - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try analyseROIStatsMultiDay('mou_bl_130923_02', 6, 1);
% catch e; o('ERROR AT 2c: %s', e.message, 0, 0); end;
% 
% 
% o('================== 3a - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try convertAllRawDataForMouse('mou_bl_130923_03', 1 : 2, 0, 0);
% catch e; o('ERROR AT 3a: %s', e.message, 0, 0); end;
% o('================== 3b - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try roiStatsAllDataForMouse('mou_bl_130923_03', 1 : 2, 0, 0);
% catch e; o('ERROR AT 3b: %s', e.message, 0, 0); end;
% o('================== 3c - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try analyseROIStatsMultiDay('mou_bl_130923_03', 1 : 2, 0);
% catch e; o('ERROR AT 3c: %s', e.message, 0, 0); end;

% o('================== 4a - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try convertAllRawDataForMouse('mou_bl_130923_03', 4, 1, 0);
% catch e; o('ERROR AT 4a: %s', e.message, 0, 0); end;
% o('================== 4b - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try roiStatsAllDataForMouse('mou_bl_130923_03', 4, 1, 0);
% catch e; o('ERROR AT 4b: %s', e.message, 0, 0); end;
% o('================== 4c - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try analyseROIStatsMultiDay('mou_bl_130923_03', 4, 1);
% catch e; o('ERROR AT 4c: %s', e.message, 0, 0); end;

% o('================== 4aB - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try convertAllRawDataForMouse('mou_bl_130923_03', 3, 1, 0);
% catch e; o('ERROR AT 4aB: %s', e.message, 0, 0); end;
% o('================== 4bB - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try roiStatsAllDataForMouse('mou_bl_130923_03', 3, 1, 0);
% catch e; o('ERROR AT 4bB: %s', e.message, 0, 0); end;
% o('================== 4cB - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try analyseROIStatsMultiDay('mou_bl_130923_03', 3, 1);
% catch e; o('ERROR AT 4cB: %s', e.message, 0, 0); end;

% o('================== 5a - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try convertAllRawDataForMouse('mou_bl_130923_03', 6, 3, 0);
% catch e; o('ERROR AT 5a: %s', e.message, 0, 0); end;
% o('================== 5b - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try roiStatsAllDataForMouse('mou_bl_130923_03', 6, 3, 0);
% catch e; o('ERROR AT 5b: %s', e.message, 0, 0); end;
% o('================== 5c - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try analyseROIStatsMultiDay('mou_bl_130923_03', 6, 3);
% catch e; o('ERROR AT 5c: %s', e.message, 0, 0); end;


% o('================== 6a - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try convertAllRawDataForMouse('mou_bl_130916_05', 1, 2, 0);
% catch e; o('ERROR AT 6a: %s', e.message, 0, 0); end;
% o('================== 6b - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try roiStatsAllDataForMouse('mou_bl_130916_05', 1 : 2, 0, 0);
% catch e; o('ERROR AT 6b: %s', e.message, 0, 0); end;
% o('================== 6c - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try analyseROIStatsMultiDay('mou_bl_130916_05', 1 : 2, 0);
% catch e; o('ERROR AT 6c: %s', e.message, 0, 0); end;

% o('================== 7a - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try convertAllRawDataForMouse('mou_bl_130916_05', 4, 1, 0);
% catch e; o('ERROR AT 7a: %s', e.message, 0, 0); end;
% o('================== 7b - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try roiStatsAllDataForMouse('mou_bl_130916_05', 3, 1, 0);
% catch e; o('ERROR AT 7b: %s', e.message, 0, 0); end;
% o('================== 7c - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try analyseROIStatsMultiDay('mou_bl_130916_05', 3, 1);
% catch e; o('ERROR AT 7c: %s', e.message, 0, 0); end;


% o('================== 8a - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try convertAllRawDataForMouse('mou_bl_130916_02', 1 : 3, 0, 0);
% catch e; o('ERROR AT 8a: %s', e.message, 0, 0); end;
% o('================== 8b - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try roiStatsAllDataForMouse('mou_bl_130916_02', 1 : 3, 0, 0);
% catch e; o('ERROR AT 8b: %s', e.message, 0, 0); end;
% o('================== 8c - %s ==================', datestr(now, 'YYmmDD-HHMMSS'), 0, 0);
% try analyseROIStatsMultiDay('mou_bl_130916_02', 1 : 3, 0);
% catch e; o('ERROR AT 8c: %s', e.message, 0, 0); end;

