

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008
load movie_for_hamutal_3apr2013
temp=cat(2,con2(:,20:35),repmat(con2(:,36),1,12),con2(:,36:52),repmat(con2(:,52),1,12));
y=mfilt2(temp-1,100,100,2,'lm');
y(pixels_to_remove,:)=10;
%figure;mimg(y,100,100,.4e-3,1.4e-3);colormap(mapgeog)
x1=(10:10:2560)-280;
x=cat(2,x1(20:35),repmat(x1(36),1,12),x1(36:52),repmat(x1(52),1,12));
[M] = mat2movie_for_hamutal_03apr2013(y, 100, 100, .4e-3, 1.4e-3, mapgeog, 1, 57, x);
movie2avi(M,'contour_condition_movie_no_gabors2','compression','none','quality',100,'fps',4);












