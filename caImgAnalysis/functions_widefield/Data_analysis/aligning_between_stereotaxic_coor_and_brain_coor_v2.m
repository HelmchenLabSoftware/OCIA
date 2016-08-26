

[r c]=find(brain==20);
t=ml_ax(r);
tt=ap_ax(c);
coor=[t;tt];
br_coor=[(res_vec_205-res_vec_205(br(2)));-(res_vec_205-res_vec_205(br(1)))];

h=zeros(205,205);
for i=1:size(coor,2)
    x=find(abs(coor(1,i)-br_coor(1,:))==min(abs(coor(1,i)-br_coor(1,:))));
    y=find(abs(coor(2,i)-br_coor(2,:))==min(abs(coor(2,i)-br_coor(2,:))));
    h(x,y)=1;
    h(x+1,y+1)=1;
end  

[r c]=find(brain==10);
t=ml_ax(r);
tt=ap_ax(c);
coor=[t;tt];
br_coor=[(res_vec_205-res_vec_205(br(2)));-(res_vec_205-res_vec_205(br(1)))];
for i=1:size(coor,2)
    x=find(abs(coor(1,i)-br_coor(1,:))==min(abs(coor(1,i)-br_coor(1,:))));
    y=find(abs(coor(2,i)-br_coor(2,:))==min(abs(coor(2,i)-br_coor(2,:))));
    h(x,y)=2;
    h(x+1,y+1)=2;
end  

[r c]=find(brain==10);
t=ml_ax(r);
tt=ap_ax(c);
coor=[t;tt];
br_coor=[(res_vec_205-res_vec_205(br(2)));-(res_vec_205-res_vec_205(br(1)))];
for i=1:size(coor,2)
    x=find(abs(coor(1,i)-br_coor(1,:))==min(abs(coor(1,i)-br_coor(1,:))));
    y=find(abs(coor(2,i)-br_coor(2,:))==min(abs(coor(2,i)-br_coor(2,:))));
    h(x,y)=2;
    h(x+1,y+1)=2;
end  

[r c]=find(brain==16);
t=ml_ax(r);
tt=ap_ax(c);
coor=[t;tt];
br_coor=[(res_vec_205-res_vec_205(br(2)));-(res_vec_205-res_vec_205(br(1)))];
for i=1:size(coor,2)
    x=find(abs(coor(1,i)-br_coor(1,:))==min(abs(coor(1,i)-br_coor(1,:))));
    y=find(abs(coor(2,i)-br_coor(2,:))==min(abs(coor(2,i)-br_coor(2,:))));
    h(x,y)=2;
    h(x+1,y+1)=2;
end  

[r c]=find(brain==23);
t=ml_ax(r);
tt=ap_ax(c);
coor=[t;tt];
br_coor=[(res_vec_205-res_vec_205(br(2)));-(res_vec_205-res_vec_205(br(1)))];
for i=1:size(coor,2)
    x=find(abs(coor(1,i)-br_coor(1,:))==min(abs(coor(1,i)-br_coor(1,:))));
    y=find(abs(coor(2,i)-br_coor(2,:))==min(abs(coor(2,i)-br_coor(2,:))));
    h(x,y)=3;
    h(x+1,y+1)=3;
end  
%figure;imagesc((res_vec_205-res_vec_205(br(1))),res_vec_205-res_vec_205(br(2)),h)

[r c]=find(brain==24);
t=ml_ax(r);
tt=ap_ax(c);
coor=[t;tt];
br_coor=[(res_vec_205-res_vec_205(br(2)));-(res_vec_205-res_vec_205(br(1)))];
for i=1:size(coor,2)
    x=find(abs(coor(1,i)-br_coor(1,:))==min(abs(coor(1,i)-br_coor(1,:))));
    y=find(abs(coor(2,i)-br_coor(2,:))==min(abs(coor(2,i)-br_coor(2,:))));
    h(x,y)=4;
    h(x+1,y+1)=4;
end  
%figure;imagesc((res_vec_205-res_vec_205(br(1))),res_vec_205-res_vec_205(br(2)),h)

[r c]=find(brain==21);
t=ml_ax(r);
tt=ap_ax(c);
coor=[t;tt];
br_coor=[(res_vec_205-res_vec_205(br(2)));-(res_vec_205-res_vec_205(br(1)))];
for i=1:size(coor,2)
    x=find(abs(coor(1,i)-br_coor(1,:))==min(abs(coor(1,i)-br_coor(1,:))));
    y=find(abs(coor(2,i)-br_coor(2,:))==min(abs(coor(2,i)-br_coor(2,:))));
    h(x,y)=5;
    h(x+1,y+1)=5;
end  
%figure;imagesc((res_vec_205-res_vec_205(br(1))),res_vec_205-res_vec_205(br(2)),h)

[r c]=find(brain==3);
t=ml_ax(r);
tt=ap_ax(c);
coor=[t;tt];
br_coor=[(res_vec_205-res_vec_205(br(2)));-(res_vec_205-res_vec_205(br(1)))];
for i=1:size(coor,2)
    x=find(abs(coor(1,i)-br_coor(1,:))==min(abs(coor(1,i)-br_coor(1,:))));
    y=find(abs(coor(2,i)-br_coor(2,:))==min(abs(coor(2,i)-br_coor(2,:))));
    h(x,y)=6;
    h(x+1,y+1)=6;
end  
%figure;imagesc((res_vec_205-res_vec_205(br(1))),res_vec_205-res_vec_205(br(2)),h)


[r c]=find(brain==19);
t=ml_ax(r);
tt=ap_ax(c);
coor=[t;tt];
br_coor=[(res_vec_205-res_vec_205(br(2)));-(res_vec_205-res_vec_205(br(1)))];
for i=1:size(coor,2)
    x=find(abs(coor(1,i)-br_coor(1,:))==min(abs(coor(1,i)-br_coor(1,:))));
    y=find(abs(coor(2,i)-br_coor(2,:))==min(abs(coor(2,i)-br_coor(2,:))));
    h(x,y)=3;
    h(x+1,y+1)=3;
end  
%figure;imagesc((res_vec_205-res_vec_205(br(1))),res_vec_205-res_vec_205(br(2)),h)

[r c]=find(brain==25);
t=ml_ax(r);
tt=ap_ax(c);
coor=[t;tt];
br_coor=[(res_vec_205-res_vec_205(br(2)));-(res_vec_205-res_vec_205(br(1)))];
for i=1:size(coor,2)
    x=find(abs(coor(1,i)-br_coor(1,:))==min(abs(coor(1,i)-br_coor(1,:))));
    y=find(abs(coor(2,i)-br_coor(2,:))==min(abs(coor(2,i)-br_coor(2,:))));
    h(x,y)=3;
    h(x+1,y+1)=3;
end  
%figure;imagesc((res_vec_205-res_vec_205(br(1))),res_vec_205-res_vec_205(br(2)),h)


h(br(2),br(1))=4;
h(mid(2),mid(1))=4;
figure;imagesc(h)

