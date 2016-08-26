% nfb_errorbar is a generic function which produces a bar chart with error
% bars
% its main advantage is that it readily plots each bar and errorbar
% separately, making it easy to change colours, filling etc for each bar
% individually later on
%
% USAGE:
% [out1] = nfb_errorbar(in1, in2)
%
% Comulsory input arguments
% in1 ... bar matrix (2D)
% in2 ... errorbar matrix (2D)
% of course in1 and in2 could also be a simple vector
% each matrix entry corresponds to 1 bar / errorbar and values in the same
% row will be grouped (i.e. bars sit closer on the plot than values from
% different rows)
% bar and errorbar matrices MUST be of equal size
%
% Optional input arguments (in any order)
% 'Figure', add errorbar to an existing figure (provide handle to figure)
% 'Spacing' (default: 0.85)
% 'Color', string specification of valid Matlab colormap (see doc colormap)
% (default is 'jet')
% 'Labels', cellstring of row*columns length (one label
% per bar) or row length (one label per bar group)
% i.e. 'Labels',{'value1' 'value2' 'value3'}
% 'Legend', cellstring provides legend tags for bars (must not be longer
% than number of bars, i.e. rows*columns of input matrices)
% 'RemoveTee', remove horizontal lines at end of error bars (0 or 1,
% default 0), requires removeErrorBarEnds function
% String args: 'Title', 'XLabel', 'YLabel', 'Name' (Figure Name, if
% specified, also switches NumberTitle off)
%
% out1 ... handle to figure

% this file written by Henry Luetcke (hluetck@gwdg.de)


function [bar_chart] = nfb_errorbar(varargin)

if nargin < 2
    disp('You MUST provide at least 2 input arguments');
    disp(' ');
    help nfb_errorbar
    return
end

bars = varargin{1};
errs = varargin{2};
if size(bars) ~= size(errs)
    error('Bar and errorbar matrices must be of equal size');
end

if length(size(bars)) > 2 || length(size(errs)) > 2
    error('Bar and errorbar matrices must be 2D matrices');
end

% hluetck::12.02.2008
% Parameter for specifying spacing between bars explicitely
% check if spacing of bars has been specified explicitely
spacing = 0.85;
% tauer::20.02.2008
% simplified
SpInput = find(strcmp(varargin, 'Spacing'));
if numel(SpInput) 
    spacing = varargin{SpInput+1};
end

% hluetck::03.03.2008
% Option to add errorbar plot to existing figure
SpInput = find(strcmp(varargin, 'Figure'));
if numel(SpInput)
    bar_chart = varargin{SpInput+1};
else
    bar_chart = figure;
end
hold on

% hluetck::12.02.2008
% Parameter for specifying spacing between bars explicitely
% first we generate the x values (depending on the number of rows and
% columns)
% tauer::20.02.2008
% simplified

current_x = 1;
for n = 1:size(bars,1)
    for m = 1:size(bars,2)
        x_vals((n-1)*size(bars,2)+m) = current_x;
        current_x = current_x + spacing;
    end
    current_x = current_x + 0.5;
end

