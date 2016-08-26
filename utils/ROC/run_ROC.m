
% provide as input
% X_summary matrix of dRR from first condition, rows are trials, columns
% are timepoints across window of analysis
% Y_summary matrix of dRR from second condition, rows are trials, columns
% are timepoints across window of analysis
            
AUC_All = [];

if isempty(Y_summary) == 1
    AUC_All(1:1001) = NaN;
elseif isempty(X_summary) == 1
    AUC_All(1:1001) = NaN;
else
    Y_summary_temp = Y_summary;
    X_summary_temp = X_summary;
    
    for ttt = 1:1001
        if ttt == 1
            X_summary = X_summary_temp;
            Y_summary = Y_summary_temp;
        else
            [X_summary Y_summary] = shuffle_AUC(X_summary_temp, Y_summary_temp);
        end
        
        %% Calculate Decision Variable
        AUC = calculate_AUC_ROC(X_summary, Y_summary);
        AUC_All = [AUC_All, AUC];
    end
end

%% one can correct for sample size by adjusting for the AUROC of the shuffled distribution and subtract it
% from the real data's distribution and add back 50%

     
 