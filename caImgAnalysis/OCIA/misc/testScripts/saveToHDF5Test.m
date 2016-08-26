function saveToHDF5Test

%% load OCIA and parameters

% runs = [13 16 19 20 25]; % runs to save
runs = [13]; % runs to save
% runs = [13 14 16 18 19 21 24 28 29 33 39 40 42 45 47]; % runs to analyse
nRuns = numel(runs);

% figPos = [10, 50, 1900, 940];
% figCommons = {'NumberTitle', 'off', 'Position', figPos}; % figure options
% UF = {'UniformOutput', false};
% comp = struct(); % comparison structure
% if ~isempty(inComp);
%     comp = inComp;
% end;
% % get the rowIDs
% rowIDs = regexprep(arrayfun(@(iDWRow)sprintf('%s-%sh', this.dw.table{iDWRow, 2 : 3}), runs, UF{:}), '_', '');

% % get number of ROIs used for frame-wise correlations on ROIs
% nROIs = size(ANGetROISetForRow(this, runs(1)), 1) - 1;

this = OCIA('dataWatcher', true, {'mou_bl_140110_02', '2014_02_25', 'spot01', 'imgData', 'B05'}, 'all', false);

%% high level API
% build path
HDF5Path = sprintf('%sHDF5Test', this.path.OCIASave);
fileName = 'imagingDeflate1.h5';
filePath = sprintf('%s/%s', HDF5Path, fileName);
% flush data
this.flushData('preproc,raw');
dataSetCreateWriteTic = tic; % for performance timing purposes
% create data sets    
for iRun = 1 : nRuns;
    % load the row
    iDWRow = runs(iRun);
    DWLoadRow(this, iDWRow, 'full');
    % get the meta-data for this run
    parts = regexp(this.dw.table{iDWRow, 1}, '\w+', 'match');
    rowID = regexprep(regexprep(sprintf('%s:%s', this.dw.table{iDWRow, 2 : 3}), '_', ''), ':', '_');
    dataSetID = sprintf('/%s/%s/%s/', parts{1 : 3});
    nChans = size(this.data.raw{iDWRow}, 1);
    rawDataSize = size(this.data.raw{iDWRow}{1});
    preProcDataSize = size(this.data.preProc{iDWRow}{1});
    % create the data set
    for iChan = 1 : nChans;
        fullDataSetID = sprintf('%s/raw/%s/chan%02d', dataSetID, rowID, iChan);
        % raw
        h5create(filePath, fullDataSetID, rawDataSize, 'Deflate', 1, 'ChunkSize', rawDataSize / 4);
        h5write(filePath, fullDataSetID, this.data.raw{iDWRow}{iChan});
        % pre-processed
        fullDataSetID = regexprep(fullDataSetID, 'raw', 'preProc');
        h5create(filePath, fullDataSetID, preProcDataSize, 'Deflate', 1, 'ChunkSize', preProcDataSize / 4);
        h5write(filePath, fullDataSetID, this.data.preProc{iDWRow}{iChan});
    end;
end;
o('Data set created and written in %.4f sec', toc(dataSetCreateWriteTic), 0, 0);

h5disp(filePath);
% 
% imagesc(nanmean(h5read('caImg.h5', '/mou_bl_140110_02/2014_02_25/spot01/20140225_174247/raw/chan01'), 3));


%% high level API
% build path
HDF5Path = sprintf('%sHDF5Test', this.path.OCIASave);
fileName = 'behavSaveTest.h5';
filePath = sprintf('%s/%s', HDF5Path, fileName);
dataSetCreateWriteTic = tic; % for performance timing purposes
% create data sets    
for iRun = 1 : nRuns;
    % load the row
    iDWRow = runs(iRun);
    % get the meta-data for this run
    parts = regexp(this.dw.table{iDWRow, 1}, '\w+', 'match');
    rowID = regexprep(regexprep(sprintf('%s:%s', this.dw.table{iDWRow, 2 : 3}), '_', ''), ':', '_');
    dataSetID = sprintf('/%s/%s/%s/', parts{1 : 3});
    nChans = size(this.data.raw{iDWRow}, 1);
    rawDataSize = size(this.data.raw{iDWRow}{1});
    preProcDataSize = size(this.data.preProc{iDWRow}{1});
    % create the data set
    for iChan = 1 : nChans;
        fullDataSetID = sprintf('%s/raw/%s/chan%02d', dataSetID, rowID, iChan);
        % raw
        h5create(filePath, fullDataSetID, rawDataSize, 'Deflate', 1, 'ChunkSize', rawDataSize / 4);
        h5write(filePath, fullDataSetID, this.data.raw{iDWRow}{iChan});
        % pre-processed
        fullDataSetID = regexprep(fullDataSetID, 'raw', 'preProc');
        h5create(filePath, fullDataSetID, preProcDataSize, 'Deflate', 1, 'ChunkSize', preProcDataSize / 4);
        h5write(filePath, fullDataSetID, this.data.preProc{iDWRow}{iChan});
    end;
end;
o('Data set created and written in %.4f sec', toc(dataSetCreateWriteTic), 0, 0);

h5disp(filePath);

%% high level with structure and cell array support

dataToSaveNumeric = rand(100, 20, 30);

dataToSaveLogical = false(100, 20, 30);

dataToSaveChar = 'testString';

dataToSaveStructEasy = struct( ...
        'A', rand(20, 30, 40), ...
        'B', 'testStringB' ...
    );

dataToSaveStructComplex = struct( ...
        'A', rand(20, 30, 40), ...
        'B', struct('C', 'testStringC') ...
    );

dataToSaveCellArrayEasy = {'A', rand(20, 30, 40), 'test'; 'B', 'testStringB', rand(2, 3, 2, 3)};

