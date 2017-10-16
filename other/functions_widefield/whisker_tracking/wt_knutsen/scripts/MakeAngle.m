%MakeAngle
for n=1:length(AvgWhiskerPos_AP)
  vCoords(:,:,n)=[AvgWhiskerPos_ML(n) AvgWhiskerPos_AP(n)];
    
end
vRefLine=[380,141;419,248]
vRefLine=[480,210;542,332]

centrePoint=[426; 260]
centrePoint=[542; 332]
% Get angle of the reference line
nX = diff(vRefLine(:,1));
nY = diff(vRefLine(:,2));
if nX < 0 & nY > 0
    nRefAngle = abs(rad2deg( atan2( nY, nX))-180);
else
    nRefAngle = 90 + rad2deg( atan2( nX, nY));
end

% Get angle of mean whisker position
nFrames = size(vCoords, 3);
nCoordsAnlge=[];
for f = 1:nFrames
    nX = centrePoint(1)-vCoords(:,1,f); 
    nY = centrePoint(2)-vCoords(:,2,f); %y- centrepoint y
    if nX < 0 & nY > 0
        nCoordsAnlge(f) = abs(rad2deg( atan2( nY, nX))-180);
    else
        nCoordsAnlge(f) = 90 + rad2deg( atan2( nX, nY));
    end
     vWhiskAngRel(f) = -90+ (nCoordsAnlge(f) - nRefAngle);   
end
