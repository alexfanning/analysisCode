%% Plot calcium re retinal slip
fitLineCalRS = fitlm(abs(rs_peak_amps(2,:)),cal_peak_amps*100);
r2calRS = fitLineCalRS.Rsquared.Ordinary;
fitLineCalRStime = fitlm(rs_peak_diffs(2,:),cal_peak_amps*100);
r2calRStime = fitLineCalRStime.Rsquared.Ordinary;
fitLineCalAucRS = fitlm(abs(rs_peak_amps(2,:)),calLauc);
r2calAucRS = fitLineCalAucRS.Rsquared.Ordinary;
fitLineCalAucRStime = fitlm(rs_peak_diffs(2,:),calLauc);
r2calAucRStime = fitLineCalRStime.Rsquared.Ordinary;

fitLine{1} = fitLineCalRS; fitLine{2} = fitLineCalRStime; fitLine{3} = fitLineCalAucRS; fitLine{4} = fitLineCalAucRStime;
xLabelName{1} = 'Contra retinal slip vel.'; xLabelName{2} = 'Time re peak contra retinal slip vel.';

scatterCorr(cal_peak_amps,calLauc,rs_peak_amps,rs_peak_diffs,condition,fitLine,'m','Calcium re retinal slip',xLabelName,1);

%% Plot calcium re eye
if condition == 0  || switchTest == 1
    fitLineCalEyeL = fitlm(eyeL_peak_amps(1,:),cal_peak_amps*100);
    fitLineCalEyeLtime = fitlm(eyeL_peak_diffs(1,:),cal_peak_amps*100);
    fitLineCalAucEyeL = fitlm(eyeL_peak_amps(1,:),calLauc);
    fitLineCalAucEyeLtime = fitlm(eyeL_peak_diffs(1,:),calLauc);
else
    fitLineCalEyeL = fitlm(abs(eyeL_peak_amps(2,:)),cal_peak_amps*100);
    fitLineCalEyeLtime = fitlm(eyeL_peak_diffs(2,:),cal_peak_amps*100);
    fitLineCalAucEyeL = fitlm(abs(eyeL_peak_amps(2,:)),calLauc);
    fitLineCalAucEyeLtime = fitlm(eyeL_peak_diffs(2,:),calLauc);
end
if expSubType ~= 4
    fitLineCalEyeD = fitlm(eyeD_peak_amps(1,:),calD_peak_amps*100);
    r2calEyeD = fitLineCalEyeD.Rsquared.Ordinary;

    fitLineCalEyeDtime = fitlm(eyeD_peak_diffs(1,:),calD_peak_amps*100);
    r2calEyeDtime = fitLineCalEyeDtime.Rsquared.Ordinary;

    fitLineCalAucEyeD = fitlm(eyeD_peak_amps(1,:),calDauc);
    r2calAucEyeD = fitLineCalAucEyeD.Rsquared.Ordinary;

    fitLineCalAucEyeDtime = fitlm(eyeD_peak_diffs(1,:),calDauc);
    r2calAucEyeDtime = fitLineCalAucEyeDtime.Rsquared.Ordinary;
end
if expSubType ~= 3
    r2calEyeL = fitLineCalEyeL.Rsquared.Ordinary;
    r2calEyeLtime = fitLineCalEyeLtime.Rsquared.Ordinary;
    r2calAucEyeL = fitLineCalAucEyeL.Rsquared.Ordinary;
    r2calAucEyeLtime = fitLineCalAucEyeLtime.Rsquared.Ordinary;
end

fitLine{1} = fitLineCalEyeL; fitLine{2} = fitLineCalEyeD; fitLine{3} = fitLineCalEyeLtime; fitLine{4} = fitLineCalEyeDtime;...
    fitLine{5} = fitLineCalAucEyeL; fitLine{6} = fitLineCalAucEyeD; fitLine{7} = fitLineCalAucEyeLtime; fitLine{8} = fitLineCalAucEyeDtime;
xLabelName{1} = 'Eye velocity'; xLabelName{2} = 'Time re peak eye velocity';

if condition ~= 4
    scatterCorr(cal_peak_amps,calD_peak_amps,calLauc,calDauc,eyeL_peak_amps,eyeL_peak_diffs,eyeD_peak_amps,eyeD_peak_diffs,...
        condition,fitLine,'r','Calcium re eye velocity',xLabelName,0,0);
