cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/vsdi_coVnon_path/Path/legolas/2007_03_12/conds

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


load 1203

tf=4;   %define target frequency
NFFT = 64;
win=16;
for i=[4 3 2 6]%condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V1,1)
        for h=1:a  %trial count 
            z=z+1;
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_bl=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            f=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    %Pxx=2/0.375*abs(y).^2;
                    f(:,j,:)=y;
                end;
            
            eval(['clear cond',int2str(i),'n_dt_bl'])
            l=0;
            disp(['condition #',int2str(i),'trial #',int2str(h),' calculating coherence'])
            eval(['inter_coher_',int2str(tf),'_V1_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['inter_coher_',int2str(tf),'_V1_cond',int2str(i),'_t(l,:,:)=repmat(squeeze(f(tf,:,find(pixels==roi_V1(p)))),[size(f,1) 1]).*conj(f(:,:,pp))./sqrt(abs(repmat(squeeze(f(tf,:,find(pixels==roi_V1(p)))),[size(f,1) 1])).^2.*abs(f(:,:,pp)).^2);'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V1(p)));
            %eval(['coher_V1_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['inter_coher_',int2str(tf),'_V1_cond',int2str(i),'=inter_coher_',int2str(tf),'_V1_cond',int2str(i),'_t;'])
                eval(['inter_coher_',int2str(tf),'_V1_std_cond',int2str(i),'=inter_coher_',int2str(tf),'_V1_cond',int2str(i),'_t.^2;'])
            else
                eval(['inter_coher_',int2str(tf),'_V1_cond',int2str(i),'=inter_coher_',int2str(tf),'_V1_cond',int2str(i),'+inter_coher_',int2str(tf),'_V1_cond',int2str(i),'_t;'])
                eval(['inter_coher_',int2str(tf),'_V1_std_cond',int2str(i),'=inter_coher_',int2str(tf),'_V1_std_cond',int2str(i),'+inter_coher_',int2str(tf),'_V1_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear inter_coher_',int2str(tf),'_V1_cond',int2str(i),'_t'])
        end;
    end;
    eval(['inter_coher_',int2str(tf),'_V1_cond',int2str(i),'=inter_coher_',int2str(tf),'_V1_cond',int2str(i),'/z;'])
    eval(['inter_coher_',int2str(tf),'_V1_std_cond',int2str(i),'=sqrt((inter_coher_',int2str(tf),'_V1_std_cond',int2str(i),'-(inter_coher_',int2str(tf),'_V1_cond',int2str(i),'.^2)*z)/(z-1));'])
    eval(['save inter_coher_',int2str(tf),'_V1_cond',int2str(i),' inter_coher_',int2str(tf),'_V1_cond',int2str(i),' roi_V1 pixels'])
    eval(['save inter_coher_',int2str(tf),'_V1_std_cond',int2str(i),' inter_coher_',int2str(tf),'_V1_std_cond',int2str(i),' roi_V1 pixels'])
    eval(['clear inter_coher_',int2str(tf),'_V1_cond',int2str(i)])
    eval(['clear inter_coher_',int2str(tf),'_V1_std_cond',int2str(i)])
end



cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/vsdi_coVnon_path/Path/legolas/2007_03_12/conds

date='1203';   %choose date
load (date)
b=size(roi_V1,1);


for cond=[4 3 2 6]
    load (['cond',int2str(cond),'n_dt_bl'])
    eval(['a=size(cond',int2str(cond),'n_dt_bl,3);'])   
    eval(['clear cond',int2str(cond),'n_dt_bl'])
    disp(['cond ',int2str(cond)])    
    load (['inter_coher_',int2str(tf),'_V1_cond',int2str(cond)])
    eval(['inter_coher_',int2str(tf),'_V1_cond',int2str(cond),'=inter_coher_',int2str(tf),'_V1_cond',int2str(cond),'*b*a;'])
    eval(['c=zeros(10000,size(inter_coher_',int2str(tf),'_V1_cond',int2str(cond),',2),size(inter_coher_',int2str(tf),'_V1_cond',int2str(cond),',3));'])
    eval(['c(pixels,:,:)=inter_coher_',int2str(tf),'_V1_cond',int2str(cond),';']);
    eval(['clear inter_coher_',int2str(tf),'_V1_cond',int2str(cond)])
    c(roi_V1,:,:)=c(roi_V1,:,:)-a;
    c=c/(b*a);
    eval(['inter_coher_',int2str(tf),'_V1_cond',int2str(cond),'=c(pixels,:,:);']);
    eval(['save inter_coher_',int2str(tf),'_V1_cond',int2str(cond),' inter_coher_',int2str(tf),'_V1_cond',int2str(cond),' roi_V1 pixels'])
    eval(['clear inter_coher_',int2str(tf),'_V1_cond',int2str(cond)])
    clear c
end


