function ij_roiResize(infile,dimIn,outfile,dimOut)

% this file written by Henry Luetcke (hluetck@gmail.com)

roiSet = ij_roiDecoder(infile,dimIn);
roiFiles = {};
for roi = 1:size(roiSet,1)
    currentRoiName = roiSet{roi,1};
    currentMask = roiSet{roi,2};
    [row,col] = find(currentMask);
    maskOut = zeros(dimOut);
    for n = 1:numel(row)
        pixelMask = zeros(size(currentMask));
        pixelMask(row(n),col(n)) = 1;
        pixelMask = imresize(pixelMask,dimOut);
        [val,idx] = max(pixelMask(:));
        pixelMask = zeros(size(pixelMask));
        pixelMask(idx) = 1;
        maskOut(pixelMask==1) = 1;
    end
    status = ij_roiEncoder(maskOut,[currentRoiName '.roi']);
    roiFiles{1,roi} = [currentRoiName '.roi'];
end
zip(outfile,roiFiles)

delete(roiFiles{:})