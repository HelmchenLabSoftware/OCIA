% delete a group in the HDF5 file
function doesExist = h5exists(fileName, groupPath)

% check if the file exists
if ~exist(fileName, 'file');
    doesExist = false;
    return;
end;

doesExist = true;
fileID = H5F.open(fileName);
pathParts = regexp(groupPath, '/', 'split');

iPart = 2;
while iPart < numel(pathParts);
    
    partialPartsString = sprintf('/%s', pathParts{2 : iPart});
    nextPart = pathParts{iPart + 1};
    try
        groupID = H5G.open(fileID, partialPartsString);
    catch err;
        if strcmp(err.identifier, 'MATLAB:imagesci:hdf5lib:libraryError') && iPart == 2;
            doesExist = false;
            break;
        end;
        rethrow(err);
    end;
    
    if H5L.exists(groupID, nextPart, 'H5P_DEFAULT');
%         fprintf('Path "%s/%s": link exists\n', partialPartsString, nextPart);
        H5G.close(groupID);
    else
%         fprintf('Path "%s/%s": link does not exist\n', partialPartsString, nextPart);
        doesExist = false;
        break;
    end;
    
    iPart = iPart + 1;
end;

H5F.close(fileID);

end