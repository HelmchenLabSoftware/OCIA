% get the indeces for only a specific part of a session


% do this part only after synchronizing the rsd and cortex files
% (synchronize_rsd_and_cortex_v2.m)
load list4data %get cortex list. put in correct cortex file
load fileIND %get rsd list through analysis1.m

%get cortex trials where the camera was working (403)
p=0;
for i=1:size(list4data,1)    
    if list4data{i,4}==1
        p=p+1;
        list_new(p,1)=list4data{i,3};
        list_cond(p,1)=list4data{i,2};
    end
end

a=size(list_new,1); %size of the rsd files
ind=zeros(1,a);

t6=find(list_new==6); %all the corrects
t5=find(list_new==5); %all the incorrects

ind(t5)=1;
ind(t6)=1;

% get indeces of correct trial for each condition
cond1=find((list_cond==1)&(list_new==6));
cond2=find((list_cond==2)&(list_new==6));
cond3=find((list_cond==3)&((list_new==6)|(list_new==3)));
cond4=find((list_cond==4)&(list_new==6));
cond5=find((list_cond==5)&(list_new==6));

% remove noisy trials
load noisytrials

for i=1:5
    eval(['c=size(cond',int2str(i),',1);'])
    er=ones(1,c);
    eval(['er(error_',int2str(i),')=0;'])
    e=find(er);
    eval(['cond',int2str(i),'=cond',int2str(i),'(e);'])
end

%% get only the trials in a specific limit

trial_start=52;  %bottom limit
trial_end=118;    %top limit

%get the real index in the rsd files
for i=1:a
    if sum(ind(1:i))==trial_start
        tr_rsd_start=i;
        disp(['trial number ',int2str(i)])
    end
end

%get the real index in the rsd files
for i=1:a
    if sum(ind(1:i))==trial_end
        tr_rsd_end=i;
        disp(['trial number ',int2str(i)])
    end
end

%get the trial indeces according to the limit for each condition
cond1_good=find(cond1>tr_rsd_start&cond1<tr_rsd_end);
cond2_good=find(cond2>tr_rsd_start&cond2<tr_rsd_end);
cond3_good=find(cond3>tr_rsd_start&cond3<tr_rsd_end);
cond4_good=find(cond4>tr_rsd_start&cond4<tr_rsd_end);
cond5_good=find(cond5>tr_rsd_start&cond5<tr_rsd_end);



%% check behavior
ind2=zeros(1,a);
ind2(t5)=1;
ind2(t6)=2;
ind2(ind2==0)=[];
win=10;
for i=1:size(ind2,2)-10
    cor=sum(ind2(i:i+win-1)==2);
    per_cor(i)=cor/win;
end

figure;plot(per_cor)

























