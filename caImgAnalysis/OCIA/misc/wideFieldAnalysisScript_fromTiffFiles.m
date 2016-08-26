% analyse widefield imaging data

tifFilesFolderPath = 'F:/RawData/1502_chronic/mou_bl_150217_05/2015_06_03/widefield/run001/Tiff_files/';

files = dir(tifFilesFolderPath);
files(1 : 2) = [];

% 4D matrix: trials x frames x X x Y
data = zeros(0, 0, 0, 0);

for iFile = 1 : numel(files);
    
    fileName = files(iFile).name;
    regexpHit = regexp(fileName, '^Trial(?<iTrial>\d+)frame(?<iFrame>\d+)$', 'names');
    iTrial = str2double(regexpHit.iTrial);
    iFrame = str2double(regexpHit.iFrame);
    
    imgStruct = tiffread2_wrapper([tifFilesFolderPath, fileName], 1, 100);
    
    data(iTrial, iFrame, :, :) = imgStruct.data;
    
    o('Loaded trial %02d frame %02d.', iTrial, iFrame, 0, 0);
    
end;