else
    scatterCorr(cal_peak_amps,calD_peak_amps,calLauc,calDauc,eyeL_peak_amps,eyeL_peak_diffs,eyeD_peak_amps,eyeD_peak_diffs,...
        condition,fitLine,'r','Calcium re eye velocity',xLabelName,0,1,4);
end

%% Plot calcium re head
if condition == 0  || switchTest == 1
    fitLineCalHeadL = fitlm(abs(headvel_peak_amps(2,:)),cal_peak_amps*100);
    fitLineCalHeadLtime = fitlm(abs(headvel_peak_diffs(2,:)),cal_peak_amps*100);
    fitLineCalAucHeadL = fitlm(abs(headvel_peak_amps(2,:)),calLauc);
    fitLineCalAucHeadLtime = fitlm(abs(headvel_peak_diffs(2,:)),calLauc);
else
    fitLineCalHeadL = fitlm(headvel_peak_amps(1,:),cal_peak_amps*100);
    fitLineCalHeadLtime = fitlm(headvel_peak_diffs(1,:),cal_peak_amps*100);
    fitLineCalAucHeadL = fitlm(headvel_peak_amps(1,:),calLauc);
    fitLineCalAucHeadLtime = fitlm(headvel_peak_diffs(1,:),calLauc);
end
r2calHeadL = fitLineCalHeadL.Rsquared.Ordinary;
fitLineCalHeadD = fitlm(abs(headvelD_peak_amps(2,:)),calD_peak_amps*100);
r2calHeadD = fitLineCalHeadD.Rsquared.Ordinary;

r2calHeadLtime = fitLineCalHeadLtime.Rsquared.Ordinary;
fitLineCalHeadDtime = fitlm(headvelD_peak_diffs(2,:),calD_peak_amps*100);
r2calHeadDtime = fitLineCalHeadDtime.Rsquared.Ordinary;

r2calAucHeadL = fitLineCalAucHeadL.Rsquared.Ordinary;
fitLineCalAucHeadD = fitlm(abs(headvelD_peak_amps(2,:)),calDauc);
r2calAucHeadD = fitLineCalAucHeadD.Rsquared.Ordinary;

r2calHeadLtime = fitLineCalHeadLtime.Rsquared.Ordinary;
fitLineCalAucHeadDtime = fitlm(headvelD_peak_diffs(2,:),calDauc);
r2calHeadDtime = fitLineCalHeadDtime.Rsquared.Ordinary;

fitLine{1} = fitLineCalHeadL; fitLine{2} = fitLineCalHeadD; fitLine{3} = fitLineCalHeadLtime; fitLine{4} = fitLineCalHeadDtime;...
    fitLine{5} = fitLineCalAucHeadL; fitLine{6} = fitLineCalAucHeadD; fitLine{7} = fitLineCalAucHeadLtime; fitLine{8} = fitLineCalAucHeadDtime;
xLabelName{1} = 'Head velocity'; xLabelName{2} = 'Time re peak head velocity';

if condition ~= 4
    scatterCorr(cal_peak_amps,calD_peak_amps,calLauc,calDauc,headvel_peak_amps,headvel_peak_diffs,headvelD_peak_amps,headvelD_peak_diffs,...
        condition,fitLine,'r','Calcium re head velocity',xLabelName,1,0);
else
    scatterCorr(cal_peak_amps,calD_peak_amps,calLauc,calDauc,headvel_peak_amps,headvel_peak_diffs,headvelD_peak_amps,headvelD_peak_diffs,...
        condition,fitLine,'r','Calcium re head velocity',xLabelName,1,0,4);
end

%% Plot normalized calcium re retinal slip
fitLineCalNormRS = fitlm(abs(rs_peak_amps(2,:)),calNorm);
r2calNormRS = fitLineCalNormRS.Rsquared.Ordinary;
fitLineCalNormRStime = fitlm(rs_peak_diffs(2,:),calNorm);
r2calNormRStime = fitLineCalNormRStime.Rsquared.Ordinary;
fitLineCalNormAucRS = fitlm(abs(rs_peak_amps(2,:)),calAucNorm);
r2calNormAucRS = fitLineCalNormAucRS.Rsquared.Ordinary;
fitLineCalNormAucRStime = fitlm(rs_peak_diffs(2,:),calAucNorm);
r2calNormAucRStime = fitLineCalNormAucRStime.Rsquared.Ordinary;

