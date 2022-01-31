%% Compile data from across multiple acute experiments
numConditions = 3;
numSxs = 8;
t = 1;

metaDirectories = {'C:\Users\afanning\Documents\Data\FP\VORx2acute','C:\Users\afanning\Documents\Data\FP\VORx0acute',...
    'C:\Users\afanning\Documents\Data\FP\OKRacute'};

%% Create storage variables
idxCalAmpPop = NaN(numConditions,1);
idxCalAmpPopAvg = NaN(numConditions,1);
idxCalAucPop = NaN(numConditions,1);
idxCalAucPopAvg = NaN(numConditions,1);
idxCalAmpPopSE = NaN(numConditions,1);
idxCalAucPopSE = NaN(numConditions,1);
idxCalNormPop = NaN(numConditions,1);
idxCalAucNormPop = NaN(numConditions,1);
idxCalNormPopAvg = NaN(numConditions,1);
idxCalAucNormPopAvg = NaN(numConditions,1);
idxCalNormPopSE = NaN(numConditions,1);
idxCalAucNormPopSE = NaN(numConditions,1);
idxPeakIdxsPop = NaN(numConditions,1);
idxIpiPop = NaN(numConditions,1);
idxWidthPop = NaN(numConditions,1);
idxCalEventsRemoved = NaN(numConditions,1);
idxCalEventsRemovedAvg = NaN(numConditions,1);
idxEventFrequencyPop = NaN(numConditions,1);
idxEventFreqPopAvg = NaN(numConditions,1);

calAmpPopAll = cell(numConditions);
calAmpPopAvgAll = cell(numConditions,1);
calAucPopAll = cell(numConditions,1);
calAucPopAvgAll = cell(numConditions,1);
calAmpPopSEall = cell(numConditions,1);
calAucPopSEall = cell(numConditions,1);
calNormPopAll = cell(numConditions,1);
calAucNormPopAll = cell(numConditions,1);
calNormPopAvgAll = cell(numConditions,1);
calAucNormPopAvgAll = cell(numConditions,1);
calNormPopSEall = cell(numConditions,1);
calAucNormPopSEall = cell(numConditions,1);
peakIdxsPopAll = cell(numConditions,1);
ipiPopAll = cell(numConditions,1);
widthPopAll = cell(numConditions,1);
calEventsRemovedAll = cell(numConditions,1);
calEventsRemovedAvgAll = cell(numConditions,1);
eventFrequencyPopAll = cell(numConditions,1);
eventFreqPopAvgAll = cell(numConditions,1);

for i = 1:numConditions
    cd(metaDirectories{i})
    dataCondition = load(uigetfile('*.mat'));
    varCondNames = fieldnames(dataCondition);
    
    [~, idxCalAmpPop(i)] = ismember('calAmpPop', varCondNames);
    [~, idxCalAmpPopAvg(i)] = ismember('calAmpPopAvg', varCondNames);
    [~, idxCalAucPop(i)] = ismember('calAucPop', varCondNames);
    [~, idxCalAucPopAvg(i)] = ismember('calAucPopAvg', varCondNames);
    [~, idxCalAmpPopSE(i)] = ismember('calAmpPopSE', varCondNames);
    [~, idxCalAucPopSE(i)] = ismember('calAucPopSE', varCondNames);
    [~, idxCalNormPop(i)] = ismember('calNormPop', varCondNames);
    [~, idxCalAucNormPop(i)] = ismember('calAucNormPop', varCondNames);
    [~, idxCalNormPopAvg(i)] = ismember('calNormPopAvg', varCondNames);
    [~, idxCalAucNormPopAvg(i)] = ismember('calAucNormPopAvg', varCondNames);
    [~, idxCalNormPopSE(i)] = ismember('calNormPopSE', varCondNames);
    [~, idxCalAucNormPopSE(i)] = ismember('calAucNormPopSE', varCondNames);
    [~, idxPeakIdxsPop(i)] = ismember('peakIdxsPop', varCondNames);
    [~, idxIpiPop(i)] = ismember('ipiPop', varCondNames);
    [~, idxWidthPop(i)] = ismember('widthPop', varCondNames);
    [~, idxCalEventsRemoved(i)] = ismember('calEventsRemoved', varCondNames);
    [~, idxCalEventsRemovedAvg(i)] = ismember('calEventsRemovedAvg', varCondNames);
