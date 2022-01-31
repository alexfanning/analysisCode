%plot segment averages and shaded standard error for X0
lightAll1 = lightX0avg + lightX0se;
lightAll2 = lightX0avg - lightX0se;
lightX2all1 = lightX2avg + lightX2se;
lightX2all2 = lightX2avg - lightX2se;
lightOKRall1 = lightAllAvg + lightAllSE;
lightOKRall2 = lightAllAvg - lightAllSE;
darkAll1 = darkComboAvg + darkComboSE;
darkAll2 = darkComboAvg - darkComboSE;
spAll1 = spComboAvg + spComboSE;
spAll2 = spComboAvg - spComboSE;
x = 1:39;
x = x';

figure(1); hold on;
plot(lightX0avg);
shade(x,lightAll1,x,lightAll2,'FillType',[1 2],'FillColor','b','FillAlpha',0.5);
plot(lightX2avg);
shade(x,lightX2all1,x,lightX2all2,'FillType',[1 2],'FillColor','r','FillAlpha',0.5);
plot(lightAllAvg);
shade(x,lightOKRall1,x,lightOKRall2,'FillType',[1 2],'FillColor','g','FillAlpha',0.5);
plot(darkComboAvg);
shade(x,darkAll1,x,darkAll2,'FillType',[1 2],'FillColor','y','FillAlpha',0.5);
plot(spComboAvg);
shade(x,spAll1,x,spAll2,'FillType',[1 2],'FillColor','k','FillAlpha',0.5);

%% 
scatter(rsPeaksX0(:,1),calPeaksX0(:,1));
hold on
scatter(rsPeaksX0(:,2),calPeaksX0(:,2));
scatter(rsPeaksX0(:,3),calPeaksX0(:,3));
scatter(rsPeaksX0(:,4),calPeaksX0(:,4));
scatter(rsPeaksX0(:,5),calPeaksX0(:,5));
scatter(rsPeaksX0(:,6),calPeaksX0(:,6));
scatter(rsPeaksX0(:,7),calPeaksX0(:,7));
calPeaksX0cat = cat(1,calRSx0{1}(:,4),calRSx0{2}(:,4),calRSx0{3}(:,4),calRSx0{4}(:,4),calRSx0{5}(:,4),calRSx0{6}(:,4),calRSx0{7}(:,4));
rsPeaksX0cat = cat(1,calRSx0{1}(:,2),calRSx0{2}(:,2),calRSx0{3}(:,2),calRSx0{4}(:,2),calRSx0{5}(:,2),calRSx0{6}(:,2),calRSx0{7}(:,2));
calPeaksX0cat = calPeaksX0cat(~isnan(calPeaksX0cat));
rsPeaksX0cat = rsPeaksX0cat(~isnan(rsPeaksX0cat));
figure(2);
scatter(rsPeaksX0cat,calPeaksX0cat); hold on
ylabel('\DeltaF/G (normalized)');
xlabel('Retinal slip velocity (\circ/s)');

%% calRS x2
scatter(rsPeaksX2(:,1),calPeaksX2(:,1));
hold on
scatter(rsPeaksX2(:,2),calPeaksX2(:,2));
scatter(rsPeaksX2(:,3),calPeaksX2(:,3));
scatter(rsPeaksX2(:,4),calPeaksX2(:,4));
scatter(rsPeaksX2(:,5),calPeaksX2(:,5));
scatter(rsPeaksX2(:,6),calPeaksX2(:,6));
scatter(rsPeaksX2(:,7),calPeaksX2(:,7));
% calPeaksX2cat = cat(1,calRSx2{1}(:,4),calRSx2{2}(:,4),calRSx2{3}(:,4),calRSx2{4}(:,4),calRSx2{5}(:,4),calRSx2{6}(:,4),calRSx2{7}(:,4));
% rsPeaksX2cat = cat(1,calRSx2{1}(:,2),calRSx2{2}(:,2),calRSx2{3}(:,2),calRSx2{4}(:,2),calRSx2{5}(:,2),calRSx2{6}(:,2),calRSx2{7}(:,2));
calPeaksX2cat = calPeaksX2cat(~isnan(calPeaksX2cat));
rsPeaksX2cat = rsPeaksX2cat(~isnan(rsPeaksX2cat));
figure(2); hold on
scatter(rsPeaksX2cat,calPeaksX2cat);
ylabel('\DeltaF/G (normalized)');
xlabel('Retinal slip velocity (\circ/s)');

