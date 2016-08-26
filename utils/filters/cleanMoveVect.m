function moveVect = cleanMoveVect(moveVect, nMinFramesMove, nMinGapBetweenMoves)

isChange = true;

% loop to fill gaps until there is no more
while isChange;
    
    isChange = false;
    nFrames = numel(moveVect);
        
    iFrame = 1;
    while iFrame < nFrames;
        currentState = moveVect(iFrame);
%         fprintf('Processing frame %d ("%d") ...\n', iFrame, moveVect(iFrame));
        nConsec = 1;
        iFrameNext = iFrame + 1;
        while iFrameNext <= nFrames && ~isnan(iFrameNext);
            if moveVect(iFrameNext) == currentState;
                nConsec = nConsec + 1;
            else
                iFrameNext = NaN;
            end;
            iFrameNext = iFrameNext+ 1;
        end;
%         fprintf('Processed frame %d ("%d") -> %d ("%d"), nConsec: %d of "%d" %s\n', iFrame, moveVect(iFrame), iFrame + nConsec - 1, ...
%             moveVect(iFrame + nConsec - 1), nConsec, moveVect(iFrame), iff(iFrame + nConsec <= nFrames, ...
%             sprintf('(%d is "%d")', iFrame + nConsec, iff(iFrame + nConsec <= nFrames, moveVect, NaN, iFrame + nConsec, 1)), ''));
        
        if currentState == 1 && ~isnan(nConsec) && nConsec < nMinFramesMove && (iFrame + nConsec) < nFrames;
%             fprintf('%d -> %d = %d consec which is not enough move, setting to 0.\n', iFrame, iFrame + nConsec, nConsec);
            moveVect(iFrame : iFrame + nConsec) = 0;
            isChange = true;
            
        elseif currentState == 0 && ~isnan(nConsec) && nConsec < nMinGapBetweenMoves && (iFrame + nConsec) < nFrames;
%             fprintf('%d -> %d = %d consec which is not enough blank setting to 1.\n', iFrame, iFrame + nConsec, nConsec);
            moveVect(iFrame : iFrame + nConsec) = 1;
            isChange = true;
            
        end;
        iFrame = iFrame + nConsec;
    end;
end;
        
end