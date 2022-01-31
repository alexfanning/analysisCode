%% Concatenate data across experiments
numSxs = 6;
t = 1;
tLength = 2000;
delay = 0;

%extract data from 1st experiment
cd 'C:\Users\afanning\Documents\Data\GPdata\unexpectedShakhawat'
sx1 = dir('L7cre5fcre50804.mat');
dataSx1 = load('L7cre5fcre50804');
varNames = fieldnames(dataSx1);

[~, idxEyeVelBlock2mat] = ismember('eyeVelBlock2mat', varNames);
[~, idxEyeVelBlockAvg] = ismember('eyeVelBlockAvg', varNames);
[~, idxEyeVelFirstAvg] = ismember('eyeVelFirstAvg', varNames);
[~, idxEyeVelLastAvg] = ismember('eyeVelLastAvg', varNames);
[~, idxRelEyeBlock2mat] = ismember('relEyeBlock2mat', varNames);
[~, idxRelEyeBlockAvg] = ismember('relEyeBlockAvg', varNames);
[~, idxRelEyeFirstAvg] = ismember('relEyeFirstAvg', varNames);
[~, idxRelEyeLastAvg] = ismember('relEyeLastAvg', varNames);
[~, idxPrePostEyeVelBlock2mat] = ismember('prePostEyeVelBlock2mat', varNames);
[~, idxPrePostEyeVelBlockAvg] = ismember('prePostEyeVelBlockAvg', varNames);
[~, idxPreEyeVelAvg] = ismember('preEyeVelAvg', varNames);
[~, idxPostEyeVelAvg] = ismember('postEyeVelAvg', varNames);
[~, idxDrumVelBlock2mat] = ismember('drumVelBlock2mat', varNames);
[~, idxDrumVelBlockAvg] = ismember('drumVelBlockAvg', varNames);
[~, idxDrumVelAvg] = ismember('drumVelAvg', varNames);
[~, idxDrumVelFirstAvg] = ismember('drumVelFirstAvg', varNames);
[~, idxDrumVelLastAvg] = ismember('drumVelLastAvg', varNames);
[~, idxTurntableVdark] = ismember('turntableVdark', varNames);
[~, idxTurntableBlockAvg] = ismember('turntableBlockAvg', varNames);
[~, idxTurntableAvg] = ismember('turntableAvg', varNames);
[~, idxTurntablePreAvg] = ismember('turntablePreAvg', varNames);
[~, idxTurntablePostAvg] = ismember('turntablePostAvg', varNames);
[~, idxGapVelBlock2mat] = ismember('gapVelBlock2mat', varNames);
[~, idxGapVelBlockAvg] = ismember('gapVelBlockAvg', varNames);
[~, idxGapVelAvg] = ismember('gapVelAvg', varNames);

eyeVelBlockAvg = cell(numSxs,1);
eyeVelBlock2mat = cell(numSxs,1);
eyeVelFirstAvg = cell(numSxs,1);
eyeVelLastAvg = cell(numSxs,1);
relEyeBlock2mat = cell(numSxs,1);
relEyeBlockAvg = cell(numSxs,1);
relEyeFirstAvg = cell(numSxs,1);
relEyeLastAvg = cell(numSxs,1);
prePostEyeVelBlock2mat = cell(numSxs,1);
prePostEyeVelBlockAvg = cell(numSxs,1);
preEyeVelAvg = cell(numSxs,1);
postEyeVelAvg = cell(numSxs,1);
drumVelBlock2mat = cell(numSxs,1);
drumVelBlockAvg = cell(numSxs,1);
drumVelAvg = cell(numSxs,1);
drumVelFirstAvg = cell(numSxs,1);
drumVelLastAvg = cell(numSxs,1);
turntableVdark = cell(numSxs,1);
turntableBlockAvg = cell(numSxs,1);
turntableAvg = cell(numSxs,1);
turntablePreAvg = cell(numSxs,1);
turntablePostAvg = cell(numSxs,1);
gapVelBlock2mat = cell(numSxs,1);
gapVelBlockAvg = cell(numSxs,1);
gapVelAvg = cell(numSxs,1);

