function resonanceAnalyser()

dbgLvl = 4;

rawDataPath = 'C:\Users\laurenczy\Documents\LabVIEW Data\2013_12_12\';
files = dir(rawDataPath);
files(arrayfun(@(f)~f.isdir, files)) = [];
nFiles = numel(files);
o('#resonanceAnalyser: found %d file(s)...', nFiles - 2, 1, dbgLvl);
imgStructures = {};
for iFile = 1 : nFiles;
    fileName = files(iFile).name;
    o('  #resonanceAnalyser: file %d/%d: "%s" ...', iFile, nFiles - 2, fileName, 2, dbgLvl);
    
    if isempty(regexp(fileName, '^\d{4}_\d{2}_\d{2}_(_\d{2}){3}h$', 'once')); continue; end;
    
    importTic = tic; % for performance timing purposes
    imgStruct = importResonanceFolder([rawDataPath fileName]);
    nChans = size(imgStruct.img_data, 2);
    imgStruct.proc.downSampleFactor = 5;
    imgStruct.img_data_downsampled = cell(nChans, 1);
    o('    #resonanceAnalyser: file %d/%d: "%s" imported (%3.1f sec).', ...
        iFile, nFiles - 2, fileName, toc(importTic), 3, dbgLvl);
    
    o('    #resonanceAnalyser: file %d/%d: "%s" processing %d channel(s) ...', ...
        iFile, nFiles - 2, fileName, nChans, 3, dbgLvl);
    
%     downSampleAllChansTic = tic; % for performance timing purposes
%     for iChan = 1 : nChans;
%         chanTic = tic; % for performance timing purposes
%         frames = ScaleToMinMax(imgStruct.img_data{iChan}, 0, 1);
%         downSampleFactor = imgStruct.proc.downSampleFactor;
%         framesDS = zeros(size(frames, 1), size(frames, 2), ceil(size(frames, 3) / downSampleFactor));
%         dimX = imgStruct.hdr.size(1);
%         dimY = imgStruct.hdr.size(2);
%         parfor x = 1 : dimX;
%             for y = 1 : dimY;
%                 framesDS(x, y, :) = decimate(frames(x, y, :), downSampleFactor);
%             end;
%         end;
%         o('      #resonanceAnalyser: file %d/%d: "%s" chan %d: down-sampled (%3.1f sec).', ...
%             iFile, nFiles - 2, fileName, iChan, toc(chanTic), 3, dbgLvl);
%         imgStruct.img_data_downsampled{iChan} = framesDS;
%     end;
%     o('      #resonanceAnalyser: file %d/%d: "%s" down-sampled %d chans(%3.1f sec).', ...
%         iFile, nFiles - 2, fileName, nChans, toc(downSampleAllChansTic), 3, dbgLvl);
    
    imgStructures{end + 1} = imgStruct; %#ok<AGROW>
end;


        
end


