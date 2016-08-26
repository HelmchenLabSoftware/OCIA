function [out2, outspikes, outdens] = Deconvolution(out)

frameRate = 9;
orgFrames = round(numel(out{1,1}.Motor.CParams_18(:,2))/2)*2-1;
extraFrames = 20;
totFrames = orgFrames  + extraFrames;

cellNum = numel(out{1,1}.Ca.roiLabel)
trialNum = numel(out);

cellNo = 1;   % specific cell   ?????????????
deconv_Smooth = 0.005; % smoothness parameter
convert2Hz = frameRate;  % conversion factor to instantaneous rate


% presumed elementary calcium transient (YC-Nano140)
drr_amp = 0.045;
drr_onset = 0.05;
drr_tau = 0.7;
kern = drr_amp*(1-exp(-((1:totFrames)*1-1)/frameRate/drr_onset)).*exp(-((1:totFrames)*1-1)/frameRate/drr_tau);

% smoothing kernel for converting spike trains into inst. firing rate (in
% Hz); sigma in frames (default: 1.2 frames = 66.7 ms) 
gausskern = normpdf((1:orgFrames),round(0.5*orgFrames),1.2);

%kern = smooth(kern(:),3)';

for ii = 1:trialNum
    for numi= 1:cellNum
        test(1,1:orgFrames) = out{1,trialNum}.Ca.CdRR{numi,ii}(1,1:orgFrames);
        mean_last = sum(out{1,trialNum}.Ca.CdRR{numi,ii}(1,(orgFrames-2):orgFrames))/3;
        test(1,(orgFrames+1):(orgFrames+extraFrames)) = mean_last*exp(-((1:extraFrames)*1-1)/frameRate/drr_tau);
    
        %test = smooth(test(:),3)';
        jj = deconvwnr(test,kern,deconv_Smooth);
        
        %jj = deconvlucy(test,kern,20);
        %PSF = gausswin(60)';
        %test2 = edgetaper(test,PSF);
        %jj = deconvreg(test2,kern,0.1);
    
        kk(1:round(totFrames/2))=jj(round(totFrames/2):totFrames);
        kk((round(totFrames/2)+1):totFrames)=jj(1:(round(totFrames/2)-1));
        deconv_out(1:orgFrames,numi) = frameRate*kk(1,1:orgFrames)';

        % now Peeling algorithm
        drr_out(1:orgFrames,numi) = test(1,1:orgFrames)';
        pdrr = drr_out(1:orgFrames,numi)'*100;
        [ca_p,exp_p,peel_p, data] = InitPeeling(pdrr, frameRate);
        
        [ca_p, peel_p, data] = Peeling(pdrr, frameRate);
        
        spike_out(1:orgFrames,numi) = data.spiketrain;
        
        APdens = conv(data.spiketrain', gausskern);
        
        spike_density(1:orgFrames,numi) = APdens(round(0.5*orgFrames):round(0.5*orgFrames)+orgFrames-1)';
        
        if (mod(numi,10) == 0) 
            numi
        end
    end
end


% now FFT of drrout
NFFT = 2^nextpow2(orgFrames);
ff = fft(drr_out(1:orgFrames,1),NFFT)/orgFrames;
psd = ff.*conj(ff)*orgFrames;
f = frameRate/2*linspace(0,1,NFFT/2+1);

out2 = drr_out';
outspikes = spike_out';
spikhist = sum(outspikes(:,1:orgFrames));

outdens = spike_density';
denshist = sum(outdens(:,1:orgFrames));

end






