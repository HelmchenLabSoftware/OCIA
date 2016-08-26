clear all
cd D:\intrinsic\20150506
load('20150506b.mat')
ses='b';

st=10;
en=10;

go=[];
miss=[];
nogo=[];
FA=[];
early=[];

cond='Texture 1 P100';
dec='Go';
ii=0;
for i=st:size(trials,1)-en
    if isequal(trials(i,1).stimulus,cond)
        if isequal(trials(i,1).decision,dec)
            if isequal(trials(i,1).report,'Report')
                ii=ii+1;
                if ii==1
                    go=trials(i,1).id;
                else
                    go=[go trials(i,1).id];
                end
            end
        end
    end
end


cond='Texture 1 P100';
dec='No Response';
ii=0;
for i=st:size(trials,1)-en
    if isequal(trials(i,1).stimulus,cond)
        if isequal(trials(i,1).decision,dec)
            if isequal(trials(i,1).report,'Report')
                ii=ii+1;
                if ii==1
                    miss=trials(i,1).id;
                else
                    miss=[miss trials(i,1).id];
                end
            end
        end
    end
end




cond='Texture 5 P1200';
dec='No Go';
ii=0;
for i=st:size(trials,1)-en
    if isequal(trials(i,1).stimulus,cond)
        if isequal(trials(i,1).decision,dec)
            if isequal(trials(i,1).report,'Report')
                ii=ii+1;
                if ii==1
                    nogo=trials(i,1).id;
                else
                    nogo=[nogo trials(i,1).id];
                end
            end
        end
    end
end


cond='Texture 5 P1200';
dec='Inappropriate Response';
ii=0;
for i=st:size(trials,1)-en
    if isequal(trials(i,1).stimulus,cond)
        if isequal(trials(i,1).decision,dec)
            if isequal(trials(i,1).report,'Report')
                ii=ii+1;
                if ii==1
                    FA=trials(i,1).id;
                else
                    FA=[FA trials(i,1).id];
                end
            end
        end
    end
end




dec='Early';
ii=0;
for i=st:size(trials,1)-en
        if isequal(trials(i,1).decision,dec)
            if isequal(trials(i,1).report,'Early')
                ii=ii+1;
                if ii==1
                    early=trials(i,1).id;
                else
                    early=[early trials(i,1).id];
                end
            end
        end
end


perf_go=size(go,2)/(size(go,2)+size(miss,2))*100
perf_nogo=size(nogo,2)/(size(FA,2)+size(nogo,2))*100
perf_tot=(size(go,2)+size(nogo,2))/(size(go,2)+size(miss,2)+size(FA,2)+size(nogo,2))*100
num_early=size(early,2)/(size(go,2)+size(miss,2)+size(FA,2)+size(nogo,2)+size(early,2))*100

figure;bar([perf_go perf_nogo perf_tot num_early])

cd(ses)
cd Matt_files
save behavior perf_* num_early




seq=zeros(1,size(trials,1));
seq(go)=1;
seq(nogo)=2;
seq(FA)=3;
seq(miss)=4;
seq(early)=5;

ju=20;
k=0;
for i=st:floor(size(trials,1)/ju)*ju-ju
    k=k+1;
    tc_go(k)=(sum(seq(i:i+ju)==1))/(sum(seq(i:i+ju)==1)+sum(seq(i:i+ju)==4))*100;
    tc_nogo(k)=(sum(seq(i:i+ju)==2))/(sum(seq(i:i+ju)==2)+sum(seq(i:i+ju)==3))*100;
    tc_tot(k)=(sum(seq(i:i+ju)==1)+sum(seq(i:i+ju)==2))/(sum(seq(i:i+ju)==1)+sum(seq(i:i+ju)==2)+sum(seq(i:i+ju)==3)+sum(seq(i:i+ju)==4))*100;
    tc_early(k)=(sum(seq(i:i+ju)==5))/(sum(seq(i:i+ju)==5)+sum(seq(i:i+ju)==1)+sum(seq(i:i+ju)==2)+sum(seq(i:i+ju)==3)+sum(seq(i:i+ju)==4))*100;
end

figure;plot(tc_go,'Marker','+')
hold on
plot(tc_nogo,'r','Marker','s')
plot(tc_early,'--k')
ylim([-5 105])
xlim([0 51])
























