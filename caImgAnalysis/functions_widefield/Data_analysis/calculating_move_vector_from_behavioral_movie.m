% cd W:\Neurophysiology-Storage1\Gilad\Data_per_mouse\mouse_tgg6fl23_8\20151021\b
load('behaviorVectors.mat')

for i=1:size(behavROINames,2)
    if strcmp(behavROINames{1,i},'Behav_back')
           ba=i;
    end
    if strcmp(behavROINames{1,i},'Behav_fl')
           fl=i;
    end
    if strcmp(behavROINames{1,i},'Behav_hl')
           hl=i;
    end
    if strcmp(behavROINames{1,i},'Behav_lick')
           mouth=i;
    end
end

if exist('ba')
    roi_back_100=squeeze(ROIBehavData_cond_100(ba,:,:))';
    roi_back_1200=squeeze(ROIBehavData_cond_1200(ba,:,:))';
    figure;errorbar(tBehav,smooth(nanmean(roi_back_1200,2),5,'Gauss'),nanstd(roi_back_1200,0,2)/sqrt(size(roi_back_1200,2)),'--b')
    hold on
    errorbar(tBehav,smooth(nanmean(roi_back_100,2),5,'Gauss'),nanstd(roi_back_100,0,2)/sqrt(size(roi_back_100,2)),'k')
    xlim([-2.5 7])
    title('back vector')
end
if exist('mouth')
    roi_mouth_100=squeeze(ROIBehavData_cond_100(mouth,:,:))';
    roi_mouth_1200=squeeze(ROIBehavData_cond_1200(mouth,:,:))';   
    figure;errorbar(tBehav,smooth(nanmean(roi_mouth_1200,2),5,'Gauss'),nanstd(roi_mouth_1200,0,2)/sqrt(size(roi_mouth_1200,2)),'--c')
    hold on
    errorbar(tBehav,smooth(nanmean(roi_mouth_100,2),5,'Gauss'),nanstd(roi_mouth_100,0,2)/sqrt(size(roi_mouth_100,2)),'k')
    xlim([-2.5 7])
    title('mouth vector')
end
if exist('hl')
    roi_hl_100=squeeze(ROIBehavData_cond_100(hl,:,:))';
    roi_hl_1200=squeeze(ROIBehavData_cond_1200(hl,:,:))';
    figure;errorbar(tBehav,smooth(nanmean(roi_hl_1200,2),5,'Gauss'),nanstd(roi_hl_1200,0,2)/sqrt(size(roi_hl_1200,2)),'--g')
    hold on
    errorbar(tBehav,smooth(nanmean(roi_hl_100,2),5,'Gauss'),nanstd(roi_hl_100,0,2)/sqrt(size(roi_hl_100,2)),'k')
    xlim([-2.5 7])
    title('hl vector')
end
if exist('fl')
    roi_fl_100=squeeze(ROIBehavData_cond_100(fl,:,:))';
    roi_fl_1200=squeeze(ROIBehavData_cond_1200(fl,:,:))';   
    figure;errorbar(tBehav,smooth(nanmean(roi_fl_1200,2),5,'Gauss'),nanstd(roi_fl_1200,0,2)/sqrt(size(roi_fl_1200,2)),'--m')
    hold on
    errorbar(tBehav,smooth(nanmean(roi_fl_100,2),5,'Gauss'),nanstd(roi_fl_100,0,2)/sqrt(size(roi_fl_100,2)),'k')
    xlim([-2.5 7])
    title('fl vector')
end

%roi_bod_100=(roi_back_100+roi_mouth_100+roi_hl_100+roi_fl_100)/4;
%roi_bod_1200=(roi_back_1200+roi_mouth_1200+roi_hl_1200+roi_fl_1200)/4;

%roi_bod_100=(roi_back_100+roi_hl_100+roi_fl_100)/3;
%roi_bod_1200=(roi_back_1200+roi_hl_1200+roi_fl_1200)/3;
% 
%roi_bod_100=(roi_back_100+roi_mouth_100+roi_fl_100)/3;
%roi_bod_1200=(roi_back_1200+roi_mouth_1200+roi_fl_1200)/3;
% 
roi_bod_100=(roi_back_100)/1;
roi_bod_1200=(roi_back_1200)/1;


figure;errorbar(tBehav,smooth(nanmean(roi_bod_1200,2),5,'Gauss'),nanstd(roi_bod_1200,0,2)/sqrt(size(roi_bod_1200,2)),'--r')
hold on
errorbar(tBehav,smooth(nanmean(roi_bod_100,2),5,'Gauss'),nanstd(roi_bod_100,0,2)/sqrt(size(roi_bod_100,2)),'k')
xlim([-2.5 7])

