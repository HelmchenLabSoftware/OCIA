function plotVarLines2D(a,percentile,minMax,resolution,doSmooth,doScatter)
% plot the 2d variance line of the n by 2 matrix a

% this file written by Henry Luetcke(hluetck@gmail.com)

maxVal = minMax(2);
minVal = minMax(1);
% bin y-data according to x-data in bins with given resolution
binX = zeros(1,2);
binY = zeros(1,2);
pos = 1;
binVector = minVal:resolution:maxVal;
for n = 2:length(binVector)
    % bin x-axis
    currentY = a(:,2);
    currentX = a(:,1);
    currentY = currentY(currentX<binVector(n)&currentX>=binVector(n-1));
    binY(pos,1) = prctile(currentY,100-percentile);
    binY(pos,2) = prctile(currentY,percentile);
    % bin y-axis
    currentY = a(:,2);
    currentX = a(:,1);
    currentX = currentX(currentY<binVector(n)&currentY>=binVector(n-1));
    binX(pos,1) = prctile(currentX,100-percentile);
    binX(pos,2) = prctile(currentX,percentile);
    
    pos = pos + 1;
end
binVector(1) = []; binVector = binVector - (resolution/2);
fig = figure; hold on
if doScatter
    scatter(a(:,1),a(:,2),'.')
end

if doSmooth
    windowSize = doSmooth;
    binY = filter(ones(1,windowSize)/windowSize,1,binY);
end

plot(binVector,binY(:,1),'k','LineWidth',1.5)
plot(binVector,binY(:,2),'k','LineWidth',1.5)

% plot(binX(:,1),binVector,'r')
% plot(binX(:,2),binVector,'r')

set(gca,'xlim',[minVal maxVal],'ylim',[minVal maxVal])