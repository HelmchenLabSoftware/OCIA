function [out] = Deconv_Wiener(out)
%
% Wiener deconvolution for spike rate estimation underlying calcium
% transients;
% Output: spike train vectors and inst. rate vectors for all cells and all
% trials
% last update 8.2.2104, Fritjof Helmchen, Brain Research Institute, UZH
%
frameRate = out{1,1}.Ca.sample_rate;
convert2Hz = frameRate;  % conversion factor to instantaneous rate

% presumed elementary calcium transient, onset exponential and single-exponential decay
% values for YC-Nano140
drr_amp = 0.045;  % DR/R amplitude 4.5% 
drr_onset = 0.05;  % in sec
drr_tau = 0.7;  % in sec
deconv_Smooth = 0.005; % smoothness parameter

cellNum = numel(out{1,1}.Ca.roiLabel);
trialNum = numel(out);
totNum = cellNum*trialNum;

all_wiener = cell(cellNum,1);

h = waitbar(0,'Wiener Filter! Please wait...');

for ii = 1:trialNum
    orgFrames = numel(out{1,ii}.Motor.Params_18(:,2));
    if (mod(orgFrames,2) == 0)
        extraFrames = frameRate*2+1; % equivalent to 2 sec, plus one extra point to make totFrames odd
    else
        extraFrames = frameRate*2; % equivalent to 2 sec 
    end
    totFrames = orgFrames  + extraFrames;
    
    % presumed elementary calcium transient
    kern = drr_amp*(1-exp(-((1:totFrames)*1-1)/frameRate/drr_onset)).*exp(-((1:totFrames)*1-1)/frameRate/drr_tau);
    
    % prepare arrays 
    Ca_tmp = zeros(1,totFrames); % expanded Ca transient
    deconv_out = zeros(1,orgFrames);
        
    for numi= 1:cellNum
        Ca_tmp(1,1:orgFrames) = out{1,ii}.Ca.dRR{numi,1}(1,1:orgFrames);
        mean_last = sum(out{1,ii}.Ca.dRR{numi,1}(1,(orgFrames-2):orgFrames))/3;
        Ca_tmp(1,(orgFrames+1):(orgFrames+extraFrames)) = mean_last*exp(-((1:extraFrames)*1-1)/frameRate/drr_tau);
 
        inan = find(isnan(Ca_tmp(1,:)));
        Ca_tmp(1,inan) = 0;  % remove potentials NaN entrys and replace with zero
     
        % apply Wiener deconvolution to expanded Ca transient
        jj = deconvwnr(Ca_tmp,kern,deconv_Smooth);
        kk(1:round(totFrames/2))=jj(round(totFrames/2):totFrames);
        kk((round(totFrames/2)+1):totFrames)=jj(1:(round(totFrames/2)-1));
        deconv_out(1,1:orgFrames) = convert2Hz*kk(1,1:orgFrames)';
              
        all_wiener{numi,1} = deconv_out;
        
        waitbar(((ii-1)*cellNum+numi)/totNum);
    end
    out{1,ii}.Ca.Wiener_Rate = all_wiener;
end

close(h);








