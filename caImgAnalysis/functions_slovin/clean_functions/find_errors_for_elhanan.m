clear all
cd /fat2/Ariel_Gilad/Matlab_analysis/2007_03_12/conds
load data6
cd /fat2/Ariel_Gilad/Matlab_analysis/2007_03_12/mat
a=dir('1203_6*');
for i=1:size(errorM,2)
    if errorM(i)<11
        eval(['delete 1203_600',int2str(errorM(i)-1),'.mat'])
    else
        eval(['delete 1203_60',int2str(errorM(i)-1),'.mat'])
    end
end
