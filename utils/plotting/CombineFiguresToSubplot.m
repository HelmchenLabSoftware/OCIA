function CombineFiguresToSubplot(roi)
% combine several figures (.fig files) into a single subplot
pos = 1;
for n = [0 30 45 60 75 105 135 165]
    filenames{pos} = sprintf('%sYC4_%smin_spot1_dist_peak.fig',...
        roi,num2str(n));
    pos=pos+1;
end
last_day = n;

% tiling for bar charts
tiling = [length(filenames) 1];

% tiling for ps plots
tiling = [1 length(filenames)];

for n = 1:length(filenames)
    if n == length(filenames)
       new_filename = strrep(filenames{n},...
           [int2str(last_day) 'min_'],'');
    end
   h(n) = open(filenames{n});
end
new_fig = figs2subplots(h,tiling);

for n = 1:length(filenames)
   close(h(n));
end
saveas(new_fig,new_filename)
% print
close(gcf)