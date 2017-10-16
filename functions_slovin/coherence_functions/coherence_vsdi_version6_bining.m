cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/test/1804/bining/way3


load pixels


load roi_V1
%load cond1n_dt_bl
%frames=50:100;
%figure(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_V1 = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_V1 = choose_polygon(100);
%mimg(mean(mean(cond1n_dt_bl(:,frames,:),2),3)-1,100,100,-0.5e-3,1.5e-3);colormap(mapgeog);
%roi_V1 = choose_polygon(100);


pix=2500;


NFFT = 64;
win=16;
for i=[4 3 2 6]%condition count
    z=0;
    w=0;
    q=0;
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
            eval(['cross_V1_cond',int2str(i),'_t=NaN*ones(size(pixels,1),NFFT/2,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                eval(['cross_V1_cond',int2str(i),'_t(l,:,:)=f(:,:,find(pixels==roi_V1(p))).*conj(f(:,:,pp));'])
            end;
            Pxx=abs(f).^2;
            clear f
            if z==1
                eval(['power_cond',int2str(i),'=Pxx;'])
            else
                eval(['power_cond',int2str(i),'=power_cond',int2str(i),'+Pxx;'])
            end
            clear Pxx
            if z==1
                eval(['cross_V1_cond',int2str(i),'=cross_V1_cond',int2str(i),'_t;'])
            else
                eval(['cross_V1_cond',int2str(i),'=cross_V1_cond',int2str(i),'+cross_V1_cond',int2str(i),'_t;'])
            end
            eval(['clear cross_V1_cond',int2str(i),'_t'])
        end;
    eval(['cross_V1_cond',int2str(i),'=cross_V1_cond',int2str(i),'/z;'])
    eval(['power_cond',int2str(i),'=power_cond',int2str(i),'/z;'])
    v=zeros(32,112,pix);
    eval(['v(:,:,pixels)=power_cond',int2str(i),';'])
    eval(['clear power_cond',int2str(i)])
    v=shiftdim(v,2);
    e=zeros(pix,32,112);
    eval(['e(pixels,:,:)=cross_V1_cond',int2str(i),';'])
    eval(['clear cross_V1_cond',int2str(i)])
    
   
    z=0;
    q=q+1;
    if q==1
       eval(['coher_V1_cond',int2str(i),'=abs(e).^2./(v.*repmat(v(roi_V1(p),:,:),[pix 1 1]));'])
    else
       eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'+abs(e).^2./(v.*repmat(v(roi_V1(p),:,:),[pix 1 1]));'])
    end
    clear e
    clear v
    end;
    eval(['coher_V1_cond',int2str(i),'=coher_V1_cond',int2str(i),'/q;'])
    eval(['save coher_V1_cond',int2str(i),' coher_V1_cond',int2str(i),' roi_V1 pixels'])
    eval(['clear coher_V1_cond',int2str(i)])
end

