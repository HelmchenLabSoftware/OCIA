function list4data = get_cortex(name) 
% TRAIL=9;

[time_arr,event_arr,eog_arr,epp_arr,header,trialcount] = GetAllData(name);
list4data = mat2cell((header(3,:)+1)',ones(1,length(header(3,:))),1); 

% % header(13,TRAIL);
% % header(3,TRAIL)+1;
% % [event_arr(:,TRAIL),time_arr(:,TRAIL)];


[x,y]=hist(header(3,:)+1,[1:5]);
numtrial=x;
%bar(y,x);
xx=x*100/sum(x);
%title(num2str(xx))
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
                ind_701 = find(event_arr(:,i)==701); % 701 is the 'go saccade' code. for old cortex files use 36
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

        list4data_xtemp{i,1} = eyex_temp(tim_eye-70:tim_eye+500)*4;  %the time course of the eye position
        list4data_ytemp{i,1} = eyey_temp(tim_eye-70:tim_eye+500)*4;

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

end
