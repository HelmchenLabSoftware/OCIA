function [slice, slice1D, imgTransformedRotated, imgTransformed] = rotateAndSlice_guy(img, centerX, centerY, rotAngle, sliceWidth)
    %transform so that rotation point is in the middle
    showSlices = false;
    halfWidths = [floor(sliceWidth/2) floor(sliceWidth/2)-~mod(sliceWidth,2)];
    realCenter = round(round([size(img, 1) size(img, 2)])/2);
    offsetsXY = realCenter- [centerY centerX];

    tform = maketform('affine',[1 0 offsetsXY(1); 
                                                    0 1 offsetsXY(2); 
                                                    0 0     1]');
    for sliceNum = 1:size(img, 3)
        imgTransformed(:,:,sliceNum) = imtransform(img(:,:,sliceNum),tform,'XData',[1 size(img,2)],'YData',[1 size(img,1)]);
        %rotate by X degrees
        imgTransformedRotated(:,:,sliceNum) = imrotate(imgTransformed(:,:,sliceNum), rotAngle, 'nearest', 'crop');
        slice(:,:,sliceNum) = imgTransformedRotated(1:end, realCenter(1)-halfWidths(1):realCenter(1)+halfWidths(2), sliceNum);
        slice1D(:,:,sliceNum) = mean(slice(:,:,sliceNum), 2);
        sliceWContour(:,:,sliceNum) = imgTransformedRotated(:,:,sliceNum);
        sliceWContour(1:end, realCenter(1)-halfWidths(1),sliceNum) = 0;
        sliceWContour(1:end, realCenter(1)+halfWidths(2),sliceNum)=0;
    end
    if(showSlices)
%         myimagesc(img, 100, [0 0.002], round(rand*100000), false, 'mapgeog', 0.5, 1);
        myimagesc(sliceWContour, 100, [0 0.002], round(rand*100000), false, 'mapgeog', 0.5, 1);
%         myimagesc(slice, 100, [0 0.002], round(rand*100000), false, 'mapgeog', 0, 1)
    end
end