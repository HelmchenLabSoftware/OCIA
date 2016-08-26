function mask = reshapeRoiMask(mask,varargin)
% transforms an input mask into a new shape
% in1 ... input mask (binary)
% in2 ... new shape {'FilledCircle'} 'EmptyCircle' 'Point'
% in3 ... circle radius in pixel {2.5}

% this file written by Henry Luetcke (hluetck@gmail.com)

if nargin > 1
   maskType = varargin{1};
else
    maskType = 'FilledCircle';
end

if nargin > 2
   radius = varargin{2};
else
    radius = 2.5;
end

[row,col] = find(mask==1);

cog = [mean(row) mean(col)];

switch maskType
    case 'FilledCircle'
        t = linspace(0,2*pi,100);
        xval = radius*cos(t) + cog(1);
        yval = radius*sin(t) + cog(2);
        vert = [yval' xval'];
        mask = zeros(size(mask));
        for n = 1:size(vert,1)
            row = vert(n,2); col = vert(n,1);
            row = cog(1) + (row - cog(1));
            col = cog(2) + (col - cog(2));
            minRow = floor(row); minRow(minRow<1) = 1;
            maxRow = ceil(row); maxRow(maxRow>size(mask,1)) = size(mask,1);
            minCol = floor(col); minCol(minCol<1) = 1;
            maxCol = ceil(col); maxCol(maxCol>size(mask,2)) = size(mask,2);
            mask(minRow:maxRow,minCol:maxCol) = 1;
        end
        mask = imfill(mask,'holes');
end
