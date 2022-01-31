%% fluorescence amplitude versus retinal slip velocity
figure(1); hold on
scatter(rs_peak_amps,cal_peak_amps,'Filled','g');
h = plot(fitLineCalRS);
h(1).Marker = 'none';
h(2).Color = 'g';
h(3).Color = 'g';
h(4).Color = 'g';
title('Retinal slip velocity vs Fluorescence amplitude');
ylabel('Fluorescence amplitude');
xlabel('Retinal slip velocity');
str = {r2calRS};
text(prctile(rs_peak_amps,40),prctile(cal_peak_amps,80),str,'FontSize',16,'VerticalAlignment','bottom');

%% fluorescence amplitude versus retinal slip velocity (normalized to spontaneous)
figure(2); hold on
scatter(rs_peak_amps,calNorm,'Filled','g');
h = plot(fitLineCalNormRS);
h(1).Marker = 'none';
h(2).Color = 'g';
h(3).Color = 'g';
h(4).Color = 'g';
title('Fluorescence amplitude (normalized) vs. retinal slip velocity');
ylabel('Fluorescence amplitude (normalized)');
xlabel('Retinal slip velocity');
str = {r2calNormRS};
text(prctile(rs_peak_amps,40),prctile(calNorm,80),str,'FontSize',16,'VerticalAlignment','bottom');

%% fluorescence amplitude versus retinal slip velocity (restricted window)
if smallWindow == 1;
    figure(3); hold on
    scatter(rsPeaks,calPeaks,'Filled','g');
    h = plot(fitLineCalRS);
    h(1).Marker = 'none';
    h(2).Color = 'g';
    h(3).Color = 'g';
    h(4).Color = 'g';
    title('Fluorescence amplitude vs. retinal slip velocity');
    ylabel('Fluorescence amplitude');
    xlabel('Retinal slip velocity');
    str = {r2calRS};
    text(prctile(rsPeaks,40),prctile(calPeaks,80),str,'FontSize',16,'VerticalAlignment','bottom');
end

%% fluorescence amplitude as a function of delay re peak retinal slip velocity
figure(4); hold on
scatter(calRSidxs,cal_peak_amps,'Filled','g');
h = plot(fitLineCalRStime);
h(1).Marker = 'none';
h(2).Color = 'g';
h(3).Color = 'g';
h(4).Color = 'g';
title('Fluorescence amplitude vs. delay re retinal slip');
xlabel('Delay re retinal slip');
ylabel('Fluorescence amplitude');
str = {r2calRStime};
text(prctile(calRSidxs,40),prctile(cal_peak_amps,80),str,'FontSize',16,'VerticalAlignment','bottom');

%% fluorescence amplitude as a function of eye velocity
figure(5); hold on
scatter(eyeL_peak_amps,cal_peak_amps,'filled','g');
scatter(eyeD_peak_amps,calD_peak_amps,'filled','b');
fit = plot(fitLineCalEyeL);
fit(1).Marker = 'none';
fit(2).Color = 'g';
fit(3).Color = 'g';
fit(4).Color = 'g';
h = plot(fitLineCalEyeD);
h(1).Marker = 'none';
h(2).Color = 'b';
h(3).Color = 'b';
h(4).Color = 'b';
title('Fluorescence amplitude vs eye amplitude');
legend('Visual','Vestibular-dark');
ylabel('Fluorescence amplitude');
xlabel('Eye velocity');
str = {r2calEyeL};
str2 = {r2calEyeD};
text(prctile(eyeL_peak_amps,55),prctile(cal_peak_amps,80),str,'FontSize',16,'VerticalAlignment','bottom');
text(prctile(eyeD_peak_amps,55),prctile(calD_peak_amps,80),str2,'FontSize',16,'VerticalAlignment','top');

