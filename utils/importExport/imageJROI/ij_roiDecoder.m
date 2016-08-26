function ROISet = ij_roiDecoder(filename,dims)
% decode ImageJ ROI into Matlab matrix with given dimensions
% supported ROI types: polygon (0), freehand (7), ellipse (2), rectangle
% (1), point (10), line (5)
% 2009-05-03::hluetck - Added ij ROI manager support
% read zip-archive of ij ROIs of equal dimensions and return cell array of
% roi names and corresponding masks

% this file written by Henry Luetcke (hluetck@gmail.com)
% modified by Balazs Laurenczy on 2014-08-05 (blaurenczy@gmail.com)

offset = 23;

[~, ~, ext] = fileparts(filename);

switch ext
    case '.roi'
        roi_files = { filename };
        ROISet = cell(1,4);
        [~, name, ext2] = fileparts(filename);
        ROISet{1, 1} = [name ext2];
    case '.zip'
        tmpdir = [datestr(clock,30) '_' num2str(randi(100000))];
        mkdir(tmpdir);
        roi_files=unzip(filename,tmpdir);
        ROISet = cell(length(roi_files),4);
        for n = 1:length(roi_files)
            [~, name, ~] = fileparts(roi_files{n});
            ROISet{n,1} = name;
        end
    otherwise
        error('ij_roiDecoder expects input files of type .roi or .zip');
end

roiTypeNames = { 0, 7, 2, 1, 10, 5; 'poly', 'freehand', 'ellipse', 'rect', 'point', 'line' };

for roi_number = 1:length(roi_files)
    current_roi = roi_files{roi_number};
    fid = fopen(current_roi,'r','ieee-be'); %'IEEE floating point with big-endian byte ordering'
    hd = fread(fid,8,'uint8');
    
    % check that this is an ImageJ roi
    if ~isequal(hd(1:2),[73 111]')
        error('%s does not contain a valid ImageJ roi\n',current_roi);
    end
    roi_type = hd(7);
    ROISet{roi_number, 2} = roiTypeNames{cell2mat(roiTypeNames(1, :)) == roi_type, 2};
    
    
    coord = fread(fid,5,'int16');
    top = coord(1);
    left = coord(2);
    bottom=coord(3);
    right = coord(4);
    width= right-left;
    height = bottom-top;
    % the number of specified coordinates (for free ROIs)
    n = coord(5);
%     coord= fread(fid,inf,'int16');
   data = fread(fid,inf,'int16');
   fclose(fid);
    
   if roi_type == 0 || roi_type == 7
       data(1:offset) = [];
       x = data(1:n);
       data(1:n) = [];
       y = data(1:n);
       x = x + left;
       y = y + top;
       roicoords=[x y];
       mask = poly2mask(x,y,dims(1),dims(2));
       
   elseif roi_type == 2
       % ellipse ROIs
       % equation for an ellipse is x^2/a^2 + y^2/b^2 = 1
       mask = zeros(dims);
       roicoords = [left, top, width, height];
       for x = 1:dims(2)
           for y = 1:dims(1)
               twoDx = 2*x - (2*left+width-1);
               twoDy = 2*y - (2*top+height-1);
               value = twoDx^2/width^2 + twoDy^2/height^2;
               if value < 1
                   mask(y,x) = 1;
               end
           end
       end
   elseif roi_type == 1
       % rectangular ROIs
       x_pos_vect = [left left+width left+width left];
       y_pos_vect = [top top top+height top+height];
       roicoords=[x_pos_vect' y_pos_vect'];
       mask = poly2mask(x_pos_vect,y_pos_vect,dims(1),dims(2));
   elseif roi_type == 3
       mask = zeros(dims);
       y1 = coord(1); x1 = coord(2); y2 = coord(3); x2 = coord(4);
       % find the line that connects (x1,y1) and (x2,y2)
       slope = (y2-y1)/(x2-x1);
       intercept = y1 - slope*x1;
       for x = 1:dims(2)
           for y = 1:dims(1)
               if y == round(slope*x+intercept) && y >= y1 && y <= y2 && ...
                       x >= x1 && x <= x2
                   mask(y,x) = 1;
               end
           end
       end
   elseif roi_type == 10
       % point ROI
       mask = zeros(dims);
       data(1:offset) = [];
       x = data(1:n);
       data(1:n) = [];
       y = data(1:n);
       x = x + left;
       y = y + top;
       roicoords = [x y];
       mask(y,x) = 1;
       
   elseif roi_type == 5
       mask = zeros(dims);
       
       x=left + coord;
       y=top + coord;
       
       m=length(x);
       x=x(m-2*n+1:m-n);  %reading backward
       y=y(m-n+1:m);
       % interpolate
       xI = interp1(x,1:0.001:numel(x),'spline');
       yI = interp1(y,1:0.001:numel(y),'spline');
       roicoords = [xI' yI'];
       for k = 1:size(roicoords,1)
           try
               if round(roicoords(k,2)+1) <= dims(1) && ...
                       round(roicoords(k,1)+1) <= dims(2) && ...
                       round(roicoords(k,2)+1) > 0 && ...
                       round(roicoords(k,1)+1) > 0
                   mask(round(roicoords(k,2)+1),round(roicoords(k,1)+1)) = 1;
               end
           catch err
               rethrow(err);
           end
       end
       % enlarge by 1 pixel
       enlarge = 1;
       [x,y] = find(mask);
       for n = 1:numel(x)
           for row = x(n)-enlarge:x(n)+enlarge
               for col = y(n)-enlarge:y(n)+enlarge
                   if row > 0 && col > 0 && row <= dims(1) && ...
                           col <= dims(2)
                       mask(row,col) = 1;
                   end
               end
           end
       end
       
   else
       error('Roi type %1.0f not recognized',roi_type);
   end
    
    ROISet{roi_number,3} = roicoords;
    ROISet{roi_number,4} = mask;
end

switch ext
    case '.zip'
        rmdir(tmpdir,'s');
end

ROISet = SortCellByColumn(ROISet,1);
