function [spect_sig]=calculate_significance_for_spectogram(spect_ave)
%after computing the spectogram, check for significance
% significance is calculated by comparing the spectogram data to 2 times of the std of the baseline
upper_limit=mean(spect_ave(:,1:8,:),2)+2.5*std(spect_ave(:,1:8,:),0,2);
bottom_limit=mean(spect_ave(:,1:8,:),2)-2.5*std(spect_ave(:,1:8,:),0,2);
clear baseline_std;
for i=1:size(spect_ave,3)
    disp(i)
    spect_temp=spect_ave(:,:,i);
    %spect_temp=(10.^(spect_temp./10)).*repmat(baseline_ave(:,i),1,223);  %undo db
    ind=find((spect_temp>repmat(upper_limit(:,i),1,size(spect_ave,2)))|(spect_temp<repmat(bottom_limit(:,i),1,size(spect_ave,2))));
    if ~isempty(ind)
        spect_temp(ind)=zeros(size(ind));
    end; 
    spect_temp(isnan(spect_temp))=1;
    spect_ave(:,:,i)=~logical(spect_temp);
end;
spect_sig=spect_ave;

