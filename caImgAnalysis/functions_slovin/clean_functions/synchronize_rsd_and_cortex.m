

%% obtain the rsd files and their conditions

path='/media/D410DCC610DCB12A/Ariel_Gilad/Matlab_analysis/experiments/mask/Smeagol/17Nov2010/b';
date='1711';

[new_files new_file_indexes] = sort_rsd_files(path,date); 

% new_file_indexes is trial by 3. first col is block num. 2nd col is trial num and 3rd col is condition
% new_files is the rsd list

%% obtain the cortex files and their conditions

% go to behavior_anal_psycho_v2.m and run the relevant cortex file

count=0;
for i=1:size(list4data,1)
    if cell2mat(list4data(i,1))==1
        %if cell2mat(list4data(i,3))==6
            count=count+1;
            cort(count,1)=cell2mat(list4data(i,2));
            if count==64
                g=i;
            end
        %end    
    end        
end


for i=1:size(cort,1)
    if ~(cort(i)==new_file_indexes(i,3))
        disp(i)
    end
end




