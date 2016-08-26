function img = INAdjustIntensity(this, img)
% INAdjustIntensity - [no description]
%
%       img = INAdjustIntensity(this, img)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

intAdjTic = tic;

% get adjustment values from GUI
minVal = get(this.GUI.handles.in.imAdjMinPrev, 'Value');
maxVal = get(this.GUI.handles.in.imAdjMaxPrev, 'Value');
if minVal >= maxVal;
    minVal = maxVal - 0.01;
    if minVal < 0;
        minVal = 0.01;
        maxVal = 0.02;
    end;
    set(this.GUI.handles.in.imAdjMinPrev, 'Value', minVal);
    set(this.GUI.handles.in.imAdjMaxPrev, 'Value', maxVal);
end;

% adjust intensities
img = imadjust(img, [minVal maxVal]);
o('#%s: intensity adjustment done: %.3f sec', mfilename, toc(intAdjTic), 3, this.verb);

end
