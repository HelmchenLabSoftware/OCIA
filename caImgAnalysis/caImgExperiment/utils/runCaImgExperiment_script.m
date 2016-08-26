%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CaImgExperiment script                         %
% Originally created on               2013-03-20 %
% Written by B. Laurenczy (blaurenczy@gmail.com) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% init
% create directory
% dataPath = sprintf('G:/Balazs/%s/%s_caImg/', datestr(date, 'yyyy'), datestr(date, 'yyyy_mm_dd'));
% dataPath = sprintf('G:/test/%s/%s_caImg/', datestr(date, 'yyyy'), datestr(date, 'yyyy_mm_dd'));
dataPath = sprintf('C:/Users/laurenczy/Documents/LabVIEW Data/%s/CaImgExp/', datestr(date, 'yyyy_mm_dd'));
mkdir(dataPath);

% create experiment object
CaImgExp = CaImgExperiment('OGB', '64/2012', 'H45_left', ... % license and room
...%     Animal('mou_bl_130711_01', 'SOMxTDTomato', ...
...%     331779, 'F', 23, '2013-06-11'), ... % animal
...%      Animal('mou_bl_130916_02', 'SOMxTDTomato', ...
...%      Animal('mou_bl_130916_03', 'SOMxTDTomato', ...
...%      Animal('mou_bl_130916_05', 'SOMxTDTomato', ...
...%      222861, 'F', 20, '2013-08-13'), ... % animal
...%      Animal('mou_bl_130923_01', 'SOMxTDTomato', ...
...%      Animal('mou_bl_130923_02', 'SOMxTDTomato', ...
...%      Animal('mou_bl_130923_03', 'SOMxTDTomato', ...
...%      456044, 'F', 23, '2013-07-13'), ... % animal
      Animal(['mou_bl_' datestr(date, 'yymmdd') '_01'], '??xTDTomato', ...
      100001, 'U', -1, '2013-??-??'), ... % animal
     dataPath, ... % base path for data
...%    'Acute 2P calcium imaging in AC'); % title
    'Acute 2P calcium imaging in AC'); % title
CaImgExp.saveAll(); % save the experiment

% CaImgExp.debugMode = 1;

cd(CaImgExp.basePath);

%% new Spot
% re-run this part of the script for each spot
CaImgExp = CaImgExp.newSpot(Spot());

CaImgExp.saveAll(sprintf('sp%02dStart', CaImgExp.nSpots)); % save a backup
CaImgExp.saveAll(); % save experiment

%% new run
CaImgExp = CaImgExp.runExperiment(5);

CaImgExp.saveAll(sprintf('sp%02dEnd', CaImgExp.nSpots)); % save a backup
CaImgExp.saveAll(); % save the experiment

%% end experiment

cd('..');
today = datestr(date, 'yyyy_mm_dd');
CaImgFolderName = sprintf('%s_caImg', today);
mouseRawDataPath = sprintf('W:/Neurophysiology/RawData/Balazs_Laurenczy/2013/%s/', CaImgExp.animal.id);
dayRawDataPath = sprintf('%s%s/', mouseRawDataPath, today);
latestCaImgExpMatFile = sprintf('G:/Balazs/%s/%s/CaImgExp_%s.mat', CaImgExp.animal.id, CaImgFolderName, today);

movefile(CaImgFolderName, sprintf('G:/Balazs/%s/', CaImgExp.animal.id));
if exist(dayRawDataPath, 'dir'); copyfile(latestCaImgExpMatFile, dayRawDataPath);
else copyfile(latestCaImgExpMatFile, mouseRawDataPath); end;




