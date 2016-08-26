load('omlortest-1');
load('Resampled_Motor_Vectors');
drrfile = Ca.dRR{12,1}(1,:);
motfile = MCP_18Hz;

% inferring underlying spikes and pike rates from dR/R

[out] = Deconv_Wiener(out);  % adds Ca.Wiener_Rate to struct 'out' 
[out] = Deconv_Peeling(out); % adds Ca.Peel_Spikes and Ca.Peel_InstRate to struct 'out'  
