

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
%figure;imagesc((res_vec_205-res_vec_205(br(1))),res_vec_205-res_vec_205(br(2)),h)


figure;imagesc(h)

