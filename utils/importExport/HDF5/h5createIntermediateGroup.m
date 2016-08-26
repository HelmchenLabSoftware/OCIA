% creates an intermediate group in the HDF5 file so that group exists whenever an attribute needs to be attached to it
function h5createIntermediateGroup(fileName, groupPath)

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
    % ... if no error, then group exists so abort
    return;
catch err; %#ok<NASGU>
    % error mean no group, so one can create it
end;

% create group creation property list and set it to allow creation of intermediate groups
gPropList = H5P.create('H5P_LINK_CREATE');
H5P.set_create_intermediate_group(gPropList, 1);
% create the group at groupPath
gID = H5G.create(fID, groupPath, gPropList, 'H5P_DEFAULT', 'H5P_DEFAULT');
% close all
H5P.close(gPropList);
H5G.close(gID);
H5F.close(fID);

end