function DWLoadGUIState(this, GUIState, GUIStatePath)
% DWLoadGUIState - [no description]
%
%       DWLoadGUIState(this, GUIState, GUIStatePath)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

    % recurively load the properties of the GUIState structure in the GUI elements
    currMainHand = this.GUI.handles;
    for iGUIStatePath = 1 : numel(GUIStatePath);
        currMainHand = currMainHand.(GUIStatePath{iGUIStatePath});
    end;
    if isempty(GUIState);
        return;
    end;
    GUIFields = fieldnames(GUIState);
    for iField = 1 : numel(GUIFields);
        handName = GUIFields{iField};
        if regexp(handName, [this.GUI.saveHandleTag '$']);
            handFields = fieldnames(GUIState.(handName));
            handNameClean = regexprep(handName, [this.GUI.saveHandleTag '$'], '');
            for iHandField = 1 : numel(handFields);
                handFieldName = handFields{iHandField};
                try
                    set(currMainHand.(handNameClean), handFieldName, GUIState.(handName).(handFieldName));
                catch err;
                    if ~(strcmp(err.identifier, 'MATLAB:hg:propswch:FindObjFailed') ...
                            && ~isempty(regexp(err.message, ...
                            '^Attempt to modify a property that is read-only.', 'once'))) ...
                     && ~(strcmp(err.identifier, 'MATLAB:class:InvalidProperty') ...
                            && ~isempty(regexp(err.message, ...
                            '^The name ''\w+'' is not an accessible property for an instance of class ''\w+''\.', ...
                            'once'))) ...
                     && ~(strcmp(err.identifier, 'MATLAB:nonExistentField') ...
                            && ~isempty(regexp(err.message, '^Reference to non-existent field ''\w+''.', 'once')));                       
                        rethrow(err);
                    end;
                end;
            end;
        else
            DWLoadGUIState(this, GUIState.(handName), [GUIStatePath, handName]);
        end;
        
    end;
    
end
