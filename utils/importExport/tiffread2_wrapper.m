function img = tiffread2_wrapper(varargin)
% wrapper function which calls tiffread2 and reformats the output structure
% all inputs are options
% in1 ... filename {GUI select}
% in2 ... start idx {1}
% in3 ... stop idx {last idx}

% tiffread2 by:
% Francois Nedelec, EMBL, Copyright 1999-2006.

% this file written by Henry Luetcke (hluetck@gmail.com)

if ~nargin
    img = tiffread2;
else
    img = tiffread2(varargin{:});
end

sizeX = img(1,1).width;
sizeY = img(1,1).height;
sizeT = numel(img);
imgOut.data = zeros(sizeY,sizeX,sizeT);
for n = 1:sizeT
    imgOut.data(:,:,n) = img(1,n).data;
end

% TODO: parse the file info description
S = 'Not trying to read XML header';
% try
%     xmlFilename = ['tmp_' datestr(clock,30) '.xml'];
%     fid = fopen(xmlFilename,'w');
%     fprintf(fid,'%s',img(1,1).descriptor);
%     fclose(fid);
% %     xmlStruct = parseXML(xmlFilename);
% %     BrowseXMLstruct(xmlStruct);
% %     clear global Sout
% %     % structure now as Sout in base ws
% %     S = evalin('base','Sout');
% %     evalin('base','clear Sout');
% catch
%     warning('Failed to read XML header.');
%     S = 'Failed to read XML header';
% end
% 
% try
%     delete(xmlFilename);
% end

imgOut.header.info = S;
imgOut.header.size = [sizeX sizeY sizeT];
imgOut.header.filename = img(1,1).filename;
imgOut.header.bits = img(1,1).bits;
imgOut.header = orderfields(imgOut.header);
img = imgOut;