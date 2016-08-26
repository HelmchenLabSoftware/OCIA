% creating some ave matrices

lowgamma_4=zeros(626,6);
lowgamma_4(:,1)=mean(lowgamma_4_b1402(1:626,:),2);
lowgamma_4(:,2)=mean(lowgamma_4_c1402(1:626,:),2);
lowgamma_4(:,3)=mean(lowgamma_4_b0702(1:626,:),2);
lowgamma_4(:,4)=mean(lowgamma_4_c0702(1:626,:),2);
lowgamma_4(:,5)=mean(lowgamma_4_d0702(1:626,:),2);
lowgamma_4(:,6)=mean(lowgamma_4_b1601(1:626,:),2);

lowgamma_3=zeros(626,6);
lowgamma_3(:,1)=mean(lowgamma_3_b1402(1:626,:),2);
lowgamma_3(:,2)=mean(lowgamma_3_c1402(1:626,:),2);
lowgamma_3(:,3)=mean(lowgamma_3_b0702(1:626,:),2);
lowgamma_3(:,4)=mean(lowgamma_3_c0702(1:626,:),2);
lowgamma_3(:,5)=mean(lowgamma_3_d0702(1:626,:),2);
lowgamma_3(:,6)=mean(lowgamma_3_b1601(1:626,:),2);

lowgamma_6=zeros(626,6);
lowgamma_6(:,1)=mean(lowgamma_6_b1402(1:626,:),2);
lowgamma_6(:,2)=mean(lowgamma_6_c1402(1:626,:),2);
lowgamma_6(:,3)=mean(lowgamma_6_b0702(1:626,:),2);
lowgamma_6(:,4)=mean(lowgamma_6_c0702(1:626,:),2);
lowgamma_6(:,5)=mean(lowgamma_6_d0702(1:626,:),2);
lowgamma_6(:,6)=mean(lowgamma_6_b1601(1:626,:),2);





highgamma_4=zeros(626,6);
highgamma_4(:,1)=mean(highgamma_4_b1402(1:626,:),2);
highgamma_4(:,2)=mean(highgamma_4_c1402(1:626,:),2);
highgamma_4(:,3)=mean(highgamma_4_b0702(1:626,:),2);
highgamma_4(:,4)=mean(highgamma_4_c0702(1:626,:),2);
highgamma_4(:,5)=mean(highgamma_4_d0702(1:626,:),2);
highgamma_4(:,6)=mean(highgamma_4_b1601(1:626,:),2);

highgamma_3=zeros(626,6);
highgamma_3(:,1)=mean(highgamma_3_b1402(1:626,:),2);
highgamma_3(:,2)=mean(highgamma_3_c1402(1:626,:),2);
highgamma_3(:,3)=mean(highgamma_3_b0702(1:626,:),2);
highgamma_3(:,4)=mean(highgamma_3_c0702(1:626,:),2);
highgamma_3(:,5)=mean(highgamma_3_d0702(1:626,:),2);
highgamma_3(:,6)=mean(highgamma_3_b1601(1:626,:),2);

highgamma_6=zeros(626,6);
highgamma_6(:,1)=mean(highgamma_6_b1402(1:626,:),2);
highgamma_6(:,2)=mean(highgamma_6_c1402(1:626,:),2);
highgamma_6(:,3)=mean(highgamma_6_b0702(1:626,:),2);
highgamma_6(:,4)=mean(highgamma_6_c0702(1:626,:),2);
highgamma_6(:,5)=mean(highgamma_6_d0702(1:626,:),2);
highgamma_6(:,6)=mean(highgamma_6_b1601(1:626,:),2);




beta_4=zeros(626,6);
beta_4(:,1)=mean(beta_4_b1402(1:626,:),2);
beta_4(:,2)=mean(beta_4_c1402(1:626,:),2);
beta_4(:,3)=mean(beta_4_b0702(1:626,:),2);
beta_4(:,4)=mean(beta_4_c0702(1:626,:),2);
beta_4(:,5)=mean(beta_4_d0702(1:626,:),2);
beta_4(:,6)=mean(beta_4_b1601(1:626,:),2);

beta_3=zeros(626,6);
beta_3(:,1)=mean(beta_3_b1402(1:626,:),2);
beta_3(:,2)=mean(beta_3_c1402(1:626,:),2);
beta_3(:,3)=mean(beta_3_b0702(1:626,:),2);
beta_3(:,4)=mean(beta_3_c0702(1:626,:),2);
beta_3(:,5)=mean(beta_3_d0702(1:626,:),2);
beta_3(:,6)=mean(beta_3_b1601(1:626,:),2);