eyeVelBlockAvg{t} = dataSx1.(varNames{idxEyeVelBlockAvg});
eyeVelBlock2mat{t} = dataSx1.(varNames{idxEyeVelBlock2mat});
eyeVelFirstAvg{t} = dataSx1.(varNames{idxEyeVelFirstAvg});
eyeVelLastAvg{t} = dataSx1.(varNames{idxEyeVelLastAvg});
relEyeBlock2mat{t} = dataSx1.(varNames{idxRelEyeBlock2mat});
relEyeBlockAvg{t} = dataSx1.(varNames{idxRelEyeBlockAvg});
relEyeFirstAvg{t} = dataSx1.(varNames{idxRelEyeFirstAvg});
relEyeLastAvg{t} = dataSx1.(varNames{idxRelEyeLastAvg});
prePostEyeVelBlock2mat{t} = dataSx1.(varNames{idxPrePostEyeVelBlock2mat});
prePostEyeVelBlockAvg{t} = dataSx1.(varNames{idxPrePostEyeVelBlockAvg});
preEyeVelAvg{t} = dataSx1.(varNames{idxPreEyeVelAvg});
postEyeVelAvg{t} = dataSx1.(varNames{idxPostEyeVelAvg});
drumVelBlock2mat{t} = dataSx1.(varNames{idxDrumVelBlock2mat});
drumVelBlockAvg{t} = dataSx1.(varNames{idxDrumVelBlockAvg});
drumVelAvg{t} = dataSx1.(varNames{idxDrumVelAvg});
drumVelFirstAvg{t} = dataSx1.(varNames{idxDrumVelFirstAvg});
drumVelLastAvg{t} = dataSx1.(varNames{idxDrumVelLastAvg});
turntableVdark{t} = dataSx1.(varNames{idxTurntableVdark});
turntableBlockAvg{t} = dataSx1.(varNames{idxTurntableBlockAvg});
turntableAvg{t} = dataSx1.(varNames{idxTurntableAvg});
turntablePreAvg{t} = dataSx1.(varNames{idxTurntablePreAvg});
turntablePostAvg{t} = dataSx1.(varNames{idxTurntablePostAvg});
gapVelBlock2mat{t} = dataSx1.(varNames{idxGapVelBlock2mat});
gapVelBlockAvg{t} = dataSx1.(varNames{idxGapVelBlockAvg});
gapVelAvg{t} = dataSx1.(varNames{idxGapVelAvg});

%% Extract data from 2nd experiment
cd 'C:\Users\afanning\Documents\Data\GPdata\unexpectedShakhawat'
sx2 = dir('L7cre5fcre50811.mat');
dataSx2 = load('L7cre5fcre50811');
varNames = fieldnames(dataSx2);
t = t + 1;

[~, idxEyeVelBlock2mat] = ismember('eyeVelBlock2mat', varNames);
[~, idxEyeVelBlockAvg] = ismember('eyeVelBlockAvg', varNames);
[~, idxEyeVelFirstAvg] = ismember('eyeVelFirstAvg', varNames);
[~, idxEyeVelLastAvg] = ismember('eyeVelLastAvg', varNames);
[~, idxRelEyeBlock2mat] = ismember('relEyeBlock2mat', varNames);
[~, idxRelEyeBlockAvg] = ismember('relEyeBlockAvg', varNames);
[~, idxRelEyeFirstAvg] = ismember('relEyeFirstAvg', varNames);
[~, idxRelEyeLastAvg] = ismember('relEyeLastAvg', varNames);
[~, idxPrePostEyeVelBlock2mat] = ismember('prePostEyeVelBlock2mat', varNames);
[~, idxPrePostEyeVelBlockAvg] = ismember('prePostEyeVelBlockAvg', varNames);
[~, idxPreEyeVelAvg] = ismember('preEyeVelAvg', varNames);
[~, idxPostEyeVelAvg] = ismember('postEyeVelAvg', varNames);
[~, idxDrumVelBlock2mat] = ismember('drumVelBlock2mat', varNames);
[~, idxDrumVelBlockAvg] = ismember('drumVelBlockAvg', varNames);
[~, idxDrumVelAvg] = ismember('drumVelAvg', varNames);
[~, idxDrumVelFirstAvg] = ismember('drumVelFirstAvg', varNames);
[~, idxDrumVelLastAvg] = ismember('drumVelLastAvg', varNames);
[~, idxTurntableVdark] = ismember('turntableVdark', varNames);
[~, idxTurntableBlockAvg] = ismember('turntableBlockAvg', varNames);
[~, idxTurntableAvg] = ismember('turntableAvg', varNames);
[~, idxTurntablePreAvg] = ismember('turntablePreAvg', varNames);
[~, idxTurntablePostAvg] = ismember('turntablePostAvg', varNames);
[~, idxGapVelBlock2mat] = ismember('gapVelBlock2mat', varNames);
[~, idxGapVelBlockAvg] = ismember('gapVelBlockAvg', varNames);
[~, idxGapVelAvg] = ismember('gapVelAvg', varNames);