fitLine{1} = fitLineCalNormRS; fitLine{2} = fitLineCalNormRStime; fitLine{3} = fitLineCalNormAucRS; fitLine{4} = fitLineCalNormAucRStime;
xLabelName{1} = 'Contra retinal slip vel.'; xLabelName{2} = 'Time re peak contra retinal slip vel.';

scatterCorr(calNorm/100,calAucNorm,rs_peak_amps,rs_peak_diffs,condition,fitLine,'m','Normalized calcium re retinal slip',xLabelName,1);

%% Plot normalized calcium re eye
if condition == 0 || switchTest == 1
    fitLineCalNormEyeL = fitlm(eyeL_peak_amps(1,:),calNorm);
    fitLineCalNormEyeLtime = fitlm(eyeL_peak_diffs(1,:),calNorm);
    fitLineCalAucNormEyeL = fitlm(eyeL_peak_amps(1,:),calAucNorm);
    fitLineCalAucNormEyeLtime = fitlm(eyeL_peak_diffs(1,:),calAucNorm);
else
    fitLineCalNormEyeL = fitlm(abs(eyeL_peak_amps(2,:)),calNorm);
    fitLineCalNormEyeLtime = fitlm(eyeL_peak_diffs(2,:),calNorm);
    fitLineCalAucNormEyeL = fitlm(abs(eyeL_peak_amps(2,:)),calAucNorm);
    fitLineCalAucNormEyeLtime = fitlm(eyeL_peak_diffs(2,:),calAucNorm);
end
r2calNormEyeL = fitLineCalNormEyeL.Rsquared.Ordinary;
fitLineCalNormEyeD = fitlm(eyeD_peak_amps(1,:),calDarkNorm);
r2calNormEyeD = fitLineCalNormEyeD.Rsquared.Ordinary;

r2calNormEyeLtime = fitLineCalNormEyeLtime.Rsquared.Ordinary;
fitLineCalNormEyeDtime = fitlm(eyeD_peak_diffs(1,:),calDarkNorm);
r2calNormEyeDtime = fitLineCalNormEyeDtime.Rsquared.Ordinary;

r2calAucNormEyeL = fitLineCalAucNormEyeL.Rsquared.Ordinary;
fitLineCalAucNormEyeD = fitlm(eyeD_peak_amps(1,:),calDarkAucNorm);
r2calAucNormEyeD = fitLineCalAucNormEyeD.Rsquared.Ordinary;

r2calAucNormEyeLtime = fitLineCalAucNormEyeLtime.Rsquared.Ordinary;
fitLineCalAucNormEyeDtime = fitlm(eyeD_peak_diffs(1,:),calDarkAucNorm);
r2calAucNormEyeDtime = fitLineCalAucNormEyeDtime.Rsquared.Ordinary;

fitLine{1} = fitLineCalNormEyeL; fitLine{2} = fitLineCalNormEyeD; fitLine{3} = fitLineCalNormEyeLtime; fitLine{4} = fitLineCalNormEyeDtime;...
    fitLine{5} = fitLineCalAucNormEyeL; fitLine{6} = fitLineCalAucNormEyeD; fitLine{7} = fitLineCalAucNormEyeLtime; fitLine{8} = fitLineCalAucNormEyeDtime;
xLabelName{1} = 'Eye velocity'; xLabelName{2} = 'Time re peak eye velocity';

if condition ~= 4
    scatterCorr(calNorm/100,calDarkNorm/100,calAucNorm,calDarkAucNorm,eyeL_peak_amps,eyeL_peak_diffs,eyeD_peak_amps,eyeD_peak_diffs,...
        condition,fitLine,'r','Normalized calcium re eye velocity',xLabelName,0,0);
else
    scatterCorr(calNorm/100,calDarkNorm/100,calAucNorm,calDarkAucNorm,eyeL_peak_amps,eyeL_peak_diffs,eyeD_peak_amps,eyeD_peak_diffs,...
        condition,fitLine,'r','Normalized calcium re eye velocity',xLabelName,0,1,4);
end

