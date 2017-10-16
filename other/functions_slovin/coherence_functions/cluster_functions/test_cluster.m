load 1111
a=size(roi_tar,1);
tic
for p=1:a
    pp=int2str(roi_tar(p));
    disp(p)
    tic
    for l=0:159
        k=int2str(l);
        coherence_vsdi_cond1(pp,'1','1111',k);
        cd ..
    end
    toc
    unite_data_cond1_V1(pp,'1','1111')
    
end
unite_pixels('tar','1','1111');
toc