%% 1711

load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1711b_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_1711b_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1711b_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1711b_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_1711b_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_1711b_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1711b_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1711b_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    
    
    
    
load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1711c_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_1711c_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1711c_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1711c_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_1711c_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_1711c_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1711c_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1711c_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end     
    
           
load myrois

for i=[1 2 4 5]
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1711g_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_1711g_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1711g_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1711g_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_1711g_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_1711g_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1711g_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1711g_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end     
        

%% 2411

load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2411b_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2411b_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2411b_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2411b_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_2411b_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2411b_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2411b_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2411b_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    
    

load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2411d_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2411d_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2411d_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2411d_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_2411d_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2411d_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2411d_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2411d_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    
    
load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2411f_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2411f_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2411f_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2411f_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_2411f_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left,2:112,:),1));'])
    %eval(['c',int2str(i),'_2411f_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2411f_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2411f_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    
    


%% 1412
load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1412b_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_1412b_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1412b_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1412b_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_1412b_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_1412b_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1412b_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1412b_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    
    

load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1412c_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_1412c_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1412c_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1412c_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_1412c_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_1412c_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1412c_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1412c_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    
    



load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1412d_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_1412d_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1412d_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1412d_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_1412d_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_1412d_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1412d_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1412d_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    
    


load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1412e_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_1412e_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1412e_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1412e_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_1412e_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_1412e_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1412e_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1412e_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    
    



%% 2212
load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2212b_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2212b_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2212b_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2212b_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_2212b_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2212b_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2212b_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2212b_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end

%taking only the 11th trial and onwards for each condition
    
load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2212b_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_left,2:112,11:end),1));'])
    eval(['c',int2str(i),'_2212b_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_right,2:112,11:end),1));'])
    eval(['c',int2str(i),'_2212b_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_middle,2:112,11:end),1));'])
    eval(['c',int2str(i),'_2212b_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,11:end),1));'])
    eval(['c',int2str(i),'_2212b_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left,2:112,11:end),1));'])
    eval(['c',int2str(i),'_2212b_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_right,2:112,11:end),1));'])
    eval(['c',int2str(i),'_2212b_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle,2:112,11:end),1));'])
    eval(['c',int2str(i),'_2212b_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,11:end),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end


load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2212c_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2212c_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2212c_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2212c_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_2212c_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2212c_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2212c_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2212c_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    
    



load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2212d_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2212d_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2212d_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2212d_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_2212d_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2212d_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2212d_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2212d_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    
    



%% 2912
load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2912b_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2912b_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2912b_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912b_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912b_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2912b_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2912b_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912b_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    

%taking only the 11th trial and onwards for each condition

load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2912b_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_left,2:112,6:end),1));'])
    eval(['c',int2str(i),'_2912b_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_right,2:112,6:end),1));'])
    eval(['c',int2str(i),'_2912b_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_middle,2:112,6:end),1));'])
    eval(['c',int2str(i),'_2912b_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,6:end),1));'])
    eval(['c',int2str(i),'_2912b_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left,2:112,6:end),1));'])
    eval(['c',int2str(i),'_2912b_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_right,2:112,6:end),1));'])
    eval(['c',int2str(i),'_2912b_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle,2:112,6:end),1));'])
    eval(['c',int2str(i),'_2912b_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,6:end),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end  



load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2912c_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2912c_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2912c_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912c_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912c_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2912c_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2912c_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912c_bg_out=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_out,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    
        
load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2912d_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2912d_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2912d_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912d_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912d_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2912d_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2912d_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912d_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    
        

load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2912e_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2912e_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2912e_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912e_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912e_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2912e_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2912e_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912e_bg_out=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_out,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end   


load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2912k_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_left,2:112,:),1));'])
    %eval(['c',int2str(i),'_2912k_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2912k_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912k_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912k_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2912k_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2912k_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912k_bg_out=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_out,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end   



%% 0501
load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_0501b_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_0501b_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_0501b_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_0501b_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_0501b_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_0501b_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_0501b_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_0501b_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['c',int2str(i),'_0501b_bg_out=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_out,2:112,:),1));'])
    eval(['c',int2str(i),'_0501b_bg_middle_bot=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle_bot,2:112,:),1));'])
    eval(['c',int2str(i),'_0501b_bg_left_bot=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left_bot,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    


load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_0501c_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_0501c_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_0501c_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_0501c_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_0501c_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_0501c_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_0501c_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_0501c_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['c',int2str(i),'_0501c_bg_out=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_out,2:112,:),1));'])
    eval(['c',int2str(i),'_0501c_bg_middle_bot=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle_bot,2:112,:),1));'])
    eval(['c',int2str(i),'_0501c_bg_left_bot=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left_bot,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    


load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_0501d_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_0501d_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_0501d_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_0501d_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_0501d_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_0501d_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_0501d_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_0501d_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    eval(['c',int2str(i),'_0501d_bg_out=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_out,2:112,:),1));'])
    eval(['c',int2str(i),'_0501d_bg_middle_bot=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle_bot,2:112,:),1));'])
    eval(['c',int2str(i),'_0501d_bg_left_bot=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left_bot,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    


load myrois

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_0501e_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_0501e_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_0501e_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_0501e_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_0501e_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_0501e_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_0501e_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_0501e_bg_in=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_in,2:112,:),1));'])
    %eval(['c',int2str(i),'_0501e_bg_out=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_out,2:112,:),1));'])
    %eval(['c',int2str(i),'_0501e_bg_middle_bot=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_middle_bot,2:112,:),1));'])
    %eval(['c',int2str(i),'_0501e_bg_left_bot=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_bg_left_bot,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    


%% creating one big matrix for each roi with all trials



cont_circle=c1_1711b_circle;
cont_circle=cat(2,cont_circle,c2_1711b_circle);
cont_circle=cat(2,cont_circle,c1_1711c_circle);
cont_circle=cat(2,cont_circle,c2_1711c_circle);
cont_circle=cat(2,cont_circle,c1_1711g_circle);
cont_circle=cat(2,cont_circle,c2_1711g_circle);
cont_circle=cat(2,cont_circle,c1_2411b_circle);
cont_circle=cat(2,cont_circle,c2_2411b_circle);
cont_circle=cat(2,cont_circle,c1_2411d_circle);
cont_circle=cat(2,cont_circle,c2_2411d_circle);
cont_circle=cat(2,cont_circle,c1_2411f_circle);
cont_circle=cat(2,cont_circle,c2_2411f_circle);
cont_circle=cat(2,cont_circle,c1_1412b_circle);
cont_circle=cat(2,cont_circle,c2_1412b_circle);
cont_circle=cat(2,cont_circle,c1_1412c_circle);
cont_circle=cat(2,cont_circle,c1_1412d_circle);
cont_circle=cat(2,cont_circle,c1_1412e_circle);
cont_circle=cat(2,cont_circle,c1_2212b_circle);
cont_circle=cat(2,cont_circle,c2_2212b_circle);
cont_circle=cat(2,cont_circle,c1_2212c_circle);
cont_circle=cat(2,cont_circle,c1_2212d_circle);
cont_circle=cat(2,cont_circle,c1_2912b_circle);
cont_circle=cat(2,cont_circle,c2_2912b_circle);
cont_circle=cat(2,cont_circle,c1_2912c_circle);
cont_circle=cat(2,cont_circle,c2_2912c_circle);
cont_circle=cat(2,cont_circle,c1_2912d_circle);
cont_circle=cat(2,cont_circle,c2_2912d_circle);
cont_circle=cat(2,cont_circle,c1_2912e_circle);
cont_circle=cat(2,cont_circle,c2_2912e_circle);
cont_circle=cat(2,cont_circle,c1_2912k_circle);
cont_circle=cat(2,cont_circle,c2_2912k_circle);
cont_circle=cat(2,cont_circle,c1_0501b_circle);
cont_circle=cat(2,cont_circle,c2_0501b_circle);
cont_circle=cat(2,cont_circle,c1_0501c_circle);
cont_circle=cat(2,cont_circle,c1_0501d_circle);
cont_circle=cat(2,cont_circle,c1_0501e_circle);
cont_circle=cat(2,cont_circle,c2_0501e_circle);


non_circle=c4_1711b_circle;
non_circle=cat(2,non_circle,c5_1711b_circle);
non_circle=cat(2,non_circle,c4_1711c_circle);
non_circle=cat(2,non_circle,c5_1711c_circle);
non_circle=cat(2,non_circle,c4_1711g_circle);
non_circle=cat(2,non_circle,c5_1711g_circle);
non_circle=cat(2,non_circle,c4_2411b_circle);
non_circle=cat(2,non_circle,c5_2411b_circle);
non_circle=cat(2,non_circle,c4_2411d_circle);
non_circle=cat(2,non_circle,c5_2411d_circle);
non_circle=cat(2,non_circle,c4_2411f_circle);
non_circle=cat(2,non_circle,c5_2411f_circle);
non_circle=cat(2,non_circle,c4_1412b_circle);
non_circle=cat(2,non_circle,c5_1412b_circle);
non_circle=cat(2,non_circle,c5_1412c_circle);
non_circle=cat(2,non_circle,c5_1412d_circle);
non_circle=cat(2,non_circle,c5_1412e_circle);
non_circle=cat(2,non_circle,c4_2212b_circle);
non_circle=cat(2,non_circle,c5_2212b_circle);
non_circle=cat(2,non_circle,c5_2212c_circle);
non_circle=cat(2,non_circle,c5_2212d_circle);
non_circle=cat(2,non_circle,c4_2912b_circle);
non_circle=cat(2,non_circle,c5_2912b_circle);
non_circle=cat(2,non_circle,c4_2912c_circle);
non_circle=cat(2,non_circle,c5_2912c_circle);
non_circle=cat(2,non_circle,c4_2912d_circle);
non_circle=cat(2,non_circle,c5_2912d_circle);
non_circle=cat(2,non_circle,c4_2912e_circle);
non_circle=cat(2,non_circle,c5_2912e_circle);
non_circle=cat(2,non_circle,c4_2912k_circle);
non_circle=cat(2,non_circle,c5_2912k_circle);
non_circle=cat(2,non_circle,c4_0501b_circle);
non_circle=cat(2,non_circle,c5_0501b_circle);
non_circle=cat(2,non_circle,c5_0501c_circle);
non_circle=cat(2,non_circle,c5_0501d_circle);
non_circle=cat(2,non_circle,c4_0501e_circle);
non_circle=cat(2,non_circle,c5_0501e_circle);





cont_bg_in=c1_1711b_bg_in;
cont_bg_in=cat(2,cont_bg_in,c2_1711b_bg_in);
cont_bg_in=cat(2,cont_bg_in,c1_1711c_bg_in);
cont_bg_in=cat(2,cont_bg_in,c2_1711c_bg_in);
cont_bg_in=cat(2,cont_bg_in,c1_1711g_bg_in);
cont_bg_in=cat(2,cont_bg_in,c2_1711g_bg_in);
cont_bg_in=cat(2,cont_bg_in,c1_2411b_bg_in);
cont_bg_in=cat(2,cont_bg_in,c2_2411b_bg_in);
cont_bg_in=cat(2,cont_bg_in,c1_2411d_bg_in);
cont_bg_in=cat(2,cont_bg_in,c2_2411d_bg_in);
cont_bg_in=cat(2,cont_bg_in,c1_2411f_bg_in);
cont_bg_in=cat(2,cont_bg_in,c2_2411f_bg_in);
cont_bg_in=cat(2,cont_bg_in,c1_1412b_bg_in);
cont_bg_in=cat(2,cont_bg_in,c2_1412b_bg_in);
cont_bg_in=cat(2,cont_bg_in,c1_1412c_bg_in);
cont_bg_in=cat(2,cont_bg_in,c1_1412d_bg_in);
cont_bg_in=cat(2,cont_bg_in,c1_1412e_bg_in);
cont_bg_in=cat(2,cont_bg_in,c1_2212b_bg_in);
cont_bg_in=cat(2,cont_bg_in,c2_2212b_bg_in);
cont_bg_in=cat(2,cont_bg_in,c1_2212c_bg_in);
cont_bg_in=cat(2,cont_bg_in,c1_2212d_bg_in);
cont_bg_in=cat(2,cont_bg_in,c1_2912b_bg_in);
cont_bg_in=cat(2,cont_bg_in,c2_2912b_bg_in);
%cont_bg_in=cat(2,cont_bg_in,c1_2912c_bg_in);
%cont_bg_in=cat(2,cont_bg_in,c2_2912c_bg_in);
cont_bg_in=cat(2,cont_bg_in,c1_2912d_bg_in);
cont_bg_in=cat(2,cont_bg_in,c2_2912d_bg_in);
%cont_bg_in=cat(2,cont_bg_in,c1_2912e_bg_in);
%cont_bg_in=cat(2,cont_bg_in,c2_2912e_bg_in);
%cont_bg_in=cat(2,cont_bg_in,c1_2912k_bg_in);
%cont_bg_in=cat(2,cont_bg_in,c2_2912k_bg_in);
cont_bg_in=cat(2,cont_bg_in,c1_0501e_bg_in);
cont_bg_in=cat(2,cont_bg_in,c2_0501e_bg_in);


non_bg_in=c4_1711b_bg_in;
non_bg_in=cat(2,non_bg_in,c5_1711b_bg_in);
non_bg_in=cat(2,non_bg_in,c4_1711c_bg_in);
non_bg_in=cat(2,non_bg_in,c5_1711c_bg_in);
non_bg_in=cat(2,non_bg_in,c4_1711g_bg_in);
non_bg_in=cat(2,non_bg_in,c5_1711g_bg_in);
non_bg_in=cat(2,non_bg_in,c4_2411b_bg_in);
non_bg_in=cat(2,non_bg_in,c5_2411b_bg_in);
non_bg_in=cat(2,non_bg_in,c4_2411d_bg_in);
non_bg_in=cat(2,non_bg_in,c5_2411d_bg_in);
non_bg_in=cat(2,non_bg_in,c4_2411f_bg_in);
non_bg_in=cat(2,non_bg_in,c5_2411f_bg_in);
non_bg_in=cat(2,non_bg_in,c4_1412b_bg_in);
non_bg_in=cat(2,non_bg_in,c5_1412b_bg_in);
non_bg_in=cat(2,non_bg_in,c5_1412c_bg_in);
non_bg_in=cat(2,non_bg_in,c5_1412d_bg_in);
non_bg_in=cat(2,non_bg_in,c5_1412e_bg_in);
non_bg_in=cat(2,non_bg_in,c4_2212b_bg_in);
non_bg_in=cat(2,non_bg_in,c5_2212b_bg_in);
non_bg_in=cat(2,non_bg_in,c5_2212c_bg_in);
non_bg_in=cat(2,non_bg_in,c5_2212d_bg_in);
non_bg_in=cat(2,non_bg_in,c4_2912b_bg_in);
non_bg_in=cat(2,non_bg_in,c5_2912b_bg_in);
%non_bg_in=cat(2,non_bg_in,c4_2912c_bg_in);
%non_bg_in=cat(2,non_bg_in,c5_2912c_bg_in);
non_bg_in=cat(2,non_bg_in,c4_2912d_bg_in);
non_bg_in=cat(2,non_bg_in,c5_2912d_bg_in);
%non_bg_in=cat(2,non_bg_in,c4_2912e_bg_in);
%non_bg_in=cat(2,non_bg_in,c5_2912e_bg_in);
%non_bg_in=cat(2,non_bg_in,c4_2912k_bg_in);
%non_bg_in=cat(2,non_bg_in,c5_2912k_bg_in);
non_bg_in=cat(2,non_bg_in,c4_0501e_bg_in);
non_bg_in=cat(2,non_bg_in,c5_0501e_bg_in);




cont_bg_out=c1_2912e_bg_out;
%cont_bg_out=cat(2,cont_bg_out,c2_2912c_bg_out);
%cont_bg_out=cat(2,cont_bg_out,c1_2912e_bg_out);
cont_bg_out=cat(2,cont_bg_out,c2_2912e_bg_out);
cont_bg_out=cat(2,cont_bg_out,c1_2912k_bg_out);
cont_bg_out=cat(2,cont_bg_out,c2_2912k_bg_out);
cont_bg_out=cat(2,cont_bg_out,c1_0501b_bg_out);
cont_bg_out=cat(2,cont_bg_out,c2_0501b_bg_out);
%cont_bg_out=cat(2,cont_bg_out,c1_0501c_bg_out);
%cont_bg_out=cat(2,cont_bg_out,c1_0501d_bg_out);


non_bg_out=c4_2912e_bg_out;
%non_bg_out=cat(2,non_bg_out,c5_2912c_bg_out);
%non_bg_out=cat(2,non_bg_out,c4_2912e_bg_out);
non_bg_out=cat(2,non_bg_out,c5_2912e_bg_out);
non_bg_out=cat(2,non_bg_out,c4_2912k_bg_out);
non_bg_out=cat(2,non_bg_out,c5_2912k_bg_out);
non_bg_out=cat(2,non_bg_out,c4_0501b_bg_out);
non_bg_out=cat(2,non_bg_out,c5_0501b_bg_out);
%non_bg_out=cat(2,non_bg_out,c5_0501c_bg_out);
%non_bg_out=cat(2,non_bg_out,c5_0501d_bg_out);












%% creating one big matrix for each roi with all trials



cont_circle(:,1)=mean(c1_1711b_circle,2);
cont_circle(:,2)=mean(c2_1711b_circle,2);
cont_circle(:,3)=mean(c1_1711c_circle,2);
cont_circle(:,4)=mean(c2_1711c_circle,2);
cont_circle(:,5)=mean(c1_1711g_circle,2);
cont_circle(:,6)=mean(c2_1711g_circle,2);
cont_circle(:,7)=mean(c1_2411b_circle,2);
cont_circle(:,8)=mean(c2_2411b_circle,2);
cont_circle(:,9)=mean(c1_2411d_circle,2);
cont_circle(:,10)=mean(c2_2411d_circle,2);
cont_circle(:,11)=mean(c1_2411f_circle,2);
cont_circle(:,12)=mean(c2_2411f_circle,2);
cont_circle(:,13)=mean(c1_1412b_circle,2);
cont_circle(:,14)=mean(c2_1412b_circle,2);
cont_circle(:,15)=mean(c1_1412c_circle,2);
cont_circle(:,16)=mean(c1_1412d_circle,2);
cont_circle(:,17)=mean(c1_1412e_circle,2);
cont_circle(:,18)=mean(c1_2212b_circle,2);
cont_circle(:,19)=mean(c2_2212b_circle,2);
cont_circle(:,20)=mean(c1_2212c_circle,2);
cont_circle(:,21)=mean(c1_2212d_circle,2);
cont_circle(:,22)=mean(c1_2912b_circle,2);
cont_circle(:,23)=mean(c2_2912b_circle,2);
cont_circle(:,24)=mean(c1_2912c_circle,2);
cont_circle(:,25)=mean(c2_2912c_circle,2);
cont_circle(:,26)=mean(c1_2912d_circle,2);
cont_circle(:,27)=mean(c2_2912d_circle,2);
cont_circle(:,28)=mean(c1_2912e_circle,2);
cont_circle(:,29)=mean(c2_2912e_circle,2);
cont_circle(:,30)=mean(c1_2912k_circle,2);
cont_circle(:,31)=mean(c2_2912k_circle,2);
cont_circle(:,32)=mean(c1_0501b_circle,2);
cont_circle(:,33)=mean(c2_0501b_circle,2);
cont_circle(:,34)=mean(c1_0501c_circle,2);
cont_circle(:,35)=mean(c1_0501d_circle,2);
cont_circle(:,36)=mean(c1_0501e_circle,2);
cont_circle(:,37)=mean(c2_0501e_circle,2);


non_circle(:,1)=mean(c4_1711b_circle,2);
non_circle(:,2)=mean(c5_1711b_circle,2);
non_circle(:,3)=mean(c4_1711c_circle,2);
non_circle(:,4)=mean(c5_1711c_circle,2);
non_circle(:,5)=mean(c4_1711g_circle,2);
non_circle(:,6)=mean(c5_1711g_circle,2);
non_circle(:,7)=mean(c4_2411b_circle,2);
non_circle(:,8)=mean(c5_2411b_circle,2);
non_circle(:,9)=mean(c4_2411d_circle,2);
non_circle(:,10)=mean(c5_2411d_circle,2);
non_circle(:,11)=mean(c4_2411f_circle,2);
non_circle(:,12)=mean(c5_2411f_circle,2);
non_circle(:,13)=mean(c4_1412b_circle,2);
non_circle(:,14)=mean(c5_1412b_circle,2);
non_circle(:,15)=mean(c5_1412c_circle,2);
non_circle(:,16)=mean(c5_1412d_circle,2);
non_circle(:,17)=mean(c5_1412e_circle,2);
non_circle(:,18)=mean(c4_2212b_circle,2);
non_circle(:,19)=mean(c5_2212b_circle,2);
non_circle(:,20)=mean(c5_2212c_circle,2);
non_circle(:,21)=mean(c5_2212d_circle,2);
non_circle(:,22)=mean(c4_2912b_circle,2);
non_circle(:,23)=mean(c5_2912b_circle,2);
non_circle(:,24)=mean(c4_2912c_circle,2);
non_circle(:,25)=mean(c5_2912c_circle,2);
non_circle(:,26)=mean(c4_2912d_circle,2);
non_circle(:,27)=mean(c5_2912d_circle,2);
non_circle(:,28)=mean(c4_2912e_circle,2);
non_circle(:,29)=mean(c5_2912e_circle,2);
non_circle(:,30)=mean(c4_2912k_circle,2);
non_circle(:,31)=mean(c5_2912k_circle,2);
non_circle(:,32)=mean(c4_0501b_circle,2);
non_circle(:,33)=mean(c5_0501b_circle,2);
non_circle(:,34)=mean(c5_0501c_circle,2);
non_circle(:,35)=mean(c5_0501d_circle,2);
non_circle(:,36)=mean(c4_0501e_circle,2);
non_circle(:,37)=mean(c5_0501e_circle,2);




cont_bg_in(:,1)=mean(c1_1711b_bg_in,2);
cont_bg_in(:,2)=mean(c2_1711b_bg_in,2);
cont_bg_in(:,3)=mean(c1_1711c_bg_in,2);
cont_bg_in(:,4)=mean(c2_1711c_bg_in,2);
cont_bg_in(:,5)=mean(c1_1711g_bg_in,2);
cont_bg_in(:,6)=mean(c2_1711g_bg_in,2);
cont_bg_in(:,7)=mean(c1_2411b_bg_in,2);
cont_bg_in(:,8)=mean(c2_2411b_bg_in,2);
cont_bg_in(:,9)=mean(c1_2411d_bg_in,2);
cont_bg_in(:,10)=mean(c2_2411d_bg_in,2);
cont_bg_in(:,11)=mean(c1_2411f_bg_in,2);
cont_bg_in(:,12)=mean(c2_2411f_bg_in,2);
cont_bg_in(:,13)=mean(c1_1412b_bg_in,2);
cont_bg_in(:,14)=mean(c2_1412b_bg_in,2);
cont_bg_in(:,15)=mean(c1_1412c_bg_in,2);
cont_bg_in(:,16)=mean(c1_1412d_bg_in,2);
cont_bg_in(:,17)=mean(c1_1412e_bg_in,2);
cont_bg_in(:,18)=mean(c1_2212b_bg_in,2);
cont_bg_in(:,19)=mean(c2_2212b_bg_in,2);
cont_bg_in(:,20)=mean(c1_2212c_bg_in,2);
cont_bg_in(:,21)=mean(c1_2212d_bg_in,2);
cont_bg_in(:,22)=mean(c1_2912b_bg_in,2);
cont_bg_in(:,23)=mean(c2_2912b_bg_in,2);
%cont_bg_in(:,24)=mean(c1_2912c_bg_in,2);
%cont_bg_in(:,25)=mean(c2_2912c_bg_in,2);
cont_bg_in(:,24)=mean(c1_2912d_bg_in,2);
cont_bg_in(:,25)=mean(c2_2912d_bg_in,2);
%cont_bg_in(:,28)=mean(c1_2912e_bg_in,2);
%cont_bg_in(:,29)=mean(c2_2912e_bg_in,2);
%cont_bg_in(:,30)=mean(c1_2912k_bg_in,2);
%cont_bg_in(:,31)=mean(c2_2912k_bg_in,2);
cont_bg_in(:,26)=mean(c1_0501e_bg_in,2);
cont_bg_in(:,27)=mean(c2_0501e_bg_in,2);


non_bg_in(:,1)=mean(c4_1711b_bg_in,2);
non_bg_in(:,2)=mean(c5_1711b_bg_in,2);
non_bg_in(:,3)=mean(c4_1711c_bg_in,2);
non_bg_in(:,4)=mean(c5_1711c_bg_in,2);
non_bg_in(:,5)=mean(c4_1711g_bg_in,2);
non_bg_in(:,6)=mean(c5_1711g_bg_in,2);
non_bg_in(:,7)=mean(c4_2411b_bg_in,2);
non_bg_in(:,8)=mean(c5_2411b_bg_in,2);
non_bg_in(:,9)=mean(c4_2411d_bg_in,2);
non_bg_in(:,10)=mean(c5_2411d_bg_in,2);
non_bg_in(:,11)=mean(c4_2411f_bg_in,2);
non_bg_in(:,12)=mean(c5_2411f_bg_in,2);
non_bg_in(:,13)=mean(c4_1412b_bg_in,2);
non_bg_in(:,14)=mean(c5_1412b_bg_in,2);
non_bg_in(:,15)=mean(c5_1412c_bg_in,2);
non_bg_in(:,16)=mean(c5_1412d_bg_in,2);
non_bg_in(:,17)=mean(c5_1412e_bg_in,2);
non_bg_in(:,18)=mean(c4_2212b_bg_in,2);
non_bg_in(:,19)=mean(c5_2212b_bg_in,2);
non_bg_in(:,20)=mean(c5_2212c_bg_in,2);
non_bg_in(:,21)=mean(c5_2212d_bg_in,2);
non_bg_in(:,22)=mean(c4_2912b_bg_in,2);
non_bg_in(:,23)=mean(c5_2912b_bg_in,2);
%non_bg_in(:,24)=mean(c4_2912c_bg_in,2);
%non_bg_in(:,25)=mean(c5_2912c_bg_in,2);
non_bg_in(:,24)=mean(c4_2912d_bg_in,2);
non_bg_in(:,25)=mean(c5_2912d_bg_in,2);
%non_bg_in(:,28)=mean(c4_2912e_bg_in,2);
%non_bg_in(:,29)=mean(c5_2912e_bg_in,2);
%non_bg_in(:,30)=mean(c4_2912k_bg_in,2);
%non_bg_in(:,31)=mean(c5_2912k_bg_in,2);
non_bg_in(:,26)=mean(c4_0501e_bg_in,2);
non_bg_in(:,27)=mean(c5_0501e_bg_in,2);






cont_bg(:,1)=mean(c1_1711b_bg_in,2);
cont_bg(:,2)=mean(c2_1711b_bg_in,2);
cont_bg(:,3)=mean(c1_1711c_bg_in,2);
cont_bg(:,4)=mean(c2_1711c_bg_in,2);
cont_bg(:,5)=mean(c1_1711g_bg_in,2);
cont_bg(:,6)=mean(c2_1711g_bg_in,2);
cont_bg(:,7)=mean(c1_2411b_bg_in,2);
cont_bg(:,8)=mean(c2_2411b_bg_in,2);
cont_bg(:,9)=mean(c1_2411d_bg_in,2);
cont_bg(:,10)=mean(c2_2411d_bg_in,2);
cont_bg(:,11)=mean(c1_2411f_bg_in,2);
cont_bg(:,12)=mean(c2_2411f_bg_in,2);
cont_bg(:,13)=mean(c1_1412b_bg_in,2);
cont_bg(:,14)=mean(c2_1412b_bg_in,2);
cont_bg(:,15)=mean(c1_1412c_bg_in,2);
cont_bg(:,16)=mean(c1_1412d_bg_in,2);
cont_bg(:,17)=mean(c1_1412e_bg_in,2);
cont_bg(:,18)=mean(c1_2212b_bg_in,2);
cont_bg(:,19)=mean(c2_2212b_bg_in,2);
cont_bg(:,20)=mean(c1_2212c_bg_in,2);
cont_bg(:,21)=mean(c1_2212d_bg_in,2);
cont_bg(:,22)=mean(c1_2912b_bg_in,2);
cont_bg(:,23)=mean(c2_2912b_bg_in,2);
cont_bg(:,24)=mean(c1_2912c_bg_out,2);
cont_bg(:,25)=mean(c2_2912c_bg_out,2);
cont_bg(:,26)=mean(c1_2912d_bg_in,2);
cont_bg(:,27)=mean(c2_2912d_bg_in,2);
cont_bg(:,28)=mean(c1_2912e_bg_out,2);
cont_bg(:,29)=mean(c2_2912e_bg_out,2);
cont_bg(:,30)=mean(c1_2912k_bg_out,2);
cont_bg(:,31)=mean(c2_2912k_bg_out,2);
cont_bg(:,32)=mean(c1_0501b_bg_out,2);
cont_bg(:,33)=mean(c2_0501b_bg_out,2);
cont_bg(:,34)=mean(c1_0501c_bg_out,2);
cont_bg(:,35)=mean(c1_0501d_bg_out,2);
cont_bg(:,36)=mean(c1_0501e_bg_in,2);
cont_bg(:,37)=mean(c2_0501e_bg_in,2);



non_bg(:,1)=mean(c4_1711b_bg_in,2);
non_bg(:,2)=mean(c5_1711b_bg_in,2);
non_bg(:,3)=mean(c4_1711c_bg_in,2);
non_bg(:,4)=mean(c5_1711c_bg_in,2);
non_bg(:,5)=mean(c4_1711g_bg_in,2);
non_bg(:,6)=mean(c5_1711g_bg_in,2);
non_bg(:,7)=mean(c4_2411b_bg_in,2);
non_bg(:,8)=mean(c5_2411b_bg_in,2);
non_bg(:,9)=mean(c4_2411d_bg_in,2);
non_bg(:,10)=mean(c5_2411d_bg_in,2);
non_bg(:,11)=mean(c4_2411f_bg_in,2);
non_bg(:,12)=mean(c5_2411f_bg_in,2);
non_bg(:,13)=mean(c4_1412b_bg_in,2);
non_bg(:,14)=mean(c5_1412b_bg_in,2);
non_bg(:,15)=mean(c5_1412c_bg_in,2);
non_bg(:,16)=mean(c5_1412d_bg_in,2);
non_bg(:,17)=mean(c5_1412e_bg_in,2);
non_bg(:,18)=mean(c4_2212b_bg_in,2);
non_bg(:,19)=mean(c5_2212b_bg_in,2);
non_bg(:,20)=mean(c5_2212c_bg_in,2);
non_bg(:,21)=mean(c5_2212d_bg_in,2);
non_bg(:,22)=mean(c4_2912b_bg_in,2);
non_bg(:,23)=mean(c5_2912b_bg_in,2);
non_bg(:,24)=mean(c4_2912c_bg_out,2);
non_bg(:,25)=mean(c5_2912c_bg_out,2);
non_bg(:,26)=mean(c4_2912d_bg_in,2);
non_bg(:,27)=mean(c5_2912d_bg_in,2);
non_bg(:,28)=mean(c4_2912e_bg_out,2);
non_bg(:,29)=mean(c5_2912e_bg_out,2);
non_bg(:,30)=mean(c4_2912k_bg_out,2);
non_bg(:,31)=mean(c5_2912k_bg_out,2);
non_bg(:,32)=mean(c4_0501b_bg_out,2);
non_bg(:,33)=mean(c5_0501b_bg_out,2);
non_bg(:,34)=mean(c5_0501c_bg_out,2);
non_bg(:,35)=mean(c5_0501d_bg_out,2);
non_bg(:,36)=mean(c4_0501e_bg_in,2);
non_bg(:,37)=mean(c5_0501e_bg_in,2);





cont_bg_out(:,1)=mean(c1_2912c_bg_out,2);
cont_bg_out(:,2)=mean(c2_2912c_bg_out,2);
cont_bg_out(:,3)=mean(c1_2912e_bg_out,2);
cont_bg_out(:,4)=mean(c2_2912e_bg_out,2);
cont_bg_out(:,5)=mean(c1_2912k_bg_out,2);
cont_bg_out(:,6)=mean(c2_2912k_bg_out,2);
cont_bg_out(:,7)=mean(c1_0501b_bg_out,2);
cont_bg_out(:,8)=mean(c2_0501b_bg_out,2);
cont_bg_out(:,9)=mean(c1_0501c_bg_out,2);
cont_bg_out(:,10)=mean(c1_0501d_bg_out,2);


non_bg_out(:,1)=mean(c4_2912c_bg_out,2);
non_bg_out(:,2)=mean(c5_2912c_bg_out,2);
non_bg_out(:,3)=mean(c4_2912e_bg_out,2);
non_bg_out(:,4)=mean(c5_2912e_bg_out,2);
non_bg_out(:,5)=mean(c4_2912k_bg_out,2);
non_bg_out(:,6)=mean(c5_2912k_bg_out,2);
non_bg_out(:,7)=mean(c4_0501b_bg_out,2);
non_bg_out(:,8)=mean(c5_0501b_bg_out,2);
non_bg_out(:,9)=mean(c5_0501c_bg_out,2);
non_bg_out(:,10)=mean(c5_0501d_bg_out,2);





%% V2 rois


%% 1711

load myrois_V2

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1711b_V2_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_1711b_V2_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1711b_V2_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1711b_V2_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_1711b_V2_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_1711b_V2_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1711b_V2_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1711b_V2_bg=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    
    


load myrois_V2

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1711c_V2_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_left,2:112,:),1));'])
    %eval(['c',int2str(i),'_1711c_V2_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1711c_V2_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1711c_V2_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_1711c_V2_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_left,2:112,:),1));'])
    %eval(['c',int2str(i),'_1711c_V2_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1711c_V2_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1711c_V2_bg=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    
    


load myrois_V2

for i=[1 2 4 5]
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1711g_V2_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_1711g_V2_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1711g_V2_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1711g_V2_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_1711g_V2_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_1711g_V2_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1711g_V2_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1711g_V2_bg=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    
    





%% 2411

load myrois_V2

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2411b_V2_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2411b_V2_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2411b_V2_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2411b_V2_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_2411b_V2_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2411b_V2_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2411b_V2_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2411b_V2_bg=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    
    


load myrois_V2

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2411d_V2_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2411d_V2_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2411d_V2_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2411d_V2_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_2411d_V2_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2411d_V2_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2411d_V2_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2411d_V2_bg=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    
    


load myrois_V2

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2411f_V2_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2411f_V2_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2411f_V2_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2411f_V2_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_2411f_V2_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2411f_V2_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2411f_V2_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2411f_V2_bg=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    




%% 1412

load myrois_V2

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1412b_V2_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_1412b_V2_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1412b_V2_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1412b_V2_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_1412b_V2_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_1412b_V2_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1412b_V2_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1412b_V2_bg=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    
    

load myrois_V2

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1412c_V2_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_1412c_V2_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1412c_V2_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1412c_V2_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_1412c_V2_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_1412c_V2_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1412c_V2_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1412c_V2_bg=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    


load myrois_V2

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1412d_V2_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_1412d_V2_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1412d_V2_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1412d_V2_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_1412d_V2_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_1412d_V2_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1412d_V2_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1412d_V2_bg=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    



load myrois_V2

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_1412e_V2_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_1412e_V2_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1412e_V2_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1412e_V2_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_1412e_V2_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_1412e_V2_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_1412e_V2_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_1412e_V2_bg=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    




%% 2212

load myrois_V2

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2212b_V2_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2212b_V2_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2212b_V2_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2212b_V2_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_2212b_V2_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2212b_V2_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2212b_V2_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2212b_V2_bg=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    
    
%taking only the 11th trial and onwards for each condition

load myrois_V2

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2212b_V2_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_left,2:112,11:end),1));'])
    eval(['c',int2str(i),'_2212b_V2_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_right,2:112,11:end),1));'])
    eval(['c',int2str(i),'_2212b_V2_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_middle,2:112,11:end),1));'])
    eval(['c',int2str(i),'_2212b_V2_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circle,2:112,11:end),1));'])
    eval(['c',int2str(i),'_2212b_V2_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_left,2:112,11:end),1));'])
    eval(['c',int2str(i),'_2212b_V2_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_right,2:112,11:end),1));'])
    eval(['c',int2str(i),'_2212b_V2_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_middle,2:112,11:end),1));'])
    eval(['c',int2str(i),'_2212b_V2_bg=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg,2:112,11:end),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    
    
load myrois_V2

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2212c_V2_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_left,2:112,11:end),1));'])
    eval(['c',int2str(i),'_2212c_V2_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_right,2:112,11:end),1));'])
    eval(['c',int2str(i),'_2212c_V2_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_middle,2:112,11:end),1));'])
    eval(['c',int2str(i),'_2212c_V2_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circle,2:112,11:end),1));'])
    eval(['c',int2str(i),'_2212c_V2_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_left,2:112,11:end),1));'])
    eval(['c',int2str(i),'_2212c_V2_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_right,2:112,11:end),1));'])
    eval(['c',int2str(i),'_2212c_V2_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_middle,2:112,11:end),1));'])
    eval(['c',int2str(i),'_2212c_V2_bg=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg,2:112,11:end),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    
    


load myrois_V2

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2212d_V2_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2212d_V2_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2212d_V2_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2212d_V2_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_2212d_V2_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2212d_V2_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2212d_V2_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2212d_V2_bg=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    




%% 2912

load myrois_V2

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2912b_V2_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2912b_V2_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2912b_V2_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912b_V2_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912b_V2_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2912b_V2_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2912b_V2_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912b_V2_bg=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    

%taking only the 11th trial and onwards for each condition


load myrois_V2

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2912b_V2_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_left,2:112,6:end),1));'])
    eval(['c',int2str(i),'_2912b_V2_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_right,2:112,6:end),1));'])
    eval(['c',int2str(i),'_2912b_V2_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_middle,2:112,6:end),1));'])
    eval(['c',int2str(i),'_2912b_V2_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circle,2:112,6:end),1));'])
    eval(['c',int2str(i),'_2912b_V2_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_left,2:112,6:end),1));'])
    eval(['c',int2str(i),'_2912b_V2_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_right,2:112,6:end),1));'])
    eval(['c',int2str(i),'_2912b_V2_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_middle,2:112,6:end),1));'])
    eval(['c',int2str(i),'_2912b_V2_bg=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg,2:112,,6:end),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    

load myrois_V2

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2912c_V2_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2912c_V2_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2912c_V2_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912c_V2_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912c_V2_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2912c_V2_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2912c_V2_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912c_V2_bg=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    



load myrois_V2

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2912d_V2_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2912d_V2_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2912d_V2_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912d_V2_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912d_V2_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2912d_V2_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2912d_V2_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912d_V2_bg=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    



load myrois_V2

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2912e_V2_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2912e_V2_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2912e_V2_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912e_V2_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912e_V2_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2912e_V2_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2912e_V2_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912e_V2_bg=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    




load myrois_V2

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_2912k_V2_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2912k_V2_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2912k_V2_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912k_V2_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912k_V2_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_2912k_V2_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_2912k_V2_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_2912k_V2_bg=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    





%% 0501
load myrois_V2

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_0501b_V2_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_0501b_V2_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_0501b_V2_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_0501b_V2_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_0501b_V2_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_0501b_V2_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_0501b_V2_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_0501b_V2_bg=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    




load myrois_V2

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_0501c_V2_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_0501c_V2_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_0501c_V2_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_0501c_V2_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_0501c_V2_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_0501c_V2_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_0501c_V2_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_0501c_V2_bg=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    



load myrois_V2

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_0501d_V2_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_0501d_V2_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_0501d_V2_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_0501d_V2_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_0501d_V2_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_0501d_V2_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_0501d_V2_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_0501d_V2_bg=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    



load myrois_V2

for i=1:5
    eval(['load cond',int2str(i),'n_dt_bl'])
    eval(['c',int2str(i),'_0501e_V2_circ_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_left,2:112,:),1));'])
    eval(['c',int2str(i),'_0501e_V2_circ_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_right,2:112,:),1));'])
    eval(['c',int2str(i),'_0501e_V2_circ_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circ_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_0501e_V2_circle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_circle,2:112,:),1));'])
    eval(['c',int2str(i),'_0501e_V2_bg_left=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_left,2:112,:),1));'])
    eval(['c',int2str(i),'_0501e_V2_bg_right=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_right,2:112,:),1));'])
    eval(['c',int2str(i),'_0501e_V2_bg_middle=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg_middle,2:112,:),1));'])
    eval(['c',int2str(i),'_0501e_V2_bg=squeeze(mean(cond',int2str(i),'n_dt_bl(roi_V2_bg,2:112,:),1));'])
    eval(['clear cond',int2str(i),'n_dt_bl'])
end    





%% V2 concatanation


cont_V2_circle=c1_1711b_V2_circle;
cont_V2_circle=cat(2,cont_V2_circle,c2_1711b_V2_circle);
cont_V2_circle=cat(2,cont_V2_circle,c1_1711c_V2_circle);
cont_V2_circle=cat(2,cont_V2_circle,c2_1711c_V2_circle);
cont_V2_circle=cat(2,cont_V2_circle,c1_1711g_V2_circle);
cont_V2_circle=cat(2,cont_V2_circle,c2_1711g_V2_circle);
cont_V2_circle=cat(2,cont_V2_circle,c1_2411b_V2_circle);
cont_V2_circle=cat(2,cont_V2_circle,c2_2411b_V2_circle);
cont_V2_circle=cat(2,cont_V2_circle,c1_2411d_V2_circle);
cont_V2_circle=cat(2,cont_V2_circle,c2_2411d_V2_circle);
cont_V2_circle=cat(2,cont_V2_circle,c1_2411f_V2_circle);
cont_V2_circle=cat(2,cont_V2_circle,c2_2411f_V2_circle);
cont_V2_circle=cat(2,cont_V2_circle,c1_1412b_V2_circle);
cont_V2_circle=cat(2,cont_V2_circle,c2_1412b_V2_circle);
cont_V2_circle=cat(2,cont_V2_circle,c1_1412c_V2_circle);
cont_V2_circle=cat(2,cont_V2_circle,c1_1412d_V2_circle);
cont_V2_circle=cat(2,cont_V2_circle,c1_1412e_V2_circle);
cont_V2_circle=cat(2,cont_V2_circle,c1_2212b_V2_circle);
cont_V2_circle=cat(2,cont_V2_circle,c2_2212b_V2_circle);
cont_V2_circle=cat(2,cont_V2_circle,c1_2212c_V2_circle);
cont_V2_circle=cat(2,cont_V2_circle,c1_2212d_V2_circle);
cont_V2_circle=cat(2,cont_V2_circle,c1_2912b_V2_circle);
cont_V2_circle=cat(2,cont_V2_circle,c2_2912b_V2_circle);
%cont_V2_circle=cat(2,cont_V2_circle,c1_2912c_V2_circle);
%cont_V2_circle=cat(2,cont_V2_circle,c2_2912c_V2_circle);
%cont_V2_circle=cat(2,cont_V2_circle,c1_2912d_V2_circle);
%cont_V2_circle=cat(2,cont_V2_circle,c2_2912d_V2_circle);
%cont_V2_circle=cat(2,cont_V2_circle,c1_2912e_V2_circle);
%cont_V2_circle=cat(2,cont_V2_circle,c2_2912e_V2_circle);
%cont_V2_circle=cat(2,cont_V2_circle,c1_2912k_V2_circle);
%cont_V2_circle=cat(2,cont_V2_circle,c2_2912k_V2_circle);
%cont_V2_circle=cat(2,cont_V2_circle,c1_0501b_V2_circle);
%cont_V2_circle=cat(2,cont_V2_circle,c2_0501b_V2_circle);
%cont_V2_circle=cat(2,cont_V2_circle,c1_0501c_V2_circle);
%cont_V2_circle=cat(2,cont_V2_circle,c1_0501d_V2_circle);
cont_V2_circle=cat(2,cont_V2_circle,c1_0501e_V2_circle);
cont_V2_circle=cat(2,cont_V2_circle,c2_0501e_V2_circle);


non_V2_circle=c4_1711b_V2_circle;
non_V2_circle=cat(2,non_V2_circle,c5_1711b_V2_circle);
non_V2_circle=cat(2,non_V2_circle,c4_1711c_V2_circle);
non_V2_circle=cat(2,non_V2_circle,c5_1711c_V2_circle);
non_V2_circle=cat(2,non_V2_circle,c4_1711g_V2_circle);
non_V2_circle=cat(2,non_V2_circle,c5_1711g_V2_circle);
non_V2_circle=cat(2,non_V2_circle,c4_2411b_V2_circle);
non_V2_circle=cat(2,non_V2_circle,c5_2411b_V2_circle);
non_V2_circle=cat(2,non_V2_circle,c4_2411d_V2_circle);
non_V2_circle=cat(2,non_V2_circle,c5_2411d_V2_circle);
non_V2_circle=cat(2,non_V2_circle,c4_2411f_V2_circle);
non_V2_circle=cat(2,non_V2_circle,c5_2411f_V2_circle);
non_V2_circle=cat(2,non_V2_circle,c4_1412b_V2_circle);
non_V2_circle=cat(2,non_V2_circle,c5_1412b_V2_circle);
non_V2_circle=cat(2,non_V2_circle,c5_1412c_V2_circle);
non_V2_circle=cat(2,non_V2_circle,c5_1412d_V2_circle);
non_V2_circle=cat(2,non_V2_circle,c5_1412e_V2_circle);
non_V2_circle=cat(2,non_V2_circle,c4_2212b_V2_circle);
non_V2_circle=cat(2,non_V2_circle,c5_2212b_V2_circle);
non_V2_circle=cat(2,non_V2_circle,c5_2212c_V2_circle);
non_V2_circle=cat(2,non_V2_circle,c5_2212d_V2_circle);
non_V2_circle=cat(2,non_V2_circle,c4_2912b_V2_circle);
non_V2_circle=cat(2,non_V2_circle,c5_2912b_V2_circle);
%non_V2_circle=cat(2,non_V2_circle,c4_2912c_V2_circle);
%non_V2_circle=cat(2,non_V2_circle,c5_2912c_V2_circle);
%non_V2_circle=cat(2,non_V2_circle,c4_2912d_V2_circle);
%non_V2_circle=cat(2,non_V2_circle,c5_2912d_V2_circle);
%non_V2_circle=cat(2,non_V2_circle,c4_2912e_V2_circle);
%non_V2_circle=cat(2,non_V2_circle,c5_2912e_V2_circle);
%non_V2_circle=cat(2,non_V2_circle,c4_2912k_V2_circle);
%non_V2_circle=cat(2,non_V2_circle,c5_2912k_V2_circle);
%non_V2_circle=cat(2,non_V2_circle,c4_0501b_V2_circle);
%non_V2_circle=cat(2,non_V2_circle,c5_0501b_V2_circle);
%non_V2_circle=cat(2,non_V2_circle,c5_0501c_V2_circle);
%non_V2_circle=cat(2,non_V2_circle,c5_0501d_V2_circle);
non_V2_circle=cat(2,non_V2_circle,c4_0501e_V2_circle);
non_V2_circle=cat(2,non_V2_circle,c5_0501e_V2_circle);





cont_V2_bg=c1_2912e_V2_bg;
%cont_V2_bg=cat(2,cont_V2_bg,c2_1711b_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c1_1711c_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c2_1711c_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c1_1711g_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c2_1711g_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c1_2411b_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c2_2411b_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c1_2411d_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c2_2411d_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c1_2411f_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c2_2411f_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c1_1412b_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c2_1412b_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c1_1412c_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c1_1412d_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c1_1412e_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c1_2212b_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c2_2212b_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c1_2212c_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c1_2212d_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c1_2912b_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c2_2912b_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c2_2912c_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c1_2912d_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c2_2912d_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c1_2912e_V2_bg);
cont_V2_bg=cat(2,cont_V2_bg,c2_2912e_V2_bg);
cont_V2_bg=cat(2,cont_V2_bg,c1_2912k_V2_bg);
cont_V2_bg=cat(2,cont_V2_bg,c2_2912k_V2_bg);
cont_V2_bg=cat(2,cont_V2_bg,c1_0501b_V2_bg);
cont_V2_bg=cat(2,cont_V2_bg,c2_0501b_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c1_0501c_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c1_0501d_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c1_0501e_V2_bg);
%cont_V2_bg=cat(2,cont_V2_bg,c2_0501e_V2_bg);


non_V2_bg=c4_2912e_V2_bg;
%non_V2_bg=cat(2,non_V2_bg,c5_1711b_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c4_1711c_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c5_1711c_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c4_1711g_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c5_1711g_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c4_2411b_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c5_2411b_V2_bg);
%%non_V2_bg=cat(2,non_V2_bg,c4_2411d_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c5_2411d_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c4_2411f_V2_bg);
%%non_V2_bg=cat(2,non_V2_bg,c5_2411f_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c4_1412b_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c5_1412b_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c5_1412c_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c5_1412d_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c5_1412e_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c4_2212b_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c5_2212b_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c5_2212c_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c5_2212d_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c4_2912b_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c5_2912b_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c5_2912c_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c4_2912d_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c5_2912d_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c4_2912e_V2_bg);
non_V2_bg=cat(2,non_V2_bg,c5_2912e_V2_bg);
non_V2_bg=cat(2,non_V2_bg,c4_2912k_V2_bg);
non_V2_bg=cat(2,non_V2_bg,c5_2912k_V2_bg);
non_V2_bg=cat(2,non_V2_bg,c4_0501b_V2_bg);
non_V2_bg=cat(2,non_V2_bg,c5_0501b_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c5_0501c_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c5_0501d_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c4_0501e_V2_bg);
%non_V2_bg=cat(2,non_V2_bg,c5_0501e_V2_bg);






%%


cont_V2_circle(:,1)=mean(c1_1711b_V2_circle,2);
cont_V2_circle(:,2)=mean(c2_1711b_V2_circle,2);
cont_V2_circle(:,3)=mean(c1_1711c_V2_circle,2);
cont_V2_circle(:,4)=mean(c2_1711c_V2_circle,2);
cont_V2_circle(:,5)=mean(c1_1711g_V2_circle,2);
cont_V2_circle(:,6)=mean(c2_1711g_V2_circle,2);
cont_V2_circle(:,7)=mean(c1_2411b_V2_circle,2);
cont_V2_circle(:,8)=mean(c2_2411b_V2_circle,2);
cont_V2_circle(:,9)=mean(c1_2411d_V2_circle,2);
cont_V2_circle(:,10)=mean(c2_2411d_V2_circle,2);
cont_V2_circle(:,11)=mean(c1_2411f_V2_circle,2);
cont_V2_circle(:,12)=mean(c2_2411f_V2_circle,2);
cont_V2_circle(:,13)=mean(c1_1412b_V2_circle,2);
cont_V2_circle(:,14)=mean(c2_1412b_V2_circle,2);
cont_V2_circle(:,15)=mean(c1_1412c_V2_circle,2);
cont_V2_circle(:,16)=mean(c1_1412d_V2_circle,2);
cont_V2_circle(:,17)=mean(c1_1412e_V2_circle,2);
cont_V2_circle(:,18)=mean(c1_2212b_V2_circle,2);
cont_V2_circle(:,19)=mean(c2_2212b_V2_circle,2);
cont_V2_circle(:,20)=mean(c1_2212c_V2_circle,2);
cont_V2_circle(:,21)=mean(c1_2212d_V2_circle,2);
cont_V2_circle(:,22)=mean(c1_2912b_V2_circle,2);
cont_V2_circle(:,23)=mean(c2_2912b_V2_circle,2);
cont_V2_circle(:,24)=mean(c1_2912c_V2_circle,2);
cont_V2_circle(:,25)=mean(c2_2912c_V2_circle,2);
cont_V2_circle(:,26)=mean(c1_2912d_V2_circle,2);
cont_V2_circle(:,27)=mean(c2_2912d_V2_circle,2);
cont_V2_circle(:,28)=mean(c1_2912e_V2_circle,2);
cont_V2_circle(:,29)=mean(c2_2912e_V2_circle,2);
cont_V2_circle(:,30)=mean(c1_2912k_V2_circle,2);
cont_V2_circle(:,31)=mean(c2_2912k_V2_circle,2);
cont_V2_circle(:,32)=mean(c1_0501b_V2_circle,2);
cont_V2_circle(:,33)=mean(c2_0501b_V2_circle,2);
cont_V2_circle(:,34)=mean(c1_0501c_V2_circle,2);
cont_V2_circle(:,35)=mean(c1_0501d_V2_circle,2);
cont_V2_circle(:,36)=mean(c1_0501e_V2_circle,2);
cont_V2_circle(:,37)=mean(c2_0501e_V2_circle,2);


non_V2_circle(:,1)=mean(c4_1711b_V2_circle,2);
non_V2_circle(:,2)=mean(c5_1711b_V2_circle,2);
non_V2_circle(:,3)=mean(c4_1711c_V2_circle,2);
non_V2_circle(:,4)=mean(c5_1711c_V2_circle,2);
non_V2_circle(:,5)=mean(c4_1711g_V2_circle,2);
non_V2_circle(:,6)=mean(c5_1711g_V2_circle,2);
non_V2_circle(:,7)=mean(c4_2411b_V2_circle,2);
non_V2_circle(:,8)=mean(c5_2411b_V2_circle,2);
non_V2_circle(:,9)=mean(c4_2411d_V2_circle,2);
non_V2_circle(:,10)=mean(c5_2411d_V2_circle,2);
non_V2_circle(:,11)=mean(c4_2411f_V2_circle,2);
non_V2_circle(:,12)=mean(c5_2411f_V2_circle,2);
non_V2_circle(:,13)=mean(c4_1412b_V2_circle,2);
non_V2_circle(:,14)=mean(c5_1412b_V2_circle,2);
non_V2_circle(:,15)=mean(c5_1412c_V2_circle,2);
non_V2_circle(:,16)=mean(c5_1412d_V2_circle,2);
non_V2_circle(:,17)=mean(c5_1412e_V2_circle,2);
non_V2_circle(:,18)=mean(c4_2212b_V2_circle,2);
non_V2_circle(:,19)=mean(c5_2212b_V2_circle,2);
non_V2_circle(:,20)=mean(c5_2212c_V2_circle,2);
non_V2_circle(:,21)=mean(c5_2212d_V2_circle,2);
non_V2_circle(:,22)=mean(c4_2912b_V2_circle,2);
non_V2_circle(:,23)=mean(c5_2912b_V2_circle,2);
non_V2_circle(:,24)=mean(c4_2912c_V2_circle,2);
non_V2_circle(:,25)=mean(c5_2912c_V2_circle,2);
non_V2_circle(:,26)=mean(c4_2912d_V2_circle,2);
non_V2_circle(:,27)=mean(c5_2912d_V2_circle,2);
non_V2_circle(:,28)=mean(c4_2912e_V2_circle,2);
non_V2_circle(:,29)=mean(c5_2912e_V2_circle,2);
non_V2_circle(:,30)=mean(c4_2912k_V2_circle,2);
non_V2_circle(:,31)=mean(c5_2912k_V2_circle,2);
non_V2_circle(:,32)=mean(c4_0501b_V2_circle,2);
non_V2_circle(:,33)=mean(c5_0501b_V2_circle,2);
non_V2_circle(:,34)=mean(c5_0501c_V2_circle,2);
non_V2_circle(:,35)=mean(c5_0501d_V2_circle,2);
non_V2_circle(:,36)=mean(c4_0501e_V2_circle,2);
non_V2_circle(:,37)=mean(c5_0501e_V2_circle,2);





cont_V2_bg(:,1)=mean(c1_1711b_V2_bg,2);
cont_V2_bg(:,2)=mean(c2_1711b_V2_bg,2);
cont_V2_bg(:,3)=mean(c1_1711c_V2_bg,2);
cont_V2_bg(:,4)=mean(c2_1711c_V2_bg,2);
cont_V2_bg(:,5)=mean(c1_1711g_V2_bg,2);
cont_V2_bg(:,6)=mean(c2_1711g_V2_bg,2);
cont_V2_bg(:,7)=mean(c1_2411b_V2_bg,2);
cont_V2_bg(:,8)=mean(c2_2411b_V2_bg,2);
cont_V2_bg(:,9)=mean(c1_2411d_V2_bg,2);
cont_V2_bg(:,10)=mean(c2_2411d_V2_bg,2);
cont_V2_bg(:,11)=mean(c1_2411f_V2_bg,2);
cont_V2_bg(:,12)=mean(c2_2411f_V2_bg,2);
cont_V2_bg(:,13)=mean(c1_1412b_V2_bg,2);
cont_V2_bg(:,14)=mean(c2_1412b_V2_bg,2);
cont_V2_bg(:,15)=mean(c1_1412c_V2_bg,2);
cont_V2_bg(:,16)=mean(c1_1412d_V2_bg,2);
cont_V2_bg(:,17)=mean(c1_1412e_V2_bg,2);
cont_V2_bg(:,18)=mean(c1_2212b_V2_bg,2);
cont_V2_bg(:,19)=mean(c2_2212b_V2_bg,2);
cont_V2_bg(:,20)=mean(c1_2212c_V2_bg,2);
cont_V2_bg(:,21)=mean(c1_2212d_V2_bg,2);
cont_V2_bg(:,22)=mean(c1_2912b_V2_bg,2);
cont_V2_bg(:,23)=mean(c2_2912b_V2_bg,2);
cont_V2_bg(:,24)=mean(c1_2912c_V2_bg,2);
cont_V2_bg(:,25)=mean(c2_2912c_V2_bg,2);
cont_V2_bg(:,26)=mean(c1_2912d_V2_bg,2);
cont_V2_bg(:,27)=mean(c2_2912d_V2_bg,2);
cont_V2_bg(:,28)=mean(c1_2912e_V2_bg,2);
cont_V2_bg(:,29)=mean(c2_2912e_V2_bg,2);
cont_V2_bg(:,30)=mean(c1_2912k_V2_bg,2);
cont_V2_bg(:,31)=mean(c2_2912k_V2_bg,2);
cont_V2_bg(:,32)=mean(c1_0501b_V2_bg,2);
cont_V2_bg(:,33)=mean(c2_0501b_V2_bg,2);
cont_V2_bg(:,34)=mean(c1_0501c_V2_bg,2);
cont_V2_bg(:,35)=mean(c1_0501d_V2_bg,2);
cont_V2_bg(:,36)=mean(c1_0501e_V2_bg,2);
cont_V2_bg(:,37)=mean(c2_0501e_V2_bg,2);



non_V2_bg(:,1)=mean(c4_1711b_V2_bg,2);
non_V2_bg(:,2)=mean(c5_1711b_V2_bg,2);
non_V2_bg(:,3)=mean(c4_1711c_V2_bg,2);
non_V2_bg(:,4)=mean(c5_1711c_V2_bg,2);
non_V2_bg(:,5)=mean(c4_1711g_V2_bg,2);
non_V2_bg(:,6)=mean(c5_1711g_V2_bg,2);
non_V2_bg(:,7)=mean(c4_2411b_V2_bg,2);
non_V2_bg(:,8)=mean(c5_2411b_V2_bg,2);
non_V2_bg(:,9)=mean(c4_2411d_V2_bg,2);
non_V2_bg(:,10)=mean(c5_2411d_V2_bg,2);
non_V2_bg(:,11)=mean(c4_2411f_V2_bg,2);
non_V2_bg(:,12)=mean(c5_2411f_V2_bg,2);
non_V2_bg(:,13)=mean(c4_1412b_V2_bg,2);
non_V2_bg(:,14)=mean(c5_1412b_V2_bg,2);
non_V2_bg(:,15)=mean(c5_1412c_V2_bg,2);
non_V2_bg(:,16)=mean(c5_1412d_V2_bg,2);
non_V2_bg(:,17)=mean(c5_1412e_V2_bg,2);
non_V2_bg(:,18)=mean(c4_2212b_V2_bg,2);
non_V2_bg(:,19)=mean(c5_2212b_V2_bg,2);
non_V2_bg(:,20)=mean(c5_2212c_V2_bg,2);
non_V2_bg(:,21)=mean(c5_2212d_V2_bg,2);
non_V2_bg(:,22)=mean(c4_2912b_V2_bg,2);
non_V2_bg(:,23)=mean(c5_2912b_V2_bg,2);
non_V2_bg(:,24)=mean(c4_2912c_V2_bg,2);
non_V2_bg(:,25)=mean(c5_2912c_V2_bg,2);
non_V2_bg(:,26)=mean(c4_2912d_V2_bg,2);
non_V2_bg(:,27)=mean(c5_2912d_V2_bg,2);
non_V2_bg(:,28)=mean(c4_2912e_V2_bg,2);
non_V2_bg(:,29)=mean(c5_2912e_V2_bg,2);
non_V2_bg(:,30)=mean(c4_2912k_V2_bg,2);
non_V2_bg(:,31)=mean(c5_2912k_V2_bg,2);
non_V2_bg(:,32)=mean(c4_0501b_V2_bg,2);
non_V2_bg(:,33)=mean(c5_0501b_V2_bg,2);
non_V2_bg(:,34)=mean(c5_0501c_V2_bg,2);
non_V2_bg(:,35)=mean(c5_0501d_V2_bg,2);
non_V2_bg(:,36)=mean(c4_0501e_V2_bg,2);
non_V2_bg(:,37)=mean(c5_0501e_V2_bg,2);







