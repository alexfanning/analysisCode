%% CalRS amplitude plots for x0, x2, okr

fitLineCalRSx0 = fitlm(calPeaksX0cat,rsPeaksX0cat);
r2calRSx0 = fitLineCalRSx0.Rsquared.Ordinary;
fitLineCalRSx2 = fitlm(calPeaksX2cat,rsPeaksX2cat);
r2calRSx2 = fitLineCalRSx2.Rsquared.Ordinary;
fitLineCalRSokr = fitlm(calPeaksCat,rsPeaksCat);
r2calRSx2 = fitLineCalRSokr.Rsquared.Ordinary;

figure(1); hold on
h0 = scatter(calPeaksX0cat,rsPeaksX0cat,'Filled','b','DisplayName','x0');
h1 = plot(fitLineCalRSx0,'HandleVisibility','off');
h1(1).Marker = 'none';
h1(2).Color = 'b';
h1(3).Color = 'b';
h1(4).Color = 'b';
legend([h0],'x0');
title('Fluorescence amplitude vs. retinal slip velocity');
xlabel('Fluorescence amplitude');
ylabel('Retinal slip velocity');

figure(2); hold on
h0 = scatter(calPeaksX2cat,rsPeaksX2cat,'Filled','r','DisplayName','x2');
h1 = plot(fitLineCalRSx2,'HandleVisibility','off');
h1(1).Marker = 'none';
h1(2).Color = 'r';
h1(3).Color = 'r';
h1(4).Color = 'r';
legend([h0],'x2');
title('Fluorescence amplitude vs. retinal slip velocity');
xlabel('Fluorescence amplitude');
ylabel('Retinal slip velocity');

figure(3); hold on
h0 = scatter(calPeaksCat,rsPeaksCat,'Filled','g','DisplayName','OKR');
h1 = plot(fitLineCalRSokr,'HandleVisibility','off');
h1(1).Marker = 'none';
h1(2).Color = 'g';
h1(3).Color = 'g';
h1(4).Color = 'g';
legend([h0],'OKR');
title('Fluorescence amplitude vs. retinal slip velocity');
xlabel('Fluorescence amplitude');
ylabel('Retinal slip velocity');
%% timing plots for peak calcium relative to peak retinal slip

fitLineCalRStimeX0cat = fitlm(calRStimeX0cat,calPeaksX0cat);
r2calRStimeX0cat = fitLineCalRStimeX0cat.Rsquared.Ordinary;
fitLineCalRStimeX2cat = fitlm(calRStimeX2cat,calPeaksX2cat);
r2calRStimeX2cat = fitLineCalRStimeX2cat.Rsquared.Ordinary;
fitLineCalRStimeCat = fitlm(calRStimeCat,calPeaksCat);
r2calRStimeCat = fitLineCalRStimeCat.Rsquared.Ordinary;

figure(4); hold on
h0 = scatter(calRStimeX0cat,calPeaksX0cat,'Filled','b','DisplayName','x0');
h1 = plot(fitLineCalRStimeX0cat);
h1(1).Marker = 'none';
h1(2).Color = 'b';
h1(3).Color = 'b';
h1(4).Color = 'b';
legend([h0],'x0');
title('Fluorescence amplitude vs. delay re retinal slip');
xlabel('Fluorescence delay re retinal slip');
ylabel('Fluorescence amplitude');

figure(5); hold on
h2 = scatter(calRStimeX2cat,calPeaksX2cat,'Filled','r','DisplayName','x2');
h3 = plot(fitLineCalRStimeX2cat);
h3(1).Marker = 'none';
h3(2).Color = 'r';
h3(3).Color = 'r';
h3(4).Color = 'r';
legend([h2],'x2');
title('Fluorescence amplitude vs. delay re retinal slip');
xlabel('Fluorescence delay re retinal slip');
ylabel('Fluorescence amplitude');

figure(6); hold on
h4 = scatter(calRStimeCat,calPeaksCat,'Filled','g','DisplayName','OKR');
h5 = plot(fitLineCalRStimeCat);
h5(1).Marker = 'none';
h5(2).Color = 'g';
h5(3).Color = 'g';
h5(4).Color = 'g';
legend([h4],'OKR');
title('Fluorescence amplitude vs. delay re retinal slip');
xlabel('Fluorescence delay re retinal slip');
ylabel('Fluorescence amplitude');