%     [~, idxEventFrequencyPop(i)] = ismember('eventFrequencyPop', varCondNames);
%     [~, idxEventFreqPopAvg(i)] = ismember('eventFreqPopAvg', varCondNames);

    calAmpPopAll{t,1} = dataCondition.(varCondNames{idxCalAmpPop(i)});
    calAmpPopAvgAll{t,1} = dataCondition.(varCondNames{idxCalAmpPopAvg(i)});
    calAucPopAll{t,1} = dataCondition.(varCondNames{idxCalAucPop(i)});
    calAucPopAvgAll{t,1} = dataCondition.(varCondNames{idxCalAucPopAvg(i)});
    calAmpPopSEall{t,1} = dataCondition.(varCondNames{idxCalAmpPopSE(i)});
    calAucPopSEall{t,1} = dataCondition.(varCondNames{idxCalAucPopSE(i)});
    calNormPopAll{t,1} = dataCondition.(varCondNames{idxCalNormPop(i)});
    calAucNormPopAll{t,1} = dataCondition.(varCondNames{idxCalAucNormPop(i)});
    calNormPopAvgAll{t,1} = dataCondition.(varCondNames{idxCalNormPopAvg(i)});
    calAucNormPopAvgAll{t,1} = dataCondition.(varCondNames{idxCalAucNormPopAvg(i)});
    calNormPopSEall{t,1} = dataCondition.(varCondNames{idxCalNormPopSE(i)});
    calAucNormPopSEall{t,1} = dataCondition.(varCondNames{idxCalAucNormPopSE(i)});
    peakIdxsPopAll{t,1} = dataCondition.(varCondNames{idxPeakIdxsPop(i)});
    ipiPopAll{t,1} = dataCondition.(varCondNames{idxIpiPop(i)});
    widthPopAll{t,1} = dataCondition.(varCondNames{idxWidthPop(i)});
    calEventsRemovedAll{t,1} = dataCondition.(varCondNames{idxCalEventsRemoved(i)});
    calEventsRemovedAvgAll{t,1} = dataCondition.(varCondNames{idxCalEventsRemovedAvg(i)});
%     eventFrequencyPopAll{t,1} = dataCondition.(varCondNames{idxEventFrequencyPop(i)});
%     eventFreqPopAvgAll{t,1} = dataCondition.(varCondNames{idxEventFreqPopAvg(i)});
    t = t + 1;
end

%% Compile and plot calcium event amplitude and AUC
calAmpPopDark = NaN(numSxs,3);
calAmpPopVisual = NaN(numSxs,3);
calAmpPopGap = NaN(numSxs,3);
calAmpPopAvgDark = NaN(1,3);
calAmpPopAvgVisual = NaN(1,3);
calAmpPopAvgGap = NaN(1,3);
calAmpPopSeVisual = NaN(1,3);