%% fluorescence amplitude as a function of eye velocity (normalized to spontaneous)
figure(6); hold on
scatter(eyeL_peak_amps,calNorm,'filled','g');
scatter(eyeD_peak_amps,calDnorm,'filled','b');
fit = plot(fitLineCalNormEyeL);
fit(1).Marker = 'none';
fit(2).Color = 'g';
fit(3).Color = 'g';
fit(4).Color = 'g';
h = plot(fitLineCalNormEyeD);
h(1).Marker = 'none';
h(2).Color = 'b';
h(3).Color = 'b';
h(4).Color = 'b';
title('Normalized fluorescence amplitude vs. eye amplitude');
legend('Visual','Vestibular-dark');
ylabel('Fluorescence amplitude');
xlabel('Eye velocity');
str = {r2calNormEyeL};
str2 = {r2calNormEyeD};
text(prctile(eyeL_peak_amps,80),prctile(calNorm,55),str,'FontSize',16,'VerticalAlignment','bottom');
text(prctile(eyeD_peak_amps,80),prctile(calDnorm,55),str2,'FontSize',16,'VerticalAlignment','top');

%% fluorescence amplitude as a function of eye velocity (restricted window)
% if smallWindow == 1
% figure(7); hold on
% scatter(eyeL_peak_amps,calNorm,'filled','g');
% scatter(eyeD_peak_amps,calDnorm,'filled','b');
% fit = plot(fitLineCalNormEyeL);
% fit(1).Marker = 'none';
% fit(2).Color = 'g';
% fit(3).Color = 'g';
% fit(4).Color = 'g';
% h = plot(fitLineCalNormEyeD);
% h(1).Marker = 'none';
% h(2).Color = 'b';
% h(3).Color = 'b';
% h(4).Color = 'b';
% title('Normalized fluorescence amplitude vs. eye amplitude');
% legend('Visual','Vestibular-dark');
% ylabel('Fluorescence amplitude');
% xlabel('Eye velocity');
% str = {r2calNormEyeL};
% str2 = {r2calNormEyeD};
% text(prctile(eyeL_peak_amps,80),prctile(calNorm,55),str,'FontSize',16,'VerticalAlignment','bottom');
% text(prctile(eyeD_peak_amps,80),prctile(calDnorm,55),str2,'FontSize',16,'VerticalAlignment','top');
% end
%% fluorescence amplitude as a function of the delay re peak eye velocity
figure(8); hold on
scatter(calEyeLidxs,cal_peak_amps,'Filled','g');
scatter(calEyeDidxs,calD_peak_amps,'Filled','b');
fit = plot(fitLineCalEyeLtime);
fit(1).Marker = 'none';
fit(2).Color = 'g';
fit(3).Color = 'g';
fit(4).Color = 'g';
h = plot(fitLineCalEyeDtime);
h(1).Marker = 'none';
h(2).Color = 'b';
h(3).Color = 'b';
h(4).Color = 'b';
title('Fluorescence amplitude vs. delay re eye');
legend('Visual','Vestibular-dark');
xlabel('Delay re eye');
ylabel('Fluorescence amplitude');
str = {r2calEyeLtime};
str2 = {r2calEyeDtime};
text(prctile(calEyeLidxs,63),prctile(cal_peak_amps,80),str,'FontSize',16,'VerticalAlignment','bottom','color','g');
text(prctile(calEyeDidxs,62),prctile(calD_peak_amps,50),str2,'FontSize',16,'VerticalAlignment','bottom','color','b');

%% fluorescence amplitude as a function of peak head velocity
figure(9); hold on
scatter(headvel_peak_amps,cal_peak_amps,'Filled','g');
scatter(headvelD_peak_amps,calD_peak_amps,'Filled','b');
fit = plot(fitLineCalHead);
fit(1).Marker = 'none';
fit(2).Color = 'g';
fit(3).Color = 'g';
fit(4).Color = 'g';
h = plot(fitLineCalHeadD);
h(1).Marker = 'none';
h(2).Color = 'b';
h(3).Color = 'b';
h(4).Color = 'b';
title('Fluorescence amplitude vs head velocity');
legend('Visual','Vestibular-dark');
xlabel('Head velocity');
ylabel('Fluorescence amplitude');
str = {r2calHead};
str2 = {r2calHeadD};
text(prctile(headvel_peak_amps,70),prctile(cal_peak_amps,80),str,'FontSize',16,'VerticalAlignment','bottom');
text(prctile(headvelD_peak_amps,67),prctile(calD_peak_amps,80),str2,'FontSize',16,'VerticalAlignment','top');

