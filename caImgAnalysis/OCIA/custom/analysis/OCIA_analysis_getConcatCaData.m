function [concatCaTraces, concatStims, concatCaTracesSGFilt, ROINames, t, hashStruct] ...
    = OCIA_analysis_getConcatCaData(this, iDWRows)

totalTic = tic; % for performance timing purposes

%% get the imaging data
ANShowHideMessage(this, 1, 'Loading data ...');
loadDataTic = tic; % for performance timing purposes
% get the calcium traces
[~, ~, ROINames, concatCaTraces, concatStims, ~, ~, ~, hashStruct] = OCIA_analysis_getCaTracesMatrix(this, iDWRows, 1);
% get the size of the dataset
[nROIs, nConcatFrames] = size(concatCaTraces);
% only show message if some traces are present
if ~isempty(concatCaTraces);
    showMessage(this, sprintf('Loading data done (%3.1f sec).', toc(loadDataTic)));
end;

%% prepare data
% get the filtering parameter
SGFiltSize = this.an.img.sgFiltFrameSize;
% use the raw traces by default
concatCaTracesSGFilt = concatCaTraces;
% apply filtering if required
if SGFiltSize > 1;
    if mod(SGFiltSize, 2) == 0;
        SGFiltSize = SGFiltSize + 1;
        this.an.img.sgFiltFrameSize = SGFiltSize;
    end;
    concatCaTracesSGFilt = nan(size(concatCaTraces));
    for iROI = 1 : nROIs;
        concatCaTracesSGFilt(iROI, :) = sgolayfilt(concatCaTraces(iROI, :), 1, SGFiltSize);
    end;
end;

% create a time vector
t = (1 : nConcatFrames) / this.an.img.defaultFrameRate;

o('#%s done (%3.1f sec).', mfilename(), toc(totalTic), 2, this.verb);

end