eyeVelBlockAvg{t} = dataSx2.(varNames{idxEyeVelBlockAvg});
eyeVelBlock2mat{t} = dataSx2.(varNames{idxEyeVelBlock2mat});
eyeVelFirstAvg{t} = dataSx2.(varNames{idxEyeVelFirstAvg});
eyeVelLastAvg{t} = dataSx2.(varNames{idxEyeVelLastAvg});
relEyeBlock2mat{t} = dataSx2.(varNames{idxRelEyeBlock2mat});
relEyeBlockAvg{t} = dataSx2.(varNames{idxRelEyeBlockAvg});
relEyeFirstAvg{t} = dataSx2.(varNames{idxRelEyeFirstAvg});
relEyeLastAvg{t} = dataSx2.(varNames{idxRelEyeLastAvg});
prePostEyeVelBlock2mat{t} = dataSx2.(varNames{idxPrePostEyeVelBlock2mat});
prePostEyeVelBlockAvg{t} = dataSx2.(varNames{idxPrePostEyeVelBlockAvg});
preEyeVelAvg{t} = dataSx2.(varNames{idxPreEyeVelAvg});
postEyeVelAvg{t} = dataSx2.(varNames{idxPostEyeVelAvg});
drumVelBlock2mat{t} = dataSx2.(varNames{idxDrumVelBlock2mat});
drumVelBlockAvg{t} = dataSx2.(varNames{idxDrumVelBlockAvg});
drumVelAvg{t} = dataSx2.(varNames{idxDrumVelAvg});
drumVelFirstAvg{t} = dataSx2.(varNames{idxDrumVelFirstAvg});
drumVelLastAvg{t} = dataSx2.(varNames{idxDrumVelLastAvg});
turntableVdark{t} = dataSx2.(varNames{idxTurntableVdark});
turntableBlockAvg{t} = dataSx2.(varNames{idxTurntableBlockAvg});
turntableAvg{t} = dataSx2.(varNames{idxTurntableAvg});
turntablePreAvg{t} = dataSx2.(varNames{idxTurntablePreAvg});
turntablePostAvg{t} = dataSx2.(varNames{idxTurntablePostAvg});
gapVelBlock2mat{t} = dataSx2.(varNames{idxGapVelBlock2mat});
gapVelBlockAvg{t} = dataSx2.(varNames{idxGapVelBlockAvg});
gapVelAvg{t} = dataSx2.(varNames{idxGapVelAvg});

%% Extract data from 2nd experiment
cd 'C:\Users\afanning\Documents\Data\GPdata\unexpectedShakhawat'
sx3 = dir('smcs40data0811.mat');
dataSx3 = load('smcs40data0811');
varNames = fieldnames(dataSx3);
t = t + 1;

[~, idxEyeVelBlock2mat] = ismember('eyeVelBlock2mat', varNames);
[~, idxEyeVelBlockAvg] = ismember('eyeVelBlockAvg', varNames);
[~, idxEyeVelFirstAvg] = ismember('eyeVelFirstAvg', varNames);
[~, idxEyeVelLastAvg] = ismember('eyeVelLastAvg', varNames);
[~, idxRelEyeBlock2mat] = ismember('relEyeBlock2mat', varNames);
[~, idxRelEyeBlockAvg] = ismember('relEyeBlockAvg', varNames);
[~, idxRelEyeFirstAvg] = ismember('relEyeFirstAvg', varNames);
[~, idxRelEyeLastAvg] = ismember('relEyeLastAvg', varNames);
[~, idxPrePostEyeVelBlock2mat] = ismember('prePostEyeVelBlock2mat', varNames);
[~, idxPrePostEyeVelBlockAvg] = ismember('prePostEyeVelBlockAvg', varNames);
[~, idxPreEyeVelAvg] = ismember('preEyeVelAvg', varNames);
[~, idxPostEyeVelAvg] = ismember('postEyeVelAvg', varNames);
[~, idxDrumVelBlock2mat] = ismember('drumVelBlock2mat', varNames);
[~, idxDrumVelBlockAvg] = ismember('drumVelBlockAvg', varNames);
[~, idxDrumVelAvg] = ismember('drumVelAvg', varNames);
[~, idxDrumVelFirstAvg] = ismember('drumVelFirstAvg', varNames);
[~, idxDrumVelLastAvg] = ismember('drumVelLastAvg', varNames);
[~, idxTurntableVdark] = ismember('turntableVdark', varNames);
[~, idxTurntableBlockAvg] = ismember('turntableBlockAvg', varNames);
[~, idxTurntableAvg] = ismember('turntableAvg', varNames);
[~, idxTurntablePreAvg] = ismember('turntablePreAvg', varNames);
[~, idxTurntablePostAvg] = ismember('turntablePostAvg', varNames);
[~, idxGapVelBlock2mat] = ismember('gapVelBlock2mat', varNames);
[~, idxGapVelBlockAvg] = ismember('gapVelBlockAvg', varNames);
[~, idxGapVelAvg] = ismember('gapVelAvg', varNames);

