%% set parameters for analysis
frequency = 1;                                  %frequency of stimuli
transientThreshold = 0.5;                       %threshold for removing high-frequency artifact (typically between 0.1 and 1.5)
saccadeThresh = 500;                            %eye velocity mean squared error threshold for what is considered a saccade (linear desaccading; typically between 100 and 2000)
presac = 50;                                    %number of additional points to remove prior to each point considered a saccade
postsac = 50;                                   %same except for points to remove following each time point considered a saccade
fr = 1000;                                      %sampling rate
minDataLength = 250;                            %minimum # of consecutive data pts that need to exist to be included in the analysis
goodCycMin = 5;                                 %number of good cycles within a block needed to keep analysis of that block

%% Extract raw data from .smr file
file = uigetfile('*.smr');
[data,dataSubset] = importDatObjectSJ(file);

drumP = data(1,dataSubset(3)).data;                         %drum position
chP = data(1,dataSubset(2)).data;                        %turntable position (the sign for the turntable in d019 or d241a isn't flipped properly during acquistion)
chV = data(1,dataSubset(1)).data;                        %turntable velocity
drumVel = smooth([diff(smooth(drumP,50)); 0],50)*fr;        %drum velocity
drumLED = [data(1,dataSubset(6)).data data(1,dataSubset(7)).data]*fr;  %drum LEDs high and low

%% Use proper eye channel and scale
directory = uigetdir;
cd(directory);
caliGrab = uigetfile('*.mat');
prompt = 'Scaling factor 1: ';
prompt2 = 'Scaling factor 2: ';
if caliGrab > 0
    load(caliGrab);
    if r2mag1 > r2mag2
        sf = scaleCh1;
        eyeP = data(1,dataSubset(4)).data * sf;
        eyeP = detrend(eyeP);
    else
        sf = scaleCh2;
        eyeP = data(1,dataSubset(5)).data * sf;
        eyeP = detrend(eyeP);
    end
else
    sf = input(prompt);
    if sf ~= 0
        eyeP = data(1,dataSubset(4)).data * sf;
        eyeP = detrend(eyeP);
    else
        sf = input(prompt2);
        eyeP = data(1,dataSubset(5)).data * sf;
        eyeP = detrend(eyeP);
    end
end

%% Segment record based on conditions
SampKeys = strcat(data(dataSubset(end)).samplerate(any(data(dataSubset(end)).samplerate == ['S' 's' 'L'], 2))');
SampKeyTimes = round(data(dataSubset(end)).data(any(data(dataSubset(end)).samplerate == ['S' 's' 'L'], 2))*fr)';

startDark = SampKeyTimes(strfind(SampKeys, 'S'));
endDark1 = SampKeyTimes(strfind(SampKeys, 'Ss')+1);
endDark2 = SampKeyTimes(strfind(SampKeys, 'SL')+1);
endDark = sort([endDark1 endDark2]);
startVisual = SampKeyTimes(strfind(SampKeys, 'SL')+1);
endVisual1 = SampKeyTimes(strfind(SampKeys, 'SLs')+2);
endVisual2 = SampKeyTimes(strfind(SampKeys, 'SLLs')+3);
endVisual = sort([endVisual1 endVisual2]);
startGap = SampKeyTimes(strfind(SampKeys, 'LsS'));
endGap = SampKeyTimes(strfind(SampKeys, 'LsS')+2);

%% Remove high-frequency artifact and desaccade (linear regression)
datout = removeTransients(eyeP,transientThreshold);
[omitH,omitCenters,eye_pos_filt,eye_vel_pfilt,eyeVelRaw,params] = desaccading(fr,datout,saccadeThresh,presac,postsac,frequency,drumVel,chV);

%% Calculate retinal slip and number of blocks per condition
rs = drumVel - (chV + eyeVelRaw);
rsFilt = drumVel - (chV + eye_vel_pfilt);

numBlocksVisual = numel(endVisual);             %total number of segments per visual test condition (x2, x0, okr)
numBlocksDark = numel(endDark);                 %total number of segments per VORD test condition
numBlocksGap = numel(endGap);

%% Determine condition with largest number of segments
if numBlocksVisual >= numBlocksDark && numBlocksVisual >= numBlocksGap
    numBlocksMax = numBlocksVisual;
elseif numBlocksDark >= numBlocksVisual && numBlocksDark >= numBlocksGap
    numBlocksMax = numBlocksDark;
else
    numBlocksMax = numBlocksGap;
end
numConditions = 3;              %number of different conditions to do separate analysis on


numTimeVisual = round((endVisual(1)/1000)-(startVisual(1)/1000));           %number of seconds for each testing condition for reshaping purposes (visual period)
numTimeGap = round((endGap(2)/1000)-(startGap(2)/1000));                    %gap period
numTimeDark = round((endDark(1)/1000)-(startDark(1)/1000)) - 2;                 %vestibular-dark period

keep = numTimeDark * fr;                   %number for what the actual segment length should be per condition, removes extraneous data points
keepL = numTimeVisual * fr;                %for visual blocks
keepSp = numTimeGap * fr;                  %for gap blocks

%% Create storage variables and partition data
eyeRawBlock = cell(numBlocksMax,numConditions);
eyeRawBlockTrunc = cell(numBlocksMax,numConditions);
eyeRawBlockMat = cell(numBlocksMax,numConditions);
eyeVelFiltBlock = cell(numBlocksMax,numConditions);
eyeVelFiltBlockTrunc = cell(numBlocksMax,numConditions);
eyeVelFiltBlockMat = cell(numBlocksMax,numConditions);
turntableBlock = cell(numBlocksMax,numConditions);
turntableBlockTrunc = cell(numBlocksMax,numConditions);
turntableBlockMat = cell(numBlocksMax,numConditions);
drumVelBlock = cell(numBlocksVisual,numConditions);
drumVelBlockTrunc = cell(numBlocksVisual,numConditions);
drumVelBlockMat = cell(numBlocksVisual,numConditions);
rsBlock = cell(numBlocksVisual,numConditions);
rsBlockTrunc = cell(numBlocksVisual,numConditions);
rsBlockMat = cell(numBlocksVisual,numConditions);
rsFiltBlock = cell(numBlocksVisual,numConditions);
rsFiltBlockTrunc = cell(numBlocksVisual,numConditions);
rsFiltBlockMat = cell(numBlocksVisual,numConditions);
desaccadeBlock = cell(numBlocksMax,numConditions);
desaccadeBlockTrunc = cell(numBlocksMax,numConditions);
desaccadeBlockMat = cell(numBlocksMax,numConditions);

if numBlocksDark > 0
    nthTime = 1;
    for i = 1:numBlocksDark
        [eyeRawBlock{i},eyeRawBlockTrunc{i},eyeRawBlockMat{i}] = segmentingSJ(eyeVelRaw,startDark,endDark,nthTime,fr,frequency,numTimeDark,keep);
        [eyeVelFiltBlock{i},eyeVelFiltBlockTrunc{i},eyeVelFiltBlockMat{i}] = segmentingSJ(eye_vel_pfilt,startDark,endDark,nthTime,fr,frequency,numTimeDark,keep);
        [turntableBlock{i},turntableBlockTrunc{i},turntableBlockMat{i}] = segmentingSJ(chV,startDark,endDark,nthTime,fr,frequency,numTimeDark,keep);
        [desaccadeBlock{i},desaccadeBlockTrunc{i},desaccadeBlockMat{i}] = segmentingSJ(omitH,startDark,endDark,nthTime,fr,frequency,numTimeDark,keep);
        nthTime = nthTime + 1;
    end
end

if numBlocksVisual > 0
    nthTime = 1;
    for i = 1:numBlocksVisual
        [eyeRawBlock{i,2},eyeRawBlockTrunc{i,2},eyeRawBlockMat{i,2}] = segmentingSJ(eyeVelRaw,startVisual,endVisual,nthTime,fr,frequency,numTimeVisual,keepL);
        [eyeVelFiltBlock{i,2},eyeVelFiltBlockTrunc{i,2},eyeVelFiltBlockMat{i,2}] = segmentingSJ(eye_vel_pfilt,startVisual,endVisual,nthTime,fr,frequency,numTimeVisual,keepL);
        [turntableBlock{i,2},turntableBlockTrunc{i,2},turntableBlockMat{i,2}] = segmentingSJ(chV,startVisual,endVisual,nthTime,fr,frequency,numTimeVisual,keepL);
        [drumVelBlock{i,2},drumVelBlockTrunc{i,2},drumVelBlockMat{i,2}] = segmentingSJ(drumVel,startVisual,endVisual,nthTime,fr,frequency,numTimeVisual,keepL);
        [rsBlock{i,2},rsBlockTrunc{i,2},rsBlockMat{i,2}] = segmentingSJ(rs,startVisual,endVisual,nthTime,fr,frequency,numTimeVisual,keepL);
        [rsFiltBlock{i,2},rsFiltBlockTrunc{i,2},rsFiltBlockMat{i,2}] = segmentingSJ(rsFilt,startVisual,endVisual,nthTime,fr,frequency,numTimeVisual,keepL);
        [desaccadeBlock{i,2},desaccadeBlockTrunc{i,2},desaccadeBlockMat{i,2}] = segmentingSJ(omitH,startVisual,endVisual,nthTime,fr,frequency,numTimeVisual,keepL);
        nthTime = nthTime + 1;
    end
end
visualRef = 0;

if numBlocksGap > 0
    nthTime = 1;
    for i = 1:numBlocksGap
        [eyeRawBlock{i,3},eyeRawBlockTrunc{i,3},eyeRawBlockMat{i,3}] = segmentingSJ(eyeVelRaw,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp);
        [eyeVelFiltBlock{i,3},eyeVelFiltBlockTrunc{i,3},eyeVelFiltBlockMat{i,3}] = segmentingSJ(eye_vel_pfilt,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp);
        [turntableBlock{i,3},turntableBlockTrunc{i,3},turntableBlockMat{i,3}] = segmentingSJ(chV,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp);
        [rsBlock{i,3},rsBlockTrunc{i,3},rsBlockMat{i,3}] = segmentingSJ(rs,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp);
        [rsFiltBlock{i,3},rsFiltBlockTrunc{i,3},rsFiltBlockMat{i,3}] = segmentingSJ(rsFilt,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp);
        [desaccadeBlock{i,3},desaccadeBlockTrunc{i,3},desaccadeBlockMat{i,3}] = segmentingSJ(omitH,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp);
        nthTime = nthTime + 1;
    end
end

eyeVelDarkFiltRecMat = cat(2,eyeVelFiltBlockMat{1:numBlocksDark,1});
eyeVelFiltRecMat = cat(2,eyeVelFiltBlockMat{1:numBlocksVisual,2});
eyeVelGapFiltRecMat = cat(2,eyeVelFiltBlockMat{1:numBlocksGap,3});
headDarkRecMat = cat(2,turntableBlockMat{1:numBlocksDark,1});
headRecMat = cat(2,turntableBlockMat{1:numBlocksVisual,2});
drumRecMat = cat(2,drumVelBlockMat{1:numBlocksVisual,2});
rsRecMat = cat(2,rsFiltBlockMat{1:numBlocksVisual,2});

eyeVelFiltVec = eyeVelFiltRecMat(:);
eyeVelDarkFiltVec = eyeVelDarkFiltRecMat(:);
eyeVelGapFiltVec = eyeVelGapFiltRecMat(:);

[eyeVelFiltRecMat,eyeVelFiltRecVec,goodCyclesVisual] = removeBadCycles(eyeVelFiltVec,numBlocksVisual,frequency,numTimeVisual,fr,minDataLength,goodCycMin,0);
[eyeVelFiltDarkRecMat,eyeVelFiltDarkRecVec,goodCyclesDark] = removeBadCycles(eyeVelDarkFiltVec,numBlocksDark,frequency,numTimeDark,fr,minDataLength,goodCycMin,1);
[eyeVelFiltGapRecMat,eyeVelFiltGapRecVec,goodCyclesGap] = removeBadCycles(eyeVelGapFiltVec,numBlocksGap,frequency,numTimeGap,fr,minDataLength,goodCycMin,2);

%% Remove discontinuous data from retinal slip matrix
for t = 1:size(eyeVelFiltRecMat,1)
    for i = 1:size(eyeVelFiltRecMat,2)
        if isnan(eyeVelFiltRecMat(t,i))
            rsRecMat(t,i) = NaN;
        end
    end
end

%% Calculate average of each block and across whole record for each condition
t = 1;
for i = 1:numBlocksDark
    eyeVelDarkBlockAvg{i} = nanmean(eyeVelFiltDarkRecMat(:,t:t+numTimeDark-1),2);
    t = t + numTimeDark;
end

t = 1;
for i = 1:numBlocksVisual
    eyeVelVisualBlockAvg{i} = nanmean(eyeVelFiltRecMat(:,t:t+numTimeVisual-1),2);
    rsBlockAvg{i} = nanmean(rsRecMat(:,t:t+numTimeVisual-1),2);
    t = t + numTimeVisual;
end
turntableDarkBlockAvg = cellfun(@(x) nanmean(x,2),turntableBlockMat(1:numBlocksDark,1),'UniformOutput',false);
turntableGapBlockAvg = cellfun(@(x) nanmean(x,2),turntableBlockMat(1:numBlocksGap,3),'UniformOutput',false);
turntableVisualBlockAvg = cellfun(@(x) nanmean(x,2),turntableBlockMat(1:numBlocksVisual,2),'UniformOutput',false);
drumVelVisualBlockAvg = cellfun(@(x) nanmean(x,2),drumVelBlockMat(1:numBlocksVisual,2),'UniformOutput',false);

turntableDarkAvg = mean(cat(2,turntableBlockMat{1:numBlocksDark,1}),2);
turntableVisualAvg = mean(cat(2,turntableBlockMat{1:numBlocksVisual,2}),2);
turntableGapAvg = mean(cat(2,turntableBlockMat{1:numBlocksGap,3}),2);
drumVelVisualAvg = mean(cat(2,drumVelBlockMat{1:numBlocksVisual,2}),2);
eyeVelVisualAvg = nanmean(eyeVelFiltRecMat,2);
eyeVelDarkAvg = nanmean(eyeVelFiltDarkRecMat,2);
eyeVelGapAvg = nanmean(eyeVelFiltGapRecMat,2);
rsAvg = nanmean(rsRecMat,2);

turntableDarkBlockAvgMat = cat(2,turntableDarkBlockAvg{1:end});
turntableVisualBlockAvgMat = cat(2,turntableVisualBlockAvg{1:end});
drumVelVisualBlockAvgMat = cat(2,drumVelVisualBlockAvg{1:end});

figure('Name','Record avgs')
subplot(2,1,1); hold on
plot(turntableDarkAvg)
plot(eyeVelDarkAvg)
ylabel('Velocity')

subplot(2,1,2); hold on
plot(turntableVisualAvg)
plot(drumVelVisualAvg)
plot(eyeVelVisualAvg)
plot(rsAvg)
legend('Turntable','Drum','Eye','Rslip')
ylabel('Velocity')
xlabel('Time (ms)')
saveas(gcf,'RecordAverages.pdf')

%% Concatenate block averages and take peak amplitude and their times
eyeVelDarkBlockAvgMat = cat(2,eyeVelDarkBlockAvg{1:numBlocksDark});
eyeVelVisualBlockAvgMat = cat(2,eyeVelVisualBlockAvg{1:numBlocksVisual});
headDarkBlockAvgMat = cat(2,turntableDarkBlockAvg{1:numBlocksDark});
headVisualBlockAvgMat = cat(2,turntableVisualBlockAvg{1:numBlocksVisual});
drumVisualBlockAvgMat = cat(2,drumVelVisualBlockAvg{1:numBlocksVisual});
rsBlockAvgMat = cat(2,rsBlockAvg{1:numBlocksVisual});

for i = 1:numBlocksDark
    [ipsiEyeBlockAmp(i,1),ipsiEyeBlockAmpTime(i,1)] = max(eyeVelDarkBlockAvgMat(:,i));
    [ipsiHeadBlockAmp(i,1),ipsiHeadBlockAmpTime(i,1)] = max(headDarkBlockAvgMat(:,i));
    [contraEyeBlockAmp(i,1),contraEyeBlockAmpTime(i,1)] = min(eyeVelDarkBlockAvgMat(:,i));
    [contraHeadBlockAmp(i,1),contraHeadBlockAmpTime(i,1)] = min(headDarkBlockAvgMat(:,i));
end

for i = 1:numBlocksVisual
    [ipsiEyeBlockAmp(i,2),ipsiEyeBlockAmpTime(i,2)] = max(eyeVelVisualBlockAvgMat(:,i));
    [ipsiHeadBlockAmp(i,2),ipsiHeadBlockAmpTime(i,2)] = max(headVisualBlockAvgMat(:,i));
    [ipsiDrumBlockAmp(i,1),ipsiDrumBlockAmpTime(i,1)] = max(drumVisualBlockAvgMat(:,i));
    [ipsiRsBlockAmp(i,1),ipsiRsBlockAmpTime(i,1)] = max(rsBlockAvgMat(:,i));
    
    [contraEyeBlockAmp(i,2),contraEyeBlockAmpTime(i,2)] = min(eyeVelVisualBlockAvgMat(:,i));
    [contraHeadBlockAmp(i,2),contraHeadBlockAmpTime(i,2)] = min(headVisualBlockAvgMat(:,i));
    [contraDrumBlockAmp(i,1),contraDrumBlockAmpTime(i,1)] = min(drumVisualBlockAvgMat(:,i));
    [contraRsBlockAmp(i,1),contraRsBlockAmpTime(i,1)] = min(rsBlockAvgMat(:,i));
end

%% Plot block averages
plotBlockCycAvgs(headDarkBlockAvgMat,keep,eyeVelDarkBlockAvgMat,keep,numBlocksDark,'Vdark block avg unfitted',2);
plotBlockCycAvgs(headVisualBlockAvgMat,drumVisualBlockAvgMat,eyeVelVisualBlockAvgMat,rsBlockAvgMat,numBlocksVisual,'Visual block avg unfitted',1);

%% Sines-fitting
[eyeDarkBlockSine,phaseBlockEyeDark] = sinesFitSJ(eyeVelDarkBlockAvgMat,fr,frequency,numBlocksDark,0);
[eyeVisualBlockSine,phaseBlockEyeVisual] = sinesFitSJ(eyeVelVisualBlockAvgMat,fr,frequency,numBlocksVisual,0);
[headDarkBlockSine,phaseBlockHeadDark] = sinesFitSJ(headDarkBlockAvgMat,fr,frequency,numBlocksDark,0);
[headVisualBlockSine,phaseBlockHeadVisual] = sinesFitSJ(headVisualBlockAvgMat,fr,frequency,numBlocksVisual,0);
[drumVisualBlockSine,phaseBlockDrumVisual] = sinesFitSJ(drumVisualBlockAvgMat,fr,frequency,numBlocksVisual,0);
[rsBlockSine,phaseBlockRS] = sinesFitSJ(rsBlockAvgMat,fr,frequency,numBlocksVisual,0);

%% Plot sines-fit blocks
plotBlockCycAvgs(headDarkBlockSine,keep,eyeDarkBlockSine,keep,numBlocksDark,'Vdark block avg sines-fitted',3);
plotBlockCycAvgs(headVisualBlockSine,drumVisualBlockSine,eyeVisualBlockSine,rsBlockSine,numBlocksVisual,'Visual block avg sines-fitted',0);

%% Take sines-fit peak amplitudes and their times
for i = 1:numBlocksDark
    [ipsiEyeSineBlockAmp(i,1),ipsiEyeSineBlockAmpTime(i,1)] = max(eyeDarkBlockSine{i});
    [ipsiHeadSineBlockAmp(i,1),ipsiHeadSineBlockAmpTime(i,1)] = max(headDarkBlockSine{i});
    
    [contraEyeSineBlockAmp(i,1),contraEyeSineBlockAmpTime(i,1)] = min(eyeDarkBlockSine{i});
    [contraHeadSineBlockAmp(i,1),contraHeadSineBlockAmpTime(i,1)] = min(headDarkBlockSine{i});
end

for i = 1:numBlocksVisual
    [ipsiEyeSineBlockAmp(i,2),ipsiEyeSineBlockAmpTime(i,2)] = max(eyeVisualBlockSine{i});
    [ipsiHeadSineBlockAmp(i,2),ipsiHeadSineBlockAmpTime(i,2)] = max(headVisualBlockSine{i});
    [ipsiDrumSineBlockAmp(i,1),ipsiDrumSineBlockAmpTime(i,1)] = max(drumVisualBlockSine{i});
    [ipsiRsSineBlockAmp(i,1),ipsiRsSineBlockAmpTime(i,1)] = max(rsBlockSine{i});
    
    [contraEyeSineBlockAmp(i,2),contraEyeSineBlockAmpTime(i,2)] = min(eyeVisualBlockSine{i});
    [contraHeadSineBlockAmp(i,2),contraHeadSineBlockAmpTime(i,2)] = min(headVisualBlockSine{i});
    [contraDrumSineBlockAmp(i,1),contraDrumSineBlockAmpTime(i,1)] = min(drumVisualBlockSine{i});
    [contraRsSineBlockAmp(i,1),contraRsSineBlockAmpTime(i,1)] = min(rsBlockSine{i});
end

%% Take sines-fit of record averages and plot
[rsSine,phaseRS] = sinesFitSJ(rsAvg,fr,frequency,numBlocksVisual,1);
[drumVisualSine,phaseDrum] = sinesFitSJ(drumVelVisualAvg,fr,frequency,numBlocksVisual,1);
[eyeDarkSine,phaseEyeDark] = sinesFitSJ(eyeVelDarkAvg,fr,frequency,numBlocksDark,1);
[eyeSine,phaseEye] = sinesFitSJ(eyeVelVisualAvg,fr,frequency,numBlocksVisual,1);
[headDarkSine,phaseHeadDark] = sinesFitSJ(turntableDarkAvg,fr,frequency,numBlocksDark,1);
[headSine,phaseHead] = sinesFitSJ(turntableVisualAvg,fr,frequency,numBlocksDark,1);

figure('Name','Record avg sines-fitted'); hold on
plot(headSine)
plot(drumVisualSine)
plot(eyeSine)
plot(rsSine)
xlabel('Time (ms)')
ylabel('Velocity')
legend('Head','Drum','Eye','Rslip')

%% save workspace
filename = [file(1:end-4) '.mat'];
save(filename);

write2excelSJ