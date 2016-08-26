function eplot(data,varargin)
% Plot of mean and errors for columns in data

% this file written by Henry Luetcke (hluetck@gmail.com)

if nargin > 1
    varMeasure = varargin{1};
else
    varMeasure = 'sem';
end

if nargin > 2
    marker = varargin{2};
else
    marker = 'none';
end

hold all
meanData = nanmean(data,1);

switch lower(varMeasure)
    case 'sem'
        varData = sem(data);
    case 'sd'
        varData = nanstd(data,1);
end
xError = [1:size(data,2) size(data,2):-1:1];
yError = [meanData-varData fliplr(meanData+varData)];
fill(xError,yError,[0.75 0.75 0.75],'EdgeColor','none')
plot([1:size(data,2)],meanData,'Color',[1 0 0],...
    'LineWidth',3,'Marker',marker)

set(gca,'xtick',[1:size(data,2)],'xlim',[0.8 size(data,2)+0.2])