calAucPopDark = NaN(numSxs,3);
calAucPopVisual = NaN(numSxs,3);
calAucPopGap = NaN(numSxs,3);
calAucPopAvgDark = NaN(1,3);
calAucPopAvgVisual = NaN(1,3);
calAucPopAvgGap = NaN(1,3);
calAucPopSeVisual = NaN(1,3);
for i = 1:numConditions
    if size(calAmpPopAll{i}(:,1),1) == numSxs
        calAmpPopDark(1:numSxs,i) = cat(2,calAmpPopAll{i}(:,2));
        calAmpPopVisual(1:numSxs,i) = cat(2,calAmpPopAll{i}(:,1));
        calAmpPopGap(1:numSxs,i) = cat(2,calAmpPopAll{i}(:,3));
        calAmpPopAvgDark(1,i) = cat(2,calAmpPopAvgAll{i}(:,2));
        calAmpPopAvgVisual(1,i) = cat(2,calAmpPopAvgAll{i}(:,1));
        calAmpPopAvgGap(1,i) = cat(2,calAmpPopAvgAll{i}(:,3));
        calAmpPopSeVisual(1,i) = cat(2,calAmpPopSEall{i}(:,1));
        
        calAucPopDark(1:numSxs,i) = cat(2,calAucPopAll{i}(:,1));
        calAucPopVisual(1:numSxs,i) = cat(2,calAucPopAll{i}(:,2));
        calAucPopGap(1:numSxs,i) = cat(2,calAucPopAll{i}(:,3));
        calAucPopAvgDark(1,i) = cat(2,calAucPopAvgAll{i}(:,1));
        calAucPopAvgVisual(1,i) = cat(2,calAucPopAvgAll{i}(:,2));
        calAucPopAvgGap(1,i) = cat(2,calAucPopAvgAll{i}(:,3));
        calAucPopSeVisual(1,i) = cat(2,calAucPopSEall{i}(:,1));
    else
        calAmpPopDark(1:numSxs-1,i) = cat(2,calAmpPopAll{i}(:,2));
        calAmpPopVisual(1:numSxs-1,i) = cat(2,calAmpPopAll{i}(:,1));
        calAmpPopGap(1:numSxs-1,i) = cat(2,calAmpPopAll{i}(:,3));
        calAmpPopAvgDark(1,i) = cat(2,calAmpPopAvgAll{i}(:,2));
        calAmpPopAvgVisual(1,i) = cat(2,calAmpPopAvgAll{i}(:,1));
        calAmpPopAvgGap(1,i) = cat(2,calAmpPopAvgAll{i}(:,3));
        calAmpPopSeVisual(1,i) = cat(2,calAmpPopSEall{i}(:,1));
        
        calAucPopDark(1:numSxs-1,i) = cat(2,calAucPopAll{i}(:,1));
        calAucPopVisual(1:numSxs-1,i) = cat(2,calAucPopAll{i}(:,2));
        calAucPopGap(1:numSxs-1,i) = cat(2,calAucPopAll{i}(:,3));
        calAucPopAvgDark(1,i) = cat(2,calAucPopAvgAll{i}(:,1));
        calAucPopAvgVisual(1,i) = cat(2,calAucPopAvgAll{i}(:,2));
        calAucPopAvgGap(1,i) = cat(2,calAucPopAvgAll{i}(:,3));
        calAucPopSeVisual(1,i) = cat(2,calAucPopSEall{i}(:,1));
    end
end
calAmpPopDarkNew = nanmean(calAmpPopDark(:,1:2),2);
calAmpPopGapNew = nanmean(calAmpPopGap,2);
calAmpPopAvgDarkNew = mean(calAmpPopAvgDark(:,1:2),2);
calAmpPopAvgGapNew = mean(calAmpPopAvgGap,2);
calAmpPopSeDarkNew = std(calAmpPopDarkNew,0,1)/sqrt(numel(calAmpPopDarkNew));
calAmpPopSeGapNew = std(calAmpPopGapNew,0,1)/sqrt(numel(calAmpPopGapNew));
calAmpPopSeVisualNew = nanstd(calAmpPopVisual,0,1)/sqrt(numel(calAmpPopVisual(:,1)));

calAucPopDarkNew = nanmean(calAucPopDark(:,2),2);
calAucPopGapNew = nanmean(calAucPopGap,2);
calAucPopAvgDarkNew = mean(calAucPopAvgDark(:,2),2);
calAucPopAvgGapNew = mean(calAucPopAvgGap,2);
calAucPopSeDarkNew = std(calAucPopDarkNew,0,1)/sqrt(numel(calAucPopDarkNew));
calAucPopSeGapNew = std(calAucPopGapNew,0,1)/sqrt(numel(calAucPopGapNew));
calAucPopSeVisualNew = nanstd(calAucPopVisual,0,1)/sqrt(numel(calAucPopVisual(:,1)));

