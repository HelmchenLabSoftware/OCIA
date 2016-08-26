function A = struct2cellArray(S)
% convert structure to pseudo-input cellarray
% A is a cell array with 'fieldname1' value1 'fieldname2' value2 etc.
% useful for allowing function inputs as 'property'-value pair or structure

% this file written by Henry Luetcke (hluetck@gmail.com)

fields = fieldnames(S);
pos = 1;
A = {};
for n = 1:length(fields)
    A{pos} = fields{n}; pos = pos+1;
    A{pos} = S.(fields{n}); pos = pos + 1;
end