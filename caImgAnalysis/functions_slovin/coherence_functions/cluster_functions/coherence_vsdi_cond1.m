function coherence_vsdi_cond1(p,i,date,l)


cd /home/ariel/data/1111c
load pixels_to_remove

p = str2double(p);
i = str2double(i);
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
eval(['mkdir ',date,'cond',int2str(i),'_pix',int2str(p),'_',int2str(ll)])
c = dir(['cond',int2str(i),'n_dt_hb_trial_*']);
a=size(c,1);
clear c
for pp = comb_loop(ll,1):comb_loop(ll,2)
    z=pixels(pp);
    for h=1:a  %trial count
        eval(['load cond',int2str(i),'n_dt_hb_trial_',int2str(h)])
        eval(['b=size(cond',int2str(i),'n_dt_hb_trial_',int2str(h),'/2,2);'])
        eval(['cond',int2str(i),'n_dt_hb_trial_',int2str(h),'=cond',int2str(i),'n_dt_hb_trial_',int2str(h),'([p pixels(pp)],2:end);'])
        f=zeros(NFFT/2,b-win,2);
        data_win=zeros(2,win);
        for j=1:(b-win)
            w=hamming(win).';
            %w=hanning(win).';
            eval(['data_win=w(ones(1,2),:).*(cond',int2str(i),'n_dt_hb_trial_',int2str(h),'(:,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_hb_trial_',int2str(h),'(:,j:j+win-1),2),[1,win]));'])
            y=fft(data_win.',NFFT);
            y=y./win;
            y = y(2:NFFT/2+1,:);
            %Pxx=2/0.375*abs(y).^2;
            f(:,j,:)=y;
        end;     
        eval(['clear cond',int2str(i),'n_dt_hb_trial_',int2str(h)])        
        eval(['coher_pix_',int2str(p),'=NaN*ones(NFFT/2,b-win);'])
        eval(['coher_pix_',int2str(p),'=f(:,:,1).*conj(f(:,:,2));'])
        clear f;
        if h==1
            eval(['coher_ave_cond',int2str(i),'pix_',int2str(p),'_pix_',int2str(z),'=coher_pix_',int2str(p),';'])
            %eval(['coher_ave_std_cond',int2str(i),'pix_',int2str(p),'_pix_',int2str(z),'=coher_pix_',int2str(p),'.^2;'])
        else
            eval(['coher_ave_cond',int2str(i),'pix_',int2str(p),'_pix_',int2str(z),'=coher_ave_cond',int2str(i),'pix_',int2str(p),'_pix_',int2str(z),'+coher_pix_',int2str(p),';'])
            %eval(['coher_ave_std_cond',int2str(i),'pix_',int2str(p),'_pix_',int2str(z),'=coher_ave_std_cond',int2str(i),'pix_',int2str(p),'_pix_',int2str(z),'+coher_pix_',int2str(p),'.^2;'])
        end
        eval(['clear coher_pix_',int2str(p)])
    end
    eval(['coher_ave_cond',int2str(i),'pix_',int2str(p),'_pix_',int2str(z),'=coher_ave_cond',int2str(i),'pix_',int2str(p),'_pix_',int2str(z),'/h;'])
    %eval(['coher_ave_std_cond',int2str(i),'pix_',int2str(p),'_pix_',int2str(z),'=sqrt((coher_ave_std_cond',int2str(i),'pix_',int2str(p),'_pix_',int2str(z),'-(coher_ave_cond',int2str(i),'pix_',int2str(p),'_pix_',int2str(z),')*h)/(h-1));'])
    eval(['cd ',date,'cond',int2str(i),'_pix',int2str(p),'_',int2str(ll)])
    eval(['save ',date,'coher_cond',int2str(i),'_pix_',int2str(p),'_pix_',int2str(z),' coher_ave_cond',int2str(i),'pix_',int2str(p),'_pix_',int2str(z),' pixels'])
    %eval(['save ',date,'coher_std_cond',int2str(i),'_pix_',int2str(p),'_pix_',int2str(z),' coher_ave_std_cond',int2str(i),'pix_',int2str(p),'_pix_',int2str(z),' pixels'])
    cd ..
    eval(['clear coher_ave_cond',int2str(i),'pix_',int2str(p),'_pix_',int2str(z)])
    %eval(['clear coher_ave_std_cond',int2str(i),'pix_',int2str(p),'_pix_',int2str(z)])
end;

eval(['cd ',date,'cond',int2str(i),'_pix',int2str(p),'_',int2str(ll)])
e=0;
for pp = comb_loop(ll,1):comb_loop(ll,2)
    e=e+1;
    z=pixels(pp);
    eval(['load ',date,'coher_cond',int2str(i),'_pix_',int2str(p),'_pix_',int2str(z)])
    if e==1
        eval(['coher_cond',int2str(i),'_pix_',int2str(p),'_',int2str(ll),'=coher_ave_cond',int2str(i),'pix_',int2str(p),'_pix_',int2str(z),';'])
    else
        eval(['coher_cond',int2str(i),'_pix_',int2str(p),'_',int2str(ll),'=cat(3,coher_cond',int2str(i),'_pix_',int2str(p),'_',int2str(ll),',coher_ave_cond',int2str(i),'pix_',int2str(p),'_pix_',int2str(z),');'])
    end
    eval(['clear coher_ave_cond',int2str(i),'pix_',int2str(p),'_pix_',int2str(z)])
    eval(['delete ',date,'coher_cond',int2str(i),'_pix_',int2str(p),'_pix_',int2str(z),'.mat'])
end;
eval(['coher_cond',int2str(i),'_pix_',int2str(p),'_',int2str(ll),'=coher_cond',int2str(i),'_pix_',int2str(p),'_',int2str(ll),'/e;'])
eval(['save coher_cond',int2str(i),'_pix_',int2str(p),'_',int2str(ll),' coher_cond',int2str(i),'_pix_',int2str(p),'_',int2str(ll),' pixels ll'])
clear all
    



