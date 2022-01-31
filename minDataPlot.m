function minDataPlot(eyeTestVisual,eyeVisualMatOutVector,eyeTestDark,eyeDarkMatOutVector,eyeTestGap,eyeGapMatOutVector,t)

figure('Name',t)
subplot(3,1,1); hold on
plot(eyeTestDark); hold on
plot(eyeDarkMatOutVector)
title('Vestibular-dark')
legend('Desaccaded eye vel.','Min. data removed')
ylabel('Eye vel.')
subplot(3,1,2); hold on
plot(eyeTestVisual); hold on
plot(eyeVisualMatOutVector)
title('Visual')
ylabel('Eye vel.')
subplot(3,1,3); hold on
plot(eyeTestGap); hold on
plot(eyeGapMatOutVector)
xlabel('Time (ms)')
ylabel('Eye vel.')
title('Gap')