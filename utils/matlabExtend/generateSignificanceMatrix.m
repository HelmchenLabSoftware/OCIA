function significanceIndex = generateSignificanceMatrix(comparisonMatrix)

%Create a significance matrix
significanceIndex = zeros(size(comparisonMatrix, 1), 1);

%% Find all significant pairs
for iPair = 1: size(comparisonMatrix, 1)
    % Check if variance interval is between zero (if both negative
    % or if both positive it is significant, otherwise not)!
    if comparisonMatrix(iPair, 3) < 0
        if comparisonMatrix(iPair, 5) < 0
            significanceIndex(iPair, 1) = 1;
        else
            significanceIndex(iPair, 1) = 0;
        end;
    else if comparisonMatrix(iPair, 3) > 0
            if comparisonMatrix(iPair, 5) > 0
                significanceIndex(iPair, 1) = 1;
            else
                significanceIndex(iPair, 1) = 0;
            end;
        end;
    end;
end;

end