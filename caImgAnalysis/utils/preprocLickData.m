function lickRateUS = preprocLickData(lickDataCell, lickThreshHard, sampRate, doPlots)

lickRateBinSize = 0.05; % in s (e.g. 0.05 for 50 ms bins)

for n = 1 : numel(lickDataCell);
    lickV = lickDataCell{n};
    t = (1 : numel(lickV)) ./ sampRate;
    
    try
        
        % filter the lick vector
        lickVfilt = filterLickVector(lickV, doPlots);
        lickVfilt(lickVfilt < lickThreshHard) = 0;

        % onsets for each 'lick'
        lickOn = zeros(1, numel(lickV));
        for m = 2 : numel(lickOn)
            if lickVfilt(m) && ~lickVfilt(m - 1)
                lickOn(m) = 1;
            end;
        end;
    
        % 'lick rate' based on onsets
        lickTimes = t(lickOn > 0);
        tt = t(1) : lickRateBinSize : t(end);
        [lickRate, tt] = instantfr(lickTimes, tt);
        lickRateUS = interp1(tt, lickRate, t);
        
    catch err;
        
        o(' Error while pre-processing lick data : %s.', err.identifier, 0, 0);
        % fill with nans
        lickRateUS = nan(size(lickV));
        
    end;
    
    if doPlots;
        
        figure('Name', sprintf('Trial %1.0f', n), 'NumberTitle', 'off')
        plot(t, lickV, 'k', 'linewidth', 2), hold on
        plot(t, lickVfilt, 'r--', 'linewidth', 1.5)
        plot(tt, lickRate ./ 1000, 'y--', 'linewidth', 1.5)
        plot(t, lickRateUS ./ 1000, 'b--', 'linewidth', 1.5)
        xlabel('Time (s)'), legend({'raw', 'filt', 'rate/1000', 'rateUS/1000'})
        
    end;
    
end;

end


function out = filterLickVector(in, doPlots)

in = abs(in);

% lick data histogram
[count,xout] = hist(in,sqrt(numel(in)));

% optional: plot histogram
if doPlots
    figure('Name','Histogram','NumberTitle','off')
    plot(xout,count,'k'), hold on
end

% fit double-peaked gaussian to histogram
fObj = fit(xout',count','gauss2');
% optional: plot fit
if doPlots;
    plot(fObj,'r--')
end

% pull out peaks and widths from fit
peaks = [fObj.b1 fObj.b2];
width = [fObj.c1 fObj.c2];
% sort so that first peak is the more negative one
[peaks,ix] = sort(peaks);
width = width(ix);
% width as SD
width = width ./ sqrt(2);
% probability of each data point based on normal distribution
p = 1-normcdf(in,peaks(2),width(2));

% threshold p-value --> this will be adjusted for the number of data points
pThresh = 0.001;
pThresh = pThresh ./ numel(in);

% threshold
thresh = in;
thresh(p>pThresh) = 0;

% binarize
thresh_bin = thresh;
thresh_bin(thresh_bin>0) = 1;

% discard segments smaller minSiz
minSiz = 3;
cc = bwconncomp(thresh_bin);
for n = 1:numel(cc.PixelIdxList)
    if numel(cc.PixelIdxList{n})<minSiz
        thresh_bin(cc.PixelIdxList{n}) = 0;
    end
end

% join adjacent segments
minSeparation = 50;
cc = bwconncomp(thresh_bin);
if numel(cc.PixelIdxList) > 1
    for n = 2:numel(cc.PixelIdxList)
        currentSegment = cc.PixelIdxList{n};
        previousSegment = cc.PixelIdxList{n-1};
        if currentSegment(1)-previousSegment(end) <= minSeparation
            thresh_bin(previousSegment(end):currentSegment(1)) = 1;
        end
    end
end

thresh(~thresh_bin) = 0;

out = thresh;

end



