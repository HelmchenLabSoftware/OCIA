function [BFtest] = BFtest(X,alpha)
%Brown-Forsythe's Test for Homogeneity of Variances.
%[In the Brown-Forsythe's test the data are transforming to yij = abs[xij - median(xj)]
%and uses the F distribution performing an one-way ANOVA using y as the 
%dependent variable. The Brown-Frosythe statistic is corrected for artificial zeros 
%occurring in odd sized samples.
%
%   Syntax: function [BFtest] = BFtest(X,alpha) 
%      
%     Inputs:
%          X - data matrix (Size of matrix must be n-by-2; data=column 1, sample=column 2). 
%       alpha - significance level (default = 0.05).
%     Outputs:
%          - Sample variances vector.
%          - Whether or not the homoscedasticity was met.
%
%    Example: From the example 10.1 of Zar (1999, p.180), to test the Brown-Forsythe's
%             homoscedasticity of data with a significance level = 0.05.
%
%                                 Diet
%                   ---------------------------------
%                       1       2       3       4
%                   ---------------------------------
%                     60.8    68.7   102.6    87.9
%                     57.0    67.7   102.1    84.2
%                     65.0    74.0   100.2    83.1
%                     58.6    66.3    96.5    85.7
%                     61.7    69.8            90.3
%                   ---------------------------------
%                                       
%           Data matrix must be:
%            X=[60.8 1;57.0 1;65.0 1;58.6 1;61.7 1;68.7 2;67.7 2;74.0 2;66.3 2;69.8 2;
%            102.6 3;102.1 3;100.2 3;96.5 3;87.9 4;84.2 4;83.1 4;85.7 4;90.3 4];
%
%     Calling on Matlab the function: 
%             BFtest(X)
%
%       Answer is:
%
% The number of samples are: 4
%
% ----------------------------
% Sample    Size      Variance
% ----------------------------
%   1        5         9.3920
%   2        5         8.5650
%   3        4         7.6567
%   4        5         8.3880
% ----------------------------
%   
% Brown-Forsythe's Test for Equality of Variances F=0.0831, df1= 3, df2=15
% Probability associated to the F statistic = 0.9682
% The associated probability for the F test is larger than 0.05
% So, the assumption of homoscedasticity was met.     
%

%  Created by A. Trujillo-Ortiz and R. Hernandez-Walls
%             Facultad de Ciencias Marinas
%             Universidad Autonoma de Baja California
%             Apdo. Postal 453
%             Ensenada, Baja California
%             Mexico.
%             atrujo@uabc.mx
%
%  April 19, 2003.
%
%  To cite this file, this would be an appropriate format:
%  Trujillo-Ortiz, A. and R. Hernandez-Walls. (2003). BFtest: Brown-Forsythe's test for homogeneity of 
%    variances. A MATLAB file. [WWW document]. URL http://www.mathworks.com/matlabcentral/fileexchange/
%    loadFile.do?objectId=3412&objectType=FILE
%
%  References:
% 
%  Brown, M. B. and Forsythe, A. B. (1974), Robust Tests for 
%           the Equality of Variances. Journal of the American 
%           Statistical Association, 69:364-367.
%  Zar, J. H. (1999), Biostatistical Analysis (2nd ed.).
%           NJ: Prentice-Hall, Englewood Cliffs. p. 180. 
%

if nargin < 2,
   alpha = 0.05;
end 

Y=X;
k=max(Y(:,2));
fprintf('The number of samples are:%2i\n\n', k);

%Brown-Forsythe's Procedure.
n=[];s2=[];Z=[];
indice=Y(:,2);
for i=1:k
   Ye=find(indice==i);
   eval(['Y' num2str(i) '=Y(Ye,1);']);
   eval(['mdY' num2str(i) '=median(Y(Ye,1));']);
   eval(['n' num2str(i) '=length(Y' num2str(i) ') ;']);
   eval(['s2' num2str(i) '=(std(Y' num2str(i) ').^2) ;']);
   eval(['Z' num2str(i) '= abs((Y' num2str(i) ') - mdY' num2str(i) ');']);
   eval(['xn= n' num2str(i) ';']);
   eval(['xs2= s2' num2str(i) ';']);
   eval(['x= Z' num2str(i) ';']);
   n=[n;xn];s2=[s2;xs2];Z=[Z;x];
end

fprintf('-----------------------------\n');
disp(' Sample    Size      Variance')
fprintf('-----------------------------\n');
for i=1:k
   fprintf('   %d       %2i         %.4f\n',i,n(i),s2(i))
end
fprintf('-----------------------------\n');
disp(' ')

Y=[Z Y(:,2)];

%Correction for artificial zeros occurring in odd sized samples.
for i=1:k
   Ye=find(Y(:,2)==i);
   ncero=find((Y(:,1)==0)&(Y(:,2)==i));
   Y(ncero,1)=999;
   Y(ncero,1)=min(Y(Ye,1));
end

%Analysis of variance procedure.
C=(sum(Y(:,1)))^2/length(Y(:,1)); %correction term.
SST=sum(Y(:,1).^2)-C; %total sum of squares.
dfT=length(Y(:,1))-1; %total degrees of freedom.

indice=Y(:,2);
for i=1:k
   Ye=find(indice==i);
   eval(['A' num2str(i) '=Y(Ye,1);']);
end

A=[];
for i=1:k
   eval(['x =((sum(A' num2str(i) ').^2)/length(A' num2str(i) '));']);
   A=[A,x];
end

SSA=sum(A)-C; %sample sum of squares.
dfA=k-1; %sample degrees of freedom.
SSE=SST-SSA; %error sum of squares.
dfE=dfT-dfA; %error degrees of freedom.
MSA=SSA/dfA; %sample mean squares.
MSE=SSE/dfE; %error mean squares.
F=MSA/MSE; %Brown-Forsythe's F-statistic.
v1=dfA;df1=v1;
v2=dfE;df2=v2;

P = 1 - fcdf(F,v1,v2);  %probability associated to the F-statistic.   

fprintf('Brown-Forsythe''s Test for Equality of Variances F=%3.4f, df1=%2i, df2=%2i\n', F,df1,df2);
fprintf('Probability associated to the F statistic = %3.4f\n', P);

if P >= alpha;
  fprintf('The associated probability for the F test is equal or larger than% 3.2f\n', alpha);
  fprintf('So, the assumption of homoscedasticity was met.\n');
else
  fprintf('The associated probability for the F test is smaller than% 3.2f\n', alpha);
  fprintf('So, the assumption of homoscedasticity was not met.\n');
end
