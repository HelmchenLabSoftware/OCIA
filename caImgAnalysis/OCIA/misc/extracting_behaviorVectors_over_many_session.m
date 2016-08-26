
% open once
this = OCIA('trialView_balazs');
% You need to put / instead of \. Also end with a /.
% listOfPath = {
%     'W:/Neurophysiology-Storage1/Gilad/Data_per_mouse/mouse_tgg6fl23_9/20151020/a/', ...
%     'W:/Neurophysiology-Storage1/Gilad/Data_per_mouse/mouse_tgg6fl23_9/20151020/b/', ...
%     'W:/Neurophysiology-Storage1/Gilad/Data_per_mouse/mouse_tgg6fl23_9/20151020/c/'    
% };

listOfPath = { ...
%     'F:/RawData/1601_behav/mou_bl_160105_03/2016_05_11/widefield_labview/session02_125500/Matt_files/', ...
%     'F:/RawData/1601_behav/mou_bl_160105_03/2016_05_11/widefield_labview/session05_140900/Matt_files/' ...
    'F:/RawData/1601_behav/mou_bl_160105_03/2016_05_12/widefield_labview/session01_104000/Matt_files/', ...
    'F:/RawData/1601_behav/mou_bl_160105_03/2016_05_12/widefield_labview/session02_111500/Matt_files/', ...
    'F:/RawData/1601_behav/mou_bl_160105_03/2016_05_12/widefield_labview/session04_121800/Matt_files/', ...
};

for iPath = 1 : numel(listOfPath);
    
    cd (listOfPath{iPath})
    this.tv.params.WFDataPath = listOfPath{iPath};
    this.tv.params.saveLoadPath = listOfPath{iPath};
    this.tv.params.behavDataPath = listOfPath{iPath};

    OCIA_startFunction_trialView(this);
    OCIA_trialview_loadROIs(this);

    OCIA_trialview_extractROITraces(this);
%     close all force
%     this = OCIA('trialView_ariel');
%     listOfPath = {
%     'W:/Neurophysiology-Storage1/Gilad/Data_per_mouse/mouse_tgg6fl23_9/20151020/a/', ...
%     'W:/Neurophysiology-Storage1/Gilad/Data_per_mouse/mouse_tgg6fl23_9/20151020/b/', ...
%     'W:/Neurophysiology-Storage1/Gilad/Data_per_mouse/mouse_tgg6fl23_9/20151020/c/'    
% };


end;
