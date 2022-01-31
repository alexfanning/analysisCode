%plot 1-second cycle phase relationship of calcium relative to eye, head, or retinal
%slip
figure(1);
hold on
xlim([-525 525]);
ylim([0 1]);
scatter(darkEye,w,'lineWidth',2,'MarkerEdgeColor','r');
scatter(darkEyeAvg,wa,'lineWidth',2,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 0]);
errorbar(darkEyeAvg,wa,darkEyeSE,'horizontal','lineWidth',2);

scatter(none,xa,'lineWidth',2);

scatter(darkHead,y,'lineWidth',2);
scatter(darkHeadAvg,ya,'lineWidth',2,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 0]);
errorbar(darkHeadAvg,ya,darkHeadSE,'horizontal','lineWidth',2);

figure(2);
hold on
xlim([-525 525]);
ylim([0 1]);
scatter(inPhaseEye,w,'lineWidth',2,'MarkerEdgeColor','r');
scatter(inPhaseEyeAvg,wa,'lineWidth',2,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 0]);
errorbar(inPhaseEyeAvg,wa,inPhaseEyeSE,'horizontal','lineWidth',2);
scatter(inPhaseRS,x,'lineWidth',2);
scatter(inPhaseRSavg,xa,'lineWidth',2,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 0]);
errorbar(inPhaseRSavg,xa,inPhaseRSse,'horizontal','lineWidth',2);
scatter(inPhaseHead,y,'lineWidth',2);
scatter(inPhaseHeadAvg,ya,'lineWidth',2,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 0]);
errorbar(inPhaseHeadAvg,ya,inPhaseHeadSE,'horizontal','lineWidth',2);

figure(3);
hold on
xlim([-525 525]);
ylim([0 1]);
scatter(outOfPhaseEye,w,'lineWidth',2,'MarkerEdgeColor','r');
scatter(outOfPhaseEyeAvg,wa,'lineWidth',2,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 0]);
errorbar(outOfPhaseEyeAvg,wa,outOfPhaseEyeSE,'horizontal','lineWidth',2);
scatter(outOfPhaseRS,x,'lineWidth',2);
scatter(outOfPhaseRSavg,xa,'lineWidth',2,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 0]);
errorbar(outOfPhaseRSavg,xa,outOfPhaseRSse,'horizontal','lineWidth',2);
scatter(outOfPhaseHead,y,'lineWidth',2);
scatter(outOfPhaseHeadAvg,ya,'lineWidth',2,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 0]);
errorbar(outOfPhaseHeadAvg,ya,outOfPhaseHeadSE,'horizontal','lineWidth',2);

figure(4);
hold on
xlim([-525 525]);
ylim([0 1]);
scatter(okrEye,w,'lineWidth',2,'MarkerEdgeColor','r');
scatter(okrEyeAvg,wa,'lineWidth',2,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 0]);
errorbar(okrEyeAvg,wa,okrEyeSE,'horizontal','lineWidth',2);

scatter(okrRS,x,'lineWidth',2);
scatter(okrRSavg,xa,'lineWidth',2,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 0]);
errorbar(okrRSavg,xa,okrRSse,'horizontal','lineWidth',2);

scatter(none,ya,'lineWidth',2);

%plot a single variable that includes all test conditions
figure(5);
hold on
xlim([-525 525]);
ylim([0 1.25]);
scatter(darkEye,w,'lineWidth',2,'MarkerEdgeColor','r');
scatter(darkEyeAvg,wa,'lineWidth',2,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 0]);
errorbar(darkEyeAvg,wa,darkEyeSE,'horizontal','lineWidth',2);

scatter(inPhaseEye,x,'lineWidth',2,'MarkerEdgeColor','r');
scatter(inPhaseEyeAvg,xa,'lineWidth',2,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 0]);
errorbar(inPhaseEyeAvg,xa,inPhaseEyeSE,'horizontal','lineWidth',2);

scatter(outOfPhaseEye,y,'lineWidth',2,'MarkerEdgeColor','r');
scatter(outOfPhaseEyeAvg,ya,'lineWidth',2,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 0]);
errorbar(outOfPhaseEyeAvg,ya,outOfPhaseEyeSE,'horizontal','lineWidth',2);

scatter(okrEye,z,'lineWidth',2,'MarkerEdgeColor','r');
scatter(okrEyeAvg,za,'lineWidth',2,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 0]);
errorbar(okrEyeAvg,za,okrEyeSE,'horizontal','lineWidth',2);

figure(6);
hold on
xlim([-525 525]);
ylim([0 1.25]);

scatter(none,wa,'lineWidth',2);

scatter(inPhaseRS,x,'lineWidth',2);
scatter(inPhaseRSavg,xa,'lineWidth',2,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 0]);
errorbar(inPhaseRSavg,xa,inPhaseRSse,'horizontal','lineWidth',2);

scatter(outOfPhaseRS,y,'lineWidth',2);
scatter(outOfPhaseRSavg,ya,'lineWidth',2,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 0]);
errorbar(outOfPhaseRSavg,ya,outOfPhaseRSse,'horizontal','lineWidth',2);

scatter(okrRS,z,'lineWidth',2);
scatter(okrRSavg,za,'lineWidth',2,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 0]);
errorbar(okrRSavg,za,okrRSse,'horizontal','lineWidth',2);

figure(7);
hold on
xlim([-525 525])
ylim([0 1.25])
scatter(darkHead,w,'lineWidth',2)
scatter(darkHeadAvg,wa,'lineWidth',2,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 0])
errorbar(darkHeadAvg,wa,darkHeadSE,'horizontal','lineWidth',2)

scatter(inPhaseHead,x,'lineWidth',2);
scatter(inPhaseHeadAvg,xa,'lineWidth',2,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 0])
errorbar(inPhaseHeadAvg,xa,inPhaseHeadSE,'horizontal','lineWidth',2)

scatter(outOfPhaseHead,y,'lineWidth',2);
scatter(outOfPhaseHeadAvg,ya,'lineWidth',2,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 0]);
errorbar(outOfPhaseHeadAvg,ya,outOfPhaseHeadSE,'horizontal','lineWidth',2)

scatter(none,za,'lineWidth',2)


%% fig 4 for jneurophys
figure()
hold on
boxplot([darkHead inPhaseHead outOfPhaseHead],'orientation', 'horizontal','Notch','on','whisker',7)
scatter(darkHead,ones(size(darkHead)))
scatter(inPhaseHead,ones(size(inPhaseHead)).*2)
scatter(outOfPhaseHead,ones(size(outOfPhaseHead)).*3)
xlim([-525 525])
ylim([0 5])

figure()
hold on
boxplot([filler inPhaseRS outOfPhaseRS okrRS],'orientation', 'horizontal','Notch','on','whisker',7)
scatter(filler,ones(size(filler)).*1)
scatter(inPhaseRS,ones(size(inPhaseRS)).*2)
scatter(outOfPhaseRS,ones(size(outOfPhaseRS)).*3)
scatter(okrRS,ones(size(okrRS)).*4)
xlim([-525 525])
ylim([0 5])

figure()
hold on
boxplot([darkEye inPhaseEye outOfPhaseEye okrEye],'orientation', 'horizontal','Notch','on','whisker',7)
scatter(darkEye,ones(size(darkEye)))
scatter(inPhaseEye,ones(size(inPhaseEye)).*2)
scatter(outOfPhaseEye,ones(size(outOfPhaseEye)).*3)
scatter(okrEye,ones(size(okrEye)).*4)
xlim([-525 525])
ylim([0 5])