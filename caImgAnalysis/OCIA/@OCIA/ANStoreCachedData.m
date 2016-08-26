function ANStoreCachedData(this, modeName, hashParamStruct, cachedData)
% ANStoreCachedData - [no description]
%
%       ANStoreCachedData(this, modeName, hashParamStruct, cachedData)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the "hash" ID of the parameter structure
selectedRowsHashID = [hashParamStruct.dataType, '_', matlab.lang.makeValidName(DataHash(hashParamStruct))];
% store this key as being the last one used
this.an.(modeName).dataHash.lastHashID = selectedRowsHashID;
% store the cached data
this.an.(modeName).dataHash.(selectedRowsHashID) = cachedData;

end