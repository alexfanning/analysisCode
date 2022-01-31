%flipped axes line plots

figure(1);
hold on
plot(airPuffTimeAll,1:2,'color',[0.5 0.5 0.5],'lineWidth',1);
plot(airPuffTimeAllAvg,1:2,'color','b','lineWidth',4);
errorbar(airPuffTimeAllAvg(1:2),1:2,airPuffTimeAllSE,'horizontal','lineWidth',2,'color','b');

figure(2);
hold on
plot(airPuffModTime,1:2,'color',[0.5 0.5 0.5],'lineWidth',1);
plot(airPuffTimeModAvg,1:2,'color','b','lineWidth',4);
errorbar(airPuffTimeModAvg(1:2),1:2,airPuffTimeModSE,'horizontal','lineWidth',2,'color','b');

figure(3);
hold on
plot(airPuffNonModTime,1:2,'color',[0.5 0.5 0.5],'lineWidth',1);
plot(airPuffNonModTimeAvg,1:2,'color','b','lineWidth',4);
errorbar(airPuffNonModTimeAvg(1:2),1:2,airPuffNonModTimeSE,'horizontal','lineWidth',2,'color','b');

figure(4);
hold on
plot(lightTimeAll,1:2,'color',[0.5 0.5 0.5],'lineWidth',1);
plot(lightTimeAllAvg,1:2,'color','y','lineWidth',4);
errorbar(lightTimeAllAvg(1:2),1:2,lightTimeAllSE,'horizontal','lineWidth',2,'color','y');

figure(5);
hold on
plot(lightTimeMod,1:2,'color',[0.5 0.5 0.5],'lineWidth',1);
plot(lightTimeModAvg,1:2,'color','y','lineWidth',4);
errorbar(lightTimeModAvg(1:2),1:2,lightTimeModSE,'horizontal','lineWidth',2,'color','y');

figure(6);
hold on
plot(lightNonModTime,1:2,'color',[0.5 0.5 0.5],'lineWidth',1);
plot(lightNonModTimeAvg,1:2,'color','y','lineWidth',4);
errorbar(lightNonModTimeAvg(1:2),1:2,lightNonModTimeSE,'horizontal','lineWidth',2,'color','y');