%% Normalized fluorescence amplitude as a function of peak head velocity
figure(10); hold on
scatter(headvel_peak_amps,calNorm,'Filled','g');
scatter(headvelD_peak_amps,calDnorm,'Filled','b');
fit = plot(fitLineCalNormHead);
fit(1).Marker = 'none';
fit(2).Color = 'g';
fit(3).Color = 'g';
fit(4).Color = 'g';
h = plot(fitLineCalNormHeadD);
h(1).Marker = 'none';
h(2).Color = 'b';
h(3).Color = 'b';
h(4).Color = 'b';
title('Fluorescence amplitude vs head velocity');
legend('Visual','Vestibular-dark');
xlabel('Head velocity');
ylabel('Fluorescence amplitude');
str = {r2calNormHead};
str2 = {r2calNormHeadD};
text(prctile(headvel_peak_amps,70),prctile(calNorm,80),str,'FontSize',16,'VerticalAlignment','bottom');
text(prctile(headvelD_peak_amps,67),prctile(calDnorm,80),str2,'FontSize',16,'VerticalAlignment','top');

%% Normalized fluorescence amplitude as a function of the delay re peak head velocity
figure(11); hold on
scatter(calHeadvelIdxs,cal_peak_amps,'Filled','g');
scatter(calHeadvelDidxs,calD_peak_amps,'Filled','b');
fit = plot(fitLineCalHeadTime);
fit(1).Marker = 'none';
fit(2).Color = 'g';
fit(3).Color = 'g';
fit(4).Color = 'g';
h = plot(fitLineCalHeadDtime);
h(1).Marker = 'none';
h(2).Color = 'b';
h(3).Color = 'b';
h(4).Color = 'b';
title('Fluorescence amplitude vs head velocity');
legend('Visual','Vestibular-dark');
xlabel('Head velocity');
ylabel('Fluorescence amplitude');
str = {r2calHeadTime};
str2 = {r2calHeadDtime};
text(prctile(calHeadvelIdxs,70),prctile(cal_peak_amps,80),str,'FontSize',16,'VerticalAlignment','bottom');
text(prctile(calHeadvelDidxs,67),prctile(calD_peak_amps,80),str2,'FontSize',16,'VerticalAlignment','top');

%% Fluorescence area under the curve vs peak retinal slip veloctiy
figure(12); hold on
scatter(rs_peak_amps,calLauc,'Filled','g');
fit = plot(fitLineCalAucRS);
fit(1).Marker = 'none';
fit(2).Color = 'g';
fit(3).Color = 'g';
fit(4).Color = 'g';
title('Fluorescence AUC vs. retinal slip velocity');
xlabel('Retinal slip velocity');
ylabel('Fluorescence AUC');
str = {r2calAucRS};
text(prctile(rs_peak_amps,63),prctile(calLauc,80),str,'FontSize',16,'VerticalAlignment','bottom','color','g');

%% Fluorescence area under the curve vs the delay of peak calcium relative to peak retinal slip velocity
figure(13); hold on
scatter(calRSidxs,calLauc,'Filled','g');
fit = plot(fitLineCalAucRStime);
fit(1).Marker = 'none';
fit(2).Color = 'g';
fit(3).Color = 'g';
fit(4).Color = 'g';
title('Fluorescence AUC vs. delay re retinal slip velocity peak');
xlabel('Delay re peak retinal slip velocity');
ylabel('Fluorescence AUC');
str = {r2calAucRS};
text(prctile(calRSidxs,63),prctile(calLauc,80),str,'FontSize',16,'VerticalAlignment','bottom','color','g');

