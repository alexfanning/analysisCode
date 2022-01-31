
numDarkBlocks = 2;
numVisualBlocks = 60;
numSxsNorm = 2;
numSxsDark = 3;
t = 1;
k = 1;

%% Concatenate data across experiments from same subject (#1)
%extract data from 1st experiment
cd 'E:\FP\data\l7cre2\l7cre2data0916\l7cre2data09166'
sx1 = dir('l7cre2data09166v3.mat');
dataSx1 = load('l7cre2data09166v3');
varNames = fieldnames(dataSx1);

[~, idxCalVisualBlockAvg] = ismember('calVisualBlockAvg', varNames);
[~, idxCalVisualBlockSine] = ismember('calVisualBlockSine', varNames);
[~, idxEyeVelVisualBlockAvg] = ismember('eyeVisualBlockAvg', varNames);
[~, idxEyeVisualBlockSine] = ismember('eyeVisualBlockSine', varNames);
[~, idxRsBlockAvg] = ismember('rsBlockAvg', varNames);
[~, idxRsBlockSine] = ismember('rsBlockSine', varNames);
[~, idxDrumVisualBlockAvg] = ismember('drumVelVisualBlockAvg', varNames);

[~, idxCalVisualBlockAmpAvg] = ismember('calBlockAmp', varNames);
[~, idxCalVisualBlockAmpIdxAvg] = ismember('calBlockAmpIdx', varNames);
[~, idxCalVisualBlockAmpAvgTrough] = ismember('calBlockAmpTrough', varNames);
[~, idxCalVisualBlockAmpIdxAvgTrough] = ismember('calBlockAmpTroughIdx', varNames);

[~, idxCalVisualSineAmpAvg] = ismember('calSineBlockAmp', varNames);
[~, idxCalVisualSineAmpIdxAvg] = ismember('calSineBlockAmpIdx', varNames);
[~, idxCalVisualSineAmpAvgTrough] = ismember('calSineBlockAmpTrough', varNames);
[~, idxCalVisualSineAmpIdxAvgTrough] = ismember('calSineBlockAmpTroughIdx', varNames);

[~, idxEyeVelVisualBlockAmpAvgIpsi] = ismember('eyeIpsiBlockAmp', varNames);
[~, idxEyeVisualBlockAmpIdxAvgIpsi] = ismember('eyeIpsiBlockAmpIdx', varNames);
[~, idxEyeVelVisualBlockAmpAvgContra] = ismember('eyeContraBlockAmp', varNames);
[~, idxEyeVisualBlockAmpIdxAvgContra] = ismember('eyeContraBlockAmpIdx', varNames);

[~, idxEyeVelVisualSineAmpAvgIpsi] = ismember('eyeIpsiSineBlockAmp', varNames);
[~, idxEyeVisualSineAmpIdxAvgIpsi] = ismember('eyeIpsiSineBlockAmpIdx', varNames);
[~, idxEyeVelVisualSineAmpAvgContra] = ismember('eyeContraSineBlockAmp', varNames);
[~, idxEyeVisualSineAmpIdxAvgContra] = ismember('eyeContraSineBlockAmpIdx', varNames);

[~, idxRsBlockAmpAvg] = ismember('rsBlockAmp', varNames);
[~, idxRsBlockAmpIdxAvg] = ismember('rsBlockAmpIdx', varNames);
[~, idxRsSineAmpAvg] = ismember('rsSineBlockAmp', varNames);
[~, idxRsSineAmpIdxAvg] = ismember('rsSineBlockAmpIdx', varNames);

[~, idxDrumVisualBlockAmpAvgContra] = ismember('drumContraBlockAmp', varNames);
[~, idxDrumVisualBlockAmpIdxAvgContra] = ismember('drumContraBlockAmpIdx', varNames);
[~, idxDrumVisualBlockAmpAvgIpsi] = ismember('drumIpsiBlockAmp', varNames);
[~, idxDrumVisualBlockAmpIdxAvgIpsi] = ismember('drumIpsiBlockAmpIdx', varNames);
[~, idxTurntableDarkBlockAvg] = ismember('turntableDarkBlockAvg', varNames);
[~, idxTurntableDarkAvg] = ismember('turntableDarkAvg', varNames);

[~, idxCalPrePost] = ismember('calPrePost', varNames);
[~, idxEyePrePost] = ismember('eyePrePost', varNames);
[~, idxRsPrePost] = ismember('rsPrePost', varNames);

[~, idxCalVisualNorm] = ismember('calVisualNorm', varNames);
[~, idxCalSineVisualNorm] = ismember('calSineVisualNorm', varNames);
[~, idxCalDarkNorm] = ismember('calDarkNorm', varNames);
[~, idxCalDarkSineNorm] = ismember('calSineDarkNorm', varNames);

[~, idxEyeIpsiGainPct] = ismember('eyeIpsiGainPct', varNames);
[~, idxEyeContraGainPct] = ismember('eyeContraGainPct', varNames);

calVisualBlockAvg = cell(numSxsDark,1);
calVisualBlockSine = cell(numSxsDark,1);
eyeVelVisualBlockAvg = cell(numSxsDark,1);
eyeVisualBlockSine = cell(numSxsDark,1);
rsBlockAvg = cell(numSxsDark,1);
rsBlockSine = cell(numSxsDark,1);
drumVisualBlockAvg = cell(numSxsDark,1);

calVisualBlockAmpAvg = cell(numSxsDark,1);
calVisualBlockAmpIdxAvg = cell(numSxsDark,1);
calVisualBlockAmpAvgTrough = cell(numSxsDark,1);
calVisualBlockAmpIdxAvgTrough = cell(numSxsDark,1);
calVisualSineAmpAvg = cell(numSxsDark,1);
calVisualSineAmpIdxAvg = cell(numSxsDark,1);
calVisualSineAmpAvgTrough = cell(numSxsDark,1);
calVisualSineAmpIdxAvgTrough = cell(numSxsDark,1);

eyeVelVisualBlockAmpAvgIpsi = cell(numSxsDark,1);
eyeVisualBlockAmpIdxAvgIpsi = cell(numSxsDark,1);
eyeVelVisualBlockAmpAvgContra = cell(numSxsDark,1);
eyeVisualBlockAmpIdxAvgContra = cell(numSxsDark,1);

eyeVelVisualSineAmpAvgIpsi = cell(numSxsDark,1);
eyeVisualSineAmpIdxAvgIpsi = cell(numSxsDark,1);
eyeVelVisualSineAmpAvgContra = cell(numSxsDark,1);
eyeVisualSineAmpIdxAvgContra = cell(numSxsDark,1);

rsBlockAmpAvg = cell(numSxsDark,1);
rsBlockAmpIdxAvg = cell(numSxsDark,1);
rsSineAmpAvg = cell(numSxsDark,1);
rsSineAmpIdxAvg = cell(numSxsDark,1);

drumVisualBlockAmpAvgIpsi = cell(numSxsDark,1);
drumVisualBlockAmpIdxAvgIpsi = cell(numSxsDark,1);
drumVisualBlockAmpAvgContra = cell(numSxsDark,1);
drumVisualBlockAmpIdxAvgContra = cell(numSxsDark,1);

calPrePost = cell(numSxsDark,1);
eyePrePost = cell(numSxsDark,1);
rsPrePost = cell(numSxsDark,1);

calVisualNorm = cell(numSxsDark,1);
calVisualSineNorm = cell(numSxsDark,1);
calDarkNorm = cell(numSxsDark,1);
calDarkSineNorm = cell(numSxsDark,1);

eyeIpsiGainPct = cell(numSxsDark,1);
eyeContraGainPct = cell(numSxsDark,1);


calVisualBlockAvg{t} = dataSx1.(varNames{idxCalVisualBlockAvg});
calVisualBlockSine{t} = dataSx1.(varNames{idxCalVisualBlockSine});
eyeVelVisualBlockAvg{t} = dataSx1.(varNames{idxEyeVelVisualBlockAvg});
eyeVisualBlockSine{t} = dataSx1.(varNames{idxEyeVisualBlockSine});
rsBlockAvg{t} = dataSx1.(varNames{idxRsBlockAvg});
rsBlockSine{t} = dataSx1.(varNames{idxRsBlockSine});
drumVisualBlockAvg{t} = dataSx1.(varNames{idxDrumVisualBlockAvg});

calVisualBlockAmpAvg{t} = dataSx1.(varNames{idxCalVisualBlockAmpAvg});
calVisualBlockAmpIdxAvg{t} = dataSx1.(varNames{idxCalVisualBlockAmpIdxAvg});
calVisualBlockAmpAvgTrough{t} = dataSx1.(varNames{idxCalVisualBlockAmpAvgTrough});
calVisualBlockAmpIdxAvgTrough{t} = dataSx1.(varNames{idxCalVisualBlockAmpIdxAvgTrough});

calVisualSineAmpAvg{t} = dataSx1.(varNames{idxCalVisualSineAmpAvg});
calVisualSineAmpIdxAvg{t} = dataSx1.(varNames{idxCalVisualSineAmpIdxAvg});
calVisualSineAmpAvgTrough{t} = dataSx1.(varNames{idxCalVisualSineAmpAvgTrough});
calVisualSineAmpIdxAvgTrough{t} = dataSx1.(varNames{idxCalVisualSineAmpIdxAvgTrough});

eyeVelVisualBlockAmpAvgIpsi{t} = dataSx1.(varNames{idxEyeVelVisualBlockAmpAvgIpsi});
eyeVisualBlockAmpIdxAvgIpsi{t} = dataSx1.(varNames{idxEyeVisualBlockAmpIdxAvgIpsi});
eyeVelVisualBlockAmpAvgContra{t} = dataSx1.(varNames{idxEyeVelVisualBlockAmpAvgContra});
eyeVisualBlockAmpIdxAvgContra{t} = dataSx1.(varNames{idxEyeVisualBlockAmpIdxAvgContra});

eyeVelVisualSineAmpAvgIpsi{t} = dataSx1.(varNames{idxEyeVelVisualSineAmpAvgIpsi});
eyeVisualSineAmpIdxAvgIpsi{t} = dataSx1.(varNames{idxEyeVisualSineAmpIdxAvgIpsi});
eyeVelVisualSineAmpAvgContra{t} = dataSx1.(varNames{idxEyeVelVisualSineAmpAvgContra});
eyeVisualSineAmpIdxAvgContra{t} = dataSx1.(varNames{idxEyeVisualSineAmpIdxAvgContra});

rsBlockAmpAvg{t} = dataSx1.(varNames{idxRsBlockAmpAvg});
rsBlockAmpIdxAvg{t} = dataSx1.(varNames{idxRsBlockAmpIdxAvg});
rsSineAmpAvg{t} = dataSx1.(varNames{idxRsSineAmpAvg});
rsSineAmpIdxAvg{t} = dataSx1.(varNames{idxRsSineAmpIdxAvg});

drumVisualBlockAmpAvgIpsi{t} = dataSx1.(varNames{idxDrumVisualBlockAmpAvgIpsi});
drumVisualBlockAmpIdxAvgIpsi{t} = dataSx1.(varNames{idxDrumVisualBlockAmpIdxAvgIpsi});
drumVisualBlockAmpAvgContra{t} = dataSx1.(varNames{idxDrumVisualBlockAmpAvgContra});
drumVisualBlockAmpIdxAvgContra{t} = dataSx1.(varNames{idxDrumVisualBlockAmpIdxAvgContra});
turntableDarkBlockAvg{t,k} = dataSx1.(varNames{idxTurntableDarkBlockAvg});
turntableDarkAvg{t,k} = dataSx1.(varNames{idxTurntableDarkAvg});

calPrePost{t} = dataSx1.(varNames{idxCalPrePost});
eyePrePost{t} = dataSx1.(varNames{idxEyePrePost});
rsPrePost{t} = dataSx1.(varNames{idxRsPrePost});

calVisualNorm{t} = dataSx1.(varNames{idxCalVisualNorm});
calVisualSineNorm{t} = dataSx1.(varNames{idxCalSineVisualNorm});
calDarkNorm{t} = dataSx1.(varNames{idxCalDarkNorm});
calDarkSineNorm{t} = dataSx1.(varNames{idxCalDarkSineNorm});

eyeIpsiGainPct{t} = dataSx1.(varNames{idxEyeIpsiGainPct});
eyeContraGainPct{t} = dataSx1.(varNames{idxEyeContraGainPct});

%% extract data from 2nd normal-reared subject
cd 'E:\FP\data\SMCS5\data111919\data11194'
sx2 = dir('smcs5data11194v2.mat');
dataSx2 = load('smcs5data11194v2');
varNames = fieldnames(dataSx2);
t = t + 1;

[~, idxCalVisualBlockAvg] = ismember('calVisualBlockAvg', varNames);
[~, idxCalVisualBlockSine] = ismember('calVisualBlockSine', varNames);
[~, idxEyeVelVisualBlockAvg] = ismember('eyeVisualBlockAvg', varNames);
[~, idxEyeVisualBlockSine] = ismember('eyeVisualBlockSine', varNames);
[~, idxRsBlockAvg] = ismember('rsBlockAvg', varNames);
[~, idxRsBlockSine] = ismember('rsBlockSine', varNames);
[~, idxDrumVisualBlockAvg] = ismember('drumVelVisualBlockAvg', varNames);

[~, idxCalVisualBlockAmpAvg] = ismember('calBlockAmp', varNames);
[~, idxCalVisualBlockAmpIdxAvg] = ismember('calBlockAmpIdx', varNames);
[~, idxCalVisualBlockAmpAvgTrough] = ismember('calBlockAmpTrough', varNames);
[~, idxCalVisualBlockAmpIdxAvgTrough] = ismember('calBlockAmpTroughIdx', varNames);

[~, idxCalVisualSineAmpAvg] = ismember('calSineBlockAmp', varNames);
[~, idxCalVisualSineAmpIdxAvg] = ismember('calSineBlockAmpIdx', varNames);
[~, idxCalVisualSineAmpAvgTrough] = ismember('calSineBlockAmpTrough', varNames);
[~, idxCalVisualSineAmpIdxAvgTrough] = ismember('calSineBlockAmpTroughIdx', varNames);

[~, idxEyeVelVisualBlockAmpAvgIpsi] = ismember('eyeIpsiBlockAmp', varNames);
[~, idxEyeVisualBlockAmpIdxAvgIpsi] = ismember('eyeIpsiBlockAmpIdx', varNames);
[~, idxEyeVelVisualBlockAmpAvgContra] = ismember('eyeContraBlockAmp', varNames);
[~, idxEyeVisualBlockAmpIdxAvgContra] = ismember('eyeContraBlockAmpIdx', varNames);

[~, idxEyeVelVisualSineAmpAvgIpsi] = ismember('eyeIpsiSineBlockAmp', varNames);
[~, idxEyeVisualSineAmpIdxAvgIpsi] = ismember('eyeIpsiSineBlockAmpIdx', varNames);
[~, idxEyeVelVisualSineAmpAvgContra] = ismember('eyeContraSineBlockAmp', varNames);
[~, idxEyeVisualSineAmpIdxAvgContra] = ismember('eyeContraSineBlockAmpIdx', varNames);

[~, idxRsBlockAmpAvg] = ismember('rsBlockAmp', varNames);
[~, idxRsBlockAmpIdxAvg] = ismember('rsBlockAmpIdx', varNames);
[~, idxRsSineAmpAvg] = ismember('rsSineBlockAmp', varNames);
[~, idxRsSineAmpIdxAvg] = ismember('rsSineBlockAmpIdx', varNames);

[~, idxDrumVisualBlockAmpAvgContra] = ismember('drumContraBlockAmp', varNames);
[~, idxDrumVisualBlockAmpIdxAvgContra] = ismember('drumContraBlockAmpIdx', varNames);
[~, idxDrumVisualBlockAmpAvgIpsi] = ismember('drumIpsiBlockAmp', varNames);
[~, idxDrumVisualBlockAmpIdxAvgIpsi] = ismember('drumIpsiBlockAmpIdx', varNames);
[~, idxTurntableDarkBlockAvg] = ismember('turntableDarkBlockAvg', varNames);
[~, idxTurntableDarkAvg] = ismember('turntableDarkAvg', varNames);

[~, idxCalPrePost] = ismember('calPrePost', varNames);
[~, idxEyePrePost] = ismember('eyePrePost', varNames);
[~, idxRsPrePost] = ismember('rsPrePost', varNames);

[~, idxCalVisualNorm] = ismember('calVisualNorm', varNames);
[~, idxCalSineVisualNorm] = ismember('calSineVisualNorm', varNames);
[~, idxCalDarkNorm] = ismember('calDarkNorm', varNames);
[~, idxCalDarkSineNorm] = ismember('calSineDarkNorm', varNames);

[~, idxEyeIpsiGainPct] = ismember('eyeIpsiGainPct', varNames);
[~, idxEyeContraGainPct] = ismember('eyeContraGainPct', varNames);

calVisualBlockAvg{t,k} = dataSx2.(varNames{idxCalVisualBlockAvg});
calVisualBlockSine{t,k} = dataSx2.(varNames{idxCalVisualBlockSine});
eyeVelVisualBlockAvg{t,k} = dataSx2.(varNames{idxEyeVelVisualBlockAvg});
eyeVisualBlockSine{t,k} = dataSx2.(varNames{idxEyeVisualBlockSine});
rsBlockAvg{t,k} = dataSx2.(varNames{idxRsBlockAvg});
rsBlockSine{t,k} = dataSx2.(varNames{idxRsBlockSine});
drumVisualBlockAvg{t,k} = dataSx2.(varNames{idxDrumVisualBlockAvg});

calVisualBlockAmpAvg{t,k} = dataSx2.(varNames{idxCalVisualBlockAmpAvg});
calVisualBlockAmpIdxAvg{t,k} = dataSx2.(varNames{idxCalVisualBlockAmpIdxAvg});
calVisualBlockAmpAvgTrough{t,k} = dataSx2.(varNames{idxCalVisualBlockAmpAvgTrough});
calVisualBlockAmpIdxAvgTrough{t,k} = dataSx2.(varNames{idxCalVisualBlockAmpIdxAvgTrough});

calVisualSineAmpAvg{t,k} = dataSx2.(varNames{idxCalVisualSineAmpAvg});
calVisualSineAmpIdxAvg{t,k} = dataSx2.(varNames{idxCalVisualSineAmpIdxAvg});
calVisualSineAmpAvgTrough{t,k} = dataSx2.(varNames{idxCalVisualSineAmpAvgTrough});
calVisualSineAmpIdxAvgTrough{t,k} = dataSx2.(varNames{idxCalVisualSineAmpIdxAvgTrough});

eyeVelVisualBlockAmpAvgIpsi{t,k} = dataSx2.(varNames{idxEyeVelVisualBlockAmpAvgIpsi});
eyeVisualBlockAmpIdxAvgIpsi{t,k} = dataSx2.(varNames{idxEyeVisualBlockAmpIdxAvgIpsi});
eyeVelVisualBlockAmpAvgContra{t,k} = dataSx2.(varNames{idxEyeVelVisualBlockAmpAvgContra});
eyeVisualBlockAmpIdxAvgContra{t,k} = dataSx2.(varNames{idxEyeVisualBlockAmpIdxAvgContra});

eyeVelVisualSineAmpAvgIpsi{t,k} = dataSx2.(varNames{idxEyeVelVisualSineAmpAvgIpsi});
eyeVisualSineAmpIdxAvgIpsi{t,k} = dataSx2.(varNames{idxEyeVisualSineAmpIdxAvgIpsi});
eyeVelVisualSineAmpAvgContra{t,k} = dataSx2.(varNames{idxEyeVelVisualSineAmpAvgContra});
eyeVisualSineAmpIdxAvgContra{t,k} = dataSx2.(varNames{idxEyeVisualSineAmpIdxAvgContra});

rsBlockAmpAvg{t,k} = dataSx2.(varNames{idxRsBlockAmpAvg});
rsBlockAmpIdxAvg{t,k} = dataSx2.(varNames{idxRsBlockAmpIdxAvg});
rsSineAmpAvg{t,k} = dataSx2.(varNames{idxRsSineAmpAvg});
rsSineAmpIdxAvg{t,k} = dataSx2.(varNames{idxRsSineAmpIdxAvg});

drumVisualBlockAmpAvgIpsi{t,k} = dataSx2.(varNames{idxDrumVisualBlockAmpAvgIpsi});
drumVisualBlockAmpIdxAvgIpsi{t,k} = dataSx2.(varNames{idxDrumVisualBlockAmpIdxAvgIpsi});
drumVisualBlockAmpAvgContra{t,k} = dataSx2.(varNames{idxDrumVisualBlockAmpAvgContra});
drumVisualBlockAmpIdxAvgContra{t,k} = dataSx2.(varNames{idxDrumVisualBlockAmpIdxAvgContra});
turntableDarkBlockAvg{t,k} = dataSx2.(varNames{idxTurntableDarkBlockAvg});
turntableDarkAvg{t,k} = dataSx2.(varNames{idxTurntableDarkAvg});

calPrePost{t,k} = dataSx2.(varNames{idxCalPrePost});
eyePrePost{t,k} = dataSx2.(varNames{idxEyePrePost});
rsPrePost{t,k} = dataSx2.(varNames{idxRsPrePost});

calVisualNorm{t,k} = dataSx2.(varNames{idxCalVisualNorm});
calVisualSineNorm{t,k} = dataSx2.(varNames{idxCalSineVisualNorm});
calDarkNorm{t,k} = dataSx2.(varNames{idxCalDarkNorm});
calDarkSineNorm{t,k} = dataSx2.(varNames{idxCalDarkSineNorm});

eyeIpsiGainPct{t,k} = dataSx2.(varNames{idxEyeIpsiGainPct});
eyeContraGainPct{t,k} = dataSx2.(varNames{idxEyeContraGainPct});

%% Extract data from 1st dark-reared subject
cd 'E:\FP\data\l7cre8\l7cre8data0824'
sx3 = dir('l7cre8data08245v2.mat');
dataSx3 = load('l7cre8data08245v2');
varNames = fieldnames(dataSx3);
t = 1;
k = 2;

[~, idxCalVisualBlockAvg] = ismember('calVisualBlockAvg', varNames);
[~, idxCalVisualBlockSine] = ismember('calVisualBlockSine', varNames);
[~, idxEyeVelVisualBlockAvg] = ismember('eyeVisualBlockAvg', varNames);
[~, idxEyeVisualBlockSine] = ismember('eyeVisualBlockSine', varNames);
[~, idxRsBlockAvg] = ismember('rsBlockAvg', varNames);
[~, idxRsBlockSine] = ismember('rsBlockSine', varNames);
[~, idxDrumVisualBlockAvg] = ismember('drumVelVisualBlockAvg', varNames);

[~, idxCalVisualBlockAmpAvg] = ismember('calBlockAmp', varNames);
[~, idxCalVisualBlockAmpIdxAvg] = ismember('calBlockAmpIdx', varNames);
[~, idxCalVisualBlockAmpAvgTrough] = ismember('calBlockAmpTrough', varNames);
[~, idxCalVisualBlockAmpIdxAvgTrough] = ismember('calBlockAmpTroughIdx', varNames);

[~, idxCalVisualSineAmpAvg] = ismember('calSineBlockAmp', varNames);
[~, idxCalVisualSineAmpIdxAvg] = ismember('calSineBlockAmpIdx', varNames);
[~, idxCalVisualSineAmpAvgTrough] = ismember('calSineBlockAmpTrough', varNames);
[~, idxCalVisualSineAmpIdxAvgTrough] = ismember('calSineBlockAmpTroughIdx', varNames);

[~, idxEyeVelVisualBlockAmpAvgIpsi] = ismember('eyeIpsiBlockAmp', varNames);
[~, idxEyeVisualBlockAmpIdxAvgIpsi] = ismember('eyeIpsiBlockAmpIdx', varNames);
[~, idxEyeVelVisualBlockAmpAvgContra] = ismember('eyeContraBlockAmp', varNames);
[~, idxEyeVisualBlockAmpIdxAvgContra] = ismember('eyeContraBlockAmpIdx', varNames);

[~, idxEyeVelVisualSineAmpAvgIpsi] = ismember('eyeIpsiSineBlockAmp', varNames);
[~, idxEyeVisualSineAmpIdxAvgIpsi] = ismember('eyeIpsiSineBlockAmpIdx', varNames);
[~, idxEyeVelVisualSineAmpAvgContra] = ismember('eyeContraSineBlockAmp', varNames);
[~, idxEyeVisualSineAmpIdxAvgContra] = ismember('eyeContraSineBlockAmpIdx', varNames);

[~, idxRsBlockAmpAvg] = ismember('rsBlockAmp', varNames);
[~, idxRsBlockAmpIdxAvg] = ismember('rsBlockAmpIdx', varNames);
[~, idxRsSineAmpAvg] = ismember('rsSineBlockAmp', varNames);
[~, idxRsSineAmpIdxAvg] = ismember('rsSineBlockAmpIdx', varNames);

[~, idxDrumVisualBlockAmpAvgContra] = ismember('drumContraBlockAmp', varNames);
[~, idxDrumVisualBlockAmpIdxAvgContra] = ismember('drumContraBlockAmpIdx', varNames);
[~, idxDrumVisualBlockAmpAvgIpsi] = ismember('drumIpsiBlockAmp', varNames);
[~, idxDrumVisualBlockAmpIdxAvgIpsi] = ismember('drumIpsiBlockAmpIdx', varNames);
[~, idxTurntableDarkBlockAvg] = ismember('turntableDarkBlockAvg', varNames);
[~, idxTurntableDarkAvg] = ismember('turntableDarkAvg', varNames);

[~, idxCalPrePost] = ismember('calPrePost', varNames);
[~, idxEyePrePost] = ismember('eyePrePost', varNames);
[~, idxRsPrePost] = ismember('rsPrePost', varNames);

[~, idxCalVisualNorm] = ismember('calVisualNorm', varNames);
[~, idxCalSineVisualNorm] = ismember('calSineVisualNorm', varNames);
[~, idxCalDarkNorm] = ismember('calDarkNorm', varNames);
[~, idxCalDarkSineNorm] = ismember('calSineDarkNorm', varNames);

[~, idxEyeIpsiGainPct] = ismember('eyeIpsiGainPct', varNames);
[~, idxEyeContraGainPct] = ismember('eyeContraGainPct', varNames);

calVisualBlockAvg{t,k} = dataSx3.(varNames{idxCalVisualBlockAvg});
calVisualBlockSine{t,k} = dataSx3.(varNames{idxCalVisualBlockSine});
eyeVelVisualBlockAvg{t,k} = dataSx3.(varNames{idxEyeVelVisualBlockAvg});
eyeVisualBlockSine{t,k} = dataSx3.(varNames{idxEyeVisualBlockSine});
rsBlockAvg{t,k} = dataSx3.(varNames{idxRsBlockAvg});
rsBlockSine{t,k} = dataSx3.(varNames{idxRsBlockSine});
drumVisualBlockAvg{t,k} = dataSx3.(varNames{idxDrumVisualBlockAvg});

calVisualBlockAmpAvg{t,k} = dataSx3.(varNames{idxCalVisualBlockAmpAvg});
calVisualBlockAmpIdxAvg{t,k} = dataSx3.(varNames{idxCalVisualBlockAmpIdxAvg});
calVisualBlockAmpAvgTrough{t,k} = dataSx3.(varNames{idxCalVisualBlockAmpAvgTrough});
calVisualBlockAmpIdxAvgTrough{t,k} = dataSx3.(varNames{idxCalVisualBlockAmpIdxAvgTrough});

calVisualSineAmpAvg{t,k} = dataSx3.(varNames{idxCalVisualSineAmpAvg});
calVisualSineAmpIdxAvg{t,k} = dataSx3.(varNames{idxCalVisualSineAmpIdxAvg});
calVisualSineAmpAvgTrough{t,k} = dataSx3.(varNames{idxCalVisualSineAmpAvgTrough});
calVisualSineAmpIdxAvgTrough{t,k} = dataSx3.(varNames{idxCalVisualSineAmpIdxAvgTrough});

eyeVelVisualBlockAmpAvgIpsi{t,k} = dataSx3.(varNames{idxEyeVelVisualBlockAmpAvgIpsi});
eyeVisualBlockAmpIdxAvgIpsi{t,k} = dataSx3.(varNames{idxEyeVisualBlockAmpIdxAvgIpsi});
eyeVelVisualBlockAmpAvgContra{t,k} = dataSx3.(varNames{idxEyeVelVisualBlockAmpAvgContra});
eyeVisualBlockAmpIdxAvgContra{t,k} = dataSx3.(varNames{idxEyeVisualBlockAmpIdxAvgContra});

eyeVelVisualSineAmpAvgIpsi{t,k} = dataSx3.(varNames{idxEyeVelVisualSineAmpAvgIpsi});
eyeVisualSineAmpIdxAvgIpsi{t,k} = dataSx3.(varNames{idxEyeVisualSineAmpIdxAvgIpsi});
eyeVelVisualSineAmpAvgContra{t,k} = dataSx3.(varNames{idxEyeVelVisualSineAmpAvgContra});
eyeVisualSineAmpIdxAvgContra{t,k} = dataSx3.(varNames{idxEyeVisualSineAmpIdxAvgContra});

rsBlockAmpAvg{t,k} = dataSx3.(varNames{idxRsBlockAmpAvg});
rsBlockAmpIdxAvg{t,k} = dataSx3.(varNames{idxRsBlockAmpIdxAvg});
rsSineAmpAvg{t,k} = dataSx3.(varNames{idxRsSineAmpAvg});
rsSineAmpIdxAvg{t,k} = dataSx3.(varNames{idxRsSineAmpIdxAvg});

drumVisualBlockAmpAvgIpsi{t,k} = dataSx3.(varNames{idxDrumVisualBlockAmpAvgIpsi});
drumVisualBlockAmpIdxAvgIpsi{t,k} = dataSx3.(varNames{idxDrumVisualBlockAmpIdxAvgIpsi});
drumVisualBlockAmpAvgContra{t,k} = dataSx3.(varNames{idxDrumVisualBlockAmpAvgContra});
drumVisualBlockAmpIdxAvgContra{t,k} = dataSx3.(varNames{idxDrumVisualBlockAmpIdxAvgContra});
turntableDarkBlockAvg{t,k} = dataSx3.(varNames{idxTurntableDarkBlockAvg});
turntableDarkAvg{t,k} = dataSx3.(varNames{idxTurntableDarkAvg});

calPrePost{t,k} = dataSx3.(varNames{idxCalPrePost});
eyePrePost{t,k} = dataSx3.(varNames{idxEyePrePost});
rsPrePost{t,k} = dataSx3.(varNames{idxRsPrePost});

calVisualNorm{t,k} = dataSx3.(varNames{idxCalVisualNorm});
calVisualSineNorm{t,k} = dataSx3.(varNames{idxCalSineVisualNorm});
calDarkNorm{t,k} = dataSx3.(varNames{idxCalDarkNorm});
calDarkSineNorm{t,k} = dataSx3.(varNames{idxCalDarkSineNorm});

eyeIpsiGainPct{t,k} = dataSx3.(varNames{idxEyeIpsiGainPct});
eyeContraGainPct{t,k} = dataSx3.(varNames{idxEyeContraGainPct});

%% extract data from 2nd dark-reared subject
cd 'E:\FP\data\l7cre8\l7cre8data0831'
sx4 = dir('l7cre8data08313v2.mat');
dataSx4 = load('l7cre8data08313v2');
varNames = fieldnames(dataSx4);
t = t + 1;

[~, idxCalVisualBlockAvg] = ismember('calVisualBlockAvg', varNames);
[~, idxCalVisualBlockSine] = ismember('calVisualBlockSine', varNames);
[~, idxEyeVelVisualBlockAvg] = ismember('eyeVisualBlockAvg', varNames);
[~, idxEyeVisualBlockSine] = ismember('eyeVisualBlockSine', varNames);
[~, idxRsBlockAvg] = ismember('rsBlockAvg', varNames);
[~, idxRsBlockSine] = ismember('rsBlockSine', varNames);
[~, idxDrumVisualBlockAvg] = ismember('drumVelVisualBlockAvg', varNames);

[~, idxCalVisualBlockAmpAvg] = ismember('calBlockAmp', varNames);
[~, idxCalVisualBlockAmpIdxAvg] = ismember('calBlockAmpIdx', varNames);
[~, idxCalVisualBlockAmpAvgTrough] = ismember('calBlockAmpTrough', varNames);
[~, idxCalVisualBlockAmpIdxAvgTrough] = ismember('calBlockAmpTroughIdx', varNames);

[~, idxCalVisualSineAmpAvg] = ismember('calSineBlockAmp', varNames);
[~, idxCalVisualSineAmpIdxAvg] = ismember('calSineBlockAmpIdx', varNames);
[~, idxCalVisualSineAmpAvgTrough] = ismember('calSineBlockAmpTrough', varNames);
[~, idxCalVisualSineAmpIdxAvgTrough] = ismember('calSineBlockAmpTroughIdx', varNames);

[~, idxEyeVelVisualBlockAmpAvgIpsi] = ismember('eyeIpsiBlockAmp', varNames);
[~, idxEyeVisualBlockAmpIdxAvgIpsi] = ismember('eyeIpsiBlockAmpIdx', varNames);
[~, idxEyeVelVisualBlockAmpAvgContra] = ismember('eyeContraBlockAmp', varNames);
[~, idxEyeVisualBlockAmpIdxAvgContra] = ismember('eyeContraBlockAmpIdx', varNames);

[~, idxEyeVelVisualSineAmpAvgIpsi] = ismember('eyeIpsiSineBlockAmp', varNames);
[~, idxEyeVisualSineAmpIdxAvgIpsi] = ismember('eyeIpsiSineBlockAmpIdx', varNames);
[~, idxEyeVelVisualSineAmpAvgContra] = ismember('eyeContraSineBlockAmp', varNames);
[~, idxEyeVisualSineAmpIdxAvgContra] = ismember('eyeContraSineBlockAmpIdx', varNames);

[~, idxRsBlockAmpAvg] = ismember('rsBlockAmp', varNames);
[~, idxRsBlockAmpIdxAvg] = ismember('rsBlockAmpIdx', varNames);
[~, idxRsSineAmpAvg] = ismember('rsSineBlockAmp', varNames);
[~, idxRsSineAmpIdxAvg] = ismember('rsSineBlockAmpIdx', varNames);

[~, idxDrumVisualBlockAmpAvgContra] = ismember('drumContraBlockAmp', varNames);
[~, idxDrumVisualBlockAmpIdxAvgContra] = ismember('drumContraBlockAmpIdx', varNames);
[~, idxDrumVisualBlockAmpAvgIpsi] = ismember('drumIpsiBlockAmp', varNames);
[~, idxDrumVisualBlockAmpIdxAvgIpsi] = ismember('drumIpsiBlockAmpIdx', varNames);
[~, idxTurntableDarkBlockAvg] = ismember('turntableDarkBlockAvg', varNames);
[~, idxTurntableDarkAvg] = ismember('turntableDarkAvg', varNames);

[~, idxCalPrePost] = ismember('calPrePost', varNames);
[~, idxEyePrePost] = ismember('eyePrePost', varNames);
[~, idxRsPrePost] = ismember('rsPrePost', varNames);

[~, idxCalVisualNorm] = ismember('calVisualNorm', varNames);
[~, idxCalSineVisualNorm] = ismember('calSineVisualNorm', varNames);
[~, idxCalDarkNorm] = ismember('calDarkNorm', varNames);
[~, idxCalDarkSineNorm] = ismember('calSineDarkNorm', varNames);

[~, idxEyeIpsiGainPct] = ismember('eyeIpsiGainPct', varNames);
[~, idxEyeContraGainPct] = ismember('eyeContraGainPct', varNames);

calVisualBlockAvg{t,k} = dataSx4.(varNames{idxCalVisualBlockAvg});
calVisualBlockSine{t,k} = dataSx4.(varNames{idxCalVisualBlockSine});
eyeVelVisualBlockAvg{t,k} = dataSx4.(varNames{idxEyeVelVisualBlockAvg});
eyeVisualBlockSine{t,k} = dataSx4.(varNames{idxEyeVisualBlockSine});
rsBlockAvg{t,k} = dataSx4.(varNames{idxRsBlockAvg});
rsBlockSine{t,k} = dataSx4.(varNames{idxRsBlockSine});
drumVisualBlockAvg{t,k} = dataSx4.(varNames{idxDrumVisualBlockAvg});

calVisualBlockAmpAvg{t,k} = dataSx4.(varNames{idxCalVisualBlockAmpAvg});
calVisualBlockAmpIdxAvg{t,k} = dataSx4.(varNames{idxCalVisualBlockAmpIdxAvg});
calVisualBlockAmpAvgTrough{t,k} = dataSx4.(varNames{idxCalVisualBlockAmpAvgTrough});
calVisualBlockAmpIdxAvgTrough{t,k} = dataSx4.(varNames{idxCalVisualBlockAmpIdxAvgTrough});

calVisualSineAmpAvg{t,k} = dataSx4.(varNames{idxCalVisualSineAmpAvg});
calVisualSineAmpIdxAvg{t,k} = dataSx4.(varNames{idxCalVisualSineAmpIdxAvg});
calVisualSineAmpAvgTrough{t,k} = dataSx4.(varNames{idxCalVisualSineAmpAvgTrough});
calVisualSineAmpIdxAvgTrough{t,k} = dataSx4.(varNames{idxCalVisualSineAmpIdxAvgTrough});

eyeVelVisualBlockAmpAvgIpsi{t,k} = dataSx4.(varNames{idxEyeVelVisualBlockAmpAvgIpsi});
eyeVisualBlockAmpIdxAvgIpsi{t,k} = dataSx4.(varNames{idxEyeVisualBlockAmpIdxAvgIpsi});
eyeVelVisualBlockAmpAvgContra{t,k} = dataSx4.(varNames{idxEyeVelVisualBlockAmpAvgContra});
eyeVisualBlockAmpIdxAvgContra{t,k} = dataSx4.(varNames{idxEyeVisualBlockAmpIdxAvgContra});

eyeVelVisualSineAmpAvgIpsi{t,k} = dataSx4.(varNames{idxEyeVelVisualSineAmpAvgIpsi});
eyeVisualSineAmpIdxAvgIpsi{t,k} = dataSx4.(varNames{idxEyeVisualSineAmpIdxAvgIpsi});
eyeVelVisualSineAmpAvgContra{t,k} = dataSx4.(varNames{idxEyeVelVisualSineAmpAvgContra});
eyeVisualSineAmpIdxAvgContra{t,k} = dataSx4.(varNames{idxEyeVisualSineAmpIdxAvgContra});

rsBlockAmpAvg{t,k} = dataSx4.(varNames{idxRsBlockAmpAvg});
rsBlockAmpIdxAvg{t,k} = dataSx4.(varNames{idxRsBlockAmpIdxAvg});
rsSineAmpAvg{t,k} = dataSx4.(varNames{idxRsSineAmpAvg});
rsSineAmpIdxAvg{t,k} = dataSx4.(varNames{idxRsSineAmpIdxAvg});

drumVisualBlockAmpAvgIpsi{t,k} = dataSx4.(varNames{idxDrumVisualBlockAmpAvgIpsi});
drumVisualBlockAmpIdxAvgIpsi{t,k} = dataSx4.(varNames{idxDrumVisualBlockAmpIdxAvgIpsi});
drumVisualBlockAmpAvgContra{t,k} = dataSx4.(varNames{idxDrumVisualBlockAmpAvgContra});
drumVisualBlockAmpIdxAvgContra{t,k} = dataSx4.(varNames{idxDrumVisualBlockAmpIdxAvgContra});
turntableDarkBlockAvg{t,k} = dataSx4.(varNames{idxTurntableDarkBlockAvg});
turntableDarkAvg{t,k} = dataSx4.(varNames{idxTurntableDarkAvg});

calPrePost{t,k} = dataSx4.(varNames{idxCalPrePost});
eyePrePost{t,k} = dataSx4.(varNames{idxEyePrePost});
rsPrePost{t,k} = dataSx4.(varNames{idxRsPrePost});

calVisualNorm{t,k} = dataSx4.(varNames{idxCalVisualNorm});
calVisualSineNorm{t,k} = dataSx4.(varNames{idxCalSineVisualNorm});
calDarkNorm{t,k} = dataSx4.(varNames{idxCalDarkNorm});
calDarkSineNorm{t,k} = dataSx4.(varNames{idxCalDarkSineNorm});

eyeIpsiGainPct{t,k} = dataSx4.(varNames{idxEyeIpsiGainPct});
eyeContraGainPct{t,k} = dataSx4.(varNames{idxEyeContraGainPct});

%% extract data from 3rd dark-reared subject
cd 'E:\FP\data\l7cre11\l7cre11data0907'
sx5 = dir('l7cre11data09077v4.mat');
dataSx5 = load('l7cre11data09077v4');
varNames = fieldnames(dataSx5);
t = t + 1;

[~, idxCalVisualBlockAvg] = ismember('calVisualBlockAvg', varNames);
[~, idxCalVisualBlockSine] = ismember('calVisualBlockSine', varNames);
[~, idxEyeVelVisualBlockAvg] = ismember('eyeVisualBlockAvg', varNames);
[~, idxEyeVisualBlockSine] = ismember('eyeVisualBlockSine', varNames);
[~, idxRsBlockAvg] = ismember('rsBlockAvg', varNames);
[~, idxRsBlockSine] = ismember('rsBlockSine', varNames);
[~, idxDrumVisualBlockAvg] = ismember('drumVelVisualBlockAvg', varNames);

[~, idxCalVisualBlockAmpAvg] = ismember('calBlockAmp', varNames);
[~, idxCalVisualBlockAmpIdxAvg] = ismember('calBlockAmpIdx', varNames);
[~, idxCalVisualBlockAmpAvgTrough] = ismember('calBlockAmpTrough', varNames);
[~, idxCalVisualBlockAmpIdxAvgTrough] = ismember('calBlockAmpTroughIdx', varNames);

[~, idxCalVisualSineAmpAvg] = ismember('calSineBlockAmp', varNames);
[~, idxCalVisualSineAmpIdxAvg] = ismember('calSineBlockAmpIdx', varNames);
[~, idxCalVisualSineAmpAvgTrough] = ismember('calSineBlockAmpTrough', varNames);
[~, idxCalVisualSineAmpIdxAvgTrough] = ismember('calSineBlockAmpTroughIdx', varNames);

[~, idxEyeVelVisualBlockAmpAvgIpsi] = ismember('eyeIpsiBlockAmp', varNames);
[~, idxEyeVisualBlockAmpIdxAvgIpsi] = ismember('eyeIpsiBlockAmpIdx', varNames);
[~, idxEyeVelVisualBlockAmpAvgContra] = ismember('eyeContraBlockAmp', varNames);
[~, idxEyeVisualBlockAmpIdxAvgContra] = ismember('eyeContraBlockAmpIdx', varNames);

[~, idxEyeVelVisualSineAmpAvgIpsi] = ismember('eyeIpsiSineBlockAmp', varNames);
[~, idxEyeVisualSineAmpIdxAvgIpsi] = ismember('eyeIpsiSineBlockAmpIdx', varNames);
[~, idxEyeVelVisualSineAmpAvgContra] = ismember('eyeContraSineBlockAmp', varNames);
[~, idxEyeVisualSineAmpIdxAvgContra] = ismember('eyeContraSineBlockAmpIdx', varNames);

[~, idxRsBlockAmpAvg] = ismember('rsBlockAmp', varNames);
[~, idxRsBlockAmpIdxAvg] = ismember('rsBlockAmpIdx', varNames);
[~, idxRsSineAmpAvg] = ismember('rsSineBlockAmp', varNames);
[~, idxRsSineAmpIdxAvg] = ismember('rsSineBlockAmpIdx', varNames);

[~, idxDrumVisualBlockAmpAvgContra] = ismember('drumContraBlockAmp', varNames);
[~, idxDrumVisualBlockAmpIdxAvgContra] = ismember('drumContraBlockAmpIdx', varNames);
[~, idxDrumVisualBlockAmpAvgIpsi] = ismember('drumIpsiBlockAmp', varNames);
[~, idxDrumVisualBlockAmpIdxAvgIpsi] = ismember('drumIpsiBlockAmpIdx', varNames);
[~, idxTurntableDarkBlockAvg] = ismember('turntableDarkBlockAvg', varNames);
[~, idxTurntableDarkAvg] = ismember('turntableDarkAvg', varNames);

[~, idxCalPrePost] = ismember('calPrePost', varNames);
[~, idxEyePrePost] = ismember('eyePrePost', varNames);
[~, idxRsPrePost] = ismember('rsPrePost', varNames);

[~, idxCalVisualNorm] = ismember('calVisualNorm', varNames);
[~, idxCalSineVisualNorm] = ismember('calSineVisualNorm', varNames);
[~, idxCalDarkNorm] = ismember('calDarkNorm', varNames);
[~, idxCalDarkSineNorm] = ismember('calSineDarkNorm', varNames);

[~, idxEyeIpsiGainPct] = ismember('eyeIpsiGainPct', varNames);
[~, idxEyeContraGainPct] = ismember('eyeContraGainPct', varNames);

calVisualBlockAvg{t,k} = dataSx5.(varNames{idxCalVisualBlockAvg});
calVisualBlockSine{t,k} = dataSx5.(varNames{idxCalVisualBlockSine});
eyeVelVisualBlockAvg{t,k} = dataSx5.(varNames{idxEyeVelVisualBlockAvg});
eyeVisualBlockSine{t,k} = dataSx5.(varNames{idxEyeVisualBlockSine});
rsBlockAvg{t,k} = dataSx5.(varNames{idxRsBlockAvg});
rsBlockSine{t,k} = dataSx5.(varNames{idxRsBlockSine});
drumVisualBlockAvg{t,k} = dataSx5.(varNames{idxDrumVisualBlockAvg});

calVisualBlockAmpAvg{t,k} = dataSx5.(varNames{idxCalVisualBlockAmpAvg});
calVisualBlockAmpIdxAvg{t,k} = dataSx5.(varNames{idxCalVisualBlockAmpIdxAvg});
calVisualBlockAmpAvgTrough{t,k} = dataSx5.(varNames{idxCalVisualBlockAmpAvgTrough});
calVisualBlockAmpIdxAvgTrough{t,k} = dataSx5.(varNames{idxCalVisualBlockAmpIdxAvgTrough});

calVisualSineAmpAvg{t,k} = dataSx5.(varNames{idxCalVisualSineAmpAvg});
calVisualSineAmpIdxAvg{t,k} = dataSx5.(varNames{idxCalVisualSineAmpIdxAvg});
calVisualSineAmpAvgTrough{t,k} = dataSx5.(varNames{idxCalVisualSineAmpAvgTrough});
calVisualSineAmpIdxAvgTrough{t,k} = dataSx5.(varNames{idxCalVisualSineAmpIdxAvgTrough});

eyeVelVisualBlockAmpAvgIpsi{t,k} = dataSx5.(varNames{idxEyeVelVisualBlockAmpAvgIpsi});
eyeVisualBlockAmpIdxAvgIpsi{t,k} = dataSx5.(varNames{idxEyeVisualBlockAmpIdxAvgIpsi});
eyeVelVisualBlockAmpAvgContra{t,k} = dataSx5.(varNames{idxEyeVelVisualBlockAmpAvgContra});
eyeVisualBlockAmpIdxAvgContra{t,k} = dataSx5.(varNames{idxEyeVisualBlockAmpIdxAvgContra});

eyeVelVisualSineAmpAvgIpsi{t,k} = dataSx5.(varNames{idxEyeVelVisualSineAmpAvgIpsi});
eyeVisualSineAmpIdxAvgIpsi{t,k} = dataSx5.(varNames{idxEyeVisualSineAmpIdxAvgIpsi});
eyeVelVisualSineAmpAvgContra{t,k} = dataSx5.(varNames{idxEyeVelVisualSineAmpAvgContra});
eyeVisualSineAmpIdxAvgContra{t,k} = dataSx5.(varNames{idxEyeVisualSineAmpIdxAvgContra});

rsBlockAmpAvg{t,k} = dataSx5.(varNames{idxRsBlockAmpAvg});
rsBlockAmpIdxAvg{t,k} = dataSx5.(varNames{idxRsBlockAmpIdxAvg});
rsSineAmpAvg{t,k} = dataSx5.(varNames{idxRsSineAmpAvg});
rsSineAmpIdxAvg{t,k} = dataSx5.(varNames{idxRsSineAmpIdxAvg});

drumVisualBlockAmpAvgIpsi{t,k} = dataSx5.(varNames{idxDrumVisualBlockAmpAvgIpsi});
drumVisualBlockAmpIdxAvgIpsi{t,k} = dataSx5.(varNames{idxDrumVisualBlockAmpIdxAvgIpsi});
drumVisualBlockAmpAvgContra{t,k} = dataSx5.(varNames{idxDrumVisualBlockAmpAvgContra});
drumVisualBlockAmpIdxAvgContra{t,k} = dataSx5.(varNames{idxDrumVisualBlockAmpIdxAvgContra});
turntableDarkBlockAvg{t,k} = dataSx5.(varNames{idxTurntableDarkBlockAvg});
turntableDarkAvg{t,k} = dataSx5.(varNames{idxTurntableDarkAvg});

calPrePost{t,k} = dataSx5.(varNames{idxCalPrePost});
eyePrePost{t,k} = dataSx5.(varNames{idxEyePrePost});
rsPrePost{t,k} = dataSx5.(varNames{idxRsPrePost});

calVisualNorm{t,k} = dataSx5.(varNames{idxCalVisualNorm});
calVisualSineNorm{t,k} = dataSx5.(varNames{idxCalSineVisualNorm});
calDarkNorm{t,k} = dataSx5.(varNames{idxCalDarkNorm});
calDarkSineNorm{t,k} = dataSx5.(varNames{idxCalDarkSineNorm});

eyeIpsiGainPct{t,k} = dataSx5.(varNames{idxEyeIpsiGainPct});
eyeContraGainPct{t,k} = dataSx5.(varNames{idxEyeContraGainPct});

%% Population average of cycle averages
calCycBlockAvg = cat(2,calVisualBlockAvg{1:numSxsNorm,1});
calCycBlockSineAvg = cat(2,calVisualBlockSine{1:numSxsNorm,1});
eyeCycBlockAvg = cat(2,eyeVelVisualBlockAvg{1:numSxsNorm,1});
eyeCycBlockSineAvg = cat(2,eyeVisualBlockSine{1:numSxsNorm,1});
rsCycBlockAvg = cat(2,rsBlockAvg{1:numSxsNorm,1});
rsCycBlockSineAvg = cat(2,rsBlockSine{1:numSxsNorm,1});
drumCycBlockAvg = cat(2,drumVisualBlockAvg{1:numSxsNorm,1});
calCycBlockPopAvg = NaN(1000,numVisualBlocks);
calCycBlockSinePopAvg = NaN(1000,numVisualBlocks);
eyeCycBlockPopAvg = NaN(1000,numVisualBlocks);
eyeCycBlockSinePopAvg = NaN(1000,numVisualBlocks);
rsCycBlockPopAvg = NaN(1000,numVisualBlocks);
rsCycBlockSinePopAvg = NaN(1000,numVisualBlocks);
drumCycBlockPopAvg = NaN(1000,numVisualBlocks);
for i = 1:numVisualBlocks
    calCycBlockPopAvg(:,i) = mean([calCycBlockAvg(:,i) calCycBlockAvg(:,i+numVisualBlocks)],2);
    calCycBlockSinePopAvg(:,i) = mean([calCycBlockSineAvg{i,1}(1,:); calCycBlockSineAvg{i,2}(1,:)],1);
    eyeCycBlockPopAvg(:,i) = mean([eyeCycBlockAvg(:,i), eyeCycBlockAvg(:,i+numVisualBlocks)],2);
    eyeCycBlockSinePopAvg(:,i) = mean([eyeCycBlockSineAvg{i,1}(1,:); eyeCycBlockSineAvg{i,2}(1,:)],1);
    rsCycBlockPopAvg(:,i) = mean([rsCycBlockAvg{i,1}(:,1), rsCycBlockAvg{i,1}(:,1)],2);
    rsCycBlockSinePopAvg(:,i) = mean([rsCycBlockSineAvg{i,1}(1,:); rsCycBlockSineAvg{i,2}(1,:)],1);
    drumCycBlockPopAvg(:,i) = mean([drumCycBlockAvg{i,1}(:,1), drumCycBlockAvg{i,1}(:,1)],2);
end


calCycBlockAvgDark = cat(2,calVisualBlockAvg{1:numSxsDark,2});
calCycBlockSineAvgDark = cat(2,calVisualBlockSine{1:numSxsDark,2});
eyeCycBlockAvgDark = cat(2,eyeVelVisualBlockAvg{1:numSxsDark,2});
eyeCycBlockSineAvgDark = cat(2,eyeVisualBlockSine{1:numSxsDark,2});
rsCycBlockAvgDark = cat(2,rsBlockAvg{1:numSxsDark,2});
rsCycBlockSineAvgDark = cat(2,rsBlockSine{1:numSxsDark,2});
drumCycBlockAvgDark = cat(2,drumVisualBlockAvg{1:numSxsDark,2});
calCycBlockPopAvgDark = NaN(1000,numVisualBlocks);
calCycBlockSinePopAvgDark = NaN(1000,numVisualBlocks);
eyeCycBlockPopAvgDark = NaN(1000,numVisualBlocks);
eyeCycBlockSinePopAvgDark = NaN(1000,numVisualBlocks);
rsCycBlockPopAvgDark = NaN(1000,numVisualBlocks);
rsCycBlockSinePopAvgDark = NaN(1000,numVisualBlocks);
drumCycBlockPopAvgDark = NaN(1000,numVisualBlocks);
for i = 1:numVisualBlocks
    calCycBlockPopAvgDark(:,i) = mean([calCycBlockAvgDark(:,i) calCycBlockAvgDark(:,i+numVisualBlocks)],2);
    calCycBlockSinePopAvgDark(:,i) = mean([calCycBlockSineAvgDark{i,1}(1,:); calCycBlockSineAvgDark{i,2}(1,:)],1);
    eyeCycBlockPopAvgDark(:,i) = mean([eyeCycBlockAvgDark(:,i), eyeCycBlockAvgDark(:,i+numVisualBlocks)],2);
    eyeCycBlockSinePopAvgDark(:,i) = mean([eyeCycBlockSineAvgDark{i,1}(1,:); eyeCycBlockSineAvgDark{i,2}(1,:)],1);
    rsCycBlockPopAvgDark(:,i) = mean([rsCycBlockAvgDark{i,1}(:,1), rsCycBlockAvgDark{i,1}(:,1)],2);
    rsCycBlockSinePopAvgDark(:,i) = mean([rsCycBlockSineAvgDark{i,1}(1,:); rsCycBlockSineAvgDark{i,2}(1,:)],1);
    drumCycBlockPopAvgDark(:,i) = mean([drumCycBlockAvgDark{i,1}(:,1), drumCycBlockAvgDark{i,1}(:,1)],2);
end

figure()
subplot(2,2,1); hold on
plot(calCycBlockPopAvg)
ylabel('% \DeltaF/G')
subplot(2,2,2); hold on
plot(calCycBlockPopAvgDark)
subplot(2,2,3); hold on
plot(calCycBlockSinePopAvg)
ylabel('% \DeltaF/G')
xlabel('Time (ms)')
subplot(2,2,4); hold on
plot(calCycBlockSinePopAvgDark)
xlabel('Time (ms)')

figure()
subplot(2,1,1); hold on
plot(drumCycBlockPopAvg)
ylabel('Velocity')
subplot(2,1,2); hold on
plot(drumCycBlockPopAvgDark)
xlabel('Time (ms)')
ylabel('Velocity')

figure()
subplot(2,1,1); hold on
plot(rsCycBlockPopAvg)
subplot(2,1,2); hold on
plot(rsCycBlockPopAvgDark)

%% Calcium amplitude and time indexing
calBlockAmpNormVdark = NaN(2,numSxsNorm);
calBlockAmpNormVisual = NaN(numVisualBlocks,numSxsNorm);
calBlockAmpTroughNormVdark = NaN(2,numSxsNorm);
calBlockAmpTroughNormVisual = NaN(numVisualBlocks,numSxsNorm);
calBlockAmpNormVdarkSine = NaN(2,numSxsNorm);
calBlockAmpNormVisualSine = NaN(numVisualBlocks,numSxsNorm);
calBlockAmpTroughNormVdarkSine = NaN(2,numSxsNorm);
calBlockAmpTroughNormVisualSine = NaN(numVisualBlocks,numSxsNorm);

calBlockAmpIdxNormVdark = NaN(2,numSxsNorm);
calBlockAmpIdxNormVisual = NaN(numVisualBlocks,numSxsNorm);
calBlockAmpIdxTroughNormVdark = NaN(2,numSxsNorm);
calBlockAmpIdxTroughNormVisual = NaN(numVisualBlocks,numSxsNorm);
calBlockAmpIdxNormVdarkSine = NaN(2,numSxsNorm);
calBlockAmpIdxNormVisualSine = NaN(numVisualBlocks,numSxsNorm);
calBlockAmpIdxTroughNormVdarkSine = NaN(2,numSxsNorm);
calBlockAmpIdxTroughNormVisualSine = NaN(numVisualBlocks,numSxsNorm);

eyeIpsiBlockAmpNormVdark = NaN(2,numSxsNorm);
eyeIpsiBlockAmpNormVisual = NaN(numVisualBlocks,numSxsNorm);
eyeContraBlockAmpNormVdark = NaN(2,numSxsNorm);
eyeContraBlockAmpNormVisual = NaN(numVisualBlocks,numSxsNorm);
eyeIpsiBlockAmpNormVdarkSine = NaN(2,numSxsNorm);
eyeIpsiBlockAmpNormVisualSine = NaN(numVisualBlocks,numSxsNorm);
eyeContraBlockAmpNormVdarkSine = NaN(2,numSxsNorm);
eyeContraBlockAmpNormVisualSine = NaN(numVisualBlocks,numSxsNorm);

eyeIpsiBlockAmpIdxNormVdark = NaN(2,numSxsNorm);
eyeIpsiBlockAmpIdxNormVisual = NaN(numVisualBlocks,numSxsNorm);
eyeContraBlockAmpIdxNormVdark = NaN(2,numSxsNorm);
eyeContraBlockAmpIdxNormVisual = NaN(numVisualBlocks,numSxsNorm);
eyeIpsiBlockAmpIdxNormVdarkSine = NaN(2,numSxsNorm);
eyeIpsiBlockAmpIdxNormVisualSine = NaN(numVisualBlocks,numSxsNorm);
eyeContraBlockAmpIdxNormVdarkSine = NaN(2,numSxsNorm);
eyeContraBlockAmpIdxNormVisualSine = NaN(numVisualBlocks,numSxsNorm);

rsBlockAmpNorm = NaN(numVisualBlocks,numSxsNorm);
rsBlockAmpNormSine = NaN(numVisualBlocks,numSxsNorm);
rsBlockAmpIdxNorm = NaN(numVisualBlocks,numSxsNorm);
rsBlockAmpIdxNormSine = NaN(numVisualBlocks,numSxsNorm);

drumBlockAmpIpsiNorm = NaN(numVisualBlocks,numSxsNorm);
drumBlockAmpContraNorm = NaN(numVisualBlocks,numSxsNorm);
drumBlockAmpIdxIpsiNorm = NaN(numVisualBlocks,numSxsNorm);
drumBlockAmpIdxContraNorm = NaN(numVisualBlocks,numSxsNorm);

calNormVdark = NaN(2,numSxsNorm);
calNorm = NaN(numVisualBlocks,numSxsNorm);
calNormVdarkSine = NaN(2,numSxsNorm);
calNormSine = NaN(numVisualBlocks,numSxsNorm);

eyeIpsiGainNormVdark = NaN(2,numSxsNorm);
eyeContraGainNormVdark = NaN(2,numSxsNorm);
eyeIpsiGainNormVisual = NaN(numVisualBlocks,numSxsNorm);
eyeContraGainNormVisual = NaN(numVisualBlocks,numSxsNorm);
eyeIpsiGainNormVdarkSine = NaN(2,numSxsNorm);
eyeContraGainNormVdarkSine = NaN(2,numSxsNorm);
eyeIpsiGainNormVisualSine = NaN(numVisualBlocks,numSxsNorm);
eyeContraGainNormVisualSine = NaN(numVisualBlocks,numSxsNorm);
for i = 1:numSxsNorm
    calBlockAmpNormVdark(:,i) = calVisualBlockAmpAvg{i,1}(1:numDarkBlocks,1);
    calBlockAmpNormVisual(:,i) = calVisualBlockAmpAvg{i,1}(1:numVisualBlocks,2);
    calBlockAmpTroughNormVdark(:,i) = calVisualBlockAmpAvgTrough{i,1}(1:numDarkBlocks,1);
    calBlockAmpTroughNormVisual(:,i) = calVisualBlockAmpAvgTrough{i,1}(1:numVisualBlocks,2);
    calBlockAmpNormAvg(1:numDarkBlocks,1) = mean(calBlockAmpNormVdark,2);
    calBlockAmpNormAvg(1:numVisualBlocks,2) = mean(calBlockAmpNormVisual,2);
    calBlockAmpNormAvg(1:numDarkBlocks,3) = mean(calBlockAmpTroughNormVdark,2);
    calBlockAmpNormAvg(1:numVisualBlocks,4) = mean(calBlockAmpTroughNormVisual,2);
    calBlockAmpNormVdarkSine(:,i) = calVisualSineAmpAvg{i,1}(1:numDarkBlocks,1);
    calBlockAmpNormVisualSine(:,i) = calVisualSineAmpAvg{i,1}(1:numVisualBlocks,2);
    calBlockAmpTroughNormVdarkSine(:,i) = calVisualSineAmpAvgTrough{i,1}(1:numDarkBlocks,1);
    calBlockAmpTroughNormVisualSine(:,i) = calVisualSineAmpAvgTrough{i,1}(1:numVisualBlocks,2);
    calBlockAmpNormAvg(1:numDarkBlocks,5) = mean(calBlockAmpNormVdarkSine,2);
    calBlockAmpNormAvg(1:numVisualBlocks,6) = mean(calBlockAmpNormVisualSine,2);
    calBlockAmpNormAvg(1:numDarkBlocks,7) = mean(calBlockAmpTroughNormVdarkSine,2);
    calBlockAmpNormAvg(1:numVisualBlocks,8) = mean(calBlockAmpTroughNormVisualSine,2);
    
    calBlockAmpIdxNormVdark(:,i) = calVisualBlockAmpIdxAvg{i,1}(1:numDarkBlocks,1);
    calBlockAmpIdxNormVisual(:,i) = calVisualBlockAmpIdxAvg{i,1}(1:numVisualBlocks,2);
    calBlockAmpIdxTroughNormVdark(:,i) = calVisualBlockAmpIdxAvgTrough{i,1}(1:numDarkBlocks,1);
    calBlockAmpIdxTroughNormVisual(:,i) = calVisualBlockAmpIdxAvgTrough{i,1}(1:numVisualBlocks,2);
    calBlockAmpIdxNormVdarkSine(:,i) = calVisualSineAmpIdxAvg{i,1}(1:numDarkBlocks,1);
    calBlockAmpIdxNormVisualSine(:,i) = calVisualSineAmpIdxAvg{i,1}(1:numVisualBlocks,2);
    calBlockAmpIdxTroughNormVdarkSine(:,i) = calVisualSineAmpIdxAvgTrough{i,1}(1:numDarkBlocks,1);
    calBlockAmpIdxTroughNormVisualSine(:,i) = calVisualSineAmpIdxAvgTrough{i,1}(1:numVisualBlocks,2);
    calBlockAmpIdxNormAvg(1:numDarkBlocks,1) = mean(calBlockAmpIdxNormVdark,2);
    calBlockAmpIdxNormAvg(1:numVisualBlocks,2) = mean(calBlockAmpIdxNormVisual,2);
    calBlockAmpIdxNormAvg(1:numDarkBlocks,3) = mean(calBlockAmpIdxTroughNormVdark,2);
    calBlockAmpIdxNormAvg(1:numVisualBlocks,4) = mean(calBlockAmpIdxTroughNormVisual,2);
    calBlockAmpIdxNormAvgSine(1:numDarkBlocks,5) = mean(calBlockAmpIdxNormVdarkSine,2);
    calBlockAmpIdxNormAvgSine(1:numVisualBlocks,6) = mean(calBlockAmpIdxNormVisualSine,2);
    calBlockAmpIdxNormAvgSine(1:numDarkBlocks,7) = mean(calBlockAmpIdxTroughNormVdarkSine,2);
    calBlockAmpIdxNormAvgSine(1:numVisualBlocks,8) = mean(calBlockAmpIdxTroughNormVisualSine,2);
    
    eyeIpsiBlockAmpNormVdark(:,i) = eyeVelVisualBlockAmpAvgIpsi{i,1}(1:numDarkBlocks,1);
    eyeIpsiBlockAmpNormVisual(:,i) = eyeVelVisualBlockAmpAvgIpsi{i,1}(1:numVisualBlocks,2);
    eyeContraBlockAmpNormVdark(:,i) = eyeVelVisualBlockAmpAvgContra{i,1}(1:numDarkBlocks,1);
    eyeContraBlockAmpNormVisual(:,i) = eyeVelVisualBlockAmpAvgContra{i,1}(1:numVisualBlocks,2);
    eyeIpsiBlockAmpNormAvg(1:numDarkBlocks,1) = mean(eyeIpsiBlockAmpNormVdark,2);
    eyeIpsiBlockAmpNormAvg(1:numVisualBlocks,2) = mean(eyeIpsiBlockAmpNormVisual,2);
    eyeContraBlockAmpNormAvg(1:numDarkBlocks,1) = mean(eyeContraBlockAmpNormVdark,2);
    eyeContraBlockAmpNormAvg(1:numVisualBlocks,2) = mean(eyeContraBlockAmpNormVisual,2);
    eyeIpsiBlockAmpNormVdarkSine(:,i) = eyeVelVisualSineAmpAvgIpsi{i,1}(1:numDarkBlocks,1);
    eyeIpsiBlockAmpNormVisualSine(:,i) = eyeVelVisualSineAmpAvgIpsi{i,1}(1:numVisualBlocks,2);
    eyeContraBlockAmpNormVdarkSine(:,i) = eyeVelVisualSineAmpAvgContra{i,1}(1:numDarkBlocks,1);
    eyeContraBlockAmpNormVisualSine(:,i) = eyeVelVisualSineAmpAvgContra{i,1}(1:numVisualBlocks,2);
    eyeIpsiBlockAmpNormAvg(1:numDarkBlocks,3) = mean(eyeIpsiBlockAmpNormVdarkSine,2);
    eyeIpsiBlockAmpNormAvg(1:numVisualBlocks,4) = mean(eyeIpsiBlockAmpNormVisualSine,2);
    eyeContraBlockAmpNormAvg(1:numDarkBlocks,3) = mean(eyeContraBlockAmpNormVdarkSine,2);
    eyeContraBlockAmpNormAvg(1:numVisualBlocks,4) = mean(eyeContraBlockAmpNormVisualSine,2);
    
    eyeIpsiBlockAmpIdxNormVdark(:,i) = eyeVisualBlockAmpIdxAvgIpsi{i,1}(1:numDarkBlocks,1);
    eyeIpsiBlockAmpIdxNormVisual(:,i) = eyeVisualBlockAmpIdxAvgIpsi{i,1}(1:numVisualBlocks,2);
    eyeContraBlockAmpIdxNormVdark(:,i) = eyeVisualBlockAmpIdxAvgContra{i,1}(1:numDarkBlocks,1);
    eyeContraBlockAmpIdxNormVisual(:,i) = eyeVisualBlockAmpIdxAvgContra{i,1}(1:numVisualBlocks,2);
    eyeIpsiBlockAmpIdxNormAvg(1:numDarkBlocks,1) = mean(eyeIpsiBlockAmpIdxNormVdark,2);
    eyeIpsiBlockAmpIdxNormAvg(1:numVisualBlocks,2) = mean(eyeIpsiBlockAmpIdxNormVisual,2);
    eyeContraBlockAmpIdxNormAvg(1:numDarkBlocks,1) = mean(eyeContraBlockAmpIdxNormVdark,2);
    eyeContraBlockAmpIdxNormAvg(1:numVisualBlocks,2) = mean(eyeContraBlockAmpIdxNormVisual,2);
    eyeIpsiBlockAmpIdxNormVdarkSine(:,i) = eyeVisualSineAmpIdxAvgIpsi{i,1}(1:numDarkBlocks,1);
    eyeIpsiBlockAmpIdxNormVisualSine(:,i) = eyeVisualSineAmpIdxAvgIpsi{i,1}(1:numVisualBlocks,2);
    eyeContraBlockAmpIdxNormVdarkSine(:,i) = eyeVisualSineAmpIdxAvgContra{i,1}(1:numDarkBlocks,1);
    eyeContraBlockAmpIdxNormVisualSine(:,i) = eyeVisualSineAmpIdxAvgContra{i,1}(1:numVisualBlocks,2);
    eyeIpsiBlockAmpIdxNormAvg(1:numDarkBlocks,3) = mean(eyeIpsiBlockAmpIdxNormVdarkSine,2);
    eyeIpsiBlockAmpIdxNormAvg(1:numVisualBlocks,4) = mean(eyeIpsiBlockAmpIdxNormVisualSine,2);
    eyeContraBlockAmpIdxNormAvg(1:numDarkBlocks,3) = mean(eyeContraBlockAmpIdxNormVdarkSine,2);
    eyeContraBlockAmpIdxNormAvg(1:numVisualBlocks,4) = mean(eyeContraBlockAmpIdxNormVisualSine,2);
    
    rsBlockAmpNorm(:,i) = rsBlockAmpAvg{i,1}(1:numVisualBlocks,1);
    rsBlockAmpNormSine(:,i) = rsSineAmpAvg{i,1}(1:numVisualBlocks,1);
    rsBlockAmpIdxNorm(:,i) = rsBlockAmpIdxAvg{i,1}(1:numVisualBlocks,1);
    rsBlockAmpIdxNormSine(:,i) = rsSineAmpIdxAvg{i,1}(1:numVisualBlocks,1);
    rsBlockAmpNormAvg(1:numVisualBlocks,1) = mean(rsBlockAmpNorm,2);
    rsBlockAmpNormAvg(1:numVisualBlocks,2) = mean(rsBlockAmpNormSine,2);
    rsBlockAmpIdxNormAvg(1:numVisualBlocks,1) = mean(rsBlockAmpIdxNorm,2);
    rsBlockAmpIdxNormAvg(1:numVisualBlocks,2) = mean(rsBlockAmpIdxNormSine,2);
    
    drumBlockAmpIpsiNorm(:,i) = drumVisualBlockAmpAvgIpsi{i,1}(1:numVisualBlocks,1);
    drumBlockAmpContraNorm(:,i) = drumVisualBlockAmpAvgContra{i,1}(1:numVisualBlocks,1);
    drumBlockAmpIdxIpsiNorm(:,i) = drumVisualBlockAmpIdxAvgIpsi{i,1}(1:numVisualBlocks,1);
    drumBlockAmpIdxContraNorm(:,i) = drumVisualBlockAmpIdxAvgContra{i,1}(1:numVisualBlocks,1);
    drumBlockAmpIpsiNormAvg(1:numVisualBlocks,1) = mean(drumBlockAmpIpsiNorm,2);
    drumBlockAmpContraNormAvg(1:numVisualBlocks,1) = mean(drumBlockAmpContraNorm,2);
    drumBlockAmpIdxIpsiNormAvg(1:numVisualBlocks,1) = mean(drumBlockAmpIdxIpsiNorm,2);
    drumBlockAmpIdxContraNormAvg(1:numVisualBlocks,1) = mean(drumBlockAmpIdxContraNorm,2);
    
    calNormVdark(1:numDarkBlocks,i) = calDarkNorm{i,1}(1,1:numDarkBlocks);
    calNorm(1:numVisualBlocks,i) = calVisualNorm{i,1}(1,1:numVisualBlocks);
    calNormVdarkSine(1:numDarkBlocks,i) = calDarkSineNorm{i,1}(1,1:numDarkBlocks);
    calNormSine(1:numVisualBlocks,i) = calVisualSineNorm{i,1}(1,1:numVisualBlocks);
    calNormAvg(1:numDarkBlocks,1) = mean(calNormVdark,2);
    calNormAvg(1:numVisualBlocks,2) = mean(calNorm,2);
    calNormAvg(1:numDarkBlocks,3) = mean(calNormVdarkSine,2);
    calNormAvg(1:numVisualBlocks,4) = mean(calNormSine,2);
    
    eyeIpsiGainNormVdark(:,i) = eyeIpsiGainPct{i,1}(1:numDarkBlocks,1);
    eyeContraGainNormVdark(:,i) = eyeContraGainPct{i,1}(1:numDarkBlocks,1);
    eyeIpsiGainNormVisual(:,i) = eyeIpsiGainPct{i,1}(:,2);
    eyeContraGainNormVisual(:,i) = eyeContraGainPct{i,1}(:,2);
    eyeIpsiGainNormVdarkSine(:,i) = eyeIpsiGainPct{i,1}(1:numDarkBlocks,3);
    eyeContraGainNormVdarkSine(:,i) = eyeContraGainPct{i,1}(1:numDarkBlocks,3);
    eyeIpsiGainNormVisualSine(:,i) = eyeIpsiGainPct{i,1}(:,4);
    eyeContraGainNormVisualSine(:,i) = eyeContraGainPct{i,1}(:,4);
end

calBlockAmpDarkVdark = NaN(2,numSxsDark);
calBlockAmpDarkVisual = NaN(numVisualBlocks,numSxsDark);
calBlockAmpTroughDarkVdark = NaN(2,numSxsNorm);
calBlockAmpTroughDarkVisual = NaN(numVisualBlocks,numSxsDark);
calBlockAmpDarkVdarkSine = NaN(2,numSxsDark);
calBlockAmpDarkVisualSine = NaN(numVisualBlocks,numSxsDark);
calBlockAmpTroughDarkVdarkSine = NaN(2,numSxsDark);
calBlockAmpTroughDarkVisualSine = NaN(numVisualBlocks,numSxsDark);

calBlockAmpIdxDarkVdark = NaN(2,numSxsDark);
calBlockAmpIdxDarkVisual = NaN(numVisualBlocks,numSxsDark);
calBlockAmpIdxTroughDarkVdark = NaN(2,numSxsDark);
calBlockAmpIdxTroughDarkVisual = NaN(numVisualBlocks,numSxsDark);
calBlockAmpIdxDarkVdarkSine = NaN(2,numSxsDark);
calBlockAmpIdxDarkVisualSine = NaN(numVisualBlocks,numSxsDark);
calBlockAmpIdxTroughDarkVdarkSine = NaN(2,numSxsDark);
calBlockAmpIdxTroughDarkVisualSine = NaN(numVisualBlocks,numSxsDark);

eyeIpsiBlockAmpDarkVdark = NaN(2,numSxsDark);
eyeIpsiBlockAmpDarkVisual = NaN(numVisualBlocks,numSxsDark);
eyeContraBlockAmpDarkVdark = NaN(2,numSxsDark);
eyeContraBlockAmpDarkVisual = NaN(numVisualBlocks,numSxsDark);
eyeIpsiBlockAmpDarkVdarkSine = NaN(2,numSxsDark);
eyeIpsiBlockAmpDarkVisualSine = NaN(numVisualBlocks,numSxsDark);
eyeContraBlockAmpDarkVdarkSine = NaN(2,numSxsDark);
eyeContraBlockAmpDarkVisualSine = NaN(numVisualBlocks,numSxsDark);

eyeIpsiBlockAmpIdxDarkVdark = NaN(2,numSxsDark);
eyeIpsiBlockAmpIdxDarkVisual = NaN(numVisualBlocks,numSxsDark);
eyeContraBlockAmpIdxDarkVdark = NaN(2,numSxsDark);
eyeContraBlockAmpIdxDarkVisual = NaN(numVisualBlocks,numSxsDark);
eyeIpsiBlockAmpIdxDarkVdarkSine = NaN(2,numSxsDark);
eyeIpsiBlockAmpIdxDarkVisualSine = NaN(numVisualBlocks,numSxsDark);
eyeContraBlockAmpIdxDarkVdarkSine = NaN(2,numSxsDark);
eyeContraBlockAmpIdxDarkVisualSine = NaN(numVisualBlocks,numSxsDark);

rsBlockAmpDark= NaN(numVisualBlocks,numSxsDark);
rsBlockAmpDarkSine = NaN(numVisualBlocks,numSxsDark);
rsBlockAmpIdxDark= NaN(numVisualBlocks,numSxsDark);
rsBlockAmpIdxDarkSine = NaN(numVisualBlocks,numSxsDark);

drumBlockAmpIpsiDark = NaN(numVisualBlocks,numSxsDark);
drumBlockAmpContraDark = NaN(numVisualBlocks,numSxsDark);
drumBlockAmpIdxIpsiDark = NaN(numVisualBlocks,numSxsDark);
drumBlockAmpIdxContraDark = NaN(numVisualBlocks,numSxsDark);

calDarkVdark = NaN(2,numSxsDark);
calDark = NaN(numVisualBlocks,numSxsDark);
calDarkVdarkSine = NaN(2,numSxsDark);
calDarkSine = NaN(numVisualBlocks,numSxsDark);

eyeIpsiGainDarkVdark = NaN(2,numSxsDark);
eyeContraGainDarkVdark = NaN(2,numSxsDark);
eyeIpsiGainDarkVisual = NaN(numVisualBlocks,numSxsDark);
eyeContraGainDarkVisual = NaN(numVisualBlocks,numSxsDark);
eyeIpsiGainDarkVdarkSine = NaN(2,numSxsDark);
eyeContraGainDarkVdarkSine = NaN(2,numSxsDark);
eyeIpsiGainDarkVisualSine = NaN(numVisualBlocks,numSxsDark);
eyeContraGainDarkVisualSine = NaN(numVisualBlocks,numSxsDark);
for i = 1:numSxsDark
    calBlockAmpDarkVdark(:,i) = calVisualBlockAmpAvg{i,2}(numDarkBlocks,1);
    calBlockAmpDarkVisual(:,i) = calVisualBlockAmpAvg{i,2}(1:numVisualBlocks,2);
    calBlockAmpTroughDarkVdark(:,i) = calVisualBlockAmpAvgTrough{i,2}(numDarkBlocks,1);
    calBlockAmpTroughDarkVisual(:,i) = calVisualBlockAmpAvgTrough{i,2}(1:numVisualBlocks,2);
    calBlockAmpDarkAvg(1:numDarkBlocks,1) = mean(calBlockAmpDarkVdark,2);
    calBlockAmpDarkAvg(1:numVisualBlocks,2) = mean(calBlockAmpDarkVisual,2);
    calBlockAmpDarkAvg(1:numDarkBlocks,3) = mean(calBlockAmpTroughDarkVdark,2);
    calBlockAmpDarkAvg(1:numVisualBlocks,4) = mean(calBlockAmpTroughDarkVisual,2);
    calBlockAmpDarkVdarkSine(:,i) = calVisualSineAmpAvg{i,2}(1:numDarkBlocks,1);
    calBlockAmpDarkVisualSine(:,i) = calVisualSineAmpAvg{i,2}(1:numVisualBlocks,2);
    calBlockAmpTroughDarkVdarkSine(:,i) = calVisualSineAmpAvgTrough{i,2}(1:numDarkBlocks,1);
    calBlockAmpTroughDarkVisualSine(:,i) = calVisualSineAmpAvgTrough{i,2}(1:numVisualBlocks,2);
    calBlockAmpDarkAvg(1:numDarkBlocks,5) = mean(calBlockAmpDarkVdarkSine,2);
    calBlockAmpDarkAvg(1:numVisualBlocks,6) = mean(calBlockAmpDarkVisualSine,2);
    calBlockAmpDarkAvg(1:numDarkBlocks,7) = mean(calBlockAmpTroughDarkVdarkSine,2);
    calBlockAmpDarkAvg(1:numVisualBlocks,8) = mean(calBlockAmpTroughDarkVisualSine,2);
    
    calBlockAmpIdxDarkVdark(:,i) = calVisualBlockAmpIdxAvg{i,2}(1:numDarkBlocks,1);
    calBlockAmpIdxDarkVisual(:,i) = calVisualBlockAmpIdxAvg{i,2}(1:numVisualBlocks,2);
    calBlockAmpIdxTroughDarkVdark(:,i) = calVisualBlockAmpIdxAvgTrough{i,2}(1:numDarkBlocks,1);
    calBlockAmpIdxTroughDarkVisual(:,i) = calVisualBlockAmpIdxAvgTrough{i,2}(1:numVisualBlocks,2);
    calBlockAmpIdxDarkVdarkSine(:,i) = calVisualSineAmpIdxAvg{i,2}(1:numDarkBlocks,1);
    calBlockAmpIdxDarkVisualSine(:,i) = calVisualSineAmpIdxAvg{i,2}(1:numVisualBlocks,2);
    calBlockAmpIdxTroughDarkVdarkSine(:,i) = calVisualSineAmpIdxAvgTrough{i,2}(1:numDarkBlocks,1);
    calBlockAmpIdxTroughDarkVisualSine(:,i) = calVisualSineAmpIdxAvgTrough{i,2}(1:numVisualBlocks,2);
    calBlockAmpIdxDarkAvg(1:numDarkBlocks,1) = mean(calBlockAmpIdxDarkVdark,2);
    calBlockAmpIdxDarkAvg(1:numVisualBlocks,2) = mean(calBlockAmpIdxDarkVisual,2);
    calBlockAmpIdxDarkAvg(1:numDarkBlocks,3) = mean(calBlockAmpIdxTroughDarkVdark,2);
    calBlockAmpIdxDarkAvg(1:numVisualBlocks,4) = mean(calBlockAmpIdxTroughDarkVisual,2);
    calBlockAmpIdxDarkAvg(1:numDarkBlocks,5) = mean(calBlockAmpIdxDarkVdarkSine,2);
    calBlockAmpIdxDarkAvg(1:numVisualBlocks,6) = mean(calBlockAmpIdxDarkVisualSine,2);
    calBlockAmpIdxDarkAvg(1:numDarkBlocks,7) = mean(calBlockAmpIdxTroughDarkVdarkSine,2);
    calBlockAmpIdxDarkAvg(1:numVisualBlocks,8) = mean(calBlockAmpIdxTroughDarkVisualSine,2);
    
    eyeIpsiBlockAmpDarkVdark(:,i) = eyeVelVisualBlockAmpAvgIpsi{i,2}(numDarkBlocks,1);
    eyeIpsiBlockAmpDarkVisual(:,i) = eyeVelVisualBlockAmpAvgIpsi{i,2}(1:numVisualBlocks,2);
    eyeContraBlockAmpDarkVdark(:,i) = eyeVelVisualBlockAmpAvgContra{i,2}(numDarkBlocks,1);
    eyeContraBlockAmpDarkVisual(:,i) = eyeVelVisualBlockAmpAvgContra{i,2}(1:numVisualBlocks,2);
    eyeIpsiBlockAmpDarkAvg(1:numDarkBlocks,1) = mean(eyeIpsiBlockAmpDarkVdark,2);
    eyeIpsiBlockAmpDarkAvg(1:numVisualBlocks,2) = mean(eyeIpsiBlockAmpDarkVisual,2);
    eyeContraBlockAmpDarkAvg(1:numDarkBlocks,1) = mean(eyeContraBlockAmpDarkVdark,2);
    eyeContraBlockAmpDarkAvg(1:numVisualBlocks,2) = mean(eyeContraBlockAmpDarkVisual,2);
    eyeIpsiBlockAmpDarkVdarkSine(:,i) = eyeVelVisualSineAmpAvgIpsi{i,2}(1:numDarkBlocks,1);
    eyeIpsiBlockAmpDarkVisualSine(:,i) = eyeVelVisualSineAmpAvgIpsi{i,2}(1:numVisualBlocks,2);
    eyeContraBlockAmpDarkVdarkSine(:,i) = eyeVelVisualSineAmpAvgContra{i,2}(1:numDarkBlocks,1);
    eyeContraBlockAmpDarkVisualSine(:,i) = eyeVelVisualSineAmpAvgContra{i,2}(1:numVisualBlocks,2);
    eyeIpsiBlockAmpDarkAvg(1:numDarkBlocks,3) = mean(eyeIpsiBlockAmpDarkVdarkSine,2);
    eyeIpsiBlockAmpDarkAvg(1:numVisualBlocks,4) = mean(eyeIpsiBlockAmpDarkVisualSine,2);
    eyeContraBlockAmpDarkAvg(1:numDarkBlocks,3) = mean(eyeContraBlockAmpDarkVdarkSine,2);
    eyeContraBlockAmpDarkAvg(1:numVisualBlocks,4) = mean(eyeContraBlockAmpDarkVisualSine,2);
    
    eyeIpsiBlockAmpIdxDarkVdark(:,i) = eyeVisualBlockAmpIdxAvgIpsi{i,2}(numDarkBlocks,1);
    eyeIpsiBlockAmpIdxDarkVisual(:,i) = eyeVisualBlockAmpIdxAvgIpsi{i,2}(1:numVisualBlocks,2);
    eyeContraBlockAmpIdxDarkVdark(:,i) = eyeVisualBlockAmpIdxAvgContra{i,2}(numDarkBlocks,1);
    eyeContraBlockAmpIdxDarkVisual(:,i) = eyeVisualBlockAmpIdxAvgContra{i,2}(1:numVisualBlocks,2);
    eyeIpsiBlockAmpIdxDarkAvg(1:numDarkBlocks,1) = mean(eyeIpsiBlockAmpIdxDarkVdark,2);
    eyeIpsiBlockAmpIdxDarkAvg(1:numVisualBlocks,2) = mean(eyeIpsiBlockAmpIdxDarkVisual,2);
    eyeContraBlockAmpIdxDarkAvg(1:numDarkBlocks,1) = mean(eyeContraBlockAmpIdxDarkVdark,2);
    eyeContraBlockAmpIdxDarkAvg(1:numVisualBlocks,2) = mean(eyeContraBlockAmpIdxDarkVisual,2);
    eyeIpsiBlockAmpIdxDarkVdarkSine(:,i) = eyeVisualSineAmpIdxAvgIpsi{i,2}(1:numDarkBlocks,1);
    eyeIpsiBlockAmpIdxDarkVisualSine(:,i) = eyeVisualSineAmpIdxAvgIpsi{i,2}(1:numVisualBlocks,2);
    eyeContraBlockAmpIdxDarkVdarkSine(:,i) = eyeVisualSineAmpIdxAvgContra{i,2}(1:numDarkBlocks,1);
    eyeContraBlockAmpIdxDarkVisualSine(:,i) = eyeVisualSineAmpIdxAvgContra{i,2}(1:numVisualBlocks,2);
    eyeIpsiBlockAmpIdxDarkAvg(1:numDarkBlocks,3) = mean(eyeIpsiBlockAmpIdxDarkVdarkSine,2);
    eyeIpsiBlockAmpIdxDarkAvg(1:numVisualBlocks,4) = mean(eyeIpsiBlockAmpIdxDarkVisualSine,2);
    eyeContraBlockAmpIdxDarkAvg(1:numDarkBlocks,3) = mean(eyeContraBlockAmpIdxDarkVdarkSine,2);
    eyeContraBlockAmpIdxDarkAvg(1:numVisualBlocks,4) = mean(eyeContraBlockAmpIdxDarkVisualSine,2);
    
    rsBlockAmpDark(:,i) = rsBlockAmpAvg{i,2}(1:numVisualBlocks,1);
    rsBlockAmpDarkSine(:,i) = rsSineAmpAvg{i,2}(1:numVisualBlocks,1);
    rsBlockAmpIdxDark(:,i) = rsBlockAmpIdxAvg{i,2}(1:numVisualBlocks,1);
    rsBlockAmpIdxDarkSine(:,i) = rsSineAmpIdxAvg{i,2}(1:numVisualBlocks,1);
    rsBlockAmpDarkAvg(1:numVisualBlocks,1) = mean(rsBlockAmpDark,2);
    rsBlockAmpDarkAvg(1:numVisualBlocks,2) = mean(rsBlockAmpDarkSine,2);
    rsBlockAmpIdxDarkAvg(1:numVisualBlocks,1) = mean(rsBlockAmpIdxDark,2);
    rsBlockAmpIdxDarkAvg(1:numVisualBlocks,2) = mean(rsBlockAmpIdxDarkSine,2);
    
    drumBlockAmpIpsiDark(:,i) = drumVisualBlockAmpAvgIpsi{i,2}(1:numVisualBlocks,1);
    drumBlockAmpContraDark(:,i) = drumVisualBlockAmpAvgContra{i,2}(1:numVisualBlocks,1);
    drumBlockAmpIdxIpsiDark(:,i) = drumVisualBlockAmpIdxAvgIpsi{i,2}(1:numVisualBlocks,1);
    drumBlockAmpIdxContraDark(:,i) = drumVisualBlockAmpIdxAvgContra{i,2}(1:numVisualBlocks,1);
    drumBlockAmpIpsiDarkAvg(1:numVisualBlocks,1) = mean(drumBlockAmpIpsiDark,2);
    drumBlockAmpContraDarkAvg(1:numVisualBlocks,1) = mean(drumBlockAmpContraDark,2);
    drumBlockAmpIdxIpsiDarkAvg(1:numVisualBlocks,1) = mean(drumBlockAmpIdxIpsiDark,2);
    drumBlockAmpIdxContraDarkAvg(1:numVisualBlocks,1) = mean(drumBlockAmpIdxContraDark,2);
    
    calDarkVdark(1:numDarkBlocks,i) = calDarkNorm{i,2}(1,1:numDarkBlocks);
    calDark(1:numVisualBlocks,i) = calVisualNorm{i,2}(1,1:numVisualBlocks);
    calDarkVdarkSine(1:numDarkBlocks,i) = calDarkSineNorm{i,2}(1,1:numDarkBlocks);
    calDarkSine(1:numVisualBlocks,i) = calVisualSineNorm{i,2}(1,1:numVisualBlocks);
    calDarkAvg(1:numDarkBlocks,1) = mean(calDarkVdark,2);
    calDarkAvg(1:numVisualBlocks,2) = mean(calDark,2);
    calDarkAvg(1:numDarkBlocks,3) = mean(calDarkVdarkSine,2);
    calDarkAvg(1:numVisualBlocks,4) = mean(calDarkSine,2);
    
    eyeIpsiGainDarkVdark(:,i) = eyeIpsiGainPct{i,2}(1:numDarkBlocks,1);
    eyeContraGainDarkVdark(:,i) = eyeContraGainPct{i,2}(1:numDarkBlocks,1);
    eyeIpsiGainDarkVisual(:,i) = eyeIpsiGainPct{i,2}(:,2);
    eyeContraGainDarkVisual(:,i) = eyeContraGainPct{i,2}(:,2);
    eyeIpsiGainDarkVdarkSine(:,i) = eyeIpsiGainPct{i,2}(1:numDarkBlocks,3);
    eyeContraGainDarkVdarkSine(:,i) = eyeContraGainPct{i,2}(1:numDarkBlocks,3);
    eyeIpsiGainDarkVisualSine(:,i) = eyeIpsiGainPct{i,2}(:,4);
    eyeContraGainDarkVisualSine(:,i) = eyeContraGainPct{i,2}(:,4);
end

%% Plot data
calBlockAmpNormAvgPeak = calBlockAmpNormAvg(:,2) - calBlockAmpNormAvg(:,4);
calBlockAmpNormAvgPeak(:,2) = calBlockAmpNormAvg(:,6) - calBlockAmpNormAvg(:,8);
calBlockAmpDarkAvgPeak = calBlockAmpDarkAvg(:,2) - calBlockAmpDarkAvg(:,4);
calBlockAmpDarkAvgPeak(:,2) = calBlockAmpDarkAvg(:,6) - calBlockAmpDarkAvg(:,8);

fitLineCalBlockAmpNorm = fitlm(1:length(calBlockAmpNormAvgPeak(:,1)),calBlockAmpNormAvgPeak(:,1));
r2calBlockAmpNorm = fitLineCalBlockAmpNorm.Rsquared.Ordinary;
fitLineCalBlockAmpNormSine = fitlm(1:length(calBlockAmpNormAvgPeak(:,1)),calBlockAmpNormAvgPeak(:,2));
r2calBlockAmpNormSine = fitLineCalBlockAmpNormSine.Rsquared.Ordinary;
fitLineCalBlockAmpDark = fitlm(1:length(calBlockAmpDarkAvgPeak(:,1)),calBlockAmpDarkAvgPeak(:,1));
r2calBlockAmpDark = fitLineCalBlockAmpDark.Rsquared.Ordinary;
fitLineCalBlockAmpDarkSine = fitlm(1:length(calBlockAmpDarkAvgPeak(:,1)),calBlockAmpDarkAvgPeak(:,2));
r2calBlockAmpDarkSine = fitLineCalBlockAmpDarkSine.Rsquared.Ordinary;
fitLineCalNormAvg = fitlm(1:length(calNormAvg(:,2)),calNormAvg(:,2));
r2calNormAvg = fitLineCalNormAvg.Rsquared.Ordinary;
fitLineCalNormAvgSine = fitlm(1:length(calNormAvg(:,4)),calNormAvg(:,4));
r2calNormAvgSine = fitLineCalNormAvgSine.Rsquared.Ordinary;
fitLineCalDarkAvg = fitlm(1:length(calDarkAvg(:,2)),calDarkAvg(:,2));
r2calDarkAvg = fitLineCalDarkAvg.Rsquared.Ordinary;
fitLineCalDarkAvgSine = fitlm(1:length(calDarkAvg(:,4)),calDarkAvg(:,4));
r2calDarkAvgSine = fitLineCalDarkAvgSine.Rsquared.Ordinary;

figure()
subplot(2,1,1); hold on
plot(calBlockAmpNormAvgPeak(:,1),'Color','k')
plot(calBlockAmpDarkAvgPeak(:,1),'Color','b')
plot(fitLineCalBlockAmpNorm,'Color','k')
plot(fitLineCalBlockAmpDark,'Color','b')
ylabel('% DeltaF/G')
xlabel('')
title('Unfitted')
legend('Normal-reared','Dark-reared','','','','')

subplot(2,1,2); hold on
plot(calBlockAmpNormAvgPeak(:,2),'Color','k')
plot(calBlockAmpDarkAvgPeak(:,2),'Color','b')
plot(fitLineCalBlockAmpNormSine,'Color','k')
plot(fitLineCalBlockAmpDarkSine,'Color','b')
ylabel('% DeltaF/G')
xlabel('Visual block number')
title('Sines-fitted')
legend('Normal-reared','Dark-reared','','','','')

figure(); hold on
plot(calNormAvg(:,2),'Color','k')
plot(calDarkAvg(:,2),'Color','b')
plot(fitLineCalNormAvg,'Color','k')
plot(fitLineCalDarkAvg,'Color','b')
ylabel('% DeltaF/G')
xlabel('Visual block number')
title('Unfitted, normalized')
legend('Normal-reared','Dark-reared','','','','')

% subplot(2,1,2); hold on
% plot(calNormAvg(:,4),'Color','k')
% plot(calDarkAvg(:,4),'Color','b')
% plot(fitLineCalNormAvgSine,'Color','k')
% plot(fitLineCalDarkAvgSine,'Color','b')
% ylabel('% DeltaF/G')
% xlabel('Visual block number')
% title('Sines-fitted')
% legend('Normal-reared','Dark-reared','','','','')

% figure(); hold on
% scatter([calDelayRSdarkPopAvg calDelayRSnormPopAvg],[Ydelay Ydelay])
% scatter([calDelayRSdarkSinePopAvg(1:4) calDelayRSsineNormPopAvg(1:4)],[Ydelay(1:4) Ydelay(1:4)])
% yticks(1:6)
% ylim([0 7])
% yticklabels({'step 10\circ{}/s','step 5\circ{}/s','4','2','1','0.5'})
% ylabel('Frequency (Hz)')
% title('Calcium peak delay re retinal slip peak')
% xlabel('Time (ms)')
% legend('Dark-reared','Normal-reared','Dark-reared sines-fitted','Normal-reared sines-fitted')


%% Plot calcium time across training blocks
calBlockAmpIdxNormAvgPeak = calBlockAmpIdxNormAvg(:,2);
calBlockAmpIdxNormAvgPeak(:,2) = calBlockAmpIdxNormAvgSine(:,6);
calBlockAmpIdxDarkAvgPeak = calBlockAmpIdxDarkAvg(:,2);
calBlockAmpIdxDarkAvgPeak(:,2) = calBlockAmpIdxDarkAvg(:,6);

fitLineCalBlockAmpIdxNorm = fitlm(1:length(calBlockAmpIdxNormAvgPeak(:,1)),calBlockAmpIdxNormAvgPeak(:,1));
r2calBlockAmpIdxNorm = fitLineCalBlockAmpIdxNorm.Rsquared.Ordinary;
fitLineCalBlockAmpIdxNormSine = fitlm(1:length(calBlockAmpIdxNormAvgPeak(:,1)),calBlockAmpIdxNormAvgPeak(:,2));
r2calBlockAmpIdxNormSine = fitLineCalBlockAmpIdxNormSine.Rsquared.Ordinary;
fitLineCalBlockAmpIdxDark = fitlm(1:length(calBlockAmpIdxDarkAvgPeak(:,1)),calBlockAmpIdxDarkAvgPeak(:,1));
r2calBlockAmpIdxDark = fitLineCalBlockAmpIdxDark.Rsquared.Ordinary;
fitLineCalBlockAmpIdxDarkSine = fitlm(1:length(calBlockAmpIdxDarkAvgPeak(:,1)),calBlockAmpIdxDarkAvgPeak(:,2));
r2calBlockAmpIdxDarkSine = fitLineCalBlockAmpIdxDarkSine.Rsquared.Ordinary;

figure()
subplot(2,1,1); hold on
plot(calBlockAmpIdxNormAvgPeak(:,1),'Color','k')
plot(calBlockAmpIdxDarkAvgPeak(:,1),'Color','b')
plot(fitLineCalBlockAmpIdxNorm,'Color','k')
plot(fitLineCalBlockAmpIdxDark,'Color','b')
plot(drumBlockAmpIdxContraNormAvg,'Color','m')
plot(drumBlockAmpIdxContraDarkAvg,'Color','m')
% plot(rsBlockAmpIdxNormAvg(:,1),'Color','cyan')
% plot(rsBlockAmpIdxDarkAvg(:,1),'Color','cyan')
ylabel('Time (ms)')
xlabel('')
title('Unfitted')
legend('')

subplot(2,1,2); hold on
plot(calBlockAmpIdxNormAvgPeak(:,2),'Color','k')
plot(calBlockAmpIdxDarkAvgPeak(:,2),'Color','b')
plot(fitLineCalBlockAmpIdxNormSine,'Color','k')
plot(fitLineCalBlockAmpIdxDarkSine,'Color','b')
plot(drumBlockAmpIdxContraNormAvg,'Color','m')
plot(drumBlockAmpIdxContraDarkAvg,'Color','m')
% plot(rsBlockAmpIdxNormAvg(:,1),'Color','cyan')
% plot(rsBlockAmpIdxDarkAvg(:,1),'Color','cyan')
ylabel('Time (ms)')
xlabel('Visual block number')
title('Sines-fitted')
legend('Normal-reared','Dark-reared','','','','','','','','','','','')


