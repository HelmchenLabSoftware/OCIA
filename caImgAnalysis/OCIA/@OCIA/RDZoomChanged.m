function RDZoomChanged(this, ~, ~)
% RDZoomChanged - [no description]
%
%       RDZoomChanged(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

    oldZoom = this.GUI.rd.zoomLevel;
    newXLim = get(this.GUI.handles.rd.axe, 'XLim');
    this.GUI.rd.zoomLevel = size(this.GUI.rd.img, 1) / (newXLim(2) - newXLim(1));
    o('#RDZoomChanged(): old zoom level: %.3f, new zoom level: %.3f.', oldZoom, ...
        this.GUI.rd.zoomLevel, 3, this.verb);
    
    % update the display
    RDUpdateGUI(this);
    
    if this.GUI.rd.zoomLevel == 1;
        RDChangeFrame(this, -1);
    end;

end
