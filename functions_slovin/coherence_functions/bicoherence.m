cd /fat2/Ariel_Gilad/Matlab_analysis/experiments/mask/legolas/right_hemisphere/06_01_2009/fg

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t



perm=6;
load 0601

NFFT = 64;
win=16;
for i=[1 4 3 2 5]%condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['a=size(cond',int2str(i),'n_dt_bl,3);'])    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_dip,1)
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
            disp(['condition #',int2str(i),'trial #',int2str(h),' calculating bicrossence'])
            eval(['bicross_dip_cond',int2str(i),'_t=NaN*ones(size(pixels,1),13,b-win);'])
            
            for pp=1:size(pixels,1)
                l=l+1;
                q=circshift(f(:,:,pp),-perm);
                eval(['bicross_dip_cond',int2str(i),'_t(l,1:13,:)=f(1:13,:,find(pixels==roi_dip(p))).*q(1:13,:).*conj(f(8:2:end,:,pp));'])
            end;
            clear f
            %t=f(:,:,find(pixels==roi_dip(p)));
            %eval(['bicross_dip_cond',int2str(i),'_t=t(:,:,ones(1,size(pixels,1))).*conj(f)./sqrt(abs(t(:,:,ones(1,size(pixels,1)))).^2.*abs(f).^2);'])
            if z==1
                eval(['bicross_dip_cond',int2str(i),'=bicross_dip_cond',int2str(i),'_t;'])
                %eval(['bicross_dip_cond',int2str(i),'=bicross_dip_cond',int2str(i),'_t.^2;'])
            else
                eval(['bicross_dip_cond',int2str(i),'=bicross_dip_cond',int2str(i),'+bicross_dip_cond',int2str(i),'_t;'])
                %eval(['bicross_dip_cond',int2str(i),'=bicross_dip_cond',int2str(i),'+bicross_dip_cond',int2str(i),'_t.^2;'])
            end
            eval(['clear bicross_dip_cond',int2str(i),'_t'])
        end;
    end;
    eval(['bicross_dip_cond',int2str(i),'=bicross_dip_cond',int2str(i),'/z;'])
    %eval(['bicross_dip_cond',int2str(i),'=sqrt((bicross_dip_cond',int2str(i),'-(bicross_dip_cond',int2str(i),'.^2)*z)/(z-1));'])
    eval(['save bicross_dip_cond',int2str(i),' bicross_dip_cond',int2str(i),' roi_dip pixels perm'])
    %eval(['save bicross_dip_cond',int2str(i),' bicross_dip_cond',int2str(i),' roi_dip pixels'])
    eval(['clear bicross_dip_cond',int2str(i)])
    %eval(['clear bicross_dip_cond',int2str(i)])
end









