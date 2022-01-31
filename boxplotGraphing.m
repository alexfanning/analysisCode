%boxplot graphing for figs in cellReports paper

boxplot([airPuff,light],'Notch','on')
hold on
scatter(ones(size(airPuff)).*(1+(rand(size(airPuff))-0.5)/10),airPuff)
scatter(ones(size(light)).*(2+(rand(size(light))-0.5)/10),light)

boxplot([airPuff,light],'Notch','on')
hold on
scatter(ones(size(ampAll(:,1))).*(1+(rand(size(ampAll(:,1)))-0.5)/10),ampAll(:,1))
scatter(ones(size(amp(:,1))).*(2+(rand(size(amp(:,1)))-0)/10),amp(:,1))

%% fig 3 for jneurophys paper
figure()
hold on
boxplot([amp1*100 amp2*100 amp3*100 amp4*100],'Notch','on','whisker',7)
scatter(ones(size(amp1)),amp1*100)
scatter(ones(size(amp2)).*2,amp2*100)
scatter(ones(size(amp3)).*3,amp3*100)
scatter(ones(size(amp4)).*4,amp4*100)
ylim([-1 7])

%% alternative way to plot fig 3 for jNeurophys paper
scatter(x,amp3);
scatter(x2,amp2);
scatter(x3,amp1);
scatter(x4,amp4);
scatter(x(1,1),amp3avg,'k');
scatter(x2(1,1),amp2avg,'k');
scatter(x3(1,1),amp1avg,'k');
scatter(x4(1,1),amp4avg,'k');
errorbar(x(1,1),amp3avg,amp3se,'k');
errorbar(x2(1,1),amp2avg,amp2se,'k');
errorbar(x3(1,1),amp1avg,amp1se,'k');
errorbar(x4(1,1),amp4avg,amp4se,'k');
