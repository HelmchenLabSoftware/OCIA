function S = textureDisc_dimensionReduce(S)
% S is a data structure returned by importData_textureDisc

% this file written by Henry Luetcke (hluetck@gmail.com)

animalID = S.info.animal;
sessionID = S.info.session;
rate = S.info.sample_rate;

roiLabel = S.info.roiLabel;
% roi labels without session ID
roiLabel = strrep(roiLabel,sprintf('%s-%1.0f-',animalID,sessionID),'');

% treat each Roi separately
for roi = 1:numel(roiLabel)
    roiID = roiLabel{roi};
    fprintf('Processing %s\n',roiID);
    data = S.(roiLabel{roi}).dRR;
    S.(roiLabel{roi}).reducedGauss1 = fitSingleTrialTransient(data,'gauss1');
end


function fitCoef = fitSingleTrialTransient(data,fitLib)
fitCoef = zeros(size(data,1),4); % 3 coefficients for gaussian + r^2
t = (1:size(data,2))';
fObj = cell(1,size(data,1)); gof = cell(1,size(data,1));
parfor n = 1:size(data,1)
    y = data(n,:)';
    if any(isnan(y))
        fObj{n} = NaN; gof{n} = NaN;
        continue
    end
    opts = fitoptions(fitLib);
    opts.Lower = [0 0 1];
    opts.Upper = [max(y) max(t) max(t)];
    [fObj{n},gof{n}] = fit(t,y,fitLib,opts);
end
for n = 1:size(data,1)
    try
        c = coeffvalues(fObj{n});
        fitCoef(n,1:numel(c)) = c;
        fitCoef(n,numel(c)+1) = gof{n}.rsquare;
    catch
        fitCoef(n,1:size(fitCoef,2)) = NaN;
    end
    %     if ~doPlot; continue; end
    %     figure('Name',id)
    %     plot(t,y,'k'), hold on
    %     plot(fObj)
    %     switch fitLib
    %         case 'gauss1'
    %             titleStr = sprintf('a=%1.3f b=%1.3f c=%1.3f r^2=%1.3f',c(1),c(2),c(3),gof.rsquare);
    %         case 'fourier1'
    %             titleStr = sprintf('a0=%1.3f a1=%1.3f b1=%1.3f w=%1.3f r^2=%1.3f',...
    %                 c(1),c(2),c(3),c(4),gof.rsquare);
    %     end
    %     title(titleStr)
end


