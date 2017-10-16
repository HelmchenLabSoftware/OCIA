% finding maximum and comparing between different frequency bands


%% lfp parameters
x2=(1:459)*4-(420); %for faces and contour integration
%x2=(1:459)*4-(420+25); %for collinear
f2=(1:64)*125/64;


hg=squeeze(mean(spect_cond4(31:end,:,:),1));
lg=squeeze(mean(spect_cond4(13:25,:,:),1));

% calculate maximum peaks
for i=1:size(hg,2)
    hg_max(i)=find(hg(:,i)==max(hg(1:142,i)));
    lg_max(i)=find(lg(:,i)==max(lg(1:142,i)));
end


lg_max_time=x2(lg_max);
hg_max_time=x2(hg_max);

ranksum(lg_max_time,hg_max_time)

% normalize to maximum
hgn=hg./repmat(max(hg(1:142,:),[],1),459,1);
lgn=lg./repmat(max(lg(1:142,:),[],1),459,1);

% find half height time
for i=1:size(hg,2)
    hg_hh(i) = find(hgn(1:hg_max(i),i)<0.5, 1, 'last');
    lg_hh(i) = find(lgn(1:lg_max(i),i)<0.5, 1, 'last');
end

lg_hh_time=x2(lg_hh);
hg_hh_time=x2(hg_hh);

ranksum(lg_hh_time,hg_hh_time)



% find width at half height time
for i=1:size(hg,2)
    hg_hh2(i) = find(hgn(hg_max(i):end,i)<0.5, 1, 'first')+hg_max(i)-2;
    lg_hh2(i) = find(lgn(lg_max(i):end,i)<0.5, 1, 'first')+lg_max(i)-2;
end

hg_whh_time=x2(hg_hh2)-x2(hg_hh);
lg_whh_time=x2(lg_hh2)-x2(lg_hh);

ranksum(lg_whh_time,hg_whh_time)


%% vsdi parameters

%% vsdi plot
%x1=(20:10:1130)-200; %for collinear
f1=(1:32)*50/32;
%x1=(20:10:2010)-190; %for contour integration
x1=(20:10:1130)-190; %for faces 

%alpha power

al=squeeze(mean(power_cond4(4:9,:,:),1));

% calculate maximum peaks
for i=1:size(al,2)
    al_max(i)=find(al(:,i)==max(al(1:40,i)));    
end

al_max_time=x1(al_max);

% normalize to maximum
aln=al./repmat(max(al(1:40,:),[],1),112,1);

% find half height time
for i=1:size(al,2)
    al_hh(i) = find(aln(1:al_max(i),i)<0.5, 1, 'last');
end

al_hh_time=x1(al_hh);

% find width at half height time
for i=1:size(al,2)
    al_hh2(i) = find(aln(al_max(i):end,i)<0.5, 1, 'first')+al_max(i)-2;
end

al_whh_time=x1(al_hh2)-x1(al_hh);



%% calculating statistics
% calculate the middle time
lg_max_time=lg_max_time+2;
lg_hh_time=lg_hh_time+2;
hg_max_time=hg_max_time+2;
hg_hh_time=hg_hh_time+2;
al_max_time=al_max_time+5;
al_hh_time=al_hh_time+5;

mean(lg_max_time)
mean(lg_hh_time)
mean(lg_whh_time)

mean(hg_max_time)
mean(hg_hh_time)
mean(hg_whh_time)

mean(al_max_time)
mean(al_hh_time)
mean(al_whh_time)


ranksum(lg_max_time,hg_max_time)
ranksum(lg_hh_time,hg_hh_time)
ranksum(lg_whh_time,hg_whh_time)

ranksum(lg_max_time,al_max_time)
ranksum(lg_hh_time,al_hh_time)
ranksum(lg_whh_time,al_whh_time)

ranksum(time_max_time,al_max_time)
ranksum(time_hh_time,al_hh_time)
ranksum(time_whh_time,al_whh_time)

ranksum(time_max_time,hg_max_time)
ranksum(time_hh_time,hg_hh_time)
ranksum(time_whh_time,hg_whh_time)



median(lg_max_time)
median(lg_hh_time)
median(lg_whh_time)

median(hg_max_time)
median(hg_hh_time)
median(hg_whh_time)

median(al_max_time)
median(al_hh_time)
median(al_whh_time)


std(lg_max_time)
std(lg_hh_time)
std(lg_whh_time)

std(hg_max_time)
std(hg_hh_time)
std(hg_whh_time)

std(al_max_time)
std(al_hh_time)
std(al_whh_time)







for i=1:14
   figure;plot(x2,hgn(:,i))
end







