function varargout = pplot(data,varargin)
% Petersen plot for columns in data

% this file written by Henry Luetcke (hluetck@gmail.com)

if isempty(data)
   return 
end

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

if nargin > 3
   plotAll = varargin{3};
else
    plotAll = 1;
end

if nargin > 4
    Xaxis = varargin{4};
else
    Xaxis = 1:size(data,2);
end

if nargin > 5
    XaxisLabel = varargin{5};
else
    for n = 1:length(Xaxis)
        XaxisLabel{n} = mat2str(Xaxis(n));
    end
end

if nargin > 6
    doStats = varargin{6};
else
    doStats = 0;
end

% hFig = figure;
% hold all
if plotAll
    for n = 1:size(data,1)
        plot(Xaxis,data(n,:),'Color',[0.8 0.8 0.9],...
            'LineWidth',1,'Marker',marker), hold on
    end
end

switch lower(varMeasure)
    case 'sem'
        varData = nanstd(data,0,1) ./ sqrt(size(data,1));
    case 'sd'
        varData = nanstd(data,0,1);
end

hErr = errorbar(Xaxis,nanmean(data,1),varData,'Color',[1 0 0],...
    'LineStyle','none','LineWidth',3,'Marker','s');
removeErrorBarEnds(hErr)
set(gca,'xtick',Xaxis)
set(gca,'xlim',[Xaxis(1)-0.1 Xaxis(length(Xaxis))+0.1])
set(gca,'xticklabel',XaxisLabel)

% if nargout
%    varargout{1} = hFig;
% end

%% statistical analysis
if ~doStats
   return 
end

if size(data,2) == 1 % 1 sample t-test
    [h,p,ci,stats] = ttest(data);
    titleStr = sprintf('Mean=%1.3f SD=%1.3f SEM=%1.3f N=%1.0f',nanmean(data),...
        nanstd(data),sem(data),numel(data));
    titleStr = sprintf('%s\nT=%1.3f P=%1.3e DF=%1.0f',titleStr,stats.tstat,p,stats.df);
elseif size(data,2) == 2 % repeated measures t-test
    [h,p,ci,stats] = ttest(data(:,1),data(:,2));
    titleStr = sprintf('Mean1=%1.3f SD1=%1.3f SEM1=%1.3f N=%1.0f',nanmean(data(:,1)),...
        nanstd(data(:,1)),sem(data(:,1)),size(data,1));
    titleStr = sprintf('%s\nMean2=%1.3f SD2=%1.3f SEM2=%1.3f',titleStr,nanmean(data(:,2)),...
        nanstd(data(:,2)),sem(data(:,2)));
    titleStr = sprintf('%s\nT=%1.3f P=%1.3e DF=%1.0f',titleStr,stats.tstat,p,stats.df);
else % repeated measures ANOVA
    titleStr = 'ANOVA not implemented';
end

title(titleStr)







