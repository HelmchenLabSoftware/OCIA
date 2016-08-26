function figOut = makePrettyFigure(varargin)
% for a given figure, apply some operations to make it look nicer

if nargin == 0;
    fig = gcf;
else
    fig = varargin{1};
end;

figOut = fig;

% a cell array of default axis properties (column 1 is the property name,
% column 2 is the property value)
defaultProps = { ...
    'box','off'; ...
    'linewidth',1.5; ...
    'fontname','arial'; ...
    'fontsize',14; ...
    };

% some basic niceties on the figure
set(fig,'color','white')

% get children (the axes)
figHandles = findall(fig);

for n = 1:numel(figHandles)
    setDefaultAxesProps(figHandles(n),defaultProps);
end

set(findall(0,'tag','legend'),'box','on')


function setDefaultAxesProps(a,defaultProps)
for n = 1:size(defaultProps,1)
    try
        set(a,defaultProps{n,1},defaultProps{n,2})
    end
end
% children = get(a,'children');
% for n = 1:numel(children)
%     for m = 1:size(defaultProps,1)
%         try
%             set(children(n),defaultProps{m,1},defaultProps{m,2})
%         end
%     end
% end