beta_6=zeros(626,6);
beta_6(:,1)=mean(beta_6_b1402(1:626,:),2);
beta_6(:,2)=mean(beta_6_c1402(1:626,:),2);
beta_6(:,3)=mean(beta_6_b0702(1:626,:),2);
beta_6(:,4)=mean(beta_6_c0702(1:626,:),2);
beta_6(:,5)=mean(beta_6_d0702(1:626,:),2);
beta_6(:,6)=mean(beta_6_b1601(1:626,:),2);



alpha_4=zeros(626,6);
alpha_4(:,1)=mean(alpha_4_b1402(1:626,:),2);
alpha_4(:,2)=mean(alpha_4_c1402(1:626,:),2);
alpha_4(:,3)=mean(alpha_4_b0702(1:626,:),2);
alpha_4(:,4)=mean(alpha_4_c0702(1:626,:),2);
alpha_4(:,5)=mean(alpha_4_d0702(1:626,:),2);
alpha_4(:,6)=mean(alpha_4_b1601(1:626,:),2);

alpha_3=zeros(626,6);
alpha_3(:,1)=mean(alpha_3_b1402(1:626,:),2);
alpha_3(:,2)=mean(alpha_3_c1402(1:626,:),2);
alpha_3(:,3)=mean(alpha_3_b0702(1:626,:),2);
alpha_3(:,4)=mean(alpha_3_c0702(1:626,:),2);
alpha_3(:,5)=mean(alpha_3_d0702(1:626,:),2);
alpha_3(:,6)=mean(alpha_3_b1601(1:626,:),2);

alpha_6=zeros(626,6);
alpha_6(:,1)=mean(alpha_6_b1402(1:626,:),2);
alpha_6(:,2)=mean(alpha_6_c1402(1:626,:),2);
alpha_6(:,3)=mean(alpha_6_b0702(1:626,:),2);
alpha_6(:,4)=mean(alpha_6_c0702(1:626,:),2);
alpha_6(:,5)=mean(alpha_6_d0702(1:626,:),2);
alpha_6(:,6)=mean(alpha_6_b1601(1:626,:),2);



lowgammaRMS_4=zeros(626,6);
lowgammaRMS_4(:,1)=mean(lowgammaRMS_4_b1402(1:626,:),2);
lowgammaRMS_4(:,2)=mean(lowgammaRMS_4_c1402(1:626,:),2);
lowgammaRMS_4(:,3)=mean(lowgammaRMS_4_b0702(1:626,:),2);
lowgammaRMS_4(:,4)=mean(lowgammaRMS_4_c0702(1:626,:),2);
lowgammaRMS_4(:,5)=mean(lowgammaRMS_4_d0702(1:626,:),2);
lowgammaRMS_4(:,6)=mean(lowgammaRMS_4_b1601(1:626,:),2);

lowgammaRMS_3=zeros(626,6);
lowgammaRMS_3(:,1)=mean(lowgammaRMS_3_b1402(1:626,:),2);
lowgammaRMS_3(:,2)=mean(lowgammaRMS_3_c1402(1:626,:),2);
lowgammaRMS_3(:,3)=mean(lowgammaRMS_3_b0702(1:626,:),2);
lowgammaRMS_3(:,4)=mean(lowgammaRMS_3_c0702(1:626,:),2);
lowgammaRMS_3(:,5)=mean(lowgammaRMS_3_d0702(1:626,:),2);
lowgammaRMS_3(:,6)=mean(lowgammaRMS_3_b1601(1:626,:),2);

lowgammaRMS_6=zeros(626,6);
lowgammaRMS_6(:,1)=mean(lowgammaRMS_6_b1402(1:626,:),2);
lowgammaRMS_6(:,2)=mean(lowgammaRMS_6_c1402(1:626,:),2);
lowgammaRMS_6(:,3)=mean(lowgammaRMS_6_b0702(1:626,:),2);
lowgammaRMS_6(:,4)=mean(lowgammaRMS_6_c0702(1:626,:),2);
lowgammaRMS_6(:,5)=mean(lowgammaRMS_6_d0702(1:626,:),2);
lowgammaRMS_6(:,6)=mean(lowgammaRMS_6_b1601(1:626,:),2);





highgammaRMS_4=zeros(626,6);
highgammaRMS_4(:,1)=mean(highgammaRMS_4_b1402(1:626,:),2);
highgammaRMS_4(:,2)=mean(highgammaRMS_4_c1402(1:626,:),2);
highgammaRMS_4(:,3)=mean(highgammaRMS_4_b0702(1:626,:),2);
highgammaRMS_4(:,4)=mean(highgammaRMS_4_c0702(1:626,:),2);
highgammaRMS_4(:,5)=mean(highgammaRMS_4_d0702(1:626,:),2);
highgammaRMS_4(:,6)=mean(highgammaRMS_4_b1601(1:626,:),2);

