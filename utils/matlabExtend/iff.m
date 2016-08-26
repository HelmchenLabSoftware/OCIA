function result = iff(condition, trueResult, falseResult, iElemTrue, iElemFalse)
    narginchk(3, 5);
    if condition;
        if exist('iElemTrue', 'var') && ~isempty(iElemTrue);
            result = trueResult(iElemTrue);
        else
            result = trueResult;
        end;
    else
        if exist('iElemFalse', 'var') && ~isempty(iElemFalse);
            result = falseResult(iElemFalse);
        else
            result = falseResult;
        end;
    end;
end