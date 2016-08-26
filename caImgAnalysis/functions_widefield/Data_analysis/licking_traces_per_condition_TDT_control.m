cd D:\intrinsic\20150506\mouse_tgg6fl23_5
load('20150506d.mat')
cd d
load('mouse_tgg6fl23_5_ses_d_20150506.mat')
top_thresh=2.64;
bot_thresh=2.57;

st=1;
en=0;

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
dec='Go';
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


licks_go=nan*ones(1500,size(go,2));
k=0;
for i=go
    k=k+1;
    licks_go(1:size(licks(i).lick_vector(1,:),2),k)=licks(i).lick_vector(1,:); 
end

licks_nogo=nan*ones(1500,size(nogo,2));
k=0;
for i=nogo
    k=k+1;
    licks_nogo(1:size(licks(i).lick_vector(1,:),2),k)=licks(i).lick_vector(1,:); 
end


x=(1:1500)*0.01-3;
figure;plot(x,licks_go,'r')
hold on
plot(x,licks_nogo,'b')



licks_early=nan*ones(1500,size(early,2));
k=0;
for i=early
    k=k+1;
    licks_early(1:size(licks(i).lick_vector(1,:),2),k)=licks(i).lick_vector(1,:); 
end

figure;plot(x,licks_early,'k')


licks_FA=nan*ones(1500,size(FA,2));
k=0;
for i=FA
    k=k+1;
    licks_FA(1:size(licks(i).lick_vector(1,:),2),k)=licks(i).lick_vector(1,:); 
end

%figure;plot(x,licks_FA,'k')

licks_miss=nan*ones(1500,size(miss,2));
k=0;
for i=miss
    k=k+1;
    licks_miss(1:size(licks(i).lick_vector(1,:),2),k)=licks(i).lick_vector(1,:); 
end

%figure;plot(x,licks_miss,'k')


go_thresh=ones(1500,size(go,2));
go_thresh(licks_go>top_thresh)=0.75;
go_thresh(licks_go<bot_thresh)=0.75;
figure;imagesc(x,1:size(go,2),go_thresh',[0 1]);colormap(mapgeog)

nogo_thresh=ones(1500,size(nogo,2));
nogo_thresh(licks_nogo>top_thresh)=0.25;
nogo_thresh(licks_nogo<bot_thresh)=0.25;
figure;imagesc(x,1:size(nogo,2),nogo_thresh',[0 1]);colormap(mapgeog)

early_thresh=ones(1500,size(early,2));
early_thresh(licks_early>top_thresh)=0.1;
early_thresh(licks_early<bot_thresh)=0.1;
figure;imagesc(x,1:size(early,2),early_thresh',[0 1]);colormap(mapgeog)


FA_thresh=ones(1500,size(FA,2));
FA_thresh(licks_FA>top_thresh)=0.4;
FA_thresh(licks_FA<bot_thresh)=0.4;
figure;imagesc(x,1:size(FA,2),FA_thresh',[0 1]);colormap(mapgeog)


miss_thresh=ones(1500,size(miss,2));
miss_thresh(licks_miss>top_thresh)=0.6;
miss_thresh(licks_miss<bot_thresh)=0.6;
figure;imagesc(x,1:size(miss,2),miss_thresh',[0 1]);colormap(mapgeog)


total=cat(2,go_thresh,miss_thresh,nogo_thresh,FA_thresh,early_thresh);
figure;imagesc(x,1:size(total,2),total',[0 1]);colormap(mapgeog)
xlim([-1 5])


