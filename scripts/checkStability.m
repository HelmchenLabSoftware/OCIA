% check stability

load('D:\OldStuff\AnalysisAuditoryLearning\2013\mou_bl_130711_01\multiDayAnalysis\ROIStatsGlobalDay_all');

days = unique(ROIStatsGlobal(:, 1));
nDays = numel(days);

ROIStats = nan(

for iDay = 1 : nDays;