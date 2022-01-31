%% Open File
clear;clc;
dbstop if error
smrFile = 'C:\Users\afanning\Documents\Data\forAmin\forPaper\Exp-Fmr1-Ch01-02-1Hz GU-12062019.smr';

%% Step 1 Allign Data

% Read Bonsai csv Files
dataTableEye = readtable('C:\Users\afanning\Documents\Data\forAmin\forPaper\fig1.txt');

% Extract TTL+ Pulses from smr file
chanlist = readSpikeFile(smrFile,[]);
chanindsAll = [chanlist.number];
rawdata = importSpike(smrFile,chanindsAll(:));


%% Frames


%% Step 2 SMR Modification

% Copy File
newSmrHandle = smrCopy(smrFile, '_eye');

% Add Thirdd Channel
data = dataTableEye.Var1;
samplerate = 1000;
title = 'chan2';
units = '1000';
smrAddChan(newSmrHandle, data, samplerate, title, units, 0);

%% tidy up
CEDS64CloseAll();