%% calRS OKR
scatter(rsPeaks(:,1),calPeaks(:,1));
hold on
scatter(rsPeaks(:,2),calPeaks(:,2));
scatter(rsPeaks(:,3),calPeaks(:,3));
scatter(rsPeaks(:,4),calPeaks(:,4));
scatter(rsPeaks(:,5),calPeaks(:,5));
scatter(rsPeaks(:,6),calPeaks(:,6));
scatter(rsPeaks(:,7),calPeaks(:,7));
% calPeaksCat = cat(1,calRS{2}(:,4),calRS{3}(:,4),calRS{4}(:,4),calRS{5}(:,4),calRS{6}(:,4),calRS{7}(:,4));
% rsPeaksCat = cat(1,calRS{2}(:,2),calRS{3}(:,2),calRS{4}(:,2),calRS{5}(:,2),calRS{6}(:,2),calRS{7}(:,2));
rsPeaksCat(rsPeaksCat > 2) = NaN;
rsPeaksCat = rsPeaksCat(~isnan(rsPeaksCat));
calPeaksCat = calPeaksCat(~isnan(rsPeaksCat));
calPeaksCat = calPeaksCat(~isnan(calPeaksCat));

figure(2); hold on
scatter(rsPeaksCat,calPeaksCat);
ylabel('\DeltaF/G (normalized)');
xlabel('Retinal slip velocity (\circ/s)');

%% calRStime X0
scatter(calRStimeX0(:,1),calPeaksX0(:,1));
hold on
scatter(calRStimeX0(:,2),calPeaksX0(:,2));
scatter(calRStimeX0(:,3),calPeaksX0(:,3));
scatter(calRStimeX0(:,4),calPeaksX0(:,4));
scatter(calRStimeX0(:,5),calPeaksX0(:,5));
scatter(calRStimeX0(:,6),calPeaksX0(:,6));
scatter(calRStimeX0(:,7),calPeaksX0(:,7));
calPeaksX0cat = cat(1,calRSx0{1}(:,4),calRSx0{2}(:,4),calRSx0{3}(:,4),calRSx0{4}(:,4),calRSx0{5}(:,4),calRSx0{6}(:,4),calRSx0{7}(:,4));
calRStimeX0cat = cat(1,calRSx0{1}(:,3),calRSx0{2}(:,3),calRSx0{3}(:,3),calRSx0{4}(:,3),calRSx0{5}(:,3),calRSx0{6}(:,3),calRSx0{7}(:,3));
calPeaksX0cat = calPeaksX0cat(~isnan(calPeaksX0cat));
calRStimeX0cat = calRStimeX0cat(~isnan(calRStimeX0cat));
figure(2);
scatter(calRStimeX0cat,calPeaksX0cat); hold on
ylabel('\DeltaF/G (normalized)');
xlabel('Time of calcium peak re retinal slip peak (ms)');

%% calRStime x2
scatter(calRStimeX2(:,1),calRStimeX2(:,1));
hold on
scatter(calRStimeX2(:,2),calPeaksX2(:,2));
scatter(calRStimeX2(:,3),calPeaksX2(:,3));
scatter(calRStimeX2(:,4),calPeaksX2(:,4));
scatter(calRStimeX2(:,5),calPeaksX2(:,5));
scatter(calRStimeX2(:,6),calPeaksX2(:,6));
scatter(calRStimeX2(:,7),calPeaksX2(:,7));
calPeaksX2cat = cat(1,calRSx2{1}(:,4),calRSx2{2}(:,4),calRSx2{3}(:,4),calRSx2{4}(:,4),calRSx2{5}(:,4),calRSx2{6}(:,4),calRSx2{7}(:,4));
calRStimeX2cat = cat(1,calRSx2{1}(:,3),calRSx2{2}(:,3),calRSx2{3}(:,3),calRSx2{4}(:,3),calRSx2{5}(:,3),calRSx2{6}(:,3),calRSx2{7}(:,3));
calPeaksX2cat = calPeaksX2cat(~isnan(calPeaksX2cat));
calRStimeX2cat = calRStimeX2cat(~isnan(calRStimeX2cat));
figure(2); hold on
scatter(calRStimeX2cat,calPeaksX2cat);
ylabel('\DeltaF/G (normalized)');
xlabel('Time of calcium peak re retinal slip peak (ms)');

