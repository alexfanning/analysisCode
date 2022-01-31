function ampIdxPlots(darkBlockAmp,darkBlockAmpIdx,visualBlockAmp,visualBlockAmpIdx,numBlocksVisual,c,p)
numBlocksDark = size(darkBlockAmp,1);
figure('Name',p)
subplot(2,2,1); hold on
m = plot(darkBlockAmp(:,1),'-s','MarkerFaceColor','k');
m.Color = 'k';
ylabel('Amplitude')
title('Vestibular-dark')
xticks(1:numBlocksDark)
xlim([1 numBlocksDark])

subplot(2,2,2); hold on
m = plot(darkBlockAmpIdx(:,1),'-s','MarkerFaceColor','k');
m.Color = 'k';
ylabel('Time (ms)')
title('Vestibular-dark')
xticks(1:numBlocksDark)
xlim([1 numBlocksDark])

subplot(2,2,3); hold on
m = plot(visualBlockAmp(1:numBlocksVisual,2),'-s','MarkerFaceColor',c);
m.Color = c;
xlabel('Block number')
ylabel('Amplitude')
title('Visual')
if numBlocksVisual > 1
    xticks(1:numBlocksVisual)
    xlim([1 numBlocksVisual])
else
    xticks(1)
    xlim(0:1)
end

subplot(2,2,4); hold on
m = plot(visualBlockAmpIdx(1:numBlocksVisual,2),'-s','MarkerFaceColor',c);
m.Color = c;
xlabel('Block number')
ylabel('Time (ms)')
title('Visual')
if numBlocksVisual > 1
    xticks(1:numBlocksVisual)
    xlim([1 numBlocksVisual])
else
    xticks(1)
    xlim(0:1)
end