%% Plot calcium re head
if condition == 0 || switchTest == 1
    fitLineCalNormHeadL = fitlm(abs(headvel_peak_amps(2,:)),calNorm);
    fitLineCalNormHeadLtime = fitlm(abs(headvel_peak_diffs(2,:)),calNorm);
    fitLineCalAucNormHeadL = fitlm(abs(headvel_peak_amps(2,:)),calAucNorm);
    fitLineCalAucNormHeadLtime = fitlm(abs(headvel_peak_diffs(2,:)),calAucNorm);
else
    fitLineCalNormHeadL = fitlm(headvel_peak_amps(1,:),calNorm);
    fitLineCalNormHeadLtime = fitlm(headvel_peak_diffs(1,:),calNorm);
    fitLineCalAucNormHeadL = fitlm(headvel_peak_amps(1,:),calAucNorm);
    fitLineCalAucNormHeadLtime = fitlm(headvel_peak_diffs(1,:),calAucNorm);
end
r2calNormHeadL = fitLineCalNormHeadL.Rsquared.Ordinary;
fitLineCalNormHeadD = fitlm(abs(headvelD_peak_amps(2,:)),calDarkNorm);
r2calNormHeadD = fitLineCalNormHeadD.Rsquared.Ordinary;

r2calNormHeadLtime = fitLineCalNormHeadLtime.Rsquared.Ordinary;
fitLineCalNormHeadDtime = fitlm(headvelD_peak_diffs(2,:),calDarkNorm);
r2calNormHeadDtime = fitLineCalNormHeadDtime.Rsquared.Ordinary;

r2calAucNormHeadL = fitLineCalAucNormHeadL.Rsquared.Ordinary;
fitLineCalAucNormHeadD = fitlm(abs(headvelD_peak_amps(2,:)),calDarkAucNorm);
r2calAucNormHeadD = fitLineCalAucNormHeadD.Rsquared.Ordinary;

r2calAucNormHeadLtime = fitLineCalAucNormHeadLtime.Rsquared.Ordinary;
fitLineCalAucNormHeadDtime = fitlm(headvelD_peak_diffs(2,:),calDarkAucNorm);
r2calAucNormHeadDtime = fitLineCalAucNormHeadDtime.Rsquared.Ordinary;

fitLine{1} = fitLineCalNormHeadL; fitLine{2} = fitLineCalNormHeadD; fitLine{3} = fitLineCalNormHeadLtime; fitLine{4} = fitLineCalNormHeadDtime;...
    fitLine{5} = fitLineCalAucNormHeadL; fitLine{6} = fitLineCalAucNormHeadD; fitLine{7} = fitLineCalAucNormHeadLtime; fitLine{8} = fitLineCalAucNormHeadDtime;
xLabelName{1} = 'Head velocity'; xLabelName{2} = 'Time re peak head velocity';

if condition ~= 4
    scatterCorr(calNorm,calDarkNorm,calAucNorm,calDarkAucNorm,headvel_peak_amps,headvel_peak_diffs,headvelD_peak_amps,headvelD_peak_diffs,...
        condition,fitLine,'r','Normalized calcium re head velocity',xLabelName,1,0);
else
    scatterCorr(calNorm,calDarkNorm,calAucNorm,calDarkAucNorm,headvel_peak_amps,headvel_peak_diffs,headvelD_peak_amps,headvelD_peak_diffs,...
    condition,fitLine,'r','Normalized calcium re head velocity',xLabelName,1,0,4);
end

%% Plot calcium effect on next trials eye
if condition == 0 || switchTest == 1
    fitLineCalNextEyeL = fitlm(eyeLampNextTrial(1,:),calAmpPriorTrial*100);
    fitLineCalNextEyeLtime = fitlm(calAmpIdxPriorTrial(2,:),eyeLampNextTrial(1,:));
    fitLineCalAucNextEyeL = fitlm(eyeLampNextTrial(1,:),calLaucPriorTrial);
    fitLineCalAucNextEyeLtime = fitlm(calAmpIdxPriorTrial(2,:),calLaucPriorTrial);
else
    fitLineCalNextEyeL = fitlm(abs(eyeLampNextTrial(2,:)),calAmpPriorTrial*100);
    fitLineCalNextEyeLtime = fitlm(calAmpIdxPriorTrial(2,:),abs(eyeLampNextTrial(2,:)));
    fitLineCalAucNextEyeL = fitlm(abs(eyeLampNextTrial(2,:)),calLaucPriorTrial);
    fitLineCalAucNextEyeLtime = fitlm(calAmpIdxPriorTrial(2,:),calLaucPriorTrial);
