%% calculate coherogram

cd /fat2/Ariel_Gilad/Matlab_analysis/2007_03_12/test


load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load 1203
%load cond1n_dt_hb
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_hb(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_V1 = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_hb(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_V2 = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_hb(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_V4 = choose_polygon(100);

NFFT = 64;
win=32;
for i=[3 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_hb'])
    eval(['a=size(cond',int2str(i),'n_dt_hb,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_hb,2);'])
    for p=1:size(roi_V1,1)
        for h=1:a  %trial count 
            z=z+1;
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_hb'])
            eval(['cond',int2str(i),'n_dt_hb=cond',int2str(i),'n_dt_hb(:,2:end,h);'])
            f=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_hb(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_hb(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    %Pxx=2/0.375*abs(y).^2;
                    f(:,j,:)=y;
                end;
            
            eval(['clear cond',int2str(i),'n_dt_hb'])
            l=0;
            disp(['condition #',int2str(i),'trial #',int2str(h),' calculating coherence'])
            eval(['coher_V1_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V1_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V1(p))).*conj(f(:,:,pp))./sqrt(abs(f(:,:,find(pixels==roi_V1(p)))).^2.*abs(f(:,:,pp)).^2);'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V1(p)));
            %eval(['coher_V1_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'_t;'])
            else
                eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'+coher_V1_cond',int2str(i),'_t;'])
            end
            eval(['clear coher_V1_cond',int2str(i),'_t'])
        end;
    end;
    %eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'/z;'])
    %eval(['save coher_V1_cond',int2str(i),' coher_V1_cond',int2str(i),' roi_V1 pixels'])
    %eval(['clear coher_V1_cond',int2str(i)])
    z=0;
    for p=1:size(roi_V2,1)
        for h=1:a  %trial count 
            z=z+1;
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_hb'])
            eval(['cond',int2str(i),'n_dt_hb=cond',int2str(i),'n_dt_hb(:,2:end,h);'])
            f=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_hb(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_hb(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    %Pxx=2/0.375*abs(y).^2;
                    f(:,j,:)=y;
                end;
            
            eval(['clear cond',int2str(i),'n_dt_hb'])
            l=0;
            disp(['condition #',int2str(i),'trial #',int2str(h),' calculating coherence'])
            eval(['coher_V2_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2(p))).*conj(f(:,:,pp))./sqrt(abs(f(:,:,find(pixels==roi_V2(p)))).^2.*abs(f(:,:,pp)).^2);'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2(p)));
            %eval(['coher_V2_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_cond',int2str(i),'=coher_V2_cond',int2str(i),'_t;'])
            else
                eval(['coher_V2_cond',int2str(i),'=coher_V2_cond',int2str(i),'+coher_V2_cond',int2str(i),'_t;'])
            end
            eval(['clear coher_V2_cond',int2str(i),'_t'])
        end;
    end;
    %eval(['coher_V2_cond',int2str(i),'=coher_V2_cond',int2str(i),'/z;'])
    %eval(['save coher_V2_cond',int2str(i),' coher_V2_cond',int2str(i),' roi_V2 pixels'])
    %eval(['clear coher_V2_cond',int2str(i)])
    
    z=0;
    for p=1:size(roi_V4,1)
        for h=1:a  %trial count 
            z=z+1;
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_hb'])
            eval(['cond',int2str(i),'n_dt_hb=cond',int2str(i),'n_dt_hb(:,2:end,h);'])
            f=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_hb(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_hb(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    %Pxx=2/0.375*abs(y).^2;
                    f(:,j,:)=y;
                end;
            
            eval(['clear cond',int2str(i),'n_dt_hb'])
            l=0;
            disp(['condition #',int2str(i),'trial #',int2str(h),' calculating coherence'])
            eval(['coher_V4_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V4_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V4(p))).*conj(f(:,:,pp))./sqrt(abs(f(:,:,find(pixels==roi_V4(p)))).^2.*abs(f(:,:,pp)).^2);'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V4(p)));
            %eval(['coher_V4_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V4_cond',int2str(i),'=coher_V4_cond',int2str(i),'_t;'])
            else
                eval(['coher_V4_cond',int2str(i),'=coher_V4_cond',int2str(i),'+coher_V4_cond',int2str(i),'_t;'])
            end
            eval(['clear coher_V4_cond',int2str(i),'_t'])
        end;
    end;
    %eval(['coher_V4_cond',int2str(i),'=coher_V4_cond',int2str(i),'/z;'])
    %eval(['save coher_V4_cond',int2str(i),' coher_V4_cond',int2str(i),' roi_V4 pixels'])
    %eval(['clear coher_V4_cond',int2str(i)])
    
    z=0;
    for p=1:size(roi_V1_2,1)
        for h=1:a  %trial count 
            z=z+1;
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_hb'])
            eval(['cond',int2str(i),'n_dt_hb=cond',int2str(i),'n_dt_hb(:,2:end,h);'])
            f=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_hb(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_hb(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    %Pxx=2/0.375*abs(y).^2;
                    f(:,j,:)=y;
                end;
            
            eval(['clear cond',int2str(i),'n_dt_hb'])
            l=0;
            disp(['condition #',int2str(i),'trial #',int2str(h),' calculating coherence'])
            eval(['coher_V1_2_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V1_2_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V1_2(p))).*conj(f(:,:,pp))./sqrt(abs(f(:,:,find(pixels==roi_V1_2(p)))).^2.*abs(f(:,:,pp)).^2);'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V1_2(p)));
            %eval(['coher_V1_2_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'_t;'])
            else
                eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'+coher_V1_2_cond',int2str(i),'_t;'])
            end
            eval(['clear coher_V1_2_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'/z;'])
    eval(['save coher_V1_2_cond',int2str(i),' coher_V1_2_cond',int2str(i),' roi_V1_2 pixels'])
    eval(['clear coher_V1_2_cond',int2str(i)])
    
    z=0;
    for p=1:size(roi_V1_3,1)
        for h=1:a  %trial count 
            z=z+1;
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_hb'])
            eval(['cond',int2str(i),'n_dt_hb=cond',int2str(i),'n_dt_hb(:,2:end,h);'])
            f=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_hb(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_hb(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    %Pxx=2/0.375*abs(y).^2;
                    f(:,j,:)=y;
                end;
            
            eval(['clear cond',int2str(i),'n_dt_hb'])
            l=0;
            disp(['condition #',int2str(i),'trial #',int2str(h),' calculating coherence'])
            eval(['coher_V1_3_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V1_3_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V1_3(p))).*conj(f(:,:,pp))./sqrt(abs(f(:,:,find(pixels==roi_V1_3(p)))).^2.*abs(f(:,:,pp)).^2);'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V1_3(p)));
            %eval(['coher_V1_3_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V1_3_cond',int2str(i),'=coher_V1_3_cond',int2str(i),'_t;'])
            else
                eval(['coher_V1_3_cond',int2str(i),'=coher_V1_3_cond',int2str(i),'+coher_V1_3_cond',int2str(i),'_t;'])
            end
            eval(['clear coher_V1_3_cond',int2str(i),'_t'])
        end;
    end;
    %eval(['coher_V1_3_cond',int2str(i),'=coher_V1_3_cond',int2str(i),'/z;'])
    %eval(['save coher_V1_3_cond',int2str(i),' coher_V1_3_cond',int2str(i),' roi_V1_3 pixels'])
    %eval(['clear coher_V1_3_cond',int2str(i)])
    
    z=0;
    for p=1:size(roi_V2_2,1)
        for h=1:a  %trial count 
            z=z+1;
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_hb'])
            eval(['cond',int2str(i),'n_dt_hb=cond',int2str(i),'n_dt_hb(:,2:end,h);'])
            f=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_hb(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_hb(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    %Pxx=2/0.375*abs(y).^2;
                    f(:,j,:)=y;
                end;
            
            eval(['clear cond',int2str(i),'n_dt_hb'])
            l=0;
            disp(['condition #',int2str(i),'trial #',int2str(h),' calculating coherence'])
            eval(['coher_V2_2_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_2_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_2(p))).*conj(f(:,:,pp))./sqrt(abs(f(:,:,find(pixels==roi_V2_2(p)))).^2.*abs(f(:,:,pp)).^2);'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_2(p)));
            %eval(['coher_V2_2_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_2_cond',int2str(i),'=coher_V2_2_cond',int2str(i),'_t;'])
            else
                eval(['coher_V2_2_cond',int2str(i),'=coher_V2_2_cond',int2str(i),'+coher_V2_2_cond',int2str(i),'_t;'])
            end
            eval(['clear coher_V2_2_cond',int2str(i),'_t'])
        end;
    end;
    %eval(['coher_V2_2_cond',int2str(i),'=coher_V2_2_cond',int2str(i),'/z;'])
    %eval(['save coher_V2_2_cond',int2str(i),' coher_V2_2_cond',int2str(i),' roi_V2_2 pixels'])
    %eval(['clear coher_V2_2_cond',int2str(i)])
    
    z=0;
    for p=1:size(roi_V2_3,1)
        for h=1:a  %trial count 
            z=z+1;
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_hb'])
            eval(['cond',int2str(i),'n_dt_hb=cond',int2str(i),'n_dt_hb(:,2:end,h);'])
            f=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_hb(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_hb(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    %Pxx=2/0.375*abs(y).^2;
                    f(:,j,:)=y;
                end;
            
            eval(['clear cond',int2str(i),'n_dt_hb'])
            l=0;
            disp(['condition #',int2str(i),'trial #',int2str(h),' calculating coherence'])
            eval(['coher_V2_3_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_3_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_3(p))).*conj(f(:,:,pp))./sqrt(abs(f(:,:,find(pixels==roi_V2_3(p)))).^2.*abs(f(:,:,pp)).^2);'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_3(p)));
            %eval(['coher_V2_3_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_3_cond',int2str(i),'=coher_V2_3_cond',int2str(i),'_t;'])
            else
                eval(['coher_V2_3_cond',int2str(i),'=coher_V2_3_cond',int2str(i),'+coher_V2_3_cond',int2str(i),'_t;'])
            end
            eval(['clear coher_V2_3_cond',int2str(i),'_t'])
        end;
    end;
    %eval(['coher_V2_3_cond',int2str(i),'=coher_V2_3_cond',int2str(i),'/z;'])
    %eval(['save coher_V2_3_cond',int2str(i),' coher_V2_3_cond',int2str(i),' roi_V2_3 pixels'])
    %eval(['clear coher_V2_3_cond',int2str(i)])
    
    z=0;
    for p=1:size(roi_V4_2,1)
        for h=1:a  %trial count 
            z=z+1;
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_hb'])
            eval(['cond',int2str(i),'n_dt_hb=cond',int2str(i),'n_dt_hb(:,2:end,h);'])
            f=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_hb(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_hb(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    %Pxx=2/0.375*abs(y).^2;
                    f(:,j,:)=y;
                end;
            
            eval(['clear cond',int2str(i),'n_dt_hb'])
            l=0;
            disp(['condition #',int2str(i),'trial #',int2str(h),' calculating coherence'])
            eval(['coher_V4_2_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V4_2_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V4_2(p))).*conj(f(:,:,pp))./sqrt(abs(f(:,:,find(pixels==roi_V4_2(p)))).^2.*abs(f(:,:,pp)).^2);'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V4_2(p)));
            %eval(['coher_V4_2_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V4_2_cond',int2str(i),'=coher_V4_2_cond',int2str(i),'_t;'])
            else
                eval(['coher_V4_2_cond',int2str(i),'=coher_V4_2_cond',int2str(i),'+coher_V4_2_cond',int2str(i),'_t;'])
            end
            eval(['clear coher_V4_2_cond',int2str(i),'_t'])
        end;
    end;
    %eval(['coher_V4_2_cond',int2str(i),'=coher_V4_2_cond',int2str(i),'/z;'])
    %eval(['save coher_V4_2_cond',int2str(i),' coher_V4_2_cond',int2str(i),' roi_V4_2 pixels'])
    %eval(['clear coher_V4_2_cond',int2str(i)])
    
    z=0;
    for p=1:size(roi_no,1)
        for h=1:a  %trial count 
            z=z+1;
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_hb'])
            eval(['cond',int2str(i),'n_dt_hb=cond',int2str(i),'n_dt_hb(:,2:end,h);'])
            f=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_hb(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_hb(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    %Pxx=2/0.375*abs(y).^2;
                    f(:,j,:)=y;
                end;
            
            eval(['clear cond',int2str(i),'n_dt_hb'])
            l=0;
            disp(['condition #',int2str(i),'trial #',int2str(h),' calculating coherence'])
            eval(['coher_no_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_no_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_no(p))).*conj(f(:,:,pp))./sqrt(abs(f(:,:,find(pixels==roi_no(p)))).^2.*abs(f(:,:,pp)).^2);'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_no(p)));
            %eval(['coher_no_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_no_cond',int2str(i),'=coher_no_cond',int2str(i),'_t;'])
            else
                eval(['coher_no_cond',int2str(i),'=coher_no_cond',int2str(i),'+coher_no_cond',int2str(i),'_t;'])
            end
            eval(['clear coher_no_cond',int2str(i),'_t'])
        end;
    end;
    %eval(['coher_no_cond',int2str(i),'=coher_no_cond',int2str(i),'/z;'])
    %eval(['save coher_no_cond',int2str(i),' coher_no_cond',int2str(i),' roi_no pixels'])
    %eval(['clear coher_no_cond',int2str(i)])
end    
    