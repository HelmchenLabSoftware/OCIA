function [x,y] = ellipse(ra,rb,an,offset,pts,doPlot)
% create x and y coordinates for an ellipse
% in1 & in2 ... radii (if in1==in2 --> circle)
% in3 ... angle
% in4 ... center point
% in5 ... number of points to draw
% in6 ... plot result?

% this file written by Henry Luetcke (hluetck@gmail.com)

% offset
xpos = offset(1); ypos = offset(2);

co=cos(an);
si=sin(an);
the=linspace(0,2*pi,pts);
x=ra*cos(the)*co-si*rb*sin(the)+xpos;
y=ra*cos(the)*si+co*rb*sin(the)+ypos;

if doPlot
    plot(x,y)
    set(gca,'XLim',[-max([ra rb]) max([ra rb])]);
    set(gca,'YLim',[-max([ra rb]) max([ra rb])]);
end