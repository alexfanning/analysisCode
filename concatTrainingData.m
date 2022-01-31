%% Concatenate data across experiments from same subject (#1)
%extract data from 1st experiment
cd 'C:\Users\afanning\Documents\Data\FP\SMCS1\data1007\data10071'
sx1 = dir('madDesac10071.mat');
DataSx1 = load('madDesac10071');
varNames = fieldnames(DataSx1);

[isTrue, idxRSlight] = ismember('rsLight', varNames);
[isTrue, idxRSsineSingle] = ismember('rsSineSingle', varNames);
[isTrue, idxRSlAmp] = ismember('rsLamp', varNames);
[isTrue, idxRSlAmpIdx] = ismember('rsLampIdx', varNames);
[isTrue, idxSavg] = ismember('Savg', varNames);
[isTrue, idxCalAmpSpNorm] = ismember('calAmpSpNorm', varNames);
[isTrue, idxCalDampSpNorm] = ismember('calDampSpNorm', varNames);
[isTrue, idxDavg] = ismember('Davg', varNames);
[isTrue, idxCalDsineSingle] = ismember('calDsineSingle', varNames);
[isTrue, idxCalDblockAmp] = ismember('calDblockAmp', varNames);
[isTrue, idxCalDblockAmpIdx] = ismember('calDblockAmpIdx', varNames);
[isTrue, idxLavg] = ismember('Lavg', varNames);
[isTrue, idxCalSineSingle] = ismember('calSineSingle', varNames);
[isTrue, idxCalBlockAmp] = ismember('calBlockAmp', varNames);
[isTrue, idxCalBlockAmpIdx] = ismember('calBlockAmpIdx', varNames);
[isTrue, idxFiltEyeDmadAvg] = ismember('filtEyeDmadAvg', varNames);
[isTrue, idxFiltEyeDsine] = ismember('filtEyeDsine', varNames);
[isTrue, idxFiltEyeDmadAmp] = ismember('filtEyeDmadAmp', varNames);
[isTrue, idxFiltEyeDmadAmpIdx] = ismember('filtEyeDmadAmpIdx', varNames);
[isTrue, idxFiltEyeMadAvg] = ismember('filtEyeMadAvg', varNames);
[isTrue, idxFiltEyeMadAmp] = ismember('filtEyeMadAmp', varNames);
[isTrue, idxFiltEyeMadAmpIdx] = ismember('filtEyeMadAmpIdx', varNames);
[isTrue, idxFiltEyeSine] = ismember('filtEyeSine', varNames);
[isTrue, idxEyeSpAvg] = ismember('eyeSpAvg', varNames);
[isTrue, idxEyeDgain] = ismember('eyeDgain', varNames);
[isTrue, idxEyeLgain] = ismember('eyeLgain', varNames);
[isTrue, idxTurntableDarkAvg] = ismember('turntableDarkAvg', varNames);
[isTrue, idxTurntableLightAvg] = ismember('turntableLightAvg', varNames);
[isTrue, idxDrumLightAvg] = ismember('drumLightAvg', varNames);

rsLight1 = [];
rsLight1 = [rsLight1; DataSx1.(varNames{idxRSlight})];
rsSineSingle1 = [];
rsSineSingle1 = [rsSineSingle1; DataSx1.(varNames{idxRSsineSingle})];
rsLamp1 = [];
rsLamp1 = [rsLamp1; DataSx1.(varNames{idxRSlAmp})];
rsLampIdx1 = [];
rsLampIdx1 = [rsLampIdx1; DataSx1.(varNames{idxRSlAmpIdx})];
sAvg1 = [];
sAvg1 = [sAvg1; DataSx1.(varNames{idxSavg})];
calAmpSpNorm1 = [];
calAmpSpNorm1 = [calAmpSpNorm1; DataSx1.(varNames{idxCalAmpSpNorm})];
calDampSpNorm1 = [];
calDampSpNorm1 = [calDampSpNorm1; DataSx1.(varNames{idxCalDampSpNorm})];
Davg1 = [];
Davg1 = [Davg1; DataSx1.(varNames{idxDavg})];
calDsineSingle1 = [];
calDsineSingle1 = [calDsineSingle1; DataSx1.(varNames{idxCalDsineSingle})];
calDblockAmp1 = [];
calDblockAmp1 = [calDblockAmp1; DataSx1.(varNames{idxCalDblockAmp})];
calDblockAmpIdx1 = [];
calDblockAmpIdx1 = [calDblockAmpIdx1; DataSx1.(varNames{idxCalDblockAmpIdx})];
Lavg1 = [];
Lavg1 = [Lavg1; DataSx1.(varNames{idxLavg})];
calSineSingle1 = [];
calSineSingle1 = [calSineSingle1; DataSx1.(varNames{idxCalSineSingle})];
calBlockAmp1 = [];
calBlockAmp1 = [calBlockAmp1; DataSx1.(varNames{idxCalBlockAmp})];
calBlockAmpIdx1 = [];
calBlockAmpIdx1 = [calBlockAmpIdx1; DataSx1.(varNames{idxCalBlockAmpIdx})];
filtEyeDmadAvg1 = [];
filtEyeDmadAvg1 = [filtEyeDmadAvg1; DataSx1.(varNames{idxFiltEyeDmadAvg})];
filtEyeDsine1 = [];
filtEyeDsine1 = [filtEyeDsine1; DataSx1.(varNames{idxFiltEyeDsine})];
filtEyeDmadAmp1 = [];
filtEyeDmadAmp1 = [filtEyeDmadAmp1; DataSx1.(varNames{idxFiltEyeDmadAmp})];
filtEyeDmadAmpIdx1 = [];
filtEyeDmadAmpIdx1 = [filtEyeDmadAmpIdx1; DataSx1.(varNames{idxFiltEyeDmadAmpIdx})];
filtEyeMadAvg1 = [];
filtEyeMadAvg1 = [filtEyeMadAvg1; DataSx1.(varNames{idxFiltEyeMadAvg})];
filtEyeSine1 = [];
filtEyeSine1 = [filtEyeSine1; DataSx1.(varNames{idxFiltEyeSine})];
filtEyeMadAmp1 = [];
filtEyeMadAmp1 = [filtEyeMadAmp1; DataSx1.(varNames{idxFiltEyeMadAmp})];
filtEyeMadAmpIdx1 = [];
filtEyeMadAmpIdx1 = [filtEyeMadAmpIdx1; DataSx1.(varNames{idxFiltEyeMadAmpIdx})];
eyeSpAvg1 = [];
eyeSpAvg1 = [eyeSpAvg1; DataSx1.(varNames{idxEyeSpAvg})];
eyeDgain1 = [];
eyeDgain1 = [eyeDgain1; DataSx1.(varNames{idxEyeDgain})];
eyeLgain1 = [];
eyeLgain1 = [eyeLgain1; DataSx1.(varNames{idxEyeLgain})];
turntableDark1 = [];
turntableDark1 = [turntableDark1; DataSx1.(varNames{idxTurntableDarkAvg})];
turntableLightAvg1 = [];
turntableLightAvg1 = [turntableLightAvg1; DataSx1.(varNames{idxTurntableLightAvg})];
drumLightAvg1 = [];
drumLightAvg1 = [drumLightAvg1; DataSx1.(varNames{idxDrumLightAvg})];

%% Concatenate data across experiments from same subject (#2)
%extract data from 1st experiment
cd 'C:\Users\afanning\Documents\Data\FP\SMCS3\data1011\data101123'
sx2 = dir('madDesac101123.mat');
DataSx2 = load('madDesac101123');
varNames = fieldnames(DataSx2);

[isTrue, idxRSlight] = ismember('rsLight', varNames);
[isTrue, idxRSsineSingle] = ismember('rsSineSingle', varNames);
[isTrue, idxRSlAmp] = ismember('rsLamp', varNames);
[isTrue, idxRSlAmpIdx] = ismember('rsLampIdx', varNames);
[isTrue, idxSavg] = ismember('Savg', varNames);
[isTrue, idxCalAmpSpNorm] = ismember('calAmpSpNorm', varNames);
[isTrue, idxCalDampSpNorm] = ismember('calDampSpNorm', varNames);
[isTrue, idxDavg] = ismember('Davg', varNames);
[isTrue, idxCalDsineSingle] = ismember('calDsineSingle', varNames);
[isTrue, idxCalDblockAmp] = ismember('calDblockAmp', varNames);
[isTrue, idxCalDblockAmpIdx] = ismember('calDblockAmpIdx', varNames);
[isTrue, idxLavg] = ismember('Lavg', varNames);
[isTrue, idxCalSineSingle] = ismember('calSineSingle', varNames);
[isTrue, idxCalBlockAmp] = ismember('calBlockAmp', varNames);
[isTrue, idxCalBlockAmpIdx] = ismember('calBlockAmpIdx', varNames);
[isTrue, idxFiltEyeDmadAvg] = ismember('filtEyeDmadAvg', varNames);
[isTrue, idxFiltEyeDsine] = ismember('filtEyeDsine', varNames);
[isTrue, idxFiltEyeDmadAmp] = ismember('filtEyeDmadAmp', varNames);
[isTrue, idxFiltEyeDmadAmpIdx] = ismember('filtEyeDmadAmpIdx', varNames);
[isTrue, idxFiltEyeMadAvg] = ismember('filtEyeMadAvg', varNames);
[isTrue, idxFiltEyeMadAmp] = ismember('filtEyeMadAmp', varNames);
[isTrue, idxFiltEyeMadAmpIdx] = ismember('filtEyeMadAmpIdx', varNames);
[isTrue, idxFiltEyeSine] = ismember('filtEyeSine', varNames);
[isTrue, idxEyeSpAvg] = ismember('eyeSpAvg', varNames);
[isTrue, idxEyeDgain] = ismember('eyeDgain', varNames);
[isTrue, idxEyeLgain] = ismember('eyeLgain', varNames);

rsLight2 = [];
rsLight2 = [rsLight2; DataSx2.(varNames{idxRSlight})];
rsSineSingle2 = [];
rsSineSingle2 = [rsSineSingle2; DataSx2.(varNames{idxRSsineSingle})];
rsLamp2 = [];
rsLamp2 = [rsLamp2; DataSx2.(varNames{idxRSlAmp})];
rsLampIdx2 = [];
rsLampIdx2 = [rsLampIdx2; DataSx2.(varNames{idxRSlAmpIdx})];
sAvg2 = [];
sAvg2 = [sAvg2; DataSx2.(varNames{idxSavg})];
calAmpSpNorm2 = [];
calAmpSpNorm2 = [calAmpSpNorm2; DataSx2.(varNames{idxCalAmpSpNorm})];
calDampSpNorm2 = [];
calDampSpNorm2 = [calDampSpNorm2; DataSx2.(varNames{idxCalDampSpNorm})];
Davg2 = [];
Davg2 = [Davg2; DataSx2.(varNames{idxDavg})];
calDsineSingle2 = [];
calDsineSingle2 = [calDsineSingle2; DataSx2.(varNames{idxCalDsineSingle})];
calDblockAmp2 = [];
calDblockAmp2 = [calDblockAmp2; DataSx2.(varNames{idxCalDblockAmp})];
calDblockAmpIdx2 = [];
calDblockAmpIdx2 = [calDblockAmpIdx2; DataSx2.(varNames{idxCalDblockAmpIdx})];
Lavg2 = [];
Lavg2 = [Lavg2; DataSx2.(varNames{idxLavg})];
calSineSingle2 = [];
calSineSingle2 = [calSineSingle2; DataSx2.(varNames{idxCalSineSingle})];
calBlockAmp2 = [];
calBlockAmp2 = [calBlockAmp2; DataSx2.(varNames{idxCalBlockAmp})];
calBlockAmpIdx2 = [];
calBlockAmpIdx2 = [calBlockAmpIdx2; DataSx2.(varNames{idxCalBlockAmpIdx})];
filtEyeDmadAvg2 = [];
filtEyeDmadAvg2 = [filtEyeDmadAvg2; DataSx2.(varNames{idxFiltEyeDmadAvg})];
filtEyeDsine2 = [];
filtEyeDsine2 = [filtEyeDsine2; DataSx2.(varNames{idxFiltEyeDsine})];
filtEyeDmadAmp2 = [];
filtEyeDmadAmp2 = [filtEyeDmadAmp2; DataSx2.(varNames{idxFiltEyeDmadAmp})];
filtEyeDmadAmpIdx2 = [];
filtEyeDmadAmpIdx2 = [filtEyeDmadAmpIdx2; DataSx2.(varNames{idxFiltEyeDmadAmpIdx})];
filtEyeMadAvg2 = [];
filtEyeMadAvg2 = [filtEyeMadAvg2; DataSx2.(varNames{idxFiltEyeMadAvg})];
filtEyeSine2 = [];
filtEyeSine2 = [filtEyeSine2; DataSx2.(varNames{idxFiltEyeSine})];
filtEyeMadAmp2 = [];
filtEyeMadAmp2 = [filtEyeMadAmp2; DataSx2.(varNames{idxFiltEyeMadAmp})];
filtEyeMadAmpIdx2 = [];
filtEyeMadAmpIdx2 = [filtEyeMadAmpIdx2; DataSx2.(varNames{idxFiltEyeMadAmpIdx})];
eyeSpAvg2 = [];
eyeSpAvg2 = [eyeSpAvg2; DataSx2.(varNames{idxEyeSpAvg})];
eyeDgain2 = [];
eyeDgain2 = [eyeDgain2; DataSx2.(varNames{idxEyeDgain})];
eyeLgain2 = [];
eyeLgain2 = [eyeLgain2; DataSx2.(varNames{idxEyeLgain})];

%% Concatenate data across experiments from same subject (#3)
%extract data from 1st experiment
cd 'C:\Users\afanning\Documents\Data\FP\SMCS12\data0109\data010913'
sx3 = dir('madDesac010913.mat');
DataSx3 = load('madDesac010913');
varNames = fieldnames(DataSx3);

[isTrue, idxRSlight] = ismember('rsLight', varNames);
[isTrue, idxRSsineSingle] = ismember('rsSineSingle', varNames);
[isTrue, idxRSlAmp] = ismember('rsLamp', varNames);
[isTrue, idxRSlAmpIdx] = ismember('rsLampIdx', varNames);
[isTrue, idxSavg] = ismember('Savg', varNames);
[isTrue, idxCalAmpSpNorm] = ismember('calAmpSpNorm', varNames);
[isTrue, idxCalDampSpNorm] = ismember('calDampSpNorm', varNames);
[isTrue, idxDavg] = ismember('Davg', varNames);
[isTrue, idxCalDsineSingle] = ismember('calDsineSingle', varNames);
[isTrue, idxCalDblockAmp] = ismember('calDblockAmp', varNames);
[isTrue, idxCalDblockAmpIdx] = ismember('calDblockAmpIdx', varNames);
[isTrue, idxLavg] = ismember('Lavg', varNames);
[isTrue, idxCalSineSingle] = ismember('calSineSingle', varNames);
[isTrue, idxCalBlockAmp] = ismember('calBlockAmp', varNames);
[isTrue, idxCalBlockAmpIdx] = ismember('calBlockAmpIdx', varNames);
[isTrue, idxFiltEyeDmadAvg] = ismember('filtEyeDmadAvg', varNames);
[isTrue, idxFiltEyeDsine] = ismember('filtEyeDsine', varNames);
[isTrue, idxFiltEyeDmadAmp] = ismember('filtEyeDmadAmp', varNames);
[isTrue, idxFiltEyeDmadAmpIdx] = ismember('filtEyeDmadAmpIdx', varNames);
[isTrue, idxFiltEyeMadAvg] = ismember('filtEyeMadAvg', varNames);
[isTrue, idxFiltEyeMadAmp] = ismember('filtEyeMadAmp', varNames);
[isTrue, idxFiltEyeMadAmpIdx] = ismember('filtEyeMadAmpIdx', varNames);
[isTrue, idxFiltEyeSine] = ismember('filtEyeSine', varNames);
[isTrue, idxEyeSpAvg] = ismember('eyeSpAvg', varNames);
[isTrue, idxEyeDgain] = ismember('eyeDgain', varNames);
[isTrue, idxEyeLgain] = ismember('eyeLgain', varNames);

rsLight3 = [];
rsLight3 = [rsLight3; DataSx3.(varNames{idxRSlight})];
rsSineSingle3 = [];
rsSineSingle3 = [rsSineSingle3; DataSx3.(varNames{idxRSsineSingle})];
rsLamp3 = [];
rsLamp3 = [rsLamp3; DataSx3.(varNames{idxRSlAmp})];
rsLampIdx3 = [];
rsLampIdx3 = [rsLampIdx3; DataSx3.(varNames{idxRSlAmpIdx})];
sAvg3 = [];
sAvg3 = [sAvg3; DataSx3.(varNames{idxSavg})];
calAmpSpNorm3 = [];
calAmpSpNorm3 = [calAmpSpNorm3; DataSx3.(varNames{idxCalAmpSpNorm})];
calDampSpNorm3 = [];
calDampSpNorm3 = [calDampSpNorm3; DataSx3.(varNames{idxCalDampSpNorm})];
Davg3 = [];
Davg3 = [Davg3; DataSx3.(varNames{idxDavg})];
calDsineSingle3 = [];
calDsineSingle3 = [calDsineSingle3; DataSx3.(varNames{idxCalDsineSingle})];
calDblockAmp3 = [];
calDblockAmp3 = [calDblockAmp3; DataSx3.(varNames{idxCalDblockAmp})];
calDblockAmpIdx3 = [];
calDblockAmpIdx3 = [calDblockAmpIdx3; DataSx3.(varNames{idxCalDblockAmpIdx})];
Lavg3 = [];
Lavg3 = [Lavg3; DataSx3.(varNames{idxLavg})];
calSineSingle3 = [];
calSineSingle3 = [calSineSingle3; DataSx3.(varNames{idxCalSineSingle})];
calBlockAmp3 = [];
calBlockAmp3 = [calBlockAmp3; DataSx3.(varNames{idxCalBlockAmp})];
calBlockAmpIdx3 = [];
calBlockAmpIdx3 = [calBlockAmpIdx3; DataSx3.(varNames{idxCalBlockAmpIdx})];
filtEyeDmadAvg3 = [];
filtEyeDmadAvg3 = [filtEyeDmadAvg3; DataSx3.(varNames{idxFiltEyeDmadAvg})];
filtEyeDsine3 = [];
filtEyeDsine3 = [filtEyeDsine3; DataSx3.(varNames{idxFiltEyeDsine})];
filtEyeDmadAmp3 = [];
filtEyeDmadAmp3 = [filtEyeDmadAmp3; DataSx3.(varNames{idxFiltEyeDmadAmp})];
filtEyeDmadAmpIdx3 = [];
filtEyeDmadAmpIdx3 = [filtEyeDmadAmpIdx3; DataSx3.(varNames{idxFiltEyeDmadAmpIdx})];
filtEyeMadAvg3 = [];
filtEyeMadAvg3 = [filtEyeMadAvg3; DataSx3.(varNames{idxFiltEyeMadAvg})];
filtEyeSine3 = [];
filtEyeSine3 = [filtEyeSine3; DataSx3.(varNames{idxFiltEyeSine})];
filtEyeMadAmp3 = [];
filtEyeMadAmp3 = [filtEyeMadAmp3; DataSx3.(varNames{idxFiltEyeMadAmp})];
filtEyeMadAmpIdx3 = [];
filtEyeMadAmpIdx3 = [filtEyeMadAmpIdx3; DataSx3.(varNames{idxFiltEyeMadAmpIdx})];
eyeSpAvg3 = [];
eyeSpAvg3 = [eyeSpAvg3; DataSx3.(varNames{idxEyeSpAvg})];
eyeDgain3 = [];
eyeDgain3 = [eyeDgain3; DataSx3.(varNames{idxEyeDgain})];
eyeLgain3 = [];
eyeLgain3 = [eyeLgain3; DataSx3.(varNames{idxEyeLgain})];

%% Concatenate data across experiments from same subject (#4)
%extract data from 1st experiment
cd 'C:\Users\afanning\Documents\Data\FP\smcs37\smcs37data1222\smcs37data122213'
sx4 = dir('madDesac122213.mat');
DataSx4 = load('madDesac122213');
varNames = fieldnames(DataSx4);

[isTrue, idxRSlight] = ismember('rsLight', varNames);
[isTrue, idxRSsineSingle] = ismember('rsSineSingle', varNames);
[isTrue, idxRSlAmp] = ismember('rsLamp', varNames);
[isTrue, idxRSlAmpIdx] = ismember('rsLampIdx', varNames);
[isTrue, idxSavg] = ismember('Savg', varNames);
[isTrue, idxCalAmpSpNorm] = ismember('calAmpSpNorm', varNames);
[isTrue, idxCalDampSpNorm] = ismember('calDampSpNorm', varNames);
[isTrue, idxDavg] = ismember('Davg', varNames);
[isTrue, idxCalDsineSingle] = ismember('calDsineSingle', varNames);
[isTrue, idxCalDblockAmp] = ismember('calDblockAmp', varNames);
[isTrue, idxCalDblockAmpIdx] = ismember('calDblockAmpIdx', varNames);
[isTrue, idxLavg] = ismember('Lavg', varNames);
[isTrue, idxCalSineSingle] = ismember('calSineSingle', varNames);
[isTrue, idxCalBlockAmp] = ismember('calBlockAmp', varNames);
[isTrue, idxCalBlockAmpIdx] = ismember('calBlockAmpIdx', varNames);
[isTrue, idxFiltEyeDmadAvg] = ismember('filtEyeDmadAvg', varNames);
[isTrue, idxFiltEyeDsine] = ismember('filtEyeDsine', varNames);
[isTrue, idxFiltEyeDmadAmp] = ismember('filtEyeDmadAmp', varNames);
[isTrue, idxFiltEyeDmadAmpIdx] = ismember('filtEyeDmadAmpIdx', varNames);
[isTrue, idxFiltEyeMadAvg] = ismember('filtEyeMadAvg', varNames);
[isTrue, idxFiltEyeMadAmp] = ismember('filtEyeMadAmp', varNames);
[isTrue, idxFiltEyeMadAmpIdx] = ismember('filtEyeMadAmpIdx', varNames);
[isTrue, idxFiltEyeSine] = ismember('filtEyeSine', varNames);
[isTrue, idxEyeSpAvg] = ismember('eyeSpAvg', varNames);
[isTrue, idxEyeDgain] = ismember('eyeDgain', varNames);
[isTrue, idxEyeLgain] = ismember('eyeLgain', varNames);

rsLight4 = [];
rsLight4 = [rsLight4; DataSx4.(varNames{idxRSlight})];
rsSineSingle4 = [];
rsSineSingle4 = [rsSineSingle4; DataSx4.(varNames{idxRSsineSingle})];
rsLamp4 = [];
rsLamp4 = [rsLamp4; DataSx4.(varNames{idxRSlAmp})];
rsLampIdx4 = [];
rsLampIdx4 = [rsLampIdx4; DataSx4.(varNames{idxRSlAmpIdx})];
sAvg4 = [];
sAvg4 = [sAvg4; DataSx4.(varNames{idxSavg})];
calAmpSpNorm4 = [];
calAmpSpNorm4 = [calAmpSpNorm4; DataSx4.(varNames{idxCalAmpSpNorm})];
calDampSpNorm4 = [];
calDampSpNorm4 = [calDampSpNorm4; DataSx4.(varNames{idxCalDampSpNorm})];
Davg4 = [];
Davg4 = [Davg4; DataSx4.(varNames{idxDavg})];
calDsineSingle4 = [];
calDsineSingle4 = [calDsineSingle4; DataSx4.(varNames{idxCalDsineSingle})];
calDblockAmp4 = [];
calDblockAmp4 = [calDblockAmp4; DataSx4.(varNames{idxCalDblockAmp})];
calDblockAmpIdx4 = [];
calDblockAmpIdx4 = [calDblockAmpIdx4; DataSx4.(varNames{idxCalDblockAmpIdx})];
Lavg4 = [];
Lavg4 = [Lavg4; DataSx4.(varNames{idxLavg})];
calSineSingle4 = [];
calSineSingle4 = [calSineSingle4; DataSx4.(varNames{idxCalSineSingle})];
calBlockAmp4 = [];
calBlockAmp4 = [calBlockAmp4; DataSx4.(varNames{idxCalBlockAmp})];
calBlockAmpIdx4 = [];
calBlockAmpIdx4 = [calBlockAmpIdx4; DataSx4.(varNames{idxCalBlockAmpIdx})];
filtEyeDmadAvg4 = [];
filtEyeDmadAvg4 = [filtEyeDmadAvg4; DataSx4.(varNames{idxFiltEyeDmadAvg})];
filtEyeDsine4 = [];
filtEyeDsine4 = [filtEyeDsine4; DataSx4.(varNames{idxFiltEyeDsine})];
filtEyeDmadAmp4 = [];
filtEyeDmadAmp4 = [filtEyeDmadAmp4; DataSx4.(varNames{idxFiltEyeDmadAmp})];
filtEyeDmadAmpIdx4 = [];
filtEyeDmadAmpIdx4 = [filtEyeDmadAmpIdx4; DataSx4.(varNames{idxFiltEyeDmadAmpIdx})];
filtEyeMadAvg4 = [];
filtEyeMadAvg4 = [filtEyeMadAvg4; DataSx4.(varNames{idxFiltEyeMadAvg})];
filtEyeSine4 = [];
filtEyeSine4 = [filtEyeSine4; DataSx4.(varNames{idxFiltEyeSine})];
filtEyeMadAmp4 = [];
filtEyeMadAmp4 = [filtEyeMadAmp4; DataSx4.(varNames{idxFiltEyeMadAmp})];
filtEyeMadAmpIdx4 = [];
filtEyeMadAmpIdx4 = [filtEyeMadAmpIdx4; DataSx4.(varNames{idxFiltEyeMadAmpIdx})];
eyeSpAvg4 = [];
eyeSpAvg4 = [eyeSpAvg4; DataSx4.(varNames{idxEyeSpAvg})];
eyeDgain4 = [];
eyeDgain4 = [eyeDgain4; DataSx4.(varNames{idxEyeDgain})];
eyeLgain4 = [];
eyeLgain4 = [eyeLgain4; DataSx4.(varNames{idxEyeLgain})];

%% Concatenate data across experiments from same subject (#5)
%extract data from 1st experiment
cd 'C:\Users\afanning\Documents\Data\FP\smcs38\smcs38data0114\smcs38data01141'
sx5 = dir('madDesac01141.mat');
DataSx5 = load('madDesac01141');
varNames = fieldnames(DataSx5);

[isTrue, idxRSlight] = ismember('rsLight', varNames);
[isTrue, idxRSsineSingle] = ismember('rsSineSingle', varNames);
[isTrue, idxRSlAmp] = ismember('rsLamp', varNames);
[isTrue, idxRSlAmpIdx] = ismember('rsLampIdx', varNames);
[isTrue, idxSavg] = ismember('Savg', varNames);
[isTrue, idxCalAmpSpNorm] = ismember('calAmpSpNorm', varNames);
[isTrue, idxCalDampSpNorm] = ismember('calDampSpNorm', varNames);
[isTrue, idxDavg] = ismember('Davg', varNames);
[isTrue, idxCalDsineSingle] = ismember('calDsineSingle', varNames);
[isTrue, idxCalDblockAmp] = ismember('calDblockAmp', varNames);
[isTrue, idxCalDblockAmpIdx] = ismember('calDblockAmpIdx', varNames);
[isTrue, idxLavg] = ismember('Lavg', varNames);
[isTrue, idxCalSineSingle] = ismember('calSineSingle', varNames);
[isTrue, idxCalBlockAmp] = ismember('calBlockAmp', varNames);
[isTrue, idxCalBlockAmpIdx] = ismember('calBlockAmpIdx', varNames);
[isTrue, idxFiltEyeDmadAvg] = ismember('filtEyeDmadAvg', varNames);
[isTrue, idxFiltEyeDsine] = ismember('filtEyeDsine', varNames);
[isTrue, idxFiltEyeDmadAmp] = ismember('filtEyeDmadAmp', varNames);
[isTrue, idxFiltEyeDmadAmpIdx] = ismember('filtEyeDmadAmpIdx', varNames);
[isTrue, idxFiltEyeMadAvg] = ismember('filtEyeMadAvg', varNames);
[isTrue, idxFiltEyeMadAmp] = ismember('filtEyeMadAmp', varNames);
[isTrue, idxFiltEyeMadAmpIdx] = ismember('filtEyeMadAmpIdx', varNames);
[isTrue, idxFiltEyeSine] = ismember('filtEyeSine', varNames);
[isTrue, idxEyeSpAvg] = ismember('eyeSpAvg', varNames);
[isTrue, idxEyeDgain] = ismember('eyeDgain', varNames);
[isTrue, idxEyeLgain] = ismember('eyeLgain', varNames);

rsLight5 = [];
rsLight5 = [rsLight5; DataSx5.(varNames{idxRSlight})];
rsSineSingle5 = [];
rsSineSingle5 = [rsSineSingle5; DataSx5.(varNames{idxRSsineSingle})];
rsLamp5 = [];
rsLamp5 = [rsLamp5; DataSx5.(varNames{idxRSlAmp})];
rsLampIdx5 = [];
rsLampIdx5 = [rsLampIdx5; DataSx5.(varNames{idxRSlAmpIdx})];
sAvg5 = [];
sAvg5 = [sAvg5; DataSx5.(varNames{idxSavg})];
calAmpSpNorm5 = [];
calAmpSpNorm5 = [calAmpSpNorm5; DataSx5.(varNames{idxCalAmpSpNorm})];
calDampSpNorm5 = [];
calDampSpNorm5 = [calDampSpNorm5; DataSx5.(varNames{idxCalDampSpNorm})];
Davg5 = [];
Davg5 = [Davg5; DataSx5.(varNames{idxDavg})];
calDsineSingle5 = [];
calDsineSingle5 = [calDsineSingle5; DataSx5.(varNames{idxCalDsineSingle})];
calDblockAmp5 = [];
calDblockAmp5 = [calDblockAmp5; DataSx5.(varNames{idxCalDblockAmp})];
calDblockAmpIdx5 = [];
calDblockAmpIdx5 = [calDblockAmpIdx5; DataSx5.(varNames{idxCalDblockAmpIdx})];
Lavg5 = [];
Lavg5 = [Lavg5; DataSx5.(varNames{idxLavg})];
calSineSingle5 = [];
calSineSingle5 = [calSineSingle5; DataSx5.(varNames{idxCalSineSingle})];
calBlockAmp5 = [];
calBlockAmp5 = [calBlockAmp5; DataSx5.(varNames{idxCalBlockAmp})];
calBlockAmpIdx5 = [];
calBlockAmpIdx5 = [calBlockAmpIdx5; DataSx5.(varNames{idxCalBlockAmpIdx})];
filtEyeDmadAvg5 = [];
filtEyeDmadAvg5 = [filtEyeDmadAvg5; DataSx5.(varNames{idxFiltEyeDmadAvg})];
filtEyeDsine5 = [];
filtEyeDsine5 = [filtEyeDsine5; DataSx5.(varNames{idxFiltEyeDsine})];
filtEyeDmadAmp5 = [];
filtEyeDmadAmp5 = [filtEyeDmadAmp5; DataSx5.(varNames{idxFiltEyeDmadAmp})];
filtEyeDmadAmpIdx5 = [];
filtEyeDmadAmpIdx5 = [filtEyeDmadAmpIdx5; DataSx5.(varNames{idxFiltEyeDmadAmpIdx})];
filtEyeMadAvg5 = [];
filtEyeMadAvg5 = [filtEyeMadAvg5; DataSx5.(varNames{idxFiltEyeMadAvg})];
filtEyeSine5 = [];
filtEyeSine5 = [filtEyeSine5; DataSx5.(varNames{idxFiltEyeSine})];
filtEyeMadAmp5 = [];
filtEyeMadAmp5 = [filtEyeMadAmp5; DataSx5.(varNames{idxFiltEyeMadAmp})];
filtEyeMadAmpIdx5 = [];
filtEyeMadAmpIdx5 = [filtEyeMadAmpIdx5; DataSx5.(varNames{idxFiltEyeMadAmpIdx})];
eyeSpAvg5 = [];
eyeSpAvg5 = [eyeSpAvg5; DataSx5.(varNames{idxEyeSpAvg})];
eyeDgain5 = [];
eyeDgain5 = [eyeDgain5; DataSx5.(varNames{idxEyeDgain})];
eyeLgain5 = [];
eyeLgain5 = [eyeLgain5; DataSx5.(varNames{idxEyeLgain})];

%% Further concatenation and population averaging
calBlockAmp = cat(1,calBlockAmp1,calBlockAmp2,calBlockAmp3,calBlockAmp4,calBlockAmp5);
calBlockAmp = reshape(calBlockAmp,6,5);
calBlockAmpAvg = mean(calBlockAmp,2);
figure(); hold on
plot(calBlockAmp*100)
plot(calBlockAmpAvg*100)
ylabel('% \DeltaF/G')
xlabel('Block number')

calDblockAmp = cat(1,calDblockAmp1,calDblockAmp2,calDblockAmp3,calDblockAmp4,calDblockAmp5);
calDblockAmp = reshape(calDblockAmp,12,5);
calDblockAmpAvg = mean(calDblockAmp,2);
figure(); hold on
plot(calDblockAmp)
plot(calDblockAmpAvg)
ylabel('% \DeltaF/G')
xlabel('Block number')

calBlockAmpIdx = cat(1,calBlockAmpIdx1,calBlockAmpIdx2,calBlockAmpIdx3,calBlockAmpIdx4,calBlockAmpIdx5);
calBlockAmpIdx = reshape(calBlockAmpIdx,6,5);
calBlockAmpIdx = cell2mat(calBlockAmpIdx);
calBlockAmpIdxAvg = mean(calBlockAmpIdx,2);
figure(); hold on
plot(calBlockAmpIdx)
plot(calBlockAmpIdxAvg) %%%3rd subject has last block way off for time
ylabel('Time')
xlabel('Block number')

calDblockAmpIdx = cat(1,calDblockAmpIdx1,calDblockAmpIdx2,calDblockAmpIdx3,calDblockAmpIdx4,calDblockAmpIdx5);
calDblockAmpIdx = reshape(calDblockAmpIdx,12,5);
calDblockAmpIdx = cell2mat(calDblockAmpIdx);
calDblockAmpIdxAvg = mean(calDblockAmpIdx,2);
figure(); hold on
plot(calDblockAmpIdx)
plot(calDblockAmpIdxAvg)
ylabel('Time')
xlabel('Block number')

calAmpSpNorm = cat(2,calAmpSpNorm1,calAmpSpNorm2,calAmpSpNorm3,calAmpSpNorm4,calAmpSpNorm5);
calAmpSpNorm = reshape(calAmpSpNorm,1000,30);
calNorm = cell(1,6);
calNorm{1} = calAmpSpNorm(:,1:6:end);
calNorm{2} = calAmpSpNorm(:,2:6:end);
calNorm{3} = calAmpSpNorm(:,3:6:end);
calNorm{4} = calAmpSpNorm(:,4:6:end);
calNorm{5} = calAmpSpNorm(:,5:6:end);
calNorm{6} = calAmpSpNorm(:,6:6:end);
calNormAvg = cell(1,6);
for i = 1:6
    calNormAvg{i} = mean(calNorm{i},2);
end
calNormAvg = cell2mat(calNormAvg);
calNormPopAvg = mean(calNormAvg,2);
turntableLightResize = rescale(turntableLightAvg1,-0.4,0.4);
drumLightResize = rescale(drumLightAvg1,-0.4,0.4);
figure(); hold on
plot(calNormAvg)
plot(turntableLightResize,'LineWidth',2)
plot(drumLightResize,'LineWidth',2)
ylabel('%\DeltaF/G')
xlabel('Time (ms)')

calDampSpNorm = cat(2,calDampSpNorm1,calDampSpNorm2,calDampSpNorm3,calDampSpNorm4,calDampSpNorm5);
calDampSpNorm = reshape(calDampSpNorm,1000,30);
calDnorm = cell(1,6);
calDnorm{1} = calDampSpNorm(:,1:6:end);
calDnorm{2} = calDampSpNorm(:,2:6:end);
calDnorm{3} = calDampSpNorm(:,3:6:end);
calDnorm{4} = calDampSpNorm(:,4:6:end);
calDnorm{5} = calDampSpNorm(:,5:6:end);
calDnorm{6} = calDampSpNorm(:,6:6:end);
calDnormAvg = cell(1,6);
for i = 1:6
    calDnormAvg{i} = mean(calDnorm{i},2);
end
calDnormAvg = cell2mat(calDnormAvg);
calDnormPopAvg = mean(calDnormAvg,2);
turntableLightResize = rescale(turntableLightAvg1,-0.4,0.4);
drumLightResize = rescale(drumLightAvg1,-0.4,0.4);
figure(); hold on
plot(calDnormAvg)
plot(turntableLightResize,'LineWidth',2)
plot(drumLightResize,'LineWidth',2)
ylabel('%\DeltaF/G')
xlabel('Time (ms)')

Lavg = cat(2,Lavg1,Lavg2,Lavg3,Lavg4,Lavg5);
Lavg = cell2mat(Lavg);
Lavg = reshape(Lavg,1000,30);
lightAvg = cell(1000,6);
lightAvg{1} = Lavg(:,1:6:end);
lightAvg{2} = Lavg(:,2:6:end);
lightAvg{3} = Lavg(:,3:6:end);
lightAvg{4} = Lavg(:,4:6:end);
lightAvg{5} = Lavg(:,5:6:end);
lightAvg{6} = Lavg(:,6:6:end);
lightAllAvg = cell(1,6);
for i = 1:6
    lightAllAvg{i} = mean(lightAvg{i}*100,2);
end
lightAllAvg = cell2mat(lightAllAvg);
lightAllPopAvg = mean(lightAllAvg,2);
turntableLightResize = rescale(turntableLightAvg1,0.3,0.8);
drumLightResize = rescale(drumLightAvg1,0.3,0.8);
figure(); hold on
plot(lightAllAvg)
plot(lightAllPopAvg)
plot(turntableLightResize,'LineWidth',2)
plot(drumLightResize,'LineWidth',2)
ylabel('%\DeltaF/G')
xlabel('Time (ms)')

Davg = cat(2,Davg1,Davg2,Davg3,Davg4,Davg5);
Davg = cell2mat(Davg);
Davg = reshape(Davg,1000,60);
darkAvg = cell(1,7);
darkAvg{1} = Davg(:,3:12:end);
darkAvg{2} = Davg(:,4:12:end);
darkAvg{3} = Davg(:,5:12:end);
darkAvg{4} = Davg(:,6:12:end);
darkAvg{5} = Davg(:,7:12:end);
darkAvg{6} = Davg(:,8:12:end);
darkAvg{7} = Davg(:,9:12:end);
darkAvgAvg = cell(1,7);
for i = 1:7
    darkAvgAvg{i} = nanmean(darkAvg{i}*100,2);
end
darkAvgAvg = cell2mat(darkAvgAvg);
darkAvgPopAvg = mean(darkAvgAvg,2);
turntableDarkResize = rescale(turntableDark1,0.2,0.8);
figure(); hold on
plot(darkAvgAvg)
plot(turntableDarkResize,'LineWidth',2)
ylabel('%\DeltaF/G')
xlabel('Time (ms)')

calSineSingle = cat(2,calSineSingle1,calSineSingle2,calSineSingle3,calSineSingle4,calSineSingle5);
calSineSingle = reshape(calSineSingle,1000,30);
calSine = cell(1,6);
calSine{1} = calSineSingle(:,1:6:end);
calSine{2} = calSineSingle(:,2:6:end);
calSine{3} = calSineSingle(:,3:6:end);
calSine{4} = calSineSingle(:,4:6:end);
calSine{5} = calSineSingle(:,5:6:end);
calSine{6} = calSineSingle(:,6:6:end);
calSineAvg = cell(1,6);
for i = 1:6
    calSineAvg{i} = mean(calSine{i}*100,2);
end
calSineAvg = cell2mat(calSineAvg);
calSinePopAvg = mean(calSineAvg,2);
turntableLightResize = rescale(turntableLightAvg1,-0.2,0.3);
drumLightResize = rescale(drumLightAvg1,-0.2,0.3);
figure(); hold on
plot(calSineAvg)
plot(turntableLightResize,'LineWidth',2)
plot(drumLightResize,'LineWidth',2)
ylabel('%\DeltaF/G')
xlabel('Time (ms)')

calDsineSingle = cat(2,calDsineSingle1,calDsineSingle2,calDsineSingle3,calDsineSingle4,calDsineSingle5);
calDsineSingle = reshape(calDsineSingle,1000,30);
calDsine = cell(1,6);
calDsine{1} = calDsineSingle(:,1:6:end);
calDsine{2} = calDsineSingle(:,2:6:end);
calDsine{3} = calDsineSingle(:,3:6:end);
calDsine{4} = calDsineSingle(:,4:6:end);
calDsine{5} = calDsineSingle(:,5:6:end);
calDsine{6} = calDsineSingle(:,6:6:end);
calDsineAvg = cell(1,6);
for i = 1:6
    calDsineAvg{i} = mean(calDsine{i}*100,2);
end
calDsineAvg = cell2mat(calDsineAvg);
calDsinePopAvg = mean(calDsineAvg,2);
turntableDarkResize = rescale(turntableDark1,-0.2,0.2);
figure(); hold on
plot(calDsineAvg)
plot(turntableDarkResize,'LineWidth',2)
ylabel('%\DeltaF/G')
xlabel('Time (ms)')

filtEyeMad = cat(2,filtEyeMadAvg1,filtEyeMadAvg2,filtEyeMadAvg3,filtEyeMadAvg4,filtEyeMadAvg5);
filtEyeMad = cell2mat(filtEyeMad);
filtEyeMad = reshape(filtEyeMad,1000,30);
filtEyeL = cell(1000,6);
filtEyeL{1} = filtEyeMad(:,1:6:end);
filtEyeL{2} = filtEyeMad(:,2:6:end);
filtEyeL{3} = filtEyeMad(:,3:6:end);
filtEyeL{4} = filtEyeMad(:,4:6:end);
filtEyeL{5} = filtEyeMad(:,5:6:end);
filtEyeL{6} = filtEyeMad(:,6:6:end);
filtEyeLavg = cell(1,6);
for i = 1:6
    filtEyeLavg{i} = mean(filtEyeL{i},2);
end
filtEyeLavg = cell2mat(filtEyeLavg);
filtEyeLpopAvg = mean(filtEyeLavg,2);
turntableLightResize = rescale(turntableLightAvg1,-1,1);
drumLightResize = rescale(drumLightAvg1,-1,1);
figure(); hold on
plot(filtEyeLavg)
plot(filtEyeLpopAvg)
plot(turntableLightResize,'LineWidth',2)
plot(drumLightResize,'LineWidth',2)
ylabel('Eye velocity')
xlabel('Time (ms)')

filtEyeDmad = cat(2,filtEyeDmadAvg1,filtEyeDmadAvg2,filtEyeDmadAvg3,filtEyeDmadAvg4,filtEyeDmadAvg5);
filtEyeDmad = cell2mat(filtEyeDmad);
filtEyeDmad = reshape(filtEyeDmad,1000,60);
filtEyeD = cell(1,7);
filtEyeD{1} = filtEyeDmad(:,3:12:end);
filtEyeD{2} = filtEyeDmad(:,4:12:end);
filtEyeD{3} = filtEyeDmad(:,5:12:end);
filtEyeD{4} = filtEyeDmad(:,6:12:end);
filtEyeD{5} = filtEyeDmad(:,7:12:end);
filtEyeD{6} = filtEyeDmad(:,8:12:end);
filtEyeD{7} = filtEyeDmad(:,9:12:end);
filtEyeDavg = cell(1,7);
for i = 1:7
    filtEyeDavg{i} = nanmean(filtEyeD{i},2);
end
filtEyeDavg = cell2mat(filtEyeDavg);
filtEyeDpopAvg = mean(filtEyeDavg,2);
turntableDarkResize = rescale(turntableDark1,-4,4);
figure(); hold on
plot(filtEyeDavg)
plot(filtEyeDpopAvg)
plot(turntableDarkResize,'LineWidth',2)
ylabel('Eye velocity')
xlabel('Time (ms)')

filtEyeMadAmp = cat(1,filtEyeMadAmp1,filtEyeMadAmp2,filtEyeMadAmp3,filtEyeMadAmp4,filtEyeMadAmp5)';
filtEyeMadAmpAvg = mean(filtEyeMadAmp,2);
figure(); hold on
plot(filtEyeMadAmp)
plot(filtEyeMadAmpAvg)
ylabel('Eye velocity')
xlabel('Block number')

filtEyeDmadAmp = cat(1,filtEyeDmadAmp1,filtEyeDmadAmp2,filtEyeDmadAmp3,filtEyeDmadAmp4,filtEyeDmadAmp5)';
filtEyeDmadAmpAvg = mean(filtEyeDmadAmp,2);
figure(); hold on
plot(filtEyeDmadAmp)
plot(filtEyeDmadAmpAvg)
ylabel('Eye velocity')
xlabel('Block number')

filtEyeMadAmpIdx = cat(1,filtEyeMadAmpIdx1,filtEyeMadAmpIdx2,filtEyeMadAmpIdx3,filtEyeMadAmpIdx4,filtEyeMadAmpIdx5)';
filtEyeMadAmpIdxAvg = mean(filtEyeMadAmpIdx,2);
figure(); hold on
plot(filtEyeMadAmpIdx)
plot(filtEyeMadAmpIdxAvg) %%%3rd subject has last block way off for time
xlabel('Block number')
ylabel('Time (ms)')

filtEyeDmadAmpIdx = cat(1,filtEyeDmadAmpIdx1,filtEyeDmadAmpIdx2,filtEyeDmadAmpIdx3,filtEyeDmadAmpIdx4,filtEyeDmadAmpIdx5)';
filtEyeDmadAmpIdxAvg = mean(filtEyeDmadAmpIdx,2);
figure(); hold on
plot(filtEyeDmadAmpIdx)
plot(filtEyeDmadAmpIdxAvg)
xlabel('Block number')
ylabel('Time (ms)')

filtEyeSine = cat(2,filtEyeSine1,filtEyeSine2,filtEyeSine3,filtEyeSine4,filtEyeSine5);
filtEyeSine = cell2mat(filtEyeSine);
filtEyeSine = reshape(filtEyeSine,1000,30);
filtEyeLsine = cell(1000,6);
filtEyeLsine{1} = filtEyeSine(:,1:6:end);
filtEyeLsine{2} = filtEyeSine(:,2:6:end);
filtEyeLsine{3} = filtEyeSine(:,3:6:end);
filtEyeLsine{4} = filtEyeSine(:,4:6:end);
filtEyeLsine{5} = filtEyeSine(:,5:6:end);
filtEyeLsine{6} = filtEyeSine(:,6:6:end);
filtEyeLsineAvg = cell(1,6);
for i = 1:6
    filtEyeLsineAvg{i} = mean(filtEyeLsine{i},2);
end
filtEyeLsineAvg = cell2mat(filtEyeLsineAvg);
filtEyeLsinePopAvg = mean(filtEyeLsineAvg,2);
turntableLightResize = rescale(turntableLightAvg1,-1,1);
drumLightResize = rescale(drumLightAvg1,-1,1);
figure(); hold on
plot(filtEyeLsineAvg)
plot(filtEyeLsinePopAvg)
plot(turntableLightResize,'LineWidth',2)
plot(drumLightResize,'LineWidth',2)
ylabel('Eye velocity')
xlabel('Time (ms)')

filtEyeDsine = cat(2,filtEyeDsine1,filtEyeDsine2,filtEyeDsine3,filtEyeDsine4,filtEyeDsine5);
filtEyeDsine = cell2mat(filtEyeDsine);
filtEyeDsine = reshape(filtEyeDsine,1000,60);
eyeDsine = cell(1,7);
eyeDsine{1} = filtEyeDsine(:,3:12:end);
eyeDsine{2} = filtEyeDsine(:,4:12:end);
eyeDsine{3} = filtEyeDsine(:,5:12:end);
eyeDsine{4} = filtEyeDsine(:,6:12:end);
eyeDsine{5} = filtEyeDsine(:,7:12:end);
eyeDsine{6} = filtEyeDsine(:,8:12:end);
eyeDsine{7} = filtEyeDsine(:,9:12:end);
eyeDsineAvg = cell(1,7);
for i = 1:7
    eyeDsineAvg{i} = nanmean(eyeDsine{i},2);
end
eyeDsineAvg = cell2mat(eyeDsineAvg);
eyeDsinePopAvg = mean(eyeDsineAvg,2);
turntableDarkResize = rescale(turntableDark1,-4,4);
figure(); hold on
plot(eyeDsineAvg)
plot(turntableDarkResize,'LineWidth',2)
ylabel('Eye velocity')
xlabel('Time (ms)')

eyeDgain = cat(1,eyeDgain1,eyeDgain2,eyeDgain3,eyeDgain4,eyeDgain5)';
eyeDgainAvg = mean(eyeDgain,2);
figure(); hold on
plot(eyeDgain,'Marker','o','LineWidth',2)
plot(eyeDgainAvg,'Marker','s','LineWidth',3)
xticklabels({0,5,10,15,20,25,30})
ylabel('Eye gain (% \DeltaVOR)')
xlabel('Time (minutes)')

eyeLgain = cat(1,eyeLgain1,eyeLgain2,eyeLgain3,eyeLgain4,eyeLgain5)';
eyeLgainAvg = mean(eyeLgain,2);
figure(); hold on
plot(eyeLgain)
plot(eyeLgainAvg)

rsLight = cat(2,rsLight1,rsLight2,rsLight3,rsLight4,rsLight5);
rsL = cell(1,6);
rsL{1} = rsLight(:,1:6:end);
rsL{2} = rsLight(:,2:6:end);
rsL{3} = rsLight(:,3:6:end);
rsL{4} = rsLight(:,4:6:end);
rsL{5} = rsLight(:,5:6:end);
rsL{6} = rsLight(:,6:6:end);
rsLavg = cell(1,6);
for i = 1:6
    rsLavg{i} = mean(rsL{i},2);
end
rsLavg = cell2mat(rsLavg);
rsLpopAvg = mean(rsLavg,2);
turntableLightResize = rescale(turntableLightAvg1,-1.5,1.5);
drumLightResize = rescale(drumLightAvg1,-1.5,1.5);
figure(); hold on
plot(rsLavg)
plot(rsLpopAvg)
plot(turntableLightResize(:,1),'LineWidth',2)
plot(drumLightResize(:,1),'LineWidth',2)
ylabel('Retinal slip velocity')
xlabel('Time (ms)')

rsSineSingle = cat(2,rsSineSingle1,rsSineSingle2,rsSineSingle3,rsSineSingle4,rsSineSingle5);
rsSineSingle = reshape(rsSineSingle,1000,30);
rsSine = cell(1,6);
rsSine{1} = rsSineSingle(:,1:6:end);
rsSine{2} = rsSineSingle(:,2:6:end);
rsSine{3} = rsSineSingle(:,3:6:end);
rsSine{4} = rsSineSingle(:,4:6:end);
rsSine{5} = rsSineSingle(:,5:6:end);
rsSine{6} = rsSineSingle(:,6:6:end);
rsSineAvg = cell(1,6);
for i = 1:6
    rsSineAvg{i} = nanmean(rsSine{i},2);
end
rsSineAvg = cell2mat(rsSineAvg);
rsSinePopAvg = mean(rsSineAvg,2);
turntableLightResize = rescale(turntableLightAvg1,-1.5,1.5);
drumLightResize = rescale(drumLightAvg1,-1.5,1.5);
figure(); hold on
plot(rsSineAvg)
plot(rsSinePopAvg)
plot(turntableLightResize,'LineWidth',2)
plot(drumLightResize,'LineWidth',2)
ylabel('Retinal slip velocity')
xlabel('Time (ms)')

rsLamp = cat(1,rsLamp1,rsLamp2,rsLamp3,rsLamp4,rsLamp5)';
rsLampAvg = mean(rsLamp,2);
figure(); hold on
plot(abs(rsLamp))
plot(abs(rsLampAvg))
ylabel('Retinal slip velocity')
xlabel('Block number)')

rsLampIdx = cat(1,rsLampIdx1,rsLampIdx2,rsLampIdx3,rsLampIdx4,rsLampIdx5)';
rsLampIdxAvg = mean(rsLampIdx,2);
figure(); hold on
plot(rsLampIdx)
plot(rsLampIdxAvg)
ylabel('Peak retinal slip time')
xlabel('Block number)')

sAvg = cat(2,sAvg1,sAvg2,sAvg3,sAvg4,sAvg5);
sAvg = cell2mat(sAvg);
sAvg = reshape(sAvg,1000,60);
calSp = cell(1000,12);
calSp{1} = sAvg(:,1:12:end);
calSp{2} = sAvg(:,2:12:end);
calSp{3} = sAvg(:,3:12:end);
calSp{4} = sAvg(:,4:12:end);
calSp{5} = sAvg(:,5:12:end);
calSp{6} = sAvg(:,6:12:end);
calSpAvg = cell(1,12);
for i = 1:6
    calSpAvg{i} = mean(calSp{i},2);
end
calSpAvg = cell2mat(calSpAvg);
calSpPopAvg = mean(calSpAvg,2);
figure(); hold on
plot(calSpAvg)
plot(calSpPopAvg)

eyeSpAvg = cat(2,eyeSpAvg1,eyeSpAvg2,eyeSpAvg3,eyeSpAvg4,eyeSpAvg5);
eyeSpAvg = cell2mat(eyeSpAvg);
eyeSpAvg = reshape(eyeSpAvg,1000,60);
filtEyeSp = cell(1,12);
filtEyeSp{1} = eyeSpAvg(:,1:12:end);
filtEyeSp{2} = eyeSpAvg(:,2:12:end);
filtEyeSp{3} = eyeSpAvg(:,3:12:end);
filtEyeSp{4} = eyeSpAvg(:,4:12:end);
filtEyeSp{5} = eyeSpAvg(:,5:12:end);
filtEyeSp{6} = eyeSpAvg(:,6:12:end);
filtEyeSp{7} = eyeSpAvg(:,7:12:end);
filtEyeSp{8} = eyeSpAvg(:,8:12:end);
filtEyeSp{9} = eyeSpAvg(:,9:12:end);
filtEyeSp{10} = eyeSpAvg(:,10:12:end);
filtEyeSp{11} = eyeSpAvg(:,11:12:end);
filtEyeSp{12} = eyeSpAvg(:,12:12:end);
filtEyeSpAvg = cell(1,12);
for i = 1:12
    filtEyeSpAvg{i} = mean(filtEyeSp{i},2);
end
filtEyeSpAvg = cell2mat(filtEyeSpAvg);
filtEyeSpPopAvg = mean(filtEyeSpAvg,2);
figure(); hold on
plot(filtEyeSpAvg)
plot(filtEyeSpPopAvg)


rs = drumLightAvg1 - (filtEyeLavg + turntableLightAvg1);