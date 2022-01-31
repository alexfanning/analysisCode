
figure()
bar(calAmp*100); hold on
errorbar(calAmp*100,calAmpSE*100,'k','LineWidth',2)

figure()
bar(calSineAmp*100); hold on
errorbar(calSineAmp*100,calSineAmpSE*100,'k','LineWidth',2)

figure()
bar(calAmpIdx); hold on
errorbar(calAmpIdx,calAmpIdxSE,'k','LineWidth',2)

figure()
bar(calAmpIdx); hold on
errorbar(calAmpIdx,calAmpIdxSE,'k','LineWidth',2)