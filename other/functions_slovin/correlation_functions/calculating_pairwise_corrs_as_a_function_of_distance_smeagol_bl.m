
tc=2;
tb=5:6;
t=1:2;

%% 1711b

cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\b\pixelwise

load coeff_bg_in_circle_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_cond3(:,:,t),3);
clear coeff_bg_in_circle_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_circle_cond3
coeff_circ_cond3=mean(coeff_circle_cond3(:,:,tc),3);
clear coeff_circle_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,tb),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg


%% 1711c

cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\c\pixelwise
lim=-0.25:0.025:0.25;

load coeff_bg_in_circle_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_cond3(:,:,t),3);
clear coeff_bg_in_circle_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_circle_cond3
coeff_circ_cond3=mean(coeff_circle_cond3(:,:,tc),3);
clear coeff_circle_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,tb),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg



%% 1711g

cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\g\pixelwise
load coeff_bg_in_circle_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_cond3(:,:,t),3);
clear coeff_bg_in_circle_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_circle_cond3
coeff_circ_cond3=mean(coeff_circle_cond3(:,:,tc),3);
clear coeff_circle_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,tb),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg


%% 2411b

cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\b\pixelwise
load coeff_bg_in_circle_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_cond3(:,:,t),3);
clear coeff_bg_in_circle_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_circle_cond3
coeff_circ_cond3=mean(coeff_circle_cond3(:,:,tc),3);
clear coeff_circle_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,tb),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg



%% 2411d

cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\d\pixelwise
lim=-0.25:0.025:0.25;

load coeff_bg_in_circle_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_cond3(:,:,t),3);
clear coeff_bg_in_circle_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_circle_cond3
coeff_circ_cond3=mean(coeff_circle_cond3(:,:,tc),3);
clear coeff_circle_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,tb),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg



%% 2411f

cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\f\pixelwise
load coeff_bg_in_circle_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_cond3(:,:,t),3);
clear coeff_bg_in_circle_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_circle_cond3
coeff_circ_cond3=mean(coeff_circle_cond3(:,:,tc),3);
clear coeff_circle_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,tb),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg


%% 1412b

cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\b\pixelwise
lim=-0.25:0.025:0.25;

load coeff_bg_in_circle_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_cond3(:,:,t),3);
clear coeff_bg_in_circle_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_circle_cond3
coeff_circ_cond3=mean(coeff_circle_cond3(:,:,tc),3);
clear coeff_circle_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,tb),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg



%% 1412c

cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\c\pixelwise
load coeff_bg_in_circle_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_cond3(:,:,t),3);
clear coeff_bg_in_circle_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_circle_cond3
coeff_circ_cond3=mean(coeff_circle_cond3(:,:,tc),3);
clear coeff_circle_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,tb),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg



%% 1412d

cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\d\pixelwise
load coeff_bg_in_circle_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_cond3(:,:,t),3);
clear coeff_bg_in_circle_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_circle_cond3
coeff_circ_cond3=mean(coeff_circle_cond3(:,:,tc),3);
clear coeff_circle_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,tb),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg



%% 1412e

cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\e\pixelwise
load coeff_bg_in_circle_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_cond3(:,:,t),3);
clear coeff_bg_in_circle_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_circle_cond3
coeff_circ_cond3=mean(coeff_circle_cond3(:,:,tc),3);
clear coeff_circle_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,tb),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg



%% 2212b

cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\b\pixelwise
load coeff_bg_in_circle_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_cond3(:,:,t),3);
clear coeff_bg_in_circle_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_circle_cond3
coeff_circ_cond3=mean(coeff_circle_cond3(:,:,tc),3);
clear coeff_circle_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,tb),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg


%% 2212c

cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\c\pixelwise
load coeff_bg_in_circle_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_cond3(:,:,t),3);
clear coeff_bg_in_circle_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_circle_cond3
coeff_circ_cond3=mean(coeff_circle_cond3(:,:,tc),3);
clear coeff_circle_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,tb),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg


%% 2212d

cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\d\pixelwise
load coeff_bg_in_circle_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_cond3(:,:,t),3);
clear coeff_bg_in_circle_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_circle_cond3
coeff_circ_cond3=mean(coeff_circle_cond3(:,:,tc),3);
clear coeff_circle_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,tb),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg



