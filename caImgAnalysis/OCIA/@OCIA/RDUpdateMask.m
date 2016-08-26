function RDUpdateMask(this, ~, ~)
% RDUpdateMask - [no description]
%
%       RDUpdateMask(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

    updateTic = tic; % for performance timing purposes
    o('#RDUpdateMask()', 4, this.verb);
    
    maskInitTic = tic; % for performance timing purposes
    % use 8-bit ints to reduce size
    this.rd.ROIMask = int8(zeros(size(this.GUI.rd.img, 1), size(this.GUI.rd.img, 2)));
    o('#RDUpdateMask(): maskInit done (%5.3f sec).', toc(maskInitTic), 4, this.verb);

    % create the mask from the mask of each ROI
    maskCreateTic = tic; % for performance timing purposes
    for iROI = 1 : this.rd.nROIs;
       singleROIMask = this.rd.ROIs{iROI, 1}.createMask(this.GUI.handles.rd.img) * iROI;
       this.rd.ROIMask(singleROIMask ~= 0) = iROI;
    end;
    o('#RDUpdateMask(): ROI mask created (%5.3f sec).', toc(maskCreateTic), 4, this.verb);

    o('#RDUpdateMask(): done (%5.3f sec)', toc(updateTic), 4, this.verb);
    
end