eyeVelBlockAvg{t} = dataSx3.(varNames{idxEyeVelBlockAvg});
eyeVelBlock2mat{t} = dataSx3.(varNames{idxEyeVelBlock2mat});
eyeVelFirstAvg{t} = dataSx3.(varNames{idxEyeVelFirstAvg});
eyeVelLastAvg{t} = dataSx3.(varNames{idxEyeVelLastAvg});
relEyeBlock2mat{t} = dataSx3.(varNames{idxRelEyeBlock2mat});
relEyeBlockAvg{t} = dataSx3.(varNames{idxRelEyeBlockAvg});
relEyeFirstAvg{t} = dataSx3.(varNames{idxRelEyeFirstAvg});
relEyeLastAvg{t} = dataSx3.(varNames{idxRelEyeLastAvg});
prePostEyeVelBlock2mat{t} = dataSx3.(varNames{idxPrePostEyeVelBlock2mat});
prePostEyeVelBlockAvg{t} = dataSx3.(varNames{idxPrePostEyeVelBlockAvg});
preEyeVelAvg{t} = dataSx3.(varNames{idxPreEyeVelAvg});
postEyeVelAvg{t} = dataSx3.(varNames{idxPostEyeVelAvg});
drumVelBlock2mat{t} = dataSx3.(varNames{idxDrumVelBlock2mat});
drumVelBlockAvg{t} = dataSx3.(varNames{idxDrumVelBlockAvg});
drumVelAvg{t} = dataSx3.(varNames{idxDrumVelAvg});
drumVelFirstAvg{t} = dataSx3.(varNames{idxDrumVelFirstAvg});
drumVelLastAvg{t} = dataSx3.(varNames{idxDrumVelLastAvg});
turntableVdark{t} = dataSx3.(varNames{idxTurntableVdark});
turntableBlockAvg{t} = dataSx3.(varNames{idxTurntableBlockAvg});
turntableAvg{t} = dataSx3.(varNames{idxTurntableAvg});
turntablePreAvg{t} = dataSx3.(varNames{idxTurntablePreAvg});
turntablePostAvg{t} = dataSx3.(varNames{idxTurntablePostAvg});
gapVelBlock2mat{t} = dataSx3.(varNames{idxGapVelBlock2mat});
gapVelBlockAvg{t} = dataSx3.(varNames{idxGapVelBlockAvg});
gapVelAvg{t} = dataSx3.(varNames{idxGapVelAvg});

%% Extract data from 2nd experiment
cd 'C:\Users\afanning\Documents\Data\GPdata\unexpectedShakhawat'
sx4 = dir('US1data0811.mat');
dataSx4 = load('US1data0811');
varNames = fieldnames(dataSx4);
t = t + 1;

[~, idxEyeVelBlock2mat] = ismember('eyeVelBlock2mat', varNames);
[~, idxEyeVelBlockAvg] = ismember('eyeVelBlockAvg', varNames);
[~, idxEyeVelFirstAvg] = ismember('eyeVelFirstAvg', varNames);
[~, idxEyeVelLastAvg] = ismember('eyeVelLastAvg', varNames);
[~, idxRelEyeBlock2mat] = ismember('relEyeBlock2mat', varNames);
[~, idxRelEyeBlockAvg] = ismember('relEyeBlockAvg', varNames);
[~, idxRelEyeFirstAvg] = ismember('relEyeFirstAvg', varNames);
[~, idxRelEyeLastAvg] = ismember('relEyeLastAvg', varNames);
[~, idxPrePostEyeVelBlock2mat] = ismember('prePostEyeVelBlock2mat', varNames);
[~, idxPrePostEyeVelBlockAvg] = ismember('prePostEyeVelBlockAvg', varNames);
[~, idxPreEyeVelAvg] = ismember('preEyeVelAvg', varNames);
[~, idxPostEyeVelAvg] = ismember('postEyeVelAvg', varNames);
[~, idxDrumVelBlock2mat] = ismember('drumVelBlock2mat', varNames);
[~, idxDrumVelBlockAvg] = ismember('drumVelBlockAvg', varNames);
[~, idxDrumVelAvg] = ismember('drumVelAvg', varNames);
[~, idxDrumVelFirstAvg] = ismember('drumVelFirstAvg', varNames);
[~, idxDrumVelLastAvg] = ismember('drumVelLastAvg', varNames);
[~, idxTurntableVdark] = ismember('turntableVdark', varNames);
[~, idxTurntableBlockAvg] = ismember('turntableBlockAvg', varNames);
[~, idxTurntableAvg] = ismember('turntableAvg', varNames);
[~, idxTurntablePreAvg] = ismember('turntablePreAvg', varNames);
[~, idxTurntablePostAvg] = ismember('turntablePostAvg', varNames);
[~, idxGapVelBlock2mat] = ismember('gapVelBlock2mat', varNames);
[~, idxGapVelBlockAvg] = ismember('gapVelBlockAvg', varNames);
[~, idxGapVelAvg] = ismember('gapVelAvg', varNames);

