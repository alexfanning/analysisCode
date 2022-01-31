%Line graph plots

figure(1);
hold on
plot(allAirPuff,'color',[0.5 0.5 0.5],'lineWidth',1);
plot(allAirPuffAvg,'color','b','lineWidth',4);
errorbar(allAirPuffAvg,allAirPuffSE,'color','b','lineWidth',2);

figure(2);
hold on
plot(airPuffMod,'color',[0.5 0.5 0.5],'lineWidth',1);
plot(airPuffModAvg,'color','b','lineWidth',4);
errorbar(airPuffModAvg,airPuffModSE,'color','b','lineWidth',2);

figure(3);
hold on
plot(airPuffNonMod,'color',[0.5 0.5 0.5],'lineWidth',1);
plot(airPuffNonModAvg,'color','b','lineWidth',4);
errorbar(airPuffNonModAvg,airPuffNonModSE,'color','b','lineWidth',2);

figure(4);
hold on
plot(allLight,'color',[0.5 0.5 0.5],'lineWidth',1);
plot(lightAllAvg,'color','y','lineWidth',4);
errorbar(lightAllAvg,lightAllSE,'color','y','lineWidth',2);

figure(5);
hold on
plot(lightMod,'color',[0.5 0.5 0.5],'lineWidth',1);
plot(lightModAvg,'color','y','lineWidth',4);
errorbar(lightModAvg,lightModSE,'color','y','lineWidth',2);

figure(6);
hold on
plot(lightNonMod,'color',[0.5 0.5 0.5],'lineWidth',1);
plot(lightNonModAvg,'color','y','lineWidth',4);
errorbar(lightNonModAvg,lightNonModSE,'color','y','lineWidth',2);