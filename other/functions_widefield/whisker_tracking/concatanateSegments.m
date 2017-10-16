%dirname='F:\data tetrodes\th_8\th_8_2014_10_28_a';

function f= concatanateSegments(dirname)
list = dir(dirname);
i=3;
oldExpName='Experiment';
whiskingAll = [];
mkdir(fullfile(dirname,'whiskByTrial'));
count = 0;
for i=3:length(list)
    fname = list(i).name;
   
    ind=strfind(fname,'_Whisker_Tracking');
    if(~isempty(ind))

        expname = fname(1:ind);
        
        load(fullfile(dirname,fname));
        
        if (strcmp(oldExpName,expname))           
            whiskingAll = [whiskingAll; MovieInfo.AvgWhiskerAngle'];
        else
            if ~isempty(whiskingAll)
                count = count+1;
                save(fullfile(dirname,'whiskByTrial',[oldExpName 't' num2str(count) '.mat']),'whiskingAll');
                whiskingAll = [];
            end
          
            whiskingAll = [whiskingAll; MovieInfo.AvgWhiskerAngle'];
        end
     oldExpName = expname; 
    
    
    end
end
 
count=count+1;
save(fullfile(dirname,'whiskByTrial',[oldExpName 't' num2str(count) '.mat']),'whiskingAll');
      

%%
subdirname=fullfile(dirname,'whiskByTrial');
sublist = dir(subdirname);

load(fullfile(subdirname,sublist(3).name));
[nr nc] = size(whiskingAll);

whiskAngle = nan(nr+5,numel(sublist)-2);

for i=3:numel(sublist)
    load(fullfile(subdirname,sublist(i).name));
    whiskAngle(1:length(whiskingAll),i-2)=whiskingAll;

end

save(fullfile(dirname, 'whiskAngle.mat'),'whiskAngle');
xlswrite('whiskAngle',whiskAngle);

end