eyeVelBlockAvg{t} = dataSx4.(varNames{idxEyeVelBlockAvg});
eyeVelBlock2mat{t} = dataSx4.(varNames{idxEyeVelBlock2mat});
eyeVelFirstAvg{t} = dataSx4.(varNames{idxEyeVelFirstAvg});
eyeVelLastAvg{t} = dataSx4.(varNames{idxEyeVelLastAvg});
relEyeBlock2mat{t} = dataSx4.(varNames{idxRelEyeBlock2mat});
relEyeBlockAvg{t} = dataSx4.(varNames{idxRelEyeBlockAvg});
relEyeFirstAvg{t} = dataSx4.(varNames{idxRelEyeFirstAvg});
relEyeLastAvg{t} = dataSx4.(varNames{idxRelEyeLastAvg});
prePostEyeVelBlock2mat{t} = dataSx4.(varNames{idxPrePostEyeVelBlock2mat});
prePostEyeVelBlockAvg{t} = dataSx4.(varNames{idxPrePostEyeVelBlockAvg});
preEyeVelAvg{t} = dataSx4.(varNames{idxPreEyeVelAvg});
postEyeVelAvg{t} = dataSx4.(varNames{idxPostEyeVelAvg});
drumVelBlock2mat{t} = dataSx4.(varNames{idxDrumVelBlock2mat});
drumVelBlockAvg{t} = dataSx4.(varNames{idxDrumVelBlockAvg});
drumVelAvg{t} = dataSx4.(varNames{idxDrumVelAvg});
drumVelFirstAvg{t} = dataSx4.(varNames{idxDrumVelFirstAvg});
drumVelLastAvg{t} = dataSx4.(varNames{idxDrumVelLastAvg});
turntableVdark{t} = dataSx4.(varNames{idxTurntableVdark});
turntableBlockAvg{t} = dataSx4.(varNames{idxTurntableBlockAvg});
turntableAvg{t} = dataSx4.(varNames{idxTurntableAvg});
turntablePreAvg{t} = dataSx4.(varNames{idxTurntablePreAvg});
turntablePostAvg{t} = dataSx4.(varNames{idxTurntablePostAvg});
gapVelBlock2mat{t} = dataSx4.(varNames{idxGapVelBlock2mat});
gapVelBlockAvg{t} = dataSx4.(varNames{idxGapVelBlockAvg});
gapVelAvg{t} = dataSx4.(varNames{idxGapVelAvg});

%% Extract data from 2nd experiment
cd 'C:\Users\afanning\Documents\Data\GPdata\unexpectedShakhawat'
Sx5 = dir('US2data0804.mat');
dataSx5 = load('US2data0804');
varNames = fieldnames(dataSx5);
t = t + 1;

[~, idxEyeVelBlock2mat] = ismember('eyeVelBlock2mat', varNames);
[~, idxEyeVelBlockAvg] = ismember('eyeVelBlockAvg', varNames);
[~, idxEyeVelFirstAvg] = ismember('eyeVelFirstAvg', varNames);
[~, idxEyeVelLastAvg] = ismember('eyeVelLastAvg', varNames);
[~, idxRelEyeBlock2mat] = ismember('relEyeBlock2mat', varNames);
[~, idxRelEyeBlockAvg] = ismember('relEyeBlockAvg', varNames);
[~, idxRelEyeFirstAvg] = ismember('relEyeFirstAvg', varNames);
[~, idxRelEyeLastAvg] = ismember('relEyeLastAvg', varNames);
[~, idxPrePostEyeVelBlock2mat] = ismember('prePostEyeVelBlock2mat', varNames);
[~, idxPrePostEyeVelBlockAvg] = ismember('prePostEyeVelBlockAvg', varNames);
[~, idxPreEyeVelAvg] = ismember('preEyeVelAvg', varNames);
[~, idxPostEyeVelAvg] = ismember('postEyeVelAvg', varNames);
[~, idxDrumVelBlock2mat] = ismember('drumVelBlock2mat', varNames);
[~, idxDrumVelBlockAvg] = ismember('drumVelBlockAvg', varNames);
[~, idxDrumVelAvg] = ismember('drumVelAvg', varNames);
[~, idxDrumVelFirstAvg] = ismember('drumVelFirstAvg', varNames);
[~, idxDrumVelLastAvg] = ismember('drumVelLastAvg', varNames);
[~, idxTurntableVdark] = ismember('turntableVdark', varNames);
[~, idxTurntableBlockAvg] = ismember('turntableBlockAvg', varNames);
[~, idxTurntableAvg] = ismember('turntableAvg', varNames);
[~, idxTurntablePreAvg] = ismember('turntablePreAvg', varNames);
[~, idxTurntablePostAvg] = ismember('turntablePostAvg', varNames);
[~, idxGapVelBlock2mat] = ismember('gapVelBlock2mat', varNames);
[~, idxGapVelBlockAvg] = ismember('gapVelBlockAvg', varNames);
[~, idxGapVelAvg] = ismember('gapVelAvg', varNames);

