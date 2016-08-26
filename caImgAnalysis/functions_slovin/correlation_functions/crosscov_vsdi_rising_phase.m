% cross-covariance in the rising phase
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/11_11_2008/c/elhanan_new

load myrois

for i=4:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);']) 
    eval(['crosscov_cond',int2str(i),'=zeros(101,a);']) 
    for tr=1:a
        disp(tr)
        crosscov_tr=zeros(size(roi_contour2,1),size(roi_V2,1),101);
        l=0;
        for p=[roi_contour2]'
            k=0;
            l=l+1;
            for pp=[roi_V2]'
                k=k+1;
                eval(['crosscov_tr(l,k,:)=xcov(cond',int2str(i),'n_dt_bl(p,18:68,tr),cond',int2str(i),'n_dt_bl(pp,18:68,tr),''coeff'');'])
            end
        end
        eval(['crosscov_cond',int2str(i),'(:,tr)=squeeze(mean(mean(crosscov_tr,1),2));']) 
    end
    eval(['clear cond',int2str(i),'n_dt_bl'])
    eval(['save crosscov_cond',int2str(i),' crosscov_cond',int2str(i)']) 
end
            
            
            
          
% cross-covariance in the rising phase
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/11_11_2008/d/elhanan_new

load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);']) 
    eval(['crosscov_cond',int2str(i),'=zeros(101,a);']) 
    for tr=1:a
        disp(tr)
        crosscov_tr=zeros(size(roi_contour2,1),size(roi_V2,1),101);
        l=0;
        for p=[roi_contour2]'
            k=0;
            l=l+1;
            for pp=[roi_V2]'
                k=k+1;
                eval(['crosscov_tr(l,k,:)=xcov(cond',int2str(i),'n_dt_bl(p,18:68,tr),cond',int2str(i),'n_dt_bl(pp,18:68,tr),''coeff'');'])
            end
        end
        eval(['crosscov_cond',int2str(i),'(:,tr)=squeeze(mean(mean(crosscov_tr,1),2));']) 
    end
    eval(['clear cond',int2str(i),'n_dt_bl'])
    eval(['save crosscov_cond',int2str(i),' crosscov_cond',int2str(i)']) 
end
            
      



% cross-covariance in the rising phase
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/c

load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);']) 
    eval(['crosscov_cond',int2str(i),'=zeros(101,a);']) 
    for tr=1:a
        disp(tr)
        crosscov_tr=zeros(size(roi_contour,1),size(roi_V2,1),101);
        l=0;
        for p=[roi_contour]'
            k=0;
            l=l+1;
            for pp=[roi_V2]'
                k=k+1;
                eval(['crosscov_tr(l,k,:)=xcov(cond',int2str(i),'n_dt_bl(p,18:68,tr),cond',int2str(i),'n_dt_bl(pp,18:68,tr),''coeff'');'])
            end
        end
        eval(['crosscov_cond',int2str(i),'(:,tr)=squeeze(mean(mean(crosscov_tr,1),2));']) 
    end
    eval(['clear cond',int2str(i),'n_dt_bl'])
    eval(['save crosscov_cond',int2str(i),' crosscov_cond',int2str(i)']) 
end
            
      


cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/d


for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);']) 
    eval(['crosscov_cond',int2str(i),'=zeros(101,a);']) 
    for tr=1:a
        disp(tr)
        crosscov_tr=zeros(size(roi_contour,1),size(roi_V2,1),101);
        l=0;
        for p=[roi_contour]'
            k=0;
            l=l+1;
            for pp=[roi_V2]'
                k=k+1;
                eval(['crosscov_tr(l,k,:)=xcov(cond',int2str(i),'n_dt_bl(p,18:68,tr),cond',int2str(i),'n_dt_bl(pp,18:68,tr),''coeff'');'])
            end
        end
        eval(['crosscov_cond',int2str(i),'(:,tr)=squeeze(mean(mean(crosscov_tr,1),2));']) 
    end
    eval(['clear cond',int2str(i),'n_dt_bl'])
    eval(['save crosscov_cond',int2str(i),' crosscov_cond',int2str(i)']) 
end
            
      
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/e


for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);']) 
    eval(['crosscov_cond',int2str(i),'=zeros(101,a);']) 
    for tr=1:a
        disp(tr)
        crosscov_tr=zeros(size(roi_contour,1),size(roi_V2,1),101);
        l=0;
        for p=[roi_contour]'
            k=0;
            l=l+1;
            for pp=[roi_V2]'
                k=k+1;
                eval(['crosscov_tr(l,k,:)=xcov(cond',int2str(i),'n_dt_bl(p,18:68,tr),cond',int2str(i),'n_dt_bl(pp,18:68,tr),''coeff'');'])
            end
        end
        eval(['crosscov_cond',int2str(i),'(:,tr)=squeeze(mean(mean(crosscov_tr,1),2));']) 
    end
    eval(['clear cond',int2str(i),'n_dt_bl'])
    eval(['save crosscov_cond',int2str(i),' crosscov_cond',int2str(i)']) 
end
        



cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/d

load 2511 

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);']) 
    eval(['crosscov_cond',int2str(i),'=zeros(101,a);']) 
    for tr=1:a
        disp(tr)
        crosscov_tr=zeros(size(roi_contour,1),size(roi_V2,1),101);
        l=0;
        for p=[roi_contour]'
            k=0;
            l=l+1;
            for pp=[roi_V2]'
                k=k+1;
                eval(['crosscov_tr(l,k,:)=xcov(cond',int2str(i),'n_dt_bl(p,18:68,tr),cond',int2str(i),'n_dt_bl(pp,18:68,tr),''coeff'');'])
            end
        end
        eval(['crosscov_cond',int2str(i),'(:,tr)=squeeze(mean(mean(crosscov_tr,1),2));']) 
    end
    eval(['clear cond',int2str(i),'n_dt_bl'])
    eval(['save crosscov_cond',int2str(i),' crosscov_cond',int2str(i)']) 
end
    


cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/e

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);']) 
    eval(['crosscov_cond',int2str(i),'=zeros(101,a);']) 
    for tr=1:a
        disp(tr)
        crosscov_tr=zeros(size(roi_contour,1),size(roi_V2,1),101);
        l=0;
        for p=[roi_contour]'
            k=0;
            l=l+1;
            for pp=[roi_V2]'
                k=k+1;
                eval(['crosscov_tr(l,k,:)=xcov(cond',int2str(i),'n_dt_bl(p,18:68,tr),cond',int2str(i),'n_dt_bl(pp,18:68,tr),''coeff'');'])
            end
        end
        eval(['crosscov_cond',int2str(i),'(:,tr)=squeeze(mean(mean(crosscov_tr,1),2));']) 
    end
    eval(['clear cond',int2str(i),'n_dt_bl'])
    eval(['save crosscov_cond',int2str(i),' crosscov_cond',int2str(i)']) 
end
    
cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/f

  

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);']) 
    eval(['crosscov_cond',int2str(i),'=zeros(101,a);']) 
    for tr=1:a
        disp(tr)
        crosscov_tr=zeros(size(roi_contour,1),size(roi_V2,1),101);
        l=0;
        for p=[roi_contour]'
            k=0;
            l=l+1;
            for pp=[roi_V2]'
                k=k+1;
                eval(['crosscov_tr(l,k,:)=xcov(cond',int2str(i),'n_dt_bl(p,18:68,tr),cond',int2str(i),'n_dt_bl(pp,18:68,tr),''coeff'');'])
            end
        end
        eval(['crosscov_cond',int2str(i),'(:,tr)=squeeze(mean(mean(crosscov_tr,1),2));']) 
    end
    eval(['clear cond',int2str(i),'n_dt_bl'])
    eval(['save crosscov_cond',int2str(i),' crosscov_cond',int2str(i)']) 
end
    



cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/d

load myrois  

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);']) 
    eval(['crosscov_cond',int2str(i),'=zeros(101,a);']) 
    for tr=1:a
        disp(tr)
        crosscov_tr=zeros(size(roi_contour,1),size(roi_V2,1),101);
        l=0;
        for p=[roi_contour]'
            k=0;
            l=l+1;
            for pp=[roi_V2]'
                k=k+1;
                eval(['crosscov_tr(l,k,:)=xcov(cond',int2str(i),'n_dt_bl(p,18:68,tr),cond',int2str(i),'n_dt_bl(pp,18:68,tr),''coeff'');'])
            end
        end
        eval(['crosscov_cond',int2str(i),'(:,tr)=squeeze(mean(mean(crosscov_tr,1),2));']) 
    end
    eval(['clear cond',int2str(i),'n_dt_bl'])
    eval(['save crosscov_cond',int2str(i),' crosscov_cond',int2str(i)']) 
end
    

cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/e

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);']) 
    eval(['crosscov_cond',int2str(i),'=zeros(101,a);']) 
    for tr=1:a
        disp(tr)
        crosscov_tr=zeros(size(roi_contour,1),size(roi_V2,1),101);
        l=0;
        for p=[roi_contour]'
            k=0;
            l=l+1;
            for pp=[roi_V2]'
                k=k+1;
                eval(['crosscov_tr(l,k,:)=xcov(cond',int2str(i),'n_dt_bl(p,18:68,tr),cond',int2str(i),'n_dt_bl(pp,18:68,tr),''coeff'');'])
            end
        end
        eval(['crosscov_cond',int2str(i),'(:,tr)=squeeze(mean(mean(crosscov_tr,1),2));']) 
    end
    eval(['clear cond',int2str(i),'n_dt_bl'])
    eval(['save crosscov_cond',int2str(i),' crosscov_cond',int2str(i)']) 
end
    

cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/f

  

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);']) 
    eval(['crosscov_cond',int2str(i),'=zeros(101,a);']) 
    for tr=1:a
        disp(tr)
        crosscov_tr=zeros(size(roi_contour,1),size(roi_V2,1),101);
        l=0;
        for p=[roi_contour]'
            k=0;
            l=l+1;
            for pp=[roi_V2]'
                k=k+1;
                eval(['crosscov_tr(l,k,:)=xcov(cond',int2str(i),'n_dt_bl(p,18:68,tr),cond',int2str(i),'n_dt_bl(pp,18:68,tr),''coeff'');'])
            end
        end
        eval(['crosscov_cond',int2str(i),'(:,tr)=squeeze(mean(mean(crosscov_tr,1),2));']) 
    end
    eval(['clear cond',int2str(i),'n_dt_bl'])
    eval(['save crosscov_cond',int2str(i),' crosscov_cond',int2str(i)']) 
end
    





