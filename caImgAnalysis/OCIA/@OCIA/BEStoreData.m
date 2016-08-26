function BEStoreData(this, ~, event)
% BEStoreData - [no description]
%
%       BEStoreData(this, ~, event)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% tic;

try
    
    nRecChans = size(event.Data, 2);
    for iAnIn = 1 : nRecChans;
        anInName = this.be.hw.analogIns{iAnIn};
        currChanData = event.Data(:, iAnIn) - mean(event.Data(:, iAnIn));
        this.be.anInData.(anInName) = [this.be.anInData.(anInName); currChanData];
        nSamples = size(this.be.anInData.(anInName), 1);
%         o('#%s: nSamples: %d', mfilename(), nSamples, 3, this.verb);
        currentDur = nSamples / this.be.hw.anInSampRate;
        
        % process the analog inputs
        procSampleRange = (size(this.be.anInData.(anInName), 1) - 400 + 1) : size(this.be.anInData.(anInName), 1);
        procSampleRange(procSampleRange < 1 | procSampleRange > size(this.be.anInData.(anInName), 1)) = [];
        if ~isempty(procSampleRange);
            try
                procCurrChanData = this.be.anInData.(anInName)(procSampleRange, 1);
            catch
                procCurrChanData = [];
            end;
        else
            procCurrChanData = [];
        end;
        % filter data if required
        filtSize = this.GUI.be.anInFilt(iAnIn);
        if filtSize;
            if mod(filtSize, 2) == 0; filtSize = filtSize + 1; end;
            procCurrChanData = sgolayfilt(procCurrChanData, 1, filtSize);
        end;

        % calculate the absolute value of the data
        if this.GUI.be.anInDoAbs(iAnIn);
            procCurrChanData = abs(procCurrChanData);
        end;
        
        % remove single peaks
        singPeakThresh = nanmean(procCurrChanData) + 3 * nanstd(procCurrChanData);
        if strcmp(anInName, 'piezo') && any(procCurrChanData > singPeakThresh);
            abovePoints = find(procCurrChanData > singPeakThresh);
            oldData = procCurrChanData; %#ok<NASGU>
            if numel(abovePoints) == 1;
                procCurrChanData(abovePoints) = nanmean( ...
                    procCurrChanData([1 : (abovePoints - 1), (abovePoints + 1) : end]));
            end;
            %{
            plot(oldData, 'r');
            hold on;
            plot(procCurrChanData, 'g');
            plot([1 numel(procCurrChanData)], repmat(singPeakThresh, 1, 2), 'Color', 'blue', 'LineStyle', ':');
            for iPoint = 1 : numel(abovePoints);
                abovePoint = abovePoints(iPoint);
                scatter(abovePoint, procCurrChanData(abovePoint) * 1.1, 'bx');
            end;
            hold off;
            %}
        end;
        
        % calculate the sum trace of the data
        if this.GUI.be.anInDoSpecial(iAnIn);
            procCurrChanData = repmat(nanmean(procCurrChanData) + (2 * std(procCurrChanData) .^ 5), ...
                numel(procCurrChanData), 1);
            procCurrChanData = abs(procCurrChanData - iff(isnan(this.be.params.piezoBL), 0.0001, this.be.params.piezoBL));
        end;
        
%         o('#%s: %d samples', mfilename(), numel(procCurrChanData), 0, this.verb);
        
        % replace processed data
        try
            this.be.procAnInData.(anInName)(procSampleRange, 1) = procCurrChanData;
            this.be.procAnInData.(anInName)(procSampleRange(end + 1) : end, 1) = [];
        catch
        end;
        
        % clear end of processed data
        try
            this.be.procAnInData.(anInName)(procSampleRange(end + 1) : end, 1) = [];
        catch
        end;
        
        % too much data and experiment is not running
        if ~this.be.isRunning && currentDur > this.be.hw.maxRecDur;
            
            this.be.anInData.(anInName) = currChanData;
            this.be.procAnInData.(anInName) = [];
            this.be.procAnInData.(anInName) = procCurrChanData(end - numel(currChanData) + 1 : end, 1);
            
        % too much data and experiment is running but paused
        elseif this.be.isRunning && this.be.isPaused && strcmp(this.be.trialPhase, 'paused') ...
                && currentDur > this.be.hw.maxRecDur;
            
            this.be.anInData.(anInName) = currChanData;
            this.be.procAnInData.(anInName) = [];
            this.be.procAnInData.(anInName) = procCurrChanData(end - numel(currChanData) + 1 : end, 1);
            
        % too much data and experiment is running
        elseif this.be.isRunning && currentDur > this.be.hw.maxRecDur;
            
            this.be.anInData.(anInName)(round(this.be.hw.maxRecDur * this.be.hw.anInSampRate) : end) = [];
            this.be.procAnInData.(anInName)(round(this.be.hw.maxRecDur * this.be.hw.anInSampRate) : end) = [];
            
        end;
        
        % remove last parts of processed data
        try
            this.be.procAnInData.(anInName)(min(numel(this.be.procAnInData.(anInName)), numel(this.be.anInData.(anInName))) : end) = [];
        catch
        end;
        
    end;
    
catch err;
    
    % show error
    errStack = getStackText(err);
    showWarning(this, 'OCIA:BEStoreData', sprintf('Behavior: caught error (%s): "%s".', err.identifier, err.message));
    o(errStack, 0, 0);
    
end;

% o('#%s: %.3f sec', mfilename(), toc(), 0, this.verb);

end


