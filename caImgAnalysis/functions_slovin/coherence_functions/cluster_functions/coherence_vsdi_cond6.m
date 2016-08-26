function coherence_vsdi_cond6(s)

load(s)

% calculate coherogram

%s = pixels_to_remove roi_V1 roi_V2 roi_V4
% load pixels_to_remove

t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

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
for i=6 %condition count
    eval(['load cond',int2str(i),'n_dt_hb'])
    eval(['a=size(cond',int2str(i),'n_dt_hb,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_hb,2);'])
    for p=1:size(roi_V1,1)
        for h=1:a  %trial count
            disp(['condition #',int2str(i),'trial #',int2str(h),' transforming data'])
            eval(['load cond',int2str(i),'n_dt_hb'])
            eval(['cond',int2str(i),'n_dt_hb=cond',int2str(i),'n_dt_hb(:,2:end,h);'])
            f=NaN*ones(NFFT/2,b-win,10000);
            data_win=zeros(size(pixels,1),32);
                for j=1:(b-win) 
                    w=hamming(win).';
                    %w=hanning(win).';
                    eval(['data_win=w(ones(1,size(pixels,1)),:).*(cond',int2str(i),'n_dt_hb(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_hb(pixels,j:j+win-1),2),[1,win]));'])
                    y=fft(data_win.',NFFT);
                    y=y./win;
                    y = y(2:NFFT/2+1,:);
                    %Pxx=2/0.375*abs(y).^2;
                    f(:,j,pixels)=y;
                end;
            
            eval(['clear cond',int2str(i),'n_dt_hb'])
            k=0;
            l=0;
            disp(['condition #',int2str(i),'trial #',int2str(h),' calculating coherence'])
        
            k=k+1;
            eval(['coher_V1_',int2str(roi_V1(p)),'=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            c=[roi_V2;roi_V4];
            for pp=1:size(pixels,1)
                l=l+1;
                disp(['coherence of pixel #',int2str(roi_V1(p)),' vs. pixel #',int2str(pixels(pp))])
                eval(['coher_V1_',int2str(roi_V1(p)),'(l,:,:)=f(:,:,roi_V1(p)).*conj(f(:,:,pixels(pp)))./sqrt(abs(f(:,:,roi_V1(p))).^2.*abs(f(:,:,pixels(pp))).^2);'])
            end;
        
            if h==1
                eval(['coher_V1_ave_pix_',int2str(roi_V1(p)),'=coher_V1_',int2str(roi_V1(p)),';'])
            else
                eval(['coher_V1_ave_pix_',int2str(roi_V1(p)),'=coher_V1_ave_pix_',int2str(roi_V1(p)),'+coher_V1_',int2str(roi_V1(p)),';'])
            end
            eval(['clear coher_V1_',int2str(roi_V1(p))])
        end;
        eval(['coher_V1_ave_pix_',int2str(roi_V1(p)),'=coher_V1_ave_pix_',int2str(roi_V1(p)),'/h;'])
        eval(['save ',s,'coher_V1_cond',int2str(i),'_pix_',int2str(roi_V1(p)),' coher_V1_ave_pix_',int2str(roi_V1(p)),' roi_V1 pixels'])
        eval(['clear coher_V1_ave_pix_',int2str(roi_V1(p))])
    end;
end