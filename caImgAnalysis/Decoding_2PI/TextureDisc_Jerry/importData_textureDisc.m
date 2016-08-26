function Sout = importData_textureDisc(matfile)

load(matfile)

roiLabel = Ca.roiLabel;

% animal / session ID
id = roiLabel{1,1};
idx = strfind(id,'-');
Sout.info.animal = id(1:idx(1)-1);
Sout.info.session = str2num(id(idx(1)+1:idx(2)-1));
Sout.info.sample_rate = Ca.sample_rate;
Sout.info.roiLabel = roiLabel;

trialID = Ca.Trial_Name; % the HS filename for each imaging trial

% build the texture trial vector by searching through {summary} and finding
% trialID --> code textures 1 - 4 (textures 1, 3, 5, 7)
Sout.info.trialVectors.texture = findTrialTexture(trialID,summary);

% DRR trial x time matrix for each neuron
timepoints = size(Ca.dRR{1,1},2);
for roi = 1:numel(roiLabel)
    id = roiLabel{roi,1};
    idx = strfind(id,'-');
    id = id(idx(2)+1:end); % for field name
    drr = zeros(numel(trialID),timepoints);
    for trial = 1:numel(trialID)
        if isempty(Ca.dRR{roi,trial})
            drr(trial,:) = NaN;
        else
            drr(trial,:) = Ca.dRR{roi,trial}(1,:);
        end
    end
    Sout.(id).dRR = drr;
end


%% Function - findTrialTexture
function v = findTrialTexture(trialID,summary)
trialCol = 6; % the column of summary in which trial IDs are stored
textureCol = 4; % the column of summary in which texture is stored
v = zeros(numel(trialID),1);
for n = 1:numel(trialID)
   id = trialID{n};
   match = 0;
   for m = 2:size(summary,1)
       if ~isnan(summary{m,trialCol}) & strcmp(summary{m,trialCol},id)
           match = 1;
           texture = summary{m,textureCol};
           switch texture(1:9)
               case 'Texture 1'
                   v(n) = 1;
               case 'Texture 3'
                   v(n) = 2;
               case 'Texture 5'
                   v(n) = 3;
               case 'Texture 7'
                   v(n) = 4;
               otherwise
                   error('Could not match texture %s (trial %s)',texture,id)
           end
       end
   end
   if ~match
      error('Could not match trial %s',id) 
   end
end


