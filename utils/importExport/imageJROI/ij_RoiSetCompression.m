function roi = ij_RoiSetCompression(roi,flag)
% roi ... ij roi set, created by ij_roiDecoder
% flag ... 1 = compress, 2 = decompress
% compression takes a standard roi set and stores only mask points and mask
% size for each roi
% decompression converts a compressed roi set to the full mask

% this file written by Henry Luetcke (hluetck@gmail.com)

if flag == 1
    for n = 1:size(roi,1)
        [x,y] = find(roi{n,2});
        dims = size(roi{n,2});
        roi{n,2} = [x,y];
        roi{n,3} = dims;
    end
elseif flag == 2
    if size(roi,2) < 3
        % not a valid compressed Roi set
        warning('Not a valid compressed RoiSet.');
        return
    end
    for n = 1:size(roi,1)
        mask = zeros(roi{n,3});
        currentRoi = roi{n,2};
        for m = 1:size(currentRoi,1)
            mask(currentRoi(m,1),currentRoi(m,2)) = 1;
        end
        roi{n,2} = logical(mask);
    end
    roi(:,3) = [];
end