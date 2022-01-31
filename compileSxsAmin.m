
numSxs = 4;
t = 1;
condition = 3;

if condition == 0
    directories = {'C:\Users\afanning\Documents\Data\forAmin\ExpFmr1\wt'};
elseif condition == 1
    directories = {'C:\Users\afanning\Documents\Data\forAmin\ExpFmr1\tg'};
elseif condition == 2
    directories = {'C:\Users\afanning\Documents\Data\forAmin\photonSaber\1 hz data'};
elseif condition == 3
    directories = {'C:\Users\afanning\Documents\Data\forAmin\photonSaber\0.5 hz data'};
end

%tgs 12, 13 have extremely low eye velocity

%% Concatenate data across experiments from same subject (#1)
%extract data from 1st experiment
idxEyePrePost = NaN(numSxs,1);
idxEyeIpsiGainPct = NaN(numSxs,1);
idxEyeContraGainPct = NaN(numSxs,1);
idxEyeIpsiBlockAmp = NaN(numSxs,1);
idxEyeContraBlockAmp = NaN(numSxs,1);
idxEyeIpsiBlockAmpIdx = NaN(numSxs,1);
idxEyeContraBlockAmpIdx = NaN(numSxs,1);
idxEyeDarkBlockAvg = NaN(numSxs,1);
idxEyeDarkAvg = NaN(numSxs,1);
idxEyeVisualBlockAvg = NaN(numSxs,1);
idxEyeVisualAvg = NaN(numSxs,1);
idxEyeIpsiAmpAvg = NaN(numSxs,1);
idxEyeContraAmpAvg = NaN(numSxs,1);
idxEyeIpsiAmpIdxAvg = NaN(numSxs,1);
idxEyeContraAmpIdxAvg = NaN(numSxs,1);
idxEyeDarkBlockSine = NaN(numSxs,1);
idxEyeVisualBlockSine = NaN(numSxs,1);
idxEyeIpsiSineBlockAmp = NaN(numSxs,1);
idxEyeContraSineBlockAmp = NaN(numSxs,1);
idxEyeVisualSine = NaN(numSxs,1);
idxEyeDarkSine = NaN(numSxs,1);
idxEyeIpsiSineAmpAvg = NaN(numSxs,1);
idxEyeSineAmpAvg = NaN(numSxs,1);

eyePrePost = cell(numSxs,3);
eyeIpsiGainPct = cell(numSxs,3);
eyeContraGainPct = cell(numSxs,3);
eyeIpsiBlockAmp = cell(numSxs,3);
eyeContraBlockAmp = cell(numSxs,3);
eyeIpsiBlockAmpIdx = cell(numSxs,1);
eyeContraBlockAmpIdx = cell(numSxs,1);
eyeDarkBlockAvg = cell(numSxs,3);
eyeDarkAvg = cell(numSxs,3);
eyeVisualBlockAvg = cell(numSxs,2);
eyeVisualAvg = cell(numSxs,2);
eyeIpsiAmpAvg = cell(numSxs,2);
eyeContraAmpAvg = cell(numSxs,2);

eyeIpsiAmpIdxAvg = cell(numSxs,1);
eyeContraAmpIdxAvg = cell(numSxs,1);
eyeDarkBlockSine = cell(numSxs,1);
eyeVisualBlockSine = cell(numSxs,1);

eyeIpsiSineBlockAmp = cell(numSxs,1);
eyeContraSineBlockAmp = cell(numSxs,1);
eyeVisualSine = cell(numSxs,1);
eyeDarkSine = cell(numSxs,1);
eyeIpsiSineAmpAvg = cell(numSxs,1);
eyeSineAmpAvg = cell(numSxs,1);

cd(directories{1})
for i = 1:numSxs
    dataSx = load(uigetfile('*.mat'));
    varNames = fieldnames(dataSx);
    
    [~, idxEyePrePost(i)] = ismember('eyePrePost', varNames);
    [~, idxEyeIpsiGainPct(i)] = ismember('eyeIpsiGainPct', varNames);
    [~, idxEyeContraGainPct(i)] = ismember('eyeContraGainPct', varNames);
    [~, idxEyeIpsiBlockAmp(i)] = ismember('eyeIpsiBlockAmp', varNames);
    [~, idxEyeIpsiBlockAmpIdx(i)] = ismember('eyeIpsiBlockAmpIdx', varNames);
    [~, idxEyeContraBlockAmp(i)] = ismember('eyeContraBlockAmp', varNames);
    [~, idxEyeContraBlockAmpIdx(i)] = ismember('eyeContraBlockAmpIdx', varNames);
    
    [~, idxEyeDarkBlockAvg(i)] = ismember('eyeDarkBlockAvg', varNames);
    [~, idxEyeDarkAvg(i)] = ismember('eyeDarkAvg', varNames);
    [~, idxEyeVisualBlockAvg(i)] = ismember('eyeVisualBlockAvg', varNames);
    [~, idxEyeVisualAvg(i)] = ismember('eyeVisualAvg', varNames);
    
    [~, idxEyeIpsiAmpAvg(i)] = ismember('eyeIpsiAmpAvg', varNames);
    [~, idxEyeIpsiAmpIdxAvg(i)] = ismember('eyeIpsiAmpIdxAvg', varNames);
    [~, idxEyeContraAmpAvg(i)] = ismember('eyeContraAmpAvg', varNames);
    [~, idxEyeContraAmpIdxAvg(i)] = ismember('eyeContraAmpIdxAvg', varNames);
    
    [~, idxEyeDarkBlockSine(i)] = ismember('eyeDarkBlockSine', varNames);
    [~, idxEyeVisualBlockSine(i)] = ismember('eyeVisualBlockSine', varNames);
    [~, idxEyeIpsiSineBlockAmp(i)] = ismember('eyeIpsiSineBlockAmp', varNames);
    [~, idxEyeContraSineBlockAmp(i)] = ismember('eyeContraSineBlockAmp', varNames);
    [~, idxEyeVisualSine(i)] = ismember('eyeVisualSine', varNames);
    [~, idxEyeDarkSine(i)] = ismember('eyeDarkSine', varNames);
    [~, idxEyeIpsiSineAmpAvg(i)] = ismember('eyeIpsiSineAmpAvg', varNames);
    [~, idxEyeContraSineAmpAvg(i)] = ismember('eyeContraSineAmpAvg', varNames);
    
    eyePrePost{t,1} = dataSx.(varNames{idxEyePrePost(i)});
    eyeIpsiGainPct{t,1} = dataSx.(varNames{idxEyeIpsiGainPct(i)});
    eyeContraGainPct{t,1} = dataSx.(varNames{idxEyeContraGainPct(i)});
    eyeIpsiBlockAmp{t,1} = dataSx.(varNames{idxEyeIpsiBlockAmp(i)});
    eyeIpsiAmpIdxAvg{t,1} = dataSx.(varNames{idxEyeIpsiAmpIdxAvg(i)});
    
    eyeContraBlockAmp{t,1} = dataSx.(varNames{idxEyeContraBlockAmp(i)});
    eyeContraBlockAmpIdx{t} = dataSx.(varNames{idxEyeContraBlockAmpIdx(i)});
    eyeDarkBlockAvg{t,1} = dataSx.(varNames{idxEyeDarkBlockAvg(i)});
    eyeVisualBlockSine{t,1} = dataSx.(varNames{idxEyeVisualBlockSine(i)});
    eyeIpsiSineBlockAmp{t,1} = dataSx.(varNames{idxEyeIpsiSineBlockAmp(i)});
    eyeDarkAvg{t,1} = dataSx.(varNames{idxEyeDarkAvg(i)});
    eyeVisualSine{t,1} = dataSx.(varNames{idxEyeVisualSine(i)});
    eyeDarkSine{t,1} = dataSx.(varNames{idxEyeDarkSine(i)});
    eyeVisualBlockAvg{t,1} = dataSx.(varNames{idxEyeVisualBlockAvg(i)});
    eyeIpsiSineAmpAvg{t,1} = dataSx.(varNames{idxEyeIpsiSineAmpAvg(i)});
    eyeVisualAvg{t,1} = dataSx.(varNames{idxEyeVisualAvg(i)});
    eyeIpsiAmpAvg{t,1} = dataSx.(varNames{idxEyeIpsiAmpAvg(i)});
    eyeContraAmpAvg{t,1} = dataSx.(varNames{idxEyeContraAmpAvg(i)});
    
    eyeDarkBlockSine{t,1} = dataSx.(varNames{idxEyeDarkBlockSine(i)});
    eyeVisualBlockSine{t,1} = dataSx.(varNames{idxEyeVisualBlockSine(i)});
    
    eyeIpsiSineBlockAmp{t,1} = dataSx.(varNames{idxEyeIpsiSineBlockAmp(i)});
    eyeContraSineBlockAmp{t,1} = dataSx.(varNames{idxEyeContraSineBlockAmp(i)});
    eyeVisualSine{t,1} = dataSx.(varNames{idxEyeVisualSine(i)});
    eyeDarkSine{t,1} = dataSx.(varNames{idxEyeDarkSine(i)});
    eyeIpsiSineAmpAvg{t,1} = dataSx.(varNames{idxEyeIpsiSineAmpAvg(i)});
    eyeContraSineAmpAvg{t,1} = dataSx.(varNames{idxEyeContraSineAmpAvg(i)});
    t = t + 1;
end

%% Plot Vdark eye record avg
figure('Name','Avg rec. eye vel. Vdark')
subplot(2,1,1); hold on
for i = 1:numSxs
    plot(eyeDarkAvg{i})
end
ylabel('Velocity')
title('Vdark')

subplot(2,1,2); hold on
for i = 1:numSxs
    plot(eyeVisualAvg{i})
end
xlabel('Time (ms)')
ylabel('Velocity')
title('Visual')

%% Plot Vdark eye block avg
figure('Name','Avg rec. eye vel. Vdark')
subplot(2,1,1); hold on
for i = 1:9
    plot(eyeDarkBlockAvg{1})
end

subplot(2,1,2); hold on
for i = 1:3
    plot(eyeVisualBlockAvg{1})
end

%% Compile and plot ipsi and contra eye peak amplitudes
for i = 1:numSxs
    eyeIpsiBlockAmpPopMat(:,i) = eyeIpsiBlockAmp{i}(:,1);
    eyeContraBlockAmpPopMat(:,i) = eyeContraBlockAmp{i}(:,1);
    eyeIpsiSineBlockAmpPopMat(:,i) = eyeIpsiSineBlockAmp{i}(:,1);
    eyeContraSineBlockAmpPopMat(:,i) = eyeContraSineBlockAmp{i}(:,1);
    eyeIpsiVisualBlockAmpPopMat(:,i) = eyeIpsiBlockAmp{i}(:,2);
    eyeContraVisualBlockAmpPopMat(:,i) = eyeContraBlockAmp{i}(:,2);
    eyeIpsiVisualSineBlockAmpPopMat(:,i) = eyeIpsiSineBlockAmp{i}(:,2);
    eyeContraVisualSineBlockAmpPopMat(:,i) = eyeContraSineBlockAmp{i}(:,2);
end
eyeIpsiBlockAmpPopAvg = mean(eyeIpsiBlockAmpPopMat,2);
eyeContraBlockAmpPopAvg = mean(eyeContraBlockAmpPopMat,2);
eyeIpsiSineBlockAmpPopAvg = mean(eyeIpsiSineBlockAmpPopMat,2);
eyeContraSineBlockAmpPopAvg = mean(eyeContraSineBlockAmpPopMat,2);
eyeIpsiVisualBlockAmpPopAvg = mean(eyeIpsiVisualBlockAmpPopMat,2);
eyeContraVisualBlockAmpPopAvg = mean(eyeContraVisualBlockAmpPopMat,2);
eyeIpsiSineVisualBlockAmpPopAvg = mean(eyeIpsiVisualSineBlockAmpPopMat,2);
eyeContraSineVisualBlockAmpPopAvg = mean(eyeContraVisualSineBlockAmpPopMat,2);

eyeIpsiBlockAmpPopSE = nanstd(eyeIpsiBlockAmpPopMat,0,2)/sqrt(size(eyeIpsiBlockAmpPopMat,2));
eyeContraBlockAmpPopSE = nanstd(eyeContraBlockAmpPopMat,0,2)/sqrt(size(eyeContraBlockAmpPopMat,2));
eyeIpsiSineBlockAmpPopSE = nanstd(eyeIpsiSineBlockAmpPopMat,0,2)/sqrt(size(eyeIpsiSineBlockAmpPopMat,2));
eyeContraSineBlockAmpPopSE = nanstd(eyeContraSineBlockAmpPopMat,0,2)/sqrt(size(eyeContraSineBlockAmpPopMat,2));
eyeIpsiVisualBlockAmpPopSE = nanstd(eyeIpsiVisualBlockAmpPopMat,0,2)/sqrt(size(eyeIpsiBlockAmpPopMat,2));
eyeContraVisualBlockAmpPopSE = nanstd(eyeContraVisualBlockAmpPopMat,0,2)/sqrt(size(eyeContraBlockAmpPopMat,2));
eyeIpsiSineVisualBlockAmpPopSE = nanstd(eyeIpsiVisualSineBlockAmpPopMat,0,2)/sqrt(size(eyeIpsiSineBlockAmpPopMat,2));
eyeContraSineVisualBlockAmpPopSE = nanstd(eyeContraVisualSineBlockAmpPopMat,0,2)/sqrt(size(eyeContraSineBlockAmpPopMat,2));

%% Vdark peak eye vel. unfitted and sines-fitted
figure('Name','Vdark peak eye amps')
subplot(2,1,1); hold on
plot(eyeIpsiBlockAmpPopMat)
plot(eyeIpsiBlockAmpPopAvg,'k','LineWidth',2)
errorbar(eyeIpsiBlockAmpPopAvg,eyeIpsiBlockAmpPopSE,'k','LineWidth',2)
title('Vdark -- Ipsi')
ylabel('Abs. eye vel.')

subplot(2,1,2); hold on
plot(abs(eyeContraBlockAmpPopMat))
plot(abs(eyeContraBlockAmpPopAvg),'k','LineWidth',2)
errorbar(abs(eyeContraBlockAmpPopAvg),eyeContraBlockAmpPopSE,'k','LineWidth',2)
title('Vdark -- Contra')
xlabel('Block #')
ylabel('Abs. eye vel.')

figure('Name','Vdark peak eye amps (sines-fitted)')
subplot(2,1,1); hold on
plot(eyeIpsiSineBlockAmpPopMat)
plot(eyeIpsiSineBlockAmpPopAvg,'k','LineWidth',2)
errorbar(eyeIpsiSineBlockAmpPopAvg,eyeIpsiSineBlockAmpPopSE,'k','LineWidth',2)
title('Vdark -- Ipsi')
ylabel('Abs. eye vel.')

subplot(2,1,2); hold on
plot(abs(eyeContraSineBlockAmpPopMat))
plot(abs(eyeContraSineBlockAmpPopAvg),'k','LineWidth',2)
errorbar(abs(eyeContraSineBlockAmpPopAvg),eyeContraSineBlockAmpPopSE,'k','LineWidth',2)
title('Vdark -- Contra')
xlabel('Block #')
ylabel('Abs. eye vel.')

%% Visual peak eye vel. unfitted and sines-fitted
figure('Name','Visual peak eye amps')
subplot(2,1,1); hold on
plot(eyeIpsiVisualBlockAmpPopMat,'-o')
plot(eyeIpsiVisualBlockAmpPopAvg,'k','LineWidth',2)
errorbar(eyeIpsiVisualBlockAmpPopAvg,eyeIpsiVisualBlockAmpPopSE,'k','LineWidth',2)
title('Visual -- Ipsi')
ylabel('Abs. eye vel.')
xticks([1,2,3])

subplot(2,1,2); hold on
plot(abs(eyeContraVisualBlockAmpPopMat),'-o')
plot(abs(eyeContraVisualBlockAmpPopAvg),'k','LineWidth',2)
errorbar(abs(eyeContraVisualBlockAmpPopAvg),eyeContraVisualBlockAmpPopSE,'k','LineWidth',2)
title('Visual -- Contra')
xlabel('Block #')
xticks([1,2,3])
ylabel('Abs. eye vel.')

figure('Name','Visual peak eye amps (sines-fitted')
subplot(2,1,1); hold on
plot(eyeIpsiVisualSineBlockAmpPopMat,'-o')
plot(eyeIpsiSineVisualBlockAmpPopAvg,'k','LineWidth',2)
errorbar(eyeIpsiSineVisualBlockAmpPopAvg,eyeIpsiSineVisualBlockAmpPopSE,'k','LineWidth',2)
title('Visual -- Ipsi')
ylabel('Abs. eye vel.')
xticks([1,2,3])

subplot(2,1,2); hold on
plot(abs(eyeContraVisualSineBlockAmpPopMat),'-o')
plot(abs(eyeContraSineVisualBlockAmpPopAvg),'k','LineWidth',2)
errorbar(abs(eyeContraSineVisualBlockAmpPopAvg),eyeContraSineVisualBlockAmpPopSE,'k','LineWidth',2)
title('Visual -- Contra')
xticks([1,2,3])
xlabel('Block #')
ylabel('Abs. eye vel.')

%% Compile gain % for each directino of eye movement
for i = 1:numSxs
    eyeIpsiGainPctDarkPopMat(:,i) = eyeIpsiGainPct{i}(:,1);
    eyeContraGainPctDarkPopMat(:,i) = eyeContraGainPct{i}(:,1);
    eyeIpsiGainPctSineDarkPopMat(:,i) = eyeIpsiGainPct{i}(:,3);
    eyeContraGainPctSineDarkPopMat(:,i) = eyeContraGainPct{i}(:,3);
    eyeIpsiGainPctVisualPopMat(:,i) = eyeIpsiGainPct{i}(:,2);
    eyeContraGainPctVisualPopMat(:,i) = eyeContraGainPct{i}(:,2);
    eyeIpsiGainPctSineVisualPopMat(:,i) = eyeIpsiGainPct{i}(:,4);
    eyeContraGainPctSineVisualPopMat(:,i) = eyeContraGainPct{i}(:,4);
end
eyeIpsiGainPctDarkPopAvg = mean(eyeIpsiGainPctDarkPopMat,2);
eyeContraGainPctDarkPopAvg = mean(eyeContraGainPctDarkPopMat,2);
eyeIpsiGainPctSineDarkPopAvg = mean(eyeIpsiGainPctSineDarkPopMat,2);
eyeContraGainPctSineDarkPopAvg = mean(eyeContraGainPctSineDarkPopMat,2);

eyeIpsiGainPctVisualPopAvg = mean(eyeIpsiGainPctVisualPopMat,2);
eyeContraGainPctVisualPopAvg = mean(eyeContraGainPctVisualPopMat,2);
eyeIpsiGainPctSineVisualPopAvg = mean(eyeIpsiGainPctSineVisualPopMat,2);
eyeContraGainPctSineVisualPopAvg = mean(eyeContraGainPctSineVisualPopMat,2);

eyeIpsiGainPctDarkPopSE = nanstd(eyeIpsiGainPctDarkPopMat,0,2)/sqrt(size(eyeIpsiGainPctDarkPopMat,2));
eyeContraGainPctDarkPopSE = nanstd(eyeContraGainPctDarkPopMat,0,2)/sqrt(size(eyeContraGainPctDarkPopMat,2));
eyeIpsiGainPctSineDarkPopSE = nanstd(eyeIpsiGainPctSineDarkPopMat,0,2)/sqrt(size(eyeIpsiGainPctSineDarkPopMat,2));
eyeContraGainPctSineDarkPopSE = nanstd(eyeContraGainPctSineDarkPopMat,0,2)/sqrt(size(eyeContraGainPctSineDarkPopMat,2));

eyeIpsiGainPctVisualPopSE = nanstd(eyeIpsiGainPctVisualPopMat,0,2)/sqrt(size(eyeIpsiGainPctVisualPopMat,2));
eyeContraGainPctVisualPopSE = nanstd(eyeContraGainPctVisualPopMat,0,2)/sqrt(size(eyeContraGainPctVisualPopMat,2));
eyeIpsiGainPctSineVisualPopSE = nanstd(eyeIpsiGainPctSineVisualPopMat,0,2)/sqrt(size(eyeIpsiGainPctSineVisualPopMat,2));
eyeContraGainPctSineVisualPopSE = nanstd(eyeContraGainPctSineVisualPopMat,0,2)/sqrt(size(eyeContraGainPctSineVisualPopMat,2));

%% Plot gain % for Vdark
figure('Name','Vdark gain %')
subplot(2,1,1); hold on
plot([eyeIpsiGainPctDarkPopMat(1:4,:); eyeIpsiGainPctDarkPopMat(6,:)])
plot([eyeIpsiGainPctDarkPopAvg(1:4); eyeIpsiGainPctDarkPopAvg(6)],'k','LineWidth',2)
errorbar([eyeIpsiGainPctDarkPopAvg(1:4,:); eyeIpsiGainPctDarkPopAvg(6,:)],[eyeIpsiGainPctDarkPopSE(1:4); eyeIpsiGainPctDarkPopSE(6)],'k','LineWidth',2)
title('Vdark -- Ipsi')
xticks(1:5)
xticklabels({'Pre','10','20','30','Post'})
ylabel('% gain re baseline')

subplot(2,1,2); hold on
plot([eyeContraGainPctDarkPopMat(1:4,:); eyeContraGainPctDarkPopMat(6,:)])
plot([eyeContraGainPctDarkPopAvg(1:4); eyeContraGainPctDarkPopAvg(6)],'k','LineWidth',2)
errorbar([eyeContraGainPctDarkPopAvg(1:4,:); eyeContraGainPctDarkPopAvg(6,:)],[eyeContraGainPctDarkPopSE(1:4); eyeContraGainPctDarkPopSE(6)],'k','LineWidth',2)
title('Vdark -- Contra')
xticks(1:5)
xticklabels({'Pre','10','20','30','Post'})
ylabel('% gain re baseline')
xlabel('Time (min)')

figure('Name','Vdark gain % (sines-fitted)')
subplot(2,1,1); hold on
plot([eyeIpsiGainPctSineDarkPopMat(1:4,:); eyeIpsiGainPctSineDarkPopMat(6,:)])
plot([eyeIpsiGainPctSineDarkPopAvg(1:4); eyeIpsiGainPctSineDarkPopAvg(6)],'k','LineWidth',2)
errorbar([eyeIpsiGainPctSineDarkPopAvg(1:4,:); eyeIpsiGainPctSineDarkPopAvg(6,:)],[eyeIpsiGainPctSineDarkPopSE(1:4); eyeIpsiGainPctSineDarkPopSE(6)],'k','LineWidth',2)
xticks(1:5)
xticklabels({'Pre','10','20','30','Post'})
ylabel('% gain re baseline')
title('Vdark -- Ipsi')

subplot(2,1,2); hold on
plot([eyeContraGainPctSineDarkPopMat(1:4,:); eyeContraGainPctSineDarkPopMat(6,:)])
plot([eyeContraGainPctSineDarkPopAvg(1:4); eyeContraGainPctSineDarkPopAvg(6)],'k','LineWidth',2)
errorbar([eyeContraGainPctSineDarkPopAvg(1:4,:); eyeContraGainPctSineDarkPopAvg(6,:)],[eyeContraGainPctSineDarkPopSE(1:4); eyeContraGainPctSineDarkPopSE(6)],'k','LineWidth',2)
title('Vdark -- Contra')
xticks(1:5)
xticklabels({'Pre','10','20','30','Post'})
ylabel('% gain re baseline')
xlabel('Time (min)')

%% plot only gain averages
figure(); hold on
plot([eyeIpsiGainPctDarkPopAvg(1:4); eyeIpsiGainPctDarkPopAvg(6)],'b','LineWidth',2,'Marker','o')
errorbar([eyeIpsiGainPctDarkPopAvg(1:4,:); eyeIpsiGainPctDarkPopAvg(6,:)],[eyeIpsiGainPctDarkPopSE(1:4); eyeIpsiGainPctDarkPopSE(6)],'b','LineWidth',2)
plot([eyeContraGainPctDarkPopAvg(1:4); eyeContraGainPctDarkPopAvg(6)],'r','LineWidth',2,'Marker','o')
errorbar([eyeContraGainPctDarkPopAvg(1:4,:); eyeContraGainPctDarkPopAvg(6,:)],[eyeContraGainPctDarkPopSE(1:4); eyeContraGainPctDarkPopSE(6)],'r','LineWidth',2)
title('Vdark')
xticks(1:5)
xticklabels({'Pre','10','20','30','Post'})
ylabel('% gain re baseline')
xlabel('Time (min)')
legend('Ipsi','','Contra')

%% Plot gain % for visual
figure('Name','Visual gain %')
subplot(2,1,1); hold on
plot(eyeIpsiGainPctVisualPopMat(1:3,:))
plot(eyeIpsiGainPctVisualPopAvg(1:3),'k','LineWidth',2)
title('Visual -- Ipsi')
errorbar(eyeIpsiGainPctVisualPopAvg(1:3,:),eyeIpsiGainPctVisualPopSE(1:3),'k','LineWidth',2)
xticks(1:3)
xticklabels({'Pre','10','20','30','Post'})
ylabel('% gain re baseline')

subplot(2,1,2); hold on
plot(eyeContraGainPctVisualPopMat(1:3,:))
plot(eyeContraGainPctVisualPopAvg(1:3),'k','LineWidth',2)
title('Visual -- Contra')
errorbar(eyeContraGainPctVisualPopAvg(1:3,:),eyeContraGainPctVisualPopSE(1:3),'k','LineWidth',2)
xticks(1:3)
xticklabels({'Pre','10','20','30','Post'})
ylabel('% gain re baseline')
xlabel('Time (min)')

figure('Name','Visual gain % (sines-fitted)')
subplot(2,1,1); hold on
plot(eyeIpsiGainPctSineVisualPopMat(1:3,:))
plot(eyeIpsiGainPctSineVisualPopAvg(1:3),'k','LineWidth',2)
title('Visual -- Ipsi')
errorbar(eyeIpsiGainPctSineVisualPopAvg(1:3,:),eyeIpsiGainPctSineVisualPopSE(1:3),'k','LineWidth',2)
xticks(1:3)
xticklabels({'Pre','10','20','30','Post'})
ylabel('% gain re baseline')

subplot(2,1,2); hold on
plot(eyeContraGainPctSineVisualPopMat(1:3,:))
plot(eyeContraGainPctSineVisualPopAvg(1:3),'k','LineWidth',2)
errorbar(eyeContraGainPctSineVisualPopAvg(1:3,:),eyeContraGainPctSineVisualPopSE(1:3),'k','LineWidth',2)
title('Visual -- Contra')
xticks(1:3)
xticklabels({'10','20','30'})
ylabel('% gain re baseline')
xlabel('Time (min)')