end
r2calNextEyeL = fitLineCalNextEyeL.Rsquared.Ordinary;
fitLineCalNextEyeD = fitlm(eyeDampNextTrial(1,:),calDarkAmpPriorTrial*100);
r2calNextEyeD = fitLineCalNextEyeD.Rsquared.Ordinary;

r2calNextEyeLtime = fitLineCalNextEyeLtime.Rsquared.Ordinary;
fitLineCalNextEyeDtime = fitlm(calDarkAmpIdxPriorTrial,eyeDampNextTrial(1,:));
r2calNextEyeDtime = fitLineCalNextEyeDtime.Rsquared.Ordinary;

r2calAucNextEyeL = fitLineCalAucNextEyeL.Rsquared.Ordinary;
fitLineCalAucNextEyeD = fitlm(eyeDampNextTrial(1,:),calDaucPriorTrial);
r2calAucNextEyeD = fitLineCalAucNextEyeD.Rsquared.Ordinary;

r2calAucNextEyeLtime = fitLineCalAucNextEyeLtime.Rsquared.Ordinary;
fitLineCalAucNextEyeDtime = fitlm(calDarkAmpIdxPriorTrial,calDaucPriorTrial);
r2calAucNextEyeDtime = fitLineCalAucNextEyeDtime.Rsquared.Ordinary;

fitLine{1} = fitLineCalNextEyeL; fitLine{2} = fitLineCalNextEyeD; fitLine{3} = fitLineCalNextEyeLtime; fitLine{4} = fitLineCalNextEyeDtime;...
    fitLine{5} = fitLineCalAucNextEyeL; fitLine{6} = fitLineCalAucNextEyeD; fitLine{7} = fitLineCalAucNextEyeLtime; fitLine{8} = fitLineCalAucNextEyeDtime;
xLabelName{1} = 'Eye velocity'; xLabelName{2} = 'Prior trial calcium time re retinal slip';

scatterCorr(calAmpPriorTrial,calDarkAmpPriorTrial,calLaucPriorTrial,calDaucPriorTrial,eyeLampNextTrial,calAmpIdxPriorTrial,eyeDampNextTrial,calDarkAmpIdxPriorTrial,...
    condition,fitLine,'r','Eye vel re prior trial calcium',xLabelName,0,3);

%% Plot no calcium effect on next trials eye
figure('Name','Next trial eye, calcium vs no calcium')
subplot(2,1,1); hold on
bar([calLampNextTrialNoCSavg(1)*100,calLampNextTrialNoCSavg(2)*100])
errorbar([calLampNextTrialNoCSavg(1)*100,calLampNextTrialNoCSavg(2)*100],[calLampNextTrialNoCSse(1)*100,calLampNextTrialNoCSse(2)*100],'LineStyle','none','Color','k','LineWidth',1)
title('Calcium size re retinal slip timing')
xticks(1:2)
xticklabels({'Related','Unrelated'})
ylabel('% \DeltaF/G')

subplot(2,1,2); hold on
bar([calLaucNextTrialNoCSavg(1)*100,calLaucNextTrialNoCSavg(2)*100])
errorbar([calLaucNextTrialNoCSavg(1)*100,calLaucNextTrialNoCSavg(2)*100],[calLaucNextTrialNoCSse(1)*100,calLaucNextTrialNoCSse(2)*100],'LineStyle','none','Color','k','LineWidth',1)
title('Calcium size re retinal slip timing')
xticks(1:2)
xticklabels({'Related','Unrelated'})
ylabel('AUC')

figure('Name','Eye related to calcium timing re retina slip prior trial'); hold on
bar([abs(eyeLampNextTrialAvg),abs(eyeLampNextTrialNoCSavg)])
errorbar([abs(eyeLampNextTrialAvg),abs(eyeLampNextTrialNoCSavg)],[eyeLampNextTrialSe,eyeLampNextTrialNoCSse],'LineStyle','none','Color','k','LineWidth',1)
title('Next trial eye, re calcium time re retinal slip')
xticks(1:2)
xticklabels({'Unrelated','Related'})
ylabel('Eye velocity')