%% 2912b

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\b\pixelwise
load coeff_bg_in_circle_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_cond3(:,:,t),3);
clear coeff_bg_in_circle_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_circle_cond3
coeff_circ_cond3=mean(coeff_circle_cond3(:,:,tc),3);
clear coeff_circle_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,tb),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg




%% 2912d

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\d\pixelwise
load coeff_bg_in_circle_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_cond3(:,:,t),3);
clear coeff_bg_in_circle_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_circle_cond3
coeff_circ_cond3=mean(coeff_circle_cond3(:,:,tc),3);
clear coeff_circle_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,tb),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg



%% 0501e

cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\e\pixelwise
load coeff_bg_in_circle_cond3
coeff_bg_circ_cond3=mean(coeff_bg_in_circle_cond3(:,:,t),3);
clear coeff_bg_in_circle_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_circle_cond3
coeff_circ_cond3=mean(coeff_circle_cond3(:,:,tc),3);
clear coeff_circle_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_in_cond3
coeff_bg_cond3=mean(coeff_bg_in_cond3(:,:,tb),3);
clear coeff_bg_in_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg



%% 2912k

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\k\pixelwise
load coeff_bg_out_circle_cond3
coeff_bg_circ_cond3=mean(coeff_bg_out_circle_cond3(:,:,t),3);
clear coeff_bg_out_circle_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_circle_cond3
coeff_circ_cond3=mean(coeff_circle_cond3(:,:,tc),3);
clear coeff_circle_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_out_cond3
coeff_bg_cond3=mean(coeff_bg_out_cond3(:,:,tb),3);
clear coeff_bg_out_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg



%% 0501b

cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\b\pixelwise
load coeff_bg_out_circle_cond3
coeff_bg_circ_cond3=mean(coeff_bg_out_circle_cond3(:,:,t),3);
clear coeff_bg_out_circle_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_circle_cond3
coeff_circ_cond3=mean(coeff_circle_cond3(:,:,tc),3);
clear coeff_circle_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_out_cond3
coeff_bg_cond3=mean(coeff_bg_out_cond3(:,:,tb),3);
clear coeff_bg_out_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg






%% 0501c

cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\c\pixelwise
load coeff_bg_out_circle_cond3
coeff_bg_circ_cond3=mean(coeff_bg_out_circle_cond3(:,:,t),3);
clear coeff_bg_out_circle_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_circle_cond3
coeff_circ_cond3=mean(coeff_circle_cond3(:,:,tc),3);
clear coeff_circle_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_out_cond3
coeff_bg_cond3=mean(coeff_bg_out_cond3(:,:,tb),3);
clear coeff_bg_out_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg



%% 0501d

cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\d\pixelwise
load coeff_bg_out_circle_cond3
coeff_bg_circ_cond3=mean(coeff_bg_out_circle_cond3(:,:,t),3);
clear coeff_bg_out_circle_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_circle_cond3
coeff_circ_cond3=mean(coeff_circle_cond3(:,:,tc),3);
clear coeff_circle_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_out_cond3
coeff_bg_cond3=mean(coeff_bg_out_cond3(:,:,tb),3);
clear coeff_bg_out_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg


%% 2912c

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c\pixelwise

load coeff_bg_out_circle_cond3
coeff_bg_circ_cond3=mean(coeff_bg_out_circle_cond3(:,:,t),3);
clear coeff_bg_out_circle_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_circle_cond3
coeff_circ_cond3=mean(coeff_circle_cond3(:,:,tc),3);
clear coeff_circle_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_out_cond3
coeff_bg_cond3=mean(coeff_bg_out_cond3(:,:,tb),3);
clear coeff_bg_out_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg


%% 2912e

cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\e\pixelwise

load coeff_bg_out_circle_cond3
coeff_bg_circ_cond3=mean(coeff_bg_out_circle_cond3(:,:,t),3);
clear coeff_bg_out_circle_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_circle_cond3
coeff_circ_cond3=mean(coeff_circle_cond3(:,:,tc),3);
clear coeff_circle_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_bg_out_cond3
coeff_bg_cond3=mean(coeff_bg_out_cond3(:,:,tb),3);
clear coeff_bg_out_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


save corr_bg_circ_bl bl_bg_circ
save corr_circ_circ_bl bl_circ_circ
save corr_bg_bg_bl bl_bg_bg




