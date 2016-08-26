function JTSwapCursor(this)
% JTSwapCursor - [no description]
%
%       JTSwapCursor(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

o('#JTSwapCursor ... ', 4, this.verb);

% get the current cursor type
currCursor = get(this.GUI.figH, 'Pointer');

% swap the cursor: if currently custom, change back to normal
if strcmp(currCursor, 'custom');
    
    set(this.GUI.figH, 'Pointer', 'arrow');
    
% if currently *not* custom, change to custom
else
    
    % create the cursor's image
    pointerCData = nan(16);
    pointerCData(7 : 10, 7 : 10) = 1;
    pointerCData(8 : 9, 8 : 9) = 2;
    set(this.GUI.figH, 'Pointer', 'custom', 'PointerShapeCData', pointerCData, 'PointerShapeHotSpot', [8.5 8.5]);
    
end;

% get the new cursor type
newCursor = get(this.GUI.figH, 'Pointer');

o('#JTSwapCursor: changed from %s to %s.', currCursor, newCursor, 3, this.verb);

end
