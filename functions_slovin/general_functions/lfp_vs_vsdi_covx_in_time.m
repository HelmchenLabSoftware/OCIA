clear all
cd /fat/Ariel/matlab_analysis/vsdi/frodo/12_05_2010/e
load times_course_vsdi_lfp
win=25;
tr=size(lfp_cond3,2);
x4=(1:256)*10-280;
x5=(1:626)*4-500;

%down sample the lfp to 100 Hz
x6 = resample(x5,4,10);
lfp_cond3_ds = resample(lfp_cond3,4,10);


% for i=1:tr
%     figure;plot(x5,lfp_cond3(:,i))
%     xlim([-100 800])
%     figure;plot(x4(2:256),vsdi_cond3(2:256,i),'--')
%     xlim([-100 800])
% end

covt_cond3=zeros(tr,2*win+1);
for i=1:tr
    lt=24;
    for vt=2:110-win
        lt=lt+1;
        d(:,vt)=xcov(lfp_cond3_ds(lt:lt+win,i),vsdi_cond3(vt:vt+win,i),'coeff');
    end
    covt_cond3(i,:)=mean(d(:,2:end),2);
end
    
 x7=-win*10:10:win*10;   
 figure;
 errorbar(x7,mean(covt_cond3,1),std(covt_cond3,0,1)/sqrt(size(covt_cond3,1)))
 xlim([-250 250])
 signrank(mean(covt_cond3(:,22),2))
   
% figure;plot(covt_cond3')   




    