function status = ij_roiEncoder(mask,filename)
% encode Matlab mask (binary) image into ImageJ ROI file 
% strategy: create edge image of mask, then write coordinates of all
% non-zero pixels into binary .roi-file of freehand type

% this file written by Henry Luetcke (hluetck@gmail.com)

status = 0;

% binarize mask image
mask(mask~=0)=1;

if length(find(mask)) == 1 % point Roi
    roiType = 10;
    [row,col] = find(mask);
else
    roiType = 0;
    % find the edges for clusters
    mask_edge = bwperim(mask,8);
    % se = strel('disk',3,0);
    % mask_edge = imdilate(mask_edge,se);
    % mask_edge = bwperim(mask_edge,8);
    % figure
    % imshow(mask_edge,[]);
    
    % all the non-zeros in mask_edge
    [row,col] = find(mask_edge==1);
    if length(row) < 5
        error('ROI must contain more than 5 pixels');
    end
    
    % use bwtraceboundary
    try
        B = bwtraceboundary(mask_edge,[row(1) col(1)],'N');
        status = 1;
    catch
        return
    end
    row = B(:,1);
    col = B(:,2);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% old manual tracing (possibly requires ROI dilation)
% points = 1;
% point_list = [row(1) col(1)];
% FullCircle = 0;
% SkipPoint = 0;
% PointFound = 0;
% while true
%     for x = point_list(points,1)+1:-1:point_list(points,1)-1
%         for y = point_list(points,2)+1:-1:point_list(points,2)-1
%             if x < 1 || y < 1 || x > size(mask_edge,1) || y > size(mask_edge,2)
%                continue 
%             end
%             if [x y] == point_list(points,:)
%                 continue
%             end
%             if ~mask_edge(x,y)
%                 continue
%             end
%             % if we come to the start point again and at least 5 points
%             % have been found in-between, we assume that the ROI has been
%             % closed
%             if size(point_list,1) > 5
%                if [x y] == point_list(1,:)
%                    FullCircle = 1;
%                    break
%                end
%             end
%             % skip point if it has been found before
%             for n = 1:size(point_list,1)
%                 if [x y] == point_list(n,:)
%                     SkipPoint = 1;
%                     break
%                 end
%             end
%             if ~SkipPoint
%                 points = points + 1;
%                 point_list(points,:) = [x y];
%                 PointFound = 1;
%                 break
%             else
%                 SkipPoint = 0;
%             end
%         end
%         if FullCircle
%             break
%         end
%         if PointFound
%             break
%         end
%     end
%     if FullCircle
%         status = 1;
%         break
%     end
%     if ~PointFound
%        warning('Failed to convert this ROI (possibly too small).');
%        return
%     else
%         PointFound = 0;
%     end
% end
% row = point_list(:,1);
% col = point_list(:,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% translate ML coordinates into ImageJ coordinates
% NIH roi format stored coordinates with respect to left and top
% coordinates
% ROI boundaries
left = min(col);
top = min(row);
right = max(col);
bottom = max(row);
pixels = length(row);
% all values relative to top-left
row = row-top;
col = col-left;

% write the header
fid = fopen(filename,'w','ieee-be');
fwrite(fid,[73 111 117 116 0 217 roiType 0],'uint8');
fwrite(fid,[top-1 left-1 bottom-1 right-1 pixels],'int16');
% write zeros for unused and ShapeROI positions
for n = 1:23
    fwrite(fid,[0],'int16');
end
% now the coordinates
% write xy-coordinates
x = col;
y = row;
for n = 1:length(x)
    fwrite(fid,x(n),'int16');
end
for n = 1:length(y)
    fwrite(fid,y(n),'int16');
end
fclose(fid);




