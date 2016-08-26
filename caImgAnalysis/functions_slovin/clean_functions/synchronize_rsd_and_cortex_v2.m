% synchronizing cortex and camera (rsd) files

%% phase 1: get cortex and rsd files


list4data = get_cortex('gol_2012_06_06_a.1'); %get cortex list. put in correct cortex file
load fileIND %get rsd list through analysis1.m

%get cortex trials where the camera was working (403)
p=0;
for i=1:size(list4data,1)    
    if list4data{i,4}==1
        %if list4data{i,1}==1 %header was correct
            p=p+1;
            list_new(p,1)=list4data{i,2};
            list_ind(p,1)=i;
            if list4data{i,1}==0
                list_new(p,1)=7;
            end
        %end
    end
end

% get a list of conditions for the rsd files
for i=1:size(fileIND,1)
    cond_cam(i,1)=str2double(fileIND{i}(5));
end
%cond_cam(cond_cam==7)=[]; %eliminate errors

% compare size of cortex files with camera working to size of rsd files
if p==size(cond_cam,1)
    disp('an equal total number of trials')
else
    disp('WRONG - an unequal total number of trials')
end
ttt=list_ind;
%% compare condition order of cortex files (with camera working) to size of rsd files
t=0;
k=0;
for i=1:size(cond_cam,1)
    if list_new(i)==cond_cam(i)
        t=t+1;
    else
        disp(['trial #',int2str(i),' is not synchronized'])
    end
end
if t==p
    disp('files are synchronized')
else
    disp('files are not synchronized')
end

%% manual removal of cortex files
us=1;  %put in the first file that is not synchronized
ind=list_ind(us) % this is the file's index in the lit for data

list_new(us)=[]; %remove this file from the list
list_ind(us)=[];
ttt(us+1:end)=ttt(us+1:end)-1;
ttt(us)=[];
p=p-1; %repeat the comparison above


% after files are synchronized, remove the unsynchronized files from
% list4data
tr_down=[1];  %choose the trial you want to remove for list4data

list4data(tr_down,:)=[];

save list4data list4data tr_down
%erase manually the trial (us) from list4data
%% automatic removal of cortex files, save indeces for checking
% i=1;
% k=0;
% while ~(i==size(cond_cam,1))
%     if list_new(i)==cond_cam(i)
%         i=i+1;
%     else
%         disp(['trial #',int2str(i),' is not synchronized'])
%         us=i;
%         k=k+1;
%         ind=list_ind(us);
%         list_new(us)=[];
%         list_ind(us)=[];
%         tr_down(k)=ind;
%         p=p-1;
%         i=1;
%     end
% end
% if i==p
%     disp('files are synchronized')
% end

%% phase 2: get eye movements (only if phase 1 is complete)
c1=0;
c2=0;
c3=0;
c4=0;
c5=0;
for i=1:size(list4data,1)    
    if list4data{i,1}==1
        if list4data{i,3}==6
            if list4data{i,4}==1
                if list4data{i,2}==1
                    c1=c1+1;
                    eyex_cond1(:,c1)=list4data{i,5};
                    eyey_cond1(:,c1)=list4data{i,6};
                end
                if list4data{i,2}==2
                    c2=c2+1;
                    eyex_cond2(:,c2)=list4data{i,5};
                    eyey_cond2(:,c2)=list4data{i,6};
                end
                
                if list4data{i,2}==4
                    c4=c4+1;
                    eyex_cond4(:,c4)=list4data{i,5};
                    eyey_cond4(:,c4)=list4data{i,6};
                end
                if list4data{i,2}==5
                    c5=c5+1;
                    eyex_cond5(:,c5)=list4data{i,5};
                    eyey_cond5(:,c5)=list4data{i,6};
                end
            end
        end
    end
end

%cond3
for i=1:size(list4data,1)    
    if list4data{i,1}==1
            if list4data{i,4}==1  
                if list4data{i,2}==3
                    c3=c3+1;
                    eyex_cond3(:,c3)=list4data{i,5};
                    eyey_cond3(:,c3)=list4data{i,6};
                end
            end
    end
end

%% checking the vsdi signal against the eye movements
x=(10:10:2560)-280;
x2=(1:4:571*4)-280;
load myrois
for i=5
    figure;plot(x(2:80),squeeze(mean(cond4n_dt_bl(roi_maskin,2:80,i),1)))
    xlim([-200 800])
    figure;plot(x2,eyex_cond4(:,i),'r')
    xlim([0 1000])
    figure;plot(x2,eyey_cond4(:,i),'r')
    xlim([-200 800])
end    
   
for i=1:19
    figure;plot(x(2:130),squeeze(mean(cond4n(roi_circle,2:130,i),1)))
    figure;plot(x2,eyex_cond4(:,i),'r')
end    
    

%% phase 3: delete noisy trials from each cond

load noisytrials

for i=1:5
    eval(['c=size(eyex_cond',int2str(i),',2);'])
    er=ones(1,c);
    eval(['er(error_',int2str(i),')=0;'])
    e=find(er);
    eval(['eyex_cond',int2str(i),'=eyex_cond',int2str(i),'(:,e);'])
    eval(['eyey_cond',int2str(i),'=eyey_cond',int2str(i),'(:,e);'])
end

%% save the eye_moves

save eye_positions eyex_cond* eyey_cond* 