%%
th=0.02;
for i=1:1:size(roi_bod_1200,2)
    zz(:,i)=smooth(roi_bod_1200(:,i),9,'Gauss');
end
move_vect_1200=zz>th;

for i=1:1:size(roi_bod_100,2)
    zzz(:,i)=smooth(roi_bod_100(:,i),9,'Gauss');
end
move_vect_100=zzz>th;

figure;errorbar(tBehav,smooth(nanmean(move_vect_1200,2),5,'Gauss'),nanstd(move_vect_1200,0,2)/sqrt(size(move_vect_1200,2)),'--r')
hold on
errorbar(tBehav,smooth(nanmean(move_vect_100,2),5,'Gauss'),nanstd(move_vect_100,0,2)/sqrt(size(move_vect_100,2)),'k')
xlim([-2.5 7])

save move_vectors_from_movie move_vect_* roi_*

k=0;
figure('Position',[400 100 800 600]);
hold on
for i=1:3:26
    k=k+1;    
    subplot(3,3,k)
    hold on
    plot(tBehav,smooth(roi_bod_1200(:,i),5,'Gauss'),'k')
    xlim([-2.5 7])
    title([int2str(i)])
    plot(tBehav,th*ones(1,size(tBehav,2)),'k')
end

%%

base=12:21;  %time frames of baseline from behavioral movie
stim=60:151; %time frames of stimulus and prestimulus from behavioral movie
del=160:180; % time frames of quiet delay
m_th=25;     % time frames of movement suring sensation

tr_1200_noisy=[];
tr_1200_prior_move=[];
tr_1200_no_prior_move=[];
tr_1200_quiet_sens=[];
for i=1:size(move_vect_1200,2)
    if sum(move_vect_1200(base,i))>0
        tr_1200_noisy=cat(2,tr_1200_noisy,i);
    elseif sum(move_vect_1200(stim,i))>m_th
        if sum(move_vect_1200(del,i))==0
            tr_1200_prior_move=cat(2,tr_1200_prior_move,i);
        end
    else
        tr_1200_quiet_sens=cat(2,tr_1200_quiet_sens,i);
        if sum(move_vect_1200(del,i))==0
            tr_1200_no_prior_move=cat(2,tr_1200_no_prior_move,i);
        end
    end
end       

tr_100_noisy=[];
tr_100_prior_move=[];
tr_100_no_prior_move=[];
tr_100_quiet_sens=[];
for i=1:size(move_vect_100,2)
    if sum(move_vect_100(base,i))>0
        tr_100_noisy=cat(2,tr_100_noisy,i);
    elseif sum(move_vect_100(stim,i))>m_th
        if sum(move_vect_100(del,i))==0
            tr_100_prior_move=cat(2,tr_100_prior_move,i);
        end
    else
        tr_100_quiet_sens=cat(2,tr_100_quiet_sens,i);
        if sum(move_vect_100(del,i))==0
            tr_100_no_prior_move=cat(2,tr_100_no_prior_move,i);
        end
    end
end       
tr_100_delay_move=find(sum(move_vect_100(del,:))>0);
tr_1200_delay_move=find(sum(move_vect_1200(del,:))>0);

save trials_with_and_wo_initial_moves_OCIA_from_movie tr_*

%%
first_move_1200_delay=nan*ones(1,size(move_vect_1200,2));
first_move_1200_delay_movie=nan*ones(1,size(move_vect_1200,2));
k=0;
for i=1:size(move_vect_1200,2)
    k=k+1;
    q=find(move_vect_1200(del(1):end,i),1)+del(1)-1;
    if ~isempty(q)
        qq=find(abs(tBehav(q-7)-tCa)==min(abs(tBehav(q-7)-tCa)));
        first_move_1200_delay(k)=qq;
        first_move_1200_delay_movie(k)=q-7;
    else
        first_move_1200_delay(k)=size(tCa,2);
        first_move_1200_delay_movie(k)=size(tCa,2);
    end
end

first_move_100_delay=nan*ones(1,size(move_vect_100,2));
first_move_100_delay_movie=nan*ones(1,size(move_vect_100,2));
k=0;
for i=1:size(move_vect_100,2)
    k=k+1;
    q=find(move_vect_100(del(1):end,i),1)+del(1)-1;
    if ~isempty(q)
        qq=find(abs(tBehav(q-7)-tCa)==min(abs(tBehav(q-7)-tCa)));
        first_move_100_delay(k)=qq;
        first_move_100_delay_movie(k)=q-7;
    else
        first_move_100_delay(k)=size(tCa,2);
        first_move_100_delay_movie(k)=size(tCa,2);
    end
end

save first_move_in_delay first_move_*

