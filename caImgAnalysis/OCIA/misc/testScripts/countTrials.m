% count trials

selRows = this.dw.selectedTableRows;
comments = get(this, selRows, 'comments');

days = get(this, selRows, 'day');
uniqueDays = unique(days);

IDs = {
    '.',       '';
    'low',     'high';
    'targ',    'distr';
    '(targ / corr)|(distr / false)',    '(targ / false)|(distr / corr)';
    'corr',    'false';
};

counts = zeros(size(IDs));

for iDay = 1 : numel(selRows); 
    for iRow = 1 : numel(selRows);    
        for iID = 1 : numel(IDs);
            counts(iID) = counts(iID) + double(~isempty(regexp(comments{iRow}, IDs{iID}, 'once')));
        end;
    end;
end;

countsPerDay = cell(numel(uniqueDays), 1);
for iDay = 1 : numel(uniqueDays); 
    countsPerDay{iDay} = zeros(size(IDs));
    for iRow = 1 : numel(selRows);
        if ~strcmp(days{iRow}, uniqueDays{iDay}); continue; end;
        for iID = 1 : numel(IDs);
            countsPerDay{iDay}(iID) = countsPerDay{iDay}(iID) + double(~isempty(regexp(comments{iRow}, IDs{iID}, 'once')));
        end;
    end;
end;