eyeVelBlockAvg{t} = dataSx5.(varNames{idxEyeVelBlockAvg});
eyeVelBlock2mat{t} = dataSx5.(varNames{idxEyeVelBlock2mat});
eyeVelFirstAvg{t} = dataSx5.(varNames{idxEyeVelFirstAvg});
eyeVelLastAvg{t} = dataSx5.(varNames{idxEyeVelLastAvg});
relEyeBlock2mat{t} = dataSx5.(varNames{idxRelEyeBlock2mat});
relEyeBlockAvg{t} = dataSx5.(varNames{idxRelEyeBlockAvg});
relEyeFirstAvg{t} = dataSx5.(varNames{idxRelEyeFirstAvg});
relEyeLastAvg{t} = dataSx5.(varNames{idxRelEyeLastAvg});
prePostEyeVelBlock2mat{t} = dataSx5.(varNames{idxPrePostEyeVelBlock2mat});
prePostEyeVelBlockAvg{t} = dataSx5.(varNames{idxPrePostEyeVelBlockAvg});
preEyeVelAvg{t} = dataSx5.(varNames{idxPreEyeVelAvg});
postEyeVelAvg{t} = dataSx5.(varNames{idxPostEyeVelAvg});
drumVelBlock2mat{t} = dataSx5.(varNames{idxDrumVelBlock2mat});
drumVelBlockAvg{t} = dataSx5.(varNames{idxDrumVelBlockAvg});
drumVelAvg{t} = dataSx5.(varNames{idxDrumVelAvg});
drumVelFirstAvg{t} = dataSx5.(varNames{idxDrumVelFirstAvg});
drumVelLastAvg{t} = dataSx5.(varNames{idxDrumVelLastAvg});
turntableVdark{t} = dataSx5.(varNames{idxTurntableVdark});
turntableBlockAvg{t} = dataSx5.(varNames{idxTurntableBlockAvg});
turntableAvg{t} = dataSx5.(varNames{idxTurntableAvg});
turntablePreAvg{t} = dataSx5.(varNames{idxTurntablePreAvg});
turntablePostAvg{t} = dataSx5.(varNames{idxTurntablePostAvg});
gapVelBlock2mat{t} = dataSx5.(varNames{idxGapVelBlock2mat});
gapVelBlockAvg{t} = dataSx5.(varNames{idxGapVelBlockAvg});
gapVelAvg{t} = dataSx5.(varNames{idxGapVelAvg});

%% Extract data from 2nd experiment
cd 'C:\Users\afanning\Documents\Data\GPdata\unexpectedShakhawat'
sx6 = dir('US2data0811.mat');
dataSx6 = load('US2data0811');
varNames = fieldnames(dataSx6);
t = t + 1;

[~, idxEyeVelBlock2mat] = ismember('eyeVelBlock2mat', varNames);
[~, idxEyeVelBlockAvg] = ismember('eyeVelBlockAvg', varNames);
[~, idxEyeVelFirstAvg] = ismember('eyeVelFirstAvg', varNames);
[~, idxEyeVelLastAvg] = ismember('eyeVelLastAvg', varNames);
[~, idxRelEyeBlock2mat] = ismember('relEyeBlock2mat', varNames);
[~, idxRelEyeBlockAvg] = ismember('relEyeBlockAvg', varNames);
[~, idxRelEyeFirstAvg] = ismember('relEyeFirstAvg', varNames);
[~, idxRelEyeLastAvg] = ismember('relEyeLastAvg', varNames);
[~, idxPrePostEyeVelBlock2mat] = ismember('prePostEyeVelBlock2mat', varNames);
[~, idxPrePostEyeVelBlockAvg] = ismember('prePostEyeVelBlockAvg', varNames);
[~, idxPreEyeVelAvg] = ismember('preEyeVelAvg', varNames);
[~, idxPostEyeVelAvg] = ismember('postEyeVelAvg', varNames);
[~, idxDrumVelBlock2mat] = ismember('drumVelBlock2mat', varNames);
[~, idxDrumVelBlockAvg] = ismember('drumVelBlockAvg', varNames);
[~, idxDrumVelAvg] = ismember('drumVelAvg', varNames);
[~, idxDrumVelFirstAvg] = ismember('drumVelFirstAvg', varNames);
[~, idxDrumVelLastAvg] = ismember('drumVelLastAvg', varNames);
[~, idxTurntableVdark] = ismember('turntableVdark', varNames);
[~, idxTurntableBlockAvg] = ismember('turntableBlockAvg', varNames);
[~, idxTurntableAvg] = ismember('turntableAvg', varNames);
[~, idxTurntablePreAvg] = ismember('turntablePreAvg', varNames);
[~, idxTurntablePostAvg] = ismember('turntablePostAvg', varNames);
[~, idxGapVelBlock2mat] = ismember('gapVelBlock2mat', varNames);
[~, idxGapVelBlockAvg] = ismember('gapVelBlockAvg', varNames);
[~, idxGapVelAvg] = ismember('gapVelAvg', varNames);

