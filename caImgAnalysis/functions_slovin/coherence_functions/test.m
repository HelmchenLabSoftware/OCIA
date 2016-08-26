       for p=1:size(roi_V1,1)
            k=k+1;
            coher_V1=NaN*ones(size(roi_V1,1),size(roi_V2,1)+size(roi_V4,1),NFFT/2,b-win);
            c=[roi_V2;roi_V4];
            for pp=1:size(c,1)
                disp(k)
                l=l+1;
                coher_V1(k,l,:,:)=f(:,:,roi_V1(p)).*conj(f(:,:,c(pp)))./sqrt(abs(f(:,:,roi_V1(p))).^2.*abs(f(:,:,c(pp))).^2);
            end;
        end;
        if h==1
            coher_V1_ave=coher_V1;
        else
            coher_V1_ave=coher_V1_ave+coher_V1;
        end
        clear coher_V1