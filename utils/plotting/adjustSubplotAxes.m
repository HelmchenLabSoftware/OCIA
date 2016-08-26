function adjustSubplotAxes(h,varargin)
% adjust axis of all subplots in figure h
% specify axis by string / value combination, e.g.:
% 'X',[-5 10] sets all x-limits to [-5 10]
% 'Y',[] sets y-limits to Min / Max
% unlisted axes are left untouched
% varargin{1} ... the axis limits to be set (default: Min / Max)

inargs = varargin;
xLims = NaN;
yLims = NaN;
zLims = NaN;
for n = 1:numel(inargs)
    if isstr(inargs{n})
        switch lower(inargs{n})
            case 'x'
                xLims = inargs{n+1};
            case 'y'
                yLims = inargs{n+1};
            case 'z'
                zLims = inargs{n+1};
        end
    end
end

% get all axes of the figure h
axisHandles = findobj(h,'Type','Axes');
legendHandles = findobj(h,'Tag','legend');
for n = 1:numel(legendHandles)
   props{n} = get(legendHandles(n));
end

% set axes
if ~any(isnan(xLims))
   setLimits('xlim',xLims,axisHandles);
end

if ~any(isnan(yLims))
   setLimits('ylim',yLims,axisHandles);
end

if ~any(isnan(zLims))
   setLimits('zlim',zLims,axisHandles);
end

% reset legend props
for n = 1:numel(legendHandles)
    fields = fieldnames(props{n});
    for m = 1:numel(fields)
        try
            set(legendHandles(n),fields{m},props{n}.(fields{m}))
        end
    end
end

function setLimits(type,lims,axisHandles)
if isempty(lims)
    % find axis limits of all axes
    lims = [inf -inf];
    for n = 1:numel(axisHandles)
        currentLims = get(axisHandles(n),type);
        lims(1) = min([lims(1) currentLims(1)]);
        lims(2) = max([lims(2) currentLims(2)]);
    end
end
set(axisHandles,type,lims)

