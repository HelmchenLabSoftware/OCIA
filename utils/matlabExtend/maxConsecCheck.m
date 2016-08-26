function exceedsMaxConsec = maxConsecCheck(sequence, maxConsec)
% checks whether a sequence of numbers has more than "maxConsec" consecutive times the same element

% a sequence has always at least 1 element
if maxConsec < 2;
    exceedsMaxConsec = true;
    return;
end;

% Use an interative difference calculation to retrieve numbers which are identical (difference = 0).
%   If after looping several times a 0 element is still present it means that there were several consecutive
%   elements were present
iLoop = 1;
diffSeq = diff(sequence);
% replace non-zeros by different numbers to avoid introducing false positive zeros
diffSeq(diffSeq ~= 0) = 1 : numel(diffSeq(diffSeq ~= 0));
while iLoop < maxConsec;
    diffSeq = diff(diffSeq);
    diffSeq(diffSeq ~= 0) = 1 : numel(diffSeq(diffSeq ~= 0));
    iLoop = iLoop + 1;
end;

exceedsMaxConsec = any(diffSeq == 0);

end
