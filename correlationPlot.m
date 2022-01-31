fitLineUSfec = fitlm(us,FEC);
r2usFEC = fitLineUSfec.Rsquared.Ordinary;

figure(1);
hold on
scatter(us,FEC,'lineWidth',2,'MarkerEdgeColor','b');
h = plot(fitLineUSfec);
h(1).Marker = 'none';
h(2).Color = 'k';
h(3).Color = 'k';
h(4).Color = 'k';
xlabel('FEC');
ylabel('\DeltaF/G (normalized)');