function out = downSampleBinAvg(in, iDim, binFactor)
% out = downSampleBinAvg(in, iDim, binFactor)

    sizeBefore = size(in);
    
    sizeMiddle = [sizeBefore(1 : iDim - 1), binFactor, sizeBefore(iDim) / binFactor, sizeBefore(iDim + 1 : length(sizeBefore))];
    
    sizeAfter = sizeBefore;
    sizeAfter(iDim) = sizeAfter(iDim) / binFactor;
    
    out = reshape(sum(reshape(in, sizeMiddle), iDim), sizeAfter);
    
end