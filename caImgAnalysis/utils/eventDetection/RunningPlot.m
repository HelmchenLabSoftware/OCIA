function RunningPlot(JointX_18Hz, JointY_18Hz)

numFrames = length(JointX_18Hz(1,:));

minx = min(min(JointX_18Hz));
maxx = max(max(JointX_18Hz));
miny = min(min(JointY_18Hz));
maxy = max(max(JointY_18Hz));

siz = size(JointX_18Hz);
xoffset_frame = 0.1;   % xoffset per frame that is added to joint vector 
frame_start = 1;
frame_end = siz(2);
fullmaxx = maxx +(frame_end-frame_start+1)*xoffset_frame;

freezescapula = 1;      % flag : 1 - the Scapula coordinates wil be subtracted, thus it will be fixed 

ScapulaX = JointX_18Hz(1,:);
ScapulaY = JointY_18Hz(1,:);

JointX = JointX_18Hz;
JointY = JointY_18Hz;

if (freezescapula == 1)
    JointX(1,:) = JointX_18Hz(1,:) - ScapulaX;
    JointX(2,:) = JointX_18Hz(2,:) - ScapulaX;
    JointX(3,:) = JointX_18Hz(3,:) - ScapulaX;
    JointX(4,:) = JointX_18Hz(4,:) - ScapulaX;
    JointX(5,:) = JointX_18Hz(5,:) - ScapulaX;
    JointX(6,:) = JointX_18Hz(6,:) - ScapulaX;

    JointY(1,:) = JointY_18Hz(1,:) - ScapulaY;
    JointY(2,:) = JointY_18Hz(2,:) - ScapulaY;
    JointY(3,:) = JointY_18Hz(3,:) - ScapulaY;
    JointY(4,:) = JointY_18Hz(4,:) - ScapulaY;
    JointY(5,:) = JointY_18Hz(5,:) - ScapulaY;
    JointY(6,:) = JointY_18Hz(6,:) - ScapulaY;
    
    minx = min(min(JointX));           % redo calculation of plot borders 
    maxx = max(max(JointX));
    miny = min(min(JointY));
    maxy = max(max(JointY));
    fullmaxx = maxx +(frame_end-frame_start+1).*xoffset_frame;
end

for i = 1:numFrames
    JointX(1,i) = JointX(1,i) + (i-1)*xoffset_frame;
    JointX(2,i) = JointX(2,i) + (i-1)*xoffset_frame;
    JointX(3,i) = JointX(3,i) + (i-1)*xoffset_frame;
    JointX(4,i) = JointX(4,i) + (i-1)*xoffset_frame;
    JointX(5,i) = JointX(5,i) + (i-1)*xoffset_frame;
    JointX(6,i) = JointX(6,i) + (i-1)*xoffset_frame;
end

%hf = figure;
rang =(frame_end-frame_start+1);
for j = frame_start:frame_end 
    %plot(JointX(:,j),JointY(:,j),'-','LineWidth',1, 'Color', [j/rang 1-j/rang 1-j/rang]);
    plot(JointX(:,j),JointY(:,j),'-','LineWidth',1, 'Color', [0 0 0]);
    xlim([minx fullmaxx]);
    ylim([miny maxy]);
    hold on;
end
