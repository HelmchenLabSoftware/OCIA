function imgStruct = importResonanceFolder(dataPath) %#ok<STOUT,INUSD>

error('importResonanceFolder:Deprecated', 'DEPRECATED: use loadData instead');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Intrinsic image analyser                       %
% Originally created on           28 / 11 / 2013 %
% Written by B. Laurenczy (blaurenczy@gmail.com) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% process files of the folder
fileNames = ls(dataPath); %#ok<UNRCH> % get all file names
imgStruct = struct('img_data', [], 'hdr', []);
iChan = 1;
keepAvgFramesSeparate = 0;

for iFile = 1 : size(fileNames, 1);
    fileName = fileNames(iFile, :);
    
    if ~isempty(regexp(fileName, '\.xml', 'once'));
    
        imgStruct.hdr.filePath = [dataPath filesep fileName];
        xml = xmlread(imgStruct.hdr.filePath);
        dimX = getNodeValue(xml, 'ResolutionX');
        dimY = getNodeValue(xml, 'ResolutionY');
        nFrames = getNodeValue(xml, 'Frames');
        imgStruct.hdr.size = [dimX, dimY, nFrames];
        imgStruct.hdr.frame_rate = getNodeValue(xml, 'FrameScanRate');
        imgStruct.hdr.nAveraging = getNodeValue(xml, 'AveragingRepetitions');
        imgStruct.hdr.zStepSize = getNodeValue(xml, 'StepSize');
        
%         fileID = fopen([dataPath filesep fileName]);
%         data = fread(fileID, 'uint16');
%         fclose(fileID);
        
    elseif ~isempty(regexp(fileName, '\.bin', 'once'));
        
        fileID = fopen([dataPath filesep fileName]);
        data = fread(fileID, 'uint16');
        if imgStruct.hdr.nAveraging == 1;
            imgStruct.img_data{iChan} = reshape(data, imgStruct.hdr.size);
        elseif imgStruct.hdr.nAveraging > 1;
            imgStruct.img_data{iChan} = reshape(data, [imgStruct.hdr.size imgStruct.hdr.nAveraging]);
        end;
        if imgStruct.hdr.nAveraging > 1 && ~keepAvgFramesSeparate;
            imgStruct.img_data{iChan} = reshape(mean(imgStruct.img_data{iChan}, 4), imgStruct.hdr.size);
        end;
        fclose(fileID);
        iChan = iChan + 1;
        
    end;
    
end;


function value = getNodeValue(xml, tagName)
    value = str2double(xml.getDocumentElement.getElementsByTagName(tagName).item(0).getChildNodes.item(0).getNodeValue);
end
        
end


