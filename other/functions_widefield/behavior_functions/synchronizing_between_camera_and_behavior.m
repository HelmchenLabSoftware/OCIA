clear all
cd D:\intrinsic\20160215
load('20160215c.mat')
cd D:\intrinsic\20160215\c
list = dir('20161502*');

if size(list,1)==size(trials,1) 
    display('Equal number of trials')
else
    display('UNEQUAL - XXXXX')
end

for i=1:size(list,1)
    t=list(i,1).name;
    t=t(10:15);
    time_camera(i,1)=str2num(t(1:2))*60*60+str2num(t(3:4))*60+str2num(t(5:6));
end

for i=1:size(trials,1)
    t=trials(i,1).time_stamp;
    time_behav(i,1)=str2num(t(1:2))*60*60+str2num(t(4:5))*60+str2num(t(7:8));
end

diff=time_camera-time_behav;
temp=diff-3600;
max(temp(2:end))
min(temp(2:end))






    
    
    