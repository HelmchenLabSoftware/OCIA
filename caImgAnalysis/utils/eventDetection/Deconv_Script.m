function [out, outspikes, outdens] = Deconv_Script(drrfile, motfile, MCP_18Hz, Ca, JointX_18Hz, JointY_18Hz)

% load(drrfile);
% load(motfile);

frameRate = 9;
orgFrames = round(length(MCP_18Hz)/2)*2-1;
extraFrames = 20;
totFrames = orgFrames  + extraFrames;

doPlot = 1;

siz = size(Ca.dRR);
cellNum = siz(1);
trialNum = 1;
cellNo = 1;   % specific cell
deconv_Smooth = 0.005; % smoothness parameter
convert2Hz = frameRate;  % conversion factor to instantaneous rate

clear drr_out; drr_out = zeros(orgFrames,cellNum);
clear deconv_out; deconv_out = zeros(orgFrames,cellNum);
clear test; test = zeros(1,totFrames);

clear spike_out; spike_out = zeros(orgFrames,cellNum);
clear spike_density; spike_density = zeros(orgFrames,cellNum);

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
        test(1,1:orgFrames) = Ca.dRR{numi,ii}(1,1:orgFrames);
        mean_last = sum(Ca.dRR{numi,ii}(1,(orgFrames-2):orgFrames))/3;
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

%close all;

% now do peeling
%pdrr = drr_out'*100;
%[ca_p,exp_p,peel_p, data] = InitPeeling(pdrr, frameRate);
%[ca_p, peel_p, data] = Peeling(pdrr, frameRate);

% now plot all relevant

%figure; plot(drr_out(1:449,1),'DisplayName','drr_out(1:449,1)','YDataSource','drr_out(1:449,1)');figure(gcf)
%figure; plot(deconv_out(1:449,1),'DisplayName','deconv_out(1:449,1)','YDataSource','deconv_out(1:449,1)');figure(gcf)
%figure; plot(f,2*abs(ff(1:NFFT/2+1)));
%figure; plot(f,2*abs(psd(1:NFFT/2+1)));

out = drr_out';
outspikes = spike_out';
spikhist = sum(outspikes(:,1:orgFrames));

outdens = spike_density';
denshist = sum(outdens(:,1:orgFrames));

if (doPlot == 1)
    figure;
    subplot(4,1,1,'Position',[0.1 0.75 0.85 0.2]);
    h = imagesc(out(1:55,1:orgFrames));
    ylabel('DR/R'); xlim([0 orgFrames]);
    %colormap('jet');
    caxis([-0.01 0.3]);

    subplot(4,1,2,'Position',[0.1 0.5 0.85 0.2]);
    plot(MCP_18Hz(1,1:orgFrames));
    ylabel('MCP Angle');
    xlim([0 orgFrames]);

    subplot(4,1,4,'Position',[0.1 0.05 0.85 0.2]);
    s = imagesc(outdens(1:55,1:orgFrames));
    map2 = colormap('gray');
    xlabel('Frames');
    ylabel('Spikes'); xlim([0 orgFrames]);
    %colormap('gray');
    caxis([0 2]);

    subplot(4,1,3,'Position',[0.1 0.3 0.85 0.2]);
    plot(denshist(1:orgFrames));
    ylabel('PSTH');
    xlim([0 orgFrames]);
    
%     subplot(4,1,3,'Position',[0.1 0.3 0.85 0.2]);
%     RunningPlot(JointX_18Hz,JointY_18Hz);
%     ylabel('PSTHLimb');
end






