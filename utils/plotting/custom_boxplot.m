function custom_boxplot(in1,in2,in3,in4,in5)
% create a custom boxplot for a given matrix
% USAGE: custom_boxplot(data,group_labels,ylabel,plot_title,figure_name)
% data must at least have one column, one boxplot will be plotted for each
% columns
% group_labels is a cell string with labels for each boxplot (length must
% be equal to column number)
% ylabel, plot_title and figure_name are strings

data = in1;
groups = in2;
y_label = in3;
plot_title = in4;
fig_name = in5;
if length(groups) ~= size(data,2)
    error('There must be as many group labels as there are columns in the data');
end

figure('NumberTitle','off','Name',fig_name);
boxplot(data,'labels',groups);
ylabel(y_label);
title(plot_title);
drawnow;
%e.o.f.