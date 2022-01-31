
numSxs = 3;
t = 1;
k = 2;

%% Concatenate data across experiments from same subject (#1)
%extract data from 1st experiment
cd 'E:\FP\data\smcs38\smcs38data0620\smcs38data062019'
sx1 = dir('smcs38data062019v2.mat');
dataSx1 = load('smcs38data062019v2');
varNames = fieldnames(dataSx1);

[~, idxCalVisualBlockAvg] = ismember('calVisualBlockAvg', varNames);
[~, idxEyeVelVisualBlockAvg] = ismember('eyeVelVisualBlockAvg', varNames);
[~, idxRsBlockAvg] = ismember('rsBlockAvg', varNames);
[~, idxDrumVisualBlockAvg] = ismember('drumVisualBlockAvg', varNames);
[~, idxCalVisualBlockAmpAvg] = ismember('calVisualBlockAmpAvg', varNames);
[~, idxCalVisualBlockAmpIdxAvg] = ismember('calVisualBlockAmpIdxAvg', varNames);
[~, idxCalVisualBlockAmpAvgTrough] = ismember('calVisualBlockAmpAvgTrough', varNames);
[~, idxCalVisualBlockAmpIdxAvgTrough] = ismember('calVisualBlockAmpIdxAvgTrough', varNames);
[~, idxEyeVelVisualBlockAmpAvgContra] = ismember('eyeVelVisualBlockAmpAvgContra', varNames);
[~, idxEyeVisualBlockAmpIdxAvgContra] = ismember('eyeVisualBlockAmpIdxAvgContra', varNames);
[~, idxEyeVelVisualBlockAmpAvgIpsi] = ismember('eyeVelVisualBlockAmpAvgIpsi', varNames);
[~, idxEyeVisualBlockAmpIdxAvgIpsi] = ismember('eyeVisualBlockAmpIdxAvgIpsi', varNames);
[~, idxRsBlockAmpAvg] = ismember('rsBlockAmpAvg', varNames);
[~, idxRsBlockAmpIdxAvg] = ismember('rsBlockAmpIdxAvg', varNames);
[~, idxDrumVisualBlockAmpAvgContra] = ismember('drumVisualBlockAmpAvgContra', varNames);
[~, idxDrumVisualBlockAmpIdxAvgContra] = ismember('drumVisualBlockAmpIdxAvgContra', varNames);
[~, idxDrumVisualBlockAmpAvgIpsi] = ismember('drumVisualBlockAmpAvgIpsi', varNames);
[~, idxDrumVisualBlockAmpIdxAvgIpsi] = ismember('drumVisualBlockAmpIdxAvgIpsi', varNames);
[~, idxCalVisualAvg] = ismember('calVisualAvg', varNames);
[~, idxEyeVisualAvg] = ismember('eyeVisualAvg', varNames);
[~, idxRsAvg] = ismember('rsAvg', varNames);
[~, idxDrumVisualAvg] = ismember('drumVisualAvg', varNames);
[~, idxCalVisualAmpAvg] = ismember('calVisualAmpAvg', varNames);
[~, idxCalVisualAmpIdxAvg] = ismember('calVisualAmpIdxAvg', varNames);
[~, idxCalVisualAmpAvgTrough] = ismember('calVisualAmpAvgTrough', varNames);
[~, idxEyeVelVisualAmpAvgContra] = ismember('eyeVelVisualAmpAvgContra', varNames);
[~, idxEyeVisualAmpIdxAvgContra] = ismember('eyeVisualAmpIdxAvgContra', varNames);
[~, idxEyeVelVisualAmpAvgIpsi] = ismember('eyeVelVisualAmpAvgIpsi', varNames);
[~, idxEyeVisualAmpIdxAvgIpsi] = ismember('eyeVisualAmpIdxAvgIpsi', varNames);
[~, idxRsAmpAvg] = ismember('rsAmpAvg', varNames);
[~, idxRsAmpIdxAvg] = ismember('rsAmpIdxAvg', varNames);
[~, idxDrumVisualAmpAvgContra] = ismember('drumVisualAmpAvgContra', varNames);
[~, idxDrumVisualAmpIdxAvgContra] = ismember('drumVisualAmpIdxAvgContra', varNames);
[~, idxDrumVisualAmpAvgIpsi] = ismember('drumVisualAmpAvgIpsi', varNames);
[~, idxDrumVisualAmpIdxAvgIpsi] = ismember('drumVisualAmpIdxAvgIpsi', varNames);
[~, idxCalDelayEye] = ismember('calDelayEye', varNames);
[~, idxCalDelayDrum] = ismember('calDelayDrum', varNames);
[~, idxCalDelayRS] = ismember('calDelayRS', varNames);
[~, idxCalVisualSine05] = ismember('calVisualSine05', varNames);
[~, idxEyeVisualSine05] = ismember('eyeVisualSine05', varNames);
[~, idxRsSine05] = ismember('rsSine05', varNames);
[~, idxCalVisualSine1] = ismember('calVisualSine1', varNames);
[~, idxEyeVisualSine1] = ismember('eyeVisualSine1', varNames);
[~, idxRsSine1] = ismember('rsSine1', varNames);
[~, idxCalVisualSine2] = ismember('calVisualSine2', varNames);
[~, idxEyeVisualSine2] = ismember('eyeVisualSine2', varNames);
[~, idxRsSine2] = ismember('rsSine2', varNames);
[~, idxCalVisualSine4] = ismember('calVisualSine4', varNames);
[~, idxEyeVisualSine4] = ismember('eyeVisualSine4', varNames);
[~, idxRsSine4] = ismember('rsSine4', varNames);
[~, idxCalVisualSineAmpAvg] = ismember('calVisualSineAmpAvg', varNames);
[~, idxCalVisualSineAmpIdxAvg] = ismember('calVisualSineAmpIdxAvg', varNames);
[~, idxCalVisualSineAmpAvgTrough] = ismember('calVisualSineAmpAvgTrough', varNames);
[~, idxCalVisualSineAmpIdxAvgTrough] = ismember('calVisualSineAmpIdxAvgTrough', varNames);
[~, idxEyeVelVisualSineSineAmpAvgContra] = ismember('eyeVelVisualSineSineAmpAvgContra', varNames);
[~, idxEyeVisualSineAmpIdxAvgContra] = ismember('eyeVisualSineAmpIdxAvgContra', varNames);
[~, idxEyeVelVisualSineAmpAvgIpsi] = ismember('eyeVelVisualSineAmpAvgIpsi', varNames);
[~, idxEyeVisualSineAmpIdxAvgIpsi] = ismember('eyeVisualSineAmpIdxAvgIpsi', varNames);
[~, idxRsSineAmpAvg] = ismember('rsSineAmpAvg', varNames);
[~, idxRsSineAmpIdxAvg] = ismember('rsSineAmpIdxAvg', varNames);

calVisualBlockAvg = cell(numSxs,1);
eyeVelVisualBlockAvg = cell(numSxs,1);
rsBlockAvg = cell(numSxs,1);
drumVisualBlockAvg = cell(numSxs,1);
calVisualBlockAmpAvg = cell(numSxs,1);
calVisualBlockAmpIdxAvg = cell(numSxs,1);
calVisualBlockAmpAvgTrough = cell(numSxs,1);
calVisualBlockAmpIdxAvgTrough = cell(numSxs,1);
eyeVelVisualBlockAmpAvgContra = cell(numSxs,1);
eyeVisualBlockAmpIdxAvgContra = cell(numSxs,1);
eyeVelVisualBlockAmpAvgIpsi = cell(numSxs,1);
eyeVisualBlockAmpIdxAvgIpsi = cell(numSxs,1);
rsBlockAmpAvg = cell(numSxs,1);
rsBlockAmpIdxAvg = cell(numSxs,1);
drumVisualBlockAmpAvgContra = cell(numSxs,1);
drumVisualBlockAmpIdxAvgContra = cell(numSxs,1);
drumVisualBlockAmpAvgIpsi = cell(numSxs,1);
drumVisualBlockAmpIdxAvgIpsi = cell(numSxs,1);
calVisualAvg = cell(numSxs,1);
eyeVisualAvg = cell(numSxs,1);
rsAvg = cell(numSxs,1);
drumVisualAvg = cell(numSxs,1);
calVisualAmpAvg = cell(numSxs,1);
calVisualAmpIdxAvg = cell(numSxs,1);
calVisualAmpAvgTrough = cell(numSxs,1);
eyeVelVisualAmpAvgContra = cell(numSxs,1);
eyeVisualAmpIdxAvgContra = cell(numSxs,1);
eyeVelVisualAmpAvgIpsi = cell(numSxs,1);
eyeVisualAmpIdxAvgIpsi = cell(numSxs,1);
rsAmpAvg = cell(numSxs,1);
rsAmpIdxAvg = cell(numSxs,1);
drumVisualAmpAvgContra = cell(numSxs,1);
drumVisualAmpIdxAvgContra = cell(numSxs,1);
drumVisualAmpAvgIpsi = cell(numSxs,1);
drumVisualAmpIdxAvgIpsi = cell(numSxs,1);
calDelayEye = cell(numSxs,1);
calDelayDrum = cell(numSxs,1);
calDelayRS = cell(numSxs,1);
calVisualSine05 = cell(numSxs,1);
eyeVisualSine05 = cell(numSxs,1);
rsSine05 = cell(numSxs,1);
calVisualSine1 = cell(numSxs,1);
eyeVisualSine1 = cell(numSxs,1);
rsSine1 = cell(numSxs,1);
calVisualSine2 = cell(numSxs,1);
eyeVisualSine2 = cell(numSxs,1);
rsSine2 = cell(numSxs,1);
calVisualSine4 = cell(numSxs,1);
eyeVisualSine4 = cell(numSxs,1);
rsSine4 = cell(numSxs,1);
calVisualSineAmpAvg = cell(numSxs,1);
calVisualSineAmpIdxAvg = cell(numSxs,1);
calVisualSineAmpAvgTrough = cell(numSxs,1);
calVisualSineAmpIdxAvgTrough = cell(numSxs,1);
eyeVelVisualSineSineAmpAvgContra = cell(numSxs,1);
eyeVisualSineAmpIdxAvgContra = cell(numSxs,1);
eyeVelVisualSineAmpAvgIpsi = cell(numSxs,1);
eyeVisualSineAmpIdxAvgIpsi = cell(numSxs,1);
rsSineAmpAvg = cell(numSxs,1);
rsSineAmpIdxAvg = cell(numSxs,1);

calVisualBlockAvg{t} = dataSx1.(varNames{idxCalVisualBlockAvg});
eyeVelVisualBlockAvg{t} = dataSx1.(varNames{idxEyeVelVisualBlockAvg});
rsBlockAvg{t} = dataSx1.(varNames{idxRsBlockAvg});
drumVisualBlockAvg{t} = dataSx1.(varNames{idxDrumVisualBlockAvg});
calVisualBlockAmpAvg{t} = dataSx1.(varNames{idxCalVisualBlockAmpAvg});
calVisualBlockAmpIdxAvg{t} = dataSx1.(varNames{idxCalVisualBlockAmpIdxAvg});
calVisualBlockAmpAvgTrough{t} = dataSx1.(varNames{idxCalVisualBlockAmpAvgTrough});
calVisualBlockAmpIdxAvgTrough{t} = dataSx1.(varNames{idxCalVisualBlockAmpIdxAvgTrough});
eyeVelVisualBlockAmpAvgContra{t} = dataSx1.(varNames{idxEyeVelVisualBlockAmpAvgContra});
eyeVisualBlockAmpIdxAvgContra{t} = dataSx1.(varNames{idxEyeVisualBlockAmpIdxAvgContra});
eyeVelVisualBlockAmpAvgIpsi{t} = dataSx1.(varNames{idxEyeVelVisualBlockAmpAvgIpsi});
eyeVisualBlockAmpIdxAvgIpsi{t} = dataSx1.(varNames{idxEyeVisualBlockAmpIdxAvgIpsi});
rsBlockAmpAvg{t} = dataSx1.(varNames{idxRsBlockAmpAvg});
rsBlockAmpIdxAvg{t} = dataSx1.(varNames{idxRsBlockAmpIdxAvg});
drumVisualBlockAmpAvgContra{t} = dataSx1.(varNames{idxDrumVisualBlockAmpAvgContra});
drumVisualBlockAmpIdxAvgContra{t} = dataSx1.(varNames{idxDrumVisualBlockAmpIdxAvgContra});
drumVisualBlockAmpAvgIpsi{t} = dataSx1.(varNames{idxDrumVisualBlockAmpAvgIpsi});
drumVisualBlockAmpIdxAvgIpsi{t} = dataSx1.(varNames{idxDrumVisualBlockAmpIdxAvgIpsi});
calVisualAvg{t} = dataSx1.(varNames{idxCalVisualAvg});
eyeVisualAvg{t} = dataSx1.(varNames{idxEyeVisualAvg});
rsAvg{t} = dataSx1.(varNames{idxRsAvg});
drumVisualAvg{t} = dataSx1.(varNames{idxDrumVisualAvg});
calVisualAmpAvg{t} = dataSx1.(varNames{idxCalVisualAmpAvg});
calVisualAmpIdxAvg{t} = dataSx1.(varNames{idxCalVisualAmpIdxAvg});
calVisualAmpAvgTrough{t} = dataSx1.(varNames{idxCalVisualAmpAvgTrough});
eyeVelVisualAmpAvgContra{t} = dataSx1.(varNames{idxEyeVelVisualAmpAvgContra});
eyeVisualAmpIdxAvgContra{t} = dataSx1.(varNames{idxEyeVisualAmpIdxAvgContra});
eyeVelVisualAmpAvgIpsi{t} = dataSx1.(varNames{idxEyeVelVisualAmpAvgIpsi});
eyeVisualAmpIdxAvgIpsi{t} = dataSx1.(varNames{idxEyeVisualAmpIdxAvgIpsi});
rsAmpAvg{t} = dataSx1.(varNames{idxRsAmpAvg});
rsAmpIdxAvg{t} = dataSx1.(varNames{idxRsAmpIdxAvg});
drumVisualAmpAvgContra{t} = dataSx1.(varNames{idxDrumVisualAmpAvgContra});
drumVisualAmpIdxAvgContra{t} = dataSx1.(varNames{idxDrumVisualAmpIdxAvgContra});
drumVisualAmpAvgIpsi{t} = dataSx1.(varNames{idxDrumVisualAmpAvgIpsi});
drumVisualAmpIdxAvgIpsi{t} = dataSx1.(varNames{idxDrumVisualAmpIdxAvgIpsi});
calDelayEye{t} = dataSx1.(varNames{idxCalDelayEye});
calDelayDrum{t} = dataSx1.(varNames{idxCalDelayDrum});
calDelayRS{t} = dataSx1.(varNames{idxCalDelayRS});
calVisualSine05{t} = dataSx1.(varNames{idxCalVisualSine05});
eyeVisualSine05{t} = dataSx1.(varNames{idxEyeVisualSine05});
rsSine05{t} = dataSx1.(varNames{idxRsSine05});
calVisualSine1{t} = dataSx1.(varNames{idxCalVisualSine1});
eyeVisualSine1{t} = dataSx1.(varNames{idxEyeVisualSine1});
rsSine1{t} = dataSx1.(varNames{idxRsSine1});
calVisualSine2{t} = dataSx1.(varNames{idxCalVisualSine2});
eyeVisualSine2{t} = dataSx1.(varNames{idxEyeVisualSine2});
rsSine2{t} = dataSx1.(varNames{idxRsSine2});
calVisualSine4{t} = dataSx1.(varNames{idxCalVisualSine4});
eyeVisualSine4{t} = dataSx1.(varNames{idxEyeVisualSine4});
rsSine4{t} = dataSx1.(varNames{idxRsSine4});
calVisualSineAmpAvg{t} = dataSx1.(varNames{idxCalVisualSineAmpAvg});
calVisualSineAmpIdxAvg{t} = dataSx1.(varNames{idxCalVisualSineAmpIdxAvg});
calVisualSineAmpAvgTrough{t} = dataSx1.(varNames{idxCalVisualSineAmpAvgTrough});
calVisualSineAmpIdxAvgTrough{t} = dataSx1.(varNames{idxCalVisualSineAmpIdxAvgTrough});
eyeVelVisualSineSineAmpAvgContra{t} = dataSx1.(varNames{idxEyeVelVisualSineSineAmpAvgContra});
eyeVisualSineAmpIdxAvgContra{t} = dataSx1.(varNames{idxEyeVisualSineAmpIdxAvgContra});
eyeVelVisualSineAmpAvgIpsi{t} = dataSx1.(varNames{idxEyeVelVisualSineAmpAvgIpsi});
eyeVisualSineAmpIdxAvgIpsi{t} = dataSx1.(varNames{idxEyeVisualSineAmpIdxAvgIpsi});
rsSineAmpAvg{t} = dataSx1.(varNames{idxRsSineAmpAvg});
rsSineAmpIdxAvg{t} = dataSx1.(varNames{idxRsSineAmpIdxAvg});

%% Concatenate data across experiments from same subject (#1)
%extract data from 1st experiment
cd 'E:\FP\data\l7cre3\l7cre3data0529\l7cre3data05296'
sx2 = dir('l7cre3data05296.mat');
dataSx2 = load('l7cre3data05296');
varNames = fieldnames(dataSx2);
t = t + 1;

[~, idxCalVisualBlockAvg] = ismember('calVisualBlockAvg', varNames);
[~, idxEyeVelVisualBlockAvg] = ismember('eyeVelVisualBlockAvg', varNames);
[~, idxRsBlockAvg] = ismember('rsBlockAvg', varNames);
[~, idxDrumVisualBlockAvg] = ismember('drumVisualBlockAvg', varNames);
[~, idxCalVisualBlockAmpAvg] = ismember('calVisualBlockAmpAvg', varNames);
[~, idxCalVisualBlockAmpIdxAvg] = ismember('calVisualBlockAmpIdxAvg', varNames);
[~, idxCalVisualBlockAmpAvgTrough] = ismember('calVisualBlockAmpAvgTrough', varNames);
[~, idxCalVisualBlockAmpIdxAvgTrough] = ismember('calVisualBlockAmpIdxAvgTrough', varNames);
[~, idxEyeVelVisualBlockAmpAvgContra] = ismember('eyeVelVisualBlockAmpAvgContra', varNames);
[~, idxEyeVisualBlockAmpIdxAvgContra] = ismember('eyeVisualBlockAmpIdxAvgContra', varNames);
[~, idxEyeVelVisualBlockAmpAvgIpsi] = ismember('eyeVelVisualBlockAmpAvgIpsi', varNames);
[~, idxEyeVisualBlockAmpIdxAvgIpsi] = ismember('eyeVisualBlockAmpIdxAvgIpsi', varNames);
[~, idxRsBlockAmpAvg] = ismember('rsBlockAmpAvg', varNames);
[~, idxRsBlockAmpIdxAvg] = ismember('rsBlockAmpIdxAvg', varNames);
[~, idxDrumVisualBlockAmpAvgContra] = ismember('drumVisualBlockAmpAvgContra', varNames);
[~, idxDrumVisualBlockAmpIdxAvgContra] = ismember('drumVisualBlockAmpIdxAvgContra', varNames);
[~, idxDrumVisualBlockAmpAvgIpsi] = ismember('drumVisualBlockAmpAvgIpsi', varNames);
[~, idxDrumVisualBlockAmpIdxAvgIpsi] = ismember('drumVisualBlockAmpIdxAvgIpsi', varNames);
[~, idxCalVisualAvg] = ismember('calVisualAvg', varNames);
[~, idxEyeVisualAvg] = ismember('eyeVisualAvg', varNames);
[~, idxRsAvg] = ismember('rsAvg', varNames);
[~, idxDrumVisualAvg] = ismember('drumVisualAvg', varNames);
[~, idxCalVisualAmpAvg] = ismember('calVisualAmpAvg', varNames);
[~, idxCalVisualAmpIdxAvg] = ismember('calVisualAmpIdxAvg', varNames);
[~, idxCalVisualAmpAvgTrough] = ismember('calVisualAmpAvgTrough', varNames);
[~, idxEyeVelVisualAmpAvgContra] = ismember('eyeVelVisualAmpAvgContra', varNames);
[~, idxEyeVisualAmpIdxAvgContra] = ismember('eyeVisualAmpIdxAvgContra', varNames);
[~, idxEyeVelVisualAmpAvgIpsi] = ismember('eyeVelVisualAmpAvgIpsi', varNames);
[~, idxEyeVisualAmpIdxAvgIpsi] = ismember('eyeVisualAmpIdxAvgIpsi', varNames);
[~, idxRsAmpAvg] = ismember('rsAmpAvg', varNames);
[~, idxRsAmpIdxAvg] = ismember('rsAmpIdxAvg', varNames);
[~, idxDrumVisualAmpAvgContra] = ismember('drumVisualAmpAvgContra', varNames);
[~, idxDrumVisualAmpIdxAvgContra] = ismember('drumVisualAmpIdxAvgContra', varNames);
[~, idxDrumVisualAmpAvgIpsi] = ismember('drumVisualAmpAvgIpsi', varNames);
[~, idxDrumVisualAmpIdxAvgIpsi] = ismember('drumVisualAmpIdxAvgIpsi', varNames);
[~, idxCalDelayEye] = ismember('calDelayEye', varNames);
[~, idxCalDelayDrum] = ismember('calDelayDrum', varNames);
[~, idxCalDelayRS] = ismember('calDelayRS', varNames);
[~, idxCalVisualSine05] = ismember('calVisualSine05', varNames);
[~, idxEyeVisualSine05] = ismember('eyeVisualSine05', varNames);
[~, idxRsSine05] = ismember('rsSine05', varNames);
[~, idxCalVisualSine1] = ismember('calVisualSine1', varNames);
[~, idxEyeVisualSine1] = ismember('eyeVisualSine1', varNames);
[~, idxRsSine1] = ismember('rsSine1', varNames);
[~, idxCalVisualSine2] = ismember('calVisualSine2', varNames);
[~, idxEyeVisualSine2] = ismember('eyeVisualSine2', varNames);
[~, idxRsSine2] = ismember('rsSine2', varNames);
[~, idxCalVisualSine4] = ismember('calVisualSine4', varNames);
[~, idxEyeVisualSine4] = ismember('eyeVisualSine4', varNames);
[~, idxRsSine4] = ismember('rsSine4', varNames);
[~, idxCalVisualSineAmpAvg] = ismember('calVisualSineAmpAvg', varNames);
[~, idxCalVisualSineAmpIdxAvg] = ismember('calVisualSineAmpIdxAvg', varNames);
[~, idxCalVisualSineAmpAvgTrough] = ismember('calVisualSineAmpAvgTrough', varNames);
[~, idxCalVisualSineAmpIdxAvgTrough] = ismember('calVisualSineAmpIdxAvgTrough', varNames);
[~, idxEyeVelVisualSineSineAmpAvgContra] = ismember('eyeVelVisualSineSineAmpAvgContra', varNames);
[~, idxEyeVisualSineAmpIdxAvgContra] = ismember('eyeVisualSineAmpIdxAvgContra', varNames);
[~, idxEyeVelVisualSineAmpAvgIpsi] = ismember('eyeVelVisualSineAmpAvgIpsi', varNames);
[~, idxEyeVisualSineAmpIdxAvgIpsi] = ismember('eyeVisualSineAmpIdxAvgIpsi', varNames);
[~, idxRsSineAmpAvg] = ismember('rsSineAmpAvg', varNames);
[~, idxRsSineAmpIdxAvg] = ismember('rsSineAmpIdxAvg', varNames);

calVisualBlockAvg{t} = dataSx2.(varNames{idxCalVisualBlockAvg});
eyeVelVisualBlockAvg{t} = dataSx2.(varNames{idxEyeVelVisualBlockAvg});
rsBlockAvg{t} = dataSx2.(varNames{idxRsBlockAvg});
drumVisualBlockAvg{t} = dataSx2.(varNames{idxDrumVisualBlockAvg});
calVisualBlockAmpAvg{t} = dataSx2.(varNames{idxCalVisualBlockAmpAvg});
calVisualBlockAmpIdxAvg{t} = dataSx2.(varNames{idxCalVisualBlockAmpIdxAvg});
calVisualBlockAmpAvgTrough{t} = dataSx2.(varNames{idxCalVisualBlockAmpAvgTrough});
calVisualBlockAmpIdxAvgTrough{t} = dataSx2.(varNames{idxCalVisualBlockAmpIdxAvgTrough});
eyeVelVisualBlockAmpAvgContra{t} = dataSx2.(varNames{idxEyeVelVisualBlockAmpAvgContra});
eyeVisualBlockAmpIdxAvgContra{t} = dataSx2.(varNames{idxEyeVisualBlockAmpIdxAvgContra});
eyeVelVisualBlockAmpAvgIpsi{t} = dataSx2.(varNames{idxEyeVelVisualBlockAmpAvgIpsi});
eyeVisualBlockAmpIdxAvgIpsi{t} = dataSx2.(varNames{idxEyeVisualBlockAmpIdxAvgIpsi});
rsBlockAmpAvg{t} = dataSx2.(varNames{idxRsBlockAmpAvg});
rsBlockAmpIdxAvg{t} = dataSx2.(varNames{idxRsBlockAmpIdxAvg});
drumVisualBlockAmpAvgContra{t} = dataSx2.(varNames{idxDrumVisualBlockAmpAvgContra});
drumVisualBlockAmpIdxAvgContra{t} = dataSx2.(varNames{idxDrumVisualBlockAmpIdxAvgContra});
drumVisualBlockAmpAvgIpsi{t} = dataSx2.(varNames{idxDrumVisualBlockAmpAvgIpsi});
drumVisualBlockAmpIdxAvgIpsi{t} = dataSx2.(varNames{idxDrumVisualBlockAmpIdxAvgIpsi});
calVisualAvg{t} = dataSx2.(varNames{idxCalVisualAvg});
eyeVisualAvg{t} = dataSx2.(varNames{idxEyeVisualAvg});
rsAvg{t} = dataSx2.(varNames{idxRsAvg});
drumVisualAvg{t} = dataSx2.(varNames{idxDrumVisualAvg});
calVisualAmpAvg{t} = dataSx2.(varNames{idxCalVisualAmpAvg});
calVisualAmpIdxAvg{t} = dataSx2.(varNames{idxCalVisualAmpIdxAvg});
calVisualAmpAvgTrough{t} = dataSx2.(varNames{idxCalVisualAmpAvgTrough});
eyeVelVisualAmpAvgContra{t} = dataSx2.(varNames{idxEyeVelVisualAmpAvgContra});
eyeVisualAmpIdxAvgContra{t} = dataSx2.(varNames{idxEyeVisualAmpIdxAvgContra});
eyeVelVisualAmpAvgIpsi{t} = dataSx2.(varNames{idxEyeVelVisualAmpAvgIpsi});
eyeVisualAmpIdxAvgIpsi{t} = dataSx2.(varNames{idxEyeVisualAmpIdxAvgIpsi});
rsAmpAvg{t} = dataSx2.(varNames{idxRsAmpAvg});
rsAmpIdxAvg{t} = dataSx2.(varNames{idxRsAmpIdxAvg});
drumVisualAmpAvgContra{t} = dataSx2.(varNames{idxDrumVisualAmpAvgContra});
drumVisualAmpIdxAvgContra{t} = dataSx2.(varNames{idxDrumVisualAmpIdxAvgContra});
drumVisualAmpAvgIpsi{t} = dataSx2.(varNames{idxDrumVisualAmpAvgIpsi});
drumVisualAmpIdxAvgIpsi{t} = dataSx2.(varNames{idxDrumVisualAmpIdxAvgIpsi});
calDelayEye{t} = dataSx2.(varNames{idxCalDelayEye});
calDelayDrum{t} = dataSx2.(varNames{idxCalDelayDrum});
calDelayRS{t} = dataSx2.(varNames{idxCalDelayRS});
calVisualSine05{t} = dataSx2.(varNames{idxCalVisualSine05});
eyeVisualSine05{t} = dataSx2.(varNames{idxEyeVisualSine05});
rsSine05{t} = dataSx2.(varNames{idxRsSine05});
calVisualSine1{t} = dataSx2.(varNames{idxCalVisualSine1});
eyeVisualSine1{t} = dataSx2.(varNames{idxEyeVisualSine1});
rsSine1{t} = dataSx2.(varNames{idxRsSine1});
calVisualSine2{t} = dataSx2.(varNames{idxCalVisualSine2});
eyeVisualSine2{t} = dataSx2.(varNames{idxEyeVisualSine2});
rsSine2{t} = dataSx2.(varNames{idxRsSine2});
calVisualSine4{t} = dataSx2.(varNames{idxCalVisualSine4});
eyeVisualSine4{t} = dataSx2.(varNames{idxEyeVisualSine4});
rsSine4{t} = dataSx2.(varNames{idxRsSine4});
calVisualSineAmpAvg{t} = dataSx2.(varNames{idxCalVisualSineAmpAvg});
calVisualSineAmpIdxAvg{t} = dataSx2.(varNames{idxCalVisualSineAmpIdxAvg});
calVisualSineAmpAvgTrough{t} = dataSx2.(varNames{idxCalVisualSineAmpAvgTrough});
calVisualSineAmpIdxAvgTrough{t} = dataSx2.(varNames{idxCalVisualSineAmpIdxAvgTrough});
eyeVelVisualSineSineAmpAvgContra{t} = dataSx2.(varNames{idxEyeVelVisualSineSineAmpAvgContra});
eyeVisualSineAmpIdxAvgContra{t} = dataSx2.(varNames{idxEyeVisualSineAmpIdxAvgContra});
eyeVelVisualSineAmpAvgIpsi{t} = dataSx2.(varNames{idxEyeVelVisualSineAmpAvgIpsi});
eyeVisualSineAmpIdxAvgIpsi{t} = dataSx2.(varNames{idxEyeVisualSineAmpIdxAvgIpsi});
rsSineAmpAvg{t} = dataSx2.(varNames{idxRsSineAmpAvg});
rsSineAmpIdxAvg{t} = dataSx2.(varNames{idxRsSineAmpIdxAvg});

%% 
%extract data from 1st experiment
cd 'E:\FP\data\l7cre8\l7cre8data0824'
sx3 = dir('l7cre8data08244v2.mat');
dataSx3 = load('l7cre8data08244v2');
varNames = fieldnames(dataSx3);
t = 1;

[~, idxCalVisualBlockAvg] = ismember('calVisualBlockAvg', varNames);
[~, idxEyeVelVisualBlockAvg] = ismember('eyeVelVisualBlockAvg', varNames);
[~, idxRsBlockAvg] = ismember('rsBlockAvg', varNames);
[~, idxDrumVisualBlockAvg] = ismember('drumVisualBlockAvg', varNames);
[~, idxCalVisualBlockAmpAvg] = ismember('calVisualBlockAmpAvg', varNames);
[~, idxCalVisualBlockAmpIdxAvg] = ismember('calVisualBlockAmpIdxAvg', varNames);
[~, idxCalVisualBlockAmpAvgTrough] = ismember('calVisualBlockAmpAvgTrough', varNames);
[~, idxCalVisualBlockAmpIdxAvgTrough] = ismember('calVisualBlockAmpIdxAvgTrough', varNames);
[~, idxEyeVelVisualBlockAmpAvgContra] = ismember('eyeVelVisualBlockAmpAvgContra', varNames);
[~, idxEyeVisualBlockAmpIdxAvgContra] = ismember('eyeVisualBlockAmpIdxAvgContra', varNames);
[~, idxEyeVelVisualBlockAmpAvgIpsi] = ismember('eyeVelVisualBlockAmpAvgIpsi', varNames);
[~, idxEyeVisualBlockAmpIdxAvgIpsi] = ismember('eyeVisualBlockAmpIdxAvgIpsi', varNames);
[~, idxRsBlockAmpAvg] = ismember('rsBlockAmpAvg', varNames);
[~, idxRsBlockAmpIdxAvg] = ismember('rsBlockAmpIdxAvg', varNames);
[~, idxDrumVisualBlockAmpAvgContra] = ismember('drumVisualBlockAmpAvgContra', varNames);
[~, idxDrumVisualBlockAmpIdxAvgContra] = ismember('drumVisualBlockAmpIdxAvgContra', varNames);
[~, idxDrumVisualBlockAmpAvgIpsi] = ismember('drumVisualBlockAmpAvgIpsi', varNames);
[~, idxDrumVisualBlockAmpIdxAvgIpsi] = ismember('drumVisualBlockAmpIdxAvgIpsi', varNames);
[~, idxCalVisualAvg] = ismember('calVisualAvg', varNames);
[~, idxEyeVisualAvg] = ismember('eyeVisualAvg', varNames);
[~, idxRsAvg] = ismember('rsAvg', varNames);
[~, idxDrumVisualAvg] = ismember('drumVisualAvg', varNames);
[~, idxCalVisualAmpAvg] = ismember('calVisualAmpAvg', varNames);
[~, idxCalVisualAmpIdxAvg] = ismember('calVisualAmpIdxAvg', varNames);
[~, idxCalVisualAmpAvgTrough] = ismember('calVisualAmpAvgTrough', varNames);
[~, idxEyeVelVisualAmpAvgContra] = ismember('eyeVelVisualAmpAvgContra', varNames);
[~, idxEyeVisualAmpIdxAvgContra] = ismember('eyeVisualAmpIdxAvgContra', varNames);
[~, idxEyeVelVisualAmpAvgIpsi] = ismember('eyeVelVisualAmpAvgIpsi', varNames);
[~, idxEyeVisualAmpIdxAvgIpsi] = ismember('eyeVisualAmpIdxAvgIpsi', varNames);
[~, idxRsAmpAvg] = ismember('rsAmpAvg', varNames);
[~, idxRsAmpIdxAvg] = ismember('rsAmpIdxAvg', varNames);
[~, idxDrumVisualAmpAvgContra] = ismember('drumVisualAmpAvgContra', varNames);
[~, idxDrumVisualAmpIdxAvgContra] = ismember('drumVisualAmpIdxAvgContra', varNames);
[~, idxDrumVisualAmpAvgIpsi] = ismember('drumVisualAmpAvgIpsi', varNames);
[~, idxDrumVisualAmpIdxAvgIpsi] = ismember('drumVisualAmpIdxAvgIpsi', varNames);
[~, idxCalDelayEye] = ismember('calDelayEye', varNames);
[~, idxCalDelayDrum] = ismember('calDelayDrum', varNames);
[~, idxCalDelayRS] = ismember('calDelayRS', varNames);
[~, idxCalVisualSine05] = ismember('calVisualSine05', varNames);
[~, idxEyeVisualSine05] = ismember('eyeVisualSine05', varNames);
[~, idxRsSine05] = ismember('rsSine05', varNames);
[~, idxCalVisualSine1] = ismember('calVisualSine1', varNames);
[~, idxEyeVisualSine1] = ismember('eyeVisualSine1', varNames);
[~, idxRsSine1] = ismember('rsSine1', varNames);
[~, idxCalVisualSine2] = ismember('calVisualSine2', varNames);
[~, idxEyeVisualSine2] = ismember('eyeVisualSine2', varNames);
[~, idxRsSine2] = ismember('rsSine2', varNames);
[~, idxCalVisualSine4] = ismember('calVisualSine4', varNames);
[~, idxEyeVisualSine4] = ismember('eyeVisualSine4', varNames);
[~, idxRsSine4] = ismember('rsSine4', varNames);
[~, idxCalVisualSineAmpAvg] = ismember('calVisualSineAmpAvg', varNames);
[~, idxCalVisualSineAmpIdxAvg] = ismember('calVisualSineAmpIdxAvg', varNames);
[~, idxCalVisualSineAmpAvgTrough] = ismember('calVisualSineAmpAvgTrough', varNames);
[~, idxCalVisualSineAmpIdxAvgTrough] = ismember('calVisualSineAmpIdxAvgTrough', varNames);
[~, idxEyeVelVisualSineSineAmpAvgContra] = ismember('eyeVelVisualSineSineAmpAvgContra', varNames);
[~, idxEyeVisualSineAmpIdxAvgContra] = ismember('eyeVisualSineAmpIdxAvgContra', varNames);
[~, idxEyeVelVisualSineAmpAvgIpsi] = ismember('eyeVelVisualSineAmpAvgIpsi', varNames);
[~, idxEyeVisualSineAmpIdxAvgIpsi] = ismember('eyeVisualSineAmpIdxAvgIpsi', varNames);
[~, idxRsSineAmpAvg] = ismember('rsSineAmpAvg', varNames);
[~, idxRsSineAmpIdxAvg] = ismember('rsSineAmpIdxAvg', varNames);

calVisualBlockAvg{t,k} = dataSx3.(varNames{idxCalVisualBlockAvg});
eyeVelVisualBlockAvg{t,k} = dataSx3.(varNames{idxEyeVelVisualBlockAvg});
rsBlockAvg{t,k} = dataSx3.(varNames{idxRsBlockAvg});
drumVisualBlockAvg{t,k} = dataSx3.(varNames{idxDrumVisualBlockAvg});
calVisualBlockAmpAvg{t,k} = dataSx3.(varNames{idxCalVisualBlockAmpAvg});
calVisualBlockAmpIdxAvg{t,k} = dataSx3.(varNames{idxCalVisualBlockAmpIdxAvg});
calVisualBlockAmpAvgTrough{t,k} = dataSx3.(varNames{idxCalVisualBlockAmpAvgTrough});
calVisualBlockAmpIdxAvgTrough{t,k} = dataSx3.(varNames{idxCalVisualBlockAmpIdxAvgTrough});
eyeVelVisualBlockAmpAvgContra{t,k} = dataSx3.(varNames{idxEyeVelVisualBlockAmpAvgContra});
eyeVisualBlockAmpIdxAvgContra{t,k} = dataSx3.(varNames{idxEyeVisualBlockAmpIdxAvgContra});
eyeVelVisualBlockAmpAvgIpsi{t,k} = dataSx3.(varNames{idxEyeVelVisualBlockAmpAvgIpsi});
eyeVisualBlockAmpIdxAvgIpsi{t,k} = dataSx3.(varNames{idxEyeVisualBlockAmpIdxAvgIpsi});
rsBlockAmpAvg{t,k} = dataSx3.(varNames{idxRsBlockAmpAvg});
rsBlockAmpIdxAvg{t,k} = dataSx3.(varNames{idxRsBlockAmpIdxAvg});
drumVisualBlockAmpAvgContra{t,k} = dataSx3.(varNames{idxDrumVisualBlockAmpAvgContra});
drumVisualBlockAmpIdxAvgContra{t,k} = dataSx3.(varNames{idxDrumVisualBlockAmpIdxAvgContra});
drumVisualBlockAmpAvgIpsi{t,k} = dataSx3.(varNames{idxDrumVisualBlockAmpAvgIpsi});
drumVisualBlockAmpIdxAvgIpsi{t,k} = dataSx3.(varNames{idxDrumVisualBlockAmpIdxAvgIpsi});
calVisualAvg{t,k} = dataSx3.(varNames{idxCalVisualAvg});
eyeVisualAvg{t,k} = dataSx3.(varNames{idxEyeVisualAvg});
rsAvg{t,k} = dataSx3.(varNames{idxRsAvg});
drumVisualAvg{t,k} = dataSx3.(varNames{idxDrumVisualAvg});
calVisualAmpAvg{t,k} = dataSx3.(varNames{idxCalVisualAmpAvg});
calVisualAmpIdxAvg{t,k} = dataSx3.(varNames{idxCalVisualAmpIdxAvg});
calVisualAmpAvgTrough{t,k} = dataSx3.(varNames{idxCalVisualAmpAvgTrough});
eyeVelVisualAmpAvgContra{t,k} = dataSx3.(varNames{idxEyeVelVisualAmpAvgContra});
eyeVisualAmpIdxAvgContra{t,k} = dataSx3.(varNames{idxEyeVisualAmpIdxAvgContra});
eyeVelVisualAmpAvgIpsi{t,k} = dataSx3.(varNames{idxEyeVelVisualAmpAvgIpsi});
eyeVisualAmpIdxAvgIpsi{t,k} = dataSx3.(varNames{idxEyeVisualAmpIdxAvgIpsi});
rsAmpAvg{t,k} = dataSx3.(varNames{idxRsAmpAvg});
rsAmpIdxAvg{t,k} = dataSx3.(varNames{idxRsAmpIdxAvg});
drumVisualAmpAvgContra{t,k} = dataSx3.(varNames{idxDrumVisualAmpAvgContra});
drumVisualAmpIdxAvgContra{t,k} = dataSx3.(varNames{idxDrumVisualAmpIdxAvgContra});
drumVisualAmpAvgIpsi{t,k} = dataSx3.(varNames{idxDrumVisualAmpAvgIpsi});
drumVisualAmpIdxAvgIpsi{t,k} = dataSx3.(varNames{idxDrumVisualAmpIdxAvgIpsi});
calDelayEye{t,k} = dataSx3.(varNames{idxCalDelayEye});
calDelayDrum{t,k} = dataSx3.(varNames{idxCalDelayDrum});
calDelayRS{t,k} = dataSx3.(varNames{idxCalDelayRS});
calVisualSine05{t,k} = dataSx3.(varNames{idxCalVisualSine05});
eyeVisualSine05{t,k} = dataSx3.(varNames{idxEyeVisualSine05});
rsSine05{t,k} = dataSx3.(varNames{idxRsSine05});
calVisualSine1{t,k} = dataSx3.(varNames{idxCalVisualSine1});
eyeVisualSine1{t,k} = dataSx3.(varNames{idxEyeVisualSine1});
rsSine1{t,k} = dataSx3.(varNames{idxRsSine1});
calVisualSine2{t,k} = dataSx3.(varNames{idxCalVisualSine2});
eyeVisualSine2{t,k} = dataSx3.(varNames{idxEyeVisualSine2});
rsSine2{t,k} = dataSx3.(varNames{idxRsSine2});
calVisualSine4{t,k} = dataSx3.(varNames{idxCalVisualSine4});
eyeVisualSine4{t,k} = dataSx3.(varNames{idxEyeVisualSine4});
rsSine4{t,k} = dataSx3.(varNames{idxRsSine4});
calVisualSineAmpAvg{t,k} = dataSx3.(varNames{idxCalVisualSineAmpAvg});
calVisualSineAmpIdxAvg{t,k} = dataSx3.(varNames{idxCalVisualSineAmpIdxAvg});
calVisualSineAmpAvgTrough{t,k} = dataSx3.(varNames{idxCalVisualSineAmpAvgTrough});
calVisualSineAmpIdxAvgTrough{t,k} = dataSx3.(varNames{idxCalVisualSineAmpIdxAvgTrough});
eyeVelVisualSineSineAmpAvgContra{t,k} = dataSx3.(varNames{idxEyeVelVisualSineSineAmpAvgContra});
eyeVisualSineAmpIdxAvgContra{t,k} = dataSx3.(varNames{idxEyeVisualSineAmpIdxAvgContra});
eyeVelVisualSineAmpAvgIpsi{t,k} = dataSx3.(varNames{idxEyeVelVisualSineAmpAvgIpsi});
eyeVisualSineAmpIdxAvgIpsi{t,k} = dataSx3.(varNames{idxEyeVisualSineAmpIdxAvgIpsi});
rsSineAmpAvg{t,k} = dataSx3.(varNames{idxRsSineAmpAvg});
rsSineAmpIdxAvg{t,k} = dataSx3.(varNames{idxRsSineAmpIdxAvg});

%% extract data from 2nd dark-reared subject
cd 'E:\FP\data\l7cre8\l7cre8data0831'
sx4 = dir('l7cre8data08312v4.mat');
dataSx4 = load('l7cre8data08312v4');
varNames = fieldnames(dataSx4);
t = t + 1;

[~, idxCalVisualBlockAvg] = ismember('calVisualBlockAvg', varNames);
[~, idxEyeVelVisualBlockAvg] = ismember('eyeVelVisualBlockAvg', varNames);
[~, idxRsBlockAvg] = ismember('rsBlockAvg', varNames);
[~, idxDrumVisualBlockAvg] = ismember('drumVisualBlockAvg', varNames);
[~, idxCalVisualBlockAmpAvg] = ismember('calVisualBlockAmpAvg', varNames);
[~, idxCalVisualBlockAmpIdxAvg] = ismember('calVisualBlockAmpIdxAvg', varNames);
[~, idxCalVisualBlockAmpAvgTrough] = ismember('calVisualBlockAmpAvgTrough', varNames);
[~, idxCalVisualBlockAmpIdxAvgTrough] = ismember('calVisualBlockAmpIdxAvgTrough', varNames);
[~, idxEyeVelVisualBlockAmpAvgContra] = ismember('eyeVelVisualBlockAmpAvgContra', varNames);
[~, idxEyeVisualBlockAmpIdxAvgContra] = ismember('eyeVisualBlockAmpIdxAvgContra', varNames);
[~, idxEyeVelVisualBlockAmpAvgIpsi] = ismember('eyeVelVisualBlockAmpAvgIpsi', varNames);
[~, idxEyeVisualBlockAmpIdxAvgIpsi] = ismember('eyeVisualBlockAmpIdxAvgIpsi', varNames);
[~, idxRsBlockAmpAvg] = ismember('rsBlockAmpAvg', varNames);
[~, idxRsBlockAmpIdxAvg] = ismember('rsBlockAmpIdxAvg', varNames);
[~, idxDrumVisualBlockAmpAvgContra] = ismember('drumVisualBlockAmpAvgContra', varNames);
[~, idxDrumVisualBlockAmpIdxAvgContra] = ismember('drumVisualBlockAmpIdxAvgContra', varNames);
[~, idxDrumVisualBlockAmpAvgIpsi] = ismember('drumVisualBlockAmpAvgIpsi', varNames);
[~, idxDrumVisualBlockAmpIdxAvgIpsi] = ismember('drumVisualBlockAmpIdxAvgIpsi', varNames);
[~, idxCalVisualAvg] = ismember('calVisualAvg', varNames);
[~, idxEyeVisualAvg] = ismember('eyeVisualAvg', varNames);
[~, idxRsAvg] = ismember('rsAvg', varNames);
[~, idxDrumVisualAvg] = ismember('drumVisualAvg', varNames);
[~, idxCalVisualAmpAvg] = ismember('calVisualAmpAvg', varNames);
[~, idxCalVisualAmpIdxAvg] = ismember('calVisualAmpIdxAvg', varNames);
[~, idxCalVisualAmpAvgTrough] = ismember('calVisualAmpAvgTrough', varNames);
[~, idxEyeVelVisualAmpAvgContra] = ismember('eyeVelVisualAmpAvgContra', varNames);
[~, idxEyeVisualAmpIdxAvgContra] = ismember('eyeVisualAmpIdxAvgContra', varNames);
[~, idxEyeVelVisualAmpAvgIpsi] = ismember('eyeVelVisualAmpAvgIpsi', varNames);
[~, idxEyeVisualAmpIdxAvgIpsi] = ismember('eyeVisualAmpIdxAvgIpsi', varNames);
[~, idxRsAmpAvg] = ismember('rsAmpAvg', varNames);
[~, idxRsAmpIdxAvg] = ismember('rsAmpIdxAvg', varNames);
[~, idxDrumVisualAmpAvgContra] = ismember('drumVisualAmpAvgContra', varNames);
[~, idxDrumVisualAmpIdxAvgContra] = ismember('drumVisualAmpIdxAvgContra', varNames);
[~, idxDrumVisualAmpAvgIpsi] = ismember('drumVisualAmpAvgIpsi', varNames);
[~, idxDrumVisualAmpIdxAvgIpsi] = ismember('drumVisualAmpIdxAvgIpsi', varNames);
[~, idxCalDelayEye] = ismember('calDelayEye', varNames);
[~, idxCalDelayDrum] = ismember('calDelayDrum', varNames);
[~, idxCalDelayRS] = ismember('calDelayRS', varNames);
[~, idxCalVisualSine05] = ismember('calVisualSine05', varNames);
[~, idxEyeVisualSine05] = ismember('eyeVisualSine05', varNames);
[~, idxRsSine05] = ismember('rsSine05', varNames);
[~, idxCalVisualSine1] = ismember('calVisualSine1', varNames);
[~, idxEyeVisualSine1] = ismember('eyeVisualSine1', varNames);
[~, idxRsSine1] = ismember('rsSine1', varNames);
[~, idxCalVisualSine2] = ismember('calVisualSine2', varNames);
[~, idxEyeVisualSine2] = ismember('eyeVisualSine2', varNames);
[~, idxRsSine2] = ismember('rsSine2', varNames);
[~, idxCalVisualSine4] = ismember('calVisualSine4', varNames);
[~, idxEyeVisualSine4] = ismember('eyeVisualSine4', varNames);
[~, idxRsSine4] = ismember('rsSine4', varNames);
[~, idxCalVisualSineAmpAvg] = ismember('calVisualSineAmpAvg', varNames);
[~, idxCalVisualSineAmpIdxAvg] = ismember('calVisualSineAmpIdxAvg', varNames);
[~, idxCalVisualSineAmpAvgTrough] = ismember('calVisualSineAmpAvgTrough', varNames);
[~, idxCalVisualSineAmpIdxAvgTrough] = ismember('calVisualSineAmpIdxAvgTrough', varNames);
[~, idxEyeVelVisualSineSineAmpAvgContra] = ismember('eyeVelVisualSineSineAmpAvgContra', varNames);
[~, idxEyeVisualSineAmpIdxAvgContra] = ismember('eyeVisualSineAmpIdxAvgContra', varNames);
[~, idxEyeVelVisualSineAmpAvgIpsi] = ismember('eyeVelVisualSineAmpAvgIpsi', varNames);
[~, idxEyeVisualSineAmpIdxAvgIpsi] = ismember('eyeVisualSineAmpIdxAvgIpsi', varNames);
[~, idxRsSineAmpAvg] = ismember('rsSineAmpAvg', varNames);
[~, idxRsSineAmpIdxAvg] = ismember('rsSineAmpIdxAvg', varNames);

calVisualBlockAvg{t,k} = dataSx4.(varNames{idxCalVisualBlockAvg});
eyeVelVisualBlockAvg{t,k} = dataSx4.(varNames{idxEyeVelVisualBlockAvg});
rsBlockAvg{t,k} = dataSx4.(varNames{idxRsBlockAvg});
drumVisualBlockAvg{t,k} = dataSx4.(varNames{idxDrumVisualBlockAvg});
calVisualBlockAmpAvg{t,k} = dataSx4.(varNames{idxCalVisualBlockAmpAvg});
calVisualBlockAmpIdxAvg{t,k} = dataSx4.(varNames{idxCalVisualBlockAmpIdxAvg});
calVisualBlockAmpAvgTrough{t,k} = dataSx4.(varNames{idxCalVisualBlockAmpAvgTrough});
calVisualBlockAmpIdxAvgTrough{t,k} = dataSx4.(varNames{idxCalVisualBlockAmpIdxAvgTrough});
eyeVelVisualBlockAmpAvgContra{t,k} = dataSx4.(varNames{idxEyeVelVisualBlockAmpAvgContra});
eyeVisualBlockAmpIdxAvgContra{t,k} = dataSx4.(varNames{idxEyeVisualBlockAmpIdxAvgContra});
eyeVelVisualBlockAmpAvgIpsi{t,k} = dataSx4.(varNames{idxEyeVelVisualBlockAmpAvgIpsi});
eyeVisualBlockAmpIdxAvgIpsi{t,k} = dataSx4.(varNames{idxEyeVisualBlockAmpIdxAvgIpsi});
rsBlockAmpAvg{t,k} = dataSx4.(varNames{idxRsBlockAmpAvg});
rsBlockAmpIdxAvg{t,k} = dataSx4.(varNames{idxRsBlockAmpIdxAvg});
drumVisualBlockAmpAvgContra{t,k} = dataSx4.(varNames{idxDrumVisualBlockAmpAvgContra});
drumVisualBlockAmpIdxAvgContra{t,k} = dataSx4.(varNames{idxDrumVisualBlockAmpIdxAvgContra});
drumVisualBlockAmpAvgIpsi{t,k} = dataSx4.(varNames{idxDrumVisualBlockAmpAvgIpsi});
drumVisualBlockAmpIdxAvgIpsi{t,k} = dataSx4.(varNames{idxDrumVisualBlockAmpIdxAvgIpsi});
calVisualAvg{t,k} = dataSx4.(varNames{idxCalVisualAvg});
eyeVisualAvg{t,k} = dataSx4.(varNames{idxEyeVisualAvg});
rsAvg{t,k} = dataSx4.(varNames{idxRsAvg});
drumVisualAvg{t,k} = dataSx4.(varNames{idxDrumVisualAvg});
calVisualAmpAvg{t,k} = dataSx4.(varNames{idxCalVisualAmpAvg});
calVisualAmpIdxAvg{t,k} = dataSx4.(varNames{idxCalVisualAmpIdxAvg});
calVisualAmpAvgTrough{t,k} = dataSx4.(varNames{idxCalVisualAmpAvgTrough});
eyeVelVisualAmpAvgContra{t,k} = dataSx4.(varNames{idxEyeVelVisualAmpAvgContra});
eyeVisualAmpIdxAvgContra{t,k} = dataSx4.(varNames{idxEyeVisualAmpIdxAvgContra});
eyeVelVisualAmpAvgIpsi{t,k} = dataSx4.(varNames{idxEyeVelVisualAmpAvgIpsi});
eyeVisualAmpIdxAvgIpsi{t,k} = dataSx4.(varNames{idxEyeVisualAmpIdxAvgIpsi});
rsAmpAvg{t,k} = dataSx4.(varNames{idxRsAmpAvg});
rsAmpIdxAvg{t,k} = dataSx4.(varNames{idxRsAmpIdxAvg});
drumVisualAmpAvgContra{t,k} = dataSx4.(varNames{idxDrumVisualAmpAvgContra});
drumVisualAmpIdxAvgContra{t,k} = dataSx4.(varNames{idxDrumVisualAmpIdxAvgContra});
drumVisualAmpAvgIpsi{t,k} = dataSx4.(varNames{idxDrumVisualAmpAvgIpsi});
drumVisualAmpIdxAvgIpsi{t,k} = dataSx4.(varNames{idxDrumVisualAmpIdxAvgIpsi});
calDelayEye{t,k} = dataSx4.(varNames{idxCalDelayEye});
calDelayDrum{t,k} = dataSx4.(varNames{idxCalDelayDrum});
calDelayRS{t,k} = dataSx4.(varNames{idxCalDelayRS});
calVisualSine05{t,k} = dataSx4.(varNames{idxCalVisualSine05});
eyeVisualSine05{t,k} = dataSx4.(varNames{idxEyeVisualSine05});
rsSine05{t,k} = dataSx4.(varNames{idxRsSine05});
calVisualSine1{t,k} = dataSx4.(varNames{idxCalVisualSine1});
eyeVisualSine1{t,k} = dataSx4.(varNames{idxEyeVisualSine1});
rsSine1{t,k} = dataSx4.(varNames{idxRsSine1});
calVisualSine2{t,k} = dataSx4.(varNames{idxCalVisualSine2});
eyeVisualSine2{t,k} = dataSx4.(varNames{idxEyeVisualSine2});
rsSine2{t,k} = dataSx4.(varNames{idxRsSine2});
calVisualSine4{t,k} = dataSx4.(varNames{idxCalVisualSine4});
eyeVisualSine4{t,k} = dataSx4.(varNames{idxEyeVisualSine4});
rsSine4{t,k} = dataSx4.(varNames{idxRsSine4});
calVisualSineAmpAvg{t,k} = dataSx4.(varNames{idxCalVisualSineAmpAvg});
calVisualSineAmpIdxAvg{t,k} = dataSx4.(varNames{idxCalVisualSineAmpIdxAvg});
calVisualSineAmpAvgTrough{t,k} = dataSx4.(varNames{idxCalVisualSineAmpAvgTrough});
calVisualSineAmpIdxAvgTrough{t,k} = dataSx4.(varNames{idxCalVisualSineAmpIdxAvgTrough});
eyeVelVisualSineSineAmpAvgContra{t,k} = dataSx4.(varNames{idxEyeVelVisualSineSineAmpAvgContra});
eyeVisualSineAmpIdxAvgContra{t,k} = dataSx4.(varNames{idxEyeVisualSineAmpIdxAvgContra});
eyeVelVisualSineAmpAvgIpsi{t,k} = dataSx4.(varNames{idxEyeVelVisualSineAmpAvgIpsi});
eyeVisualSineAmpIdxAvgIpsi{t,k} = dataSx4.(varNames{idxEyeVisualSineAmpIdxAvgIpsi});
rsSineAmpAvg{t,k} = dataSx4.(varNames{idxRsSineAmpAvg});
rsSineAmpIdxAvg{t,k} = dataSx4.(varNames{idxRsSineAmpIdxAvg});

%% extract data from 3rd dark-reared subject
cd 'E:\FP\data\l7cre11\l7cre11data0907'
sx5 = dir('l7cre11data09076v2.mat');
dataSx5 = load('l7cre11data09076v2');
varNames = fieldnames(dataSx5);
t = t + 1;

[~, idxCalVisualBlockAvg] = ismember('calVisualBlockAvg', varNames);
[~, idxEyeVelVisualBlockAvg] = ismember('eyeVelVisualBlockAvg', varNames);
[~, idxRsBlockAvg] = ismember('rsBlockAvg', varNames);
[~, idxDrumVisualBlockAvg] = ismember('drumVisualBlockAvg', varNames);
[~, idxCalVisualBlockAmpAvg] = ismember('calVisualBlockAmpAvg', varNames);
[~, idxCalVisualBlockAmpIdxAvg] = ismember('calVisualBlockAmpIdxAvg', varNames);
[~, idxCalVisualBlockAmpAvgTrough] = ismember('calVisualBlockAmpAvgTrough', varNames);
[~, idxCalVisualBlockAmpIdxAvgTrough] = ismember('calVisualBlockAmpIdxAvgTrough', varNames);
[~, idxEyeVelVisualBlockAmpAvgContra] = ismember('eyeVelVisualBlockAmpAvgContra', varNames);
[~, idxEyeVisualBlockAmpIdxAvgContra] = ismember('eyeVisualBlockAmpIdxAvgContra', varNames);
[~, idxEyeVelVisualBlockAmpAvgIpsi] = ismember('eyeVelVisualBlockAmpAvgIpsi', varNames);
[~, idxEyeVisualBlockAmpIdxAvgIpsi] = ismember('eyeVisualBlockAmpIdxAvgIpsi', varNames);
[~, idxRsBlockAmpAvg] = ismember('rsBlockAmpAvg', varNames);
[~, idxRsBlockAmpIdxAvg] = ismember('rsBlockAmpIdxAvg', varNames);
[~, idxDrumVisualBlockAmpAvgContra] = ismember('drumVisualBlockAmpAvgContra', varNames);
[~, idxDrumVisualBlockAmpIdxAvgContra] = ismember('drumVisualBlockAmpIdxAvgContra', varNames);
[~, idxDrumVisualBlockAmpAvgIpsi] = ismember('drumVisualBlockAmpAvgIpsi', varNames);
[~, idxDrumVisualBlockAmpIdxAvgIpsi] = ismember('drumVisualBlockAmpIdxAvgIpsi', varNames);
[~, idxCalVisualAvg] = ismember('calVisualAvg', varNames);
[~, idxEyeVisualAvg] = ismember('eyeVisualAvg', varNames);
[~, idxRsAvg] = ismember('rsAvg', varNames);
[~, idxDrumVisualAvg] = ismember('drumVisualAvg', varNames);
[~, idxCalVisualAmpAvg] = ismember('calVisualAmpAvg', varNames);
[~, idxCalVisualAmpIdxAvg] = ismember('calVisualAmpIdxAvg', varNames);
[~, idxCalVisualAmpAvgTrough] = ismember('calVisualAmpAvgTrough', varNames);
[~, idxEyeVelVisualAmpAvgContra] = ismember('eyeVelVisualAmpAvgContra', varNames);
[~, idxEyeVisualAmpIdxAvgContra] = ismember('eyeVisualAmpIdxAvgContra', varNames);
[~, idxEyeVelVisualAmpAvgIpsi] = ismember('eyeVelVisualAmpAvgIpsi', varNames);
[~, idxEyeVisualAmpIdxAvgIpsi] = ismember('eyeVisualAmpIdxAvgIpsi', varNames);
[~, idxRsAmpAvg] = ismember('rsAmpAvg', varNames);
[~, idxRsAmpIdxAvg] = ismember('rsAmpIdxAvg', varNames);
[~, idxDrumVisualAmpAvgContra] = ismember('drumVisualAmpAvgContra', varNames);
[~, idxDrumVisualAmpIdxAvgContra] = ismember('drumVisualAmpIdxAvgContra', varNames);
[~, idxDrumVisualAmpAvgIpsi] = ismember('drumVisualAmpAvgIpsi', varNames);
[~, idxDrumVisualAmpIdxAvgIpsi] = ismember('drumVisualAmpIdxAvgIpsi', varNames);
[~, idxCalDelayEye] = ismember('calDelayEye', varNames);
[~, idxCalDelayDrum] = ismember('calDelayDrum', varNames);
[~, idxCalDelayRS] = ismember('calDelayRS', varNames);
[~, idxCalVisualSine05] = ismember('calVisualSine05', varNames);
[~, idxEyeVisualSine05] = ismember('eyeVisualSine05', varNames);
[~, idxRsSine05] = ismember('rsSine05', varNames);
[~, idxCalVisualSine1] = ismember('calVisualSine1', varNames);
[~, idxEyeVisualSine1] = ismember('eyeVisualSine1', varNames);
[~, idxRsSine1] = ismember('rsSine1', varNames);
[~, idxCalVisualSine2] = ismember('calVisualSine2', varNames);
[~, idxEyeVisualSine2] = ismember('eyeVisualSine2', varNames);
[~, idxRsSine2] = ismember('rsSine2', varNames);
[~, idxCalVisualSine4] = ismember('calVisualSine4', varNames);
[~, idxEyeVisualSine4] = ismember('eyeVisualSine4', varNames);
[~, idxRsSine4] = ismember('rsSine4', varNames);
[~, idxCalVisualSineAmpAvg] = ismember('calVisualSineAmpAvg', varNames);
[~, idxCalVisualSineAmpIdxAvg] = ismember('calVisualSineAmpIdxAvg', varNames);
[~, idxCalVisualSineAmpAvgTrough] = ismember('calVisualSineAmpAvgTrough', varNames);
[~, idxCalVisualSineAmpIdxAvgTrough] = ismember('calVisualSineAmpIdxAvgTrough', varNames);
[~, idxEyeVelVisualSineAmpAvgContra] = ismember('eyeVelVisualSineAmpAvgContra', varNames);
[~, idxEyeVisualSineAmpIdxAvgContra] = ismember('eyeVisualSineAmpIdxAvgContra', varNames);
[~, idxEyeVelVisualSineAmpAvgIpsi] = ismember('eyeVelVisualSineAmpAvgIpsi', varNames);
[~, idxEyeVisualSineAmpIdxAvgIpsi] = ismember('eyeVisualSineAmpIdxAvgIpsi', varNames);
[~, idxRsSineAmpAvg] = ismember('rsSineAmpAvg', varNames);
[~, idxRsSineAmpIdxAvg] = ismember('rsSineAmpIdxAvg', varNames);

calVisualBlockAvg{t,k} = dataSx5.(varNames{idxCalVisualBlockAvg});
eyeVelVisualBlockAvg{t,k} = dataSx5.(varNames{idxEyeVelVisualBlockAvg});
rsBlockAvg{t,k} = dataSx5.(varNames{idxRsBlockAvg});
drumVisualBlockAvg{t,k} = dataSx5.(varNames{idxDrumVisualBlockAvg});
calVisualBlockAmpAvg{t,k} = dataSx5.(varNames{idxCalVisualBlockAmpAvg});
calVisualBlockAmpIdxAvg{t,k} = dataSx5.(varNames{idxCalVisualBlockAmpIdxAvg});
calVisualBlockAmpAvgTrough{t,k} = dataSx5.(varNames{idxCalVisualBlockAmpAvgTrough});
calVisualBlockAmpIdxAvgTrough{t,k} = dataSx5.(varNames{idxCalVisualBlockAmpIdxAvgTrough});
eyeVelVisualBlockAmpAvgContra{t,k} = dataSx5.(varNames{idxEyeVelVisualBlockAmpAvgContra});
eyeVisualBlockAmpIdxAvgContra{t,k} = dataSx5.(varNames{idxEyeVisualBlockAmpIdxAvgContra});
eyeVelVisualBlockAmpAvgIpsi{t,k} = dataSx5.(varNames{idxEyeVelVisualBlockAmpAvgIpsi});
eyeVisualBlockAmpIdxAvgIpsi{t,k} = dataSx5.(varNames{idxEyeVisualBlockAmpIdxAvgIpsi});
rsBlockAmpAvg{t,k} = dataSx5.(varNames{idxRsBlockAmpAvg});
rsBlockAmpIdxAvg{t,k} = dataSx5.(varNames{idxRsBlockAmpIdxAvg});
drumVisualBlockAmpAvgContra{t,k} = dataSx5.(varNames{idxDrumVisualBlockAmpAvgContra});
drumVisualBlockAmpIdxAvgContra{t,k} = dataSx5.(varNames{idxDrumVisualBlockAmpIdxAvgContra});
drumVisualBlockAmpAvgIpsi{t,k} = dataSx5.(varNames{idxDrumVisualBlockAmpAvgIpsi});
drumVisualBlockAmpIdxAvgIpsi{t,k} = dataSx5.(varNames{idxDrumVisualBlockAmpIdxAvgIpsi});
calVisualAvg{t,k} = dataSx5.(varNames{idxCalVisualAvg});
eyeVisualAvg{t,k} = dataSx5.(varNames{idxEyeVisualAvg});
rsAvg{t,k} = dataSx5.(varNames{idxRsAvg});
drumVisualAvg{t,k} = dataSx5.(varNames{idxDrumVisualAvg});
calVisualAmpAvg{t,k} = dataSx5.(varNames{idxCalVisualAmpAvg});
calVisualAmpIdxAvg{t,k} = dataSx5.(varNames{idxCalVisualAmpIdxAvg});
calVisualAmpAvgTrough{t,k} = dataSx5.(varNames{idxCalVisualAmpAvgTrough});
eyeVelVisualAmpAvgContra{t,k} = dataSx5.(varNames{idxEyeVelVisualAmpAvgContra});
eyeVisualAmpIdxAvgContra{t,k} = dataSx5.(varNames{idxEyeVisualAmpIdxAvgContra});
eyeVelVisualAmpAvgIpsi{t,k} = dataSx5.(varNames{idxEyeVelVisualAmpAvgIpsi});
eyeVisualAmpIdxAvgIpsi{t,k} = dataSx5.(varNames{idxEyeVisualAmpIdxAvgIpsi});
rsAmpAvg{t,k} = dataSx5.(varNames{idxRsAmpAvg});
rsAmpIdxAvg{t,k} = dataSx5.(varNames{idxRsAmpIdxAvg});
drumVisualAmpAvgContra{t,k} = dataSx5.(varNames{idxDrumVisualAmpAvgContra});
drumVisualAmpIdxAvgContra{t,k} = dataSx5.(varNames{idxDrumVisualAmpIdxAvgContra});
drumVisualAmpAvgIpsi{t,k} = dataSx5.(varNames{idxDrumVisualAmpAvgIpsi});
drumVisualAmpIdxAvgIpsi{t,k} = dataSx5.(varNames{idxDrumVisualAmpIdxAvgIpsi});
calDelayEye{t,k} = dataSx5.(varNames{idxCalDelayEye});
calDelayDrum{t,k} = dataSx5.(varNames{idxCalDelayDrum});
calDelayRS{t,k} = dataSx5.(varNames{idxCalDelayRS});
calVisualSine05{t,k} = dataSx5.(varNames{idxCalVisualSine05});
eyeVisualSine05{t,k} = dataSx5.(varNames{idxEyeVisualSine05});
rsSine05{t,k} = dataSx5.(varNames{idxRsSine05});
calVisualSine1{t,k} = dataSx5.(varNames{idxCalVisualSine1});
eyeVisualSine1{t,k} = dataSx5.(varNames{idxEyeVisualSine1});
rsSine1{t,k} = dataSx5.(varNames{idxRsSine1});
calVisualSine2{t,k} = dataSx5.(varNames{idxCalVisualSine2});
eyeVisualSine2{t,k} = dataSx5.(varNames{idxEyeVisualSine2});
rsSine2{t,k} = dataSx5.(varNames{idxRsSine2});
calVisualSine4{t,k} = dataSx5.(varNames{idxCalVisualSine4});
eyeVisualSine4{t,k} = dataSx5.(varNames{idxEyeVisualSine4});
rsSine4{t,k} = dataSx5.(varNames{idxRsSine4});
calVisualSineAmpAvg{t,k} = dataSx5.(varNames{idxCalVisualSineAmpAvg});
calVisualSineAmpIdxAvg{t,k} = dataSx5.(varNames{idxCalVisualSineAmpIdxAvg});
calVisualSineAmpAvgTrough{t,k} = dataSx5.(varNames{idxCalVisualSineAmpAvgTrough});
calVisualSineAmpIdxAvgTrough{t,k} = dataSx5.(varNames{idxCalVisualSineAmpIdxAvgTrough});
eyeVelVisualSineSineAmpAvgContra{t,k} = dataSx5.(varNames{idxEyeVelVisualSineAmpAvgContra});
eyeVisualSineAmpIdxAvgContra{t,k} = dataSx5.(varNames{idxEyeVisualSineAmpIdxAvgContra});
eyeVelVisualSineAmpAvgIpsi{t,k} = dataSx5.(varNames{idxEyeVelVisualSineAmpAvgIpsi});
eyeVisualSineAmpIdxAvgIpsi{t,k} = dataSx5.(varNames{idxEyeVisualSineAmpIdxAvgIpsi});
rsSineAmpAvg{t,k} = dataSx5.(varNames{idxRsSineAmpAvg});
rsSineAmpIdxAvg{t,k} = dataSx5.(varNames{idxRsSineAmpIdxAvg});

%% Concatenate data from each subject
%Calcium peak timing re peak retinal slip velocity
calDelayRSnew = cat(2,calDelayRS{1:numSxs,1});
calDelayRSnewDark = cat(2,calDelayRS{1:numSxs,2});
calDelayRSnorm = [calDelayRSnew(:,1),calDelayRSnew(:,3)];
calDelayRSdark = [calDelayRSnewDark(:,1),calDelayRSnewDark(:,3),calDelayRSnewDark(:,5)];
calDelayRSsineNorm = [calDelayRSnew(:,2),calDelayRSnew(:,4)];
calDelayRSdarkSine = [calDelayRSnewDark(:,2),calDelayRSnewDark(:,4),calDelayRSnewDark(:,6)];
calDelayRSnormPopAvg = mean(calDelayRSnorm,2);
calDelayRSdarkPopAvg = mean(calDelayRSdark,2);
calDelayRSsineNormPopAvg = mean(calDelayRSsineNorm,2);
calDelayRSdarkSinePopAvg = mean(calDelayRSdarkSine,2);

calAmpNew = cell2mat(cat(2,calVisualAmpAvg{1:numSxs,1}));
calAmpNewDark = cell2mat(cat(2,calVisualAmpAvg{1:numSxs,2}));
calAmpPopAvg = mean(calAmpNew,2)*100;
calAmpDarkPopAvg = mean(calAmpNewDark,2)*100;
Ydelay = [6 5 4 3 2 1]';

figure(); hold on
scatter([calDelayRSdarkPopAvg calDelayRSnormPopAvg],[Ydelay Ydelay])
scatter([calDelayRSdarkSinePopAvg(1:4) calDelayRSsineNormPopAvg(1:4)],[Ydelay(1:4) Ydelay(1:4)])
yticks(1:6)
ylim([0 7])
yticklabels({'step 10\circ{}/s','step 5\circ{}/s','4','2','1','0.5'})
ylabel('Frequency (Hz)')
title('Calcium peak delay re retinal slip peak')
xlabel('Time (ms)')
legend('Dark-reared','Normal-reared','Dark-reared sines-fitted','Normal-reared sines-fitted')

%% Calcium peak timing re peak eye velocity
calDelayEyeNew = cat(2,calDelayEye{1:numSxs,1});
calDelayEyeNewDark = cat(2,calDelayEye{1:numSxs,2});
calDelayEyeNorm = [calDelayEyeNew(:,1),calDelayEyeNew(:,3)];
calDelayEyeDark = [calDelayEyeNewDark(:,1),calDelayEyeNewDark(:,3)];
calDelayEyeSineNorm = [calDelayEyeNew(:,2),calDelayEyeNew(:,4)];
calDelayEyeDarkSine = [calDelayEyeNewDark(:,2),calDelayEyeNewDark(:,4)];
calDelayEyeNormPopAvg = mean(calDelayEyeNorm,2);
calDelayEyeDarkPopAvg = mean(calDelayEyeDark,2);
calDelayEyeSineNormPopAvg = mean(calDelayEyeSineNorm,2);
calDelayEyeDarkSinePopAvg = mean(calDelayEyeDarkSine,2);

figure(); hold on
scatter([calDelayEyeDarkPopAvg calDelayEyeNormPopAvg],[Ydelay Ydelay])
scatter([calDelayEyeDarkSinePopAvg(1:4) calDelayEyeSineNormPopAvg(1:4)],[Ydelay(1:4) Ydelay(1:4)])
yticks(1:6)
ylim([0 7])
yticklabels({'step 10\circ{}/s','step 5\circ{}/s','4','2','1','0.5'})
ylabel('Frequency (Hz)')
title('Calcium peak delay re eye velocity peak')
xlabel('Time (ms)')
legend('Dark-reared','Normal-reared','Dark-reared sines-fitted','Normal-reared sines-fitted')

%% Calcium peak timing re peak drum velocity
calDelayDrumNew = cat(2,calDelayDrum{1:numSxs,1});
calDelayDrumNewDark = cat(2,calDelayDrum{1:numSxs,2});
calDelayDrumNorm = [calDelayDrumNew(:,1),calDelayDrumNew(:,3)];
calDelayDrumDark = [calDelayDrumNewDark(:,1),calDelayDrumNewDark(:,3)];
calDelayDrumSineNorm = [calDelayDrumNew(:,2),calDelayDrumNew(:,4)];
calDelayDrumDarkSine = [calDelayDrumNewDark(:,2),calDelayDrumNewDark(:,4)];
calDelayDrumNormPopAvg = mean(calDelayDrumNorm,2);
calDelayDrumDarkPopAvg = mean(calDelayDrumDark,2);
calDelayDrumSineNormPopAvg = mean(calDelayDrumSineNorm,2);
calDelayDrumDarkSinePopAvg = mean(calDelayDrumDarkSine,2);

figure(); hold on
scatter([calDelayDrumDarkPopAvg calDelayDrumNormPopAvg],[Ydelay Ydelay])
scatter([calDelayDrumDarkSinePopAvg(1:4) calDelayDrumSineNormPopAvg(1:4)],[Ydelay(1:4) Ydelay(1:4)])
yticks(1:6)
ylim([0 7])
yticklabels({'step 10\circ{}/s','step 5\circ{}/s','4','2','1','0.5'})
ylabel('Frequency (Hz)')
title('Calcium peak delay re drum velocity peak')
xlabel('Time (ms)')
legend('Dark-reared','Normal-reared','Dark-reared sines-fitted','Normal-reared sines-fitted')

%% 

% calBlockAmpIdxDim = [calBlockAmpIdx1{1:5}; calBlockAmpIdx2a{1:5}];
% calBlockAmpIdxAvgDim = mean(calBlockAmpIdxDim,1);
% calBlockAmpIdxDimPopMean = mean(calBlockAmpIdxAvgDim);
% calSineBlockAvgAmpIdxDim = [calSineBlockAvgAmpIdx1{1:5}; calSineBlockAvgAmpIdx2a{1:5}];
% calSineBlockAmpIdxAvgDim = mean(calSineBlockAvgAmpIdxDim,1);
% calSineBlockAmpIdxDimPopMean = mean(calSineBlockAmpIdxAvgDim);
% 
% calBlockAmpIdxBright = [calBlockAmpIdx1a{1:5}; calBlockAmpIdx2{1:5}];
% calBlockAmpIdxAvgBright = mean(calBlockAmpIdxBright,1);
% calBlockAmpIdxBrightPopMean = mean(calBlockAmpIdxAvgBright);
% calSineBlockAvgAmpIdxBright = [calSineBlockAvgAmpIdx1{1:5}; calSineBlockAvgAmpIdx2a{1:5}];
% calSineBlockAmpIdxAvgBright = mean(calSineBlockAvgAmpIdxBright,1);
% calSineBlockAmpIdxBrightPopMean = mean(calSineBlockAmpIdxAvgBright);
% 
% %plot sine-fitted calcium traces
% calSine1 = circshift(calSineSingleAvg1,500);
% calSine1a = circshift(calSineSingleAvg1a,500);
% sineMin = min(calSine1);
% sineMin1a = min(calSine1a);
% calSine1 = calSine1*100 + abs(sineMin*100);
% calSine1a = calSine1a*100 + abs(sineMin1a*100);
% drum1 = circshift(calDelayDrum05a,500);
% drum1a = circshift(drumLightAvg1a,500);
% drum1rescale = rescale(calDelayDrum05a,0,2.5);
% drum1aRescale = rescale(drumLightAvg1a,0,2.5)
% rs1 = calDelayDrum05a - eyeSineSingleAvg1;
% rs1a = drumLightAvg1a - eyeSineSingleAvg1a;
% rs1rescale = rescale(rs1,0,2.5)
% rs1aRescale = rescale(rs1a,0,2.5)
% 
% plot(calSine1)
% hold on
% plot(calSine1a)
% plot(drum1rescale)
% plot(drum1aRescale)
% plot(rs1rescale)
% plot(rs1aRescale)
% 
% figure(); hold on
% plot(calDelayDrum05a)
% plot(eyeSineSingleAvg1)
% plot(rs1)
% plot(calciumAvg1*100)
% figure(); hold on
% plot(drumLightAvg1a)
% plot(eyeSineSingleAvg1a)
% plot(rs1a)
% plot(calciumAvg1a*100)
% 
% %% 
% %plot calcium traces
% figure()
% t = tiledlayout(2,2);
% t.TileSpacing = 'compact';
% t.Padding = 'tight';
% drumRescale1 = rescale(calDelayDrum05a,0,3);
% drumRescale1 = drumRescale1*-1+max(drumRescale1)
% drumRescale1a = rescale(drumLightAvg1a,0,3);
% drumRescale1a = drumRescale1a*-1+max(drumRescale1a)
% drumRescale2 = rescale(drumLightAvg2,0,0.5);
% drumRescale2 = drumRescale2*-1+max(drumRescale2)
% drumRescale2a = rescale(drumLightAvg2a,0,0.5);
% drumRescale2a = drumRescale2a*-1+max(drumRescale2a)
% nexttile; hold on
% plot(visualAvg05a*100)
% plot(drumRescale1)
% title('Dim')
% ylabel('% \DeltaF/G')
% ylim([0 6])
% legend('Block 1', 'Block 2', 'Block 3', 'Block 4', 'Block 5', 'Drum vel.')
% nexttile; hold on
% plot(calcium2a*100)
% plot(drumRescale2a)
% title('Dim')
% ylim([0 0.8])
% nexttile; hold on
% plot(calcium1a*100)
% plot(drumRescale1a)
% ylabel('% \DeltaF/G')
% xlabel('Time (ms)')
% title('Bright')
% ylim([0 6])
% nexttile; hold on
% plot(calcium2*100)
% plot(drumRescale2)
% title('Bright')
% xlabel('Time (ms)')
% ylim([0 0.8])
% %% 
% rs1 = calDelayDrum05a - visualDrumAvg05a;
% rs1a = drumLightAvg1a - eyeLightAvg1a;
% rs2 = drumLightAvg2 - eyeLightAvg2;
% rs2a = drumLightAvg2a - eyeLightAvg2a;
% figure()
% t = tiledlayout(2,2);
% t.TileSpacing = 'compact';
% t.Padding = 'tight';
% rsRescale1 = rescale(rs1,0,3);
% rsRescale1 = rsRescale1*-1+max(rsRescale1)
% rsRescale1a = rescale(rs1a,0,3);
% rsRescale1a = rsRescale1a*-1+max(rsRescale1a)
% rsRescale2 = rescale(rs2,0,0.5);
% rsRescale2 = rsRescale2*-1+max(rsRescale2)
% rsRescale2a = rescale(rs2a,0,0.5);
% rsRescale2a = rsRescale2a*-1+max(rsRescale2a)
% nexttile; hold on
% plot(calciumAvg1*100)
% plot(rsRescale1)
% title('Dim')
% ylabel('% \DeltaF/G')
% ylim([0 6])
% legend('Calcium avg.','Retinal slip vel.')
% nexttile; hold on
% plot(calciumAvg2a*100)
% plot(rsRescale2a)
% title('Dim')
% ylim([0 0.8])
% nexttile; hold on
% plot(calciumAvg1a*100)
% plot(rsRescale1a)
% ylabel('% \DeltaF/G')
% xlabel('Time (ms)')
% title('Bright')
% ylim([0 6])
% nexttile; hold on
% plot(calciumAvg2*100)
% plot(rsRescale2)
% title('Bright')
% xlabel('Time (ms)')
% ylim([0 0.8])
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
