%% Concatenate data across experiments from same subject (#1)
%extract data from 1st experiment
cd 'C:\Users\afanning\Documents\Data\FP\l7cre2\l7cre2data0916\l7cre2data09167'
sx1 = dir('l7cre2data09167.mat');
DataSx1 = load('l7cre2data09167');
varNames = fieldnames(DataSx1);

[isTrue, idxCalcium] = ismember('calcium', varNames);
[isTrue, idxCalciumAvg] = ismember('calciumAvg', varNames);
[isTrue, idxCalSineSingle] = ismember('calSineSingle', varNames);
[isTrue, idxCalSineSingleAvg] = ismember('calSineSingleAvg', varNames);
[isTrue, idxCalBlockAmp] = ismember('calBlockAmp', varNames);
[isTrue, idxCalBlockAmpIdx] = ismember('calBlockAmpIdx', varNames);
[isTrue, idxCalSineBlockAvgAmp] = ismember('calSineBlockAvgAmp', varNames);
[isTrue, idxCalSineBlockAvgAmpIdx] = ismember('calSineBlockAvgAmpIdx', varNames);
[isTrue, idxDrumLightAvg] = ismember('drumLightAvg', varNames);
[isTrue, idxEyeSineSingleAvg] = ismember('eyeSineSingleAvg', varNames);
[isTrue, idxEyeLightAvg] = ismember('eyeLightAvg', varNames);

calcium1 = [];
calcium1 = [calcium1; DataSx1.(varNames{idxCalcium})];
calciumAvg1 = [];
calciumAvg1 = [calciumAvg1; DataSx1.(varNames{idxCalciumAvg})];
calSineSingle1 = [];
calSineSingle1 = [calSineSingle1; DataSx1.(varNames{idxCalSineSingle})];
calSineSingleAvg1 = [];
calSineSingleAvg1 = [calSineSingleAvg1; DataSx1.(varNames{idxCalSineSingleAvg})];
calBlockAmp1 = [];
calBlockAmp1 = [calBlockAmp1; DataSx1.(varNames{idxCalBlockAmp})];
calBlockAmpIdx1 = [];
calBlockAmpIdx1 = [calBlockAmpIdx1; DataSx1.(varNames{idxCalBlockAmpIdx})];
calSineBlockAvgAmp1 = [];
calSineBlockAvgAmp1 = [calSineBlockAvgAmp1; DataSx1.(varNames{idxCalSineBlockAvgAmp})];
calSineBlockAvgAmpIdx1 = [];
calSineBlockAvgAmpIdx1 = [calSineBlockAvgAmpIdx1; DataSx1.(varNames{idxCalSineBlockAvgAmpIdx})];
drumLightAvg1 = [];
drumLightAvg1 = [drumLightAvg1; DataSx1.(varNames{idxDrumLightAvg})];
eyeSineSingleAvg1 = [];
eyeSineSingleAvg1 = [eyeSineSingleAvg1; DataSx1.(varNames{idxEyeSineSingleAvg})];
eyeLightAvg1 = [];
eyeLightAvg1 = [eyeLightAvg1; DataSx1.(varNames{idxEyeLightAvg})];

%extract data from 2nd experiment
cd 'C:\Users\afanning\Documents\Data\FP\l7cre2\l7cre2data0916\l7cre2data09168'
sx1b = dir('l7cre2data09168.mat');
DataSx1b = load('l7cre2data09168');
varNames = fieldnames(DataSx1b);

[isTrue, idxCalcium] = ismember('calcium', varNames);
[isTrue, idxCalciumAvg] = ismember('calciumAvg', varNames);
[isTrue, idxCalSineSingle] = ismember('calSineSingle', varNames);
[isTrue, idxCalSineSingleAvg] = ismember('calSineSingleAvg', varNames);
[isTrue, idxCalBlockAmp] = ismember('calBlockAmp', varNames);
[isTrue, idxCalBlockAmpIdx] = ismember('calBlockAmpIdx', varNames);
[isTrue, idxCalSineBlockAvgAmp] = ismember('calSineBlockAvgAmp', varNames);
[isTrue, idxCalSineBlockAvgAmpIdx] = ismember('calSineBlockAvgAmpIdx', varNames);
[isTrue, idxDrumLightAvg] = ismember('drumLightAvg', varNames);
[isTrue, idxEyeSineSingleAvg] = ismember('eyeSineSingleAvg', varNames);
[isTrue, idxEyeLightAvg] = ismember('eyeLightAvg', varNames);

calcium1a = [];
calcium1a = [calcium1a; DataSx1b.(varNames{idxCalcium})];
calciumAvg1a = [];
calciumAvg1a = [calciumAvg1a; DataSx1b.(varNames{idxCalciumAvg})];
calSineSingle1a = [];
calSineSingle1a = [calSineSingle1a; DataSx1b.(varNames{idxCalSineSingle})];
calSineSingleAvg1a = [];
calSineSingleAvg1a = [calSineSingleAvg1a; DataSx1b.(varNames{idxCalSineSingleAvg})];
calBlockAmp1a = [];
calBlockAmp1a = [calBlockAmp1a; DataSx1b.(varNames{idxCalBlockAmp})];
calBlockAmpIdx1a = [];
calBlockAmpIdx1a = [calBlockAmpIdx1a; DataSx1b.(varNames{idxCalBlockAmpIdx})];
calSineBlockAvgAmp1a = [];
calSineBlockAvgAmp1a = [calSineBlockAvgAmp1a; DataSx1b.(varNames{idxCalSineBlockAvgAmp})];
calSineBlockAvgAmpIdx1a = [];
calSineBlockAvgAmpIdx1a = [calSineBlockAvgAmpIdx1a; DataSx1b.(varNames{idxCalSineBlockAvgAmpIdx})];
drumLightAvg1a = [];
drumLightAvg1a = [drumLightAvg1a; DataSx1b.(varNames{idxDrumLightAvg})];
eyeSineSingleAvg1a = [];
eyeSineSingleAvg1a = [eyeSineSingleAvg1a; DataSx1b.(varNames{idxEyeSineSingleAvg})];
eyeLightAvg1a = [];
eyeLightAvg1a = [eyeLightAvg1a; DataSx1b.(varNames{idxEyeLightAvg})];

%% Concatenate data across experiments from same subject (#2)
%extract data from 1st experiment
cd 'C:\Users\afanning\Documents\Data\FP\smcs38\smcs38data0620\smcs38data062014'
sx2 = dir('smcs38data062014.mat');
DataSx2 = load('smcs38data062014');
varNames = fieldnames(DataSx2);

[isTrue, idxCalcium] = ismember('calcium', varNames);
[isTrue, idxCalciumAvg] = ismember('calciumAvg', varNames);
[isTrue, idxCalSineSingle] = ismember('calSineSingle', varNames);
[isTrue, idxCalSineSingleAvg] = ismember('calSineSingleAvg', varNames);
[isTrue, idxCalBlockAmp] = ismember('calBlockAmp', varNames);
[isTrue, idxCalBlockAmpIdx] = ismember('calBlockAmpIdx', varNames);
[isTrue, idxCalSineBlockAvgAmp] = ismember('calSineBlockAvgAmp', varNames);
[isTrue, idxCalSineBlockAvgAmpIdx] = ismember('calSineBlockAvgAmpIdx', varNames);
[isTrue, idxDrumLightAvg] = ismember('drumLightAvg', varNames);
[isTrue, idxEyeSineSingleAvg] = ismember('eyeSineSingleAvg', varNames);
[isTrue, idxEyeLightAvg] = ismember('eyeLightAvg', varNames);

calcium2 = [];
calcium2 = [calcium2; DataSx2.(varNames{idxCalcium})];

calciumAvg2 = [];
calciumAvg2 = [calciumAvg2; DataSx2.(varNames{idxCalciumAvg})];
calSineSingle2 = [];
calSineSingle2 = [calSineSingle2; DataSx2.(varNames{idxCalSineSingle})];
calSineSingleAvg2 = [];
calSineSingleAvg2 = [calSineSingleAvg2; DataSx2.(varNames{idxCalSineSingleAvg})];
calBlockAmp2 = [];
calBlockAmp2 = [calBlockAmp2; DataSx2.(varNames{idxCalBlockAmp})];
calBlockAmpIdx2 = [];
calBlockAmpIdx2 = [calBlockAmpIdx2; DataSx2.(varNames{idxCalBlockAmpIdx})];
calSineBlockAvgAmp2 = [];
calSineBlockAvgAmp2 = [calSineBlockAvgAmp2; DataSx2.(varNames{idxCalSineBlockAvgAmp})];
calSineBlockAvgAmpIdx2 = [];
calSineBlockAvgAmpIdx2 = [calSineBlockAvgAmpIdx2; DataSx2.(varNames{idxCalSineBlockAvgAmpIdx})];
drumLightAvg2 = [];
drumLightAvg2 = [drumLightAvg2; DataSx2.(varNames{idxDrumLightAvg})];
eyeSineSingleAvg2 = [];
eyeSineSingleAvg2 = [eyeSineSingleAvg2; DataSx2.(varNames{idxEyeSineSingleAvg})];
eyeLightAvg2 = [];
eyeLightAvg2 = [eyeLightAvg2; DataSx2.(varNames{idxEyeLightAvg})];

%% Extract data from 2nd subject
cd 'C:\Users\afanning\Documents\Data\FP\smcs38\smcs38data0620\smcs38data062016'
sx2b = dir('smcs38data062016.mat');
DataSx2b = load('smcs38data062016');
varNames = fieldnames(DataSx2b);

[isTrue, idxCalcium] = ismember('calcium', varNames);
[isTrue, idxCalciumAvg] = ismember('calciumAvg', varNames);
[isTrue, idxCalSineSingle] = ismember('calSineSingle', varNames);
[isTrue, idxCalSineSingleAvg] = ismember('calSineSingleAvg', varNames);
[isTrue, idxCalBlockAmp] = ismember('calBlockAmp', varNames);
[isTrue, idxCalBlockAmpIdx] = ismember('calBlockAmpIdx', varNames);
[isTrue, idxCalSineBlockAvgAmp] = ismember('calSineBlockAvgAmp', varNames);
[isTrue, idxCalSineBlockAvgAmpIdx] = ismember('calSineBlockAvgAmpIdx', varNames);
[isTrue, idxDrumLightAvg] = ismember('drumLightAvg', varNames);
[isTrue, idxEyeSineSingleAvg] = ismember('eyeSineSingleAvg', varNames);
[isTrue, idxEyeLightAvg] = ismember('eyeLightAvg', varNames);

calcium2a = [];
calcium2a = [calcium2a; DataSx2b.(varNames{idxCalcium})];
calciumAvg2a = [];
calciumAvg2a = [calciumAvg2a; DataSx2b.(varNames{idxCalciumAvg})];
calSineSingle2a = [];
calSineSingle2a = [calSineSingle2a; DataSx2b.(varNames{idxCalSineSingle})];
calSineSingleAvg2a = [];
calSineSingleAvg2a = [calSineSingleAvg2a; DataSx2b.(varNames{idxCalSineSingleAvg})];
calBlockAmp2a = [];
calBlockAmp2a = [calBlockAmp2a; DataSx2b.(varNames{idxCalBlockAmp})];
calBlockAmpIdx2a = [];
calBlockAmpIdx2a = [calBlockAmpIdx2a; DataSx2b.(varNames{idxCalBlockAmpIdx})];
calSineBlockAvgAmp2a = [];
calSineBlockAvgAmp2a = [calSineBlockAvgAmp2a; DataSx2b.(varNames{idxCalSineBlockAvgAmp})];
calSineBlockAvgAmpIdx2a = [];
calSineBlockAvgAmpIdx2a = [calSineBlockAvgAmpIdx2a; DataSx2b.(varNames{idxCalSineBlockAvgAmpIdx})];
drumLightAvg2a = [];
drumLightAvg2a = [drumLightAvg2a; DataSx2b.(varNames{idxDrumLightAvg})];
eyeSineSingleAvg2a = [];
eyeSineSingleAvg2a = [eyeSineSingleAvg2a; DataSx2b.(varNames{idxEyeSineSingleAvg})];
eyeLightAvg2a = [];
eyeLightAvg2a = [eyeLightAvg2a; DataSx2b.(varNames{idxEyeLightAvg})];

%% Concatenate data from each subject

calBlockAmpIdxDim = [calBlockAmpIdx1{1:5}; calBlockAmpIdx2a{1:5}];
calBlockAmpIdxAvgDim = mean(calBlockAmpIdxDim,1);
calBlockAmpIdxDimPopMean = mean(calBlockAmpIdxAvgDim);
calSineBlockAvgAmpIdxDim = [calSineBlockAvgAmpIdx1{1:5}; calSineBlockAvgAmpIdx2a{1:5}];
calSineBlockAmpIdxAvgDim = mean(calSineBlockAvgAmpIdxDim,1);
calSineBlockAmpIdxDimPopMean = mean(calSineBlockAmpIdxAvgDim);

calBlockAmpIdxBright = [calBlockAmpIdx1a{1:5}; calBlockAmpIdx2{1:5}];
calBlockAmpIdxAvgBright = mean(calBlockAmpIdxBright,1);
calBlockAmpIdxBrightPopMean = mean(calBlockAmpIdxAvgBright);
calSineBlockAvgAmpIdxBright = [calSineBlockAvgAmpIdx1{1:5}; calSineBlockAvgAmpIdx2a{1:5}];
calSineBlockAmpIdxAvgBright = mean(calSineBlockAvgAmpIdxBright,1);
calSineBlockAmpIdxBrightPopMean = mean(calSineBlockAmpIdxAvgBright);

drumLightAvg2aShift = circshift(drumLightAvg2a,-86);
calciumAvgB = circshift(calciumAvg2a,-86);
calcium = [calciumAvg1a calciumAvg1];
calciumSub2 = [calciumAvg2 calciumAvgB];
drum = [drumLightAvg1 drumLightAvg1a];
drumRescale = rescale(drumLightAvg1,0,3);
drumSub2 = [drumLightAvg2 drumLightAvg2aShift];
drumSub2rescale = rescale(drumLightAvg2,-0.1,0.1);

rs1 = drumLightAvg1 - eyeLightAvg1;
rs1a = drumLightAvg1a - eyeLightAvg1a;
rs2 = drumLightAvg2 - eyeLightAvg2;
rs2a = drumLightAvg2a - eyeLightAvg2a;
figure(); hold on
plot(calcium*100)
plot(drumRescale)

figure(); hold on
plot(calciumSub2*100)
plot(drumSub2rescale)

%plot sine-fitted calcium traces
calSineSingle1 = [calSineSingleAvg1a calSineSingleAvg1];
calSineSingle1shift = circshift(calSineSingle1,500);
calSineSingleAvg2b = circshift(calSineSingleAvg2a,-86);
calSineSingle2 = [calSineSingleAvg2 calSineSingleAvg2b];
calSineSingle2shift = circshift(calSineSingle2,500);
drumRescale = rescale(drumLightAvg1,-1,1);
drumRescaleShift = circshift(drumRescale,500);
drumRescale2 = rescale(drumLightAvg2,-0.1,0.1);
drumRescale2shift = circshift(drumRescale2,500);
plot(drumLightAvg2)
figure(); hold on
plot(calSineSingle1shift*100)
plot(drumRescaleShift*-1)

figure(); hold on
plot(calSineSingle2shift*100)
plot(drumSub2rescale)

calSine1 = circshift(calSineSingleAvg1,500);
calSine1a = circshift(calSineSingleAvg1a,500);
sineMin = min(calSine1);
sineMin1a = min(calSine1a);
calSine1 = calSine1*100 + abs(sineMin*100);
calSine1a = calSine1a*100 + abs(sineMin1a*100);
drum1 = circshift(drumLightAvg1,500);
drum1a = circshift(drumLightAvg1a,500);
drum1rescale = rescale(drumLightAvg1,0,2.5);
drum1aRescale = rescale(drumLightAvg1a,0,2.5)
rs1 = drumLightAvg1 - eyeSineSingleAvg1;
rs1a = drumLightAvg1a - eyeSineSingleAvg1a;
rs1rescale = rescale(rs1,0,2.5)
rs1aRescale = rescale(rs1a,0,2.5)

plot(calSine1)
hold on
plot(calSine1a)
plot(drum1rescale)
plot(drum1aRescale)
plot(rs1rescale)
plot(rs1aRescale)

figure(); hold on
plot(drumLightAvg1)
plot(eyeSineSingleAvg1)
plot(rs1)
plot(calciumAvg1*100)
figure(); hold on
plot(drumLightAvg1a)
plot(eyeSineSingleAvg1a)
plot(rs1a)
plot(calciumAvg1a*100)

%% 
%plot calcium traces
figure()
t = tiledlayout(2,2);
t.TileSpacing = 'compact';
t.Padding = 'tight';
drumRescale1 = rescale(drumLightAvg1,0,3);
drumRescale1 = drumRescale1*-1+max(drumRescale1)
drumRescale1a = rescale(drumLightAvg1a,0,3);
drumRescale1a = drumRescale1a*-1+max(drumRescale1a)
drumRescale2 = rescale(drumLightAvg2,0,0.5);
drumRescale2 = drumRescale2*-1+max(drumRescale2)
drumRescale2a = rescale(drumLightAvg2a,0,0.5);
drumRescale2a = drumRescale2a*-1+max(drumRescale2a)
nexttile; hold on
plot(calcium1*100)
plot(drumRescale1)
title('Dim')
ylabel('% \DeltaF/G')
ylim([0 6])
legend('Block 1', 'Block 2', 'Block 3', 'Block 4', 'Block 5', 'Drum vel.')
nexttile; hold on
plot(calcium2a*100)
plot(drumRescale2a)
title('Dim')
ylim([0 0.8])
nexttile; hold on
plot(calcium1a*100)
plot(drumRescale1a)
ylabel('% \DeltaF/G')
xlabel('Time (ms)')
title('Bright')
ylim([0 6])
nexttile; hold on
plot(calcium2*100)
plot(drumRescale2)
title('Bright')
xlabel('Time (ms)')
ylim([0 0.8])
%% 
rs1 = drumLightAvg1 - eyeLightAvg1;
rs1a = drumLightAvg1a - eyeLightAvg1a;
rs2 = drumLightAvg2 - eyeLightAvg2;
rs2a = drumLightAvg2a - eyeLightAvg2a;
figure()
t = tiledlayout(2,2);
t.TileSpacing = 'compact';
t.Padding = 'tight';
rsRescale1 = rescale(rs1,0,3);
rsRescale1 = rsRescale1*-1+max(rsRescale1)
rsRescale1a = rescale(rs1a,0,3);
rsRescale1a = rsRescale1a*-1+max(rsRescale1a)
rsRescale2 = rescale(rs2,0,0.5);
rsRescale2 = rsRescale2*-1+max(rsRescale2)
rsRescale2a = rescale(rs2a,0,0.5);
rsRescale2a = rsRescale2a*-1+max(rsRescale2a)
nexttile; hold on
plot(calciumAvg1*100)
plot(rsRescale1)
title('Dim')
ylabel('% \DeltaF/G')
ylim([0 6])
legend('Calcium avg.','Retinal slip vel.')
nexttile; hold on
plot(calciumAvg2a*100)
plot(rsRescale2a)
title('Dim')
ylim([0 0.8])
nexttile; hold on
plot(calciumAvg1a*100)
plot(rsRescale1a)
ylabel('% \DeltaF/G')
xlabel('Time (ms)')
title('Bright')
ylim([0 6])
nexttile; hold on
plot(calciumAvg2*100)
plot(rsRescale2)
title('Bright')
xlabel('Time (ms)')
ylim([0 0.8])
%% Concatenating and analyzing data across the population
% calciumAvgX2 = cat(1,calciumAvgReshape1(:,1),calciumAvgReshape2(:,1),calciumAvgReshape3(:,1),calciumAvgReshape4(:,1),calciumAvgReshape5(:,1),calciumAvgReshape6(:,1),calciumAvgReshape7(:,1));
% calciumAvgX0 = cat(1,calciumAvgReshape1(:,2),calciumAvgReshape2(:,2),calciumAvgReshape3(:,2),calciumAvgReshape4(:,2),calciumAvgReshape5(:,2),calciumAvgReshape6(:,2),calciumAvgReshape7(:,2));
% calciumAvgOKR = cat(1,calciumAvgReshape1(:,3),calciumAvgReshape2(:,3),calciumAvgReshape3(:,3),calciumAvgReshape4(:,3),calciumAvgReshape5(:,3),calciumAvgReshape6(:,3),calciumAvgReshape7(:,3));
% calciumAvgX2reshape = reshape(calciumAvgX2,1000,7);
% calciumAvgX0reshape = reshape(calciumAvgX0,1000,7);
% calciumAvgOKRreshape = reshape(calciumAvgOKR,1000,7);
% calciumAvgX2mean = mean(calciumAvgX2reshape,2);
% calciumAvgX0mean = mean(calciumAvgX0reshape,2);
% calciumAvgOKRmean = mean(calciumAvgOKRreshape,2);
% % dFdAllAvgReshape = circshift(calciumAvgX0,500);
% calDavg = cat(1,calDavgReshape1,calDavgReshape2,calDavgReshape3,calDavgReshape4,calDavgReshape5,calDavgReshape6,calDavgReshape7);
% calDavgReshape = reshape(calDavg,1000,7);
% calDmean = mean(calDavgReshape,2);
% 
% calDsinePeak = cat(1,calDsinePeak1,calDsinePeak2,calDsinePeak3,calDsinePeak4,calDsinePeak5,calDsinePeak6,calDsinePeak7);
% calDsinePeakAvg = mean(calDsinePeak,1);
% calDsinePeakSE = std(calDsinePeak(:,1),0,1)./(sqrt(numel(calDsinePeak(:,1))));
% calDsinePeakIdx = cat(1,calDsinePeakIdx1,calDsinePeakIdx2,calDsinePeakIdx3,calDsinePeakIdx4,calDsinePeakIdx5,calDsinePeakIdx6,calDsinePeakIdx7);
% calDsinePeakIdxReshape = reshape(calDsinePeakIdx,3,7);
% calDsinePeakIdxAvg = mean(calDsinePeakIdxReshape(1:2,:),1);
% calDsinePeakIdxMean = mean(calDsinePeakIdxAvg);
% 
% calSinePeak = cat(1,calSinePeak1,calSinePeak2,calSinePeak3,calSinePeak4,calSinePeak5,calSinePeak6,calSinePeak7);
% calSinePeakReshape = reshape(calSinePeak,3,7);
% calSinePeakX2avg = mean(calSinePeakReshape(1,:),2);
% calSinePeakX0avg = mean(calSinePeakReshape(2,:),2);
% calSinePeakOKRavg = mean(calSinePeakReshape(3,:),2);
% calSinePeakX2se = std(calSinePeakReshape(1,:),0,2)./(sqrt(numel(calSinePeakReshape(1,:))));
% calSinePeakX0se = std(calSinePeakReshape(2,:),0,2)./(sqrt(numel(calSinePeakReshape(2,:))));
% calSinePeakOKRse = std(calSinePeakReshape(3,:),0,2)./(sqrt(numel(calSinePeakReshape(3,:))));
% calSinePeakIdx = cat(1,calSinePeakIdx1,calSinePeakIdx2,calSinePeakIdx3,calSinePeakIdx4,calSinePeakIdx5,calSinePeakIdx6,calSinePeakIdx7);
% calSinePeakIdxReshape = reshape(calSinePeakIdx,3,7);
% calSinePeakIdxX2avg = mean(calSinePeakIdx(1,:),1);
% calSinePeakIdxX0avg = mean(calSinePeakIdx(2,:),1);
% calSinePeakIdxOKRavg = mean(calSinePeakIdx(3,:),1);