figure;errorbar(tBehav,smooth(nanmean(roi_bod_1200(:,tr_1200_prior_move),2),5,'Gauss'),nanstd(roi_bod_1200(:,tr_1200_prior_move),0,2)/sqrt(size(roi_bod_1200(:,tr_1200_prior_move),2)),'--r')
hold on
errorbar(tBehav,smooth(nanmean(roi_bod_100(:,tr_100_prior_move),2),5,'Gauss'),nanstd(roi_bod_100(:,tr_100_prior_move),0,2)/sqrt(size(roi_bod_100(:,tr_100_prior_move),2)),'k')
xlim([-2.5 7])

figure;errorbar(tBehav,smooth(nanmean(roi_bod_1200(:,tr_1200_no_prior_move),2),5,'Gauss'),nanstd(roi_bod_1200(:,tr_1200_no_prior_move),0,2)/sqrt(size(roi_bod_1200(:,tr_1200_no_prior_move),2)),'--r')
hold on
errorbar(tBehav,smooth(nanmean(roi_bod_100(:,tr_100_no_prior_move),2),5,'Gauss'),nanstd(roi_bod_100(:,tr_100_no_prior_move),0,2)/sqrt(size(roi_bod_100(:,tr_100_no_prior_move),2)),'k')
xlim([-2.5 7])

figure;errorbar(tBehav,smooth(nanmean(move_vect_1200(:,tr_1200_prior_move),2),5,'Gauss'),nanstd(move_vect_1200(:,tr_1200_prior_move),0,2)/sqrt(size(move_vect_1200(:,tr_1200_prior_move),2)),'--r')
hold on
errorbar(tBehav,smooth(nanmean(move_vect_100(:,tr_100_prior_move),2),5,'Gauss'),nanstd(move_vect_100(:,tr_100_prior_move),0,2)/sqrt(size(move_vect_100(:,tr_100_prior_move),2)),'k')
xlim([-2.5 7])


roi_bod_100_cut=nan*ones(size(move_vect_100));
for i=1:size(move_vect_100,2)
    roi_bod_100_cut(1:first_move_100_delay_movie(i),i)=roi_bod_100(1:first_move_100_delay_movie(i),i);    
end
roi_bod_1200_cut=nan*ones(size(move_vect_1200));
for i=1:size(move_vect_1200,2)
    roi_bod_1200_cut(1:first_move_1200_delay_movie(i),i)=roi_bod_1200(1:first_move_1200_delay_movie(i),i);    
end


figure;errorbar(tBehav,smooth(nanmean(roi_bod_1200_cut(:,tr_1200_prior_move),2),5,'Gauss'),nanstd(roi_bod_1200_cut(:,tr_1200_prior_move),0,2)/sqrt(size(roi_bod_1200_cut(:,tr_1200_prior_move),2)),'--r')
hold on
errorbar(tBehav,smooth(nanmean(roi_bod_100_cut(:,tr_100_prior_move),2),5,'Gauss'),nanstd(roi_bod_100_cut(:,tr_100_prior_move),0,2)/sqrt(size(roi_bod_100_cut(:,tr_100_prior_move),2)),'k')
xlim([-2.5 7])
ylim([0 0.07])

figure;errorbar(tBehav,smooth(nanmean(roi_bod_1200_cut(:,tr_1200_no_prior_move),2),5,'Gauss'),nanstd(roi_bod_1200_cut(:,tr_1200_no_prior_move),0,2)/sqrt(size(roi_bod_1200_cut(:,tr_1200_no_prior_move),2)),'--r')
hold on
errorbar(tBehav,smooth(nanmean(roi_bod_100_cut(:,tr_100_no_prior_move),2),5,'Gauss'),nanstd(roi_bod_100_cut(:,tr_100_no_prior_move),0,2)/sqrt(size(roi_bod_100_cut(:,tr_100_no_prior_move),2)),'k')
xlim([-2.5 7])
ylim([0 0.07])

t100=size(move_vect_100,2)-size(tr_100_noisy,2);
t1200=size(move_vect_1200,2)-size(tr_1200_noisy,2);

rat100=[(t100-size(tr_100_no_prior_move,2)-size(tr_100_prior_move,2))/t100 size(tr_100_prior_move,2)/t100 size(tr_100_no_prior_move,2)/t100]*100; 
rat1200=[(t1200-size(tr_1200_no_prior_move,2)-size(tr_1200_prior_move,2))/t1200 size(tr_1200_prior_move,2)/t1200 size(tr_1200_no_prior_move,2)/t1200]*100; 

figure;
bar([rat1200;rat100],'stacked') 
legend('moving in delay','prior move','no prior move')

figure;bar([(rat1200(3)-rat1200(2))/(rat1200(3)+rat1200(2)) (rat100(3)-rat100(2))/(rat100(3)+rat100(2))])







