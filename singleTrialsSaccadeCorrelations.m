%% average spontaneous fp - eye time indexes
z = cat(1,eyeL_peak_diffs,eyeD_peak_diffs,eyeSp_peak_diffs)
za = reshape(z,[],1);
zab = nanmean(za,1)
%% 
figure(2); hold on;
scatter(cal_peak_idxs,eyeL_peak_idxs,'Filled','b');
scatter(calD_peak_idxs,eyeD_peak_idxs,'Filled','r');
scatter(calSp_peak_idxs,eyeSp_peak_idxs,'Filled','g');
fit = plot(fitLineEyeLidx);
fit(1).Marker = 'none';
fit(2).Color = 'b';
fit(3).Color = 'b';
fit(4).Color = 'b';
h = plot(fitLineEyeDidx);
h(1).Marker = 'none';
h(2).Color = 'r';
h(3).Color = 'r';
h(4).Color = 'r';
title('Calcium delay vs. eye delay');
legend('Light','Dark');
xlabel('Calcium delay');
ylabel('Eye delay');
str = {r2eyeLtime};
str2 = {r2eyeDtime};
text(prctile(cal_peak_idxs,80),prctile(eyeL_peak_idxs,63),str,'FontSize',16,'VerticalAlignment','bottom');
text(prctile(cal_peak_idxs,50),prctile(eyeD_peak_idxs,62),str2,'FontSize',16,'VerticalAlignment','top');
%% 
figure(3); hold on;
scatter(eyeL_peak_diffs,eyeLdiffs,'Filled','b');
scatter(eyeD_peak_diffs,eyeDdiffs,'Filled','r');
scatter(eyeSp_peak_diffs,eyeSpDiffs,'Filled','g');
scatter(eyeLdiffsAvg,avgL,'Filled','k');
scatter(eyeDdiffsAvg,avgD,'Filled','k');
scatter(eyeSpDiffsAvg,avgSp,'Filled','k');
title('Calcium time re eye');
legend('Light','Dark','Sp');
xlabel('Time difference');
axis([-1 1 0 1]);
%% 

figure(4);
hold on
scatter(calSpPeakAmpsE,eyeSpPeakDiffs,'Filled','g');
hSp = plot(fitLineEyeSpTime);
hSp(1).Marker = 'none';
hSp(2).Color = 'g';
hSp(3).Color = 'g';
hSp(4).Color = 'g';
str3 = {r2eyeSpTime};
text(prctile(calSpPeakAmpsE,62),prctile(eyeSpPeakDiffs,62),str3,'FontSize',16,'VerticalAlignment','top','color','g');

%% 
figure(6);
hold on
scatter(cal_peak_amps,eyeL_peak_amps,'filled','b');
scatter(cal_peak_amps,eyeD_peak_amps,'filled','r');
fit = plot(fitLineEyeL);
fit(1).Marker = 'none';
fit(2).Color = 'b';
fit(3).Color = 'b';
fit(4).Color = 'b';
h = plot(fitLineEyeD);
h(1).Marker = 'none';
h(2).Color = 'r';
h(3).Color = 'r';
h(4).Color = 'r';
title('Calcium amplitude vs. eye amplitude')
legend('Light','Dark');
xlabel('Calcium amplitude')
ylabel('Eye velocity')
str = {r2eyeL};
str2 = {r2eyeD};
text(prctile(cal_peak_amps,80),prctile(eyeL_peak_amps,55),str,'FontSize',16,'VerticalAlignment','bottom');
text(prctile(cal_peak_amps,80),prctile(eyeD_peak_amps,55),str2,'FontSize',16,'VerticalAlignment','top');

%% Saccade histogram plots and counts
histogram(eyeD_peak_idxs);
histogram(eyeL_peak_idxs);
histogram(eyeSp_peak_idxs);

histogram(eyeL_peak_diffs);
histogram(eyeD_peak_diffs);
histogram(eyeSp_peak_diffs);

eyeD_peak_diffs = eyeD_peak_diffs(~isnan(eyeD_peak_diffs));
eyeL_peak_diffs = eyeL_peak_diffs(~isnan(eyeL_peak_diffs));
eyeSp_peak_diffs = eyeSp_peak_diffs(~isnan(eyeSp_peak_diffs));

eyeCountsD = numel(eyeD_peak_diffs);
eyeCountsL = numel(eyeL_peak_diffs);
eyeCountsSp = numel(eyeSp_peak_diffs);