%% calRStime OKR
scatter(rsPeaks(:,1),calPeaks(:,1));
hold on
scatter(calRStime(:,2),calPeaks(:,2));
scatter(calRStime(:,3),calPeaks(:,3));
scatter(calRStime(:,4),calPeaks(:,4));
scatter(calRStime(:,5),calPeaks(:,5));
scatter(calRStime(:,6),calPeaks(:,6));
scatter(calRStime(:,7),calPeaks(:,7));
calPeaksCat = cat(1,calRS{2}(:,4),calRS{3}(:,4),calRS{4}(:,4),calRS{5}(:,4),calRS{6}(:,4),calRS{7}(:,4));
calRStimeCat = cat(1,calRS{2}(:,3),calRS{3}(:,3),calRS{4}(:,3),calRS{5}(:,3),calRS{6}(:,3),calRS{7}(:,3));
calRStimeCat = calRStimeCat(~isnan(calRStimeCat));
calPeaksCat = calPeaksCat(~isnan(calPeaksCat));

figure(2); hold on
scatter(calRStimeCat,calPeaksCat);
ylabel('\DeltaF/G (normalized)');
xlabel('Time of calcium peak re retinal slip peak (ms)');

%% calEyeL Amplitude X0
scatter(eyeLpeaksX0(:,1),calEyeLpeaksX0(:,1));
hold on
scatter(eyeLpeaksX0(:,2),calEyeLpeaksX0(:,2));
scatter(eyeLpeaksX0(:,3),calEyeLpeaksX0(:,3));
scatter(eyeLpeaksX0(:,4),calEyeLpeaksX0(:,4));
scatter(eyeLpeaksX0(:,5),calEyeLpeaksX0(:,5));
scatter(eyeLpeaksX0(:,6),calEyeLpeaksX0(:,6));
scatter(eyeLpeaksX0(:,7),calEyeLpeaksX0(:,7));
% calEyeLx0cat = cat(1,calEyeLx0{1}(:,4),calEyeLx0{2}(:,4),calEyeLx0{3}(:,4),calEyeLx0{4}(:,4),calEyeLx0{5}(:,4),calEyeLx0{6}(:,4),calEyeLx0{7}(:,4));
% eyeLx0cat = cat(1,calEyeLx0{1}(:,2),calEyeLx0{2}(:,2),calEyeLx0{3}(:,2),calEyeLx0{4}(:,2),calEyeLx0{5}(:,2),calEyeLx0{6}(:,2),calEyeLx0{7}(:,2));
calEyeLx0cat = calEyeLx0cat(~isnan(calEyeLx0cat));
eyeLx0cat = eyeLx0cat(~isnan(eyeLx0cat));
fitLineCalEyeLx0 = fitlm(eyeLx0cat,calEyeLx0cat);
r2calEyeLx0 = fitLineCalEyeLx0.Rsquared.Ordinary;
h1 = plot(fitLineCalEyeLx0,'HandleVisibility','off');
h1(1).Marker = 'none';
h1(2).Color = 'k';
h1(3).Color = 'k';
h1(4).Color = 'k';
legend([h1],'x0');
ylabel('\DeltaF/G (normalized)');
xlabel('Eye velocity (\circ/s)');
figure(2);
scatter(eyeLx0cat,calEyeLx0cat); hold on
ylabel('\DeltaF/G (normalized)');
xlabel('Eye velocity (\circ/s)');


