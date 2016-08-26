% convert mat files to HDF5 for widefield

matFilesPath = 'D:\RawData\1509_tonotopy\mou_bl_150922_02\2015_10_01\wideField\';
files = dir([matFilesPath 'intr*.mat']);
saveNames = { '20151001_172500_exp01_stim1Hz_80sec_upSweep', '20151001_174400_exp02_stim0p166Hz_60sec_upSweep', ...
    '20151001_180300_exp03_stim4Hz_60sec_upSweep', '20151001_181200_exp04_stim4Hz_60sec_upSweep_NOSOUND', ...
    '20151001_182300_exp05_stim0p166Hz_60sec_upSweep_NOSOUND' };

animDate = 'mou_bl_150922_02\2015_10_01';

for iSaveName = 1 : numel(saveNames);
    saveName = saveNames{iSaveName};

    savePath = [ 'D:\RawData\1509_tonotopy\' animDate '\wideField\' saveName '.h5' ];
    datasetPathRoot = [ '/' regexprep(animDate, '\', '/') '/' saveName ];
    datasetPathStim = sprintf('%s/stimFrames', datasetPathRoot);
    datasetPathRefImg = sprintf('%s/refImg', datasetPathRoot);

    intrSaveMat = load([matFilesPath files(iSaveName).name]);
    intrSave = intrSaveMat.intrSave;
    
    imgDim = [size(intrSave.data.stimFrames, 1) size(intrSave.data.stimFrames, 2)];
    nFramesRec = size(intrSave.data.stimFrames, 3);

    h5create(savePath, datasetPathStim, [imgDim nFramesRec], 'ChunkSize', [16 16 100], 'Deflate', 1, 'DataType', 'uint16');
    h5write(savePath, datasetPathStim, uint16(intrSave.data.stimFrames));
    if ~isempty(intrSave.data.refImg);
        h5create(savePath, datasetPathRefImg, imgDim, 'ChunkSize', [16 16], 'Deflate', 1, 'DataType', 'uint16');
        h5write(savePath, datasetPathRefImg, uint16(intrSave.data.refImg));
    elseif exist('refImg', 'var');
        h5create(savePath, datasetPathRefImg, imgDim, 'ChunkSize', [16 16], 'Deflate', 1, 'DataType', 'uint16');
        h5write(savePath, datasetPathRefImg, refImg);
    end;

    intrSave.params.common = rmfield(intrSave.params.common, 'saveName');
    intrSave.params.common.animalID = 'mou_bl_150922_02';
    intrSave.params.common.h5saveDeflate = 1;
    intrSave.params.common.rampFrac = intrSave.params.rampFrac;
    intrSave.params.common.TDTSampFreq = intrSave.params.TDTSampFreq;
    intrSave.params.common.standardSampFreq = intrSave.params.standardSampFreq;
    intrSave.params.fourier.frameRate = intrSave.params.fourier.camFPS;
    intrSave.params.fourier = rmfield(intrSave.params.fourier, { 'stimFreqSingle', 'stimFreqAll', 'camFPS', 'tempDSFactor', ...
        'phaseMapFilt', 'phaseMapCLim', 'powerMapFilt', 'powerMapCLim', 'spectrYLim', 'pixTCYLim', 'pixTimeCourseNBins' });

    h5createwrite_wrapper(savePath, datasetPathRoot, intrSave.params.common, {}, {});
    h5createwrite_wrapper(savePath, datasetPathRoot, intrSave.params.fourier, {}, {});

    h5disp(savePath);
    
end;