%% Open File
clear;clc;
dbstop if error
smrFile = 'C:\Users\afanning\Documents\Data\HyunGeunData\gcImaging\exGCCamP_0201\data1210\data1210.smr';

%% Step 1 Allign Data

% Read Bonsai csv Files
dataTable = readtable('C:\Users\afanning\Documents\Data\HyunGeunData\gcImaging\exGCCamP_0201\data1210\data1210.csv');
%dataTableEye = readtable('E:\FP\data\smcs38\smcs38data0620\smcs38data062019\smcs38data062019eye.csv');

% Extract the Time Stamps
timeStamps_bonsai = dataTable.Var1;

% Use only relative time
timeStamps_bonsai = timeStamps_bonsai - timeStamps_bonsai(1);

% Extract TTL+ Pulses from smr file
chanlist = readSpikeFile(smrFile,[]);
chanindsAll = [chanlist.number];
rawdata = importSpike(smrFile,chanindsAll(13));
pulseTimes_start = rawdata(1).data(1);

% ms --> s
timeStamps_bonsai = timeStamps_bonsai ./ 1000;


%% Frames
sampleLen = timeStamps_bonsai(2:end)-timeStamps_bonsai(1:end-1);
meanFR = mean(sampleLen);
stdFR = std(sampleLen);


%% Step 2 SMR Modification

% Copy File
newSmrHandle = smrCopy(smrFile, '_FP');

% Add first channel
data = dataTable.Var3*100;
samplerate = 1/meanFR;
title = 'chan1';
units = 'n/a';
smrAddChan(newSmrHandle, data, samplerate, title, units, pulseTimes_start);

% Add Second Channel
data = dataTable.Var4*100;
samplerate = 1/meanFR;
title = 'chan2';
units = 'n/a';
smrAddChan(newSmrHandle, data, samplerate, title, units, pulseTimes_start);

% Add Third Channel
% data = dataTableEye.Var1;
% samplerate = 1000;
% title = 'chan2';
% units = 'n/a';
% smrAddChan(newSmrHandle, data, samplerate, title, units, pulseTimes_start);

%% tidy up
CEDS64CloseAll();