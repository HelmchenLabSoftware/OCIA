function [overlay,hImg] = image_overlay(bg,mask,transp)
% mask bg image with mask
% all non-zero values in mask will be rendered on top of bg
% both inputs must be gray-scale images
% overlay is rgb with mask color scaled between min(mask) and max(mask)
% transp is transparency factor (colors are weighted by 1-transp)

% this file written by Henry Luetcke (hluetck@gmail.com)

overlay_red = bg;
overlay_green = bg;
overlay_blue = bg;
mask(mask==0) = NaN;
min_val = min(mask(:));
max_val = max(mask(:));
range_val = max_val - min_val;
% use 256 colors for the range of values in the mask
colors = jet(256);
% colors_row is equal to floor((255/range)*val + (1-(255/range)*min))

for x = 1:size(bg,1)
    for y = 1:size(bg,2)
        if ~isnan(mask(x,y))
            colors_row = floor((255/range_val)*mask(x,y) + ...
                (1-(255/range_val)*min_val));
            overlay_red(x,y) = (1-transp).*colors(colors_row,1) + transp.*overlay_red(x,y);
            overlay_green(x,y) = (1-transp).*colors(colors_row,2) + transp.*overlay_green(x,y);
            overlay_blue(x,y) = (1-transp).*colors(colors_row,3) + transp.*overlay_blue(x,y);
        end
    end
end

overlay = cat(3, overlay_red, overlay_green, overlay_blue);
hImg = figure;
set(gcf,'renderer','opengl')
imshow(overlay,'initialmagnification','fit');
cbar = colorbar;
ylims = get(cbar,'ylim');
set(cbar,'ytick',[ylims(1) ylims(2)])
labels = get(cbar,'YTickLabel');
minS = sprintf('%1.2f',min_val);
maxS = sprintf('%1.2f',max_val);
set(cbar,'YLimMode','manual','YTickMode','manual','yticklabel',{minS, maxS})

