function BELaserInt(~, intensity)
% BELaserInt - [no description]
%
%       BELaserInt(~, intensity)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

mCoords = java.awt.MouseInfo.getPointerInfo().getLocation(); 

if intensity ~= 0 && intensity < 1 && intensity > 0;
    intensity = intensity * 100;
end;

intensity = min(max(intensity, 0), 100);

% % fullscreen
% xCoord = 269; minIntYCoord = 974; maxIntYCoord = 766;
% scanHeadTabCoord = [206, 667]; iconCoord = [446, 1178]; previewCoord = [552, 1080];

% half-screen
xCoord = 275; minIntYCoord = 983; maxIntYCoord = 774;
% xCoord = 264; minIntYCoord = 1007; maxIntYCoord = 798;
% xCoord = 277; minIntYCoord = 981; maxIntYCoord = 773;
% xCoord = 277; minIntYCoord = 970; maxIntYCoord = 763;
scanHeadTabCoords = [214, 673]; iconCoords = [446, 1178]; previewCoords = [552, 1080];

mb1 = java.awt.event.InputEvent.BUTTON1_MASK;
yCoord = (intensity / 100) * (maxIntYCoord - minIntYCoord) + minIntYCoord;

r = java.awt.Robot();
r.mouseMove(scanHeadTabCoords(1), scanHeadTabCoords(2)); pause(0.05);
r.mousePress(mb1); pause(0.05); r.mouseRelease(mb1); pause(0.05);
r.mouseMove(iconCoords(1), iconCoords(2)); pause(0.05);
r.mousePress(mb1); pause(0.05); r.mouseRelease(mb1); pause(0.05);
r.mouseMove(previewCoords(1), previewCoords(2)); pause(0.05);
r.mousePress(mb1); pause(0.05); r.mouseRelease(mb1); pause(0.05);

r.mouseMove(xCoord, yCoord); pause(0.05);
r.mousePress(mb1); pause(0.05); r.mouseRelease(mb1); pause(0.05);
r.mousePress(mb1); pause(0.05); r.mouseRelease(mb1); pause(0.05);

r.mouseMove(mCoords.getX(), mCoords.getY());


end
