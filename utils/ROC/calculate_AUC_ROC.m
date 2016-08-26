function [AUC, P_X, P_Y] = calculate_AUC_ROC(X_summary, Y_summary)

        [rowX colX] = size(X_summary);
        [rowY colX] = size(Y_summary);
        Y_avg = nanmean(Y_summary, 1);
        X_avg = nanmean(X_summary, 1);
    
        Y_DV = [];
            
        for www = 1:rowY
            if www == 1
                Y_avgb = nanmean(Y_summary(2:end,:), 1);
            elseif www == rowY
                Y_avgb = nanmean(Y_summary(1:end-1,:), 1);
            else
                Y_summaryb = [Y_summary(1:www-1,:); Y_summary(www+1:end,:)];
                Y_avgb = nanmean(Y_summaryb,1);
            end
            DV = dot(Y_summary(www,:),X_avg)  - dot(Y_summary(www,:), Y_avgb);
            Y_DV = [Y_DV, DV];
        end
        
        X_DV = [];
    
        for www = 1:rowX
            if www == 1
                X_avgb = nanmean(X_summary(2:end,:), 1);
            elseif www == rowY
                X_avgb = nanmean(X_summary(1:end-1,:), 1);
            else
                X_summaryb = [X_summary(1:www-1,:); X_summary(www+1:end,:)];
                X_avgb = nanmean(X_summaryb,1);
            end
            DV = dot(X_summary(www,:),X_avgb)  - dot(X_summary(www,:), Y_avg);
            X_DV = [X_DV, DV];
        end
             
        if max(X_DV) > max(Y_DV)
            maxval = nanmax(X_DV);
        else
            maxval = nanmax(Y_DV);
        end
    
        if min(X_DV) < min(Y_DV)
            minval = nanmin(X_DV);
        else
            minval = nanmin(Y_DV);
        end
    
        step_size = 100;
    
        step = (maxval - minval)/step_size;
    
        P_X =  [];
        P_Y =  [];
            
        for vvv = 1:step_size+1
            crit = minval+(step*(vvv-1)); 
            X_val = sum(X_DV < crit)/rowX;
            Y_val = sum(Y_DV < crit)/rowY;
            P_X =  [P_X, X_val];
            P_Y =  [P_Y, Y_val];
        end
    
%         plot(P_X, P_Y);
       
        % AUC
    
        AUC = 0; 
        for uuu = 2:step_size
            X_int = P_X(uuu)-P_X(uuu-1);
            if X_int > 0
                AUC = AUC + X_int * P_Y(uuu-1) + (X_int * (P_Y(uuu)-P_Y(uuu-1))/2);
            end
        end

end