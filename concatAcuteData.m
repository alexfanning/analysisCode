%% Concatenate data across experiments from same subject (#1)
%extract data from 1st experiment
cd 'C:\Users\afanning\Documents\Data\FP\MouseF\data0828\data08289'
sx1 = dir('mouseFdata08289calpresacPostsac.mat');
DataSx1 = load('mouseFdata08289calpresacPostsac');
varNames = fieldnames(DataSx1);

[isTrue, idxCalDavg] = ismember('calDavg', varNames);
[isTrue, idxCalciumAvg] = ismember('calciumAvg', varNames);
[isTrue, idxCalDsinePeak] = ismember('calDsinePeak', varNames);
[isTrue, idxCalDsinePeakIdx] = ismember('calDsinePeakIdx', varNames);
[isTrue, idxCalSinePeak] = ismember('calSinePeak', varNames);
[isTrue, idxCalSinePeakIdx] = ismember('calSinePeakIdx', varNames);
[isTrue, idxCalDsineBlockAvg] = ismember('calDsineBlockAvg', varNames);
[isTrue, idxCalDsineBlockAvgAmp] = ismember('calDsineBlockAvgAmp', varNames);


calDavg1 = [];
calDavg1 = [calDavg1; DataSx1.(varNames{idxCalDavg})];
calciumAvg1 = [];
calciumAvg1 = [calciumAvg1; DataSx1.(varNames{idxCalciumAvg})];
calDsinePeak1 = [];
calDsinePeak1 = [calDsinePeak1; DataSx1.(varNames{idxCalDsinePeak})];
calDsinePeakIdx1 = [];
calDsinePeakIdx1 = [calDsinePeakIdx1; DataSx1.(varNames{idxCalDsinePeakIdx})];
calSinePeak1 = [];
calSinePeak1 = [calSinePeak1; DataSx1.(varNames{idxCalSinePeak})];
calSinePeakIdx1 = [];
calSinePeakIdx1 = [calSinePeakIdx1; DataSx1.(varNames{idxCalSinePeakIdx})];
calDsineBlockAvg1 = [];
calDsineBlockAvg1 = [calDsineBlockAvg1; DataSx1.(varNames{idxCalDsineBlockAvg})];
calDsineBlockAvgAmp1 = [];
calDsineBlockAvgAmp1 = [calDsineBlockAvgAmp1; DataSx1.(varNames{idxCalDsineBlockAvgAmp})];

%extract data from 2nd experiment
cd 'C:\Users\afanning\Documents\Data\FP\MouseF\data0828\data082811'
sx1b = dir('mouseFdata082811calpresacPostsac.mat');
DataSx1b = load('mouseFdata082811calpresacPostsac');
varNames = fieldnames(DataSx1b);

[isTrue, idxCalDavg] = ismember('calDavg', varNames);
[isTrue, idxCalciumAvg] = ismember('calciumAvg', varNames);
[isTrue, idxCalDsinePeak] = ismember('calDsinePeak', varNames);
[isTrue, idxCalDsinePeakIdx] = ismember('calDsinePeakIdx', varNames);
[isTrue, idxCalSinePeak] = ismember('calSinePeak', varNames);
[isTrue, idxCalSinePeakIdx] = ismember('calSinePeakIdx', varNames);
[isTrue, idxCalDsineBlockAvg] = ismember('calDsineBlockAvg', varNames);
[isTrue, idxCalDsineBlockAvgAmp] = ismember('calDsineBlockAvgAmp', varNames);

calDavg1 = [calDavg1; DataSx1b.(varNames{idxCalDavg})];
calciumAvg1 = [calciumAvg1; DataSx1b.(varNames{idxCalciumAvg})];
calDsinePeak1 = [calDsinePeak1; DataSx1b.(varNames{idxCalDsinePeak})];
calDsinePeakIdx1 = [calDsinePeakIdx1; DataSx1b.(varNames{idxCalDsinePeakIdx})];
calSinePeak1 = [calSinePeak1; DataSx1b.(varNames{idxCalSinePeak})];
calSinePeakIdx1 = [calSinePeakIdx1; DataSx1b.(varNames{idxCalSinePeakIdx})];
calDsineBlockAvg1 = [calDsineBlockAvg1; DataSx1b.(varNames{idxCalDsineBlockAvg})];
calDsineBlockAvgAmp1 = [calDsineBlockAvgAmp1; DataSx1b.(varNames{idxCalDsineBlockAvgAmp})];

%extract data from 3rd experiment
cd 'C:\Users\afanning\Documents\Data\FP\MouseF\data0828\data082812'
sx1c = dir('mouseFdata082812calpresacPostsac.mat');
DataSx1c = load('mouseFdata082812calpresacPostsac');
varNames = fieldnames(DataSx1c);

[isTrue, idxCalDavg] = ismember('calDavg', varNames);
[isTrue, idxCalciumAvg] = ismember('calciumAvg', varNames);
[isTrue, idxCalDsinePeak] = ismember('calDsinePeak', varNames);
[isTrue, idxCalDsinePeakIdx] = ismember('calDsinePeakIdx', varNames);
[isTrue, idxCalSinePeak] = ismember('calSinePeak', varNames);
[isTrue, idxCalSinePeakIdx] = ismember('calSinePeakIdx', varNames);
[isTrue, idxCalDsineBlockAvg] = ismember('calDsineBlockAvg', varNames);
[isTrue, idxCalDsineBlockAvgAmp] = ismember('calDsineBlockAvgAmp', varNames);

calDavg1 = [calDavg1; DataSx1c.(varNames{idxCalDavg})];
calciumAvg1 = [calciumAvg1; DataSx1c.(varNames{idxCalciumAvg})];
calDsinePeak1 = [calDsinePeak1; DataSx1c.(varNames{idxCalDsinePeak})];
calDsinePeakIdx1 = [calDsinePeakIdx1; DataSx1c.(varNames{idxCalDsinePeakIdx})];
calSinePeak1 = [calSinePeak1; DataSx1c.(varNames{idxCalSinePeak})];
calSinePeakIdx1 = [calSinePeakIdx1; DataSx1c.(varNames{idxCalSinePeakIdx})];
calDsineBlockAvg1 = [calDsineBlockAvg1; DataSx1c.(varNames{idxCalDsineBlockAvg})];
calDsineBlockAvgAmp1 = [calDsineBlockAvgAmp1; DataSx1c.(varNames{idxCalDsineBlockAvgAmp})];

%cycle averaged vestibular-dark calcium trace
calDavgReshape1 = reshape(calDavg1,1000,3);
calDavgReshape1 = nanmean(calDavgReshape1(:,1:2),2);
calciumAvgReshape1 = reshape(calciumAvg1,1000,3);

%average across experiments
calDsinePeak1 = mean(calDsinePeak1(1:2));
calDsinePeak1 = 2*calDsinePeak1;
calSinePeak1 = 2*calSinePeak1;

calDsineBlockAvg1 = [calDsineBlockAvg1{1:end}];
calDconcatBlockAvg1 = cell(1,1);
calDconcatBlockAvg1{1} = max(nanmean(calDsineBlockAvg1(:,1:2),2));
calDconcatBlockAvg1{2} = max(nanmean(calDsineBlockAvg1(:,3:4),2));
calDconcatBlockAvg1{3} = max(nanmean(calDsineBlockAvg1(:,5:6),2));
calDconcatBlockAvg1{4} = max(nanmean(calDsineBlockAvg1(:,7:8),2));
calDconcatBlockAvg1{5} = max(nanmean(calDsineBlockAvg1(:,9:10),2));
calDconcatBlockAvg1{6} = max(nanmean(calDsineBlockAvg1(:,11:12),2));
calDconcatBlockAvg1{7} = max(nanmean(calDsineBlockAvg1(:,13:14),2));
calDconcatBlockAvg1{8} = max(nanmean(calDsineBlockAvg1(:,15:16),2));
calDconcatBlockAvg1{9} = max(nanmean(calDsineBlockAvg1(:,17:18),2));
calDconcatBlockAvg1{10} = max(nanmean(calDsineBlockAvg1(:,19:20),2));
calDconcatBlockAvg1{11} = max(nanmean(calDsineBlockAvg1(:,21:22),2));
calDconcatBlockAvg1{12} = max(nanmean(calDsineBlockAvg1(:,23:24),2));
calDconcatBlock1 = cat(1,calDconcatBlockAvg1{1:12});

%% Concatenate data across experiments from same subject (#2)
%Extract data from 1st experiment

cd 'C:\Users\afanning\Documents\Data\FP\SMCS1\data1002\data10022'
sx2 = dir('smcs1data10022calpresacPostsac.mat');
DataSx2 = load('smcs1data10022calpresacPostsac');
varNames = fieldnames(DataSx2);

[isTrue, idxCalDavg] = ismember('calDavg', varNames);
[isTrue, idxCalciumAvg] = ismember('calciumAvg', varNames);
[isTrue, idxCalDsinePeak] = ismember('calDsinePeak', varNames);
[isTrue, idxCalDsinePeakIdx] = ismember('calDsinePeakIdx', varNames);
[isTrue, idxCalSinePeak] = ismember('calSinePeak', varNames);
[isTrue, idxCalSinePeakIdx] = ismember('calSinePeakIdx', varNames);
[isTrue, idxCalDsineBlockAvg] = ismember('calDsineBlockAvg', varNames);
[isTrue, idxCalDsineBlockAvgAmp] = ismember('calDsineBlockAvgAmp', varNames);

calDavg2 = [];
calDavg2 = [calDavg2; DataSx2.(varNames{idxCalDavg})];
calciumavg2 = [];
calciumavg2 = [calciumavg2; DataSx2.(varNames{idxCalciumAvg})];
calDsinePeak2 = [];
calDsinePeak2 = [calDsinePeak2; DataSx2.(varNames{idxCalDsinePeak})];
calDsinePeakIdx2 = [];
calDsinePeakIdx2 = [calDsinePeakIdx2; DataSx2.(varNames{idxCalDsinePeakIdx})];
calSinePeak2 = [];
calSinePeak2 = [calSinePeak2; DataSx2.(varNames{idxCalSinePeak})];
calSinePeakIdx2 = [];
calSinePeakIdx2 = [calSinePeakIdx2; DataSx2.(varNames{idxCalSinePeakIdx})];
calDsineBlockAvg2 = [];
calDsineBlockAvg2 = [calDsineBlockAvg2; DataSx2.(varNames{idxCalDsineBlockAvg})];
calDsineBlockAvgAmp2 = [];
calDsineBlockAvgAmp2 = [calDsineBlockAvgAmp2; DataSx2.(varNames{idxCalDsineBlockAvgAmp})];

%extract data from 2nd experiment
cd 'C:\Users\afanning\Documents\Data\FP\SMCS1\data1002\data10029'
sx2b = dir('smcs1data10029calpresacPostsac.mat');
DataSx2b = load('smcs1data10029calpresacPostsac');
varNames = fieldnames(DataSx2b);

[isTrue, idxCalDavg] = ismember('calDavg', varNames);
[isTrue, idxCalciumAvg] = ismember('calciumAvg', varNames);
[isTrue, idxCalDsinePeak] = ismember('calDsinePeak', varNames);
[isTrue, idxCalDsinePeakIdx] = ismember('calDsinePeakIdx', varNames);
[isTrue, idxCalSinePeak] = ismember('calSinePeak', varNames);
[isTrue, idxCalSinePeakIdx] = ismember('calSinePeakIdx', varNames);
[isTrue, idxCalDsineBlockAvg] = ismember('calDsineBlockAvg', varNames);
[isTrue, idxCalDsineBlockAvgAmp] = ismember('calDsineBlockAvgAmp', varNames);

calDavg2 = [calDavg2; DataSx2b.(varNames{idxCalDavg})];
calciumAvg2 = [calciumavg2; DataSx2b.(varNames{idxCalciumAvg})];
calDsinePeak2 = [calDsinePeak2; DataSx2b.(varNames{idxCalDsinePeak})];
calDsinePeakIdx2 = [calDsinePeakIdx2; DataSx2b.(varNames{idxCalDsinePeakIdx})];
calSinePeak2 = [calSinePeak2; DataSx2b.(varNames{idxCalSinePeak})];
calSinePeakIdx2 = [calSinePeakIdx2; DataSx2b.(varNames{idxCalSinePeakIdx})];
calDsineBlockAvg2 = [calDsineBlockAvg2; DataSx2b.(varNames{idxCalDsineBlockAvg})];
calDsineBlockAvgAmp2 = [calDsineBlockAvgAmp2; DataSx2b.(varNames{idxCalDsineBlockAvgAmp})];

%extract data from 3rd experiment
cd 'C:\Users\afanning\Documents\Data\FP\SMCS1\data1002\data10027'
sx2c = dir('smcs1data10027calpresacPostsac.mat');
DataSx2c = load('smcs1data10027calpresacPostsac');
varNames = fieldnames(DataSx2c);

[isTrue, idxCalDavg] = ismember('calDavg', varNames);
[isTrue, idxCalciumAvg] = ismember('calciumAvg', varNames);
[isTrue, idxCalDsinePeak] = ismember('calDsinePeak', varNames);
[isTrue, idxCalDsinePeakIdx] = ismember('calDsinePeakIdx', varNames);
[isTrue, idxCalSinePeak] = ismember('calSinePeak', varNames);
[isTrue, idxCalSinePeakIdx] = ismember('calSinePeakIdx', varNames);
[isTrue, idxCalDsineBlockAvg] = ismember('calDsineBlockAvg', varNames);
[isTrue, idxCalDsineBlockAvgAmp] = ismember('calDsineBlockAvgAmp', varNames);

calDavg2 = [calDavg2; DataSx2c.(varNames{idxCalDavg})];
calciumAvg2 = [calciumAvg2; DataSx2c.(varNames{idxCalciumAvg})];
calDsinePeak2 = [calDsinePeak2; DataSx2c.(varNames{idxCalDsinePeak})];
calDsinePeakIdx2 = [calDsinePeakIdx2; DataSx2c.(varNames{idxCalDsinePeakIdx})];
calSinePeak2 = [calSinePeak2; DataSx2c.(varNames{idxCalSinePeak})];
calSinePeakIdx2 = [calSinePeakIdx2; DataSx2c.(varNames{idxCalSinePeakIdx})];
calDsineBlockAvg2 = [calDsineBlockAvg2; DataSx2c.(varNames{idxCalDsineBlockAvg})];
calDsineBlockAvgAmp2 = [calDsineBlockAvgAmp2; DataSx2c.(varNames{idxCalDsineBlockAvgAmp})];

%cycle averaged vestibular-dark calcium trace
calDavgReshape2 = reshape(calDavg2,1000,3);
calDavgReshape2 = nanmean(calDavgReshape2(:,1:2),2);
calciumAvgReshape2 = reshape(calciumAvg2,1000,3);

%average across experiments
calDsinePeak2 = mean(calDsinePeak2(1:2));
calDsinePeak2 = 2*calDsinePeak2;
calSinePeak2 = 2*calSinePeak2;

calDsineBlockAvg2 = [calDsineBlockAvg2{1:end}];
calDconcatBlockAvg2 = cell(1,1);
calDconcatBlockAvg2{1} = max(nanmean(calDsineBlockAvg2(:,1:2),2));
calDconcatBlockAvg2{2} = max(nanmean(calDsineBlockAvg2(:,3:4),2));
calDconcatBlockAvg2{3} = max(nanmean(calDsineBlockAvg2(:,5:6),2));
calDconcatBlockAvg2{4} = max(nanmean(calDsineBlockAvg2(:,7:8),2));
calDconcatBlockAvg2{5} = max(nanmean(calDsineBlockAvg2(:,9:10),2));
calDconcatBlockAvg2{6} = max(nanmean(calDsineBlockAvg2(:,11:12),2));
calDconcatBlockAvg2{7} = max(nanmean(calDsineBlockAvg2(:,13:14),2));
calDconcatBlockAvg2{8} = max(nanmean(calDsineBlockAvg2(:,15:16),2));
calDconcatBlockAvg2{9} = max(nanmean(calDsineBlockAvg2(:,17:18),2));
calDconcatBlockAvg2{10} = max(nanmean(calDsineBlockAvg2(:,19:20),2));
calDconcatBlockAvg2{11} = max(nanmean(calDsineBlockAvg2(:,21:22),2));
calDconcatBlockAvg2{12} = max(nanmean(calDsineBlockAvg2(:,23:24),2));
calDconcatBlock2 = cat(1,calDconcatBlockAvg2{1:12});

%% Concatenate data across experiments from same subject (#3)
%Extract data from 1st experiment
cd 'C:\Users\afanning\Documents\Data\FP\SMCS3\data1008\data10084'
sx3 = dir('smcs3data10084calpresacPostsac.mat');
DataSx3 = load('smcs3data10084calpresacPostsac');
varNames = fieldnames(DataSx3);

[isTrue, idxCalDavg] = ismember('calDavg', varNames);
[isTrue, idxCalciumAvg] = ismember('calciumAvg', varNames);
[isTrue, idxCalDsinePeak] = ismember('calDsinePeak', varNames);
[isTrue, idxCalDsinePeakIdx] = ismember('calDsinePeakIdx', varNames);
[isTrue, idxCalSinePeak] = ismember('calSinePeak', varNames);
[isTrue, idxCalSinePeakIdx] = ismember('calSinePeakIdx', varNames);
[isTrue, idxCalDsineBlockAvg] = ismember('calDsineBlockAvg', varNames);
[isTrue, idxCalDsineBlockAvgAmp] = ismember('calDsineBlockAvgAmp', varNames);

calDavg3 = [];
calDavg3 = [calDavg3; DataSx3.(varNames{idxCalDavg})];
calciumAvg3 = [];
calciumAvg3 = [calciumAvg3; DataSx3.(varNames{idxCalciumAvg})];
calDsinePeak3 = [];
calDsinePeak3 = [calDsinePeak3; DataSx3.(varNames{idxCalDsinePeak})];
calDsinePeakIdx3 = [];
calDsinePeakIdx3 = [calDsinePeakIdx3; DataSx3.(varNames{idxCalDsinePeakIdx})];
calSinePeak3 = [];
calSinePeak3 = [calSinePeak3; DataSx3.(varNames{idxCalSinePeak})];
calSinePeakIdx3 = [];
calSinePeakIdx3 = [calSinePeakIdx3; DataSx3.(varNames{idxCalSinePeakIdx})];
calDsineBlockAvg3 = [];
calDsineBlockAvg3 = [calDsineBlockAvg3; DataSx3.(varNames{idxCalDsineBlockAvg})];
calDsineBlockAvgAmp3 = [];
calDsineBlockAvgAmp3 = [calDsineBlockAvgAmp3; DataSx3.(varNames{idxCalDsineBlockAvgAmp})];

%extract data from 2nd experiment
cd 'C:\Users\afanning\Documents\Data\FP\SMCS3\data1008\data10083'
sx3b = dir('smcs3data10083calpresacPostsac.mat');
DataSx3b = load('smcs3data10083calpresacPostsac');
varNames = fieldnames(DataSx3b);

[isTrue, idxCalDavg] = ismember('calDavg', varNames);
[isTrue, idxCalciumAvg] = ismember('calciumAvg', varNames);
[isTrue, idxCalDsinePeak] = ismember('calDsinePeak', varNames);
[isTrue, idxCalDsinePeakIdx] = ismember('calDsinePeakIdx', varNames);
[isTrue, idxCalSinePeak] = ismember('calSinePeak', varNames);
[isTrue, idxCalSinePeakIdx] = ismember('calSinePeakIdx', varNames);
[isTrue, idxCalDsineBlockAvg] = ismember('calDsineBlockAvg', varNames);
[isTrue, idxCalDsineBlockAvgAmp] = ismember('calDsineBlockAvgAmp', varNames);

calDavg3 = [calDavg3; DataSx3b.(varNames{idxCalDavg})];
calciumAvg3 = [calciumAvg3; DataSx3b.(varNames{idxCalciumAvg})];
calDsinePeak3 = [calDsinePeak3; DataSx3b.(varNames{idxCalDsinePeak})];
calDsinePeakIdx3 = [calDsinePeakIdx3; DataSx3b.(varNames{idxCalDsinePeakIdx})];
calSinePeak3 = [calSinePeak3; DataSx3b.(varNames{idxCalSinePeak})];
calSinePeakIdx3 = [calSinePeakIdx3; DataSx3b.(varNames{idxCalSinePeakIdx})];
calDsineBlockAvg3 = [calDsineBlockAvg3; DataSx3b.(varNames{idxCalDsineBlockAvg})];
calDsineBlockAvgAmp3 = [calDsineBlockAvgAmp3; DataSx3b.(varNames{idxCalDsineBlockAvgAmp})];

%extract data from 3rd experiment
cd 'C:\Users\afanning\Documents\Data\FP\smcs30\smcs30data1003\smcs30data10035'
sx3c = dir('smcs30data10035calpresacPostsac.mat');
DataSx3c = load('smcs30data10035calpresacPostsac');
varNames = fieldnames(DataSx3c);

[isTrue, idxCalDavg] = ismember('calDavg', varNames);
[isTrue, idxCalciumAvg] = ismember('calciumAvg', varNames);
[isTrue, idxCalDsinePeak] = ismember('calDsinePeak', varNames);
[isTrue, idxCalDsinePeakIdx] = ismember('calDsinePeakIdx', varNames);
[isTrue, idxCalSinePeak] = ismember('calSinePeak', varNames);
[isTrue, idxCalSinePeakIdx] = ismember('calSinePeakIdx', varNames);
[isTrue, idxCalDsineBlockAvg] = ismember('calDsineBlockAvg', varNames);
[isTrue, idxCalDsineBlockAvgAmp] = ismember('calDsineBlockAvgAmp', varNames);

calDavg3 = [calDavg3; DataSx3c.(varNames{idxCalDavg})];
calciumAvg3 = [calciumAvg3; DataSx3c.(varNames{idxCalciumAvg})];
calDsinePeak3 = [calDsinePeak3; DataSx3c.(varNames{idxCalDsinePeak})];
calDsinePeakIdx3 = [calDsinePeakIdx3; DataSx3c.(varNames{idxCalDsinePeakIdx})];
calSinePeak3 = [calSinePeak3; DataSx3c.(varNames{idxCalSinePeak})];
calSinePeakIdx3 = [calSinePeakIdx3; DataSx3c.(varNames{idxCalSinePeakIdx})];
calDsineBlockAvg3 = [calDsineBlockAvg3; DataSx3c.(varNames{idxCalDsineBlockAvg})];
calDsineBlockAvgAmp3 = [calDsineBlockAvgAmp3; DataSx3c.(varNames{idxCalDsineBlockAvgAmp})];

%cycle averaged vestibular-dark calcium trace
calDavgReshape3 = reshape(calDavg3,1000,3);
calDavgReshape3 = nanmean(calDavgReshape3(:,1:2),2);
calciumAvgReshape3 = reshape(calciumAvg3,1000,3);

%average across experiments
calDsinePeak3 = mean(calDsinePeak3(1:2));
calDsinePeak3 = 2*calDsinePeak3;
calSinePeak3 = 2*calSinePeak3;

calDsineBlockAvg3 = [calDsineBlockAvg3{1:end}];
calDconcatBlockAvg3 = cell(1,1);
calDconcatBlockAvg3{1} = max(nanmean(calDsineBlockAvg3(:,1:2),2));
calDconcatBlockAvg3{2} = max(nanmean(calDsineBlockAvg3(:,3:4),2));
calDconcatBlockAvg3{3} = max(nanmean(calDsineBlockAvg3(:,5:6),2));
calDconcatBlockAvg3{4} = max(nanmean(calDsineBlockAvg3(:,7:8),2));
calDconcatBlockAvg3{5} = max(nanmean(calDsineBlockAvg3(:,9:10),2));
calDconcatBlockAvg3{6} = max(nanmean(calDsineBlockAvg3(:,11:12),2));
calDconcatBlockAvg3{7} = max(nanmean(calDsineBlockAvg3(:,13:14),2));
calDconcatBlockAvg3{8} = max(nanmean(calDsineBlockAvg3(:,15:16),2));
calDconcatBlockAvg3{9} = max(nanmean(calDsineBlockAvg3(:,17:18),2));
calDconcatBlockAvg3{10} = max(nanmean(calDsineBlockAvg3(:,19:20),2));
calDconcatBlockAvg3{11} = max(nanmean(calDsineBlockAvg3(:,21:22),2));
calDconcatBlockAvg3{12} = max(nanmean(calDsineBlockAvg3(:,23:24),2));
calDconcatBlock3 = cat(1,calDconcatBlockAvg3{1:12});

%% Concatenate data across experiments from same subject (#4)
%Extract data from 1st experiment
cd 'C:\Users\afanning\Documents\Data\FP\SMCS5\data1112\data11122'
sx4 = dir('smcs5data11122calpresacPostsac.mat');
DataSx4 = load('smcs5data11122calpresacPostsac');
varNames = fieldnames(DataSx4);

[isTrue, idxCalDavg] = ismember('calDavg', varNames);
[isTrue, idxCalciumAvg] = ismember('calciumAvg', varNames);
[isTrue, idxCalDsinePeak] = ismember('calDsinePeak', varNames);
[isTrue, idxCalDsinePeakIdx] = ismember('calDsinePeakIdx', varNames);
[isTrue, idxCalSinePeak] = ismember('calSinePeak', varNames);
[isTrue, idxCalSinePeakIdx] = ismember('calSinePeakIdx', varNames);
[isTrue, idxCalDsineBlockAvg] = ismember('calDsineBlockAvg', varNames);
[isTrue, idxCalDsineBlockAvgAmp] = ismember('calDsineBlockAvgAmp', varNames);

calDavg4 = [];
calDavg4 = [calDavg4; DataSx4.(varNames{idxCalDavg})];
calciumAvg4 = [];
calciumAvg4 = [calciumAvg4; DataSx4.(varNames{idxCalciumAvg})];
calDsinePeak4 = [];
calDsinePeak4 = [calDsinePeak4; DataSx4.(varNames{idxCalDsinePeak})];
calDsinePeakIdx4 = [];
calDsinePeakIdx4 = [calDsinePeakIdx4; DataSx4.(varNames{idxCalDsinePeakIdx})];
calSinePeak4 = [];
calSinePeak4 = [calSinePeak4; DataSx4.(varNames{idxCalSinePeak})];
calSinePeakIdx4 = [];
calSinePeakIdx4 = [calSinePeakIdx4; DataSx4.(varNames{idxCalSinePeakIdx})];
calDsineBlockAvg4 = [];
calDsineBlockAvg4 = [calDsineBlockAvg4; DataSx4.(varNames{idxCalDsineBlockAvg})];
calDsineBlockAvgAmp4 = [];
calDsineBlockAvgAmp4 = [calDsineBlockAvgAmp4; DataSx4.(varNames{idxCalDsineBlockAvgAmp})];

%extract data from 2nd experiment
cd 'C:\Users\afanning\Documents\Data\FP\SMCS5\data1112\data11123'
sx4b = dir('smcs5data11123calpresacPostsac.mat');
DataSx4b = load('smcs5data11123calpresacPostsac');
varNames = fieldnames(DataSx4b);

[isTrue, idxCalDavg] = ismember('calDavg', varNames);
[isTrue, idxCalciumAvg] = ismember('calciumAvg', varNames);
[isTrue, idxCalDsinePeak] = ismember('calDsinePeak', varNames);
[isTrue, idxCalDsinePeakIdx] = ismember('calDsinePeakIdx', varNames);
[isTrue, idxCalSinePeak] = ismember('calSinePeak', varNames);
[isTrue, idxCalSinePeakIdx] = ismember('calSinePeakIdx', varNames);
[isTrue, idxCalDsineBlockAvg] = ismember('calDsineBlockAvg', varNames);
[isTrue, idxCalDsineBlockAvgAmp] = ismember('calDsineBlockAvgAmp', varNames);

calDavg4 = [calDavg4; DataSx4b.(varNames{idxCalDavg})];
calciumAvg4 = [calciumAvg4; DataSx4b.(varNames{idxCalciumAvg})];
calDsinePeak4 = [calDsinePeak4; DataSx4b.(varNames{idxCalDsinePeak})];
calDsinePeakIdx4 = [calDsinePeakIdx4; DataSx4b.(varNames{idxCalDsinePeakIdx})];
calSinePeak4 = [calSinePeak4; DataSx4b.(varNames{idxCalSinePeak})];
calSinePeakIdx4 = [calSinePeakIdx4; DataSx4b.(varNames{idxCalSinePeakIdx})];
calDsineBlockAvg4 = [calDsineBlockAvg4; DataSx4b.(varNames{idxCalDsineBlockAvg})];
calDsineBlockAvgAmp4 = [calDsineBlockAvgAmp4; DataSx4b.(varNames{idxCalDsineBlockAvgAmp})];

%extract data from 3rd experiment
cd 'C:\Users\afanning\Documents\Data\FP\SMCS5\data1112\data11127'
sx4b = dir('smcs5data11127calpresacPostsac.mat');
DataSx4c = load('smcs5data11127calpresacPostsac');
varNames = fieldnames(DataSx4c);

[isTrue, idxCalDavg] = ismember('calDavg', varNames);
[isTrue, idxCalciumAvg] = ismember('calciumAvg', varNames);
[isTrue, idxCalDsinePeak] = ismember('calDsinePeak', varNames);
[isTrue, idxCalDsinePeakIdx] = ismember('calDsinePeakIdx', varNames);
[isTrue, idxCalSinePeak] = ismember('calSinePeak', varNames);
[isTrue, idxCalSinePeakIdx] = ismember('calSinePeakIdx', varNames);
[isTrue, idxCalDsineBlockAvg] = ismember('calDsineBlockAvg', varNames);
[isTrue, idxCalDsineBlockAvgAmp] = ismember('calDsineBlockAvgAmp', varNames);

calDavg4 = [calDavg4; DataSx4c.(varNames{idxCalDavg})];
calciumAvg4 = [calciumAvg4; DataSx4c.(varNames{idxCalciumAvg})];
calDsinePeak4 = [calDsinePeak4; DataSx4c.(varNames{idxCalDsinePeak})];
calDsinePeakIdx4 = [calDsinePeakIdx4; DataSx4c.(varNames{idxCalDsinePeakIdx})];
calSinePeak4 = [calSinePeak4; DataSx4c.(varNames{idxCalSinePeak})];
calSinePeakIdx4 = [calSinePeakIdx4; DataSx4c.(varNames{idxCalSinePeakIdx})];
calDsineBlockAvg4 = [calDsineBlockAvg4; DataSx4c.(varNames{idxCalDsineBlockAvg})];
calDsineBlockAvgAmp4 = [calDsineBlockAvgAmp4; DataSx4c.(varNames{idxCalDsineBlockAvgAmp})];

%cycle averaged vestibular-dark calcium trace
calDavgReshape4 = reshape(calDavg4,1000,3);
calDavgReshape4 = nanmean(calDavgReshape4(:,1:2),2);
calciumAvgReshape4 = reshape(calciumAvg4,1000,3);

%average across experiments
calDsinePeak4 = mean(calDsinePeak4(1:2));
calDsinePeak4 = 2*calDsinePeak4;
calSinePeak4 = 2*calSinePeak4;

calDsineBlockAvg4 = [calDsineBlockAvg4{1:end}];
calDconcatBlockAvg4 = cell(1,1);
calDconcatBlockAvg4{1} = max(nanmean(calDsineBlockAvg4(:,1:2),2));
calDconcatBlockAvg4{2} = max(nanmean(calDsineBlockAvg4(:,3:4),2));
calDconcatBlockAvg4{3} = max(nanmean(calDsineBlockAvg4(:,5:6),2));
calDconcatBlockAvg4{4} = max(nanmean(calDsineBlockAvg4(:,7:8),2));
calDconcatBlockAvg4{5} = max(nanmean(calDsineBlockAvg4(:,9:10),2));
calDconcatBlockAvg4{6} = max(nanmean(calDsineBlockAvg4(:,11:12),2));
calDconcatBlockAvg4{7} = max(nanmean(calDsineBlockAvg4(:,13:14),2));
calDconcatBlockAvg4{8} = max(nanmean(calDsineBlockAvg4(:,15:16),2));
calDconcatBlockAvg4{9} = max(nanmean(calDsineBlockAvg4(:,17:18),2));
calDconcatBlockAvg4{10} = max(nanmean(calDsineBlockAvg4(:,19:20),2));
calDconcatBlockAvg4{11} = max(nanmean(calDsineBlockAvg4(:,21:22),2));
calDconcatBlockAvg4{12} = max(nanmean(calDsineBlockAvg4(:,23:24),2));
calDconcatBlock4 = cat(1,calDconcatBlockAvg4{1:12});

%% Concatenate data across experiments from same subject (#5)
%Extract data from 1st experiment
cd 'C:\Users\afanning\Documents\Data\FP\l7cre2\l7cre2data1003\l7cre2data10038'
sx5 = dir('l7cre2data10038calpresacPostsac.mat');
DataSx5 = load('l7cre2data10038calpresacPostsac');
varNames = fieldnames(DataSx5);

[isTrue, idxCalDavg] = ismember('calDavg', varNames);
[isTrue, idxCalciumAvg] = ismember('calciumAvg', varNames);
[isTrue, idxCalDsinePeak] = ismember('calDsinePeak', varNames);
[isTrue, idxCalDsinePeakIdx] = ismember('calDsinePeakIdx', varNames);
[isTrue, idxCalSinePeak] = ismember('calSinePeak', varNames);
[isTrue, idxCalSinePeakIdx] = ismember('calSinePeakIdx', varNames);
[isTrue, idxCalDsineBlockAvg] = ismember('calDsineBlockAvg', varNames);
[isTrue, idxCalDsineBlockAvgAmp] = ismember('calDsineBlockAvgAmp', varNames);

calDavg5 = [];
calDavg5 = [calDavg5; DataSx5.(varNames{idxCalDavg})];
calciumAvg5 = [];
calciumAvg5 = [calciumAvg5; DataSx5.(varNames{idxCalciumAvg})];
calDsinePeak5 = [];
calDsinePeak5 = [calDsinePeak5; DataSx5.(varNames{idxCalDsinePeak})];
calDsinePeakIdx5 = [];
calDsinePeakIdx5 = [calDsinePeakIdx5; DataSx5.(varNames{idxCalDsinePeakIdx})];
calSinePeak5 = [];
calSinePeak5 = [calSinePeak5; DataSx5.(varNames{idxCalSinePeak})];
calSinePeakIdx5 = [];
calSinePeakIdx5 = [calSinePeakIdx5; DataSx5.(varNames{idxCalSinePeakIdx})];
calDsineBlockAvg5 = [];
calDsineBlockAvg5 = [calDsineBlockAvg5; DataSx5.(varNames{idxCalDsineBlockAvg})];
calDsineBlockAvgAmp5 = [];
calDsineBlockAvgAmp5 = [calDsineBlockAvgAmp5; DataSx5.(varNames{idxCalDsineBlockAvgAmp})];

%extract data from 2nd experiment
cd 'C:\Users\afanning\Documents\Data\FP\SMCS12\data0109\data01092'
sx5b = dir('smcs12data01092calpresacPostsac.mat');
DataSx5b = load('smcs12data01092calpresacPostsac');
varNames = fieldnames(DataSx5b);

[isTrue, idxCalDavg] = ismember('calDavg', varNames);
[isTrue, idxCalciumAvg] = ismember('calciumAvg', varNames);
[isTrue, idxCalDsinePeak] = ismember('calDsinePeak', varNames);
[isTrue, idxCalDsinePeakIdx] = ismember('calDsinePeakIdx', varNames);
[isTrue, idxCalSinePeak] = ismember('calSinePeak', varNames);
[isTrue, idxCalSinePeakIdx] = ismember('calSinePeakIdx', varNames);
[isTrue, idxCalDsineBlockAvg] = ismember('calDsineBlockAvg', varNames);
[isTrue, idxCalDsineBlockAvgAmp] = ismember('calDsineBlockAvgAmp', varNames);

calDavg5 = [calDavg5; DataSx5b.(varNames{idxCalDavg})];
calciumAvg5 = [calciumAvg5; DataSx5b.(varNames{idxCalciumAvg})];
calDsinePeak5 = [calDsinePeak5; DataSx5b.(varNames{idxCalDsinePeak})];
calDsinePeakIdx5 = [calDsinePeakIdx5; DataSx5b.(varNames{idxCalDsinePeakIdx})];
calSinePeak5 = [calSinePeak5; DataSx5b.(varNames{idxCalSinePeak})];
calSinePeakIdx5 = [calSinePeakIdx5; DataSx5b.(varNames{idxCalSinePeakIdx})];
calDsineBlockAvg5 = [calDsineBlockAvg5; DataSx5b.(varNames{idxCalDsineBlockAvg})];
calDsineBlockAvgAmp5 = [calDsineBlockAvgAmp5; DataSx5b.(varNames{idxCalDsineBlockAvgAmp})];

%extract data from 3rd experiment
cd 'C:\Users\afanning\Documents\Data\FP\SMCS12\data0109\data01094'
sx5b = dir('smcs12data01094calpresacPostsac.mat');
DataSx5c = load('smcs12data01094calpresacPostsac');
varNames = fieldnames(DataSx5c);

[isTrue, idxCalDavg] = ismember('calDavg', varNames);
[isTrue, idxCalciumAvg] = ismember('calciumAvg', varNames);
[isTrue, idxCalDsinePeak] = ismember('calDsinePeak', varNames);
[isTrue, idxCalDsinePeakIdx] = ismember('calDsinePeakIdx', varNames);
[isTrue, idxCalSinePeak] = ismember('calSinePeak', varNames);
[isTrue, idxCalSinePeakIdx] = ismember('calSinePeakIdx', varNames);
[isTrue, idxCalDsineBlockAvg] = ismember('calDsineBlockAvg', varNames);
[isTrue, idxCalDsineBlockAvgAmp] = ismember('calDsineBlockAvgAmp', varNames);

calDavg5 = [calDavg5; DataSx5c.(varNames{idxCalDavg})];
calciumAvg5 = [calciumAvg5; DataSx5c.(varNames{idxCalciumAvg})];
calDsinePeak5 = [calDsinePeak5; DataSx5c.(varNames{idxCalDsinePeak})];
calDsinePeakIdx5 = [calDsinePeakIdx5; DataSx5c.(varNames{idxCalDsinePeakIdx})];
calSinePeak5 = [calSinePeak5; DataSx5c.(varNames{idxCalSinePeak})];
calSinePeakIdx5 = [calSinePeakIdx5; DataSx5c.(varNames{idxCalSinePeakIdx})];
calDsineBlockAvg5 = [calDsineBlockAvg5; DataSx5c.(varNames{idxCalDsineBlockAvg})];
calDsineBlockAvgAmp5 = [calDsineBlockAvgAmp5; DataSx5c.(varNames{idxCalDsineBlockAvgAmp})];

%cycle averaged vestibular-dark calcium trace
calDavgReshape5 = reshape(calDavg5,1000,3);
calDavgReshape5 = nanmean(calDavgReshape5(:,1:2),2);
calciumAvgReshape5 = reshape(calciumAvg5,1000,3);

%average across experiments
calDsinePeak5 = mean(calDsinePeak5(1:2));
calDsinePeak5 = 2*calDsinePeak5;
calSinePeak5 = 2*calSinePeak5;

calDsineBlockAvg5 = [calDsineBlockAvg5{1:end}];
calDconcatBlockAvg5 = cell(1,1);
calDconcatBlockAvg5{1} = max(nanmean(calDsineBlockAvg5(:,1:2),2));
calDconcatBlockAvg5{2} = max(nanmean(calDsineBlockAvg5(:,3:4),2));
calDconcatBlockAvg5{3} = max(nanmean(calDsineBlockAvg5(:,5:6),2));
calDconcatBlockAvg5{4} = max(nanmean(calDsineBlockAvg5(:,7:8),2));
calDconcatBlockAvg5{5} = max(nanmean(calDsineBlockAvg5(:,9:10),2));
calDconcatBlockAvg5{6} = max(nanmean(calDsineBlockAvg5(:,11:12),2));
calDconcatBlockAvg5{7} = max(nanmean(calDsineBlockAvg5(:,13:14),2));
calDconcatBlockAvg5{8} = max(nanmean(calDsineBlockAvg5(:,15:16),2));
calDconcatBlockAvg5{9} = max(nanmean(calDsineBlockAvg5(:,17:18),2));
calDconcatBlockAvg5{10} = max(nanmean(calDsineBlockAvg5(:,19:20),2));
calDconcatBlockAvg5{11} = max(nanmean(calDsineBlockAvg5(:,21:22),2));
calDconcatBlockAvg5{12} = max(nanmean(calDsineBlockAvg5(:,23:24),2));
calDconcatBlock5 = cat(1,calDconcatBlockAvg5{1:12});

%% Concatenate data across experiments from same subject (#6)
%Extract data from 1st experiment
cd 'C:\Users\afanning\Documents\Data\FP\SMCS14\data0123\data01232'
sx6 = dir('smcs14data01232calpresacPostsac.mat');
DataSx6 = load('smcs14data01232calpresacPostsac');
varNames = fieldnames(DataSx6);

[isTrue, idxCalDavg] = ismember('calDavg', varNames);
[isTrue, idxCalciumAvg] = ismember('calciumAvg', varNames);
[isTrue, idxCalDsinePeak] = ismember('calDsinePeak', varNames);
[isTrue, idxCalDsinePeakIdx] = ismember('calDsinePeakIdx', varNames);
[isTrue, idxCalSinePeak] = ismember('calSinePeak', varNames);
[isTrue, idxCalSinePeakIdx] = ismember('calSinePeakIdx', varNames);
[isTrue, idxCalDsineBlockAvg] = ismember('calDsineBlockAvg', varNames);
[isTrue, idxCalDsineBlockAvgAmp] = ismember('calDsineBlockAvgAmp', varNames);

calDavg6 = [];
calDavg6 = [calDavg6; DataSx6.(varNames{idxCalDavg})];
calciumAvg6 = [];
calciumAvg6 = [calciumAvg6; DataSx6.(varNames{idxCalciumAvg})];
calDsinePeak6 = [];
calDsinePeak6 = [calDsinePeak6; DataSx6.(varNames{idxCalDsinePeak})];
calDsinePeakIdx6 = [];
calDsinePeakIdx6 = [calDsinePeakIdx6; DataSx6.(varNames{idxCalDsinePeakIdx})];
calSinePeak6 = [];
calSinePeak6 = [calSinePeak6; DataSx6.(varNames{idxCalSinePeak})];
calSinePeakIdx6 = [];
calSinePeakIdx6 = [calSinePeakIdx6; DataSx6.(varNames{idxCalSinePeakIdx})];
calDsineBlockAvg6 = [];
calDsineBlockAvg6 = [calDsineBlockAvg6; DataSx6.(varNames{idxCalDsineBlockAvg})];
calDsineBlockAvgAmp6 = [];
calDsineBlockAvgAmp6 = [calDsineBlockAvgAmp6; DataSx6.(varNames{idxCalDsineBlockAvgAmp})];

%extract data from 2nd experiment
cd 'C:\Users\afanning\Documents\Data\FP\SMCS14\data0123\data01231'
sx6b = dir('smcs14data01231calpresacPostsac.mat');
DataSx6b = load('smcs14data01231calpresacPostsac');
varNames = fieldnames(DataSx6b);

[isTrue, idxCalDavg] = ismember('calDavg', varNames);
[isTrue, idxCalciumAvg] = ismember('calciumAvg', varNames);
[isTrue, idxCalDsinePeak] = ismember('calDsinePeak', varNames);
[isTrue, idxCalDsinePeakIdx] = ismember('calDsinePeakIdx', varNames);
[isTrue, idxCalSinePeak] = ismember('calSinePeak', varNames);
[isTrue, idxCalSinePeakIdx] = ismember('calSinePeakIdx', varNames);
[isTrue, idxCalDsineBlockAvg] = ismember('calDsineBlockAvg', varNames);
[isTrue, idxCalDsineBlockAvgAmp] = ismember('calDsineBlockAvgAmp', varNames);

calDavg6 = [calDavg6; DataSx6b.(varNames{idxCalDavg})];
calciumAvg6 = [calciumAvg6; DataSx6b.(varNames{idxCalciumAvg})];
calDsinePeak6 = [calDsinePeak6; DataSx6b.(varNames{idxCalDsinePeak})];
calDsinePeakIdx6 = [calDsinePeakIdx6; DataSx6b.(varNames{idxCalDsinePeakIdx})];
calSinePeak6 = [calSinePeak6; DataSx6b.(varNames{idxCalSinePeak})];
calSinePeakIdx6 = [calSinePeakIdx6; DataSx6b.(varNames{idxCalSinePeakIdx})];
calDsineBlockAvg6 = [calDsineBlockAvg6; DataSx6b.(varNames{idxCalDsineBlockAvg})];
calDsineBlockAvgAmp6 = [calDsineBlockAvgAmp6; DataSx6b.(varNames{idxCalDsineBlockAvgAmp})];

%extract data from 3rd experiment
cd 'C:\Users\afanning\Documents\Data\FP\SMCS14\data0123\data01236'
sx6b = dir('smcs14data01236calpresacPostsac.mat');
DataSx6c = load('smcs14data01236calpresacPostsac');
varNames = fieldnames(DataSx6c);

[isTrue, idxCalDavg] = ismember('calDavg', varNames);
[isTrue, idxCalciumAvg] = ismember('calciumAvg', varNames);
[isTrue, idxCalDsinePeak] = ismember('calDsinePeak', varNames);
[isTrue, idxCalDsinePeakIdx] = ismember('calDsinePeakIdx', varNames);
[isTrue, idxCalSinePeak] = ismember('calSinePeak', varNames);
[isTrue, idxCalSinePeakIdx] = ismember('calSinePeakIdx', varNames);
[isTrue, idxCalDsineBlockAvg] = ismember('calDsineBlockAvg', varNames);
[isTrue, idxCalDsineBlockAvgAmp] = ismember('calDsineBlockAvgAmp', varNames);

calDavg6 = [calDavg6; DataSx6c.(varNames{idxCalDavg})];
calciumAvg6 = [calciumAvg6; DataSx6c.(varNames{idxCalciumAvg})];
calDsinePeak6 = [calDsinePeak6; DataSx6c.(varNames{idxCalDsinePeak})];
calDsinePeakIdx6 = [calDsinePeakIdx6; DataSx6c.(varNames{idxCalDsinePeakIdx})];
calSinePeak6 = [calSinePeak6; DataSx6c.(varNames{idxCalSinePeak})];
calSinePeakIdx6 = [calSinePeakIdx6; DataSx6c.(varNames{idxCalSinePeakIdx})];
calDsineBlockAvg6 = [calDsineBlockAvg6; DataSx6c.(varNames{idxCalDsineBlockAvg})];
calDsineBlockAvgAmp6 = [calDsineBlockAvgAmp6; DataSx6c.(varNames{idxCalDsineBlockAvgAmp})];

%cycle averaged vestibular-dark calcium trace
calDavgReshape6 = reshape(calDavg6,1000,3);
calDavgReshape6 = nanmean(calDavgReshape6(:,1:2),2);
calciumAvgReshape6 = reshape(calciumAvg6,1000,3);

%average across experiments
calDsinePeak6 = mean(calDsinePeak6(1:2));
calDsinePeak6 = 2*calDsinePeak6;
calSinePeak6 = 2*calSinePeak6;

calDsineBlockAvg6 = [calDsineBlockAvg6{1:end}];
calDconcatBlockAvg6 = cell(1,1);
calDconcatBlockAvg6{1} = max(nanmean(calDsineBlockAvg6(:,1:2),2));
calDconcatBlockAvg6{2} = max(nanmean(calDsineBlockAvg6(:,3:4),2));
calDconcatBlockAvg6{3} = max(nanmean(calDsineBlockAvg6(:,5:6),2));
calDconcatBlockAvg6{4} = max(nanmean(calDsineBlockAvg6(:,7:8),2));
calDconcatBlockAvg6{5} = max(nanmean(calDsineBlockAvg6(:,9:10),2));
calDconcatBlockAvg6{6} = max(nanmean(calDsineBlockAvg6(:,11:12),2));
calDconcatBlockAvg6{7} = max(nanmean(calDsineBlockAvg6(:,13:14),2));
calDconcatBlockAvg6{8} = max(nanmean(calDsineBlockAvg6(:,15:16),2));
calDconcatBlockAvg6{9} = max(nanmean(calDsineBlockAvg6(:,17:18),2));
calDconcatBlockAvg6{10} = max(nanmean(calDsineBlockAvg6(:,19:20),2));
calDconcatBlockAvg6{11} = max(nanmean(calDsineBlockAvg6(:,21:22),2));
calDconcatBlockAvg6{12} = max(nanmean(calDsineBlockAvg6(:,23:24),2));
calDconcatBlock6 = cat(1,calDconcatBlockAvg6{1:12});

%% Concatenate data across experiments from same subject (#7)
%Extract data from 1st experiment
cd 'C:\Users\afanning\Documents\Data\FP\SMCS15\data0123\data012327'
sx7 = dir('smcs15data012327calpresacPostsac.mat');
DataSx7 = load('smcs15data012327calpresacPostsac');
varNames = fieldnames(DataSx7);

[isTrue, idxCalDavg] = ismember('calDavg', varNames);
[isTrue, idxCalciumAvg] = ismember('calciumAvg', varNames);
[isTrue, idxCalDsinePeak] = ismember('calDsinePeak', varNames);
[isTrue, idxCalDsinePeakIdx] = ismember('calDsinePeakIdx', varNames);
[isTrue, idxCalSinePeak] = ismember('calSinePeak', varNames);
[isTrue, idxCalSinePeakIdx] = ismember('calSinePeakIdx', varNames);
[isTrue, idxCalDsineBlockAvg] = ismember('calDsineBlockAvg', varNames);
[isTrue, idxCalDsineBlockAvgAmp] = ismember('calDsineBlockAvgAmp', varNames);

calDavg7 = [];
calDavg7 = [calDavg7; DataSx7.(varNames{idxCalDavg})];
calciumAvg7 = [];
calciumAvg7 = [calciumAvg7; DataSx7.(varNames{idxCalciumAvg})];
calDsinePeak7 = [];
calDsinePeak7 = [calDsinePeak7; DataSx7.(varNames{idxCalDsinePeak})];
calDsinePeakIdx7 = [];
calDsinePeakIdx7 = [calDsinePeakIdx7; DataSx7.(varNames{idxCalDsinePeakIdx})];
calSinePeak7 = [];
calSinePeak7 = [calSinePeak7; DataSx7.(varNames{idxCalSinePeak})];
calSinePeakIdx7 = [];
calSinePeakIdx7 = [calSinePeakIdx7; DataSx7.(varNames{idxCalSinePeakIdx})];
calDsineBlockAvg7 = [];
calDsineBlockAvg7 = [calDsineBlockAvg7; DataSx7.(varNames{idxCalDsineBlockAvg})];
calDsineBlockAvgAmp7 = [];
calDsineBlockAvgAmp7 = [calDsineBlockAvgAmp7; DataSx7.(varNames{idxCalDsineBlockAvgAmp})];

%extract data from 2nd experiment
cd 'C:\Users\afanning\Documents\Data\FP\SMCS15\data0123\data012328'
sx7b = dir('smcs15data012328calpresacPostsac.mat');
DataSx7b = load('smcs15data012328calpresacPostsac');
varNames = fieldnames(DataSx7b);

[isTrue, idxCalDavg] = ismember('calDavg', varNames);
[isTrue, idxCalciumAvg] = ismember('calciumAvg', varNames);
[isTrue, idxCalDsinePeak] = ismember('calDsinePeak', varNames);
[isTrue, idxCalDsinePeakIdx] = ismember('calDsinePeakIdx', varNames);
[isTrue, idxCalSinePeak] = ismember('calSinePeak', varNames);
[isTrue, idxCalSinePeakIdx] = ismember('calSinePeakIdx', varNames);
[isTrue, idxCalDsineBlockAvg] = ismember('calDsineBlockAvg', varNames);
[isTrue, idxCalDsineBlockAvgAmp] = ismember('calDsineBlockAvgAmp', varNames);

calDavg7 = [calDavg7; DataSx7b.(varNames{idxCalDavg})];
calciumAvg7 = [calciumAvg7; DataSx7b.(varNames{idxCalciumAvg})];
calDsinePeak7 = [calDsinePeak7; DataSx7b.(varNames{idxCalDsinePeak})];
calDsinePeakIdx7 = [calDsinePeakIdx7; DataSx7b.(varNames{idxCalDsinePeakIdx})];
calSinePeak7 = [calSinePeak7; DataSx7b.(varNames{idxCalSinePeak})];
calSinePeakIdx7 = [calSinePeakIdx7; DataSx7b.(varNames{idxCalSinePeakIdx})];
calDsineBlockAvg7 = [calDsineBlockAvg7; DataSx7b.(varNames{idxCalDsineBlockAvg})];
calDsineBlockAvgAmp7 = [calDsineBlockAvgAmp7; DataSx7b.(varNames{idxCalDsineBlockAvgAmp})];

%extract data from 3rd experiment
cd 'C:\Users\afanning\Documents\Data\FP\SMCS15\data0123\data012334'
sx7b = dir('smcs15data012334calpresacPostsac.mat');
DataSx7c = load('smcs15data012334calpresacPostsac');
varNames = fieldnames(DataSx7c);

[isTrue, idxCalDavg] = ismember('calDavg', varNames);
[isTrue, idxCalciumAvg] = ismember('calciumAvg', varNames);
[isTrue, idxCalDsinePeak] = ismember('calDsinePeak', varNames);
[isTrue, idxCalDsinePeakIdx] = ismember('calDsinePeakIdx', varNames);
[isTrue, idxCalSinePeak] = ismember('calSinePeak', varNames);
[isTrue, idxCalSinePeakIdx] = ismember('calSinePeakIdx', varNames);
[isTrue, idxCalDsineBlockAvg] = ismember('calDsineBlockAvg', varNames);
[isTrue, idxCalDsineBlockAvgAmp] = ismember('calDsineBlockAvgAmp', varNames);

calDavg7 = [calDavg7; DataSx7c.(varNames{idxCalDavg})];
calciumAvg7 = [calciumAvg7; DataSx7c.(varNames{idxCalciumAvg})];
calDsinePeak7 = [calDsinePeak7; DataSx7c.(varNames{idxCalDsinePeak})];
calDsinePeakIdx7 = [calDsinePeakIdx7; DataSx7c.(varNames{idxCalDsinePeakIdx})];
calSinePeak7 = [calSinePeak7; DataSx7c.(varNames{idxCalSinePeak})];
calSinePeakIdx7 = [calSinePeakIdx7; DataSx7c.(varNames{idxCalSinePeakIdx})];
calDsineBlockAvg7 = [calDsineBlockAvg7; DataSx7c.(varNames{idxCalDsineBlockAvg})];
calDsineBlockAvgAmp7 = [calDsineBlockAvgAmp7; DataSx7c.(varNames{idxCalDsineBlockAvgAmp})];

%cycle averaged vestibular-dark calcium trace
calDavgReshape7 = reshape(calDavg7,1000,3);
calDavgReshape7 = nanmean(calDavgReshape7(:,1:2),2);
calciumAvgReshape7 = reshape(calciumAvg7,1000,3);

%average across experiments
calDsinePeak7 = mean(calDsinePeak7(1:2));
calDsinePeak7 = 2*calDsinePeak7;
calSinePeak7 = 2*calSinePeak7;

calDsineBlockAvg7 = [calDsineBlockAvg7{1:end}];
calDconcatBlockAvg7 = cell(1,1);
calDconcatBlockAvg7{1} = max(nanmean(calDsineBlockAvg7(:,1:2),2));
calDconcatBlockAvg7{2} = max(nanmean(calDsineBlockAvg7(:,3:4),2));
calDconcatBlockAvg7{3} = max(nanmean(calDsineBlockAvg7(:,5:6),2));
calDconcatBlockAvg7{4} = max(nanmean(calDsineBlockAvg7(:,7:8),2));
calDconcatBlockAvg7{5} = max(nanmean(calDsineBlockAvg7(:,9:10),2));
calDconcatBlockAvg7{6} = max(nanmean(calDsineBlockAvg7(:,11:12),2));
calDconcatBlockAvg7{7} = max(nanmean(calDsineBlockAvg7(:,13:14),2));
calDconcatBlockAvg7{8} = max(nanmean(calDsineBlockAvg7(:,15:16),2));
calDconcatBlockAvg7{9} = max(nanmean(calDsineBlockAvg7(:,17:18),2));
calDconcatBlockAvg7{10} = max(nanmean(calDsineBlockAvg7(:,19:20),2));
calDconcatBlockAvg7{11} = max(nanmean(calDsineBlockAvg7(:,21:22),2));
calDconcatBlockAvg7{12} = max(nanmean(calDsineBlockAvg7(:,23:24),2));
calDconcatBlock7 = cat(1,calDconcatBlockAvg7{1:12});

%% Concatenating and analyzing data across the population
calciumAvgX2 = cat(1,calciumAvgReshape1(:,1),calciumAvgReshape2(:,1),calciumAvgReshape3(:,1),calciumAvgReshape4(:,1),calciumAvgReshape5(:,1),calciumAvgReshape6(:,1),calciumAvgReshape7(:,1));
calciumAvgX0 = cat(1,calciumAvgReshape1(:,2),calciumAvgReshape2(:,2),calciumAvgReshape3(:,2),calciumAvgReshape4(:,2),calciumAvgReshape5(:,2),calciumAvgReshape6(:,2),calciumAvgReshape7(:,2));
calciumAvgOKR = cat(1,calciumAvgReshape1(:,3),calciumAvgReshape2(:,3),calciumAvgReshape3(:,3),calciumAvgReshape4(:,3),calciumAvgReshape5(:,3),calciumAvgReshape6(:,3),calciumAvgReshape7(:,3));
calciumAvgX2reshape = reshape(calciumAvgX2,1000,7);
calciumAvgX0reshape = reshape(calciumAvgX0,1000,7);
calciumAvgOKRreshape = reshape(calciumAvgOKR,1000,7);
calciumAvgX2mean = mean(calciumAvgX2reshape,2);
calciumAvgX0mean = mean(calciumAvgX0reshape,2);
calciumAvgOKRmean = mean(calciumAvgOKRreshape,2);
% dFdAllAvgReshape = circshift(calciumAvgX0,500);
calDavg = cat(1,calDavgReshape1,calDavgReshape2,calDavgReshape3,calDavgReshape4,calDavgReshape5,calDavgReshape6,calDavgReshape7);
calDavgReshape = reshape(calDavg,1000,7);
calDmean = mean(calDavgReshape,2);

calDsinePeak = cat(1,calDsinePeak1,calDsinePeak2,calDsinePeak3,calDsinePeak4,calDsinePeak5,calDsinePeak6,calDsinePeak7);
calDsinePeakAvg = mean(calDsinePeak,1);
calDsinePeakSE = std(calDsinePeak(:,1),0,1)./(sqrt(numel(calDsinePeak(:,1))));
calDsinePeakIdx = cat(1,calDsinePeakIdx1,calDsinePeakIdx2,calDsinePeakIdx3,calDsinePeakIdx4,calDsinePeakIdx5,calDsinePeakIdx6,calDsinePeakIdx7);
calDsinePeakIdxReshape = reshape(calDsinePeakIdx,3,7);
calDsinePeakIdxAvg = mean(calDsinePeakIdxReshape(1:2,:),1);
calDsinePeakIdxMean = mean(calDsinePeakIdxAvg);

calSinePeak = cat(1,calSinePeak1,calSinePeak2,calSinePeak3,calSinePeak4,calSinePeak5,calSinePeak6,calSinePeak7);
calSinePeakReshape = reshape(calSinePeak,3,7);
calSinePeakX2avg = mean(calSinePeakReshape(1,:),2);
calSinePeakX0avg = mean(calSinePeakReshape(2,:),2);
calSinePeakOKRavg = mean(calSinePeakReshape(3,:),2);
calSinePeakX2se = std(calSinePeakReshape(1,:),0,2)./(sqrt(numel(calSinePeakReshape(1,:))));
calSinePeakX0se = std(calSinePeakReshape(2,:),0,2)./(sqrt(numel(calSinePeakReshape(2,:))));
calSinePeakOKRse = std(calSinePeakReshape(3,:),0,2)./(sqrt(numel(calSinePeakReshape(3,:))));
calSinePeakIdx = cat(1,calSinePeakIdx1,calSinePeakIdx2,calSinePeakIdx3,calSinePeakIdx4,calSinePeakIdx5,calSinePeakIdx6,calSinePeakIdx7);
calSinePeakIdxReshape = reshape(calSinePeakIdx,3,7);
calSinePeakIdxX2avg = mean(calSinePeakIdx(1,:),1);
calSinePeakIdxX0avg = mean(calSinePeakIdx(2,:),1);
calSinePeakIdxOKRavg = mean(calSinePeakIdx(3,:),1);

calDconcatBlock2block = cat(1,calDconcatBlock1,calDconcatBlock2,calDconcatBlock3,calDconcatBlock4,calDconcatBlock5,calDconcatBlock6,calDconcatBlock7)*2;
calDconcatBlock2block = reshape(calDconcatBlock2block,12,7);

calDmean = mean(calDavgReshape,2);
calDmean = circshift(calDmean,500);
calDavgReshape = circshift(calDavgReshape,500);
figure(); hold on
plot(calDavgReshape)
plot(calDmean)

figure(); hold on
plot(calciumAvgX2reshape)
plot(calciumAvgX2mean)
test = calciumAvgX2reshape;
test(1:1000,3) = smooth(calciumAvgX2reshape(:,3),8);
test(1:1000,4) = smooth(calciumAvgX2reshape(:,4),10);
testAvg = mean(test,2);
figure(); hold on
plot(test)
plot(testAvg)

calciumAvgX0reshape = circshift(calciumAvgX0reshape,500);
calciumAvgX0mean = circshift(calciumAvgX0mean,500);
figure(); hold on
plot(calciumAvgX0reshape)
plot(calciumAvgX0mean)

figure(); hold on
plot(calciumAvgOKRreshape)
plot(calciumAvgOKRmean)
testOKR = calciumAvgOKRreshape;
testOKRavg = mean(testOKR,2);
plot(testOKR); hold on
plot(testOKRavg)

figure(); hold on
plot(calDsinePeak)
plot(calDsinePeakAvg)

figure(); hold on
plot(calDsinePeakIdxAvg)
plot(calDsinePeakIdxMean)

figure(); hold on
plot(calSinePeakReshape(1,:))
plot(calSinePeakX2avg)

figure(); hold on
plot(calSinePeakReshape(2,:))
plot(calSinePeakX0avg)

figure(); hold on
plot(calSinePeakReshape(3,:))
plot(calSinePeakOKRavg)

figure(); hold on
plot(calSinePeakIdxReshape(1,:))
plot(calSinePeakIdxX2avg)

figure(); hold on
plot(calSinePeakIdxReshape(2,:))
plot(calSinePeakIdxX0avg)

for i = 1:7
    if calSinePeakIdxReshape(3,i) < 500
        calSinePeakIdxReshape(3,i) = calSinePeakIdxReshape(3,i) + 1000;
    end
end
figure(); hold on
plot(calSinePeakIdxReshape(3,:))
plot(calSinePeakIdxOKRavg)

figure(); hold on
plot(calDconcatBlock2block)
