% cross-covariance in the rising phase

time=28:43;
win=size(time,2);
x=(-win+1)*10:10:(win-1)*10;

cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/11_11_2008/c/elhanan_new

load myrois
roi1=roi_V2;
roi2=roi_contour2;

for i=1:5
    disp(i)
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=mean(cond',int2str(i),'n_dt_bl,3)-1;'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
    eval(['crosscorr_cond',int2str(i),'=zeros(win*2-1,1);']) 
        crosscorr=zeros(size(roi1,1),size(roi2,1),win*2-1);
        l=0;
        for p=[roi1]'
            k=0;
            l=l+1;
            for pp=[roi2]'
                k=k+1;
                eval(['crosscorr(l,k,:)=xcorr(a(p,time),a(pp,time),''coeff'');'])
            end
        end
        eval(['crosscorr_cond',int2str(i),'=squeeze(mean(mean(crosscorr,1),2));'])  
end
save crosscorr_ave_V2_contour2 crosscorr_cond1 crosscorr_cond2 crosscorr_cond3 crosscorr_cond4 crosscorr_cond5



cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/11_11_2008/d/elhanan_new

roi1=roi_V2;
roi2=roi_contour2;

for i=1:5
    disp(i)
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=mean(cond',int2str(i),'n_dt_bl,3)-1;'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
    eval(['crosscorr_cond',int2str(i),'=zeros(win*2-1,1);']) 
        crosscorr=zeros(size(roi1,1),size(roi2,1),win*2-1);
        l=0;
        for p=[roi1]'
            k=0;
            l=l+1;
            for pp=[roi2]'
                k=k+1;
                eval(['crosscorr(l,k,:)=xcorr(a(p,time),a(pp,time),''coeff'');'])
            end
        end
        eval(['crosscorr_cond',int2str(i),'=squeeze(mean(mean(crosscorr,1),2));'])  
end
save crosscorr_ave_V2_contour2 crosscorr_cond1 crosscorr_cond2 crosscorr_cond3 crosscorr_cond4 crosscorr_cond5



cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/c

load myrois
roi1=roi_V2;
roi2=roi_contour;

for i=[1 5]
    disp(i)
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=mean(cond',int2str(i),'n_dt_bl,3)-1;'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
    eval(['crosscorr_cond',int2str(i),'=zeros(win*2-1,1);']) 
        crosscorr=zeros(size(roi1,1),size(roi2,1),win*2-1);
        l=0;
        for p=[roi1]'
            k=0;
            l=l+1;
            for pp=[roi2]'
                k=k+1;
                eval(['crosscorr(l,k,:)=xcorr(a(p,time),a(pp,time),''coeff'');'])
            end
        end
        eval(['crosscorr_cond',int2str(i),'=squeeze(mean(mean(crosscorr,1),2));'])  
end
save crosscorr_ave_V2_contour crosscorr_cond1 crosscorr_cond2 crosscorr_cond3 crosscorr_cond4 crosscorr_cond5


cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/d

roi1=roi_V2;
roi2=roi_contour;

for i=[1 5]
    disp(i)
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=mean(cond',int2str(i),'n_dt_bl,3)-1;'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
    eval(['crosscorr_cond',int2str(i),'=zeros(win*2-1,1);']) 
        crosscorr=zeros(size(roi1,1),size(roi2,1),win*2-1);
        l=0;
        for p=[roi1]'
            k=0;
            l=l+1;
            for pp=[roi2]'
                k=k+1;
                eval(['crosscorr(l,k,:)=xcorr(a(p,time),a(pp,time),''coeff'');'])
            end
        end
        eval(['crosscorr_cond',int2str(i),'=squeeze(mean(mean(crosscorr,1),2));'])  
end
save crosscorr_ave_V2_contour crosscorr_cond1 crosscorr_cond2 crosscorr_cond3 crosscorr_cond4 crosscorr_cond5


cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_18/e

roi1=roi_V2;
roi2=roi_contour;

for i=[1 5]
    disp(i)
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=mean(cond',int2str(i),'n_dt_bl,3)-1;'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
    eval(['crosscorr_cond',int2str(i),'=zeros(win*2-1,1);']) 
        crosscorr=zeros(size(roi1,1),size(roi2,1),win*2-1);
        l=0;
        for p=[roi1]'
            k=0;
            l=l+1;
            for pp=[roi2]'
                k=k+1;
                eval(['crosscorr(l,k,:)=xcorr(a(p,time),a(pp,time),''coeff'');'])
            end
        end
        eval(['crosscorr_cond',int2str(i),'=squeeze(mean(mean(crosscorr,1),2));'])  
end
save crosscorr_ave_V2_contour crosscorr_cond1 crosscorr_cond2 crosscorr_cond3 crosscorr_cond4 crosscorr_cond5


cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/d

load 2511

roi1=roi_V2;
roi2=roi_contour;

