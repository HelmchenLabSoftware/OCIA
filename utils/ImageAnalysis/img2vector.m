function [tone,toneT] = img2vector(img,f,doPlot)
% img ... img array (3D)
% f ... effective sampling rate (pixel rate) in Hz
% doPlot ... 0 or 1

% this file written by Henry Luetcke (hluetck@gmail.com)

tone = permute(img,[2 1 3]);
tone = reshape(tone,1,numel(tone));

toneT = 1/f:1/f:length(tone)/f;

if doPlot
   plot(toneT,tone) 
end
