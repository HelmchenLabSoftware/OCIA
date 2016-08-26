function [yDS, tDS] = interp1DS(frameRate, frameRateDS, y)

t = (1 : numel(y)) / frameRate;
tDS = t(1) : 1 / frameRateDS : t(end);
yDS = interp1(t, y, tDS);
    
end