function fit_fminsearch

% simulate a double-peaked Gaussian
a = normrnd(1,0.5,[10000,1]);
a = [a; normrnd(3,0.5,[10000,1])];
[count,xout] = hist(a,sqrt(numel(a)));
figure('Name','Fit fun figure','NumberTitle','off')
stairs(xout,count,'k-'), hold on

%% fit with curve fitting toolbox
% fit double-peaked gaussian to histogram
fObj = fit(xout',count','gauss2');
plot(fObj,'r--')

%% fit with fminsearch 
% (no curve fitting toolbox required)
% start points x0 should be chosen as precisely as possible
pars0 = [max(count) 1 1 max(count) 1 1]';
[x, fval] = fminsearch(@(x) gauss2(x,count,xout),pars0);
% x contains the optimal 6 parameters for the Gaussian
% fval is the minimum of the objective function, ie. the smaller the better the fit

fitCurve = x(1).*exp(-((xout-x(2))./x(3)).^2) + ...
    x(4).*exp(-((xout-x(5))./x(6)).^2);
plot(xout,fitCurve,'b--')

legend({'dota','fit','fminsearch'})

end


%% Objective function for minimization
function fOut = gauss2(pars,a,x)
f = pars(1).*exp(-((x-pars(2))./pars(3)).^2) + ...
    pars(4).*exp(-((x-pars(5))./pars(6)).^2);
fOut = sum(abs(f-a));
end
