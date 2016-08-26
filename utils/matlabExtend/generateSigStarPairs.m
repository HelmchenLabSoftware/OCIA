function pairVectCell = generateSigStarPairs(significanceIndex, compStats)
    % Function to generate a pair vector cell array that is needed to plot
    % all significant multi-comparisons using sigstar
    % 
    % Usage: pairVectCell = generateSigStarPairs(significanceIndex, compStats)
    %
    % Author: A. van der Bourg, 2014
    pairDims = size(significanceIndex, 1);
    pairVectCell = cell(1, length(significanceIndex(significanceIndex ==1)));
    %Go through all possibilties and get the significant paired elements
    pairVectIndex =1;
    for pairIndex = 1:pairDims
        if significanceIndex(pairIndex,1) == 1
            % We obtain the pairs by getting the paired numbers for the
            % given significanceIndex entry in multiComparisonStats
            pairVectCell{1, pairVectIndex} = [compStats(pairIndex,1), compStats(pairIndex,2)];
            pairVectIndex = pairVectIndex +1;
        end;
    end
end