dataToSaveCellArrayEmpty = cell(12, 24, 3);

dataToSaveCellArrayPartEmpty = cell(12, 24, 3);
dataToSaveCellArrayPartEmpty{1, 2, 3} = 'test';
dataToSaveCellArrayPartEmpty{2, 2, 1} = rand(10);

dataToSaveCellArrayComplex = {'A', rand(20, 30, 40); {'B', 'test'}, 'testStringC' };

s = struct('Person', 0, 'Name', 'test');
dataToSaveStructArray = repmat(s, 3, 4);

s2 = struct([]);

a = struct('test', s, 'test2', s2, 'test3', 'ok');

dataToSaveComplex = struct( ...
        'A', rand(20, 30, 40), ...
        'B', struct( ...
            'C', struct( ...
                'D', rand(10, 20, 30), ...
                'E', 'test' ...
            ), ...
            'F', {{ 'test', 'test2', rand(10, 20)}} ...
        ), ...
        'G', dataToSaveStructArray ...
    );




%%
%{
%% create the file
% build path
HDF5Path = sprintf('%sHDF5Test', this.path.OCIASave);
fileName = 'caImg.h5';
filePath = sprintf('%s/%s', HDF5Path, fileName);

% H5F API: create the file
fID = H5F.create(filePath, 'H5F_ACC_TRUNC', 'H5P_DEFAULT', 'H5P_DEFAULT');
% H5F API: close the file
H5F.close(fID);
% H5F file content dumper
h5disp(filePath)

%% create a dataset
% create example data: random doubles in shape of 50 frames of 100 by 200 pixels
data = rand(100, 200, 50);
% H5F file interface: create the file
fID = H5F.create(filePath, 'H5F_ACC_TRUNC', 'H5P_DEFAULT', 'H5P_DEFAULT');
% create the name of the dataset
dataSetName = 'testDataSet';
% H5T datatype interface: create the data type (double)
typeID = H5T.copy('H5T_NATIVE_DOUBLE');
% get the number of dimensions of the data (rank)
rank = ndims(data);
% change dimension ordering
data = permute(data, fliplr(1 : rank));
% H5S dataspace interface: create the data space
spaceID = H5S.create_simple(rank, size(data), size(data));
% H5D dataset interface: create the data set
dSetID = H5D.create(fID, dataSetName, typeID, spaceID, 'H5P_DEFAULT');
% H5S dataspace interface: close the data space
H5S.close(spaceID);
% H5T datatype interface: close the data type
H5T.close(typeID);
% H5D dataset interface: close the dataset
H5D.close(dSetID);
% H5F file interface: close the file
H5F.close(fID);
% file content dumper
h5disp(filePath)


%% write to dataset
% create example data: random doubles in shape of 50 frames of 100 by 200 pixels
data = rand(100, 200, 50);
% H5F file interface: create the file
fID = H5F.create(filePath, 'H5F_ACC_TRUNC', 'H5P_DEFAULT', 'H5P_DEFAULT');
% create the name of the dataset
dataSetName = 'testDataSet';
% H5T datatype interface: create the data type (double)
typeID = H5T.copy('H5T_NATIVE_DOUBLE');
% get the number of dimensions of the data (rank)
rank = ndims(data);
% change dimension ordering
data = permute(data, fliplr(1 : rank));
% H5S dataspace interface: create the data space
spaceID = H5S.create_simple(rank, size(data), size(data));
% H5D dataset interface: create the data set
dSetID = H5D.create(fID, dataSetName, typeID, spaceID, 'H5P_DEFAULT');
% H5S dataspace interface: close the data space
H5S.close(spaceID);
% H5T datatype interface: close the data type
H5T.close(typeID);
% H5D dataset interface: close the dataset
H5D.close(dSetID);
% H5F file interface: close the file
H5F.close(fID);
% file content dumper
h5disp(filePath)

%% other stuff

% this.flushData('preproc,raw');
% ANFrameJitterCorrection(this, iDWRow);
% ANMotionCorrection(this, iDWRow);

% animalID = this.dw.animalIDs{get(this.GUI.handles.dw.filt.animalID, 'Value')};
% dayID = this.dw.dayIDs{get(this.GUI.handles.dw.filt.dayID, 'Value')};
% spotID = this.dw.spotIDs{get(this.GUI.handles.dw.filt.spotID, 'Value')};
% % nTrials = 50; nROIs = 101; nFramesMax = 600;
% % caImgDataSet = rand(nTrials, nROIs, nFramesMax);
% nTrials = 50; nFramesMax = 600;
% caImgDataSet = rand(nTrials, nFramesMax);
% 
% % dSetName = sprintf('/%s/%s/%s', mouseID, day, spotID);
% dSetName = sprintf('/%s_%s_%s', animalID, day, spotID);
% 
% fID = H5F.create(filePath, 'H5F_ACC_TRUNC', 'H5P_DEFAULT', 'H5P_DEFAULT');
% % fID = H5F.create(fileName, 'H5F_ACC_TRUNC', H5P.create('H5P_FILE_CREATE'), H5P.create('H5P_FILE_ACCESS'));
% typeID = H5T.copy('H5T_NATIVE_DOUBLE');
% h5Dims = fliplr(size(caImgDataSet));
% h5MaxDims = h5Dims;
% spaceID = H5S.create_simple(2, h5Dims, h5MaxDims);
% 
% dSetID = H5D.create(fID, dSetName, typeID, spaceID, 'H5P_DEFAULT');
% H5S.close(spaceID);
% H5T.close(typeID);
% H5D.close(dSetID);
% H5F.close(fID);

%}

end
