function stats = glm_Connectivity(roiData,varargin)
% compute connectivity matrix using Generalized Linear Model fitting
% roiData ... timepoints x cells matrix
% in2 ... doPlot {0}
% stats ... output structure with fields:
% Beta ... cells x cells matrix of beta values
% tBeta ... t statistic for the observed beta value
% pBeta ... p-value of t
% dfe ... degrees of freedom error (no. of timepoints - no.of cells)
% for all output matrices, columns are presynaptic and rows postsynaptic

% this file written by Henry Luetcke (hluetck@gmail.com)

if nargin > 1
   doPlot = varargin{1};
else
    doPlot = 0;
end

stats.Beta = nan(size(roiData,2));
stats.tBeta = nan(size(roiData,2));
stats.pBeta = nan(size(roiData,2));
for roi = 1:size(roiData,2)
    y = roiData(:,roi);
    % build design matrix from all other Rois
    model = roiData;
    model(:,roi) = [];
    %Orthogonalize the model
    model = Gram_Schmidt_Process(model);
    
    [b,~,s] = glmfit(model,y);
    for roi2 = 1:size(roiData,2)
        if roi2 < roi
            stats.Beta(roi,roi2) = b(roi2+1);
            stats.tBeta(roi,roi2) = s.t(roi2+1);
            stats.pBeta(roi,roi2) = s.p(roi2+1);
        elseif roi2 > roi
            stats.Beta(roi,roi2) = b(roi2);
            stats.tBeta(roi,roi2) = s.t(roi2);
            stats.pBeta(roi,roi2) = s.p(roi2);
        else
            continue
        end
    end
end

stats.dfe = s.dfe;

if ~doPlot, return, end

connMatLogP = abs(log(stats.pBeta));
subplot(1,3,1)
imshow(stats.Beta,[],'InitialMagnification','fit')
title('Beta')
subplot(1,3,2)
imshow(stats.tBeta,[],'InitialMagnification','fit')
title('T-value')
subplot(1,3,3)
imshow(connMatLogP,[],'InitialMagnification','fit')
title('Abs. Log P-Value')


