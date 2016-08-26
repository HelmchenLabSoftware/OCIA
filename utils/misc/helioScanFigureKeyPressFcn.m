function helioScanFigureKeyPressFcn(h, e, pos)

uData = get(h, 'UserData');

xLims = get(get(h, 'Children'), 'XLim');
if xLims(2) - xLims(2) > uData.imDim(2) - 1;
    xLims(2) = xLims(2) + uData.imDim(2) - 1;
end;
yLims = get(get(h, 'Children'), 'YLim');
if yLims(2) - yLims(1) > uData.imDim(1) - 1;
    yLims(2) = yLims(1) + uData.imDim(1) - 1;
end;
set(get(h, 'Children'), 'XLim', xLims, 'YLim', yLims);
        
switch e.Key;
    
    case 'escape';
        close(h);
        
    case 'space';
        if (~isempty(e.Modifier) && ismember(e.Modifier, 'shift')) || isempty(pos);
            pos = get(h, 'Position');
        end;
        set(h, 'Position', pos, 'Visible', 'on');
        pause(0.01);
        jFrame = get(handle(h), 'JavaFrame');
        jWind = jFrame.fHG1Client.getWindow();
        if jWind.isAlwaysOnTop();   jWind.setAlwaysOnTop(0); set(h, 'Name', regexprep(get(h, 'Name'), ' \[OnTopLocked\]$', ''));
        else                        jWind.setAlwaysOnTop(1); set(h, 'Name', [get(h, 'Name'), ' [OnTopLocked]']);    end;
    case 'leftarrow';  
        set(get(h, 'Children'), 'XLim', xLims - uData.imDim(2));
    case 'rightarrow';
        set(get(h, 'Children'), 'XLim', xLims + uData.imDim(2));
    case 'uparrow';
        set(get(h, 'Children'), 'YLim', yLims - uData.imDim(1));
    case 'downarrow';
        set(get(h, 'Children'), 'YLim', yLims + uData.imDim(1));
    case 'o';
        if isfield(uData, 'ROIHandles');
            set(uData.ROIHandles, 'Visible', iff(strcmp(get(uData.ROIHandles, 'Visible'), 'on'), 'off', 'on'));
        end;
    case 'i';
        if isfield(uData, 'ROIIDHandles');
            set(uData.ROIIDHandles, 'Visible', iff(strcmp(get(uData.ROIIDHandles, 'Visible'), 'on'), 'off', 'on'));
        end;
    case 'r';
        set(get(h, 'Children'), 'XLim', [1 uData.imDim(2)], 'YLim', [1 uData.imDim(1)]);
        set(get(h, 'Children'), 'XLim', [1 uData.imDim(2)], 'YLim', [1 uData.imDim(1)]);
        if isfield(uData, 'titleHands');
            set(uData.titleHands, 'FontSize', 8);
        end;
    case 't';
        if isfield(uData, 'titleHands');
            set(uData.titleHands, 'Visible', iff(strcmp(get(uData.titleHands, 'Visible'), 'on'), 'off', 'on'));
        end;
    case 'h';
        fprintf(['Shortcuts:\n', ...
            'escape: close figure\n', ...
            'space: toggle "always-on-top" and reposition window\n', ...
            'left/right/up/down arrow: navigate between images\n', ...
            'i: show/hide ROI IDs\n', ...
            'o: show/hide ROI contours\n']);
    otherwise;
        
end;

end