highgammaRMS_3=zeros(626,6);
highgammaRMS_3(:,1)=mean(highgammaRMS_3_b1402(1:626,:),2);
highgammaRMS_3(:,2)=mean(highgammaRMS_3_c1402(1:626,:),2);
highgammaRMS_3(:,3)=mean(highgammaRMS_3_b0702(1:626,:),2);
highgammaRMS_3(:,4)=mean(highgammaRMS_3_c0702(1:626,:),2);
highgammaRMS_3(:,5)=mean(highgammaRMS_3_d0702(1:626,:),2);
highgammaRMS_3(:,6)=mean(highgammaRMS_3_b1601(1:626,:),2);

highgammaRMS_6=zeros(626,6);
highgammaRMS_6(:,1)=mean(highgammaRMS_6_b1402(1:626,:),2);
highgammaRMS_6(:,2)=mean(highgammaRMS_6_c1402(1:626,:),2);
highgammaRMS_6(:,3)=mean(highgammaRMS_6_b0702(1:626,:),2);
highgammaRMS_6(:,4)=mean(highgammaRMS_6_c0702(1:626,:),2);
highgammaRMS_6(:,5)=mean(highgammaRMS_6_d0702(1:626,:),2);
highgammaRMS_6(:,6)=mean(highgammaRMS_6_b1601(1:626,:),2);

%% normalization

lowgammaRMS_4_b1402=10*log10(lowgammaRMS_4_b1402./repmat(mean(lowgammaRMS_4_b1402(1:100,:),1),[size(lowgammaRMS_4_b1402,1) 1]));
lowgammaRMS_4_c1402=10*log10(lowgammaRMS_4_c1402./repmat(mean(lowgammaRMS_4_c1402(1:100,:),1),[size(lowgammaRMS_4_c1402,1) 1]));
lowgammaRMS_4_b0702=10*log10(lowgammaRMS_4_b0702./repmat(mean(lowgammaRMS_4_b0702(1:100,:),1),[size(lowgammaRMS_4_b0702,1) 1]));
lowgammaRMS_4_c0702=10*log10(lowgammaRMS_4_c0702./repmat(mean(lowgammaRMS_4_c0702(1:100,:),1),[size(lowgammaRMS_4_c0702,1) 1]));
lowgammaRMS_4_d0702=10*log10(lowgammaRMS_4_d0702./repmat(mean(lowgammaRMS_4_d0702(1:100,:),1),[size(lowgammaRMS_4_d0702,1) 1]));
lowgammaRMS_4_b1601=10*log10(lowgammaRMS_4_b1601./repmat(mean(lowgammaRMS_4_b1601(1:100,:),1),[size(lowgammaRMS_4_b1601,1) 1]));

lowgammaRMS_3_b1402=10*log10(lowgammaRMS_3_b1402./repmat(mean(lowgammaRMS_3_b1402(1:100,:),1),[size(lowgammaRMS_3_b1402,1) 1]));
lowgammaRMS_3_c1402=10*log10(lowgammaRMS_3_c1402./repmat(mean(lowgammaRMS_3_c1402(1:100,:),1),[size(lowgammaRMS_3_c1402,1) 1]));
lowgammaRMS_3_b0702=10*log10(lowgammaRMS_3_b0702./repmat(mean(lowgammaRMS_3_b0702(1:100,:),1),[size(lowgammaRMS_3_b0702,1) 1]));
lowgammaRMS_3_c0702=10*log10(lowgammaRMS_3_c0702./repmat(mean(lowgammaRMS_3_c0702(1:100,:),1),[size(lowgammaRMS_3_c0702,1) 1]));
lowgammaRMS_3_d0702=10*log10(lowgammaRMS_3_d0702./repmat(mean(lowgammaRMS_3_d0702(1:100,:),1),[size(lowgammaRMS_3_d0702,1) 1]));
lowgammaRMS_3_b1601=10*log10(lowgammaRMS_3_b1601./repmat(mean(lowgammaRMS_3_b1601(1:100,:),1),[size(lowgammaRMS_3_b1601,1) 1]));

