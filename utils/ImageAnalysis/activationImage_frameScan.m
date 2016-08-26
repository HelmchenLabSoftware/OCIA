function varargout = activationImage_frameScan(ch1,ch2,stim,rate)
% ch1 and ch2 should be background-subtracted
% leave ch2 empty if only 1 channel (DFF)
% stim is stim vector at frame rate (0 ... no stim)

% Required toolboxes: image, signal, stats

% this file written by Henry Luetcke (hluetck@gmail.com)
tic

statsType = 'cc'; % cc or glm

getModel = 0; % only for statsType glm: evaluate the model

% simple average spatial filter with width in pixels
smoothPixels = 5;

% Savitzky-Golay filter for timeseries
lpFiltCutoff = 4; % cutoff in timepoints
sgolayOrder = 1; % filter order (set this to 0 to skip SG filter)

% model settings
onsettau = 0.01;
tau = 0.6;

% Desired false discovery rate for thresholding stats images
fdrAlpha = 0.01;

% transparency of stats overlay image (1 ... completely transparent)
transp = 0.8;

switch statsType
    case 'cc'
        getModel = 0;
end

if ~rem(lpFiltCutoff,2)
    lpFiltCutoff = lpFiltCutoff+1;
end

timepoints = length(stim);

% average of ch1 for display
ch1_avg = mean(ch1,3);

fprintf('Smoothing images with width %1.1f\n',smoothPixels)
fSmooth = fspecial('average',smoothPixels);
ch1 = imfilter(ch1,fSmooth);
if ~isempty(ch2)
    ch2 = imfilter(ch2,fSmooth);
    fprintf('Computing ratio image\n');
    ratio = double(ch1) ./ double(ch2);
else
    ratio = double(ch1);
end

drr = zeros(size(ratio));

x = (1:timepoints)';
t = x./rate;

% calculate DRR
fprintf('Timeseries filter\n'); % might not be necessary
for row = 1:size(ratio,1)
    if ~rem(row,2)
        fprintf('.');
    end
    for col = 1:size(ratio,2)
        ts(1:timepoints,1) = ratio(row,col,:);
        if any(isinf(ts)) || any(isnan(ts))
            drr(row,col,1:timepoints) = NaN;
            continue
        end
        if sgolayOrder
            ts = sgolayfilt(ts,sgolayOrder,lpFiltCutoff);
        end
        %         p = polyfit(x,ts,2);
        %         r0 = p(1).*x.^2 + p(2).*x + p(3);
        %         drr(row,col,1:timepoints) = ((ts - r0) ./ r0) .* 100;
        drr(row,col,1:timepoints) = ts;
    end
end

% make GLM design matrix
fprintf('\nSetting up design matrix with %1.0f stimuli\n',max(stim));
modelTransient = spkTimes2Calcium(0,onsettau,1,tau,0,0,rate,t(end));
glmModel = [];
for n = 1:max(stim)
    stimOn = zeros(size(stim));
    stimOn(stim==n) = 1;
    stimOnConv = conv(stimOn,modelTransient);
    stimOnConv = stimOnConv(1:numel(stimOn))';
    glmModel = [glmModel stimOnConv];
    tImageCell{1,n} = zeros(size(ch1_avg));
    pImageCell{1,n} = zeros(size(ch1_avg));
end
if sgolayOrder
    glmModel = sgolayfilt(glmModel,sgolayOrder,lpFiltCutoff);
end

%Orthogonalize the model
glmModel = Gram_Schmidt_Process(glmModel);

switch statsType
    case 'glm'
        fprintf('Fitting GLM\n');
        if getModel
           modelMov = drr;
        end
        dfe = [];
        for row = 1:size(ratio,1)
            if ~rem(row,2)
                fprintf('.');
            end
            for col = 1:size(ratio,2)
                if isnan(drr(row,col,1))
                    for n = 1:max(stim)
                        tImageCell{n}(row,col) = NaN;
                        pImageCell{n}(row,col) = NaN;
                    end
                    continue
                end
                ts(1:timepoints,1) = drr(row,col,:);
                
                % using glmfit
                [b,dev,stats] = glmfit(glmModel,ts);
                % could use glmval to get back the fitted model
                [yfit,ciL,ciU] = glmval(b,glmModel,'identity',stats);
                for n = 1:max(stim)
                    tImageCell{n}(row,col) = stats.t(n+1);
                    pImageCell{n}(row,col) = stats.p(n+1);
                end
                if isempty(dfe)
                    dfe = stats.dfe;
                end
                if getModel
                   modelMov(row,col,1:timepoints) = yfit;
                end
            end
        end
    case 'cc'
        fprintf('Computing cross-correlation\n');
        % or simple correlation (much faster)
        drr2D = reshape(shiftdim(drr,2),timepoints,numel(ch1_avg));
        [r,p] = corr(drr2D,glmModel);
        for n = 1:max(stim)
            tImageCell{n} = reshape(r(:,n),size(ratio,1),size(ratio,2));
            pImageCell{n} = reshape(p(:,n),size(ratio,1),size(ratio,2));
        end
end

for n = 1:max(stim)
    % not sure what to make of t / r values < 0
    pImageCell{n}(tImageCell{n}<0) = NaN;
    tImageCell{n}(tImageCell{n}<0) = NaN;
    pVals = pImageCell{n}(:);
    pVals(isnan(pVals)) = [];
    pThreshold = FDRcontP(pVals,fdrAlpha,1000,100);
    fprintf('\nFDR threshold for stim %1.0f: %1.3e',n,pThreshold);
    tImageCell{n}(pImageCell{n}>pThreshold) = NaN;
    pImageCell{n}(pImageCell{n}>pThreshold) = NaN;
end

if getModel
   for row = 1:size(ratio,1)
       for col = 1:size(ratio,2)
           allNaN = 1;
           for n = 1:max(stim)
              if ~isnan(pImageCell{n}(row,col))
                 allNaN = 0;
                 break
              end
           end
           if allNaN
              modelMov(row,col,1:timepoints) = NaN;
           end
       end
   end
end

% figure('Name','Activation Image','NumberTitle','off')
% subplot(1,max(stim)+1,1)
% imshow(ch1_avg,[],'initialmagnification','fit')
% plot image overlay
ch1_avg = ScaleToMinMax(ch1_avg,0,1);
% figure handles
h = cell(1,max(stim));
for n = 1:max(stim)
    switch statsType
        case 'cc'
            titleStr = sprintf('Correlation Image - stim %1.0f',n);
            titleStr = sprintf('%s\nFDR-threshold: %1.3f',titleStr,fdrAlpha);
        case 'glm'
            titleStr = sprintf('T-score Image - stim %1.0f',n);
            titleStr = sprintf('%s\nFDR-threshold: %1.3f',titleStr,fdrAlpha);
    end
%     h{n} = figure('Name',titleStr,'NumberTitle','off');
    [~,currentHandle] = image_overlay(ch1_avg,tImageCell{n},transp);
%     set(currentHandle,'Name',titleStr,'NumberTitle','off');
    title(titleStr)
    h{n} = currentHandle;
end

fprintf('\nDone!\n');

if nargout
    varargout{1} = h;
    varargout{2} = tImageCell;
    varargout{3} = pImageCell;
    if nargout > 3
       varargout{4} = modelMov;
    end
end

toc