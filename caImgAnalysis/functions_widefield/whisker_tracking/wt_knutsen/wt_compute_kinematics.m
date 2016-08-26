function wt_compute_kinematics(sParam, nW)
% WT_COMPUTE_KINEMATICS
% Compute kinematic parameter(s) for selected or all tracked whiskers
%
% Usage:
%   wt_compute_kinematics(P, W)
%
% where P is a parameter string and W the whisker index.
%
% P can be either of:
%       angle
%       curvature
%       all
% 
% W must be a valid whisker index or zero (0). When W=0, the kinematic
% parameter is computed for all whiskers
%

global g_tWT

mSplinePoints = g_tWT.MovieInfo.SplinePoints;

% Get indices of all whiskers if nW == 0 (i.e. compute parameter for all)
if nW == 0, nW = 1:size(mSplinePoints, 4); end

for w = nW
    % Splinepoints of current whisker
    mSplinePointsThis = mSplinePoints(:,:,:,w);
    if strcmp(sParam, 'angle') | strcmp(sParam, 'all')
            wt_set_status('Computing whisker angle')
            % Compute angle
            [vAngle vIntersect] = wt_get_angle(mSplinePointsThis, g_tWT.MovieInfo.RefLine, g_tWT.MovieInfo.AngleDelta);
            % Assign values
            g_tWT.MovieInfo.Angle(1:length(vAngle), w) = vAngle;
            if ~isempty(vIntersect)
                g_tWT.MovieInfo.Intersect(1:length(vIntersect),1:2,w) = vIntersect;
            end
    end
    if strcmp(sParam, 'curvature') | strcmp(sParam, 'all')
            wt_set_status('Computing whisker curvature')
            % Compute curvature
            if g_tWT.MovieInfo.AngleDelta == 0
                vCurvature = wt_get_curv_at_base(mSplinePointsThis);
            else
                vCurvature = wt_get_curvature(mSplinePointsThis);
            end
            % Assign values
            g_tWT.MovieInfo.Curvature(1:length(vCurvature), w) = vCurvature;
    end

end

wt_set_status('Done computing kinematic parameters')

return