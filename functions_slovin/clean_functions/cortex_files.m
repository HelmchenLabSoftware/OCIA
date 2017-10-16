function list4data=cortex_files


% behavior_anal_psycho
clc
close all;
clear all;

name ='gol_2010_11_17_b.1';
% TRAIL=9;

[time_arr,event_arr,eog_arr,epp_arr,header,trialcount] = GetAllData(name);
list4data = mat2cell((header(3,:)+1)',ones(1,length(header(3,:))),1); 

% % header(13,TRAIL);
% % header(3,TRAIL)+1;
% % [event_arr(:,TRAIL),time_arr(:,TRAIL)];


[x,y]=hist(header(3,:)+1,[1:5]);
bar(y,x);
xx=x*100/sum(x);
title(num2str(xx))
%% errors
for i = 1:length(header(3,:))
    ind_100 = find(event_arr(:,i)==100); %eye movement
    if isempty(ind_100);
        ind_100 = nan;
        ind_403=nan;
        ind_56x=nan;
        ind_700=nan;
        ind_701=nan;
        ind_ok = 0;
        list4data_temp{i,1}=0;
    else
        ind_100 = ind_100(1);
        ind_403 = find(event_arr(:,i)==403); %camera onset
        if isempty(ind_403);
            ind_403 = nan;
            ind_56x = nan;
            ind_700 = nan;
            ind_701 = nan;
            ind_ok = 0;
            list4data_temp{i,1} = 1;
        else
            ind_403 = ind_403(1);
            
            if cell2mat(list4data(i,1))==1 %cond2
                ind_56x = find(event_arr(:,i)==561);
            elseif cell2mat(list4data(i,1))==2 %cond3
                ind_56x = find(event_arr(:,i)==562);
            elseif cell2mat(list4data(i,1))==3 %cond4
                ind_56x = find(event_arr(:,i)==563);
            elseif cell2mat(list4data(i,1))==4 %cond3
                ind_56x = find(event_arr(:,i)==564);
            elseif cell2mat(list4data(i,1))==5 %cond4
                ind_56x = find(event_arr(:,i)==565);
            end
            ind_56x(ind_56x<ind_403) = [];
           
                ind_700 = find(event_arr(:,i)==700); % 700 is the 'saccade to target' code
                ind_701 = find(event_arr(:,i)==701); % 701 is the 'go saccade' code
                ind_200 = find(event_arr(:,i)==200); % 701 is the 'go saccade' code
      
                if  isempty(ind_701)
                    ind_ok =            0;
                    list4data_temp{i,1} = 3;
                    ind_701 = nan;
                else 
                    if  isempty(ind_700)
                        if isempty(ind_200)
                            ind_ok = 0;
                            list4data_temp{i,1} = 5;
                            ind_700 = nan;
                        else
                            if ind_200>ind_701
                                ind_ok = 0;
                                list4data_temp{i,1} = 5;
                                ind_700 = nan;
                            else
                                ind_ok = 0;
                                list4data_temp{i,1} = 4;
                                ind_700 = nan;
                            end
                        end
                    else
                        if header(13,i)==3
                            ind_ok = 0;
                            list4data_temp{i,1} = 5;
                        else
                            ind_ok = 1;
                            list4data_temp{i,1} = 6;
                        end
                        ind_700 = ind_700(1);
                        ind_701 = ind_701(1);
                    end
                end
        end
    end
    list4nm{i,:} = [ind_100,ind_403,ind_56x,ind_700,ind_700,ind_701,ind_ok];
end
list4data = [list4data,list4data_temp]; %[cond,error]
clear list4data_temp


%% camera
for i = 1:length(header(3,:))
    ind_403 = find(event_arr(:,i)==403);
    if isempty(ind_403);
        list4data_temp{i,1} = 0;
    else
        list4data_temp{i,1} = 1;
    end
end
list4data = [list4data,list4data_temp]; %[cond,the error,camera]
clear list4data_temp

%% eye movment
B = repmat([0,1],[1,round(size(eog_arr,1)/2)]);
for i = 1:length(header(3,:))
    if list4data{i,2}<4  %taking off early break fixation etc.
        list4data_xtemp{i,1} = nan;
        list4data_ytemp{i,1} = nan;
        tim_700{i,1} = nan;
        tim_701{i,1} = nan;
    else
        tims = time_arr(:,i);  % gives the real time (need to compare with the ind)
        eyes = eog_arr(:,i);  % gives the real eye movments (need to compare with the ind)
        ind_100 = list4nm{i}(1);
        ind_403 = list4nm{i}(2);
        ind_56x = list4nm{i}(3);
        tim_403 = tims(ind_403);  % gives the real time of the stimuli compare with the first ind 29
        tim_56x = tims(ind_56x);
        tim_100 = tims(ind_100);  % gives the real time of the eyes compare with the first ind 100
        tim_eye = round((tim_56x-tim_100)/4); % set the time zero for the eye movement, Fs = 250Hz
        eyex_temp = eyes(B==0);
        eyey_temp = eyes(B==1); %l&r U&D movments

        list4data_xtemp{i,1} = eyex_temp(tim_eye:tim_eye+570)*4;
        list4data_ytemp{i,1} = eyey_temp(tim_eye:tim_eye+570)*4;

         if ~isnan(list4nm{i}(5))
            tim_700{i,1} = (tims(list4nm{i}(5))-tims(list4nm{i}(3)));
        else
            tim_700{i,1} = nan;
        end
        if ~isnan(list4nm{i}(6))
            tim_701{i,1} = (tims(list4nm{i}(6))-tims(list4nm{i}(3)));
        else
            tim_701{i,1} = nan;
        end
    end
end
list4data2_temp = cell(length(list4data),1);
list4data = [list4data2_temp,list4data,list4data_xtemp,list4data_ytemp,tim_700,tim_700,tim_700,tim_701,tim_700]; %[mat_name,cond,error,camera,xeye,yeye,36,700]
clear list4data_xtemp list4datax_ytemp tim_703 tim_700 tim_701 tim_704 tim_705 list4data2_temp

for i = 1:length(header(3,:))
    ind_403 = header(13,i);
    if ind_403==3;
        list4data{i,1} = 0;
    else
        list4data{i,1} = 1;
    end
end



%%
tim_4_late_fix=0;
n = find(~isnan(cell2mat(list4data(:,10)))&cell2mat(list4data(:,10))<tim_4_late_fix);
for m = 1:length(n)
    list4data{n(m),3}=1;
end
clear m n

bigMat=zeros(length(header),8);
for i=1:length(header(3,:))
    bigMat(i,1) = i;  %trial nimber
    bigMat(i,2) = cell2mat(list4data(i,2));  %cond
    bigMat(i,3) = cell2mat(list4data(i,3));  %error style
    bigMat(i,4) = cell2mat(list4data(i,7));  %703 
    bigMat(i,5) = cell2mat(list4data(i,8));  %704
    bigMat(i,6) = cell2mat(list4data(i,9));  %705
    bigMat(i,7) = cell2mat(list4data(i,10)); %701
    bigMat(i,8) = cell2mat(list4data(i,11)); %700
end

%% taking off trials in which the monkey didn't keep fixation till mask on/off
% for i=1:size(list4data,1)
%     if list4data{i,2}~=3 
%         aaa = cell2mat(list4data(i,5));
%         aaa2 =cell2mat(list4data(i,6));
%         if ~isnan(aaa)
%             for j=1:round(tim_4_late_fix/4)%this number means the number of points that accepted for corectness.
%                 if (aaa(j) >4500) || (aaa(j) <-4500)
%                     bigMat(i,3) = 3;list4data{i,3}=3;
%                 end
%                 if (aaa2(j) >7000) || (aaa2(j) <-7000)
%                     bigMat(i,3) = 3;list4data{i,3}=3;
%                 end
%             end
% % 
% %                 if any(aaa(325:360) <1500 & aaa(325:360) >-1500)
% %                     bigMat(i,3) = 3;list4data{i,3}=3;
% %                 end
% 
%         end
%     end
% end

for i=1:length(header(3,:))
    if list4data{i,2}==3 && list4data{i,3}==3 %correct for cond 3 is also 6 and not 3
        bigMat(i,3)=6;
    end
end
for i=1:size(list4data,1)
    if list4data{i,2}==3 
        aaa = cell2mat(list4data(i,5));
        aaa2 =cell2mat(list4data(i,6));
        if ~isnan(aaa)
            for j=1:360
                if (aaa(j) >2000) || (aaa(j) <-2000)
                    bigMat(i,3) = 3;list4data{i,3}=3;
                end
                if (aaa2(j) >2000) || (aaa2(j) <-2000)
                    bigMat(i,3) = 3;list4data{i,3}=3;
                end
            end
        end
    end
end
% 
% for i=1:length(header(3,:))
%     if list4data{i,2}==3 && list4data{i,3}==3 %correct for cond 3 is also 6 and not 3
%         bigMat(i,3)=6;
%     end
% end

% taking off nan trials and the trials from above
for i=length(bigMat):-1:1
    if bigMat(i,3)<3
        bigMat(i,:)=[];
    end
end


% seperating bigMat to three different mats        
mat1(:,:)=bigMat(find(bigMat(:,2)==1),:);
mat2(:,:)=bigMat(find(bigMat(:,2)==2),:);
mat3(:,:)=bigMat(find(bigMat(:,2)==3),:);
mat4(:,:)=bigMat(find(bigMat(:,2)==4),:);
mat5(:,:)=bigMat(find(bigMat(:,2)==5),:);

%% plot eyex
cor_count = 0;
err_count = 0;
x=0;%(-3000:3000);
for cond = 1:5 %[2,3,4]
    figure;
    eval(['temp = (mat',int2str(cond),'(:,3));']);
    eval(['ind = (mat',int2str(cond),'(:,1));']);
    for ii=1:length(temp)
        %if temp(ii)>=4
            %pause
            %figure;
            if temp(ii) == 6
                plot (list4data{ind(ii),5},'b');
                xlim([0 450])
                hold on;
%                 plot(list4data{ind(ii),9}/4,x,'*c'); %705 - mask off
                plot(list4data{ind(ii),10}/4,x,'*r'); %701 - go saccade
                plot(list4data{ind(ii),11}/4,x,'*k'); %700 - saccade
                cor_count=cor_count+1;
            elseif temp(ii) == 5
                plot (list4data{ind(ii),5},'r');
                xlim([0 450])
                hold on;
%                 plot(list4data{ind(ii),9}/4,x,'*c');
                plot(list4data{ind(ii),10}/4,x,'*r');
                plot(list4data{ind(ii),11}/4,x,'*k');
               err_count=err_count+1;
            elseif temp(ii) == 4
                plot (list4data{ind(ii),5},'g');
                xlim([0 450])
                hold on;
%                 plot(list4data{ind(ii),9}/4,x,'*c');
                plot(list4data{ind(ii),10}/4,x,'*r');
                plot(list4data{ind(ii),11}/4,x,'*k');
%                 err_count=err_count+1;
            elseif temp(ii) == 3
                plot (list4data{ind(ii),5},'m');
                xlim([0 450])
                hold on;
%                 plot(list4data{ind(ii),9}/4,x,'*c');
                plot(list4data{ind(ii),10}/4,x,'*r');
                plot(list4data{ind(ii),11}/4,x,'*k');
%                 err_count=err_count+1;
            end
            title (['trial # ', int2str(ind(ii)),' cond ', int2str(cond)])
        end
        %title (['cond ',int2str(cond)]);
    %end
end


total_count = err_count+cor_count
disp(err_count)
per_cor = cor_count/total_count
       
%% sliding window of correct
%taking conds 2&4 orderly
ind = cell2mat(list4data(:,2)); %ind - conition; correct and error
j=1;
for i=1:length(ind)
    if ind(i)==2 || ind(i)==4 || ind(i)==1 || ind(i)==5
        cond2_4(j,:) = list4data (i,[2:3,5:11]);
        j=j+1;
    end
end

% taking off early break fixation
indx = cell2mat(cond2_4(:,2));
xxx=find(indx>4);
cond2_4 = cond2_4(xxx,:);

% sliding window - win length - 20 trials    
cor_err = cell2mat(cond2_4(:,2));
cor_name = cell2mat(cond2_4(:,1));
win=10;
for i=1:length(cond2_4)-win
    temp=cor_err(i:i+win-1);
    temp2=cor_name(i+win-1);
    correct=0;
    for j=1:win
        if temp(j)>5
            correct=correct+1;
        end
    end
    temp_ave(i) = (correct/win)*100;
        temp_name(i) = temp2;
    clear temp
end

%%%%% cond2
j=1;
for i=1:length(ind)
    if ind(i)==2 || ind(i)==1
        cond2_5(j,:) = list4data (i,[2:3,5:11]);
        j=j+1;
    end
end

% taking off early break fixation
indx = cell2mat(cond2_5(:,2));
xxx=find(indx>4);
cond2_5 = cond2_5(xxx,:);


% sliding window - win length - 10 trials    
cor_err = cell2mat(cond2_5(:,2));
win=10;
for i=1:length(cond2_5)-win
    temp=cor_err(i:i+win-1);
    correct=0;
    for j=1:win
        if temp(j)>5
            correct=correct+1;
        end
    end
    temp_ave2(i) = (correct/win)*100;
    clear temp
end

%%%%% cond4
j=1;
for i=1:length(ind)
    if ind(i)==4 || ind(i)==5
        cond2_6(j,:) = list4data (i,[2:3,5:11]);
        j=j+1;
    end
end

% taking off early break fixation
indx = cell2mat(cond2_6(:,2));
xxx=find(indx>4);
cond2_6 = cond2_6(xxx,:);


% sliding window - win length - 10 trials    
cor_err = cell2mat(cond2_6(:,2));
win=10;
for i=1:length(cond2_6)-win
    temp=cor_err(i:i+win-1);
    correct=0;
    for j=1:win
        if temp(j)>5
            correct=correct+1;
        end
    end
    temp_ave3(i) = (correct/win)*100;
    clear temp
end

figure;
subplot(2,2,[1,2]);hold on
if exist('temp_ave','var')
plot (find(temp_name>3),temp_ave(temp_name>3), '*r')
plot (find(temp_name<3),temp_ave(temp_name<3), '*g')
plot (temp_ave, '-k');

end
legend('4,5','1,2','Location','NorthWest')
ylim([40 100])
ylabel('percent correct')
title('average of 20 in sliding window (conds 1,2,4,5)')
clear cor_err;
set(gca,'YGrid','on');
subplot(2,2,3)
if exist('temp_ave2','var')
plot (temp_ave2, '*-k')
end
ylim([40 100])
ylabel('percent correct')
title('conds 1,2')
clear cor_err;
set(gca,'YGrid','on');
subplot(2,2,4)
if exist('temp_ave3','var')
plot (temp_ave3, '*-k')
end
ylim([40 100])
ylabel('percent correct')
title('conds 4,5')
clear cor_err;
set(gca,'YGrid','on');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
hold on
if exist('temp_ave','var')
plot (find(temp_name==1),temp_ave(temp_name==1), '*r')
plot (find(temp_name==2),temp_ave(temp_name==2), '*g')
plot (find(temp_name==4),temp_ave(temp_name==4), '*b')
plot (find(temp_name==5),temp_ave(temp_name==5), '*k')
plot (temp_ave, '-k');

end
legend('1','2','4','5','Location','SouthWest')
ylim([0 100])
ylabel('percent correct')
title('average of 10 in sliding window (conds 1,2,4,5)')
clear cor_err;
set(gca,'YGrid','on');

% %% sliding window of cond 3 only
% clear temp_ave
% cor_err3 = mat3(:,3);
% win=5;
% 
% for i=1:length(mat3)-win
%     temp=cor_err3(i:i+win-1);
%     correct=0;
%     for j=1:win
%         if temp(j)==6
%             correct=correct+1;
% 
%         end
%     end
%     temp_ave(i) = (correct/win)*100;
%     clear temp
% end
% figure;
% if exist('temp_ave','var')
% plot (temp_ave, '*-')
% end
% ylim([40 100])
% ylabel('percent correct')
% title('average of 5 in sliding window (cond 3)')
% 
% %%
% figure;
% plot(bigMat(:,1),bigMat(:,2)+8,'*r')
% hold on
% plot(bigMat(:,1),bigMat(:,3),'*b')
% grid on
% ylim([0 13])
