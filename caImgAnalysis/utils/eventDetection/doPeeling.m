function Sout = doPeeling(Sin,varargin)
% Sin ... input structure with following fields
%   dff ... calcium trace (a vector)
%   rate ... acquisition rate of the calcium trace / Hz
%   A1 ... single AP amplitude / % DFF (e.g. 6-7% for OGB1-AM)
%   tau1 ... indicator decay time / s (e.g. 0.5-1 s for OGB1-AM)
%   onsettau ... indicator onset time / s (e.g. 10ms for OGB1-AM)
%   optimMethod ... optimization routine ('simulated annealing', 'pattern
%   search' or 'none') --> currently disabled
%
%   Schmitt-trigger settings (bounds are only required if an optimization
%   method is selected)
%   schmittHi ... Schmitt-trigger high treshold (x0 , lbound, ubound)
%   schmittLo ... Schmitt-trigger low treshold (x0 , lbound, ubound)
%   schmittMinDur ... Schmitt-trigger min. duration / s (x0 , lbound, ubound)
%
%   Optimization algorithm settings (only if an optimization routine is
%   specified)
%   minPercentChange ... min. change in the objective function, relative to
%   start value, if change is less than this value, optimization will
%   terminate (e.g. 0.1 for 10% of starting residual)
%   maxIter ... max. iterations of objective function evaluation
%
%   More peeling settings
%   plotFinal ... plot the final reconstruction result

% Peeling algorithm was developed by Fritjof Helmchen, Brain Research
% Institute, University of Zurich, Switzerland
% Matlab implementation by Fritjof Helmchen and Henry Luetcke, Brain Research
% Institute, University of Zurich, Switzerland
% Please cite:
% Nat Methods. 2010 May;7(5):399-405. High-speed in vivo calcium imaging
% reveals neuronal network activity with near-millisecond precision.
% Grewe BF, Langer D, Kasper H, Kampa BM, Helmchen F.

if nargin > 1
    dff = varargin{1};
else
    dff = Sin.dff;
end
rate = Sin.rate;

% InitPeeling is now called within main Peeling routine
% [ca_p,exp_p,peel_p, data] = InitPeeling(dff,rate);

% override some of the default parameters set in InitPeeling
ca_p.amp1= Sin.A1; % single AP amplitude / % DFF (e.g. 6-7% for OGB1-AM)
ca_p.tau1= Sin.tau1; % indicator decay time / s (e.g. 0.5-1 s for OGB1-AM)
ca_p.onsettau = Sin.onsettau; % indicator onset time / s (e.g. 10ms for OGB1-AM)

% Optimization settings
% optimMethod can be 'simulated annealing', 'pattern search' or 'none'
% optimMethod = Sin.optimMethod;

% Schmitt trigger settings for finding events (in units of SD of the
% calcium trace)
% for optimization, this should be a 3 column vector for each threshold,
% specified as [x0 lbound ubound]
% play with these parameters depending on the noise
schmittHi = Sin.schmittHi;
schmittLo = Sin.schmittLo;
schmittMinDur = Sin.schmittMinDur; % minimum duration for events / s

% t = 1/rate:1/rate:length(dff)/rate;

% SD of calcium trace (filter low frequency drifts, e.g. slower than 0.5 Hz)
% this approach for estimating the noise only works well for low firing
% rates
dff_filt = mpi_BandPassFilterTimeSeries(dff,1/rate,0.5,rate*2);
SDdff = std(dff_filt);

% Schmitt trigger - high threshold, relative to noise
peel_p.smtthigh = schmittHi(1)*SDdff;
peel_p.smttlow = schmittLo(1)*SDdff;
peel_p.smttmindur= schmittMinDur(1);
peel_p.slidwinsiz = 100.0;
peel_p.fitupdatetime=2.0;
peel_p.doPlot = Sin.plotFinal;
peel_p.optimizeSpikeTimes = Sin.optimizeSpikeTimes;

% spike time optimization settings (only useful at higher frame rates)
peel_p.fitonset = 0;
peel_p.optimizeSpikeTimes = 0;

exp_p = struct;

[ca_p, peel_p, data] = Peeling(dff, rate, ca_p, exp_p, peel_p);

Sout.ca_p = ca_p;
Sout.peel_p = peel_p;
Sout.data = data;


% % previous version with optimization of Schmitt trigger thresholds
% % (currently disabled)
% opt_args.dff = dff;
% opt_args.rate = rate;
% opt_args.ca_p = ca_p;
% opt_args.exp_p = exp_p;
% opt_args.peel_p = peel_p;
% opt_args.data = data;
% opt_args.SDdff = SDdff;
% 
% if ~isfield(Sin,'plotFinal')
%    Sin.plotFinal = 0;
% end
% 
% opt_args.peel_p.doPlot = 0;
% 
% switch lower(optimMethod)
%     case {'simulated annealing','pattern search'}
%         x0 = [schmittHi(1) schmittLo(1) schmittMinDur(1)];
%         lbound = [schmittHi(2) schmittLo(2) schmittMinDur(2)];
%         ubound = [schmittHi(3) schmittLo(3) schmittMinDur(3)];
%         fvalStart = peelObjFunc(x0,opt_args);
% end
% 
% switch lower(optimMethod)
%     case 'simulated annealing'
%         options = saoptimset;
%         options.TolFun = Sin.minPercentChange.*fvalStart;
%         options.MaxIter = Sin.maxIter;
%         [x fval , ~, output] = simulannealbnd(...
%             @(x) peelObjFunc(x,opt_args),x0,lbound,ubound,options);
%     case 'pattern search'
%         options = psoptimset;
%         options.TolFun = Sin.minPercentChange.*fvalStart;
%         optins.MaxIter = Sin.maxIter;
%         [x fval , ~, output] = patternsearch(...
%             @(x) peelObjFunc(x,opt_args),x0,[],[],[],[],lbound,...
%             ubound,[],options);
%     case 'none'
%         opt_args.peel_p.doPlot = Sin.plotFinal;
%         opt_args.peel_p.smtthigh = schmittHi(1)*SDdff;
%         opt_args.peel_p.smttlow = schmittLo(1)*SDdff;
%         opt_args.peel_p.smttmindur= schmittMinDur(1);
%         [opt_args.ca_p, opt_args.peel_p, opt_args.data] = ...
%             Peeling(opt_args.ca_p, opt_args.exp_p, opt_args.peel_p, opt_args.data);
%     otherwise
%         error('Optimization method %s not supported.',optimMethod)
% end
% 
% opt_args.peel_p.doPlot = Sin.plotFinal;
% 
% switch lower(optimMethod)
%     case {'simulated annealing','pattern search'}
%         fvalDiff = fvalStart-fval;
%         fprintf('Finished optimization (%s)\n',optimMethod);
%         fprintf('Final schmitt trigger thresholds:\n%1.3f %1.3f %1.3f\n',x(1),x(2),x(3));
%         fprintf('Starting sum of squared residuals: %1.3f\n',fvalStart);
%         fprintf('Final sum of squared residuals: %1.3f (Difference: %1.3f)\n',...
%             fval,fvalDiff);
%         fprintf('Elapsed time: %1.2f s\n',output.totaltime);
%         opt_args.peel_p.smtthigh = x(1)*SDdff;
%         opt_args.peel_p.smttlow = x(2)*SDdff;
%         opt_args.peel_p.smttmindur= x(3);
%         [opt_args.ca_p, opt_args.peel_p, opt_args.data] = ...
%             Peeling(opt_args.ca_p, opt_args.exp_p, opt_args.peel_p, opt_args.data);
% end
% 
% Sout = opt_args;
% 
% 
% 
% 


