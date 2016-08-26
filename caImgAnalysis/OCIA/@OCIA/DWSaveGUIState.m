function GUIState = DWSaveGUIState(this, handles)
% DWSaveGUIState - [no description]
%
%       GUIState = DWSaveGUIState(this, handles)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
    
    % recurively saves the properties of the GUI elements as structures
    GUIState = struct();
    % go through all fields of the current handles
    GUIFields = fieldnames(handles);
    for iField = 1 : numel(GUIFields);
        handName = GUIFields{iField};
        hand = handles.(handName);
        % if the current element is a handle, get its properties
        if ishandle(hand);
            % go through all the properties to save, ignoring the invalid property error
            for iHandField = 1 : numel(this.GUI.toSaveProps);
                toSavePropName = this.GUI.toSaveProps{iHandField};
                try
                    GUIState.([handName this.GUI.saveHandleTag]).(toSavePropName) = get(hand, toSavePropName);
                catch err;
                    if ~strcmp(err.identifier, 'MATLAB:class:InvalidProperty');
                        rethrow(err);
                    end;
                end;
            end;
        % if the current element is a structure, recursively fetch the properties of its sub-handles and sub-structures
        elseif isstruct(hand);
            GUIState.(handName) = DWSaveGUIState(this, hand);
        elseif isempty(hand)
            GUIState.(handName) = [];
        else
            showWarning(this, 'OCIA:DWSaveGUIState:UnknownField', sprintf('Unknown field found: %s.', handName));
        end;

    end;
    
end