%% calEyeL X2
scatter(eyeLpeaksX2(:,1),calEyeLpeaksX2(:,1));
hold on
scatter(eyeLpeaksX2(:,2),calEyeLpeaksX2(:,2));
scatter(eyeLpeaksX2(:,3),calEyeLpeaksX2(:,3));
scatter(eyeLpeaksX2(:,4),calEyeLpeaksX2(:,4));
scatter(eyeLpeaksX2(:,5),calEyeLpeaksX2(:,5));
scatter(eyeLpeaksX2(:,6),calEyeLpeaksX2(:,6));
scatter(eyeLpeaksX2(:,7),calEyeLpeaksX2(:,7));
% calEyeLx2cat = cat(1,calEyeLx2{1}(:,4),calEyeLx2{2}(:,4),calEyeLx2{3}(:,4),calEyeLx2{4}(:,4),calEyeLx2{5}(:,4),calEyeLx2{6}(:,4),calEyeLx2{7}(:,4));
% eyeLx2cat = cat(1,calEyeLx2{1}(:,2),calEyeLx2{2}(:,2),calEyeLx2{3}(:,2),calEyeLx2{4}(:,2),calEyeLx2{5}(:,2),calEyeLx2{6}(:,2),calEyeLx2{7}(:,2));
calEyeLx2cat = calEyeLx2cat(~isnan(calEyeLx2cat));
eyeLx2cat = eyeLx2cat(~isnan(eyeLx2cat));
fitLineCalEyeLx2 = fitlm(eyeLx2cat,calEyeLx2cat);
r2calEyeLx2 = fitLineCalEyeLx2.Rsquared.Ordinary;
h1 = plot(fitLineCalEyeLx2,'HandleVisibility','off');
h1(1).Marker = 'none';
h1(2).Color = 'k';
h1(3).Color = 'k';
h1(4).Color = 'k';
legend([h1],'x0');
ylabel('\DeltaF/G (normalized)');
xlabel('Eye velocity (\circ/s)');
figure(2); hold on
scatter(rsPeaksX2cat,calPeaksX2cat);
ylabel('\DeltaF/G (normalized)');
xlabel('Retinal slip velocity (\circ/s)');

%% calEyeL OKR
scatter(eyeLpeaksOKR(:,1),calEyeLpeaksOKR(:,1));
hold on
scatter(eyeLpeaksOKR(:,2),calEyeLpeaksOKR(:,2));
scatter(eyeLpeaksOKR(:,3),calEyeLpeaksOKR(:,3));
scatter(eyeLpeaksOKR(:,4),calEyeLpeaksOKR(:,4));
scatter(eyeLpeaksOKR(:,5),calEyeLpeaksOKR(:,5));
scatter(eyeLpeaksOKR(:,6),calEyeLpeaksOKR(:,6));
scatter(eyeLpeaksOKR(:,7),calEyeLpeaksOKR(:,7));
calEyeLokrCat = cat(1,calEyeLokr{1}(:,4),calEyeLokr{2}(:,4),calEyeLokr{3}(:,4),calEyeLokr{4}(:,4),calEyeLokr{5}(:,4),calEyeLokr{6}(:,4),calEyeLokr{7}(:,4));
eyeLokrCat = cat(1,calEyeLokr{1}(:,2),calEyeLokr{2}(:,2),calEyeLokr{3}(:,2),calEyeLokr{4}(:,2),calEyeLokr{5}(:,2),calEyeLokr{6}(:,2),calEyeLokr{7}(:,2));
eyeLokrCat(eyeLokrCat < -12) = NaN;
eyeLokrCat(eyeLokrCat > -6) = NaN;
calEyeLokrCat = calEyeLokrCat(~isnan(eyeLokrCat));
calEyeLokrCat = calEyeLokrCat(~isnan(calEyeLokrCat));
eyeLokrCat = eyeLokrCat(~isnan(eyeLokrCat));
fitLineCalEyeLokr = fitlm(eyeLokrCat,calEyeLokrCat);
r2calEyeLokr = fitLineCalEyeLokr.Rsquared.Ordinary;
h1 = plot(fitLineCalEyeLokr,'HandleVisibility','off');
h1(1).Marker = 'none';
h1(2).Color = 'k';
h1(3).Color = 'k';
h1(4).Color = 'k';
legend([h1],'x0');
ylabel('\DeltaF/G (normalized)');
xlabel('Eye velocity (\circ/s)');
figure(2); hold on
scatter(eyeLokrCat,calEyeLokrCat);
ylabel('\DeltaF/G (normalized)');
xlabel('Retinal slip velocity (\circ/s)');

