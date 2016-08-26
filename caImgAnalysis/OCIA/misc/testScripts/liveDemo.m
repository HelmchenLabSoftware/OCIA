this = OCIA();
this = OCIA('dataWatcher', false, {'mou_bl_140110_02', '2014_02_25', 'spot01', 'data', 'B05'}, {'animal', 'day', 'spot', 'data', 'notebook', 'behavior'}, false);
clc
ANFrameJitterCorrection(this, 16);
ANMotionCorrection(this, 13);
h5disp('C:\Users\laurenczy\Documents\LabVIEW Data\OCIA\trial1_dataOnly_data.h5')
this = OCIA('preProcessPipeline', true, {'mou_bl_140110_02', '2014_02_25', 'spot01', 'data', 'B05', '10'}, 'all', false, {'skipFrame', 'fShift', 'fJitt', 'moCorr'});
clc
