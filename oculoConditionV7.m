%%Oculomotor conditioning analysis
protocol = 1;                   %set to 0 for oculomotor conditioning without probes, 1 for OC with probe trials, or 2 for unexpected Shakhawat
delay = 350;                    %set for the proper delay period length (250, 500, or 600 ms)
desacAnalysis = 1;              %set to 0 for linear regression desaccading, 1 for MAD desaccading, or 2 for cluster desaccading
tLength = 2000;                 %trial length without delay period
prePostLength = 2000;           %trial length for vestibular-dark stimulation or pre-post for unexpected shakhawat
numTrialsInBlock = 10;           %number of trials in each block
numTrials2avg = 20;             %number of trials in the beginning or end of training to average across
sf1 = 0;                        %scaling factors for eye channels (set sf not used to 0)
sf2 = -750;
transientThreshold = 0.1;       %ranges between 0.1 and 1.5 (used to remove high-frequency artifact from eye position channel)
madMultiplier = 3;              %determines the multiplication factor that sets the upper and lower bounds for MAD desaccading thresholds (values between 1-5)
madMultiplierD = 3;             %for vestibular-dark desaccading
madMultiplierGap = 3;           %for spontaneous activity desaccading
madMultiplierCued = 3;          %for delay period desaccading
movingMean = 75;                %window size for turning neighbor points into saccades (cluster desaccading)
thresh = 0.003;                 %threshold related to movingMean for turning neighbor points into saccades
saccadeThresh = 200;            %ranges typically between 25 and 1000 (for linear regression desaccading)
presac = 50;                    %number of points to remove before saccade timept
postsac = 50;                   %number of points to remove after saccade timept
fr = 1000;                      %sampling rate
eyeBoxFilt = 75;                %window size for moving average of eye velocity (# of samples)
version = 0;

%% extract raw data from each Spike2 channel
file = uigetfile('*.smr');
[data,dataSubset] = importDatObjectOC(file,version);      %extracts raw data from .smr experimental file

drDiff = (data(1,dataSubset(3)).data)*15;                               %drum velocity
drumP = data(1,dataSubset(10)).data;                                    %drum velocity
chP = data(1,dataSubset(2)).data*-1;                                    %turntable position (the sign for the turntable in d019 or d241a isn't flipped properly during acquistion)
turntableVel = data(1,dataSubset(1)).data*-1;                           %turntable velocity
drumLED = [data(1,dataSubset(4)).data data(1,dataSubset(5)).data]*fr;   %drum LEDs high and low
fpTTL = [data(1,dataSubset(6)).data data(1,dataSubset(7)).data]*fr;     %signal for start and end of experiment

if sf1 ~= 0 
    eye = data(1,dataSubset(4)).data;           %eye position vector
    eyeP = eye*sf1;                             %applies scaling factor to eye position
else
    eye = data(1,dataSubset(5)).data;
    eyeP = eye*sf2;
end

[datout] = removeTransients(eyeP,transientThreshold);
rawEyeVel = (smooth([diff(smooth(datout,50)); 0],50)*fr);
eyeAccRaw = [diff(rawEyeVel); 0];
keepSacs = rawEyeVel;
frequency = 1;
if desacAnalysis == 0
    [omitH, omitCenters, eye_pos_filt, eye_vel_pfilt] = desaccading(fr,datout,saccadeThresh,presac,postsac,frequency,drDiff);
    keepSacs(~omitH) = NaN;
end

%% Extract segment start and end times
%reads the keyboard channel for specific keystrokes
SampKeys = strcat(data(dataSubset(end)).samplerate(any(data(dataSubset(end)).samplerate == ['X' 'x' 'T' 'K' 'k' 'H' 'h'], 2))');
SampKeyTimes = round(data(dataSubset(end)).data(any(data(dataSubset(end)).samplerate == ['X' 'x' 'T' 'K' 'k' 'H' 'h'], 2))*fr)';

%find specific strings that indicate start and stop of particular tests
if protocol == 0
    startVisual = SampKeyTimes(strfind(SampKeys, 'K'));
    endVisual = SampKeyTimes(strfind(SampKeys, 'Kx')+1);
    startDark = SampKeyTimes(strfind(SampKeys, 'T'));
    endDark = SampKeyTimes(strfind(SampKeys, 'Tx')+1);
elseif protocol == 1
    SampKeys = strcat(data(dataSubset(end)).samplerate(any(data(dataSubset(end)).samplerate == ['X' 'x' 'T' 'K' 'k' 'H' 'h' '5' '4'], 2))');
    SampKeyTimes = round(data(dataSubset(end)).data(any(data(dataSubset(end)).samplerate == ['X' 'x' 'T' 'K' 'k' 'H' 'h' '5' '4'], 2))*fr)';
    
    startVisual = SampKeyTimes(strfind(SampKeys, 'XK'));
    startVisualProbe1 = SampKeyTimes(strfind(SampKeys, '4KX'));
    startVisualProbe2a = SampKeyTimes(strfind(SampKeys, '5KX'));
    startVisualProbe2b = SampKeyTimes(strfind(SampKeys, '5Kx'));
    startVisualProbe2b(1) = [];
    startVisualProbe2 = sort([startVisualProbe2a startVisualProbe2b]);
    endVisualProbe1 = SampKeyTimes(strfind(SampKeys, '4KX')+2);
    endVisualProbe2a = SampKeyTimes(strfind(SampKeys, '5KX')+2);
    endVisualProbe2b = SampKeyTimes(strfind(SampKeys, '5Kx')+2);
    endVisualProbe2b(1) = [];
    endVisualProbe2 = sort([endVisualProbe2a endVisualProbe2b]);
    endVisual = sort([startVisualProbe1 startVisualProbe2]);
    startDarkProbe1 = SampKeyTimes(strfind(SampKeys, '4K5')+1);
    startDarkProbe1(end) = [];
    startDarkProbe2 = SampKeyTimes(strfind(SampKeys, '5K4')+1);
    startDark = sort([startDarkProbe1 startDarkProbe2]);
    endDarkProbe1 = SampKeyTimes(strfind(SampKeys, '4K5')+2);
    endDarkProbe1(end) = [];
    endDarkProbe2 = SampKeyTimes(strfind(SampKeys, '5K4')+2);
    endDark = sort([endDarkProbe1 endDarkProbe2]);
elseif protocol == 2
    startVisual = SampKeyTimes(strfind(SampKeys, 'k'));
    endVisual = SampKeyTimes(strfind(SampKeys, 'kx')+1);
    startDark = SampKeyTimes(strfind(SampKeys, 'k'));
    startDark = startDark([1:3 end-2:end]);
    endDark = SampKeyTimes(strfind(SampKeys, 'kx')+1);
    endDark = endDark([1:3 end-2:end]);
end

startGap = SampKeyTimes(strfind(SampKeys, 'xX'))';
endGap = SampKeyTimes(strfind(SampKeys, 'xX')+1)';
startRec = SampKeyTimes(strfind(SampKeys, 'H'));
endRec = SampKeyTimes(strfind(SampKeys, 'h'));

numBlocksGap = numel(endGap);                   %total number of segments per gaps
startT = NaN(numBlocksGap,1);
startT(1:end,1) = startGap;
if protocol == 0
    startT(end+1,1) = endDark(end);
elseif protocol == 2
    startT(end+1,1) = endVisual(end);
end
endT = NaN(numBlocksGap,1);
endT(1:numBlocksGap,1) = endGap;
endT(end+1,1) = endRec;

numBlocks = numel(endVisual);             %total number of segments per visual test condition (x2, x0, okr)
numBlocksD = numel(endDark);              %number of pre and post training tests

numTimeVisual = round((endVisual(2)/1000)-(startVisual(2)/1000));           %number of seconds for each testing condition for reshaping purposes (visual period)
numTimeGap = round((endGap(1)/1000)-(startGap(1)/1000));                    %gap period
numTimeDark = round((endDark(1)/1000)-(startDark(1)/1000))-2;               %vestibular-dark period

keep = numTimeDark * (fr*(1/frequency));                        %number for what the actual segment length should be per condition, removes extraneous data points
keepGap = numTimeGap * (fr*(1/frequency));                      %for gap blocks
keepVisual = numTimeVisual * (fr*(1/frequency));                %for gap blocks

%% Segmenting
%eye trace segmenting
prePostDarkRawPos = cell(numBlocksD,1);
prePostDarkRawPosTrunc = cell(numBlocksD,1);
prePostDarkRaw = cell(numBlocksD,1);
prePostDarkRawTrunc = cell(numBlocksD,1);
prePostDarkEyePos = cell(numBlocksD,1);
prePostDarkEyePosTrunc = cell(numBlocksD,1);
prePostDarkEyeVel = cell(numBlocksD,1);
prePostDarkEyeVelTrunc = cell(numBlocksD,1);
turntable = cell(numBlocksD,1);
turntableTrunc = cell(numBlocksD,1);
drumPrePost = cell(numBlocksD,1);
drumPrePostTrunc = cell(numBlocksD,1);
nthKeyTime = 1;
for i = 1:numBlocksD
    prePostDarkRawPos{i} = eyeP(startDark(nthKeyTime):endDark(nthKeyTime));
    prePostDarkRawPosTrunc{i} = prePostDarkRawPos{i}(1:keep);
    prePostDarkRaw{i} = rawEyeVel(startDark(nthKeyTime):endDark(nthKeyTime));
    prePostDarkRawTrunc{i} = prePostDarkRaw{i}(1:keep);
    turntable{i} = turntableVel(startDark(nthKeyTime):endDark(nthKeyTime));
    turntableTrunc{i} = turntable{i}(1:keep);
    drumPrePost{i} = drDiff(startDark(nthKeyTime):endDark(nthKeyTime));
    drumPrePostTrunc{i} = drumPrePost{i}(1:keep);
    if desacAnalysis == 0
        prePostDarkEyePos{i} = eye_pos_filt(startDark(nthKeyTime):endDark(nthKeyTime));
        prePostDarkEyePosTrunc{i} = prePostDarkEyePos{i}(1:keep);
        prePostDarkEyeVel{i} = eye_vel_pfilt(startDark(nthKeyTime):endDark(nthKeyTime));
        prePostDarkEyeVelTrunc{i} = prePostDarkEyeVel{i}(1:keep);
    end
    nthKeyTime = nthKeyTime + 1;
end

%gap eye trace segmenting
gapEyeRawPos = cell(numBlocksGap,1);
gapEyeRawPosTrunc = cell(numBlocksGap,1);
gapEyeRaw = cell(numBlocksGap,1);
gapEyeRawTrunc = cell(numBlocksGap,1);
gapEyePos = cell(numBlocksGap,1);
gapEyePosTrunc = cell(numBlocksGap,1);
gapEyeVel = cell(numBlocksGap,1);
gapEyeVelTrunc = cell(numBlocksGap,1);
nthKeyTime = 1;
for i = 1:numBlocksGap
    gapEyeRawPos{i} = eyeP(startT(nthKeyTime):endT(nthKeyTime));
    gapEyeRaw{i} = rawEyeVel(startT(nthKeyTime):endT(nthKeyTime));
    if i == numBlocksGap && (endT(end)-startT(end)) <  keepGap
        gapEyeRawPos{i}(end:keepGap) = NaN;
        gapEyeRaw{i}(end:keepGap) = NaN;
    end
    gapEyeRawPosTrunc{i} = gapEyeRawPos{i}(1:keepGap);
    gapEyeRawTrunc{i} = gapEyeRaw{i}(1:keepGap);
    if desacAnalysis == 0
        gapEyePos{i} = eye_pos_filt(startT(nthKeyTime):endT(nthKeyTime));
        gapEyeVel{i} = eye_vel_pfilt(startT(nthKeyTime):endT(nthKeyTime));
        if i == numBlocksGap && (endT(end)-startT(end)) <  keepGap
            gapEyePos{i}(end:keepGap) = NaN;
            gapEyeVel{i}(end:keepGap) = NaN;
        end
        gapEyePosTrunc{i} = gapEyePos{i}(1:keepGap);
        gapEyeVelTrunc{i} = gapEyeVel{i}(1:keepGap);
    end
    nthKeyTime = nthKeyTime + 1;
end

% Create start and end times for visual blocks
delayBlockTimes = cell(numBlocks,1);
if protocol == 0 || protocol == 1
    for i = 1:numBlocks
        delayBlockTimes{i} = startVisual(i):endVisual(i);
    end
elseif protocol == 2
    for i = numBlocksD/2+1:numBlocks+prePostD/2
        delayBlockTimes{i} = startVisual(i):endVisual(i);
    end
end

%segmenting of eye traces during visual stimulation periods
rawEyeBlocks = cell(numBlocks,1);
rawEyePosBlocks = cell(numBlocks,1);
eyeVelBlocks = cell(numBlocks,1);
eyePosBlocks = cell(numBlocks,1);
sacBlocks = cell(numBlocks,1);
drum = cell(numBlocks,1);
if protocol ~= 1
    for i = 1:numBlocks
        rawEyeBlocks{i} = rawEyeVel(delayBlockTimes{i}(1:(tLength+delay)*numTrialsInBlock));
        rawEyePosBlocks{i} = eyeP(delayBlockTimes{i}(1:(tLength+delay)*numTrialsInBlock));
        drum{i} = drDiff(delayBlockTimes{i}(1:(tLength+delay)*numTrialsInBlock));
        if desacAnalysis == 0
            eyeVelBlocks{i} = eye_vel_pfilt(delayBlockTimes{i}(1:(tLength+delay)*numTrialsInBlock));
            eyePosBlocks{i} = eye_pos_filt(delayBlockTimes{i}(1:(tLength+delay)*numTrialsInBlock));
            sacBlocks{i} = keepSacs(delayBlockTimes{i}(1:(tLength+delay)*numTrialsInBlock));
        end
    end
else
    numBlocks = numel(endVisual);
    for i = 1:numBlocks
        rawEyeBlocks{i} = rawEyeVel(delayBlockTimes{i}(1:numTrialsInBlock*(delay+tLength)));
        rawEyePosBlocks{i} = eyeP(delayBlockTimes{i}(1:numTrialsInBlock*(delay+tLength)));
        drum{i} = drDiff(delayBlockTimes{i}(1:numTrialsInBlock*(delay+tLength)));
        if desacAnalysis == 0
            eyeVelBlocks{i} = eye_vel_pfilt(delayBlockTimes{i}(tLength/2+1:numTrialsInBlock*(delay+tLength)));
            eyePosBlocks{i} = eye_pos_filt(delayBlockTimes{i}(tLength/2+1:numTrialsInBlock*(delay+tLength)));
            sacBlocks{i} = keepSacs(delayBlockTimes{i}(tLength/2+1:numTrialsInBlock*(delay+tLength)));
        end
    end
    
    numProbeBlocks = numel(endVisualProbe1);
    rawEyeProbeBlocks = cell(numProbeBlocks,1);
    rawEyePosProbeBlocks = cell(numProbeBlocks,1);
    eyeVelProbeBlocks = cell(numProbeBlocks,1);
    eyePosProbeBlocks = cell(numProbeBlocks,1);
    sacProbeBlocks = cell(numProbeBlocks,1);
    drumProbe = cell(numProbeBlocks,1);
    
    numTimeProbe1 = round((endVisualProbe1(1)/1000)-(startVisualProbe1(1)/1000),1);
    numTimeProbe2 = round((endVisualProbe2(1)/1000)-(startVisualProbe2(1)/1000),1); 
    keepProbe1 = numTimeProbe1 * (fr*(1/frequency));
    keepProbe2 = numTimeProbe2 * (fr*(1/frequency));
    for i = 1:numProbeBlocks
        rawEyeProbeBlocks{i,1} = rawEyeVel(startVisualProbe1(i):endVisualProbe1(i));
        rawEyeProbeBlocks{i,2} = rawEyeVel(startVisualProbe2(i):endVisualProbe2(i)+150);
        rawEyeProbeBlocks{i,1} = rawEyeProbeBlocks{i,1}(1:keepProbe1);
        rawEyeProbeBlocks{i,2} = rawEyeProbeBlocks{i,2}(1:keepProbe2);
        rawEyePosProbeBlocks{i,1} = eyeP(startVisualProbe1(i):endVisualProbe1(i));
        rawEyePosProbeBlocks{i,2} = eyeP(startVisualProbe2(i):endVisualProbe2(i)+150);
        rawEyePosProbeBlocks{i,1} = rawEyePosProbeBlocks{i,1}(1:keepProbe1);
        rawEyePosProbeBlocks{i,2} = rawEyePosProbeBlocks{i,2}(1:keepProbe2);
        drumProbe{i,1} = drDiff(startVisualProbe1(i):endVisualProbe1(i));
        drumProbe{i,2} = drDiff(startVisualProbe2(i):endVisualProbe2(i)+150);
        drumProbe{i,1} = drumProbe{i,1}(1:keepProbe1);
        drumProbe{i,2} = drumProbe{i,2}(1:keepProbe2);
        if desacAnalysis == 0
            eyeVelProbeBlocks{i,1} = eye_vel_pfilt(startVisualProbe1(i):endVisualProbe1(i));
            eyeVelProbeBlocks{i,2} = eye_vel_pfilt(startVisualProbe2(i):endVisualProbe2(i));
            eyeVelProbeBlocks{i,1} = eyeVelProbeBlocks{i,1}(1:keepProbe1);
            eyeVelProbeBlocks{i,2} = eyeVelProbeBlocks{i,2}(1:keepProbe2);
            eyePosProbeBlocks{i,1} = eye_pos_filt(startVisualProbe1(i):endVisualProbe1(i));
            eyePosProbeBlocks{i,2} = eye_pos_filt(startVisualProbe2(i):endVisualProbe2(i));
            eyePosProbeBlocks{i,1} = eyePosProbeBlocks{i,1}(1:keepProbe1);
            eyePosProbeBlocks{i,2} = eyePosProbeBlocks{i,2}(1:keepProbe2);
            sacProbeBlocks{i,1} = keepSacs(startVisualProbe1(i):endVisualProbe1(i));
            sacProbeBlocks{i,2} = keepSacs(startVisualProbe2(i):endVisualProbe2(i));
            sacProbeBlocks{i,1} = sacProbeBlocks{i,1}(1:keepProbe1);
            sacProbeBlocks{i,2} = sacProbeBlocks{i,2}(1:keepProbe2);
        end
    end
end

%% Reorganizing vectors into arrays of data for each block
delayVel = cell(numBlocks,1);
lightVel = cell(numBlocks,1);
drCyc = cell(numBlocks, 1);
badDrCyc = cell(numBlocks,1);
rawEye = cell(numBlocks,1);
badCyc = cell(numBlocks,1);
rawEyePos = cell(numBlocks,1);
badPosCyc = cell(numBlocks,1);
eyePos = cell(numBlocks,1);
eyeVel = cell(numBlocks,1);
relEye = cell(numBlocks,1);
badRelEye = cell(numBlocks,1);
badRelCyc = cell(numBlocks,1);
eyeSacs = cell(numBlocks,1);

t = 1;
trial = 1;
trialLength = tLength + delay;

for i = 1:numBlocks
    delayVel{i} = single.empty(0,2);
    lightVel{i} = single.empty(0,2);
    drCyc{i} = single.empty(0,trialLength+1);
    badDrCyc{i} = single.empty(0,trialLength+1);
    badRelCyc{i} = single.empty(0,trialLength+1);
    badCyc{i} = single.empty(0,trialLength+1);
    badPosCyc{i} = single.empty(0,trialLength+1);
    badRelEye{i} = single.empty(0,trialLength+1);
    rawEye{i} = single.empty(0, trialLength+1);
    rawEyePos{i} = single.empty(0,trialLength+1);
    eyeVel{i} = single.empty(0,trialLength+1);
    eyePos{i} = single.empty(0,trialLength+1);
    relEye{i} = single.empty(0,trialLength+1);
    eyeSacs{i} = single.empty(0,trialLength+1);
    
    if protocol == 0
        while (t + trialLength < length(rawEyeBlocks{i}))
            delayVel{i} = [delayVel{i}; trial, nanmean(drum{i}((t + tLength/2):(t + tLength/2 + delay - 1)))];
            lightVel{i} = [lightVel{i}; trial, nanmean(drum{i}((t + tLength/2 + delay):(t + trialLength - 1)))];

            if (abs(delayVel{i}(end)) < abs(delayVel{i}(end) - lightVel{i}(end)))
                drCyc{i} = [drCyc{i}; trial, (drum{i}(t:(t + trialLength - 1)))'];
                rawEye{i} = [rawEye{i}; trial, (rawEyeBlocks{i}(t:(t + trialLength - 1)))'];
                rawEyePos{i} = [rawEyePos{i}; trial, (rawEyePosBlocks{i}(t:(t + trialLength - 1)))'];
                relEye{i} = rawEye{i} ./ drCyc{i};
                if desacAnalysis == 0
                    eyeVel{i} = [eyeVel{i}; trial, (eyeVelBlocks{i}(t:(t + trialLength - 1)))'];
                    eyePos{i} = [eyePos{i}; trial, (eyePosBlocks{i}(t:(t + trialLength - 1)))'];
                    relEye{i} = eyeVel{i} ./ drCyc{i};
                    eyeSacs{i} = [eyeSacs{i}; trial, (sacBlocks{i}(t:(t + trialLength - 1)))'];
                end
                t = t + trialLength;
            else
                j = drum{i}(t:t+trialLength);
                cutoff = zeros(1,trialLength);
                for k = tLength/2+1:tLength/2+fr
                    if j(k) < delayVel{i}(end,2)
                        cutoff(k) = k;
                    end
                end
                cutoffIdx = find(cutoff)-tLength/2;
                if t+tLength+cutoffIdx(1) < length(rawEyeBlocks{i})
                    if desacAnalysis == 1 || desacAnalysis == 2
                        badCyc{i} = [badCyc{i}; trial, (rawEyeBlocks{i}(t:t+trialLength))'];
                        badPosCyc{i} = [badPosCyc{i}; trial, (rawEyePosBlocks{i}(t:t+trialLength))'];
                        badDrCyc{i} = [badDrCyc{i}; trial, (drum{i}(t:t+trialLength))'];
                        badRelCyc{i} = badCyc{i} ./ badDrCyc{i};
                    else
                        badCyc{i} = [badCyc{i}; trial, (eyeVelBlocks{i}(t:t+trialLength))'];
                        badPosCyc{i} = [badPosCyc{i}; trial, (eyePosBlocks{i}(t:t+trialLength))'];
                        badDrCyc{i} = [badDrCyc{i}; trial, (drum{i}(t:t+trialLength))'];
                        badRelCyc{i} = badCyc{i} ./ badDrCyc{i};
                    end
                end
                t = t + tLength + cutoffIdx(1);
            end
            trial = trial + 1;
        end
        t = 1;
        trial = 1;
    elseif protocol == 1
        while (t + trialLength < length(rawEyeBlocks{i}))
            delayVel{i} = [delayVel{i}; trial, nanmean(drum{i}(t:(t + 75)))];
            lightVel{i} = [lightVel{i}; trial, nanmean(drum{i}((t + 100):(t + 100 + tLength/2 - 1)))];

            if (abs(delayVel{i}(end)) < abs(delayVel{i}(end) - lightVel{i}(end)))
                drCyc{i} = [drCyc{i}; trial, (drum{i}(t:(t + trialLength - 1)))'];
                rawEye{i} = [rawEye{i}; trial, (rawEyeBlocks{i}(t:(t + trialLength - 1)))'];
                rawEyePos{i} = [rawEyePos{i}; trial, (rawEyePosBlocks{i}(t:(t + trialLength - 1)))'];
                relEye{i} = rawEye{i} ./ drCyc{i};
                if desacAnalysis == 0
                    eyeVel{i} = [eyeVel{i}; trial, (eyeVelBlocks{i}(t:(t + trialLength - 1)))'];
                    eyePos{i} = [eyePos{i}; trial, (eyePosBlocks{i}(t:(t + trialLength - 1)))'];
                    relEye{i} = eyeVel{i} ./ drCyc{i};
                    eyeSacs{i} = [eyeSacs{i}; trial, (sacBlocks{i}(t:(t + trialLength - 1)))'];
                end
                t = t + trialLength;
            else
                j = drum{i}(t:t+trialLength);
                cutoff = zeros(1,trialLength);
                for k = 1:trialLength-100
                    if j(k) < delayVel{i}(end,2)
                        cutoff(k) = k;
                    end
                end
                cutoffIdx = find(cutoff);
                if t+tLength+cutoffIdx(1) < length(rawEyeBlocks{i})
                    if desacAnalysis == 1 || desacAnalysis == 2
                        badCyc{i} = [badCyc{i}; trial, (rawEyeBlocks{i}(t:t+trialLength))'];
                        badPosCyc{i} = [badPosCyc{i}; trial, (rawEyePosBlocks{i}(t:t+trialLength))'];
                        badDrCyc{i} = [badDrCyc{i}; trial, (drum{i}(t:t+trialLength))'];
                        badRelCyc{i} = badCyc{i} ./ badDrCyc{i};
                    else
                        badCyc{i} = [badCyc{i}; trial, (eyeVelBlocks{i}(t:t+trialLength))'];
                        badPosCyc{i} = [badPosCyc{i}; trial, (eyePosBlocks{i}(t:t+trialLength))'];
                        badDrCyc{i} = [badDrCyc{i}; trial, (drum{i}(t:t+trialLength))'];
                        badRelCyc{i} = badCyc{i} ./ badDrCyc{i};
                    end
                end
                t = t + tLength + cutoffIdx(1);
            end
            trial = trial + 1;
        end
        t = 1;
        trial = 1;
    elseif protocol == 2
        while (t + trialLength < length(rawEyeBlocks{i}))
                drCyc{i} = [drCyc{i}; trial, (drum{i}(t:(t + trialLength - 1)))'];
                rawEye{i} = [rawEye{i}; trial, (rawEyeBlocks{i}(t:(t + trialLength - 1)))'];
                rawEyePos{i} = [rawEyePos{i}; trial, (rawEyePosBlocks{i}(t:(t + trialLength - 1)))'];
                relEye{i} = rawEye{i} ./ drCyc{i};
                if desacAnalysis == 0
                    eyeVel{i} = [eyeVel{i}; trial, (eyeVelBlocks{i}(t:(t + trialLength - 1)))'];
                    eyePos{i} = [eyePos{i}; trial, (eyePosBlocks{i}(t:(t + trialLength - 1)))'];
                    relEye{i} = eyeVel{i} ./ drCyc{i};
                    eyeSacs{i} = [eyeSacs{i}; trial, (sacBlocks{i}(t:(t + trialLength - 1)))'];
                end
                t = t + trialLength;
                trial = trial + 1;
        end
        t = 1;
        trial = 1;
    end
end

if protocol == 1
    delayVelProbe = cell(numProbeBlocks,2);
    lightVelProbe = cell(numProbeBlocks,2);
    drCycProbe = cell(numProbeBlocks,2);
    rawEyeProbe = cell(numProbeBlocks,2);
    rawEyePosProbe = cell(numProbeBlocks,2);
    relEyeProbe = cell(numProbeBlocks,2);
    eyeVelProbe = cell(numProbeBlocks,2);
    eyePosProbe = cell(numProbeBlocks,2);
    relEyeProbe = cell(numProbeBlocks,2);
    eyeSacsProbe = cell(numProbeBlocks,2);
    badCycProbe = cell(numProbeBlocks,2);
    badPosCycProbe = cell(numProbeBlocks,2);
    badDrCycProbe = cell(numProbeBlocks,2);
    badRelCycProbe = cell(numProbeBlocks,2);

    for i = 1:numProbeBlocks
        delayVelProbe{i} = [delayVelProbe{i}; nanmean(drumProbe{i,1}(1:1000))];
        lightVelProbe{i} = [lightVelProbe{i}; nanmean(drumProbe{i,1}(1001:3000))];

            if (abs(delayVelProbe{i}(end)) < abs(delayVelProbe{i}(end) - abs(lightVelProbe{i}(end))))
                drCycProbe{i} = [drCycProbe{i}; (drumProbe{i})];
                rawEyeProbe{i} = [rawEyeProbe{i}; (rawEyeProbeBlocks{i})];
                rawEyePosProbe{i} = [rawEyePosProbe{i}; (rawEyePosProbeBlocks{i})];
                relEyeProbe{i} = rawEyeProbe{i} ./ drCycProbe{i};
                if desacAnalysis == 0
                    eyeVelProbe{i} = [eyeVelProbe{i}; (eyeVelProbeBlocks{i})];
                    eyePosProbe{i} = [eyePos{i}; (eyePosProbeBlocks{i})];
                    relEyeProbe{i} = eyeVelProbe{i} ./ drCycProbe{i};
                    eyeSacsProbe{i} = [eyeSacsProbe{i}; (sacProbeBlocks{i})];
                end
            else
                j = drumProbe{i};
                cutoff = zeros(1,trialLength);
                for k = 1:trialLength-100
                    if j(k) < delayVelProbe{i}(end)
                        cutoff(k) = k;
                    end
                end
                cutoffIdx = find(cutoff);
                if desacAnalysis == 1 || desacAnalysis == 2
                    badCycProbe{i} = [badCycProbe{i}; (rawEyeProbeBlocks{i})];
                    badPosCycProbe{i} = [badPosCycProbe{i}; (rawEyePosProbeBlocks{i})];
                    badDrCycProbe{i} = [badDrCycProbe{i}; (drumProbe{i})];
                    badRelCycProbe{i} = badCycProbe{i} ./ badDrCycProbe{i};
                else
                    badCycProbe{i} = [badCycProbe{i}; (eyeVelProbeBlocks{i})];
                    badPosCycProbe{i} = [badPosCycProbe{i}; (eyePosProbeBlocks{i})];
                    badDrCycProbe{i} = [badDrCycProbe{i}; (drumProbe{i})];
                    badRelCycProbe{i} = badCycProbe{i} ./ badDrCycProbe{i};
                end
            end

        delayVelProbe{i,2} = [delayVelProbe{i,2}; nanmean(drumProbe{i,2}(1:500))];
        lightVelProbe{i,2} = [lightVelProbe{i,2}; nanmean(drumProbe{i,2}(501:4500))];

        if (abs(delayVelProbe{i,2}(end)) < abs(delayVelProbe{i,2}(end) - abs(lightVelProbe{i,2}(end))))
                drCycProbe{i,2} = [drCycProbe{i,2}; (drumProbe{i,2})];
                rawEyeProbe{i,2} = [rawEyeProbe{i,2}; (rawEyeProbeBlocks{i,2})];
                rawEyePosProbe{i,2} = [rawEyePosProbe{i,2}; (rawEyePosProbeBlocks{i,2})];
                relEyeProbe{i,2} = rawEyeProbe{i,2} ./ drCycProbe{i,2};
                if desacAnalysis == 0
                    eyeVelProbe{i,2} = [eyeVelProbe{i,2}; (eyeVelProbeBlocks{i,2})];
                    eyePosProbe{i,2} = [eyePos{i,2}; (eyePosProbeBlocks{i,2})];
                    relEyeProbe{i,2} = eyeVelProbe{i,2} ./ drCycProbe{i,2};
                    eyeSacsProbe{i,2} = [eyeSacsProbe{i,2}; (sacProbeBlocks{i,2})];
                end
            else
                j = drumProbe{i,2};
                cutoff = zeros(1,trialLength);
                for k = 1:trialLength-100
                    if j(k) < delayVelProbe{i,2}(end)
                        cutoff(k) = k;
                    end
                end
                cutoffIdx = find(cutoff);
                if desacAnalysis == 1 || desacAnalysis == 2
                    badCycProbe{i,2} = [badCycProbe{i,2}; (rawEyeProbeBlocks{i,2})];
                    badPosCycProbe{i,2} = [badPosCycProbe{i,2}; (rawEyePosProbeBlocks{i,2})];
                    badDrCycProbe{i,2} = [badDrCycProbe{i,2}; (drumProbe{i,2})];
                    badRelCycProbe{i,2} = badCycProbe{i,2} ./ badDrCycProbe{i,2};
                else
                    badCycProbe{i,2} = [badCycProbe{i,2}; (eyeVelProbeBlocks{i,2})];
                    badPosCycProbe{i,2} = [badPosCycProbe{i,2}; (eyePosProbeBlocks{i,2})];
                    badDrCycProbe{i,2} = [badDrCycProbe{i,2}; (drumProbe{i,2})];
                    badRelCycProbe{i,2} = badCycProbe{i,2} ./ badDrCycProbe{i,2};
                end
            end
    end

    figure('Name','Block avg. drum vel.')
    subplot(2,1,1); hold on
    for i = 1:length(drumProbe)
        plot(drCycProbe{i,2})
    end
    xlabel('Time (ms)')
    ylabel('Velocity')
    
    subplot(2,1,2); hold on
    for i = 1:length(drumProbe)
        plot(drCycProbe{i,1})
    end
    xlabel('Time (ms)')
    ylabel('Velocity')
end

%% Reorganizing pre and post-test vectors into arrays for each block
prePostDarkEyeRaw = cell(numBlocksD,1);
prePostDarkEyePosRaw = cell(numBlocksD,1);
prePostEyeVel = cell(numBlocksD,1);
prePostEyePos = cell(numBlocksD,1);
prePostTurntable = cell(numBlocksD,1);
prePostDrum = cell(numBlocksD,1);
for i = 1:numBlocksD
    prePostTurntable{i} = single.empty(0,prePostLength+1);
    prePostDrum{i} = single.empty(0,prePostLength+1);
    prePostDarkEyeRaw{i} = single.empty(0,prePostLength+1);
    prePostDarkEyePosRaw{i} = single.empty(0,prePostLength+1);
    prePostEyeVel{i} = single.empty(0,prePostLength+1);
    prePostEyePos{i} = single.empty(0,prePostLength+1);
    while (t + prePostLength < length(prePostDarkRawTrunc{i}))
        prePostTurntable{i} = [prePostTurntable{i}; trial, (turntableTrunc{i}(t:(t + prePostLength - 1)))];
        prePostDrum{i} = [prePostDrum{i}; trial, (drumPrePostTrunc{i}(t:(t + prePostLength - 1)))];
        prePostDarkEyeRaw{i} = [prePostDarkEyeRaw{i}; trial, (prePostDarkRawTrunc{i}(t:(t + prePostLength - 1)))'];
        prePostDarkEyePosRaw{i} = [prePostDarkEyePosRaw{i}; trial, (prePostDarkRawPosTrunc{i}(t:(t + prePostLength - 1)))'];
        if desacAnalysis == 0
            prePostEyeVel{i} = [prePostEyeVel{i}; trial, (prePostDarkEyeVelTrunc{i}(t:(t + prePostLength - 1)))'];
            prePostEyePos{i} = [prePostEyePos{i}; trial, (prePostDarkEyePosTrunc{i}(t:(t + prePostLength - 1)))'];
        end
        t = t + prePostLength;
        trial = trial+1;
    end
    t = 1;
    trial = 1;
end

%% Reorganizing gap vector into arrays for each block
gapVelRaw = cell(numBlocksGap,1);
gapPosRaw = cell(numBlocksGap,1);
gapVel = cell(numBlocksGap,1);
gapPos = cell(numBlocksGap,1);
for i = 1:numBlocksGap
    gapVelRaw{i} = single.empty(0,fr+1);
    gapPosRaw{i} = single.empty(0,fr+1);
    gapVel{i} = single.empty(0,fr+1);
    gapPos{i} = single.empty(0,fr+1);
    while (t + fr -1 <= length(gapEyeRawTrunc{i}))
        gapVelRaw{i} = [gapVelRaw{i}; trial, (gapEyeRawTrunc{i}(t:(t + fr - 1)))'];
        gapPosRaw{i} = [gapPosRaw{i}; trial, (gapEyeRawPosTrunc{i}(t:(t + fr - 1)))'];
        if desacAnalysis == 0
            gapVel{i} = [gapVel{i}; trial, (gapEyeVelTrunc{i}(t:(t + fr - 1)))'];
            gapPos{i} = [gapPos{i}; trial, (gapEyePosTrunc{i}(t:(t + fr - 1)))'];
        end
        t = t + fr;
        trial = trial + 1;
    end
    t = 1;
    trial = 1;
end

%further reorganization of eye velocity matrices for each condition
trialEyeVel = cell2mat(rawEye);
for i = 1:size(trialEyeVel,1)
    trialEyeVel(i,:) = circshift(trialEyeVel(i,:),-1100);
end
trialEyeVel = trialEyeVel(:,2:end)';
trialEyeVel = movmean(trialEyeVel, [eyeBoxFilt eyeBoxFilt]);
trialEyeVelVector = trialEyeVel(:)';

vestibularDarkEye = cell2mat(prePostDarkEyeRaw);
vestibularDarkEye = vestibularDarkEye(:,2:end)';
vestibularDarkEyeVector = vestibularDarkEye(:)';
spEye = cell2mat(gapVelRaw);
spEye = spEye(1:end-5,2:end)';

trialEyeVelRel = cell2mat(relEye);
trialEyeVelRel = trialEyeVelRel(:,2:end)';

if protocol == 1
    rawEyeProbeNew = rawEyeProbe(~cellfun('isempty',rawEyeProbe));
    for i = 1:length(rawEyeProbeNew)
        blockLength(i) = length(rawEyeProbeNew{i});
    end
    [probeSep,probeSepIdx] = unique(blockLength);
    probeEyeVel1 = cat(2,rawEyeProbeNew{1:probeSepIdx(2)-1});
    probeEyeVel2 = cat(2,rawEyeProbeNew{probeSepIdx(2):end});
    probeSepIdx = probeSepIdx(2)-1;
end

probeEyeVel1 = probeEyeVel1(:);
probeEyeVel2 = probeEyeVel2(:);
probeEyeVel1 = smooth(probeEyeVel1,50);
probeEyeVel2 = smooth(probeEyeVel2,50);
probeEyeVel1 = reshape(probeEyeVel1,probeSep(1),probeSepIdx);
probeEyeVel2 = reshape(probeEyeVel2,probeSep(2),probeSepIdx);
%Median Absolute Deviation (MAD) desaccading
if desacAnalysis == 1
    [madEye,madDeye,madEyeSp,madEyeVector,madDeyeVector,madEyeSpVector,madEyeDesacMat,madEyeDdesac,madEyeDesacSp] = madDesacOC(tLength,delay,numBlocksD,numBlocks,numBlocksGap,madMultiplier,madMultiplierCued,madMultiplierD,madMultiplierGap,trialEyeVel,vestibularDarkEye,spEye,presac,postsac,0);
    [madRelEye,~,~,madEyeRelVector,~,~,madEyeRelDesacMat,~,~] = madDesacOC(tLength,delay,numBlocks,numBlocks,numBlocks,madMultiplier,madMultiplierCued,madMultiplierD,madMultiplierGap,trialEyeVelRel,trialEyeVelRel,trialEyeVelRel,presac,postsac,0);
    if protocol == 1
        [madEyeProbe1,~,~,madEyeProbeVector1,~,~,madEyeDesacProbe1,~,~] = madDesacOC(tLength,1100,probeSepIdx,probeSepIdx,probeSepIdx,madMultiplier,madMultiplierCued,madMultiplierD,madMultiplierGap,probeEyeVel1,probeEyeVel1,probeEyeVel1,presac,postsac,1);
        [madEyeProbe2,~,~,madEyeProbeVector2,~,~,madEyeDesacProbe2,~,~] = madDesacOC(tLength*3,400,probeSepIdx,probeSepIdx,probeSepIdx,madMultiplier,madMultiplierCued,madMultiplierD,madMultiplierGap,probeEyeVel2,probeEyeVel2,probeEyeVel2,presac,postsac,1);
    end
    
    eyeVisualSacs = trialEyeVel;
    eyeDarkSacs = vestibularDarkEye;
    eyeGapSacs = spEye;
    eyeVisualSacs(madEyeDesacMat) = NaN;
    eyeDarkSacs(madEyeDdesac) = NaN;
    eyeGapSacs(madEyeDesacSp) = NaN;
    
elseif desacAnalysis == 2
    trialEyeVel = trialEyeVel';
    vestibularDarkEye = vestibularDarkEye';
    spEye = spEye';
    probeEyeVel1 = probeEyeVel1';
    probeEyeVel2 = probeEyeVel2';
    clusterSize = size(trialEyeVel,1)/3;
    clusterSize = 2*floor(clusterSize)/2 - 1;
    
    [madEye,madDeye,madEyeSp,madEyeVector,madDeyeVector,madEyeSpVector,~,~] = clusterDesaccading(trialEyeVel,vestibularDarkEye,spEye,movingMean,thresh,clusterSize,'Cluster desaccaded eye vel.');
    if protocol == 1
        clusterSize = size(probeEyeVel1,1)/3;
        clusterSize = 2*floor(clusterSize)/2 - 1;
        [madEyeProbe1,~,~,madEyeProbe1Vector,~,~,~,~] = clusterDesaccading(probeEyeVel1,probeEyeVel1,probeEyeVel1,movingMean,thresh,clusterSize,'Cluster desaccaded eye vel.');
        clusterSize = size(probeEyeVel2,1)/3;
        clusterSize = 2*floor(clusterSize)/2 - 1;
        if clusterSize > 0
            [madEyeProbe2,~,~,madEyeProbe2Vector,~,~,~,~] = clusterDesaccading(probeEyeVel2,probeEyeVel2,probeEyeVel2,movingMean,thresh,clusterSize,'Cluster desaccaded eye vel.');
        end
    end
    eyeRawVisualMatIn = trialEyeVel;
    eyeRawDarkMatIn = vestibularDarkEye;
    eyeRawGapMatIn = spEye;
    eyeVisualSacs = trialEyeVel';
    eyeDarkSacs = vestibularDarkEye';
    eyeGapSacs = spEye';
    saccadesVisualMat = reshape(madEyeVector,trialLength,size(trialEyeVel,1));
    saccadesDarkMat = reshape(madDeyeVector,prePostLength,size(vestibularDarkEye,1));
    saccadesGapMat = reshape(madEyeSpVector,fr,size(spEye,1));
    eyeVisualSacs(saccadesVisualMat) = NaN;
    eyeDarkSacs(saccadesDarkMat) = NaN;
    eyeGapSacs(saccadesGapMat) = NaN;
    tempVector = trialEyeVelVector;
    tempVector(madEyeVector) = NaN;
    madEyeVector = tempVector';
end

%% reorganization of data, averaging, and plotting
first = 1:2;
pre = 1:numBlocksD/2;
post = numBlocksD/2+1:numBlocksD;
last = (numBlocks - 1):numBlocks;
numTri = size(drCyc{1},1);

%drum data reshaping
drumTraining = cat(1,drCyc{1:numBlocks})';
drumTraining = circshift(drumTraining,-1100);
drumVelBlock2mat = drumTraining(2:end,:);
drumVector = drumVelBlock2mat(:)';
drumVelBlockAvg = cellfun(@(x) mean(x,1),drCyc,'UniformOutput',false);
drumVelBlockAvg = cell2mat(drumVelBlockAvg)';
drumVelBlockAvg = drumVelBlockAvg(2:end,:);
drumVelBlockAvg = circshift(drumVelBlockAvg,-1100);
drumVelAvg = mean(drumVelBlock2mat,2);
drumVelFirstAvg = mean(drumVelBlockAvg,2);
drumVelLastAvg = mean(drumVelBlockAvg,2);

% turntableVdark = cat(1,prePostTurntable{1:numBlocksD})';
% turntableVdark = turntableVdark(2:end,:);
% turntableVdark(:,end:(numBlocksD*keep/prePostLength)) = NaN;
% turntableVector = turntableVdark(:)';
% turntableBlockPrePost = cellfun(@(y) mean(y,1),prePostTurntable,'UniformOutput',false);
% turntableBlockAvg = cell2mat(turntableBlockPrePost)';
% turntableBlockAvg = turntableBlockAvg(2:end,:);
% turntableAvg = mean(turntableBlockAvg,2);
% turntablePreAvg = mean(turntableBlockAvg(:,pre),2);
% turntablePostAvg = mean(turntableBlockAvg(:,post),2);

%% 
prePostDrumBlock2mat = cell2mat(prePostDrum)';
drumPrePostBlockAvg = cellfun(@(x) mean(x,1),prePostDrum,'UniformOutput',false);
preSize = size(prePostDrumBlock2mat,2);
pre = 1:preSize/2;
post = preSize/2+1:preSize;
drumPreAvg = mean(prePostDrumBlock2mat(2:end,pre),2);
drumPostAvg = mean(prePostDrumBlock2mat(2:end,post),2);

if desacAnalysis == 0
    %% pre and post-test plots
    prePostEyeVelBlock2mat = cell2mat(prePostEyeVel)';
    prePostEyeVelBlock2mat = prePostEyeVelBlock2mat(2:end,:);
    prePostEyeVelBlockAvg = cellfun(@(x) nanmean(x,1),prePostEyeVel,'UniformOutput',false);
    prePostEyeVelBlockAvg = cell2mat(prePostEyeVelBlockAvg)';
    prePostEyeVelBlockAvg = prePostEyeVelBlockAvg(2:end,:);
    preEyeVelAvg = nanmean(prePostEyeVelBlock2mat(:,1:numBlocksD/2),2);
    postEyeVelAvg = nanmean(prePostEyeVelBlock2mat(:,numBlocksD/2+1:end),2);

    if protocol == 0
        figure(); hold on
        plot(preEyeVelAvg,'k')
        plot(postEyeVelAvg,'r')
        plot(turntablePreAvg,'b')
        plot(turntablePostAvg,'cyan')
        title('Vestibular-dark whole trial')
        ylabel('Velocity')
        xlabel('Time (ms)')
        legend('First 3 blocks eye vel.','Last 3 blocks eye vel.','First 3 blocks turntable vel.','Last 3 blocks turntable vel.')
    elseif protocol == 1
        figure('Name','Pre vs post'); hold on
        plot(preEyeVelAvg,'k')
        plot(postEyeVelAvg,'r')
        plot(drumPreAvg,'b')
        plot(drumPostAvg,'g')
        ylabel('Velocity')
        xlabel('Time (ms)')
        legend('First 3 blocks eye vel.','Last 3 blocks eye vel.','Drum vel. pre','Drum vel. post')
    end
    
    %% Spontaneous eye movement plots
    gapVelBlockAvg = cellfun(@(x) nanmean(x,1),gapVel,'UniformOutput',false);
    gapVelBlockAvg = cell2mat(gapVelBlockAvg)';
    gapVelBlockAvg = gapVelBlockAvg(2:end,:);
    gapVelBlock2mat = cell2mat(gapVel)';
    gapVelBlock2mat = gapVelBlock2mat(2:end,:);
    gapVelAvg = nanmean(gapVelBlock2mat,2);
    gapVelSE = nanstd(gapVelBlock2mat,0,2)/sqrt(size(gapVelBlock2mat,2));

    figure()
    subplot(2,1,1); hold on
    plot(gapVelBlockAvg)
    title('Block avg. gap eye vel.')
    ylabel('Velocity')
    xlabel('Time (ms)')
    subplot(2,1,2); hold on
    errorbar(gapVelAvg,gapVelSE,'r')
    plot(gapVelAvg,'k','LineWidth',2)
    title('Whole record avg gap eye vel.')
    ylabel('Velocity')
    xlabel('Time (ms)')
    legend('SE','spontaneous eye vel.')

%% plot block-averaged eye and drum velocity
    eyeVelFilt = cell2mat(eyeVel);
    eyeVelBlock2mat = eyeVelFilt(:,2:end)';
    eyeVelFiltVector = eyeVelBlock2mat(:);
    eyeVelBlockAvg = cellfun(@(x) nanmean(x,1),eyeVel,'UniformOutput',false);
    eyeVelBlockAvg = cell2mat(eyeVelBlockAvg)';
    eyeVelBlockAvg = eyeVelBlockAvg(2:end,:);
    eyeVelFirstAvg = nanmean(eyeVelBlock2mat(:,1:numTrials2avg),2);
    eyeVelLastAvg = nanmean(eyeVelBlock2mat(:,end-numTrials2avg:end),2);
    
    figure();
    t = tiledlayout(2,2);
    t.TileSpacing = 'compact';
    t.Padding = 'tight';
    nexttile; hold on
    plot(eyeVelFirstAvg,'k')
    plot(eyeVelLastAvg,'r')
    plot(drumVelFirstAvg,'b')
    plot(drumVelLastAvg,'cyan')
    title('Whole trial');
    ylabel('Velocity');

    nexttile; hold on
    plot(eyeVelFirstAvg(1:tLength/2),'k')
    plot(eyeVelLastAvg(1:tLength/2),'r')
    plot(drumVelFirstAvg(1:tLength/2),'b')
    plot(drumVelLastAvg(1:tLength/2),'cyan')
    title('Dark Period');
    legend('First 2 blocks eye vel.','Last 2 blocks eye vel.','First 2 blocks eye acc.','Last 2 blocks eye acc.');

    nexttile; hold on
    plot(eyeVelFirstAvg(tLength/2+101:tLength/2+delay),'k')
    plot(eyeVelLastAvg(tLength/2+101:tLength/2+delay),'r')
    plot(drumVelFirstAvg(tLength/2+101:tLength/2+delay),'b')
    plot(drumVelLastAvg(tLength/2+101:tLength/2+delay),'cyan')
    title('Delay Period');
    xlabel('Time (ms)');
    ylabel('Velocity');

    nexttile; hold on
    plot(eyeVelFirstAvg(tLength/2+delay:trialLength-1),'k')
    plot(eyeVelLastAvg(tLength/2+delay:trialLength-1),'r')
    plot(drumVelFirstAvg(tLength/2+delay:trialLength-1),'b')
    plot(drumVelLastAvg(tLength/2+delay:trialLength-1),'cyan')
    title('Visual Period');
    xlabel('Time (ms)');

%% Relative eye processing and plots
    relEyeBlockAvg = cellfun(@(x) nanmean(x,1),madRelEye,'UniformOutput',false);
    relEyeBlockAvg = cell2mat(relEyeBlockAvg)';
    relEyeBlockAvg = relEyeBlockAvg(2:end,:);
    relEyeBlock2mat = cell2mat(relEye)';
    relEyeBlock2mat = relEyeBlock2mat(2:end,:);
    relEyeFirstAvg = nanmean(relEyeBlock2mat(:,1:numTrials2avg),2);
    relEyeLastAvg = nanmean(relEyeBlock2mat(:,end-numTrials2avg:end),2);

    drumFirstRescale = rescale(abs(drumVelFirstAvg),0,1);
    figure();
    subplot(2,1,1); hold on
    plot(relEyeFirstAvg,'k')
    plot(relEyeLastAvg,'r')
    plot(drumFirstRescale,'b')
    title('Whole Trial, eye gain');
    ylabel('Eye velocity');
    ylim([-0.5 1.5])

    subplot(2,1,2); hold on
    plot(relEyeFirstAvg(1:tLength/2),'k')
    plot(relEyeLastAvg(1:tLength/2),'r')
    plot(drumFirstRescale(1:tLength/2),'b')
    title('Dark Period');
    legend('First 25 trials','Last 25 trials','Drum');
    ylabel('Eye velocity');
    xlabel('Time (ms)');
    ylim([-1 1])

    figure();
    subplot(2,1,1); hold on
    plot(relEyeFirstAvg(tLength/2+101:tLength/2+delay),'k')
    plot(relEyeLastAvg(tLength/2+101:tLength/2+delay),'r')
    plot(drumFirstRescale(tLength/2+101:tLength/2+delay),'b')
    title('Delay Period');
    ylabel('Eye velocity');
    ylim([-1 1])

    subplot(2,1,2); hold on
    plot(relEyeFirstAvg(tLength/2+delay:trialLength-1),'k')
    plot(relEyeLastAvg(tLength/2+delay:trialLength-1),'r')
    plot(drumFirstRescale(tLength/2+delay:trialLength-1),'b')
    title('Visual Period');
    xlabel('Time (ms)');
    ylabel('Eye velocity');
    legend('First 25 trials','Last 25 trials','Drum');
    ylim([-0.5 1.5])

%% Eye and drum velocity for every block plots
    figure()
    subplot(2,1,1); hold on
    plot(eyeVelBlockAvg)
    plot(drumVelBlockAvg)
    title('Whole trial, block averages');
    xlabel('Time (ms)');
    ylabel('Velocity');

    subplot(2,1,2); hold on
    plot(trialEyeVelVector(1,1:trialLength*20))
    plot(drumVector(1,1:trialLength*20))
    plot(eyeVelFiltVector(1:trialLength*20,1))
    title('Raw eye and drum velocity');
    xlabel('Time (ms)');
    ylabel('Velocity');
    
%% Saccades and drum velocity plots
    trialSacs = cell2mat(eyeSacs)';
    trialSacs = trialSacs(2:end,:);
    plot(trialSacs(:,1));

else
%% Spontaneous eye movement plots
    spEye(:,end:(numBlocksGap*10)) = NaN;
    spCell = cell(numBlocksGap,1);
    w = 1;
    for k = 1:numBlocksGap
        spCell{k} = spEye(:,w:w+(keepGap/fr)-1);
        w = w + (keepGap/fr)-1;
    end
    gapVelBlockAvg = cellfun(@(x) nanmean(x,2),spCell,'UniformOutput',false);
    gapVelBlockAvg = cat(2,gapVelBlockAvg{1:numBlocksGap});
    gapVelBlock2mat = spEye;
    gapVelAvg = nanmean(spEye,2);
    gapVelSE = nanstd(spEye,0,2)/sqrt(size(spEye,2));

    subplot(2,1,1); hold on
    plot(gapVelBlockAvg)
    title('Block avg. gap eye vel.')
    ylabel('Velocity')
    subplot(2,1,2); hold on
    errorbar(gapVelAvg,gapVelSE,'r')
    plot(gapVelAvg,'k','LineWidth',2)
    title('Whole record avg gap eye vel.')
    ylabel('Velocity')
    xlabel('Time (ms)')
    legend('SE','spontaneous eye vel.')

% %% pre and post-test plots
%     preSize = size(madDeye,2);
%     pre = 1:preSize/2;
%     post = preSize/2+1:preSize;
%     madDeye(:,end:(numBlocksD*keep/prePostLength)) = NaN;
%     madDeyeCell = cell(numBlocksD,1);
%     w = 1;
%     for k = 1:numBlocksD
%         madDeyeCell{k} = madDeye(:,w:w+(keep/prePostLength)-1);
%         w = w + (keep/prePostLength)-1;
%     end
%     prePostEyeVelBlockAvg = cellfun(@(x) nanmean(x,2),madDeyeCell,'UniformOutput',false);
%     prePostEyeVelBlockAvg = cat(2,prePostEyeVelBlockAvg{1:numBlocksD});
%     prePostEyeVelBlock2mat = madDeye;
%     preEyeVelAvg = nanmean(madDeye(:,pre),2);
%     postEyeVelAvg = nanmean(madDeye(:,post),2);
% 
%     if protocol == 0 || protocol == 1
%         figure('Name','Pre vs. post'); hold on
%         plot(preEyeVelAvg,'k')
%         plot(postEyeVelAvg,'r')
%         plot(turntablePreAvg,'b')
%         plot(turntablePostAvg,'cyan')
%         title('Vestibular-dark, whole trial avg')
%         ylabel('Velocity')
%         xlabel('Time (ms)')
%         legend('Pre blocks eye vel.','Post blocks eye vel.','Pre blocks turntable vel.','Post blocks turntable vel.')
%     elseif protocol == 2
%         figure('Name','Pre vs. post'); hold on
%         plot(preEyeVelAvg,'k')
%         plot(postEyeVelAvg,'r')
%         plot(drumPreAvg,'b')
%         plot(drumPostAvg,'g')
%         title('Pre vs. post, whole trial avg.')
%         ylabel('Velocity')
%         xlabel('Time (ms)')
%         legend('Pre blocks eye vel.','Post blocks eye vel.','Drum vel. pre','Drum vel. post')  
%     end
    
    %% Median Absolute Deviation processing and plotting
    %plot raw eye vel and MAD desaccaded eye vel to check desaccading
    badCyc = badCyc(~cellfun('isempty',badCyc));
    badDrCyc = badDrCyc(~cellfun('isempty',badDrCyc));
    badPosCyc = badPosCyc(~cellfun('isempty',badPosCyc));
    badRelCyc = badRelCyc(~cellfun('isempty',badRelCyc));
    badRelEye = badRelEye(~cellfun('isempty',badRelEye));
    eyeAccVector = [diff(madEyeVector); 0]*100;
    if length(badCyc) ~= 0
        add = length(badCyc);
    else
        add = 0;
    end
    %madEye(trialLength,end:end+add) = NaN;
    eyeAccMat = reshape(eyeAccVector,tLength+delay,504);
    eyeAccMat(end,:) = NaN;
    eyeAccCell = cell(numBlocks,1);
    eyeCell = cell(numBlocks,1);
    w = 1;
    for k = 1:numBlocks
        eyeCell{k} = madEye(:,w:w+(numTri)-1);
        eyeAccCell{k} = eyeAccMat(:,w:w+(numTri)-1);
        w = w + (numTri)-1;
    end
    eyeVelBlockAvg = cellfun(@(x) nanmean(x,2),eyeCell,'UniformOutput',false);
    eyeVelBlockAvg = cat(2,eyeVelBlockAvg{1:numBlocks});
    eyeAccBlockAvg = cellfun(@(x) nanmean(x,2),eyeAccCell,'UniformOutput',false);
    eyeAccBlockAvg = cat(2,eyeAccBlockAvg{1:numBlocks});
    eyeVelBlock2mat = trialEyeVel;
    eyeVelFirstAvg = nanmean(madEye(:,1:numTrials2avg),2);
    eyeVelLastAvg = nanmean(madEye(:,end-numTrials2avg:end),2);
    
    eyeAccFirstAvg = nanmean(eyeAccMat(:,1:numTrials2avg),2);
    eyeAccLastAvg = nanmean(eyeAccMat(:,end-numTrials2avg:end),2);
    
    figure('Name','Begin vs. end eye vel.');
    t = tiledlayout(2,2);
    t.TileSpacing = 'compact';
    t.Padding = 'tight';
    nexttile; hold on
    plot(eyeVelFirstAvg,'k')
    plot(eyeVelLastAvg,'r')
    plot(eyeAccFirstAvg,'g')
    plot(eyeAccLastAvg,'cyan')
    plot(drumVelFirstAvg,'b')
    plot(drumVelLastAvg,'b')
    title('Whole trial')
    ylabel('Velocity')

    if protocol ~= 1
        nexttile; hold on
        plot(eyeVelFirstAvg(1:tLength/2),'k')
        plot(eyeVelLastAvg(1:tLength/2),'r')
        plot(eyeAccFirstAvg(1:tLength/2),'g')
        plot(eyeAccLastAvg(1:tLength/2),'cyan')
        plot(drumVelFirstAvg(1:tLength/2),'b')
        plot(drumVelLastAvg(1:tLength/2),'b')
        title('Dark Period')
        legend('Eye vel. begin','Eye vel. end','Eye acc. begin','Eye acc end','Drum vel. begin','Drum vel. end')

        nexttile; hold on
        plot(eyeVelFirstAvg(tLength/2+101:tLength/2+delay),'k')
        plot(eyeVelLastAvg(tLength/2+101:tLength/2+delay),'r')
        plot(eyeAccFirstAvg(tLength/2+101:tLength/2+delay),'g')
        plot(eyeAccLastAvg(tLength/2+101:tLength/2+delay),'cyan')
        plot(drumVelFirstAvg(tLength/2+101:tLength/2+delay),'b')
        plot(drumVelLastAvg(tLength/2+101:tLength/2+delay),'b')
        title('Delay Period')
        xlabel('Time (ms)')
        ylabel('Velocity')

        nexttile; hold on
        plot(eyeVelFirstAvg(tLength/2+delay:trialLength-1),'k')
        plot(eyeVelLastAvg(tLength/2+delay:trialLength-1),'r')
        plot(eyeAccFirstAvg(tLength/2+delay:trialLength-1),'g')
        plot(eyeAccLastAvg(tLength/2+delay:trialLength-1),'cyan')
        plot(drumVelFirstAvg(tLength/2+delay:trialLength-1),'b')
        plot(drumVelLastAvg(tLength/2+delay:trialLength-1),'b')
        title('Visual Period')
        xlabel('Time (ms)')
    else
        nexttile; hold on
        plot(eyeVelFirstAvg(tLength/2+1:tLength/2+delay),'k')
        plot(eyeVelLastAvg(tLength/2+1:tLength/2+delay),'r')
        plot(eyeAccFirstAvg(tLength/2+1:tLength/2+delay),'g')
        plot(eyeAccLastAvg(tLength/2+1:tLength/2+delay),'cyan')
        plot(drumVelFirstAvg(tLength/2+1:tLength/2+delay),'b')
        plot(drumVelLastAvg(tLength/2+1:tLength/2+delay),'b')
        title('Cued Period')
        legend('First 2 blocks eye vel.','Last 2 blocks eye vel.','First 2 blocks eye acc.','Last 2 blocks eye acc.')

        nexttile; hold on
        plot(eyeVelFirstAvg(tLength/2+delay+1:end),'k')
        plot(eyeVelLastAvg(tLength/2+delay+1:end),'r')
        plot(eyeAccFirstAvg(tLength/2+delay+1:end),'g')
        plot(eyeAccLastAvg(tLength/2+delay+1:end),'cyan')
        plot(drumVelLastAvg(tLength/2+delay+1:end),'b')
        plot(drumVelLastAvg(tLength/2+delay+1:end),'b')
        title('Visual Period')
        xlabel('Time (ms)')
        ylabel('Velocity')

        nexttile; hold on
        plot(eyeVelFirstAvg(1:tLength/2),'k')
        plot(eyeVelLastAvg(1:tLength/2),'r')
        plot(eyeAccFirstAvg(1:tLength/2),'g')
        plot(eyeAccLastAvg(1:tLength/2),'cyan')
        plot(drumVelFirstAvg(1:tLength/2),'b')
        plot(drumVelLastAvg(1:tLength/2),'b')
        title('Dark Period')
        xlabel('Time (ms)')
    end
    
    multiPlot = figure('Name','Block avg eye vel');
    eyeVelAvgCount = eyeVelBlockAvg;
    eyeAccAvgCount = eyeAccBlockAvg;
    a = 1;
    for j = 1:5:size(eyeVelBlockAvg,2)
        nexttile; hold on
        for i = 1:5
            plot(eyeVelAvgCount(:,i))
        end
        plot(drumVelFirstAvg)
        if j+5 > size(eyeVelBlockAvg,2)
            continue
        else
            eyeVelAvgCount = eyeVelBlockAvg(:,j:j+4);
        end
        eyeVelMultiBlockAvg(1:length(eyeVelBlockAvg),a) = nanmean(eyeVelBlockAvg(:,j:j+4),2);
        eyeAccMultiBlockAvg(1:length(eyeAccBlockAvg),a) = nanmean(eyeAccBlockAvg(:,j:j+4),2);
        a = a + 1;
    end
    labelOff = axes(multiPlot,'visible','off');
    labelOff.XLabel.Visible='on';
    labelOff.YLabel.Visible='on';
    ylabel(labelOff,'Velocity');
    xlabel(labelOff,'Time (ms)');
    
    c = cool(11);
    figure('Name','Multi-block Avgs')
    subplot(2,1,1); hold on
    for i = 1:size(eyeVelMultiBlockAvg,2)
        plot(eyeVelMultiBlockAvg(:,i),'Color',c(i,:))
    end
    plot(drumVelFirstAvg,'Color','k')
    xlabel('Time (ms)')
    ylabel('Velocity')
    legend('Multi-block 1','','','','','Multi-block 6','','','','','Multi-block 11','Drum vel.')
    
    c = cool(11);
    subplot(2,1,2); hold on
    for i = 1:size(eyeVelMultiBlockAvg,2)
        plot(eyeAccMultiBlockAvg(:,i),'Color',c(i,:))
    end
    plot(drumVelFirstAvg,'Color','k')
    xlabel('Time (ms)')
    ylabel('Acceleration')
    legend('Multi-block 1','','','','','Multi-block 6','','','','','Multi-block 11','Drum vel.')
    
%% Relative eye processing and plotting
    drumTraining(:,end:end+add) = NaN;
    drumTraining = drumTraining(2:end,:);
    relEyeBlock2mat = madEye ./ drumTraining;

%% Relative eye plots

    relEyeCell = cell(numBlocks,1);
    w = 1;
    for k = 1:numBlocks
        relEyeCell{k} = relEyeBlock2mat(:,w:w+(numTri)-1);
        w = w + (numTri)-1;
    end
    relEyeBlockAvg = cellfun(@(x) nanmean(x,2),relEyeCell,'UniformOutput',false);
    relEyeBlockAvg = cat(2,relEyeBlockAvg{1:numBlocks});
    relEyeFirstAvg = nanmean(relEyeBlock2mat(:,1:numTrials2avg),2);
    relEyeLastAvg = nanmean(relEyeBlock2mat(:,end-numTrials2avg:end),2);

    drumFirstRescale = rescale(abs(drumVelFirstAvg),0,1);
    figure()
    subplot(2,2,1); hold on
    plot(relEyeFirstAvg,'k')
    plot(relEyeLastAvg,'r')
    plot(drumFirstRescale,'b')
    title('Whole Trial')
    ylabel('Eye velocity')
    ylim([-1 2])

    if protocol ~= 3
        subplot(2,1,2); hold on
        plot(relEyeFirstAvg(1:tLength/2),'k')
        plot(relEyeLastAvg(1:tLength/2),'r')
        plot(drumFirstRescale(1:tLength/2),'b')
        title('Dark Period')
        ylabel('Eye velocity')
        xlabel('Time (ms)')
        legend('First 25 trials','Last 25 trials','Drum')
        ylim([-1 2])

        figure()
        subplot(2,1,1); hold on
        plot(relEyeFirstAvg(tLength/2+101:tLength/2+delay),'k')
        plot(relEyeLastAvg(tLength/2+101:tLength/2+delay),'r')
        plot(drumFirstRescale(tLength/2+101:tLength/2+delay-1),'b')
        title('Delay Period')
        ylabel('Eye velocity')
        ylim([-1 1])

        subplot(2,1,2); hold on
        plot(relEyeFirstAvg(tLength/2+delay:trialLength-1),'k')
        plot(relEyeLastAvg(tLength/2+delay:trialLength-1),'r')
        plot(drumFirstRescale(tLength/2+delay:trialLength-1),'b')
        title('Visual Period')
        ylabel('Eye velocity')
        xlabel('Time (ms)')
        legend('First 25 trials','Last 25 trials','Drum')
        ylim([-0.5 1.5])
    elseif protocol == 3
        subplot(2,2,2); hold on
        plot([relEyeFirstAvg(4151:end);relEyeFirstAvg(1:50)],'k')
        plot([relEyeLastAvg(4151:end);relEyeLastAvg(1:50)],'r')
        plot([drumFirstRescale(4151:end);drumFirstRescale(1:50)],'b')
        title('Delay Period')
        ylabel('Eye velocity')
        xlabel('Time (ms)')
        legend('First 25 trials','Last 25 trials','Drum')
        ylim([-1 2])

        subplot(2,2,3); hold on
        plot(relEyeFirstAvg(51:51+tLength/2),'k')
        plot(relEyeLastAvg(51:51+tLength/2),'r')
        plot(drumFirstRescale(51:51+tLength/2),'b')
        title('Visual Period')
        ylabel('Eye velocity')
        ylim([-1 2])

        subplot(2,2,4); hold on
        plot(relEyeFirstAvg(tLength/2+51:end-450),'k')
        plot(relEyeLastAvg(tLength/2+51:end-450),'r')
        plot(drumFirstRescale(tLength/2+51:end-450),'b')
        title('Dark Period')
        ylabel('Eye velocity')
        xlabel('Time (ms)')
        legend('First 25 trials','Last 25 trials','Drum')
        ylim([-0.5 1.5])
    end

%% plot block averages for eye and drum velocity
    figure('Name','Raw eye and drum vel.')
    subplot(2,1,1); hold on
    plot(eyeVelBlockAvg)
    plot(drumVelBlockAvg)
    title('Whole trial, block averages');
    xlabel('Time (ms)')
    ylabel('Velocity')

    subplot(2,1,2); hold on
    plot(trialEyeVelVector(1,1:trialLength*20));
    plot(drumVector(1,1:trialLength*20));
    plot(madEyeVector(1:trialLength*20,1));
    title('First 20 or so trials');
    xlabel('Time (ms)')
    ylabel('Velocity')
    legend('Raw eye vel.','drum velocity','MAD desaccaded eye vel.')

    %% Separate trials without saccades during certain periods
    goodEyeTrialCued = NaN(trialLength,size(trialEyeVel,2));
    badEyeTrialCued = NaN(trialLength,size(trialEyeVel,2));
    goodEyeTrialVisual = NaN(trialLength,size(trialEyeVel,2));
    badEyeTrialVisual = NaN(trialLength,size(trialEyeVel,2));
    goodEyeTrialDark = NaN(trialLength,size(trialEyeVel,2));
    badEyeTrialDark = NaN(trialLength,size(trialEyeVel,2));
    a = 1; b = 1; c = 1; d = 1; e = 1; f = 1;
    for i = 1:size(madEye,2)
        if find(isnan(madEye(4301:end,i)))
            badEyeTrialCued(:,a) = madEye(:,i);
            badTrialCuedIdx(a) = i;
            a = a + 1;
        else
            goodEyeTrialCued(:,i) = madEye(:,i);
            goodTrialCuedIdx(b) = i;
            b = b + 1;
        end
        
        if find(isnan(madEye(1551:51+tLength/2,i)))
            badEyeTrialVisual(:,i) = madEye(:,i);
            badTrialVisualIdx(c) = i;
            c = c + 1;
        else
            goodEyeTrialVisual(:,i) = madEye(:,i);
            goodTrialVisualIdx(d) = i;
            d = d + 1;
        end
        
        if find(isnan(madEye(tLength/2+1551:end-450,i)))
            badEyeTrialDark(:,i) = madEye(:,i);
            badTrialDarkIdx(e) = i;
            e = e + 1;
        else
            goodEyeTrialDark(:,i) = madEye(:,i);
            goodTrialDarkIdx(f) = i;
            f = f + 1;
        end
    end
    
    goodEyeCued = NaN(trialLength,size(trialEyeVel,2));
    badEyeCued = NaN(trialLength,size(trialEyeVel,2));
    goodEyeVisual = NaN(trialLength,size(trialEyeVel,2));
    badEyeVisual = NaN(trialLength,size(trialEyeVel,2));
    goodEyeDark = NaN(trialLength,size(trialEyeVel,2));
    badEyeDark = NaN(trialLength,size(trialEyeVel,2));
    a = 1; b = 1; c = 1; d = 1; e = 1; f = 1;
    for i = 1:size(madEye,2)
        if find(isnan(madEye(tLength/2+delay/2+1:tLength/2+delay,i)))
            badEyeCued(:,i) = madEye(:,i);
            badCuedIdx(a) = i;
            a = a + 1;
        else
            goodEyeCued(:,i) = madEye(:,i);
            goodCuedIdx(b) = i;
            b = b + 1;
        end
        
        if find(isnan(madEye(tLength/2+delay+1:end,i)))
            badEyeVisual(:,i) = madEye(:,i);
            badVisualIdx(c) = i;
            c = c + 1;
        else
            goodEyeVisual(:,i) = madEye(:,i);
            goodVisualIdx(d) = i;
            d = d + 1;
        end
        
        if find(isnan(madEye(1:tLength/2,i)))
            badEyeDark(:,i) = madEye(:,i);
            badDarkIdx(e) = i;
            e = e + 1;
        else
            goodEyeDark(:,i) = madEye(:,i);
            goodDarkIdx(f) = i;
            f = f + 1;
        end
    end
    
    goodCuedBegin = goodCuedIdx(find(goodCuedIdx <= 25));
    goodEyeCuedBeginAvg = nanmean(goodEyeCued(:,goodCuedBegin),2);
    goodCuedEnd = goodCuedIdx(find(goodCuedIdx >= size(madEye,2)-24));
    goodEyeCuedEndAvg = nanmean(goodEyeCued(:,goodCuedEnd),2);
    figure()
    subplot(2,1,1); hold on
    plot(goodEyeCued(:,goodCuedBegin))
    subplot(2,1,2); hold on
    plot(goodEyeCued(:,goodCuedEnd))
    
    figure(); hold on
    plot(goodEyeCuedBeginAvg)
    plot(goodEyeCuedEndAvg)
    
    goodVisualBegin = goodVisualIdx(find(goodVisualIdx <= 25));
    goodEyeVisualBeginAvg = nanmean(goodEyeVisual(:,goodVisualBegin),2);
    goodVisualEnd = goodVisualIdx(find(goodVisualIdx >= size(madEye,2)-24));
    goodEyeVisualEndAvg = nanmean(goodEyeVisual(:,goodVisualEnd),2);
    figure()
    subplot(2,1,1); hold on
    plot(goodEyeVisual(:,goodVisualBegin))
    subplot(2,1,2); hold on
    plot(goodEyeVisual(:,goodVisualEnd))
    
    figure(); hold on
    plot(goodEyeVisualBeginAvg)
    plot(goodEyeVisualEndAvg)
    
    goodDarkBegin = goodDarkIdx(find(goodDarkIdx <= 25));
    goodEyeDarkBeginAvg = nanmean(goodEyeDark(:,goodDarkBegin),2);
    goodDarkEnd = goodDarkIdx(find(goodDarkIdx >= size(madEye,2)-24));
    goodEyeDarkEndAvg = nanmean(goodEyeDark(:,goodDarkEnd),2);
    figure()
    subplot(2,1,1); hold on
    plot(goodEyeDark(:,goodDarkBegin))
    subplot(2,1,2); hold on
    plot(goodEyeDark(:,goodDarkEnd))
    
    figure(); hold on
    plot(goodEyeDarkBeginAvg)
    plot(goodEyeDarkEndAvg)
end

%% 
if protocol == 1
    drumVelProbe1 = cat(2,drCycProbe{1:numProbeBlocks});
    drumVelProbe2 = cat(2,drCycProbe{1:numProbeBlocks,2});
    drumVelProbe1reshape = reshape(drumVelProbe1,length(probeEyeVel1),size(probeEyeVel1,2));
    drumVelProbe2reshape = reshape(drumVelProbe2,length(probeEyeVel2),size(probeEyeVel2,2));
    drumVelProbe1avg = mean(drumVelProbe1reshape,2);
    drumVelProbe2avg = mean(drumVelProbe2reshape,2);
    eyeVelProbe1avg = nanmean(madEyeProbe1,2);
    eyeVelProbe2avg = nanmean(madEyeProbe2,2);
    
    eyeAccProbe1 = [diff(madEyeProbeVector1); 0]*100;
    eyeAccProbe2 = [diff(madEyeProbeVector2); 0]*100;
    eyeAccProbe1mat = reshape(eyeAccProbe1,probeSep(1),size(probeEyeVel1,2));
    eyeAccProbe2mat = reshape(eyeAccProbe2,probeSep(2),size(probeEyeVel2,2));
    eyeAccProbe1mat(end,:) = NaN;
    eyeAccProbe2mat(end,:) = NaN;
    eyeAccProbe1avg = nanmean(eyeAccProbe1mat,2);
    eyeAccProbe2avg = nanmean(eyeAccProbe2mat,2);
    
    a = 1;
    for i = 1:4:size(madEyeProbe1,2)
        eyeProbe1multiBlockAvg(1:size(madEyeProbe1,1),a) = nanmean(madEyeProbe1(:,i:i+3),2);
        eyeProbe2multiBlockAvg(1:size(madEyeProbe2,1),a) = nanmean(madEyeProbe2(:,i:i+3),2);
        eyeAccProbe1multiBlockAvg(1:size(eyeAccProbe1mat,1),a) = nanmean(eyeAccProbe1mat(:,i:i+3),2);
        eyeAccProbe2multiBlockAvg(1:size(eyeAccProbe2mat,1),a) = nanmean(eyeAccProbe2mat(:,i:i+3),2);
        a = a + 1;
    end
    
    c = cool(28);
    multiPlot = figure('Name','Probe trials');
    subplot(2,2,1); hold on
    for i = 1:numProbeBlocks
        plot(circshift(madEyeProbe1(:,i),-1100),'Color',c(i,:))
    end
    plot(circshift(drumVelProbe1avg,-1100),'Color','r','LineWidth',2)
    plot(drumVelLastAvg,'Color','y','LineWidth',2)
    plot(eyeVelLastAvg,'Color','k','LineWidth',2)
    title('Cued offset change')
    
    subplot(2,2,2); hold on
    plot(circshift(drumVelProbe2avg,-3100),'Color','r','LineWidth',2)
    for i = 1:numProbeBlocks
        plot(circshift(madEyeProbe2(:,i),-3100),'Color',c(i,:))
    end
    title('Drum offset change')
    
    subplot(2,2,3); hold on
    plot(circshift(drumVelProbe1avg,-1100),'Color','r','LineWidth',2)
    plot(drumVelFirstAvg,'Color','y','LineWidth',2)
    plot(circshift(eyeVelProbe1avg,-1100))
    plot(eyeVelLastAvg,'Color','k','LineWidth',2)
    legend('Drum vel probe.','Drum vel training.','Probe eye vel.','Training eye vel.')
    
    subplot(2,2,4); hold on
    plot(circshift(drumVelProbe2avg,-3100),'Color','r','LineWidth',2)
    plot(drumVelFirstAvg,'Color','y','LineWidth',2)
    plot(circshift(eyeVelProbe2avg,-3100))
    plot(eyeVelLastAvg,'Color','k','LineWidth',2)
    legend('Probe drum vel.','Training drum vel.','Probe eye vel.','Training eye vel.')
    labelOff = axes(multiPlot,'visible','off');
    labelOff.XLabel.Visible='on';
    labelOff.YLabel.Visible='on';
    ylabel(labelOff,'Velocity');
    xlabel(labelOff,'Time (ms)');
    
    %% Plot eye acceleration for probes
    figure()
    subplot(2,1,1); hold on
    plot(circshift(drumVelProbe1avg,-1100))
    plot(circshift(eyeAccProbe1avg,-1100))
    title('Drum onset probe')
    ylabel('Acceleration')
    
    subplot(2,1,2); hold on
    plot(circshift(drumVelProbe2avg,-3100))
    plot(circshift(eyeAccProbe2avg,-3100))
    xlabel('Time (ms)')
    ylabel('Acceleration')
    title('Drum offset probe')
    
    %% Multi-block plots
    c = cool(7);
    figure('Name','Multi-block probe trials')
    subplot(2,1,1); hold on
    for i = 1:size(eyeProbe1multiBlockAvg,2)
        plot(circshift(eyeProbe1multiBlockAvg(:,i),-1100),'Color',c(i,:))
    end
    plot(circshift(drumVelProbe1avg,-1100),'Color','r','LineWidth',3)
    plot(drumVelFirstAvg,'y','LineWidth',3)
    ylabel('Velocity')
    title('Cue offset probe trials')
    legend('Multi-block 1','','','','','','Multi-block 7','')
    
    subplot(2,1,2); hold on
    for i = 1:size(eyeProbe2multiBlockAvg,2)
        plot(circshift(eyeProbe2multiBlockAvg(:,i),-3100),'Color',c(i,:))
    end
    plot(circshift(drumVelProbe2avg,-3100),'Color','r','LineWidth',3)
    plot(drumVelFirstAvg,'y','LineWidth',3)
    xlabel('Time (ms)')
    ylabel('Eye velocity')
    title('Drum offset probe trials')
    legend('','','','','','','','Probe drum vel.','Training drum vel.')
end
%     %% 
% nexttile; hold on
%     for i = 1:numBlocks
%         plot(relEyeBlockAvg{i})
%     end
sacMat = trialEyeVel;
sacMat(madEyeDesacMat) = NaN;
sacAvg = nanmean(sacMat,2);

figure('Name','Saccades'); hold on
plot(sacAvg,'k')
plot(drumVelLastAvg,'cyan')
xlabel('Time (ms)')
ylabel('Velocity')
legend('Saccade avg','Drum vel.')

% if protocol ~= 3
%         nexttile; hold on
%         plot(sacVisualAvg(1:tLength/2),'k')
%         plot(drumVelLastAvg(1:tLength/2),'cyan')
%         title('Dark Period')
%         legend('First 2 blocks eye vel.','Last 2 blocks eye vel.','First 2 blocks drum vel.','Last 2 blocks drum vel.')
% 
%         nexttile; hold on
%         plot(eyeVelFirstAvg(tLength/2+101:tLength/2+delay),'k')
%         plot(eyeVelLastAvg(tLength/2+101:tLength/2+delay),'r')
%         plot(drumVelFirstAvg(tLength/2+101:tLength/2+delay),'b')
%         plot(drumVelLastAvg(tLength/2+101:tLength/2+delay),'cyan')
%         title('Delay Period')
%         xlabel('Time (ms)')
%         ylabel('Velocity')
% 
%         nexttile; hold on
%         plot(eyeVelFirstAvg(tLength/2+delay:trialLength-1),'k')
%         plot(eyeVelLastAvg(tLength/2+delay:trialLength-1),'r')
%         plot(drumVelFirstAvg(tLength/2+delay:trialLength-1),'b')
%         plot(drumVelLastAvg(tLength/2+delay:trialLength-1),'cyan')
%         title('Visual Period')
%         xlabel('Time (ms)')
% end
%% For plots of the raw eye trace overlaid with the desaccaded trace
% eyeDesacAll = zeros(length(numTrials),tLength+delay);
% for i = numTrials
%     eyeDesacAll(i,1:tLength/2) = darkAll(i,2:end);
%     eyeDesacAll(i,tLength/2+1:tLength/2+delay) = cuedAll(i,2:end);
%     eyeDesacAll(i,tLength/2+delay+1:end) = visualAll(i,2:end);
% end
% eyeDesacAll = eyeDesacAll';
% 
% figure(); hold on
% plot(rawEye(:,2),'color','k')
% plot(eyeDesacAll(:,2),'color','r')
% title('Individual trial analysis of desaccading');
% legend('Raw eye vel.','old desaccaded eye vel.');
% xlabel('Time (ms)');
% ylabel('Eye velocity');

%% For plotting many individual trials of raw eye traces

% hold off
% s = stackedplot(rawEye(:,1:6));
% for i = 1:6
%     s.AxesProperties(i).YLimits = [-20 20];
%     s.Color = 'g';
% end
% 
% s = stackedplot(rawEye(:,(end-25):(end-21)));
% for i = 1:5
%     s.AxesProperties(i).YLimits = [-15 15];
%     s.Color = 'g';
% end
% drumAll = drumAll';
% t = stackedplot(drumAll);
