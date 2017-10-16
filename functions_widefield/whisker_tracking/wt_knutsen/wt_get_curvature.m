function nRMax = wt_get_curvature(mSplinePoints)
% WT_GET_CURVATURE
% Calculate whisker curvature. Function is 'stand-alone' and can be called
% without WT being currently invoked (it does not access any globals
% variables used by WT).
%
% Syntax: wt_get_curvature(M), where
%           M is a 3D matrix that contains rows of [X Y] splinepoints
%           arranged in frames along the 3rd dimension.
%
% Whisker Tracker (WT)
%
% Authors: Per Magne Knutsen, Dori Derdikman
%
% (c) Copyright 2004 Yeda Research and Development Company Ltd.,
%     Rehovot, Israel
%
% This software is protected by copyright and patent law. Any unauthorized
% use, reproduction or distribution of this software or any part thereof
% is strictly forbidden. 
%
% Citation:
% Knutsen, Derdikman, Ahissar (2004), Tracking whisker and head movements
% of unrestrained, behaving rodents, J. Neurophys, 2004, IN PRESS
%

nRMax = [];
for f = 1:size(mSplinePoints, 3)
    mSpl = mSplinePoints(:,:,f,1);
    if all(mSpl(end,:) == 0) % 4 splinepoints
        vX = mSpl(1:3,1);
        vY = mSpl(1:3,2);
    else
        vX = mSpl(:,1);
        vY = mSpl(:,2);
    end
    vXX = vX(1):max(vX);
    [vXX, vYY] = wt_spline(vX, vY, vXX);
    vR = [diff(vYY, 2) 0] ./ ((1 + diff(vYY).^2 ).^1.5);
    [nRMax(f), nRMaxIndx] = max(abs(vR(1:end-2)));
    nRMax(f) = vR(nRMaxIndx);
end

nRMax = -nRMax';

return;