function createHDF5DataSet()

fileName = 'C:/Users/laurenczy/Documents/LabVIEW Data/OCIA/caImg.h5';
mouseID = 'testMouseID';
day = '2014_02_21';
spotID = 'sp01';
% nTrials = 50; nROIs = 101; nFramesMax = 600;
% caImgDataSet = rand(nTrials, nROIs, nFramesMax);
nTrials = 50; nFramesMax = 600;
caImgDataSet = rand(nTrials, nFramesMax);

% dSetName = sprintf('/%s/%s/%s', mouseID, day, spotID);
dSetName = sprintf('/%s_%s_%s', mouseID, day, spotID);

fID = H5F.create(fileName, 'H5F_ACC_TRUNC', H5P.create('H5P_FILE_CREATE'), H5P.create('H5P_FILE_ACCESS'));
typeID = H5T.copy('H5T_NATIVE_DOUBLE');
h5Dims = fliplr(size(caImgDataSet));
h5MaxDims = h5Dims;
spaceID = H5S.create_simple(2, h5Dims, h5MaxDims);

dSetID = H5D.create(fID, dSetName, typeID, spaceID, 'H5P_DEFAULT');
H5S.close(spaceID);
H5T.close(typeID);
H5D.close(dSetID);
H5F.close(fID);

h5disp(fileName);

end