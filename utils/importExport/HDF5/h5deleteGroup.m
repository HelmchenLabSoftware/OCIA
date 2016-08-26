% delete a group in the HDF5 file
function h5deleteGroup(fileName, groupPath)

% if file does not exist, create a new file using the default properties
if ~exist(fileName, 'file');
    fID = H5F.create(fileName, 'H5F_ACC_TRUNC', 'H5P_DEFAULT', 'H5P_DEFAULT');
% if file exists, open it using the default properties
else
    fID = H5F.open(fileName, 'H5F_ACC_RDWR', 'H5P_DEFAULT');
end;
% check if the group does not already exist
try
    % try to fetch the info for this group ...
    H5G.get_objinfo(fID, groupPath, false);
    % ... if no error, then group exists, so go on ...
catch err; %#ok<NASGU>
    % error means no group, so nothing to do
    return;
end;

% delete the object
H5L.delete(fID, groupPath, 'H5P_DEFAULT');

% close all
H5F.close(fID);

end