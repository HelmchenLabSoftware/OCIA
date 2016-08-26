function noBleach = BleachCorrect(data,mask,plotFit)
% perform bleach correction by fitting exponential model to the mean
% timeseries of the mask and subtract the model from all pixel timeseries
% empty mask selects all pixels
% data may be a timeseries, in this case mask should be empty
% plotFit ... if true, plot the mean timeseries and fit

% this file written by Henry Luetcke

data = double(data);
if ~isempty(mask)
    ts = mean(GetRoiTimeseries(data,mask));
else
    ts = data;
end



% smooth ts to improve fit
ts_fit = smooth(ts,round(length(ts)/3));
%% Fit
% fit a double-exponential model
fit_model = 'a*exp(b*x) + c*exp(d*x)';

% fit using Matlab advanced fitting procedure
fo_ = fitoptions('method','NonlinearLeastSquares');
ft_ = fittype('exp2');
[fresult, gof, fit_info] = fit((1:length(ts_fit))',ts_fit,ft_ ,fo_);
coef = coeffvalues(fresult);
fit_a = coef(1); fit_b = coef(2); fit_c = coef(3); fit_d = coef(4);
fprintf('Fit results (R^2=%s)\n',num2str(gof.rsquare));
fprintf('a: %1.4f \tb: %1.4f \tc: %1.4f\td: %1.4f\n',...
    fit_a,fit_b,fit_c,fit_d);
time_fit = 1:length(ts_fit);
data_fit = (fit_a.*exp(time_fit*fit_b))+(fit_c.*exp(time_fit*fit_d));

% fitresult.gof = gof;
% fitresult.amp = fit_amp;
% fitresult.decay = fit_decay;
% fitresult.amp_at_peak = data_fit(1);
% fitresult.model = fit_model;
% fitresult.fit = [time_fit data_fit];
%% Correct
noBleach = zeros(size(data));
if ~isempty(mask)
    for x = 1:size(data,1)
        for y= 1:size(data,2)
            current_pixel_ts(1:size(data,3)) = data(x,y,:);
            noBleach(x,y,:) = current_pixel_ts - data_fit;
        end
    end
else
    noBleach = ts - data_fit;
end

%% Plot
if plotFit
    figure('Name','Fit results bleach correction'); hold all
    plot(ts);
    plot(ts_fit)
    plot(fresult);
    legend({'data','data smooth','fit'});
end




