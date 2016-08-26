function [X_summary Y_summary] = shuffle_AUC(X_summary_temp, Y_summary_temp)

    [rowX colX] = size(X_summary_temp);
    [rowY colX] = size(Y_summary_temp);

    combined = [X_summary_temp; Y_summary_temp];
    combined = combined(randperm(rowX+rowY),:);
    
    X_summary = combined(1:rowX,:);
    Y_summary = combined(rowX+1:end,:);

end



