
fr0=7:9;
ds=2;
dateID = '2016_02_18';
dateIDShort = regexprep(dateID, '_', '');
dateIDShort = [dateIDShort(1 : 4), dateIDShort(7:8), dateIDShort(5:6)];
basePath = 'C:/Users/WideField/Documents/LabVIEW Data/1601_behav/';
animIDs = dir([basePath 'mou_bl*']);
animIDs = animIDs(arrayfun(@(i)animIDs(i).isdir, 1 : numel(animIDs)));

for iAnim = 1 : numel(animIDs);
    
    basePathAnim = [basePath animIDs(iAnim).name '/' dateID '/widefield_labiew/'];
    sessIDs = dir([basePathAnim 'exp*']);
    sessIDs = sessIDs(arrayfun(@(i)sessIDs(i).isdir, 1 : numel(sessIDs)));
    fprintf('Processing animal %d "%s", %d session(s)...\n', iAnim, animIDs(iAnim).name, ...
        numel(sessIDs));

    for iSess = 1 : numel(sessIDs);

        basePathSess = [basePathAnim sessIDs(iSess).name '/'];
        matFilesPath = sprintf('%sMatt_files/', basePathSess);
        tifFilesPath = sprintf('%sTiff_files/', basePathSess);
        fprintf('  Processing animal %d "%s" session %d "%s" ...\n', iAnim, ...
            animIDs(iAnim).name, iSess, sessIDs(iSess).name);

        if exist(matFilesPath, 'dir') ~= 7;
            fprintf('    Skipping animal %d "%s" session %d "%s": Matt_files folder missing.\n', iAnim, ...
                animIDs(iAnim).name, iSess, sessIDs(iSess).name);
            continue;
        end;
        pixelsToRemoveFilePath = sprintf('%spixels_to_remove.mat', matFilesPath);
        if exist(pixelsToRemoveFilePath, 'file') ~= 2;
            fprintf('    Skipping animal %d "%s" session %d "%s": "pixels_to_remove.mat" file missing.\n', ...
                iAnim, animIDs(iAnim).name, iSess, sessIDs(iSess).name);
            continue;
        end;
        
        pixelsToRemoveMat = load(pixelsToRemoveFilePath);
        pixels_to_remove = pixelsToRemoveMat.pixels_to_remove;
        trialDCIMGFiles = dir(sprintf('%s%s*', basePathSess, dateIDShort));
        nTrials = numel(trialDCIMGFiles);

        if exist(sprintf('%sstim_ave.mat', matFilesPath), 'file');
            fprintf('    Skipping animal %d "%s" session %d "%s": average mat-file exists.\n', iAnim, ...
                animIDs(iAnim).name, iSess, sessIDs(iSess).name);
            continue;
        end;
        
        img = imread(sprintf('%sTrial1frame2', tifFilesPath));
        imgDimY = size(img, 1);
        imgDimX = size(img, 2);
        framesTiffList = dir(sprintf('%sTrial1frame*', tifFilesPath));
        nFrames = numel(framesTiffList);
        iTrial = 0;
        
        trials = nan(ceil(imgDimY/ds), ceil(imgDimX/ds), nFrames, nTrials);
        fprintf('  Processing animal %d "%s" session %d "%s": %d trial(s) ...\n', iAnim, ...
            animIDs(iAnim).name, iSess, sessIDs(iSess).name, nTrials);
        
        for iTrial = 1 : nTrials ;
            framesTiffList = dir(sprintf('Trial%dframe*', iTrial));
            fprintf('  Processing animal %d "%s" session %d "%s" trial %d: %d frame(s) ...\n', iAnim, ...
                animIDs(iAnim).name, iSess, sessIDs(iSess).name, iTrial, nFrames);
            
            for iFrame = 1 : nFrames;
                
                try
                    img = imread(sprintf('%sTrial%dframe%d', tifFilesPath, iTrial, iFrame));
                catch err;
                    fprintf('/!\\ Error for animal %d "%s" session %d "%s" trial %d frame %d (%s): %s. Skipping...\n', ...
                        iAnim, animIDs(iAnim).name, iSess, sessIDs(iSess).name, iTrial, iFrame, ...
                        err.identifier, err.message);
                    continue;
                end;
                
                imgReshape = reshape(img, imgDimY * imgDimX, 1);
                imgReshape(pixels_to_remove, :) = nan;
                img = reshape(imgReshape, imgDimY, imgDimX);
                img = im2double(img);
                o=0;
                for ii = 1 : ds : imgDimY;
                    o=o+1;
                    oo=0;
                    for jj = 1 : ds : imgDimX;
                        oo=oo+1;
                        if (imgDimY-ii)<(ds-1)
                            if (imgDimY-jj)<(ds-1)
                                trials(o,oo,iFrame,iTrial)=nanmean(nanmean(img(ii:end,jj:end),1),2);
                            else
                                trials(o,oo,iFrame,iTrial)=nanmean(nanmean(img(ii:end,jj:jj+(ds-1)),1),2);
                            end
                        else
                           if (imgDimY-jj)<(ds-1)
                                trials(o,oo,iFrame,iTrial)=nanmean(nanmean(img(ii:ii+(ds-1),jj:end),1),2);
                           else
                                trials(o,oo,iFrame,iTrial)=nanmean(nanmean(img(ii:ii+(ds-1),jj:jj+(ds-1)),1),2);
                           end 
                        end
                    end
                end
            end   
        end
        
        fr_dev = nanmean(trials(:,:,fr0,:), 3);
        trials = trials./repmat(fr_dev,[1 1 nFrames 1]);
        
        for iTrial = 1:size(trials,4)
            fprintf('    Saving animal %d "%s" session %d "%s" trial %d ...\n', iAnim, ...
                animIDs(iAnim).name, iSess, sessIDs(iSess).name, iTrial);
            tr = trials(:,:,:,iTrial);
            save(sprintf('%sstim_trial%d.mat', matFilesPath, iTrial), 'tr');
        end
        
        tr_ave = nanmean(trials, 4);
        save(sprintf('%sstim_ave.mat', matFilesPath), 'tr_ave');
        save(sprintf('%snorm_frame.mat', matFilesPath), 'fr_dev', 'fr0');
        clear('trials', 'tr', 'tr_ave', 'fr_dev', 'img', 'imgReshape', 'trialDCIMGFiles', 'framesTiffList');

    end;
end;