%% calEyeD Amplitude X0
scatter(eyeDpeaksX0(:,1),calEyeDpeaksX0(:,1));
hold on
scatter(eyeDpeaksX0(:,2),calEyeDpeaksX0(:,2));
scatter(eyeDpeaksX0(:,3),calEyeDpeaksX0(:,3));
scatter(eyeDpeaksX0(:,4),calEyeDpeaksX0(:,4));
scatter(eyeDpeaksX0(:,5),calEyeDpeaksX0(:,5));
scatter(eyeDpeaksX0(:,6),calEyeDpeaksX0(:,6));
scatter(eyeDpeaksX0(:,7),calEyeDpeaksX0(:,7));
% calEyeLx0cat = cat(1,calEyeLx0{1}(:,4),calEyeLx0{2}(:,4),calEyeLx0{3}(:,4),calEyeLx0{4}(:,4),calEyeLx0{5}(:,4),calEyeLx0{6}(:,4),calEyeLx0{7}(:,4));
% eyeLx0cat = cat(1,calEyeLx0{1}(:,2),calEyeLx0{2}(:,2),calEyeLx0{3}(:,2),calEyeLx0{4}(:,2),calEyeLx0{5}(:,2),calEyeLx0{6}(:,2),calEyeLx0{7}(:,2));
eyeDx0cat(eyeDx0cat > 12) = NaN;
calEyeDx0cat = calEyeDx0cat(~isnan(eyeDx0cat));
calEyeDx0cat = calEyeDx0cat(~isnan(calEyeDx0cat));
eyeDx0cat = eyeDx0cat(~isnan(eyeDx0cat));
fitLineCalEyeDx0 = fitlm(eyeDx0cat,calEyeDx0cat);
r2calEyeDx0 = fitLineCalEyeDx0.Rsquared.Ordinary;
h1 = plot(fitLineCalEyeDx0,'HandleVisibility','off');
h1(1).Marker = 'none';
h1(2).Color = 'k';
h1(3).Color = 'k';
h1(4).Color = 'k';
legend([h1],'x0');
ylabel('\DeltaF/G (normalized)');
xlabel('Eye velocity (\circ/s)');
figure(2);
scatter(eyeDx0cat,calEyeDx0cat); hold on
ylabel('\DeltaF/G (normalized)');
xlabel('Eye velocity (\circ/s)');


%% calEyeL X2
scatter(eyeLpeaksX2(:,1),calEyeLpeaksX2(:,1));
hold on
scatter(eyeLpeaksX2(:,2),calEyeLpeaksX2(:,2));
scatter(eyeLpeaksX2(:,3),calEyeLpeaksX2(:,3));
scatter(eyeLpeaksX2(:,4),calEyeLpeaksX2(:,4));
scatter(eyeLpeaksX2(:,5),calEyeLpeaksX2(:,5));
scatter(eyeLpeaksX2(:,6),calEyeLpeaksX2(:,6));
scatter(eyeLpeaksX2(:,7),calEyeLpeaksX2(:,7));
% calEyeLx2cat = cat(1,calEyeLx2{1}(:,4),calEyeLx2{2}(:,4),calEyeLx2{3}(:,4),calEyeLx2{4}(:,4),calEyeLx2{5}(:,4),calEyeLx2{6}(:,4),calEyeLx2{7}(:,4));
% eyeLx2cat = cat(1,calEyeLx2{1}(:,2),calEyeLx2{2}(:,2),calEyeLx2{3}(:,2),calEyeLx2{4}(:,2),calEyeLx2{5}(:,2),calEyeLx2{6}(:,2),calEyeLx2{7}(:,2));
calEyeLx2cat = calEyeLx2cat(~isnan(calEyeLx2cat));
eyeLx2cat = eyeLx2cat(~isnan(eyeLx2cat));
fitLineCalEyeLx2 = fitlm(eyeLx2cat,calEyeLx2cat);
r2calEyeLx2 = fitLineCalEyeLx2.Rsquared.Ordinary;
h1 = plot(fitLineCalEyeLx2,'HandleVisibility','off');
h1(1).Marker = 'none';
h1(2).Color = 'k';
h1(3).Color = 'k';
h1(4).Color = 'k';
legend([h1],'x0');
ylabel('\DeltaF/G (normalized)');
xlabel('Eye velocity (\circ/s)');
figure(2); hold on
scatter(rsPeaksX2cat,calPeaksX2cat);
ylabel('\DeltaF/G (normalized)');
xlabel('Retinal slip velocity (\circ/s)');

