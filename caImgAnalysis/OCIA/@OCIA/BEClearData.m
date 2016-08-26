function BEClearData(this, varargin)

o('#%s ...', mfilename(), 2, this.verb);
% update mean
if ~isempty(this.be.procAnInData) && isfield(this.be.procAnInData, 'piezo');
    this.be.params.piezoBLMed = nanmean(this.be.procAnInData.piezo);
    set(this.GUI.handles.be.piezoBLMedLab, 'String', sprintf('Med = %0.8f', this.be.params.piezoBLMed));
end;

% reset the stored data
for iChan = 1 : size(this.be.hw.analogIns, 2);
    anInName = this.be.hw.analogIns{iChan};
    if numel(varargin) > 0;
        this.be.anInData.(anInName)(1 : min(varargin{1}, size(this.be.anInData.(anInName), 1))) = [];
        this.be.procAnInData.(anInName)(1 : min(varargin{1}, size(this.be.procAnInData.(anInName), 1))) = [];
    else
        this.be.anInData.(anInName) = [];
        this.be.procAnInData.(anInName) = [];
    end;
end;
o('#%s done.', mfilename(), 2, this.verb);
    
end