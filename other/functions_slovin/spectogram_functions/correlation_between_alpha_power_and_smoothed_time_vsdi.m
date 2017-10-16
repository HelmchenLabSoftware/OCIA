
x1=(20:10:1130)-200; %for collinear

for i=1:size(pow4,2)
    c=corrcoef(time4(14:39,i),pow4(14:39,i));
    corr4(i)=c(1,2);
end

for i=1:size(pow3,2)
    c=corrcoef(time3(14:39,i),pow3(14:39,i));
    corr3(i)=c(1,2);
end