eyeVelBlockAvg{t} = dataSx6.(varNames{idxEyeVelBlockAvg});
eyeVelBlock2mat{t} = dataSx6.(varNames{idxEyeVelBlock2mat});
eyeVelFirstAvg{t} = dataSx6.(varNames{idxEyeVelFirstAvg});
eyeVelLastAvg{t} = dataSx6.(varNames{idxEyeVelLastAvg});
relEyeBlock2mat{t} = dataSx6.(varNames{idxRelEyeBlock2mat});
relEyeBlockAvg{t} = dataSx6.(varNames{idxRelEyeBlockAvg});
relEyeFirstAvg{t} = dataSx6.(varNames{idxRelEyeFirstAvg});
relEyeLastAvg{t} = dataSx6.(varNames{idxRelEyeLastAvg});
prePostEyeVelBlock2mat{t} = dataSx6.(varNames{idxPrePostEyeVelBlock2mat});
prePostEyeVelBlockAvg{t} = dataSx6.(varNames{idxPrePostEyeVelBlockAvg});
preEyeVelAvg{t} = dataSx6.(varNames{idxPreEyeVelAvg});
postEyeVelAvg{t} = dataSx6.(varNames{idxPostEyeVelAvg});
drumVelBlock2mat{t} = dataSx6.(varNames{idxDrumVelBlock2mat});
drumVelBlockAvg{t} = dataSx6.(varNames{idxDrumVelBlockAvg});
drumVelAvg{t} = dataSx6.(varNames{idxDrumVelAvg});
drumVelFirstAvg{t} = dataSx6.(varNames{idxDrumVelFirstAvg});
drumVelLastAvg{t} = dataSx6.(varNames{idxDrumVelLastAvg});
turntableVdark{t} = dataSx6.(varNames{idxTurntableVdark});
turntableBlockAvg{t} = dataSx6.(varNames{idxTurntableBlockAvg});
turntableAvg{t} = dataSx6.(varNames{idxTurntableAvg});
turntablePreAvg{t} = dataSx6.(varNames{idxTurntablePreAvg});
turntablePostAvg{t} = dataSx6.(varNames{idxTurntablePostAvg});
gapVelBlock2mat{t} = dataSx6.(varNames{idxGapVelBlock2mat});
gapVelBlockAvg{t} = dataSx6.(varNames{idxGapVelBlockAvg});
gapVelAvg{t} = dataSx6.(varNames{idxGapVelAvg});

%% 
drumVelBegin = cat(2,drumVelFirstAvg{1:numSxs});
drumVelBeginAvg = mean(drumVelBegin,2);
drumVelEnd = cat(2,drumVelLastAvg{1:numSxs});
drumVelEndAvg = mean(drumVelEnd,2);

eyeVelAvg = cat(2,eyeVelBlockAvg{1:numSxs});
eyeVelBegin = cat(2,eyeVelFirstAvg{1:numSxs});
eyeVelBeginAvg = mean(eyeVelBegin,2);
eyeVelEnd = cat(2,eyeVelLastAvg{1:numSxs});
eyeVelEndAvg = mean(eyeVelEnd,2);

subplot(2,1,1)
hold on
plot(eyeVelBegin)
plot(drumVelBeginAvg)
ylabel('Velocity')
title('Each subjects avg eye vel. during first 2 blocks')
subplot(2,1,2)
hold on
plot(eyeVelEnd)
plot(drumVelEndAvg)
xlabel('Trial time (ms)')
ylabel('Velocity')
title('Each subjects avg eye vel. during last 2 blocks')