for i=[1 5]
    disp(i)
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=mean(cond',int2str(i),'n_dt_bl,3)-1;'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
    eval(['crosscorr_cond',int2str(i),'=zeros(win*2-1,1);']) 
        crosscorr=zeros(size(roi1,1),size(roi2,1),win*2-1);
        l=0;
        for p=[roi1]'
            k=0;
            l=l+1;
            for pp=[roi2]'
                k=k+1;
                eval(['crosscorr(l,k,:)=xcorr(a(p,time),a(pp,time),''coeff'');'])
            end
        end
        eval(['crosscorr_cond',int2str(i),'=squeeze(mean(mean(crosscorr,1),2));'])  
end
save crosscorr_ave_V2_contour crosscorr_cond1 crosscorr_cond2 crosscorr_cond3 crosscorr_cond4 crosscorr_cond5


cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/e


roi1=roi_V2;
roi2=roi_contour;

for i=[1 5]
    disp(i)
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=mean(cond',int2str(i),'n_dt_bl,3)-1;'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
    eval(['crosscorr_cond',int2str(i),'=zeros(win*2-1,1);']) 
        crosscorr=zeros(size(roi1,1),size(roi2,1),win*2-1);
        l=0;
        for p=[roi1]'
            k=0;
            l=l+1;
            for pp=[roi2]'
                k=k+1;
                eval(['crosscorr(l,k,:)=xcorr(a(p,time),a(pp,time),''coeff'');'])
            end
        end
        eval(['crosscorr_cond',int2str(i),'=squeeze(mean(mean(crosscorr,1),2));'])  
end
save crosscorr_ave_V2_contour crosscorr_cond1 crosscorr_cond2 crosscorr_cond3 crosscorr_cond4 crosscorr_cond5



cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_11_25/f


roi1=roi_V2;
roi2=roi_contour;

for i=[1 5]
    disp(i)
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=mean(cond',int2str(i),'n_dt_bl,3)-1;'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
    eval(['crosscorr_cond',int2str(i),'=zeros(win*2-1,1);']) 
        crosscorr=zeros(size(roi1,1),size(roi2,1),win*2-1);
        l=0;
        for p=[roi1]'
            k=0;
            l=l+1;
            for pp=[roi2]'
                k=k+1;
                eval(['crosscorr(l,k,:)=xcorr(a(p,time),a(pp,time),''coeff'');'])
            end
        end
        eval(['crosscorr_cond',int2str(i),'=squeeze(mean(mean(crosscorr,1),2));'])  
end
save crosscorr_ave_V2_contour crosscorr_cond1 crosscorr_cond2 crosscorr_cond3 crosscorr_cond4 crosscorr_cond5



cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/d

load myrois

roi1=roi_V2;
roi2=roi_contour;

for i=[1 5]
    disp(i)
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=mean(cond',int2str(i),'n_dt_bl,3)-1;'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
    eval(['crosscorr_cond',int2str(i),'=zeros(win*2-1,1);']) 
        crosscorr=zeros(size(roi1,1),size(roi2,1),win*2-1);
        l=0;
        for p=[roi1]'
            k=0;
            l=l+1;
            for pp=[roi2]'
                k=k+1;
                eval(['crosscorr(l,k,:)=xcorr(a(p,time),a(pp,time),''coeff'');'])
            end
        end
        eval(['crosscorr_cond',int2str(i),'=squeeze(mean(mean(crosscorr,1),2));'])  
end
save crosscorr_ave_V2_contour crosscorr_cond1 crosscorr_cond2 crosscorr_cond3 crosscorr_cond4 crosscorr_cond5


cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/e

roi1=roi_V2;
roi2=roi_contour;

for i=[1 5]
    disp(i)
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=mean(cond',int2str(i),'n_dt_bl,3)-1;'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
    eval(['crosscorr_cond',int2str(i),'=zeros(win*2-1,1);']) 
        crosscorr=zeros(size(roi1,1),size(roi2,1),win*2-1);
        l=0;
        for p=[roi1]'
            k=0;
            l=l+1;
            for pp=[roi2]'
                k=k+1;
                eval(['crosscorr(l,k,:)=xcorr(a(p,time),a(pp,time),''coeff'');'])
            end
        end
        eval(['crosscorr_cond',int2str(i),'=squeeze(mean(mean(crosscorr,1),2));'])  
end
save crosscorr_ave_V2_contour crosscorr_cond1 crosscorr_cond2 crosscorr_cond3 crosscorr_cond4 crosscorr_cond5


cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/psychophysics/2008_12_03/f

roi1=roi_V2;
roi2=roi_contour;

for i=[1 5]
    disp(i)
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=mean(cond',int2str(i),'n_dt_bl,3)-1;'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
    eval(['crosscorr_cond',int2str(i),'=zeros(win*2-1,1);']) 
        crosscorr=zeros(size(roi1,1),size(roi2,1),win*2-1);
        l=0;
        for p=[roi1]'
            k=0;
            l=l+1;
            for pp=[roi2]'
                k=k+1;
                eval(['crosscorr(l,k,:)=xcorr(a(p,time),a(pp,time),''coeff'');'])
            end
        end
        eval(['crosscorr_cond',int2str(i),'=squeeze(mean(mean(crosscorr,1),2));'])  
end
save crosscorr_ave_V2_contour crosscorr_cond1 crosscorr_cond2 crosscorr_cond3 crosscorr_cond4 crosscorr_cond5

