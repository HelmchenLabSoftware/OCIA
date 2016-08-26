function coherence_vsdi_cond1(s,p,l)
% p is the pixel index
load(s)
ll = str2double(l)+1;
process_total = 160;
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t
%--------------------------------------------------------------------------
number_of_loops = floor(size(pixels,1)/process_total);
r = rem(size(pixels,1),process_total);
comb_loop = zeros(process_total,2);
for n = 1:process_total
    comb_loop(n,1) = number_of_loops*(n-1)+1;
    comb_loop(n,2) = number_of_loops*(n);
end
comb_loop(process_total,2) = comb_loop(process_total,2)+r;

NFFT = 64;
win=32;
i=1; %condition count
eval(['load cond',int2str(i),'n_dt_hb'])
eval(['a=size(cond',int2str(i),'n_dt_hb,3);'])
eval(['b=size(cond',int2str(i),'n_dt_hb,2);'])
for pp = comb_loop(ll,1):comb_loop(ll,2)
    for h=1:a  %trial count
        disp(['condition #',int2str(i),'trial #',int2str(h),' transforming data'])
        eval(['load cond',int2str(i),'n_dt_hb'])
        eval(['cond',int2str(i),'n_dt_hb=cond',int2str(i),'n_dt_hb([roi_V1(p) pixels(pp)],2:end,h);'])
        f=zeros(NFFT/2,b-win,2);
        data_win=zeros(2,32);
        for j=1:(b-win)
            w=hamming(win).';
            %w=hanning(win).';
            eval(['data_win=w(ones(1,2),:).*(cond',int2str(i),'n_dt_hb(:,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_hb(:,j:j+win-1),2),[1,win]));'])
            y=fft(data_win.',NFFT);
            y=y./win;
            y = y(2:NFFT/2+1,:);
            %Pxx=2/0.375*abs(y).^2;
            f(:,j,:)=y;
        end;
        eval(['clear cond',int2str(i),'n_dt_hb'])
        disp(['condition #',int2str(i),'trial #',int2str(h),' calculating coherence'])
        eval(['coher_V1_',int2str(roi_V1(p)),'=NaN*ones(NFFT/2,b-win);'])
        eval(['coher_V1_',int2str(roi_V1(p)),'=f(:,:,1).*conj(f(:,:,2))./sqrt(abs(f(:,:,1)).^2.*abs(f(:,:,2)).^2);'])
        clear f;
        if h==1
            eval(['coher_V1_ave_pix_',int2str(roi_V1(p)),'=coher_V1_',int2str(roi_V1(p)),';'])
        else
            eval(['coher_V1_ave_pix_',int2str(roi_V1(p)),'=coher_V1_ave_pix_',int2str(roi_V1(p)),'+coher_V1_',int2str(roi_V1(p)),';'])
        end
        eval(['clear coher_V1_',int2str(roi_V1(p))])
    end;
    eval(['coher_V1_ave_pix_',int2str(roi_V1(p)),'=coher_V1_ave_pix_',int2str(roi_V1(p)),'/h;'])
    eval(['save ',s,'coher_V1_cond',int2str(i),'_pix_',int2str(roi_V1(p)),'_pix_',int2str(pixels(pp)),' coher_V1_ave_pix_',int2str(roi_V1(p)),' roi_V1 pixels'])
    eval(['clear coher_V1_ave_pix_',int2str(roi_V1(p))])
end;