figure()
hold on
plot(eyeVelBeginAvg)
plot(eyeVelEndAvg)
plot(drumVelBeginAvg)
plot(drumVelEndAvg)
xlabel('Trial time (ms)')
ylabel('Velocity')
legend('First 2 blocks avg','Last 2 blocks avg','Drum vel.')
title('Population avg eye vel. during first and last 2 blocks')

relEyeVelAvg = cat(2,relEyeBlockAvg{1:numSxs});
relEyeVelBegin = cat(2,relEyeFirstAvg{1:numSxs});
relEyeVelBeginAvg = mean(relEyeVelBegin,2);
relEyeVelEnd = cat(2,relEyeLastAvg{1:numSxs});
relEyeVelEndAvg = mean(relEyeVelEnd,2);

drumRescaleBegin = abs(rescale(drumVelBeginAvg,-1,1));
drumRescaleEnd = abs(rescale(drumVelEndAvg,-1,1));

figure()
subplot(2,1,1)
hold on
plot(relEyeVelBegin)
plot(drumRescaleBegin)
ylabel('Velocity')
title('Each subjects avg rel. eye vel. during first 2 blocks')
ylim([-0.5 1.5])

subplot(2,1,2)
hold on
plot(relEyeVelEnd)
plot(drumRescaleEnd)
xlabel('Trial time (ms)')
ylabel('Velocity')
title('Each subjects avg rel. eye vel. during last 2 blocks')
ylim([-0.5 1.5])

figure()
hold on
plot(relEyeVelBeginAvg)
plot(relEyeVelEndAvg)
plot(drumRescaleBegin)
plot(drumRescaleEnd)
xlabel('Trial time (ms)')
ylabel('Velocity')
legend('First 2 blocks avg','Last 2 blocks avg','Drum vel.')
title('Population avg eye vel. during first and last 2 blocks')
ylim([-0.5 1.5])

turntableVelBegin = cat(2,turntablePreAvg{1:numSxs});
turntableVelBeginAvg = mean(turntableVelBegin,2);
turntableVelEnd = cat(2,turntablePostAvg{1:numSxs});
turntableVelEndAvg = mean(turntableVelEnd,2);

preEye = cat(2,preEyeVelAvg{1:numSxs});
preEyeAvg = mean(preEye,2);
postEye = cat(2,postEyeVelAvg{1:numSxs});
postEyeAvg = mean(postEye,2);

figure()
subplot(2,1,1)
hold on
plot(preEye)
plot(turntableVelBegin)
ylabel('Velocity')
title('Each subjects avg eye vel. during first 2 blocks')

subplot(2,1,2)
hold on
plot(postEye)
plot(turntableVelEnd)
xlabel('Trial time (ms)')
ylabel('Velocity')
title('Each subjects avg eye vel. during last 2 blocks')

figure()
hold on
plot(preEyeAvg)
plot(postEyeAvg)
plot(turntableVelBegin)
plot(turntableVelEnd)
xlabel('Trial time (ms)')
ylabel('Velocity')
legend('First 2 blocks avg','Last 2 blocks avg','Drum vel.')
title('Population avg eye vel. during first and last 2 blocks')

spEyeVel = cat(2,gapVelAvg{1:numSxs});
spEyeVelAvg = mean(spEyeVel,2);

figure(); hold on
plot(spEyeVel)
plot(spEyeVelAvg,'LineWidth',3,'Color','k')

% figure()
% subplot(2,1,1)
% hold on
% plot(relEyeVelBegin(tLength/2+delay+1:end-1,:))
% plot(drumRescaleBegin(tLength/2+delay+1:end-1,:))
% ylabel('Velocity')
% ylim([0 1.25])
% title('Each subjects avg rel.eye vel. during first 2 visual blocks')
% subplot(2,1,2)
% hold on
% plot(relEyeVelEnd(tLength/2+delay+1:end-1,:))
% plot(drumRescaleEnd(tLength/2+delay+1:end-1,:))
% xlabel('Trial time (ms)')
% ylabel('Velocity')
% ylim([0 1.25])
% title('Each subjects avg rel. eye vel. during last 2 visual blocks')
% 
% figure()
% subplot(2,1,1)
% hold on
% plot(relEyeVelBegin(1:tLength/2,:))
% plot(drumRescaleBegin(1:tLength/2,:))
% ylabel('Velocity')
% ylim([0 1.25])
% title('Each subjects avg rel. eye vel. during first 2 dark blocks')
% subplot(2,1,2)
% hold on
% plot(relEyeVelEnd(1:tLength/2,:))
% plot(drumRescaleEnd(1:tLength/2,:))
% xlabel('Trial time (ms)')
% ylabel('Velocity')
% ylim([0 1.25])
% title('Each subjects avg rel. eye vel. during last 2 dark blocks')