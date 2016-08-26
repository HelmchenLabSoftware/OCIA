function h = imgOverlay(img,roiSet)

transpValue = 0.75;

dims = size(img);

roiRgb = zeros(dims(1),dims(2),3);
cmap = jet(size(roiSet,1));
alphaMat = ones(size(img));
roiCounterImg = zeros(size(img));

for n = 1:size(roiSet,1)
    roiID = roiSet{n,1};
    if strcmp(roiID,'npil') % exclude neuropil
        continue
    end
    mask = roiSet{n,2};
    alphaMat(mask) = transpValue;
    if ~isempty(str2num(roiID))
        roiCounterImg(mask==1) = str2num(roiID);
        [row, col] = ind2sub(size(img),find(mask));
        for idx = 1:length(row)
            for color = 1:3
                roiRgb(row(idx),col(idx),color) = ...
                    cmap(n,color);
            end
        end
    end
end

h = imshow(roiRgb,[],'initialmagnification','fit'); hold on
h = imshow(img,[]);
set(h,'AlphaData',alphaMat);
try
    s = regionprops(roiCounterImg,roiCounterImg, ...
        'MaxIntensity','Extrema');
catch
    disp('error');
end
hold(gca, 'on');
for k = 1:numel(s)
    e = s(k).Extrema;
    val = s(k).MaxIntensity;
    text(e(1,1), e(1,2)-1, sprintf('%d', val), ...
        'Parent', gca, ...
        'Clipping', 'on', ...
        'Color', 'r', ...
        'FontWeight', 'bold', ...
        'Tag', 'CellLabel');
end
drawnow