% rearrange matrices into vectors and plot
rows = size(bars,1);
cols = size(bars,2);
bars = reshape(bars',(size(bars,1)*size(bars,2)),1);
errs = reshape(errs',(size(errs,1)*size(errs,2)),1);
% hluetck::24.02.2008
% specify bar color according to Matlab color map
SpInput = find(strcmp(varargin, 'Color'));
if numel(SpInput) 
    cmap = varargin{SpInput+1};
    cstring = sprintf('%s(%s)',cmap,int2str(cols));
    try evalc(cstring);
    catch
        fprintf(...
            '\n"%s" is not a valid Matlab color map. Using ''jet''.\n',...
            cmap);
        cmap = 'jet';
    end
else
    cmap = 'jet';
end
cstring = sprintf('%s(%s)',cmap,int2str(cols));
group_colors = colormap(cstring);
% hluetck::23.02.2008
% changed allocation of bar color
% now cycle colors within bar groups and not between groups
% (makes more sense if used in combination with legend?)
% also adjusted color specification (now RGB vector)
% plot
current_col = 0;
col = 1;
for n = 1:length(bars)
    if current_col == cols
        col = 1;
        current_col = 0;
    end
    bar(x_vals(n),bars(n),'FaceColor',group_colors(col,:));
    current_col = current_col + 1;
    col = col + 1;
end
% for n = length(errs):-1:1
%     errorbar(x_vals(n),bars(n),errs(n),'k','LineWidth',1.5);
% end
e_bar = errorbar(x_vals,bars,errs,'k','LineWidth',1.5,'LineStyle','none');
% parse opional input arguments
if nargin > 2
    opt_args = varargin(3:nargin);
    for n = 1:length(opt_args)
        if strcmp(opt_args{n},'RemoveTee') == 1
           removeTee = opt_args{n+1};
           if removeTee && exist('removeErrorBarEnds','file') == 2
               removeErrorBarEnds(e_bar);
           end
        end
        % hluetck::23.02.2008
        % included option to attach only one label per bar group
        % in combination with legend option, this now allows efficient
        % labeling of bar charts
        % attach labels
        if strcmp(opt_args{n},'Labels') == 1
            labels = opt_args{n+1};
            if length(labels) ~= (rows*cols)
                if length(labels) ~= rows
                    disp('Incorrect number of labels has been given');
                    disp(' ');
                    help nfb_errorbar
                    return
                else
                    % hluetck::23.02.2008
                    % attach only 1 label per bar group
                    if rem(cols,2)
                        center = ceil(cols/2);
                        x_vals_short = [];
                        x_vals_pos = 1;
                        previous_center = 0;
                        for m = 1:length(x_vals)
                            if m == (ceil((cols*x_vals_pos)/2)+previous_center)
                                previous_center = ceil((cols*x_vals_pos)/2);
                                x_vals_short(x_vals_pos) = x_vals(m);
                                x_vals_pos = x_vals_pos + 1;
                            end
                        end
                    else
                        center = cols/2;
                        center = ceil(cols/2);
                        x_vals_short = [];
                        x_vals_pos = 1;
                        previous_center = 0;
                        for m = 1:length(x_vals)
                            if m == (ceil((cols*x_vals_pos)/2)+previous_center)
                                previous_center = ceil((cols*x_vals_pos)/2);
                                x_vals_short(x_vals_pos) = x_vals(m)+0.5;
                                x_vals_pos = x_vals_pos + 1;
                            end
                        end
                    end
                    set(gca,'XTick',[x_vals_short],'XTickLabel',labels);
                end
            else
                % hluetck::23.02.2008
                % attach one label for each bar
                set(gca,'XTick',[x_vals],'XTickLabel',labels);
            end
        end

        % hluetck::23.02.2008
        % modified legend creation (it does actually work now)
        % create column legend
        if strcmp(opt_args{n},'Legend') == 1
            col_legend = opt_args{n+1};
            if length(col_legend) > cols*rows
                disp('Incorrect number of legend values has been given');
                disp(' ');
                help nfb_errorbar
                return
            end
            legend(col_legend,'Location','Best');
        end

        % add a title
        if strcmp(opt_args{n},'Title') == 1
            plot_title = opt_args{n+1};
            h_title = title(plot_title);
            set(h_title,'Interpreter','none');
        end

        % y-axis label
        if strcmp(opt_args{n},'YLabel') == 1
            plot_ylabel = opt_args{n+1};
            ylabel(plot_ylabel);
        end

        % x-axis label
        if strcmp(opt_args{n},'XLabel') == 1
            plot_xlabel = opt_args{n+1};
            xlabel(plot_xlabel);
        end

        % Figure Name
        if strcmp(opt_args{n},'Name') == 1
            fig_name = opt_args{n+1};
            set(gcf,'Name',fig_name,'NumberTitle','off');
        end
    end
end


% e.o.f.