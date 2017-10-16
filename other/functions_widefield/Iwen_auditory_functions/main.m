%% best frequency (BF) determination

sf = 44100; % 44100
dur = 0.1; % sec
dutyCycle = 0.8; % ISI, sec

f0 = 4000; %2000;
%fqnStep = 2.^0.25; % 0.25 octaves, numFqn = 15
fqnStep = 2.^0.5; % 0.5 octaves, numFqn = 8

numFqn = 8;
fqnVector = zeros(1, numFqn);
for n = 1: numFqn
    fqnVector(n) = f0*fqnStep.^(n-1); 
end
stimVector = randperm(numFqn); % random permutation
BFtoneArray = MakePureToneArray(fqnVector,stimVector,dur,sf); % ON-, OFF-ramp = 0.05 s

toneArray = BFtoneArray;
PlayToneArray(toneArray,sf,dutyCycle,0,0);
numSweep = 2;
for i = 1:numSweep
    PlayToneArray(toneArray,sf,dutyCycle,0,0);
end


%ampMod =[1 0.4 1 0.5 0.5 1 0.8 0.6 0.6 0.6 1 1 0.45 1 1];
%ampMod = [1 1 0.4 0.5 1 1 1 1]; % fqnStep as 0.5 octaves
% ampMod = [1 1 0.5 0.8 0.6 1 0.45 1];
% for n = 1: numFqn    
%     id = find (stimVector == n);
%     toneArray{n} = BFtoneArray{n}.*ampMod(id);    
% end

%% generate psedurandom stimVector
sf = 44100; % 44100
dur = 0.1; % sec
dutyCycle = 0.8; % ISI, sec
f0 = 4000; %2000;
fqnStep = 2.^0.5; % 0.5 octaves, numFqn = 5
numFqn = 5;
fqnVector = zeros(1, numFqn);
for n = 1: numFqn
    fqnVector(n) = f0*fqnStep.^(n-1); 
end

SV = cell(1, 20);
FV = deal(SV);
for n = 1: 20
    svMat = randperm(numFqn);
    SV{n} = svMat;
    
    fvMat = nan(1, numel(svMat));
    for m = 1: numel(svMat)
        fvMat(m) = fqnVector(svMat(m));
        clear m
    end
    FV{n} = fvMat;    
    clear n svMat fvMat