figure()
subplot(1,2,1);hold on
sgtitle('Calcium event sizes')
bar([calAmpPopAvgGapNew, calAmpPopAvgDarkNew, calAmpPopAvgVisual(2), calAmpPopAvgVisual(1), calAmpPopAvgVisual(3)],'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
scatter(ones(size(calAmpPopGapNew)),calAmpPopGapNew,'LineWidth',1)
scatter(ones(size(calAmpPopDarkNew(:,1))).*2,calAmpPopDarkNew(:,1),'LineWidth',1)
scatter(ones(size(calAmpPopVisual(:,2))).*3,calAmpPopVisual(:,2),'LineWidth',1)
scatter(ones(size(calAmpPopVisual(:,1))).*4,calAmpPopVisual(:,1),'LineWidth',1)
scatter(ones(size(calAmpPopVisual(:,3))).*5,calAmpPopVisual(:,3),'LineWidth',1)
errorbar([calAmpPopAvgGapNew, calAmpPopAvgDarkNew, calAmpPopAvgVisual(2), calAmpPopAvgVisual(1), calAmpPopAvgVisual(3)],...
    [calAmpPopSeGapNew,calAmpPopSeDarkNew,calAmpPopSeVisualNew(2),calAmpPopSeVisualNew(1),calAmpPopSeVisualNew(3)],'Color','k','LineStyle','none','LineWidth',2)
xticks(1:5)
xticklabels({'Sp','Vdark','X0','X2','OKR'})
ylabel('Peak amplitude')

subplot(1,2,2); hold on
bar([calAucPopAvgGapNew, calAucPopAvgDarkNew, calAucPopAvgVisual(2), calAucPopAvgVisual(1), calAucPopAvgVisual(3)],'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
scatter(ones(size(calAucPopGapNew)),calAucPopGapNew,'LineWidth',1)
scatter(ones(size(calAucPopDarkNew(:,1))).*2,calAucPopDarkNew(:,1),'LineWidth',1)
scatter(ones(size(calAucPopVisual(:,2))).*3,calAucPopVisual(:,2),'LineWidth',1)
scatter(ones(size(calAucPopVisual(:,1))).*4,calAucPopVisual(:,1),'LineWidth',1)
scatter(ones(size(calAucPopVisual(:,3))).*5,calAucPopVisual(:,3),'LineWidth',1)
errorbar([calAucPopAvgGapNew, calAucPopAvgDarkNew, calAucPopAvgVisual(2), calAucPopAvgVisual(1), calAucPopAvgVisual(3)],...
    [calAucPopSeGapNew,calAucPopSeDarkNew,calAucPopSeVisualNew(2),calAucPopSeVisualNew(1),calAucPopSeVisualNew(3)],'Color','k','LineStyle','none','LineWidth',2)
xticks(1:5)
xticklabels({'Sp','Vdark','X0','X2','OKR'})
ylabel('AUC')

%% Compile and plot normalized calcium event amplitude and AUC
calNormPopDark = NaN(numSxs,2);
calNormPopVisual = NaN(numSxs,3);
calNormPopAvgDark = NaN(1,2);
calNormPopAvgVisual = NaN(1,3);

calAucNormPopDark = NaN(numSxs,2);
calAucNormPopVisual = NaN(numSxs,3);
calAucNormPopAvgDark = NaN(1,2);
calAucNormPopAvgVisual = NaN(1,3);
for i = 1:numConditions
    if size(calAmpPopAll{i}(:,1),1) == numSxs
        calNormPopDark(1:numSxs,i) = cat(2,calNormPopAll{i}(:,1));
        calNormPopVisual(1:numSxs,i) = cat(2,calNormPopAll{i}(:,2));
        calAucNormPopDark(1:numSxs,i) = cat(2,calAucNormPopAll{i}(:,1));
        calAucNormPopVisual(1:numSxs,i) = cat(2,calAucNormPopAll{i}(:,2));
        calNormPopAvgDark(1,i) = cat(2,calNormPopAvgAll{i}(:,1));
        calNormPopAvgVisual(1,i) = cat(2,calNormPopAvgAll{i}(:,2));
        calAucNormPopAvgDark(1,i) = cat(2,calAucNormPopAvgAll{i}(:,1));
        calAucNormPopAvgVisual(1,i) = cat(2,calAucNormPopAvgAll{i}(:,2));
    else
        calNormPopDark(1:numSxs-1,i) = cat(2,calNormPopAll{i}(:,1));
        calNormPopVisual(1:numSxs-1,i) = cat(2,calNormPopAll{i}(:,2));
        calAucNormPopDark(1:numSxs-1,i) = cat(2,calAucNormPopAll{i}(:,1));
        calAucNormPopVisual(1:numSxs-1,i) = cat(2,calAucNormPopAll{i}(:,2));
        calNormPopAvgDark(1,i) = cat(2,calNormPopAvgAll{i}(:,1));
        calNormPopAvgVisual(1,i) = cat(2,calNormPopAvgAll{i}(:,2));
        calAucNormPopAvgDark(1,i) = cat(2,calAucNormPopAvgAll{i}(:,1));
        calAucNormPopAvgVisual(1,i) = cat(2,calAucNormPopAvgAll{i}(:,2));
    end
end
calNormPopDarkNew = nanmean(calNormPopDark(:,1:2),2);
calAucNormPopDarkNew = nanmean(calAucNormPopDark,2);
calNormPopAvgDarkNew = mean(calNormPopAvgDark(:,1:2),2);
calAucNormPopAvgDarkNew = mean(calAucNormPopAvgDark,2);
calNormPopSeDarkNew = std(calNormPopDarkNew,0,1)/sqrt(numel(calNormPopDarkNew));
calAucNormPopSeDarkNew = std(calAucNormPopDarkNew,0,1)/sqrt(numel(calAucNormPopDarkNew));
calNormPopSeVisual = nanstd(calNormPopVisual,0,1)/sqrt(numel(calNormPopVisual(:,1)));
calAucNormPopSeVisual = nanstd(calAucNormPopVisual,0,1)/sqrt(numel(calAucNormPopVisual(:,1)));

figure()
subplot(1,2,1);hold on
sgtitle('Normalized calcium event sizes')
bar([calNormPopAvgDarkNew(1),calNormPopAvgVisual(2),calNormPopAvgVisual(1),calNormPopAvgVisual(3)],'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
scatter(ones(size(calNormPopDarkNew)),calNormPopDarkNew,'LineWidth',1)
scatter(ones(size(calNormPopVisual(:,2))).*2,calNormPopVisual(:,2),'LineWidth',1)
scatter(ones(size(calNormPopVisual(:,1))).*3,calNormPopVisual(:,1),'LineWidth',1)
scatter(ones(size(calNormPopVisual(:,3))).*4,calNormPopVisual(:,3),'LineWidth',1)
errorbar([calNormPopAvgDarkNew(1),calNormPopAvgVisual(2),calNormPopAvgVisual(1),calNormPopAvgVisual(3)],...
    [calNormPopSeDarkNew,calNormPopSeVisual(2),calNormPopSeVisual(1),calNormPopSeVisual(3)],'Color','k','LineStyle','none','LineWidth',2)
yline(1,'LineStyle','--')
xticks(1:4)
xticklabels({'Vdark','X0','X2','OKR'})
ylabel('Peak amplitude (normalized)')

subplot(1,2,2); hold on
bar([calAucNormPopAvgDarkNew(1),calAucNormPopAvgVisual(2),calAucNormPopAvgVisual(1),calAucNormPopAvgVisual(3)],'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
scatter(ones(size(calAucNormPopDarkNew)),calAucNormPopDarkNew,'LineWidth',1)
scatter(ones(size(calAucNormPopVisual(:,2))).*2,calAucNormPopVisual(:,2),'LineWidth',1)
scatter(ones(size(calAucNormPopVisual(:,1))).*3,calAucNormPopVisual(:,1),'LineWidth',1)
scatter(ones(size(calAucNormPopVisual(:,3))).*4,calAucNormPopVisual(:,3),'LineWidth',1)
errorbar([calAucNormPopAvgDarkNew(1),calAucNormPopAvgVisual(2),calAucNormPopAvgVisual(1),calAucNormPopAvgVisual(3)],...
    [calAucNormPopSeDarkNew,calAucNormPopSeVisual(2),calAucNormPopSeVisual(1),calAucNormPopSeVisual(3)],'Color','k','LineStyle','none','LineWidth',2)
yline(1,'LineStyle','--')
xticks(1:4)
xticklabels({'Vdark','X0','X2','OKR'})
ylabel('AUC (normalized)')

%% Compile and plot event peak indexes, inter-peak intervals, and half-widths
maxDims = cellfun('size', peakIdxsPopAll,1);
maxDimsIpi = cellfun('size', ipiPopAll,1);
maxDimsWidths = cellfun('size', widthPopAll,1);

peakIdxsPopDark = NaN(maxDims(1),3);
peakIdxsPopVisual = NaN(maxDims(1),3);
peakIdxsPopGap = NaN(maxDims(1),3);

ipiPopDark = NaN(maxDimsIpi(1),3);
ipiPopVisual = NaN(maxDimsIpi(1),3);
ipiPopGap = NaN(maxDimsIpi(1),3);

widthsPopDark = NaN(maxDimsWidths(1),3);
widthsPopVisual = NaN(maxDimsWidths(1),3);
widthsPopGap = NaN(maxDimsWidths(1),3);
for i = 1:numConditions
    peakIdxsPopDark(1:maxDims(i),i) = cat(2,peakIdxsPopAll{i}(:,2));
    peakIdxsPopVisual(1:maxDims(i),i) = cat(2,peakIdxsPopAll{i}(:,1));
    peakIdxsPopGap(1:maxDims(i),i) = cat(2,peakIdxsPopAll{i}(:,3));
    ipiPopDark(1:maxDimsIpi(i),i) = cat(2,ipiPopAll{i}(:,2));
    ipiPopVisual(1:maxDimsIpi(i),i) = cat(2,ipiPopAll{i}(:,1));
    ipiPopGap(1:maxDimsIpi(i),i) = cat(2,ipiPopAll{i}(:,3));
    widthsPopDark(1:maxDimsWidths(i),i) = cat(2,widthPopAll{i}(:,2));
    widthsPopVisual(1:maxDimsWidths(i),i) = cat(2,widthPopAll{i}(:,1));
    widthsPopGap(1:maxDimsWidths(i),i) = cat(2,widthPopAll{i}(:,3));
end
peakIdxsPopDarkNew = peakIdxsPopDark(:,2);
peakIdxsPopGapNew = peakIdxsPopGap(:,2);

figure()
sgtitle('Calcium event peak times')
subplot(2,3,1);hold on
histogram(peakIdxsPopGapNew,30,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
xline(250,'LineStyle','--','Color','r','LineWidth',1)
xline(750,'LineStyle','--','Color','b','LineWidth',1)
xticks(0:250:1000)
ylim([0 80])
ax = gca;
xax = ax.XAxis;
set(xax,'TickDirection','out','TickLength',[0.04 0.05])
ylabel('Number of events')
title('Spontaneous')

subplot(2,3,2); hold on
histogram(peakIdxsPopDarkNew,30,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
xline(750,'LineStyle','--','Color','b','LineWidth',1)
xline(250,'LineStyle','--','Color','r','LineWidth',1)
xticks(0:250:1000)
ylim([0 80])
ax = gca;
xax = ax.XAxis;
set(xax,'TickDirection','out','TickLength',[0.04 0.05])
title('Vdark')

subplot(2,3,3); hold on
histogram(peakIdxsPopVisual(:,2),30,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
xline(250,'LineStyle','--','Color','r','LineWidth',1)
xline(750,'LineStyle','--','Color','b','LineWidth',1)
xticks(0:250:1000)
ylim([0 80])
ax = gca;
xax = ax.XAxis;
set(xax,'TickDirection','out','TickLength',[0.04 0.05])
xlabel('Time of peak (ms)')
title('X0')

subplot(2,3,4); hold on
histogram(peakIdxsPopVisual(:,1),30,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
xline(250,'LineStyle','--','Color','r','LineWidth',1)
xline(750,'LineStyle','--','Color','b','LineWidth',1)
xticks(0:250:1000)
ylim([0 80])
ax = gca;
xax = ax.XAxis;
set(xax,'TickDirection','out','TickLength',[0.04 0.05])
ylabel('Number of events')
xlabel('Time of peak (ms)')
title('X2')

subplot(2,3,5); hold on
histogram(peakIdxsPopVisual(:,3),30,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
xline(250,'LineStyle','--','Color','r','LineWidth',1)
xline(750,'LineStyle','--','Color','b','LineWidth',1)
xticks(0:250:1000)
ylim([0 80])
ax = gca;
xax = ax.XAxis;
set(xax,'TickDirection','out','TickLength',[0.04 0.05])
xlabel('Time of peak (ms)')
title('OKR')

subplot(2,3,6); hold on
text(0.05,0.4,'-- Contra drum peak','Color','b')
text(0.05,0.6,'-- Ipsi drum peak','Color','r')
xticklabels({''})
yticklabels({''})
axis off

%% Plot inter-peak event interval times
ipiPopDarkNew = ipiPopDark(:,2);
ipiPopGapNew = ipiPopGap(:,2);

figure()
sgtitle('Calcium inter-peak intervals')
subplot(2,3,1);hold on
histogram(ipiPopGapNew,100,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
xticks(0:1000:6000)
ylim([0 75])
ax = gca;
xax = ax.XAxis;
set(xax,'TickDirection','out','TickLength',[0.04 0.05])
ylabel('Number of events')
title('Spontaneous')

subplot(2,3,2); hold on
histogram(ipiPopDarkNew,100,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
xticks(0:1000:6000)
ylim([0 75])
ax = gca;
xax = ax.XAxis;
set(xax,'TickDirection','out','TickLength',[0.04 0.05])
title('Vdark')

subplot(2,3,3); hold on
histogram(ipiPopVisual(:,2),100,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
xticks(0:1000:6000)
ylim([0 75])
ax = gca;
xax = ax.XAxis;
set(xax,'TickDirection','out','TickLength',[0.04 0.05])
xlabel('Inter-peak interval (ms)')
title('X0')

subplot(2,3,4); hold on
histogram(ipiPopVisual(:,1),100,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
xticks(0:1000:6000)
ylim([0 75])
ax = gca;
xax = ax.XAxis;
set(xax,'TickDirection','out','TickLength',[0.04 0.05])
ylabel('Number of events')
xlabel('Inter-peak interval (ms)')
title('X2')

subplot(2,3,5); hold on
histogram(ipiPopVisual(:,3),100,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
xticks(0:1000:6000)
ylim([0 75])
ax = gca;
xax = ax.XAxis;
set(xax,'TickDirection','out','TickLength',[0.04 0.05])
xlabel('Inter-peak interval (ms)')
title('OKR')

%% Plot calcium event half-widths
widthsPopDarkNew = widthsPopDark(:,2);
widthsPopGapNew = widthsPopGap(:,2);

figure()
sgtitle('Calcium event half-widths')
subplot(2,3,1);hold on
histogram(widthsPopDarkNew,100,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
ylim([0 60])
ax = gca;
xax = ax.XAxis;
set(xax,'TickDirection','out','TickLength',[0.04 0.05])
ylabel('Number of events')
title('Spontaneous')

subplot(2,3,2); hold on
histogram(widthsPopGapNew,100,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
ylim([0 60])
ax = gca;
xax = ax.XAxis;
set(xax,'TickDirection','out','TickLength',[0.04 0.05])
title('Vdark')

subplot(2,3,3); hold on
histogram(widthsPopVisual(:,2),100,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
ylim([0 60])
ax = gca;
xax = ax.XAxis;
set(xax,'TickDirection','out','TickLength',[0.04 0.05])
xlabel('Inter-peak interval (ms)')
title('X0')

subplot(2,3,4); hold on
histogram(widthsPopVisual(:,1),100,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
ylim([0 60])
ax = gca;
xax = ax.XAxis;
set(xax,'TickDirection','out','TickLength',[0.04 0.05])
ylabel('Number of events')
xlabel('Half-width (ms)')
title('X2')

subplot(2,3,5); hold on
histogram(widthsPopVisual(:,3),100,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
ylim([0 60])
ax = gca;
xax = ax.XAxis;
set(xax,'TickDirection','out','TickLength',[0.04 0.05])
xlabel('Half-width (ms)')
title('OKR')
