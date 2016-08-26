
%1100 delay
cd D:\intrinsic\20150128\mouse_tgg6fl23_2\c\Matt_files
load behavior
perf_go_ave=perf_go;
perf_nogo_ave=perf_nogo;
perf_tot_ave=perf_tot;
early_ave=num_early;


cd D:\intrinsic\20150129\mouse_tgg6fl23_2\c\Matt_files
load behavior
perf_go_ave=cat(2,perf_go_ave,perf_go);
perf_nogo_ave=cat(2,perf_nogo_ave,perf_nogo);
perf_tot_ave=cat(2,perf_tot_ave,perf_tot);
early_ave=cat(2,early_ave,num_early);


cd D:\intrinsic\20150130\mouse_tgg6fl23_2\b\Matt_files
load behavior
perf_go_ave=cat(2,perf_go_ave,perf_go);
perf_nogo_ave=cat(2,perf_nogo_ave,perf_nogo);
perf_tot_ave=cat(2,perf_tot_ave,perf_tot);
early_ave=cat(2,early_ave,num_early);


cd D:\intrinsic\20150130\mouse_tgg6fl23_2\c\Matt_files
load behavior
perf_go_ave=cat(2,perf_go_ave,perf_go);
perf_nogo_ave=cat(2,perf_nogo_ave,perf_nogo);
perf_tot_ave=cat(2,perf_tot_ave,perf_tot);
early_ave=cat(2,early_ave,num_early);


%800 delay

cd D:\intrinsic\20150128\mouse_tgg6fl23_2\a\Matt_files
load behavior
perf_go_ave=cat(2,perf_go_ave,perf_go);
perf_nogo_ave=cat(2,perf_nogo_ave,perf_nogo);
perf_tot_ave=cat(2,perf_tot_ave,perf_tot);
early_ave=cat(2,early_ave,num_early);


cd D:\intrinsic\20150128\mouse_tgg6fl23_2\b\Matt_files
load behavior
perf_go_ave=cat(2,perf_go_ave,perf_go);
perf_nogo_ave=cat(2,perf_nogo_ave,perf_nogo);
perf_tot_ave=cat(2,perf_tot_ave,perf_tot);
early_ave=cat(2,early_ave,num_early);


cd D:\intrinsic\20150129\mouse_tgg6fl23_2\a\Matt_files
load behavior
perf_go_ave=cat(2,perf_go_ave,perf_go);
perf_nogo_ave=cat(2,perf_nogo_ave,perf_nogo);
perf_tot_ave=cat(2,perf_tot_ave,perf_tot);
early_ave=cat(2,early_ave,num_early);

cd D:\intrinsic\20150130\mouse_tgg6fl23_2\a\Matt_files
load behavior
perf_go_ave=cat(2,perf_go_ave,perf_go);
perf_nogo_ave=cat(2,perf_nogo_ave,perf_nogo);
perf_tot_ave=cat(2,perf_tot_ave,perf_tot);
early_ave=cat(2,early_ave,num_early);


m=[nanmean(perf_tot_ave) nanmean(perf_go_ave) nanmean(perf_nogo_ave) nanmean(early_ave)];
s=[nanstd(perf_tot_ave) nanstd(perf_go_ave) nanstd(perf_nogo_ave) nanstd(early_ave)]/sqrt(size(perf_go_ave,2));
figure;bar(m)
hold on 
errorbar(m,s,'Linestyle','none')













