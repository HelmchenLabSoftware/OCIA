

cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/Path/legolas/2007_05_10/b/way2

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[3] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_flanker,1)
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
            eval(['coher_V2_flanker_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_flanker_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_flanker(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_flanker(p)));
            %eval(['coher_V2_flanker_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_flanker_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'/z;'])
    %eval(['coher_V2_flanker_cond',int2str(i),'=sqrt((coher_V2_flanker_cond',int2str(i),'-(coher_V2_flanker_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    %cd ..
    %eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    eval(['clear coher_V2_flanker_cond',int2str(i)])
    %eval(['clear coher_V2_flanker_cond',int2str(i)])
end


cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/Path/legolas/2007_05_10/e/way2

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[4 3] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_target,1)
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
            eval(['coher_V2_target_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_target_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_target(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_target(p)));
            %eval(['coher_V2_target_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'_t;'])
                %eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'+coher_V2_target_cond',int2str(i),'_t;'])
                %eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'+coher_V2_target_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_target_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'/z;'])
    %eval(['coher_V2_target_cond',int2str(i),'=sqrt((coher_V2_target_cond',int2str(i),'-(coher_V2_target_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_target_cond',int2str(i),' coher_V2_target_cond',int2str(i),' roi_V2_target pixels'])
    %cd ..
    %eval(['save coher_V2_target_cond',int2str(i),' coher_V2_target_cond',int2str(i),' roi_V2_target pixels'])
    eval(['clear coher_V2_target_cond',int2str(i)])
    %eval(['clear coher_V2_target_cond',int2str(i)])
end



cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/Path/legolas/2007_05_10/e/way2

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[4 3] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_flanker,1)
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
            eval(['coher_V2_flanker_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_flanker_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_flanker(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_flanker(p)));
            %eval(['coher_V2_flanker_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_flanker_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'/z;'])
    %eval(['coher_V2_flanker_cond',int2str(i),'=sqrt((coher_V2_flanker_cond',int2str(i),'-(coher_V2_flanker_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    %cd ..
    %eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    eval(['clear coher_V2_flanker_cond',int2str(i)])
    %eval(['clear coher_V2_flanker_cond',int2str(i)])
end



cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/Path/aragon/2007_11_20/way2

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[4 3] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_target,1)
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
            eval(['coher_V2_target_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_target_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_target(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_target(p)));
            %eval(['coher_V2_target_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'_t;'])
                %eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'+coher_V2_target_cond',int2str(i),'_t;'])
                %eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'+coher_V2_target_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_target_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'/z;'])
    %eval(['coher_V2_target_cond',int2str(i),'=sqrt((coher_V2_target_cond',int2str(i),'-(coher_V2_target_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_target_cond',int2str(i),' coher_V2_target_cond',int2str(i),' roi_V2_target pixels'])
    %cd ..
    %eval(['save coher_V2_target_cond',int2str(i),' coher_V2_target_cond',int2str(i),' roi_V2_target pixels'])
    eval(['clear coher_V2_target_cond',int2str(i)])
    %eval(['clear coher_V2_target_cond',int2str(i)])
end



cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/Path/aragon/2007_11_20/way2

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[4 3] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_flanker,1)
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
            eval(['coher_V2_flanker_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_flanker_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_flanker(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_flanker(p)));
            %eval(['coher_V2_flanker_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_flanker_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'/z;'])
    %eval(['coher_V2_flanker_cond',int2str(i),'=sqrt((coher_V2_flanker_cond',int2str(i),'-(coher_V2_flanker_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    %cd ..
    %eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    eval(['clear coher_V2_flanker_cond',int2str(i)])
    %eval(['clear coher_V2_flanker_cond',int2str(i)])
end


cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/legolas/2007_01_31

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_target,1)
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
            eval(['coher_V2_target_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_target_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_target(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_target(p)));
            %eval(['coher_V2_target_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'_t;'])
                %eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'+coher_V2_target_cond',int2str(i),'_t;'])
                %eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'+coher_V2_target_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_target_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'/z;'])
    %eval(['coher_V2_target_cond',int2str(i),'=sqrt((coher_V2_target_cond',int2str(i),'-(coher_V2_target_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_target_cond',int2str(i),' coher_V2_target_cond',int2str(i),' roi_V2_target pixels'])
    %cd ..
    %eval(['save coher_V2_target_cond',int2str(i),' coher_V2_target_cond',int2str(i),' roi_V2_target pixels'])
    eval(['clear coher_V2_target_cond',int2str(i)])
    %eval(['clear coher_V2_target_cond',int2str(i)])
end



cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/legolas/2007_01_31

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_flanker,1)
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
            eval(['coher_V2_flanker_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_flanker_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_flanker(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_flanker(p)));
            %eval(['coher_V2_flanker_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_flanker_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'/z;'])
    %eval(['coher_V2_flanker_cond',int2str(i),'=sqrt((coher_V2_flanker_cond',int2str(i),'-(coher_V2_flanker_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    %cd ..
    %eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    eval(['clear coher_V2_flanker_cond',int2str(i)])
    %eval(['clear coher_V2_flanker_cond',int2str(i)])
end



cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/legolas/2007_02_07

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_target,1)
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
            eval(['coher_V2_target_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_target_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_target(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_target(p)));
            %eval(['coher_V2_target_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'_t;'])
                %eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'+coher_V2_target_cond',int2str(i),'_t;'])
                %eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'+coher_V2_target_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_target_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'/z;'])
    %eval(['coher_V2_target_cond',int2str(i),'=sqrt((coher_V2_target_cond',int2str(i),'-(coher_V2_target_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_target_cond',int2str(i),' coher_V2_target_cond',int2str(i),' roi_V2_target pixels'])
    %cd ..
    %eval(['save coher_V2_target_cond',int2str(i),' coher_V2_target_cond',int2str(i),' roi_V2_target pixels'])
    eval(['clear coher_V2_target_cond',int2str(i)])
    %eval(['clear coher_V2_target_cond',int2str(i)])
end



cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/legolas/2007_02_07

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_flanker,1)
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
            eval(['coher_V2_flanker_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_flanker_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_flanker(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_flanker(p)));
            %eval(['coher_V2_flanker_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_flanker_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'/z;'])
    %eval(['coher_V2_flanker_cond',int2str(i),'=sqrt((coher_V2_flanker_cond',int2str(i),'-(coher_V2_flanker_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    %cd ..
    %eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    eval(['clear coher_V2_flanker_cond',int2str(i)])
    %eval(['clear coher_V2_flanker_cond',int2str(i)])
end


cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/aragon/2007_11_20

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_target,1)
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
            eval(['coher_V2_target_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_target_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_target(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_target(p)));
            %eval(['coher_V2_target_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'_t;'])
                %eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'+coher_V2_target_cond',int2str(i),'_t;'])
                %eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'+coher_V2_target_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_target_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'/z;'])
    %eval(['coher_V2_target_cond',int2str(i),'=sqrt((coher_V2_target_cond',int2str(i),'-(coher_V2_target_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_target_cond',int2str(i),' coher_V2_target_cond',int2str(i),' roi_V2_target pixels'])
    %cd ..
    %eval(['save coher_V2_target_cond',int2str(i),' coher_V2_target_cond',int2str(i),' roi_V2_target pixels'])
    eval(['clear coher_V2_target_cond',int2str(i)])
    %eval(['clear coher_V2_target_cond',int2str(i)])
end



cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/aragon/2007_11_20

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_flanker,1)
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
            eval(['coher_V2_flanker_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_flanker_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_flanker(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_flanker(p)));
            %eval(['coher_V2_flanker_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_flanker_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'/z;'])
    %eval(['coher_V2_flanker_cond',int2str(i),'=sqrt((coher_V2_flanker_cond',int2str(i),'-(coher_V2_flanker_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    %cd ..
    %eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    eval(['clear coher_V2_flanker_cond',int2str(i)])
    %eval(['clear coher_V2_flanker_cond',int2str(i)])
end

cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/Path/legolas/2007_04_18/no_stim/way2

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[4 3] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_target,1)
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
            eval(['coher_V2_target_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_target_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_target(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_target(p)));
            %eval(['coher_V2_target_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'_t;'])
                %eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'+coher_V2_target_cond',int2str(i),'_t;'])
                %eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'+coher_V2_target_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_target_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'/z;'])
    %eval(['coher_V2_target_cond',int2str(i),'=sqrt((coher_V2_target_cond',int2str(i),'-(coher_V2_target_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_target_cond',int2str(i),' coher_V2_target_cond',int2str(i),' roi_V2_target pixels'])
    %cd ..
    %eval(['save coher_V2_target_cond',int2str(i),' coher_V2_target_cond',int2str(i),' roi_V2_target pixels'])
    eval(['clear coher_V2_target_cond',int2str(i)])
    %eval(['clear coher_V2_target_cond',int2str(i)])
end




cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/Path/legolas/2007_04_18/no_stim/way2

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[4 3] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_flanker,1)
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
            eval(['coher_V2_flanker_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_flanker_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_flanker(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_flanker(p)));
            %eval(['coher_V2_flanker_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_flanker_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'/z;'])
    %eval(['coher_V2_flanker_cond',int2str(i),'=sqrt((coher_V2_flanker_cond',int2str(i),'-(coher_V2_flanker_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    %cd ..
    %eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    eval(['clear coher_V2_flanker_cond',int2str(i)])
    %eval(['clear coher_V2_flanker_cond',int2str(i)])
end


cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/Path/legolas/2007_03_12/conds_ns/way2

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[4 3] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_target,1)
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
            eval(['coher_V2_target_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_target_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_target(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_target(p)));
            %eval(['coher_V2_target_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'_t;'])
                %eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'+coher_V2_target_cond',int2str(i),'_t;'])
                %eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'+coher_V2_target_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_target_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'/z;'])
    %eval(['coher_V2_target_cond',int2str(i),'=sqrt((coher_V2_target_cond',int2str(i),'-(coher_V2_target_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_target_cond',int2str(i),' coher_V2_target_cond',int2str(i),' roi_V2_target pixels'])
    %cd ..
    %eval(['save coher_V2_target_cond',int2str(i),' coher_V2_target_cond',int2str(i),' roi_V2_target pixels'])
    eval(['clear coher_V2_target_cond',int2str(i)])
    %eval(['clear coher_V2_target_cond',int2str(i)])
end



cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/Path/legolas/2007_03_12/conds_ns/way2

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[4 3] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_flanker,1)
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
            eval(['coher_V2_flanker_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_flanker_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_flanker(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_flanker(p)));
            %eval(['coher_V2_flanker_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_flanker_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'/z;'])
    %eval(['coher_V2_flanker_cond',int2str(i),'=sqrt((coher_V2_flanker_cond',int2str(i),'-(coher_V2_flanker_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    %cd ..
    %eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    eval(['clear coher_V2_flanker_cond',int2str(i)])
    %eval(['clear coher_V2_flanker_cond',int2str(i)])
end


cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/Path/legolas/2007_05_10/b/no_stim/way2

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[4 3] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_target,1)
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
            eval(['coher_V2_target_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_target_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_target(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_target(p)));
            %eval(['coher_V2_target_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'_t;'])
                %eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'+coher_V2_target_cond',int2str(i),'_t;'])
                %eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'+coher_V2_target_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_target_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'/z;'])
    %eval(['coher_V2_target_cond',int2str(i),'=sqrt((coher_V2_target_cond',int2str(i),'-(coher_V2_target_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_target_cond',int2str(i),' coher_V2_target_cond',int2str(i),' roi_V2_target pixels'])
    %cd ..
    %eval(['save coher_V2_target_cond',int2str(i),' coher_V2_target_cond',int2str(i),' roi_V2_target pixels'])
    eval(['clear coher_V2_target_cond',int2str(i)])
    %eval(['clear coher_V2_target_cond',int2str(i)])
end



cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/Path/legolas/2007_05_10/b/no_stim/way2

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[4 3] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_flanker,1)
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
            eval(['coher_V2_flanker_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_flanker_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_flanker(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_flanker(p)));
            %eval(['coher_V2_flanker_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_flanker_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'/z;'])
    %eval(['coher_V2_flanker_cond',int2str(i),'=sqrt((coher_V2_flanker_cond',int2str(i),'-(coher_V2_flanker_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    %cd ..
    %eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    eval(['clear coher_V2_flanker_cond',int2str(i)])
    %eval(['clear coher_V2_flanker_cond',int2str(i)])
end


cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/Path/legolas/2007_05_10/e/no_stim/way2

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[4 3] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_target,1)
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
            eval(['coher_V2_target_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_target_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_target(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_target(p)));
            %eval(['coher_V2_target_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'_t;'])
                %eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'+coher_V2_target_cond',int2str(i),'_t;'])
                %eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'+coher_V2_target_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_target_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'/z;'])
    %eval(['coher_V2_target_cond',int2str(i),'=sqrt((coher_V2_target_cond',int2str(i),'-(coher_V2_target_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_target_cond',int2str(i),' coher_V2_target_cond',int2str(i),' roi_V2_target pixels'])
    %cd ..
    %eval(['save coher_V2_target_cond',int2str(i),' coher_V2_target_cond',int2str(i),' roi_V2_target pixels'])
    eval(['clear coher_V2_target_cond',int2str(i)])
    %eval(['clear coher_V2_target_cond',int2str(i)])
end



cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/Path/legolas/2007_05_10/e/no_stim/way2

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[4 3] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_flanker,1)
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
            eval(['coher_V2_flanker_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_flanker_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_flanker(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_flanker(p)));
            %eval(['coher_V2_flanker_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_flanker_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'/z;'])
    %eval(['coher_V2_flanker_cond',int2str(i),'=sqrt((coher_V2_flanker_cond',int2str(i),'-(coher_V2_flanker_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    %cd ..
    %eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    eval(['clear coher_V2_flanker_cond',int2str(i)])
    %eval(['clear coher_V2_flanker_cond',int2str(i)])
end



cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/Path/aragon/2007_11_20/no_stim/way2

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[4 3] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_target,1)
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
            eval(['coher_V2_target_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_target_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_target(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_target(p)));
            %eval(['coher_V2_target_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'_t;'])
                %eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'+coher_V2_target_cond',int2str(i),'_t;'])
                %eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'+coher_V2_target_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_target_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'/z;'])
    %eval(['coher_V2_target_cond',int2str(i),'=sqrt((coher_V2_target_cond',int2str(i),'-(coher_V2_target_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_target_cond',int2str(i),' coher_V2_target_cond',int2str(i),' roi_V2_target pixels'])
    %cd ..
    %eval(['save coher_V2_target_cond',int2str(i),' coher_V2_target_cond',int2str(i),' roi_V2_target pixels'])
    eval(['clear coher_V2_target_cond',int2str(i)])
    %eval(['clear coher_V2_target_cond',int2str(i)])
end



cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/Path/aragon/2007_11_20/no_stim/way2

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[4 3] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_flanker,1)
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
            eval(['coher_V2_flanker_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_flanker_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_flanker(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_flanker(p)));
            %eval(['coher_V2_flanker_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_flanker_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'/z;'])
    %eval(['coher_V2_flanker_cond',int2str(i),'=sqrt((coher_V2_flanker_cond',int2str(i),'-(coher_V2_flanker_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    %cd ..
    %eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    eval(['clear coher_V2_flanker_cond',int2str(i)])
    %eval(['clear coher_V2_flanker_cond',int2str(i)])
end


cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/legolas/2007_01_31/no_stim

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_target,1)
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
            eval(['coher_V2_target_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_target_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_target(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_target(p)));
            %eval(['coher_V2_target_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'_t;'])
                %eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'+coher_V2_target_cond',int2str(i),'_t;'])
                %eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'+coher_V2_target_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_target_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'/z;'])
    %eval(['coher_V2_target_cond',int2str(i),'=sqrt((coher_V2_target_cond',int2str(i),'-(coher_V2_target_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_target_cond',int2str(i),' coher_V2_target_cond',int2str(i),' roi_V2_target pixels'])
    %cd ..
    %eval(['save coher_V2_target_cond',int2str(i),' coher_V2_target_cond',int2str(i),' roi_V2_target pixels'])
    eval(['clear coher_V2_target_cond',int2str(i)])
    %eval(['clear coher_V2_target_cond',int2str(i)])
end



cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/legolas/2007_01_31/no_stim

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_flanker,1)
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
            eval(['coher_V2_flanker_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_flanker_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_flanker(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_flanker(p)));
            %eval(['coher_V2_flanker_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_flanker_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'/z;'])
    %eval(['coher_V2_flanker_cond',int2str(i),'=sqrt((coher_V2_flanker_cond',int2str(i),'-(coher_V2_flanker_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    %cd ..
    %eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    eval(['clear coher_V2_flanker_cond',int2str(i)])
    %eval(['clear coher_V2_flanker_cond',int2str(i)])
end



cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/legolas/2007_02_07/no_stim

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_target,1)
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
            eval(['coher_V2_target_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_target_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_target(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_target(p)));
            %eval(['coher_V2_target_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'_t;'])
                %eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'+coher_V2_target_cond',int2str(i),'_t;'])
                %eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'+coher_V2_target_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_target_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'/z;'])
    %eval(['coher_V2_target_cond',int2str(i),'=sqrt((coher_V2_target_cond',int2str(i),'-(coher_V2_target_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_target_cond',int2str(i),' coher_V2_target_cond',int2str(i),' roi_V2_target pixels'])
    %cd ..
    %eval(['save coher_V2_target_cond',int2str(i),' coher_V2_target_cond',int2str(i),' roi_V2_target pixels'])
    eval(['clear coher_V2_target_cond',int2str(i)])
    %eval(['clear coher_V2_target_cond',int2str(i)])
end



cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/legolas/2007_02_07/no_stim

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_flanker,1)
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
            eval(['coher_V2_flanker_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_flanker_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_flanker(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_flanker(p)));
            %eval(['coher_V2_flanker_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_flanker_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'/z;'])
    %eval(['coher_V2_flanker_cond',int2str(i),'=sqrt((coher_V2_flanker_cond',int2str(i),'-(coher_V2_flanker_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    %cd ..
    %eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    eval(['clear coher_V2_flanker_cond',int2str(i)])
    %eval(['clear coher_V2_flanker_cond',int2str(i)])
end


cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/aragon/2007_11_20/no_stim

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_target,1)
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
            eval(['coher_V2_target_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_target_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_target(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_target(p)));
            %eval(['coher_V2_target_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'_t;'])
                %eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'+coher_V2_target_cond',int2str(i),'_t;'])
                %eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'+coher_V2_target_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_target_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_target_cond',int2str(i),'=coher_V2_target_cond',int2str(i),'/z;'])
    %eval(['coher_V2_target_cond',int2str(i),'=sqrt((coher_V2_target_cond',int2str(i),'-(coher_V2_target_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_target_cond',int2str(i),' coher_V2_target_cond',int2str(i),' roi_V2_target pixels'])
    %cd ..
    %eval(['save coher_V2_target_cond',int2str(i),' coher_V2_target_cond',int2str(i),' roi_V2_target pixels'])
    eval(['clear coher_V2_target_cond',int2str(i)])
    %eval(['clear coher_V2_target_cond',int2str(i)])
end



cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/aragon/2007_11_20/no_stim

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t


load myrois_V2
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2_flanker,1)
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
            eval(['coher_V2_flanker_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_flanker_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2_flanker(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2_flanker(p)));
            %eval(['coher_V2_flanker_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t;'])
                %eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'+coher_V2_flanker_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_flanker_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_flanker_cond',int2str(i),'=coher_V2_flanker_cond',int2str(i),'/z;'])
    %eval(['coher_V2_flanker_cond',int2str(i),'=sqrt((coher_V2_flanker_cond',int2str(i),'-(coher_V2_flanker_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    %cd ..
    %eval(['save coher_V2_flanker_cond',int2str(i),' coher_V2_flanker_cond',int2str(i),' roi_V2_flanker pixels'])
    eval(['clear coher_V2_flanker_cond',int2str(i)])
    %eval(['clear coher_V2_flanker_cond',int2str(i)])
end


cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/legolas/2007_02_07/no_stim

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load 0702
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2,1)
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
            eval(['coher_V2_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2(p)));
            %eval(['coher_V2_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_cond',int2str(i),'=coher_V2_cond',int2str(i),'_t;'])
                %eval(['coher_V2_cond',int2str(i),'=coher_V2_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_cond',int2str(i),'=coher_V2_cond',int2str(i),'+coher_V2_cond',int2str(i),'_t;'])
                %eval(['coher_V2_cond',int2str(i),'=coher_V2_cond',int2str(i),'+coher_V2_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_cond',int2str(i),'=coher_V2_cond',int2str(i),'/z;'])
    %eval(['coher_V2_cond',int2str(i),'=sqrt((coher_V2_cond',int2str(i),'-(coher_V2_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_cond',int2str(i),' coher_V2_cond',int2str(i),' roi_V2 pixels'])
    %cd ..
    %eval(['save coher_V2_cond',int2str(i),' coher_V2_cond',int2str(i),' roi_V2 pixels'])
    eval(['clear coher_V2_cond',int2str(i)])
    %eval(['clear coher_V2_cond',int2str(i)])
end



cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/legolas/2007_01_31/no_stim

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load 3101
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2,1)
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
            eval(['coher_V2_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2(p)));
            %eval(['coher_V2_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_cond',int2str(i),'=coher_V2_cond',int2str(i),'_t;'])
                %eval(['coher_V2_cond',int2str(i),'=coher_V2_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_cond',int2str(i),'=coher_V2_cond',int2str(i),'+coher_V2_cond',int2str(i),'_t;'])
                %eval(['coher_V2_cond',int2str(i),'=coher_V2_cond',int2str(i),'+coher_V2_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_cond',int2str(i),'=coher_V2_cond',int2str(i),'/z;'])
    %eval(['coher_V2_cond',int2str(i),'=sqrt((coher_V2_cond',int2str(i),'-(coher_V2_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_cond',int2str(i),' coher_V2_cond',int2str(i),' roi_V2 pixels'])
    %cd ..
    %eval(['save coher_V2_cond',int2str(i),' coher_V2_cond',int2str(i),' roi_V2 pixels'])
    eval(['clear coher_V2_cond',int2str(i)])
    %eval(['clear coher_V2_cond',int2str(i)])
end


cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/aragon/2007_11_20/no_stim

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load 2011
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V2,1)
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
            eval(['coher_V2_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V2_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V2(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V2(p)));
            %eval(['coher_V2_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V2_cond',int2str(i),'=coher_V2_cond',int2str(i),'_t;'])
                %eval(['coher_V2_cond',int2str(i),'=coher_V2_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V2_cond',int2str(i),'=coher_V2_cond',int2str(i),'+coher_V2_cond',int2str(i),'_t;'])
                %eval(['coher_V2_cond',int2str(i),'=coher_V2_cond',int2str(i),'+coher_V2_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V2_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V2_cond',int2str(i),'=coher_V2_cond',int2str(i),'/z;'])
    %eval(['coher_V2_cond',int2str(i),'=sqrt((coher_V2_cond',int2str(i),'-(coher_V2_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V2_cond',int2str(i),' coher_V2_cond',int2str(i),' roi_V2 pixels'])
    %cd ..
    %eval(['save coher_V2_cond',int2str(i),' coher_V2_cond',int2str(i),' roi_V2 pixels'])
    eval(['clear coher_V2_cond',int2str(i)])
    %eval(['clear coher_V2_cond',int2str(i)])
end




cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/legolas/2007_02_07

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load 0702
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V1_2,1)
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
            eval(['coher_V1_2_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V1_2_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V1_2(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V1_2(p)));
            %eval(['coher_V1_2_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'_t;'])
                %eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'+coher_V1_2_cond',int2str(i),'_t;'])
                %eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'+coher_V1_2_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V1_2_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'/z;'])
    %eval(['coher_V1_2_cond',int2str(i),'=sqrt((coher_V1_2_cond',int2str(i),'-(coher_V1_2_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V1_2_cond',int2str(i),' coher_V1_2_cond',int2str(i),' roi_V1_2 pixels'])
    %cd ..
    %eval(['save coher_V1_2_cond',int2str(i),' coher_V1_2_cond',int2str(i),' roi_V1_2 pixels'])
    eval(['clear coher_V1_2_cond',int2str(i)])
    %eval(['clear coher_V1_2_cond',int2str(i)])
end



cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/legolas/2007_01_31

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load 3101
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V1_2,1)
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
            eval(['coher_V1_2_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V1_2_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V1_2(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V1_2(p)));
            %eval(['coher_V1_2_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'_t;'])
                %eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'+coher_V1_2_cond',int2str(i),'_t;'])
                %eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'+coher_V1_2_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V1_2_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'/z;'])
    %eval(['coher_V1_2_cond',int2str(i),'=sqrt((coher_V1_2_cond',int2str(i),'-(coher_V1_2_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V1_2_cond',int2str(i),' coher_V1_2_cond',int2str(i),' roi_V1_2 pixels'])
    %cd ..
    %eval(['save coher_V1_2_cond',int2str(i),' coher_V1_2_cond',int2str(i),' roi_V1_2 pixels'])
    eval(['clear coher_V1_2_cond',int2str(i)])
    %eval(['clear coher_V1_2_cond',int2str(i)])
end


cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/aragon/2007_11_20

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load 2011
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V1_2,1)
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
            eval(['coher_V1_2_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V1_2_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V1_2(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V1_2(p)));
            %eval(['coher_V1_2_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'_t;'])
                %eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'+coher_V1_2_cond',int2str(i),'_t;'])
                %eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'+coher_V1_2_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V1_2_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'/z;'])
    %eval(['coher_V1_2_cond',int2str(i),'=sqrt((coher_V1_2_cond',int2str(i),'-(coher_V1_2_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V1_2_cond',int2str(i),' coher_V1_2_cond',int2str(i),' roi_V1_2 pixels'])
    %cd ..
    %eval(['save coher_V1_2_cond',int2str(i),' coher_V1_2_cond',int2str(i),' roi_V1_2 pixels'])
    eval(['clear coher_V1_2_cond',int2str(i)])
    %eval(['clear coher_V1_2_cond',int2str(i)])
end



cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/legolas/2007_02_07/no_stim

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load 0702
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V1_2,1)
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
            eval(['coher_V1_2_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V1_2_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V1_2(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V1_2(p)));
            %eval(['coher_V1_2_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'_t;'])
                %eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'+coher_V1_2_cond',int2str(i),'_t;'])
                %eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'+coher_V1_2_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V1_2_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'/z;'])
    %eval(['coher_V1_2_cond',int2str(i),'=sqrt((coher_V1_2_cond',int2str(i),'-(coher_V1_2_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V1_2_cond',int2str(i),' coher_V1_2_cond',int2str(i),' roi_V1_2 pixels'])
    %cd ..
    %eval(['save coher_V1_2_cond',int2str(i),' coher_V1_2_cond',int2str(i),' roi_V1_2 pixels'])
    eval(['clear coher_V1_2_cond',int2str(i)])
    %eval(['clear coher_V1_2_cond',int2str(i)])
end



cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/legolas/2007_01_31/no_stim

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load 3101
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V1_2,1)
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
            eval(['coher_V1_2_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V1_2_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V1_2(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V1_2(p)));
            %eval(['coher_V1_2_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'_t;'])
                %eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'+coher_V1_2_cond',int2str(i),'_t;'])
                %eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'+coher_V1_2_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V1_2_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'/z;'])
    %eval(['coher_V1_2_cond',int2str(i),'=sqrt((coher_V1_2_cond',int2str(i),'-(coher_V1_2_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V1_2_cond',int2str(i),' coher_V1_2_cond',int2str(i),' roi_V1_2 pixels'])
    %cd ..
    %eval(['save coher_V1_2_cond',int2str(i),' coher_V1_2_cond',int2str(i),' roi_V1_2 pixels'])
    eval(['clear coher_V1_2_cond',int2str(i)])
    %eval(['clear coher_V1_2_cond',int2str(i)])
end


cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/aragon/2007_11_20/no_stim

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load 2011
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_V1_2,1)
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
            eval(['coher_V1_2_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V1_2_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V1_2(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V1_2(p)));
            %eval(['coher_V1_2_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'_t;'])
                %eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'+coher_V1_2_cond',int2str(i),'_t;'])
                %eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'+coher_V1_2_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V1_2_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V1_2_cond',int2str(i),'=coher_V1_2_cond',int2str(i),'/z;'])
    %eval(['coher_V1_2_cond',int2str(i),'=sqrt((coher_V1_2_cond',int2str(i),'-(coher_V1_2_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V1_2_cond',int2str(i),' coher_V1_2_cond',int2str(i),' roi_V1_2 pixels'])
    %cd ..
    %eval(['save coher_V1_2_cond',int2str(i),' coher_V1_2_cond',int2str(i),' roi_V1_2 pixels'])
    eval(['clear coher_V1_2_cond',int2str(i)])
    %eval(['clear coher_V1_2_cond',int2str(i)])
end




cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/legolas/2007_02_07

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load 0702
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
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
            eval(['coher_V1_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V1_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V1(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V1(p)));
            %eval(['coher_V1_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'_t;'])
                %eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'+coher_V1_cond',int2str(i),'_t;'])
                %eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'+coher_V1_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V1_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'/z;'])
    %eval(['coher_V1_cond',int2str(i),'=sqrt((coher_V1_cond',int2str(i),'-(coher_V1_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V1_cond',int2str(i),' coher_V1_cond',int2str(i),' roi_V1 pixels'])
    %cd ..
    %eval(['save coher_V1_cond',int2str(i),' coher_V1_cond',int2str(i),' roi_V1 pixels'])
    eval(['clear coher_V1_cond',int2str(i)])
    %eval(['clear coher_V1_cond',int2str(i)])
end



cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/legolas/2007_01_31

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load 3101
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
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
            eval(['coher_V1_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V1_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V1(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V1(p)));
            %eval(['coher_V1_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'_t;'])
                %eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'+coher_V1_cond',int2str(i),'_t;'])
                %eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'+coher_V1_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V1_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'/z;'])
    %eval(['coher_V1_cond',int2str(i),'=sqrt((coher_V1_cond',int2str(i),'-(coher_V1_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V1_cond',int2str(i),' coher_V1_cond',int2str(i),' roi_V1 pixels'])
    %cd ..
    %eval(['save coher_V1_cond',int2str(i),' coher_V1_cond',int2str(i),' roi_V1 pixels'])
    eval(['clear coher_V1_cond',int2str(i)])
    %eval(['clear coher_V1_cond',int2str(i)])
end


cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/aragon/2007_11_20

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load 2011
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
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
            eval(['coher_V1_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V1_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V1(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V1(p)));
            %eval(['coher_V1_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'_t;'])
                %eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'+coher_V1_cond',int2str(i),'_t;'])
                %eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'+coher_V1_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V1_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'/z;'])
    %eval(['coher_V1_cond',int2str(i),'=sqrt((coher_V1_cond',int2str(i),'-(coher_V1_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V1_cond',int2str(i),' coher_V1_cond',int2str(i),' roi_V1 pixels'])
    %cd ..
    %eval(['save coher_V1_cond',int2str(i),' coher_V1_cond',int2str(i),' roi_V1 pixels'])
    eval(['clear coher_V1_cond',int2str(i)])
    %eval(['clear coher_V1_cond',int2str(i)])
end



cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/legolas/2007_02_07/no_stim

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load 0702
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
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
            eval(['coher_V1_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V1_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V1(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V1(p)));
            %eval(['coher_V1_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'_t;'])
                %eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'+coher_V1_cond',int2str(i),'_t;'])
                %eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'+coher_V1_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V1_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'/z;'])
    %eval(['coher_V1_cond',int2str(i),'=sqrt((coher_V1_cond',int2str(i),'-(coher_V1_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V1_cond',int2str(i),' coher_V1_cond',int2str(i),' roi_V1 pixels'])
    %cd ..
    %eval(['save coher_V1_cond',int2str(i),' coher_V1_cond',int2str(i),' roi_V1 pixels'])
    eval(['clear coher_V1_cond',int2str(i)])
    %eval(['clear coher_V1_cond',int2str(i)])
end



cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/legolas/2007_01_31/no_stim

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load 3101
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
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
            eval(['coher_V1_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V1_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V1(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V1(p)));
            %eval(['coher_V1_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'_t;'])
                %eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'+coher_V1_cond',int2str(i),'_t;'])
                %eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'+coher_V1_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V1_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'/z;'])
    %eval(['coher_V1_cond',int2str(i),'=sqrt((coher_V1_cond',int2str(i),'-(coher_V1_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V1_cond',int2str(i),' coher_V1_cond',int2str(i),' roi_V1 pixels'])
    %cd ..
    %eval(['save coher_V1_cond',int2str(i),' coher_V1_cond',int2str(i),' roi_V1 pixels'])
    eval(['clear coher_V1_cond',int2str(i)])
    %eval(['clear coher_V1_cond',int2str(i)])
end


cd /fat1/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/coVnon/aragon/2007_11_20/no_stim

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t




load 2011
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_dip = choose_polygon(100);

NFFT = 64;
win=16;
for i=[2 4] %condition count
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
            eval(['coher_V1_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['coher_V1_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V1(p))).*conj(f(:,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_V1(p)));
            %eval(['coher_V1_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'_t;'])
                %eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'_t.^2;'])
            else
                eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'+coher_V1_cond',int2str(i),'_t;'])
                %eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'+coher_V1_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear coher_V1_cond',int2str(i),'_t'])
        end;
    end;
    eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'/z;'])
    %eval(['coher_V1_cond',int2str(i),'=sqrt((coher_V1_cond',int2str(i),'-(coher_V1_cond',int2str(i),'.^2)*z)/(z-1));'])
    %cd regNFFT
    eval(['save coher_V1_cond',int2str(i),' coher_V1_cond',int2str(i),' roi_V1 pixels'])
    %cd ..
    %eval(['save coher_V1_cond',int2str(i),' coher_V1_cond',int2str(i),' roi_V1 pixels'])
    eval(['clear coher_V1_cond',int2str(i)])
    %eval(['clear coher_V1_cond',int2str(i)])
end








