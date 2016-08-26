function binned_data = plotsp2(xaxis,data, xbin, ybin, xsize, ysize, hold)
%PLOTSP	plot super pixels ...
%	BINNED_DATA = SP(DATA, XBIN, YBIN, XSIZE, YSIZE, HOLD)
%
% 
% Hamutal Slovin, 2005
colors= get(gca,'coloro');
ncolors=size(colors,1);

if (nargin >= 4),	% called from command line with at least 3 args

	if     (nargin == 4); xsize=64; ysize=64; hold=0; 
	elseif (nargin == 5); hold = xsize; xsize=64; ysize=64; 
	elseif (nargin == 6); hold = 0; 
	elseif (nargin > 7); help plotsp; return;
	end;

	ncols = fix(xsize/xbin);
	nrows = fix(ysize/ybin);
	nplots = ncols*nrows;
	[m,n] = size(data);

	total_area = [0.95 1];	% width is .95 to leave space for sliders
	plot_fraction = 0.8;	% fraction of plots in plot area
	plot_interval = total_area ./ [ncols nrows];
	plot_size = plot_fraction * plot_interval;
	plot_origin = (plot_interval - plot_size) / 2;

	low_clip = 0;		% here limits will be from
	high_clip = 1;		% min to max

	handles = get(gcf, 'UserData');
	if ( length(handles) >= 5 ),
		old_size  = handles(1:2);
		bot_slidh = handles(3);
		top_slidh = handles(4);
		title_h   = handles(5);
		handles(1:5) = [];
    else
		old_size = [0 0];
	end;
	if (hold && ...
            ( any(old_size ~= [nrows ncols]) ))
		disp('Cannot use hold mode in this figure. Using no-hold');
		hold = 0;
	end;

	if hold
		plot_color = colors(rem(length(get(handles(1),'Children')),ncolors)+1,:);
	
    else	% initialize the figure
	  clf reset;
	  set(gcf, 'DefaultAxesDrawMode', 'fast', 'DefaultAxesNextPlot', 'add');
		handles = zeros(1, nrows*ncols);
		plot_color = colors(1,:);
		bot_slidh = uicontrol('Style','slider',...
			   'Units','normalized', 'Position',[.95 .1 .015 .4],...
			   'Callback', 'plotsp(1)');
		top_slidh = uicontrol('Style','slider',...
			   'Units','normalized', 'Position',[.975 .1 .015 .4],...
			   'Callback', 'plotsp(1)');
		shrink_h = uicontrol('Style','pushbutton',...
			   'Units','normalized', 'Position',[.95 .9 .04 .04],...
			   'String', '>-<',...
			   'BackgroundColor', [0 .5 0],...
			   'ForegroundColor', [1 1 0],...
			   'Callback', 'plotsp(2)');
		expand_h = uicontrol('Style','pushbutton',...
			   'Units','normalized', 'Position',[.95 .85 .04 .04],...
			   'String', '<->',...
			   'BackgroundColor', [0 .5 0],...
			   'ForegroundColor', [1 1 0],...
			   'Callback', 'plotsp(3)');
		figax_h  = uicontrol('Style','pushbutton',...
			   'Units','normalized', 'Position',[.95 .78 .04 .04],...
			   'String', 'F',...
			   'BackgroundColor', [0 .5 0],...
			   'ForegroundColor', [1 1 0],...
			   'Callback', 'plotsp(4)');
		puttitle_h = uicontrol('Style','pushbutton',...
                           'Units','normalized', 'Position',[.95 .71 .04 .04],...
                           'String', 'T',...
                           'BackgroundColor', [0 .5 0],...
                           'ForegroundColor', [1 1 0],...
                           'Callback', 'plotsp(5)');
		text_axis = axes('position', [0 0 1 1], 'vis', 'off');
		text(.025, .975, date);
		title_h   = text(.5, .975, ' ', 'HorizontalAlignment', 'center');
	end;

	[x,y]=meshgrid(1:xbin,[0:ybin-1]*xsize);
	sp = x+y; sp = sp(:);
	
	binned_data = zeros(nplots, n);
	for i=1:nplots
		col = rem(i-1,ncols);
		row = fix((i-1)/ncols);
		xoffset = col * xbin;
		yoffset = row * xsize *ybin;
		if (xbin*ybin >1)
			trace = nanmean(data(sp+xoffset+yoffset,:));
		else
			trace = data(sp+xoffset+yoffset,:);
		end;
%		trace = trace - nanmean(trace);
		if hold,
			axes(handles(i));
        else
		handles(i) = axes('Visible', 'off',...
		      'Position',...
		      [plot_origin+[col nrows-1-row].*plot_interval plot_size]);
		end;
		plot(xaxis,trace ,'color', plot_color);
		binned_data(i,:) = trace;
	end;

	max_trace = sort(max(binned_data'));
	min_trace = sort(min(binned_data'));
	low_idx = round(nplots * low_clip);
	high_idx = round(nplots * high_clip);
	low_idx = low_idx + (low_idx == 0);
	ylimit = [min_trace(low_idx) max_trace(high_idx)];
	ymin = min(min_trace);
	ymax = max(max_trace);
	xlimit = [0 n];
	if hold,
		xlimit = max(xlimit, get(gca,'Xlim'));
		ymin = min(ymin, get(bot_slidh, 'Min'));
		ymax = max(ymax, get(bot_slidh, 'Max'));
		ylimit(1) = min(ylimit(1), get(bot_slidh, 'Value'));
		ylimit(2) = max(ylimit(2), get(top_slidh, 'Value'));
	end;
% 	set(handles, 'XLim', xlimit, 'YLim', ylimit);
% 	set(bot_slidh, 'Value', ylimit(1), 'Min', ymin, 'Max', ymax);
% 	set(top_slidh, 'Value', ylimit(2), 'Min', ymin, 'Max', ymax);
	if (nargout == 0), binned_data = []; end;

	set(gcf, 'UserData', [nrows ncols bot_slidh top_slidh title_h handles]);

elseif data == 1,	% called from sliders
	handles = get(gcf, 'UserData');
	bot_slidh = handles(3);
	top_slidh = handles(4);
	handles(1:5) = [];
	set(handles, 'YLim', [get(bot_slidh, 'Value') get(top_slidh, 'Value')]);
elseif data == 2	% shrink vertically (to leave space for a title)
	handles = get(gcf, 'UserData');
	handles(1:5) = [];
	for i = handles,
		p = get(i, 'Position');
		set(i, 'Position', [p(1) .95*p(2) p(3) .95*p(4)]);
		set(i, 'Position', [p(1) .5+(p(2)-.5)*.95 p(3) .95*p(4)]);
	end;
elseif data == 3	% expand back
	handles = get(gcf, 'UserData');
	handles(1:5) = [];
	for i = handles,
		p = get(i, 'Position');
		set(i, 'Position', [p(1) p(2)/.95 p(3) p(4)/.95]);
		set(i, 'Position', [p(1) .5+(p(2)-.5)/.95 p(3) p(4)/.95]);
	end;
elseif data == 4	% call figaxis
	figaxis;
elseif data == 5	% change title
	handles = get(gcf, 'UserData');
	title_h = handles(5);
	title =  input('Enter title: ', 's'); 
	if isempty(title), title = ' '; end;
	set(title_h, 'String', title);
else
	help plotsp;
end;

