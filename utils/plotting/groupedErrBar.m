function h = groupedErrBar(dataCell,varargin)
% plot multiple data sets in groups with errorbar and (optionally) individual data points
% dataCell ... cell array with 1 vector per cell containing n observations
% cells in the same row will be grouped, cells in different rows will be different groups (similar
% to bar function)
% optional input args ({'parameter',value} pairs):
% 'plotAll' ... plot individual observations in addition to mean / error (0 or 1)
% 'avg' ... 'mean', 'median'
% 'var' ... 'sd', 'sem', 'ci' (ci is 95% CI of the mean and should not be used with median)
% 'separation' ... 0.2 (determines the separation of groups)
% 'xticklabel' ... {'1','2','3'} (name of each group)
% 'legend' ... legend entry for each column
% doStats ... 0 or 1 (default: 0) --> print out stats comparison for each group
% output: handle vector
% Example:
% A = {randn(10,1) randn(8,1) randn(12,1); randn(5,1) randn(9,1) randn(7,1)};
% groupedErrBar(A,'var','sem','plotall',1,'xticklabel',{'G1','G2'},'legend',{'t1','t2','t3'})
% this function requires the statistics toolbox

% TODO: further measures of central tendency and variability (e.g. CI); assymetric error bars; stats

if nargin > 1
    config = parseInputArgs(varargin);
else
    config = parseInputArgs; % defaults
end

dataSize = size(dataCell);
% calculate corresponding x-axis
xCoarse = 1:dataSize(1); % the different groups
x = [];
for n = 1:dataSize(1)
    x = [x, linspace(xCoarse(n)-config.separation,xCoarse(n)+config.separation,dataSize(2))];
end

% run ANOVA on entire data set
if config.doStats
    anovaData = [];
    anovaLabels = cell(1,2);
    for row = 1:dataSize(1)
        for col = 1:dataSize(2)
            anovaData = [anovaData; dataCell{row,col}];
            anovaLabels{1,1} = [anovaLabels{1,1}; repmat(row,numel(dataCell{row,col}),1)];
            anovaLabels{1,2} = [anovaLabels{1,2}; repmat(col,numel(dataCell{row,col}),1)];
        end
    end
    [~,table] = anovan(anovaData,anovaLabels,'display','off','model','full',...
        'varnames',{'Row','Column'});
    fprintf('\nANOVA table:\n')
    disp(table)
end

colorMap = lines(dataSize(2)); % different color for each entry per group

% now just go sequentially through the data and plot
xPos = 0;
for row = 1:dataSize(1)
    for col = 1:dataSize(2)
        xPos = xPos + 1;
        data = dataCell{row,col};
        config.avgColor = colorMap(col,:);
        if row == dataSize(1)
            config.setLegend = 1;
        else
            config.setLegend = 0;
        end
        doPlot(x(xPos),data,config);
    end
    if config.doStats
       anovaData = []; labels = [];
       for col = 1:dataSize(2)
           anovaData = [anovaData; dataCell{row,col}];
           labels = [labels; repmat(col,numel(dataCell{row,col}),1)];
       end
       [~,table,stats] = anovan(anovaData,labels,'display','off');
       if isempty(config.xticklabel)
           fprintf('\nStats - %1.0f\n',row)
       else
           fprintf('\nStats - %s\n',config.xticklabel{row})
       end
       fprintf('F=%1.3f p=%1.5e df=%1.0f\n',table{2,6},table{2,7},table{3,3})
    end
end

% label axis
if isempty(config.xticklabel)
    set(gca,'xtick',1:dataSize(1))
else
    set(gca,'xtick',1:dataSize(1),'xticklabel',config.xticklabel)
end
set(gca,'xlim',[0 x(end)+x(1)]), ylabel(sprintf('%s +- %s',config.avg,config.var))
legend(config.legend)

makePrettyFigure(gcf);
end


function doPlot(x,data,config)

switch lower(config.avg)
    case 'mean'
        avgData = nanmean(data);
    case 'median'
        avgData = nanmedian(data);
    otherwise
        error('Avg measure %s not supported',config.avg)
end

switch lower(config.var)
    case 'sd'
        varData = nanstd(data);
    case 'sem'
        varData = sem(data);
    case 'ci'
        [~,~,varData] = normfit(data);
    otherwise
        error('Var measure %s not supported',config.var)
end

if config.plotAll
    hScatter = scatter(repmat(x,numel(data),1),data,'Marker','o','MarkerEdgeColor',[0.5 0.5 0.5]); hold on
    set(get(get(hScatter,'Annotation'),'LegendInformation'),...
        'IconDisplayStyle','off');
end

xErr = x - config.separation./10; % slightly offset
if numel(varData) == 1
    hErr = errorbar(xErr,avgData,varData,...
        'Marker','s','Color',config.avgColor,'LineStyle','none');
else
    hErr = errorbar(xErr,avgData,varData(1),varData(2),...
        'Marker','s','Color',config.avgColor,'LineStyle','none');
end
removeErrorBarEnds(hErr); hold on
if ~config.setLegend
    set(get(get(hErr,'Annotation'),'LegendInformation'),...
        'IconDisplayStyle','off');
end

end

function config = parseInputArgs(varargin)

if nargin
    inArgs = varargin;
else
    inArgs = {[]};
end

inArgs = inArgs{1};
config = struct;
requiredArgs = {'plotAll','avg','var','separation','xticklabel','legend','doStats'};
defaults = {1,'mean','sem',0.2,[],[],0};
for n = 1:numel(requiredArgs)
    if isempty(find(strcmpi(inArgs,requiredArgs{n}), 1))
        config.(requiredArgs{n}) = defaults{n};
    else
        config.(requiredArgs{n}) = inArgs{find(strcmpi(inArgs,requiredArgs{n}),1)+1};
    end
end


end