end
SV = cell2mat(SV);
FV = cell2mat(FV);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% fqnVector_CF.mat, stimMatrix.mat
% % CF
% % fqnVector_CF (1*numFqn)
% fqnStep = 2^(0.25); % 0.25 octave as fqnStep
% numFqn = 15;
% fqnVector = zeros(1, numFqn);
% for n = 1: numFqn
%     fqnVector(n) = f0*fqnStep.^(n-1); 
%     clear n
% end
% 
% % stimMatrix_CF (rep*numFqn)
% rep = 15;
% stimMatrix = zeros(rep, numFqn);
% for n = 1: rep
%     stimVector = randperm(numFqn);
%     stimMatrix(n, :) = stimVector;
%     clear n stimVector
% end
% 
% 
% % design aVector according to piezoMicTest_5XmV
% load piezoMicTest_5XmV; % var name: micVolt5X
% micVolt = micVolt5X/5;
% num_att = size(micVolt5X, 1);
% 
% attMatrix = zeros(size(micVolt));
% micSpl = zeros(size(micVolt));
% for n = 1: num_att
%     curMicVolt = micVolt(n, :);
%     ratio = min(curMicVolt)./ curMicVolt;
%     curAtt = round(ratio*10);
%     curAtt = curAtt/ 10;
%     attMatrix(n, :) = curAtt;
%     
%     spl = 20*log10(curMicVolt/2/sqrt(2)/(2.47*20*10^(-6))); % from mic manuel
%     micSpl(n, :) = spl;
%     
%     clear n curMicVolt ratio curAtt spl
% end
% 
% 
% % generating FIR coeffs for calibration (adapted from the website)
% ntaps = 250;
% nyquist = 97656.3; 
% filtcoefs = fir2(ntaps,freq_list,10.^(gain_list/20));
% fileid = fopen('C:\TDT\MyFIRcoefs.txt','wt+');
% fprintf(fileid,'%6f\n',filtcoefs);
% fclose(fileid);
% subplot(2,1,1);
% filtresp=fft(filtcoefs,1000);
% plot(freq_list*nyquist,gain_list, 'b-o',linspace(0,nyquist,...
% length(filtresp)/2),20*log10(abs(filtresp(1:length(filtresp)/2))),'r');
% xlabel('Frequency (Hz)'); ylabel('Gain (dB)');
% subplot(2,1,2)
% plot(filtcoefs);
% xlabel('Coefficient number'); ylabel('Coefficient value');
% 
% 
% % play tone via trigger from StartUp macro
% load fqnVector_CF;
% load stimMatrix3_CF;
% load attMatrix;
% toneAmp = 10;
% aLevel = 0;
% %attVector = attMatrix(1, :); % not using it anymore...
% 
% isi = 0.8;
% PureTone_exp_rcx(fqnVector, toneAmp, aLevel, stimMatrix(15, :), isi, 0); % 1 sweep, dur = 18000 ms
% 
% numSweep = 15;
% for i = 1: numSweep
%     PureTone_exp_rcx(fqnVector, toneAmp, aLevel, stimMatrix(i, :), isi, 1); 
% end
% 
% 
% % SSA
% % fqnVector_SSA
% BF = fqnVector(10);
% pDev = 0.1; % 0.1, 0.3
% fDev = 0.25; % 0.25, 0.125; in octave
% f1 = BF * 2.^fDev;
% f2 = BF * 2.^-fDev;
% 
% % constrains for SSA stimVector:
% % 1) oddball not the 1st
% % 2) avoiding oddball repetitively occurred when pDev = 0.1
% %numStim = 400;
% %stimVector = MakeStimVector_SSA(numStim, [pDev 1-pDev]);
% 
% load stimMatrix_SSApp1
% curSV = stimMatrix_SSApp1(1, :);
% 
% aLevel = 0;
% isi = 0.5;
% 
% PureTone_exp_rcx([f1 f2], toneAmp, aLevel, curSV, isi, 0); % 55000 ms per sweep
% 
% 
% %% new config of sound via TDT
% 
% DIR1 = 'E:\I-Wen\2014-12-12';
% mkdir(DIR1);
% 
% DIR2 = 'W:\Neurophysiology\RawData\I-Wen_Chen\2014_12_12';
% mkdir(DIR2);
% 
% % CFtest
% % during exp.
% att = 10;
% cSV = 4; % corr. to x+1 th column, [0 11]
% %sweepDur = 50; % sec
% numPulse = 60; % sweepDur = 50000 ms in Igor
% curName = 't13';
% curName = ['data_' curName];
% cmd = [curName ' = CFtest (100, 800, numPulse, att, cSV);'];
% 
% eval(cmd);
% 
% data = CFtest (100, 800, 20, att, cSV);
% 
% % save all vaiables in workspace for online CF analysis
% varName = [DIR1 '\data']; % this may also be a bit dangerous in case of overwriting...
% save(varName);
% 
% 
% % SSAtest_freq
% att = 10;
% cfSV = 7; % CF Idx
% 
% %cSV = 10; % pDev = 0.1: 0~4, pDev = 0.3: 5~9, pDev = 0.5: 10~14, old one,
% %not suitable...
% pDev = 0.1; % 0.1, 0.3, 0.5
% cSV = 3; % always 0~4
% 
% swap = 1; 
% fDev = 0.5;
% curName = 't14';
% curName = ['data_' curName];
% numPulse = 100; % sweepDur = 53000 ms in Igor
% cmd = [curName ' = SSAtest_StimSplit (cfSV, fDev, 100, 500, numPulse, att, cSV, swap, pDev);'];
% 
% eval(cmd);
% 
% %sweepDur = 41; % in Igor 42000 ms sweepDur
% %cmd = [curName ' = SSAtest (cfSV, fDev, 100, 500, sweepDur, att, cSV, swap);'];
% %cmd = [curName ' = SSAtest_StimNum (cfSV, fDev, 100, 500, numPulse, att, cSV, swap);'];
% 
% data1 = SSAtest_StimSplit (6, fDev, 100, 500, 20, 10, 0, swap, pDev);
% 
% 
% %% buy cookies
% 
% %%
% 
% % SSAtest_DevOmi
% att = 10;
% cfSV = 7; % CF Idx-1, +1; CF
% 
% %cSV = 1; % pDev = 0.1: 0~4, pDev = 0.3: 5~9, pDev = 0.5: 10~14
% pDev = 0.1; % 0.1, 0.3, 0.5
% cSV = 0; % always 0~4
% swap = -1; % Deviant-alone: 1; Ommission: -1
% 
% curName = 't91';
% curName = ['data_' curName];
% numPulse = 100; % sweepDur = 53000 ms in Igor
% cmd = [curName ' = SSAtest_Omi_StimSplit (cfSV, 100, 500, numPulse, att, cSV, swap, pDev);'];
% 
% eval(cmd);
% 
% %sweepDur = 41; % in Igor 42000 ms sweepDur
% %cmd = [curName ' = SSAtest (cfSV, fDev, 100, 500, sweepDur, att, cSV, swap);'];
% %cmd = [curName ' = SSAtest_Omi (cfSV, 100, 500, numPulse, att, cSV, swap);'];
% 
% data2 = SSAtest_Omi_StimSplit (6, 100, 500, 20, 10, 0, swap, pDev);
% 
% 
% 
% 
% 
% 
% % SSAtest_intensity
% cfSV = 5; % CF Idx
% cSV = 2; % pDev = 0.1: 0~4, pDev = 0.3: 5~9, pDev = 0.5: 10~14
% 
% att = [10 20]; % [att_small att_large]
% swap = 1; % 
% numPulse = 100;
% %sweepDur = 41; % in Igor 42000 ms sweepDur
% curName = 't44';
% curName = ['data_' curName];
% cmd = [curName ' = SSAtest_int (cfSV, 100, 500, numPulse, att, cSV, swap);'];
% 
% eval(cmd);
% 
% data3 = SSAtest_int (7, 100, 500, 10, [0 20], 1, swap);
% 
% 
% % save data after exp.
% num_data = 23;
% DATA = cell(1, num_data);
% for n = 1: num_data
%     curData = ['data_t' num2str(n)];
%     curData = eval(curData);
%     DATA{n} = curData;
%     clear curData n
% end
% 
% 
% 
% 
% 
% 
% %%
% %freqVector = linspace(2000, 20000, numFqn); % 2 ~ 20 kHz
% stimVector = 1:numFqn; % ascending fqn order
% %stimVector = repmat(stimVector, 1, 10);
% BFtoneArray = MakePureToneArray(fqnVector,stimVector,dur,sf); % ON-, OFF-ramp = 0.05 s
% 
% ampMod =[1 0.4 1 0.5 0.5 1 0.8 0.6 0.6 0.6 1 1 0.45 1 1];
% %ampMod = [0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 1 0.8 1 1 1 1 1]; % fqnStep as 0.25 ocatves
% %ampMod = [1 1 0.4 0.5 1 1 1 1]; % fqnStep as 0.5 octaves
% for n = 1: numFqn
%     toneArray{n} = BFtoneArray{n}.*ampMod(n); 
% end
% 
% numSweep = 10;
% for i = 1:numSweep
%     PlayToneArray(toneArray,sf,dutyCycle,0,1);
% end
% 
% 
% %% oddball frequency according to BF
% 
% BF = fqnVector(6);
% pDev = 0.1; % 0.1, 0.3
% fDev = 0.25; % 0.25, 0.125; in octave
% 
% f1 = BF * 2.^fDev;
% f2 = BF * 2.^-fDev;
% 
% numStim = 50;
% load SSA_pp3_1; stimVector = SSA_pp3_1;
% %stimVector = MakeStimVector(numStim, [pDev 1-pDev]); % be careful that oddball should not be too close
% % use makeMMNexperiment.m to make oddball stimVectors
% % makeMMNexperiment([f1 f2],sf);
% 
% % oddball fqn
% oddFqnArray = MakePureToneArray([f1 f2],stimVector,dur,sf);
% oddFqnArray = MakePureToneArray([f2 f1],stimVector,dur,sf); % swap fqn
% 
% % oddball intensity with BF
% sV_int = ones(1, numStim); % [BF 0]
% %sV_int = 2*sV_int; % [0 BF]
% oddIntArray = MakePureToneArray([BF 0],sV_int,dur,sf);
% 
% id = 1: 1: numel(stimVector);
% %id_norm = find (stimVector == mode(stimVector));
% id_odd = find(stimVector ~= mode(stimVector));
% ampmod = 0.3; % for oddball intensity at BF, smaller than 0.3 cannot be recorded
% AMP = sV_int;
% for n = 1: numel(id_norm)
%     curOdd = id_norm(n);
%     AMP(curOdd) = ampmod;   
%     clear n
% end
% 
% for n = 1: numel(AMP)
%     oddIntArray{n} = oddIntArray{n}.*AMP(n); 
%     clear n
% end
% 
% % oddball ommission
% %oddOmiArray = MakePureToneArray([BF 0],stimVector,dur,sf);
% %oddOmiArray = MakePureToneArray([0 BF],stimVector,dur,sf);
% 
% % oddball duration
% 
% dutyCycle = 0.5;
% PlayToneArray(oddIntArray,sf,dutyCycle,0,0);
% 
% numSweep = 6; % notice the sweep duration in igor (10000 ms)
% for i = 1:numSweep
%     PlayToneArray(oddIntArray,sf,dutyCycle,0,1);
%     %PlayToneArray(oddFqnArray,sf,dutyCycle,0,1);
% end
% 
% 
% 
% 
% 
% 
% 
% %%
% freq = max(fqnVector);
% freqVector = repmat(freq, 1, 15);
% toneArray = MakePureToneArray(freqVector,stimVector,dur,sf);
% 
% PlayToneArray(toneArray,sf,dutyCycle,0,1);
% 
% 
% Amp = [0.32 0.47 0.22 0.18 0.28 0.10 0.02 0.06 0.04 0.06];
% ampMod = [0.8 0.6 1.1 1.4 1 35 35 50 50 20];
% ampMod = repmat(ampMod, 1, 10);
% for n = 1: numel(stimVector)
%    BFtoneArrayAmpMod{n} = BFtoneArray{n}.*ampMod(n); 
% end
% 
% PlayToneArray(BFtoneArrayAmpMod,sf,isi,0,0);
% 
% 
% 
% %%%%%%%%%%%%%%
% 
% 
% fVector = [4000 8000 12000 15000];
% stimVector = [1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4];
% dur = 0.2;
% sf = 96000;
% toneArray = MakePureToneArray(fVector,stimVector,dur,sf);
% stimVector = repmat(stimVector,1,5);