%% calEyeL OKR
scatter(eyeLpeaksOKR(:,1),calEyeLpeaksOKR(:,1));
hold on
scatter(eyeLpeaksOKR(:,2),calEyeLpeaksOKR(:,2));
scatter(eyeLpeaksOKR(:,3),calEyeLpeaksOKR(:,3));
scatter(eyeLpeaksOKR(:,4),calEyeLpeaksOKR(:,4));
scatter(eyeLpeaksOKR(:,5),calEyeLpeaksOKR(:,5));
scatter(eyeLpeaksOKR(:,6),calEyeLpeaksOKR(:,6));
scatter(eyeLpeaksOKR(:,7),calEyeLpeaksOKR(:,7));
% calEyeLokrCat = cat(1,calEyeLokr{1}(:,4),calEyeLokr{2}(:,4),calEyeLokr{3}(:,4),calEyeLokr{4}(:,4),calEyeLokr{5}(:,4),calEyeLokr{6}(:,4),calEyeLokr{7}(:,4));
% eyeLokrCat = cat(1,calEyeLokr{1}(:,2),calEyeLokr{2}(:,2),calEyeLokr{3}(:,2),calEyeLokr{4}(:,2),calEyeLokr{5}(:,2),calEyeLokr{6}(:,2),calEyeLokr{7}(:,2));
eyeLokrCat(eyeLokrCat < -10) = NaN;
eyeLokrCat(eyeLokrCat > 0) = NaN;
calEyeLokrCat = calEyeLokrCat(~isnan(eyeLokrCat));
calEyeLokrCat = calEyeLokrCat(~isnan(calEyeLokrCat));
eyeLokrCat = eyeLokrCat(~isnan(eyeLokrCat));
fitLineCalEyeLokr = fitlm(eyeLokrCat,calEyeLokrCat);
r2calEyeLokr = fitLineCalEyeLokr.Rsquared.Ordinary;
h1 = plot(fitLineCalEyeLokr,'HandleVisibility','off');
h1(1).Marker = 'none';
h1(2).Color = 'k';
h1(3).Color = 'k';
h1(4).Color = 'k';
legend([h1],'x0');
ylabel('\DeltaF/G (normalized)');
xlabel('Eye velocity (\circ/s)');
figure(2); hold on
scatter(eyeLokrCat,calEyeLokrCat);
ylabel('\DeltaF/G (normalized)');
xlabel('Retinal slip velocity (\circ/s)');

%% 
%index histogram

figure(1); hold on
xlim([0 500]);
histogram(calIdxs,20,'FaceColor','g','BinWidth',25);
title('Distribution of fluorescence peaks');
xlabel('Time of fluorescence peaks');
ylabel('Number of events');

figure(2); hold on
xlim([0 750]);
histogram(calDidxs,30,'FaceColor','g','BinWidth',25);
title('Distribution of fluorescence peaks in the dark');
xlabel('Time of fluorescence peaks');
ylabel('Number of events');

figure(3); hold on
xlim([0 500]);
histogram(rsIdxs,20,'FaceColor','m','BinWidth',25);
title('Distribution of retinal slip peaks');
xlabel('Time of retinal slip peaks');
ylabel('Number of events');

figure(4); hold on
xlim([0 500]);
histogram(eyeLidxs,20,'FaceColor','r','BinWidth',25);
title('Distribution of eye velocity peaks');
xlabel('Time of eye velocity peaks');
ylabel('Number of events');

figure(5); hold on
xlim([0 750]);
histogram(eyeDidxs,30,'FaceColor','r','BinWidth',25);
title('Distribution of eye velocity peaks in the dark');
xlabel('Time of eye velocity peaks');
ylabel('Number of events');

figure(6); hold on
xlim([0 500]);
histogram(headvelIdxs,20,'FaceColor','k','BinWidth',25);
title('Distribution of head velocity peaks');
xlabel('Time of head velocity peaks');
ylabel('Number of events');

figure(7); hold on
xlim([0 750]);
histogram(headvelDidxs,30,'FaceColor','k','BinWidth',25);
title('Distribution of head velocity peaks in the dark');
xlabel('Time of head velocity peaks');
ylabel('Number of events');