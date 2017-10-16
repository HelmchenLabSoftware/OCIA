


cd /fat/Ariel/matlab_analysis/vsdi/vsdi_coVnon_path/Path/legolas/2007_04_18/way2

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t



NFFT = 64;
win=16;
for i=[4 3 6] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    
        for h=1:a  %trial count 
            z=z+1;
            disp(['condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_bl=cond',int2str(i),'n_dt_bl(:,2:end,h);'])
            fff=NaN*ones(NFFT/2,b-win,size(pixels,1));
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_bl(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    fff(:,j,:)=y;                
                end;
            eval(['clear cond',int2str(i),'n_dt_bl'])
            l=0;
            %t=f(:,:,find(pixels==roi_V1(p)));
            %eval(['coher_V1_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['fourier_cond',int2str(i),'=fff;'])
                %eval(['fourier_std_cond',int2str(i),'=fff.^2;'])
            else
                eval(['fourier_cond',int2str(i),'=fourier_cond',int2str(i),'+fff;'])
                %eval(['fourier_std_cond',int2str(i),'=fourier_std_cond',int2str(i),'+fff.^2;'])
            end
            clear fff
        end;
    
    eval(['fourier_cond',int2str(i),'=fourier_cond',int2str(i),'/z;'])
    %eval(['fourier_std_cond',int2str(i),'=sqrt((fourier_std_cond',int2str(i),'-(fourier_cond',int2str(i),'.^2)*z)/(z-1));'])
    eval(['save fourier_cond',int2str(i),' fourier_cond',int2str(i),' pixels'])
    %eval(['save fourier_std_cond',int2str(i),' fourier_std_cond',int2str(i),' pixels'])
    eval(['clear fourier_cond',int2str(i)])
    %eval(['clear fourier_std_cond',int2str(i)])
end;
