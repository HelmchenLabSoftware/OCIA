function WhiskAngRel=ks_CalcAngle(g_tWT)
for n=1:length(g_tWT.MovieInfo.AvgWhiskerPos)
  vCoords(:,:,n)=[g_tWT.MovieInfo.AvgWhiskerPos(n,:)];
    
end

centrePoint=g_tWT.MovieInfo.WhiskerOrigin;

% Get angle of the reference line
nX = diff(g_tWT.MovieInfo.RefLine(:,1));
nY = diff(g_tWT.MovieInfo.RefLine(:,2));
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
    WhiskAngRel(f) = -90+ (nCoordsAnlge(f) - nRefAngle);   
end