lowgammaRMS_6_b1402=10*log10(lowgammaRMS_6_b1402./repmat(mean(lowgammaRMS_6_b1402(1:100,:),1),[size(lowgammaRMS_6_b1402,1) 1]));
lowgammaRMS_6_c1402=10*log10(lowgammaRMS_6_c1402./repmat(mean(lowgammaRMS_6_c1402(1:100,:),1),[size(lowgammaRMS_6_c1402,1) 1]));
lowgammaRMS_6_b0702=10*log10(lowgammaRMS_6_b0702./repmat(mean(lowgammaRMS_6_b0702(1:100,:),1),[size(lowgammaRMS_6_b0702,1) 1]));
lowgammaRMS_6_c0702=10*log10(lowgammaRMS_6_c0702./repmat(mean(lowgammaRMS_6_c0702(1:100,:),1),[size(lowgammaRMS_6_c0702,1) 1]));
lowgammaRMS_6_d0702=10*log10(lowgammaRMS_6_d0702./repmat(mean(lowgammaRMS_6_d0702(1:100,:),1),[size(lowgammaRMS_6_d0702,1) 1]));
lowgammaRMS_6_b1601=10*log10(lowgammaRMS_6_b1601./repmat(mean(lowgammaRMS_6_b1601(1:100,:),1),[size(lowgammaRMS_6_b1601,1) 1]));





highgammaRMS_4_b1402=10*log10(highgammaRMS_4_b1402./repmat(mean(highgammaRMS_4_b1402(1:100,:),1),[size(highgammaRMS_4_b1402,1) 1]));
highgammaRMS_4_c1402=10*log10(highgammaRMS_4_c1402./repmat(mean(highgammaRMS_4_c1402(1:100,:),1),[size(highgammaRMS_4_c1402,1) 1]));
highgammaRMS_4_b0702=10*log10(highgammaRMS_4_b0702./repmat(mean(highgammaRMS_4_b0702(1:100,:),1),[size(highgammaRMS_4_b0702,1) 1]));
highgammaRMS_4_c0702=10*log10(highgammaRMS_4_c0702./repmat(mean(highgammaRMS_4_c0702(1:100,:),1),[size(highgammaRMS_4_c0702,1) 1]));
highgammaRMS_4_d0702=10*log10(highgammaRMS_4_d0702./repmat(mean(highgammaRMS_4_d0702(1:100,:),1),[size(highgammaRMS_4_d0702,1) 1]));
highgammaRMS_4_b1601=10*log10(highgammaRMS_4_b1601./repmat(mean(highgammaRMS_4_b1601(1:100,:),1),[size(highgammaRMS_4_b1601,1) 1]));

highgammaRMS_3_b1402=10*log10(highgammaRMS_3_b1402./repmat(mean(highgammaRMS_3_b1402(1:100,:),1),[size(highgammaRMS_3_b1402,1) 1]));
highgammaRMS_3_c1402=10*log10(highgammaRMS_3_c1402./repmat(mean(highgammaRMS_3_c1402(1:100,:),1),[size(highgammaRMS_3_c1402,1) 1]));
highgammaRMS_3_b0702=10*log10(highgammaRMS_3_b0702./repmat(mean(highgammaRMS_3_b0702(1:100,:),1),[size(highgammaRMS_3_b0702,1) 1]));
highgammaRMS_3_c0702=10*log10(highgammaRMS_3_c0702./repmat(mean(highgammaRMS_3_c0702(1:100,:),1),[size(highgammaRMS_3_c0702,1) 1]));
highgammaRMS_3_d0702=10*log10(highgammaRMS_3_d0702./repmat(mean(highgammaRMS_3_d0702(1:100,:),1),[size(highgammaRMS_3_d0702,1) 1]));
highgammaRMS_3_b1601=10*log10(highgammaRMS_3_b1601./repmat(mean(highgammaRMS_3_b1601(1:100,:),1),[size(highgammaRMS_3_b1601,1) 1]));

highgammaRMS_6_b1402=10*log10(highgammaRMS_6_b1402./repmat(mean(highgammaRMS_6_b1402(1:100,:),1),[size(highgammaRMS_6_b1402,1) 1]));
highgammaRMS_6_c1402=10*log10(highgammaRMS_6_c1402./repmat(mean(highgammaRMS_6_c1402(1:100,:),1),[size(highgammaRMS_6_c1402,1) 1]));
highgammaRMS_6_b0702=10*log10(highgammaRMS_6_b0702./repmat(mean(highgammaRMS_6_b0702(1:100,:),1),[size(highgammaRMS_6_b0702,1) 1]));
highgammaRMS_6_c0702=10*log10(highgammaRMS_6_c0702./repmat(mean(highgammaRMS_6_c0702(1:100,:),1),[size(highgammaRMS_6_c0702,1) 1]));
highgammaRMS_6_d0702=10*log10(highgammaRMS_6_d0702./repmat(mean(highgammaRMS_6_d0702(1:100,:),1),[size(highgammaRMS_6_d0702,1) 1]));
highgammaRMS_6_b1601=10*log10(highgammaRMS_6_b1601./repmat(mean(highgammaRMS_6_b1601(1:100,:),1),[size(highgammaRMS_6_b1601,1) 1]));



