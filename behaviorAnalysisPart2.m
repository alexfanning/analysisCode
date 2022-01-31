%% Reorganizing stimuli and neural data into blocks and grouping according to test condition
desacMethod = 1;                %set to 0 for cluster desaccading or 1 for MAD desaccading
sinesFitting = 0;               %set to 0 for sines-fitting or 1 to skip sines-fitting
minDataLength = 250;            %set minimum data length for removal of data that is not continuous for minimum amount of samples
goodCycMin = 2;                %minimum number of cycles per block needed to add block to cycle-average
nextCycleTime = 250;            %time threshold for averaged time that falls outside of the current cycle
expSubType = 0;                 %set to 0 for default analysis, 1 for alternating x2x0 protocol analyses, 2 for multiple frequency protocol, 3 for VORD acute experiments, 4 for OKR acute experiments, or 5 for VORD training experiments
numConditions = 3;              %number of different conditions to do separate analysis on
thresh = 0.002;                 %threshold for cluster saccade threshold (typically between 0.01-1)
movingMean = 50;                %smoothing of eye data, which turns more "neighbor" points into saccades for cluster desaccading with higher number (typically between 10-150)
madMultiplier = 4;              %multiplier for upper and lower threshold bounds for visual segments
madMultiplierD = 3;             %multiplier for upper and lower threshold bounds for vestibular-dark segments
madMultiplierSp = 3;            %multiplier for upper and lower threshold bounds for gap segments

minDataCheck = 1;
cycAvgPlotting = 1;
sinesFitPlots = 1;
eyeGainPlots = 1;
phasePlots = 1;
prePostPlots = 1;

if expSubType == 2
    cd 'E:\FP\data\l7cre3\l7cre3data0529\l7cre3data05296'                   %path for multiple frequencies experiment
    randFile = fopen('l7cre3data05296.txt');                                %filename for multiple frequencies experiment
    dataRand = fgetl(randFile);
    randBlockStr = str2double(strsplit(dataRand,','));
    numFreq = numel(unique(randBlockStr))-2;                    %for sriramOKRtestModAlex, the number of different test frequencies
    numTestPerFreq = round(numel(randBlockStr)/(numFreq+2));             %for sriramOKRtestModAlex, the total number of sine frequency tests
end

numBlocksVisual = numel(endVisual);             %total number of segments per visual test condition (x2, x0, okr)
numBlocksDark = numel(endDark);                 %total number of segments per VORD test condition
numBlocksGap = numel(endGap);                   %total number of segments per gaps

if (protocol == 0 || protocol == 1) && (condition == 0 || condition == 1 || condition == 2)
    numTimeVisual = round((endVisual(1)/1000)-(startVisual(1)/1000));           %number of seconds for each testing condition for reshaping purposes (visual period)
    numTimeGap = round((endGap(2)/1000)-(startGap(2)/1000));                    %gap period
    numTimeDark = round((endDark(1)/1000)-(startDark(1)/1000));                 %vestibular-dark period
elseif protocol == 3 || expSubType == 4
    numTimeVisual = round((endVisual(1)/1000)-(startVisual(1)/1000));
    numTimeGap = round((endGap(1)/1000)-(startGap(1)/1000));
    numTimeDark = [];
elseif protocol == 0 && condition == 3
    numTimeVisual = [];
    numTimeGap = round((endGap(1)/1000)-(startGap(1)/1000));
    numTimeDark = round((endDark(1)/1000)-(startDark(1)/1000));
elseif protocol == 2
    numTimeVisual = round((endVisual(1)/1000)-(startVisual(1)/1000));           %number of seconds for each testing condition for reshaping purposes (visual period)
    numTimeGap = round((endGap(2)/1000)-(startGap(2)/1000));                    %gap period
    numTimeDark = round((endDark(1)/1000)-(startDark(1)/1000)-2);               %vestibular-dark period
end

%% Create cell arrays for each variable of interest
if numBlocksVisual >= numBlocksDark && numBlocksVisual >= numBlocksGap
    numBlocksMax = numBlocksVisual;
elseif numBlocksDark >= numBlocksVisual && numBlocksDark >= numBlocksGap
    numBlocksMax = numBlocksDark;
else
    numBlocksMax = numBlocksGap;
end

eyeRawBlock = cell(numBlocksMax,numConditions);
eyeRawBlockTrunc = cell(numBlocksMax,numConditions);
eyeRawBlockMat = cell(numBlocksMax,numConditions);
eyeVelFiltBlock = cell(numBlocksMax,numConditions);
eyeVelFiltBlockTrunc = cell(numBlocksMax,numConditions);
eyeVelFiltBlockMat = cell(numBlocksMax,numConditions);
eyeAccRawBlock = cell(numBlocksMax,numConditions);
eyeAccRawBlockTrunc = cell(numBlocksMax,numConditions);
eyeAccRawBlockMat = cell(numBlocksMax,numConditions);
eyePrawBlock = cell(numBlocksMax,numConditions);
eyePrawBlockTrunc = cell(numBlocksMax,numConditions);
eyePrawBlockMat = cell(numBlocksMax,numConditions);
eyePfiltBlock = cell(numBlocksMax,numConditions);
eyePfiltBlockTrunc = cell(numBlocksMax,numConditions);
eyePfiltBlockMat = cell(numBlocksMax,numConditions);
eyeSacsBlock = cell(numBlocksMax,numConditions);
eyeSacsBlockTrunc = cell(numBlocksMax,numConditions);
eyeSacsBlockMat = cell(numBlocksMax,numConditions);
turntableBlock = cell(numBlocksMax,numConditions);
turntableBlockTrunc = cell(numBlocksMax,numConditions);
turntableBlockMat = cell(numBlocksMax,numConditions);
turntablePblock = cell(numBlocksMax,numConditions);
turntablePblockTrunc = cell(numBlocksMax,numConditions);
turntablePblockMat = cell(numBlocksMax,numConditions);
drumPblock = cell(numBlocksVisual,numConditions);
drumPblockTrunc = cell(numBlocksVisual,numConditions);
drumPblockMat = cell(numBlocksVisual,numConditions);
drumVelBlock = cell(numBlocksVisual,numConditions);
drumVelBlockTrunc = cell(numBlocksVisual,numConditions);
drumVelBlockMat = cell(numBlocksVisual,numConditions);
rsBlock = cell(numBlocksVisual,numConditions);
rsBlockTrunc = cell(numBlocksVisual,numConditions);
rsBlockMat = cell(numBlocksVisual,numConditions);
rsFiltBlock = cell(numBlocksVisual,numConditions);
rsFiltBlockTrunc = cell(numBlocksVisual,numConditions);
rsFiltBlockMat = cell(numBlocksVisual,numConditions);

%% Splits data into blocks and with respect to test conditions
keep = numTimeDark * fr;                   %number for what the actual segment length should be per condition, removes extraneous data points
keepL = numTimeVisual * fr;                %for visual blocks
keepSp = numTimeGap * fr;                  %for gap blocks

%dark test segmenting
if numBlocksDark > 0
    nthTime = 1;
    visualRef = 0;
    for i = 1:numBlocksDark
        [eyeRawBlock{i},eyeRawBlockTrunc{i},eyeRawBlockMat{i}] = segmenting(eyeVelRawTrunc,startDark,startGap,endDark,nthTime,fr,frequency,numTimeDark,keep,visualRef);
        [eyeVelFiltBlock{i},eyeVelFiltBlockTrunc{i},eyeVelFiltBlockMat{i}] = segmenting(eyeVelFiltTrunc,startDark,startGap,endDark,nthTime,fr,frequency,numTimeDark,keep,visualRef);
        [eyeAccRawBlock{i},eyeAccRawBlockTrunc{i},eyeAccRawBlockMat{i}] = segmenting(eyeAccRawTrunc,startDark,startGap,endDark,nthTime,fr,frequency,numTimeDark,keep,visualRef);
        [eyePrawBlock{i},eyePrawBlockTrunc{i},eyePrawBlockMat{i}] = segmenting(eyePtrunc,startDark,startGap,endDark,nthTime,fr,frequency,numTimeDark,keep,visualRef);
        [eyePfiltBlock{i},eyePfiltBlockTrunc{i},eyePfiltBlockMat{i}] = segmenting(eyePfiltTrunc,startDark,startGap,endDark,nthTime,fr,frequency,numTimeDark,keep,visualRef);
        [eyeSacsBlock{i},eyeSacsBlockTrunc{i},eyeSacsBlockMat{i}] = segmenting(eyeSacsTrunc,startDark,startGap,endDark,nthTime,fr,frequency,numTimeDark,keep,visualRef);
        [turntableBlock{i},turntableBlockTrunc{i},turntableBlockMat{i}] = segmenting(chVtrunc,startDark,startGap,endDark,nthTime,fr,frequency,numTimeDark,keep,visualRef);
        [turntablePblock{i},turntablePblockTrunc{i},turntablePblockMat{i}] = segmenting(chPtrunc,startDark,startGap,endDark,nthTime,fr,frequency,numTimeDark,keep,visualRef);
        nthTime = nthTime + 1;
    end
end

%visual test segmenting
if numBlocksVisual > 0
    nthTime = 1;
    visualRef = 1;
    for i = 1:numBlocksVisual
        [eyeRawBlock{i,2},eyeRawBlockTrunc{i,2},eyeRawBlockMat{i,2}] = segmenting(eyeVelRawTrunc,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [eyeVelFiltBlock{i,2},eyeVelFiltBlockTrunc{i,2},eyeVelFiltBlockMat{i,2}] = segmenting(eyeVelFiltTrunc,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [eyeAccRawBlock{i,2},eyeAccRawBlockTrunc{i,2},eyeAccRawBlockMat{i,2}] = segmenting(eyeAccRawTrunc,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [eyePrawBlock{i,2},eyePrawBlockTrunc{i,2},eyePrawBlockMat{i,2}] = segmenting(eyePtrunc,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [eyePfiltBlock{i,2},eyePfiltBlockTrunc{i,2},eyePfiltBlockMat{i,2}] = segmenting(eyePfiltTrunc,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [eyeSacsBlock{i,2},eyeSacsBlockTrunc{i,2},eyeSacsBlockMat{i,2}] = segmenting(eyeSacsTrunc,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [turntableBlock{i,2},turntableBlockTrunc{i,2},turntableBlockMat{i,2}] = segmenting(chVtrunc,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [turntablePblock{i,2},turntablePblockTrunc{i,2},turntablePblockMat{i,2}] = segmenting(chPtrunc,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [drumVelBlock{i,2},drumVelBlockTrunc{i,2},drumVelBlockMat{i,2}] = segmenting(drumVelTrunc,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [drumPblock{i,2},drumPblockTrunc{i,2},drumPblockMat{i,2}] = segmenting(drumPtrunc,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [rsBlock{i,2},rsBlockTrunc{i,2},rsBlockMat{i,2}] = segmenting(rsTrunc,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [rsFiltBlock{i,2},rsFiltBlockTrunc{i,2},rsFiltBlockMat{i,2}] = segmenting(rsFiltTrunc,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        nthTime = nthTime + 1;
    end
end
visualRef = 0;

%gap segmenting
if numBlocksGap > 0 && (protocol == 0 || protocol == 1 || protocol == 2)
    nthTime = 1;
    for i = 1:numBlocksGap
        [eyeRawBlock{i,3},eyeRawBlockTrunc{i,3},eyeRawBlockMat{i,3}] = segmenting(eyeVelRawTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [eyeVelFiltBlock{i,3},eyeVelFiltBlockTrunc{i,3},eyeVelFiltBlockMat{i,3}] = segmenting(eyeVelFiltTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [eyeAccRawBlock{i,3},eyeAccRawBlockTrunc{i,3},eyeAccRawBlockMat{i,3}] = segmenting(eyeAccRawTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [eyePrawBlock{i,3},eyePrawBlockTrunc{i,3},eyePrawBlockMat{i,3}] = segmenting(eyePtrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [eyePfiltBlock{i,3},eyePfiltBlockTrunc{i,3},eyePfiltBlockMat{i,3}] = segmenting(eyePfiltTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [eyeSacsBlock{i,3},eyeSacsBlockTrunc{i,3},eyeSacsBlockMat{i,3}] = segmenting(eyeSacsTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [turntableBlock{i,3},turntableBlockTrunc{i,3},turntableBlockMat{i,3}] = segmenting(chVtrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [turntablePblock{i,3},turntablePblockTrunc{i,3},turntablePblockMat{i,3}] = segmenting(chPtrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [drumVelBlock{i,3},drumVelBlockTrunc{i,3},drumVelBlockMat{i,3}] = segmenting(drumVelTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [drumPblock{i,3},drumPblockTrunc{i,3},drumPblockMat{i,3}] = segmenting(drumPtrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        if condition ~= 3
            [rsBlock{i,3},rsBlockTrunc{i,3},rsBlockMat{i,3}] = segmenting(rsTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
            [rsFiltBlock{i,3},rsFiltBlockTrunc{i,3},rsFiltBlockMat{i,3}] = segmenting(rsFiltTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        end
        nthTime = nthTime + 1;
    end
    
elseif numBlocksGap > 0 && protocol == 3
    nthTime = 1;
    for i = 1:numBlocksGap-1
        [eyeRawBlock{i,3},eyeRawBlockTrunc{i,3},eyeRawBlockMat{i,3}] = segmenting(eyeVelRawTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [eyeVelFiltBlock{i,3},eyeVelFiltBlockTrunc{i,3},eyeVelFiltBlockMat{i,3}] = segmenting(eyeVelFiltTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [eyeAccRawBlock{i,3},eyeAccRawBlockTrunc{i,3},eyeAccRawBlockMat{i,3}] = segmenting(eyeAccRawTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [eyePrawBlock{i,3},eyePrawBlockTrunc{i,3},eyePrawBlockMat{i,3}] = segmenting(eyePtrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [eyePfiltBlock{i,3},eyePfiltBlockTrunc{i,3},eyePfiltBlockMat{i,3}] = segmenting(eyePfiltTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [eyeSacsBlock{i,3},eyeSacsBlockTrunc{i,3},eyeSacsBlockMat{i,3}] = segmenting(eyeSacsTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [turntableBlock{i,3},turntableBlockTrunc{i,3},turntableBlockMat{i,3}] = segmenting(chVtrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [turntablePblock{i,3},turntablePblockTrunc{i,3},turntablePblockMat{i,3}] = segmenting(chPtrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [drumVelBlock{i,3},drumVelBlockTrunc{i,3},drumVelBlockMat{i,3}] = segmenting(drumVelTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [drumPblock{i,3},drumPblockTrunc{i,3},drumPblockMat{i,3}] = segmenting(drumPtrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        if condition ~= 3
            [rsBlock{i,3},rsBlockTrunc{i,3},rsBlockMat{i,3}] = segmenting(rsTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
            [rsFiltBlock{i,3},rsFiltBlockTrunc{i,3},rsFiltBlockMat{i,3}] = segmenting(rsFiltTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        end
        nthTime = nthTime + 1;
    end
end

%% Desaccading
eyeDarkMatIn = [eyeRawBlockMat{1:numBlocksDark,1}]';
eyeVisualMatIn = [eyeRawBlockMat{1:numBlocksVisual,2}]';
eyeGapMatIn = [eyeRawBlockMat{1:numBlocksGap,3}]';

if desacMethod == 0
% Cluster desaccading
    clusterSize = size(calDarkMatIn,1)/3;
    clusterSize = 2*floor(clusterSize)/2 - 1;
    
    [eyeDarkMatOut,eyeVisualMatOut,eyeGapMatOut,eyeDarkSacVector,eyeVisualSacVector,eyeGapSacVector] = clusterDesaccading(eyeDarkMatIn,eyeVisualMatIn,eyeGapMatIn,movingMean,thresh,clusterSize,'Cluster desaccaded eye vel.');
    
    eyeDarkSacs = eyeDarkMatIn';
    eyeVisualSacs = eyeVisualMatIn';
    eyeGapSacs = eyeGapMatIn';
    saccadesDarkMat = reshape(eyeDarkSacVector,fr*(1/frequency),numBlocksDark*numTimeDark);
    saccadesVisualMat = reshape(eyeVisualSacVector,fr*(1/frequency),numBlocksVisual*numTimeVisual);
    saccadesGapMat = reshape(eyeGapSacVector,fr*(1/frequency),numBlocksGap*numTimeGap);
    eyeDarkSacs(saccadesDarkMat) = NaN;
    eyeVisualSacs(saccadesVisualMat) = NaN;
    eyeGapSacs(saccadesGapMat) = NaN;
    
elseif desacMethod == 1
% MAD desaccading
    [eyeVisualMatOut,eyeDarkMatOut,eyeGapMatOut,eyeVisualOutVector,eyeDarkOutVector,eyeGapOutVector,saccadesDarkMat,saccadesVisualMat,saccadesGapMat] = madDesac(numBlocksDark,numBlocksVisual,numBlocksGap,madMultiplier,madMultiplierD,madMultiplierSp,eyeVisualMatIn,eyeDarkMatIn,eyeGapMatIn,presac,postsac,'MAD desaccading eye vel.');

    eyeDarkSacs = eyeDarkMatIn';
    eyeVisualSacs = eyeVisualMatIn';
    eyeGapSacs = eyeGapMatIn';
    eyeDarkSacs(saccadesDarkMat) = NaN;
    eyeVisualSacs(saccadesVisualMat) = NaN;
    eyeGapSacs(saccadesGapMat) = NaN;
end

%% Remove data that isn't continuous for minimum amount of time
eyeVisualMatOutVector = eyeVisualMatOut(:);
eyeDarkMatOutVector = eyeDarkMatOut(:);
eyeGapMatOutVector = eyeGapMatOut(:);
[nanLocsVisual, ~] = find(isnan(eyeVisualMatOutVector));
[nanLocsDark, ~] = find(isnan(eyeDarkMatOutVector));
[nanLocsGap, ~] = find(isnan(eyeGapMatOutVector));
keepChunksVisual = nanLocsVisual(2:end) - nanLocsVisual(1:end-1);
keepChunksDark = nanLocsDark(2:end) - nanLocsDark(1:end-1);
keepChunksGap = nanLocsGap(2:end) - nanLocsGap(1:end-1);
keepChunksVisual(keepChunksVisual == 1) = [];
keepChunksDark(keepChunksDark == 1) = [];
keepChunksGap(keepChunksGap == 1) = [];
nanEndsVisual = find((nanLocsVisual(2:end) - nanLocsVisual(1:end-1)) -1);
nanEndsDark = find((nanLocsDark(2:end) - nanLocsDark(1:end-1)) -1);
nanEndsGap = find((nanLocsGap(2:end) - nanLocsGap(1:end-1)) -1);
nanEndsAbsVisual = nanLocsVisual(nanEndsVisual);
nanEndsAbsDark = nanLocsDark(nanEndsDark);
nanEndsAbsGap = nanLocsGap(nanEndsGap);
goodChunkStartsVisual = nanEndsAbsVisual + 1;
goodChunkStartsDark = nanEndsAbsDark + 1;
goodChunkStartsGap = nanEndsAbsGap + 1;

goodChunkStartsVisual(keepChunksVisual >= minDataLength) = [];
goodChunkStartsDark(keepChunksDark >= minDataLength) = [];
goodChunkStartsGap(keepChunksGap >= minDataLength) = [];
keepChunksVisual(keepChunksVisual >= minDataLength) = [];
keepChunksDark(keepChunksDark >= minDataLength) = [];
keepChunksGap(keepChunksGap >= minDataLength) = [];
eyeTestVisual = eyeVisualMatOutVector;
eyeTestDark = eyeDarkMatOutVector;
eyeTestGap = eyeGapMatOutVector;
for ii = 1:length(goodChunkStartsVisual)
    eyeVisualMatOutVector(goodChunkStartsVisual(ii):goodChunkStartsVisual(ii)+keepChunksVisual(ii)-1) = NaN;
end
for ii = 1:length(goodChunkStartsDark)
    eyeDarkMatOutVector(goodChunkStartsDark(ii):goodChunkStartsDark(ii)+keepChunksDark(ii)-1) = NaN;
end
for ii = 1:length(goodChunkStartsGap)
    eyeGapMatOutVector(goodChunkStartsGap(ii):goodChunkStartsGap(ii)+keepChunksGap(ii)-1) = NaN;
end

if minDataCheck == 1
    minDataPlot(eyeTestVisual,eyeVisualMatOutVector,eyeTestDark,eyeDarkMatOutVector,eyeTestGap,eyeGapMatOutVector,'Minimum data removal');
end

eyeVisualMatOut = reshape(eyeVisualMatOutVector,fr*1/frequency,numTimeVisual*frequency*numBlocksVisual);
eyeDarkMatOut = reshape(eyeDarkMatOutVector,fr*1/frequency,numTimeDark*frequency*numBlocksDark);
eyeGapMatOut = reshape(eyeGapMatOutVector,fr*1/frequency,numTimeGap*frequency*numBlocksGap);

badCyclesVisual = zeros(size(eyeVisualMatOut,2),1);
for i = 1:size(eyeVisualMatOut,2)
    bad = find(isnan(eyeVisualMatOut(:,i)));
    if ~isempty(bad)
        badCyclesVisual(i) = 1;
    end
end

badCyclesDark = zeros(size(eyeDarkMatOut,2),1);
for i = 1:size(eyeDarkMatOut,2)
    bad = find(isnan(eyeDarkMatOut(:,i)));
    if ~isempty(bad)
        badCyclesDark(i) = 1;
    end
end

badCyclesGap = zeros(size(eyeGapMatOut,2),1);
for i = 1:size(eyeGapMatOut,2)
    bad = find(isnan(eyeGapMatOut(:,i)));
    if ~isempty(bad)
        badCyclesGap(i) = 1;
    end
end

goodCyclesVisual = NaN(numBlocksVisual,1);
j = 1;
for i = 1:numBlocksVisual
    goodCyclesVisual(i) = sum(badCyclesVisual(j:j+(numTimeVisual*frequency)-1));
    j = j + numTimeVisual*frequency;
end

goodCyclesDark = NaN(numBlocksDark,1);
j = 1;
for i = 1:numBlocksDark
    goodCyclesDark(i) = sum(badCyclesDark(j:j+(numTimeDark*frequency)-1));
    j = j + numTimeDark*frequency;
end

goodCyclesGap = NaN(numBlocksGap,1);
j = 1;
for i = 1:numBlocksGap
    goodCyclesGap(i) = sum(badCyclesGap(j:j+(numTimeGap*frequency)-1));
    j = j + numTimeGap*frequency;
end

%% Blocks to keep calculation
blocks2keepVisual = zeros(1,numBlocksVisual);
for i = 1:numBlocksVisual
    if goodCyclesVisual(i) < goodCycMin
        blocks2keepVisual(i) = 1;
    end
end

blocks2keepDark = zeros(1,numBlocksDark);
for i = 1:numBlocksDark
    if goodCyclesDark(i) < goodCycMin
        blocks2keepDark(i) = 1;
    end
end

blocks2keepGap = zeros(1,numBlocksGap);
for i = 1:numBlocksGap
    if goodCyclesGap(i) < goodCycMin
        blocks2keepGap(i) = 1;
    end
end

%removing blocks with too few cycles
m = 1;
for i = 1:numBlocksVisual
    if blocks2keepVisual(i) == 1
        eyeVisualMatOut(:,m:m+numTimeVisual-1) = NaN;
    end
    m = m + numTimeVisual;
end

m = 1;
for i = 1:numBlocksDark
    if blocks2keepDark(i) == 1
        eyeDarkMatOut(:,m:m+numTimeDark-1) = NaN;
    end
    m = m + numTimeDark;
end

m = 1;
for i = 1:numBlocksGap
    if blocks2keepGap(i) == 1
        eyeGapMatOut(:,m:m+numTimeGap-1) = NaN;
    end
    m = m + numTimeGap;
end
    
%% Calculate average of each block and across whole record for each condition
turntableDarkBlockAvg = cellfun(@(x) nanmean(x,2),turntableBlockMat(1:numBlocksDark,1),'UniformOutput',false);
turntableVisualBlockAvg = cellfun(@(x) nanmean(x,2),turntableBlockMat(1:numBlocksVisual,2),'UniformOutput',false);
turntableGapBlockAvg = cellfun(@(x) nanmean(x,2),turntableBlockMat(1:numBlocksGap,3),'UniformOutput',false);
turntablePdarkBlockAvg = cellfun(@(x) nanmean(x,2),turntableBlockMat(1:numBlocksDark,1),'UniformOutput',false);
turntablePvisualBlockAvg = cellfun(@(x) nanmean(x,2),turntablePblockMat(1:numBlocksVisual,2),'UniformOutput',false);
turntablePgapBlockAvg = cellfun(@(x) nanmean(x,2),turntablePblockMat(1:numBlocksGap,3),'UniformOutput',false);
drumVelVisualBlockAvg = cellfun(@(x) nanmean(x,2),drumVelBlockMat(1:numBlocksVisual,2),'UniformOutput',false);
drumVelGapBlockAvg = cellfun(@(x) nanmean(x,2),drumVelBlockMat(1:numBlocksGap,3),'UniformOutput',false);
drumPvisualBlockAvg = cellfun(@(x) nanmean(x,2),drumPblockMat(1:numBlocksVisual,2),'UniformOutput',false);
drumPgapBlockAvg = cellfun(@(x) nanmean(x,2),drumPblockMat(1:numBlocksGap,3),'UniformOutput',false);

turntableDarkAvg = mean(cat(2,turntableDarkBlockAvg{1:numBlocksDark}),2);
turntableVisualAvg = mean(cat(2,turntableVisualBlockAvg{1:numBlocksVisual}),2);
turntableGapAvg = mean(cat(2,turntableGapBlockAvg{1:numBlocksGap}),2);
turntablePdarkAvg = mean(cat(2,turntablePdarkBlockAvg{1:numBlocksDark}),2);
turntablePvisualAvg = mean(cat(2,turntablePvisualBlockAvg{1:numBlocksVisual}),2);
turntablePgapAvg = mean(cat(2,turntablePgapBlockAvg{1:numBlocksGap}),2);
drumVelVisualAvg = mean(cat(2,drumVelVisualBlockAvg{1:numBlocksVisual}),2);
drumVelGapAvg = mean(cat(2,drumVelGapBlockAvg{1:numBlocksGap}),2);
drumPvisualAvg = mean(cat(2,drumPvisualBlockAvg{1:numBlocksVisual}),2);
drumPgapAvg = mean(cat(2,drumPgapBlockAvg{1:numBlocksGap}),2);

turntableDarkBlockAvgMat = cat(2,turntableDarkBlockAvg{1:end});
turntableVisualBlockAvgMat = cat(2,turntableVisualBlockAvg{1:end});
drumVelVisualBlockAvgMat = cat(2,drumVelVisualBlockAvg{1:end});

eyeIpsiBlockAmp = NaN(numBlocksMax,numConditions);
eyeIpsiBlockAmpIdx = NaN(numBlocksMax,numConditions);
eyeContraBlockAmp = NaN(numBlocksMax,numConditions);
eyeContraBlockAmpIdx = NaN(numBlocksMax,numConditions);
headIpsiBlockAmp = NaN(numBlocksMax,numConditions);
headContraBlockAmp = NaN(numBlocksMax,numConditions);
headIpsiBlockAmpIdx = NaN(numBlocksMax,numConditions);
headContraBlockAmpIdx = NaN(numBlocksMax,numConditions);

%vestibular-dark cycle-averaging and amplitude calculations
if expSubType ~= 3
    eyeDarkBlockAvg = NaN(fr*(1/frequency),numBlocksDark);
    eyeSacsDarkBlockAvg = NaN(fr*(1/frequency),numBlocksDark);
end
t = 1:numTimeDark*frequency;
while t < size(eyeDarkMatOut,2)
    for i = 1:numBlocksDark
        eyeDarkBlockAvg(1:fr*(1/frequency),i) = nanmean(eyeDarkMatOut(:,t),2);
        eyeSacsDarkBlockAvg(1:fr*(1/frequency),i) = nanmean(eyeDarkSacs(:,t),2);
        [eyeIpsiBlockAmp(i,1),eyeIpsiBlockAmpIdx(i,1)] = max(eyeDarkBlockAvg(:,i));
        [eyeContraBlockAmp(i,1),eyeContraBlockAmpIdx(i,1)] = min(eyeDarkBlockAvg(:,i));
        [headIpsiBlockAmp(i,1),headIpsiBlockAmpIdx(i,1)] = max(turntableDarkBlockAvg{i});
        [headContraBlockAmp(i,1),headContraBlockAmpIdx(i,1)] = min(turntableDarkBlockAvg{i});
        if nextCycleTime ~= 0
            if eyeIpsiBlockAmpIdx(i,1) > nextCycleTime*(1/frequency) + fr*(1/frequency)/2
                eyeIpsiBlockAmpIdx(i,1) = eyeIpsiBlockAmpIdx(i,1) - fr*(1/frequency);
            end
            if eyeContraBlockAmpIdx(i,1) < nextCycleTime*(1/frequency)
                eyeContraBlockAmpIdx(i,1) = eyeContraBlockAmpIdx(i,1) + fr*(1/frequency);
            end
        end
        t = t + numTimeDark*frequency;
    end
end
eyeDarkAvg = nanmean(eyeDarkMatOut,2);
eyeSacsDarkAvg = nanmean(eyeDarkSacs,2);

[eyeIpsiAmpAvg(1),eyeIpsiAmpIdxAvg(1)] = max(eyeDarkAvg);
[eyeContraAmpAvg(1),eyeContraAmpIdxAvg(1)] = min(eyeDarkAvg);
[headIpsiAmpAvg(1),headIpsiAmpIdxAvg(1)] = max(turntableDarkAvg);
[headContraAmpAvg(1),headContraAmpIdxAvg(1)] = min(turntableDarkAvg);

if expSubType ~= 3
    %visual cycle-averaging and amplitude calculations
    rsBlockAmp = NaN(numBlocksVisual,numConditions);
    rsBlockAmpIdx = NaN(numBlocksVisual,numConditions);
    drumIpsiBlockAmp = NaN(numBlocksMax,numConditions);
    drumContraBlockAmp = NaN(numBlocksMax,numConditions);
    drumIpsiBlockAmpIdx = NaN(numBlocksMax,numConditions);
    drumContraBlockAmpIdx = NaN(numBlocksMax,numConditions);

    rsDesacMat = cat(2,rsBlockMat{1:numBlocksVisual,2});
    rsDesacMat(~saccadesVisualMat) = NaN;
    
    eyeVisualBlockAvg = NaN(fr*(1/frequency),numBlocksVisual);
    eyeSacsVisualBlockAvg = NaN(fr*(1/frequency),numBlocksVisual);
    rsVisualBlockAvg = NaN(fr*(1/frequency),numBlocksVisual);
    t = 1:numTimeVisual*frequency;
    while t < size(eyeVisualMatOut,2)
        for i = 1:numBlocksVisual
            eyeVisualBlockAvg(1:fr*(1/frequency),i) = nanmean(eyeVisualMatOut(:,t),2);
            eyeSacsVisualBlockAvg(1:fr*(1/frequency),i) = nanmean(eyeVisualSacs(:,t),2);
            rsVisualBlockAvg(1:fr*(1/frequency),i) = nanmean(rsDesacMat(:,t),2);
            [eyeIpsiBlockAmp(i,2),eyeIpsiBlockAmpIdx(i,2)] = max(eyeVisualBlockAvg(:,i));
            [eyeContraBlockAmp(i,2),eyeContraBlockAmpIdx(i,2)] = min(eyeVisualBlockAvg(:,i));
            [headIpsiBlockAmp(i,2),headIpsiBlockAmpIdx(i,2)] = max(turntableVisualBlockAvg{i});
            [headContraBlockAmp(i,2),headContraBlockAmpIdx(i,2)] = min(turntableVisualBlockAvg{i});
            [drumIpsiBlockAmp(i,1),drumIpsiBlockAmpIdx(i,1)] = max(drumVelVisualBlockAvg{i});
            [drumContraBlockAmp(i,1),drumContraBlockAmpIdx(i,1)] = min(drumVelVisualBlockAvg{i});
            [rsBlockAmp(i,1),rsBlockAmpIdx(i,1)] = min(rsVisualBlockAvg(:,i));
            if nextCycleTime ~= 0
                if condition == 0
                    if eyeIpsiBlockAmpIdx(i,2) > nextCycleTime*(1/frequency) + fr*(1/frequency)/2
                        eyeIpsiBlockAmpIdx(i,2) = eyeIpsiBlockAmpIdx(i,2) - fr*(1/frequency);
                    end
                    if eyeContraBlockAmpIdx(i,2) < nextCycleTime*(1/frequency)
                        eyeContraBlockAmpIdx(i,2) = eyeContraBlockAmpIdx(i,2) + fr*(1/frequency);
                    end
                    if rsBlockAmpIdx(i,1) > nextCycleTime*(1/frequency) + fr*(1/frequency)/2
                        rsBlockAmpIdx(i,1) = rsBlockAmpIdx(i,1) - fr*(1/frequency);
                    end
                elseif condition == 1 || condition == 2
                    if eyeIpsiBlockAmpIdx(i,2) > nextCycleTime*(1/frequency) + fr*(1/frequency)/2
                        eyeIpsiBlockAmpIdx(i,2) = eyeIpsiBlockAmpIdx(i,2) - fr*(1/frequency);
                    end
                    if eyeContraBlockAmpIdx(i,2) < nextCycleTime*(1/frequency)
                        eyeContraBlockAmpIdx(i,2) = eyeContraBlockAmpIdx(i,2) + fr*(1/frequency);
                    end
                    if rsBlockAmpIdx(i,1) < nextCycleTime*(1/frequency)
                        rsBlockAmpIdx(i,1) = rsBlockAmpIdx(i,1) + fr*(1/frequency);
                    end
                end
            end
            t = t + numTimeVisual*frequency;
        end
    end
    eyeVisualAvg = nanmean(eyeVisualMatOut,2);
    eyeSacsVisualAvg = nanmean(eyeVisualSacs,2);
    rsVisualAvg = nanmean(rsDesacMat,2);

    [eyeIpsiAmpAvg(2),eyeIpsiAmpIdxAvg(2)] = max(eyeVisualAvg);
    [eyeContraAmpAvg(2),eyeContraAmpIdxAvg(2)] = min(eyeVisualAvg);
    [headIpsiAmpAvg(2),headIpsiAmpIdxAvg(2)] = max(turntableVisualAvg);
    [headContraAmpAvg(2),headContraAmpIdxAvg(2)] = min(turntableVisualAvg);
    [drumIpsiAmpAvg(2),drumIpsiAmpIdxAvg(2)] = max(drumVelVisualAvg);
    [drumContraAmpAvg(2),drumContraAmpIdxAvg(2)] = min(drumVelVisualAvg);
    [rsAmpAvg(1),rsAmpIdxAvg(1)] = min(rsVisualAvg);

    %gap cycle-averaging
    eyeGapBlockAvg = NaN(fr*(1/frequency),numBlocksGap);
    eyeSacsGapBlockAvg = NaN(fr*(1/frequency),numBlocksGap);
    t = 1:numTimeGap*frequency;
    while t < size(eyeGapMatOut,2)
        for i = 1:numBlocksGap
            eyeGapBlockAvg(1:fr*(1/frequency),i) = nanmean(eyeGapMatOut(:,t),2);
            eyeSacsGapBlockAvg(1:fr*(1/frequency),i) = nanmean(eyeGapSacs(:,t),2);
            t = t + numTimeGap*frequency;
        end
    end
    eyeGapAvg = nanmean(eyeGapMatOut,2);
    eyeSacsGapAvg = nanmean(eyeGapSacs,2);
end

%% plotting cycle averages, amplitude, and timing indexes
if expSubType == 0 || expSubType == 2
    if cycAvgPlotting == 1
        cycAvgPlots(eyeDarkBlockAvg,eyeDarkAvg,eyeVisualBlockAvg,eyeVisualAvg,eyeGapBlockAvg,eyeGapAvg,'Eye vel. block averages');
        cycAvgPlots(eyeSacsDarkBlockAvg,eyeSacsDarkAvg,eyeSacsVisualBlockAvg,eyeSacsVisualAvg,eyeSacsGapBlockAvg,eyeSacsGapAvg,'Saccade block averages');
        
        ampIdxPlots(eyeIpsiBlockAmp,eyeIpsiBlockAmpIdx,eyeIpsiBlockAmp,eyeIpsiBlockAmpIdx,numBlocksVisual,'r','Peak ipsi eye amplitude and timing');
        ampIdxPlots(eyeContraBlockAmp,eyeContraBlockAmpIdx,eyeContraBlockAmp,eyeContraBlockAmpIdx,numBlocksVisual,'r','Peak contra eye amplitude and timing');
        
        figure('Name','Retinal slip (unfitted)')
        subplot(3,1,1); hold on
        plot(rsVisualBlockAvg)
        plot(rsVisualAvg,'Color','k','LineWidth',2)
        xlabel('Time (ms)')
        ylabel('Amplitude')
        title('Block average retinal slip vel.')
        
        subplot(3,1,2); hold on
        m = plot(rsBlockAmp(1:numBlocksVisual,1),'-s','MarkerFaceColor','m');
        m.Color = 'm';
        ylabel('Amplitude')
        title('Peak retinal slip amplitude for each visual block')
        xticks(1:numBlocksVisual)
        xlim([1 numBlocksVisual])

        subplot(3,1,3); hold on
        m = plot(rsBlockAmpIdx(1:numBlocksVisual,1),'-s','MarkerFaceColor','m');
        m.Color = 'm';
        xlabel('Block number')
        ylabel('Time (ms)')
        title('Peak retinal slip amplitude time for each visual block')
        xticks(1:numBlocksVisual)
        xlim([1 numBlocksVisual])
    end
    
elseif expSubType == 1
    %plotting for VOR x2, x0 alternating experiment
    if cycAvgPlotting == 1
        figure('Name','Eye vel. cycle-averages')
        subplot(3,1,1); hold on
        plot(eyeDarkBlockAvg)
        plot(eyeDarkAvg,'Color','k','LineWidth',2)
        subplot(3,1,2); hold on
        plot(eyeVisualBlockAvg(:,1:2:numBlocksVisual))
        plot(mean(eyeVisualBlockAvg(:,1:2:numBlocksVisual),2),'Color','k','LineWidth',2)
        ylabel('Eye velocity')
        xlabel('Time (ms)')
        legend('Block 1','Block 2','Block 3','Gain up avg')
        title('Gain up eye velocity')
        subplot(3,1,3); hold on
        plot(eyeVisualBlockAvg(:,2:2:numBlocksVisual))
        plot(mean(eyeVisualBlockAvg(:,2:2:numBlocksVisual),2),'Color','k','LineWidth',2)
        ylabel('Eye velocity')
        xlabel('Time (ms)')
        legend('Block 1','Block 2','Block 3','Gain down avg')
        title('Gain down eye velocity')
    end
elseif expSubType == 3
    if cycAvgPlotting == 1
        figure('Name','Eye vel. cycle-averages'); hold on
        plot(eyeDarkMatOut)
        plot(eyeDarkAvg,'Color','k','LineWidth',3)
        ylabel('Eye velocity')
        xlabel('Time (ms)')
        title('Vestibular-dark block avg eye vel.')
    end
end

%% Sines-fitting each block and across whole record for each condition
if sinesFitting == 0
    if expSubType ~= 3
        [eyeDarkBlockSine,phaseBlockEyeDark] = sinesFit(eyeDarkBlockAvg,fr,frequency,numBlocksDark,0);
        [eyeVisualBlockSine,phaseBlockEyeVisual] = sinesFit(eyeVisualBlockAvg,fr,frequency,numBlocksVisual,0);
        [headDarkBlockSine,phaseBlockHeadDark] = sinesFit(turntableDarkBlockAvgMat,fr,frequency,numBlocksDark,0);
        [headVisualBlockSine,phaseBlockHeadVisual] = sinesFit(turntableVisualBlockAvgMat,fr,frequency,numBlocksVisual,0);
        [drumVisualBlockSine,phaseBlockDrumVisual] = sinesFit(drumVelVisualBlockAvgMat,fr,frequency,numBlocksVisual,0);
        [rsBlockSine,phaseBlockRS] = sinesFit(rsVisualBlockAvg,fr,frequency,numBlocksVisual,0);
        
        eyeIpsiSineBlockAmp = NaN(numBlocksMax,numConditions);
        eyeIpsiSineBlockAmpIdx = NaN(numBlocksMax,numConditions);
        eyeContraSineBlockAmp = NaN(numBlocksMax,numConditions);
        eyeContraSineBlockAmpIdx = NaN(numBlocksMax,numConditions);
        headIpsiSineBlockAmp = NaN(numBlocksMax,numConditions);
        headIpsiSineBlockAmpIdx = NaN(numBlocksMax,numConditions);
        headContraSineBlockAmp = NaN(numBlocksMax,numConditions);
        headContraSineBlockAmpIdx = NaN(numBlocksMax,numConditions);

        for i = 1:numBlocksDark
            [eyeIpsiSineBlockAmp(i,1),eyeIpsiSineBlockAmpIdx(i,1)] = max(eyeDarkBlockSine{i});
            [eyeContraSineBlockAmp(i,1),eyeContraSineBlockAmpIdx(i,1)] = min(eyeDarkBlockSine{i});
            [headIpsiSineBlockAmp(i,1),headIpsiSineBlockAmpIdx(i,1)] = max(headDarkBlockSine{i});
            [headContraSineBlockAmp(i,1),headContraSineBlockAmpIdx(i,1)] = min(headDarkBlockSine{i});
            if nextCycleTime ~= 0
                if eyeIpsiSineBlockAmpIdx(i,1) > nextCycleTime*(1/frequency) + fr*(1/frequency)/2
                    eyeIpsiSineBlockAmpIdx(i,1) = eyeIpsiSineBlockAmpIdx(i,1) - fr*(1/frequency);
                end
                if eyeContraSineBlockAmpIdx(i,1) < nextCycleTime*(1/frequency)
                    eyeContraSineBlockAmpIdx(i,1) = eyeContraSineBlockAmpIdx(i,1) + fr*(1/frequency);
                end
            end
        end

        drumIpsiSineBlockAmp = NaN(numBlocksVisual,numConditions);
        drumIpsiSineBlockAmpIdx = NaN(numBlocksVisual,numConditions);
        drumContraSineBlockAmp = NaN(numBlocksVisual,numConditions);
        drumContraSineBlockAmpIdx = NaN(numBlocksVisual,numConditions);
        rsSineBlockAmp = NaN(numBlocksVisual,numConditions);
        rsSineBlockAmpIdx = NaN(numBlocksVisual,numConditions);
        for i = 1:numBlocksVisual
            [eyeIpsiSineBlockAmp(i,2),eyeIpsiSineBlockAmpIdx(i,2)] = max(eyeVisualBlockSine{i});
            [eyeContraSineBlockAmp(i,2),eyeContraSineBlockAmpIdx(i,2)] = min(eyeVisualBlockSine{i});
            [headIpsiSineBlockAmp(i,2),headIpsiSineBlockAmpIdx(i,2)] = max(headVisualBlockSine{i});
            [headContraSineBlockAmp(i,2),headContraSineBlockAmpIdx(i,2)] = min(headVisualBlockSine{i});
            [drumIpsiSineBlockAmp(i,1),drumIpsiSineBlockAmpIdx(i,1)] = max(drumVisualBlockSine{i});
            [drumContraSineBlockAmp(i,1),drumContraSineBlockAmpIdx(i,1)] = min(drumVisualBlockSine{i});
            [rsSineBlockAmp(i,1),rsSineBlockAmpIdx(i,1)] = min(rsBlockSine{i});
            if nextCycleTime ~= 0
                if condition == 0
                    if eyeIpsiSineBlockAmpIdx(i,2) > nextCycleTime*(1/frequency) + fr*(1/frequency)/2
                        eyeIpsiSineBlockAmpIdx(i,2) = eyeIpsiSineBlockAmpIdx(i,2) - fr*(1/frequency);
                    end
                    if eyeContraSineBlockAmpIdx(i,2) < nextCycleTime*(1/frequency)
                        eyeContraSineBlockAmpIdx(i,2) = eyeContraSineBlockAmpIdx(i,2) + fr*(1/frequency);
                    end
                    if rsSineBlockAmpIdx(i,1) > nextCycleTime*(1/frequency) + fr*(1/frequency)/2
                        rsSineBlockAmpIdx(i,1) = rsSineBlockAmpIdx(i,1) - fr*(1/frequency);
                    end
                elseif condition == 1 || condition == 2
                    if eyeIpsiSineBlockAmpIdx(i,2) > nextCycleTime*(1/frequency) + fr*(1/frequency)/2
                        eyeIpsiSineBlockAmpIdx(i,2) = eyeIpsiSineBlockAmpIdx(i,2) - fr*(1/frequency);
                    end
                    if eyeContraSineBlockAmpIdx(i,2) < nextCycleTime*(1/frequency)
                        eyeContraSineBlockAmpIdx(i,2) = eyeContraSineBlockAmpIdx(i,2) + fr*(1/frequency);
                    end
                    if rsSineBlockAmpIdx(i,1) < nextCycleTime*(1/frequency)
                        rsSineBlockAmpIdx(i,1) = rsSineBlockAmpIdx(i,1) + fr*(1/frequency);
                    end
                end
            end
        end
        
        [rsSine,phaseRS] = sinesFit(rsVisualAvg,fr,frequency,numBlocksVisual,1);
        [drumVisualSine,phaseDrumVisual] = sinesFit(drumVelVisualAvg,fr,frequency,numBlocksVisual,1);
        
        rsSineAmpAvg = min(rsSine(1,:));
        drumIpsiSineAmpAvg = max(drumVisualSine(1,:));
        drumContraSineAmpAvg = min(drumVisualSine(1,:));
        
    end
    
    [eyeDarkSine,phaseEyeDark] = sinesFit(eyeDarkAvg,fr,frequency,numBlocksDark,1);
    [eyeVisualSine,phaseEyeVisual] = sinesFit(eyeVisualAvg,fr,frequency,numBlocksVisual,1);
    [headDarkSine,phaseHeadDark] = sinesFit(turntableDarkAvg,fr,frequency,numBlocksDark,1);
    [headVisualSine,phaseHeadVisual] = sinesFit(turntableVisualAvg,fr,frequency,numBlocksVisual,1);
    
    [eyeIpsiSineAmpAvg,eyeIpsiSineAmpIdxAvg] = max(eyeDarkSine(1,:));
    [eyeContraSineAmpAvg,eyeContraSineAmpIdxAvg] = min(eyeDarkSine(1,:));
    [headIpsiSineAmpAvg,headIpsiSineAmpIdxAvg] = max(headDarkSine(1,:));
    [headContraSineAmpAvg,headContraSineAmpIdxAvg] = min(headDarkSine(1,:));
    
    if expSubType ~= 3
        eyeIpsiSineAmpAvg(2,:) = max(eyeVisualSine);
        eyeContraSineAmpAvg(2,:) = min(eyeVisualSine);
        headIpsiSineAmpAvg(2,:) = max(headVisualSine);
        headContraSineAmpAvg(2,:) = min(headVisualSine);

        if sinesFitPlots == 1
            cycAvgPlots(eyeDarkBlockSine,eyeDarkSine,eyeVisualBlockSine,eyeVisualSine,eyeDarkBlockSine,eyeDarkSine,'Sines-fitted eye vel. block averages');
            cycAvgPlots(headDarkBlockSine,headDarkSine,headVisualBlockSine,headVisualSine,headVisualBlockSine,headVisualSine,'Sines-fitted head vel. block averages');

            figure('Name','Retinal slip (sines-fitted)')
            subplot(3,1,1); hold on
            for i = 1:numBlocksVisual
                plot(rsBlockSine{i})
            end
            plot(rsSine(1,:),'Color','k','LineWidth',2)
            xlabel('Time (ms)')
            ylabel('Amplitude')
            title('Retinal slip vel. block averages')

            subplot(3,1,2); hold on
            m = plot(rsSineBlockAmp(1:numBlocksVisual,1),'-s','MarkerFaceColor','m');
            m.Color = 'm';
            xlabel('Block number')
            ylabel('Amplitude')
            title('Peak retinal slip amplitude for each visual block')
            xticklabels(1:numBlocksVisual)
            xticks(1:numBlocksVisual)

            subplot(3,1,3); hold on
            m = plot(rsSineBlockAmpIdx(1:numBlocksVisual,1),'-s','MarkerFaceColor','m');
            m.Color = 'm';
            xlabel('Block number')
            ylabel('Time (ms)')
            title('Peak retinal slip amplitude time for each visual block')
            xticklabels(1:numBlocksVisual)
            xticks(1:numBlocksVisual)
            
            figure('Name','Block-averaged drum vel.'); hold on
            for i = 1:numBlocksVisual
                plot(drumVisualBlockSine{i,1})
            end
            plot(drumVisualSine(1,:),'Color','k','LineWidth',2)
            xlabel('Time (ms)')
            ylabel('Amplitude')

            ampIdxPlots(eyeIpsiSineBlockAmp,eyeIpsiSineBlockAmpIdx,eyeIpsiSineBlockAmp,eyeIpsiSineBlockAmpIdx,numBlocksVisual,'r','Peak ipsi eye amplitude and timing');
            ampIdxPlots(eyeContraSineBlockAmp,eyeContraSineBlockAmpIdx,eyeContraSineBlockAmp,eyeContraSineBlockAmpIdx,numBlocksVisual,'r','Peak contra eye amplitude and timing');
            ampIdxPlots(headIpsiBlockAmp,headIpsiBlockAmpIdx,headIpsiBlockAmp,headIpsiBlockAmpIdx,numBlocksVisual,'b','Peak ipsi head (sines-fitted) amplitude and timing');
            ampIdxPlots(headContraBlockAmp,headContraBlockAmpIdx,headContraBlockAmp,headContraBlockAmpIdx,numBlocksVisual,'b','Peak contra head (sines-fitted) amplitude and timing');
        end
    else
        figure('Name','Eye vel. cycle-average sines-fitted'); hold on
        plot(eyeDarkSine,'Color','k','LineWidth',2)
        ylabel('Eye vel.')
        xlabel('Time (ms)')
        title('Vestibular-dark block avg calcium response')
    end
end

%%Gain calculations
if expSubType ~= 3
    if protocol ~= 2
        eyeIpsiGain = NaN(numBlocksDark,numConditions*2);
        eyeContraGain = NaN(numBlocksDark,numConditions*2);
        for i = 1:numBlocksDark
            eyeIpsiGain(i,1) = eyeIpsiBlockAmp(i,1) / headContraBlockAmp(i,1);
            eyeContraGain(i,1) = eyeContraBlockAmp(i,1) / headIpsiBlockAmp(i,1);
            eyeIpsiGain(i,3) = eyeIpsiSineBlockAmp(i,1) / headContraSineBlockAmp(i,1);
            eyeContraGain(i,3) = eyeContraSineBlockAmp(i,1) / headIpsiSineBlockAmp(i,1);
        end
        eyeIpsiGainPre = mean(eyeIpsiGain(1:3,1));
        eyeContraGainPre = mean(eyeContraGain(1:3,1));
        eyeIpsiGainPre(2) = mean(eyeIpsiGain(1:3,3));
        eyeContraGainPre(2) = mean(eyeContraGain(1:3,3));
        eyeIpsiGainPost = mean(eyeIpsiGain(numBlocksDark-3:numBlocksDark-1,1));
        eyeContraGainPost = mean(eyeContraGain(numBlocksDark-3:numBlocksDark-1,1));
        eyeIpsiGainPost(2) = mean(eyeIpsiGain(numBlocksDark-3:numBlocksDark-1,3));
        eyeContraGainPost(2) = mean(eyeContraGain(numBlocksDark-3:numBlocksDark-1,3));
        eyeIpsiGainPct = NaN(numBlocksDark-5,numConditions*2);
        eyeContraGainPct = NaN(numBlocksDark-5,numConditions*2);
        eyeIpsiGainPct(1,1) = (eyeIpsiGainPre / eyeIpsiGainPre) - 1;
        eyeContraGainPct(1,1) = (eyeContraGainPre / eyeContraGainPre) - 1;
        eyeIpsiGainPct(1,3) = (eyeIpsiGainPre(2) / eyeIpsiGainPre(2)) - 1;
        eyeContraGainPct(1,3) = (eyeContraGainPre(2) / eyeContraGainPre(2)) - 1;
        for i = 2:numBlocksDark/2
            eyeIpsiGainPct(i,1) = ((eyeIpsiGain(i+2,1) / eyeIpsiGainPre(1))-1) * 100;
            eyeContraGainPct(i,1) = ((eyeContraGain(i+2,1) / eyeContraGainPre(1))-1) * 100;
            eyeIpsiGainPct(i,3) = ((eyeIpsiGain(i+2,3) / eyeIpsiGainPre(2))-1) * 100;
            eyeContraGainPct(i,3) = ((eyeContraGain(i+2,3) / eyeContraGainPre(2))-1) * 100;
        end
        eyeIpsiGainPct(numBlocksDark/2+1,1) = ((eyeIpsiGainPost / eyeIpsiGainPre)-1) * 100;
        eyeContraGainPct(numBlocksDark/2+1,1) = ((eyeContraGainPost / eyeContraGainPre)-1) * 100;
        eyeIpsiGainPct(numBlocksDark/2+1,3) = ((eyeIpsiGainPost(2) / eyeIpsiGainPre(2))-1) * 100;
        eyeContraGainPct(numBlocksDark/2+1,3) = ((eyeContraGainPost(2) / eyeContraGainPre(2))-1) * 100;
    elseif protocol == 2
        eyeIpsiGain = NaN(numBlocksVisual,numConditions*2);
        eyeContraGain = NaN(numBlocksVisual,numConditions*2);
        for i = 1:numBlocksDark
            eyeIpsiGain(i,1) = eyeIpsiBlockAmp(i,1) / headContraBlockAmp(i,1);
            eyeContraGain(i,1) = eyeContraBlockAmp(i,1) / headIpsiBlockAmp(i,1);
            eyeIpsiGain(i,3) = eyeIpsiSineBlockAmp(i,1) / headContraSineBlockAmp(i,1);
            eyeContraGain(i,3) = eyeContraSineBlockAmp(i,1) / headIpsiSineBlockAmp(i,1);
        end
        for i = 1:numBlocksVisual
            eyeIpsiGain(i,2) = eyeIpsiBlockAmp(i,2) / drumIpsiBlockAmp(i,1);
            eyeContraGain(i,2) = eyeContraBlockAmp(i,2) / drumContraBlockAmp(i,1);
            eyeIpsiGain(i,4) = eyeIpsiSineBlockAmp(i,2) / headContraSineBlockAmp(i,2);
            eyeContraGain(i,4) = eyeContraSineBlockAmp(i,2) / headIpsiSineBlockAmp(i,2);
        end
        eyeIpsiGainPre = eyeIpsiGain(1,1);
        eyeContraGainPre = eyeContraGain(1,1);
        eyeIpsiGainPost = eyeIpsiGain(end,1);
        eyeContraGainPost = eyeContraGain(end,1);
        eyeIpsiGainPre(2) = eyeIpsiGain(1,3);
        eyeContraGainPre(2) = eyeContraGain(1,3);
        eyeIpsiGainPost(2) = eyeIpsiGain(end,3);
        eyeContraGainPost(2) = eyeContraGain(end,3);
        
        eyeIpsiGainPct = NaN(3,numConditions*2);
        eyeContraGainPct = NaN(3,numConditions*2);
        eyeIpsiGainPct(1,1) = (eyeIpsiGainPre / eyeIpsiGainPre) - 1;
        eyeContraGainPct(1,1) = (eyeContraGainPre / eyeContraGainPre) - 1;
        eyeIpsiGainPct(2,1) = ((eyeIpsiGain(end,2) / eyeIpsiGain(1,2))-1) * 100;
        eyeContraGainPct(2,1) = ((eyeContraGain(end,2) / eyeContraGain(1,2))-1) * 100;
        eyeIpsiGainPct(3,1) = ((eyeIpsiGainPost / eyeIpsiGainPre)-1) * 100;
        eyeContraGainPct(3,1) = ((eyeContraGainPost / eyeContraGainPre)-1) * 100;
        
        eyeIpsiGainPct(1,2) = (eyeIpsiGainPre(2) / eyeIpsiGainPre(2)) - 1;
        eyeContraGainPct(1,2) = (eyeContraGainPre(2) / eyeContraGainPre(2)) - 1;
        eyeIpsiGainPct(2,2) = ((eyeIpsiGain(end,4) / eyeIpsiGain(1,4))-1) * 100;
        eyeContraGainPct(2,2) = ((eyeContraGain(end,4) / eyeContraGain(1,4))-1) * 100;
        eyeIpsiGainPct(3,2) = ((eyeIpsiGainPost(2) / eyeIpsiGainPre(2))-1) * 100;
        eyeContraGainPct(3,2) = ((eyeContraGainPost(2) / eyeContraGainPre(2))-1) * 100;
    end

    %visual processing
    if condition == 0 || condition == 1
        for i = 1:numBlocksVisual
            eyeIpsiGain(i,2) = eyeIpsiBlockAmp(i,2) / abs(headContraBlockAmp(i,2));
            eyeContraGain(i,2) = abs(eyeContraBlockAmp(i,2)) / headIpsiBlockAmp(i,2);
            eyeIpsiGain(i,4) = eyeIpsiSineBlockAmp(i,2) / abs(headContraSineBlockAmp(i,2));
            eyeContraGain(i,4) = abs(eyeContraSineBlockAmp(i,2)) / headIpsiSineBlockAmp(i,2);
        end

        for i = 1:numBlocksVisual
            eyeIpsiGainPct(i,2) = ((eyeIpsiGain(i,2) / eyeIpsiGain(1,2))-1) * 100;
            eyeContraGainPct(i,2) = ((eyeContraGain(i,2) / eyeContraGain(1,2))-1) * 100;
            eyeIpsiGainPct(i,4) = ((eyeIpsiGain(i,4) / eyeIpsiGain(1,4))-1) * 100;
            eyeContraGainPct(i,4) = ((eyeContraGain(i,4) / eyeContraGain(1,4))-1) * 100;
        end
    elseif condition == 2
        for i = 1:numBlocksVisual
            eyeIpsiGain(i,2) = eyeIpsiBlockAmp(i,2) / drumIpsiBlockAmp(i,1);
            eyeContraGain(i,2) = abs(eyeContraBlockAmp(i,2)) / abs(drumContraBlockAmp(i,1));
            eyeIpsiGain(i,4) = eyeIpsiSineBlockAmp(i,2) / drumIpsiSineBlockAmp(i,1);
            eyeContraGain(i,4) = abs(eyeContraSineBlockAmp(i,2)) / abs(drumContraSineBlockAmp(i,1));
        end
        for i = 1:numBlocksVisual
            eyeIpsiGainPct(i,2) = ((eyeIpsiGain(i,2) / eyeIpsiGain(1,2))-1) * 100;
            eyeContraGainPct(i,2) = ((eyeContraGain(i,2) / eyeContraGain(1,2))-1) * 100;
            eyeIpsiGainPct(i,4) = ((eyeIpsiGain(i,4) / eyeIpsiGain(1,4))-1) * 100;
            eyeContraGainPct(i,4) = ((eyeContraGain(i,4) / eyeContraGain(1,4))-1) * 100;
        end
    end

    if eyeGainPlots == 1
        figure('Name','Eye gain')
        subplot(2,1,1); hold on
        plot(eyeIpsiGainPct(:,1),'-s')
        plot(eyeContraGainPct(:,1),'-s')
        plot(eyeIpsiGainPct(:,3),'-s')
        plot(eyeContraGainPct(:,3),'-s')
        title('Vestibular-dark')
        ylabel('% \Delta eye vel.')
        xticks(1:7)
        xticklabels(["Pre" 5 10 15 20 25 "Post"])
        xlabel('Time (min.)')
        legend('Ipsi eye','Contra eye','Ipsi eye sines-fitted','Contra eye sines-fitted')

        subplot(2,1,2); hold on
        plot(eyeIpsiGainPct(:,2),'-s')
        plot(eyeContraGainPct(:,2),'-s')
        plot(eyeIpsiGainPct(:,4),'-s')
        plot(eyeContraGainPct(:,4),'-s')
        title('Visual')
        ylabel('% \Delta eye vel.')
        xticks(1:6)
        xticklabels(1:6)
        xlabel('Block number')
        
    end

%% Phase calculations
    eyeBlockRadians(:,1) = deg2rad(phaseBlockEyeDark);
    eyeRadians(1) = deg2rad(phaseEyeDark);
    eyeBlockRadians(1:numBlocksVisual,2) = deg2rad(phaseBlockEyeVisual);
    eyeRadians(2) = deg2rad(phaseEyeVisual);
    headBlockRadians(:,1) = deg2rad(phaseBlockHeadDark);
    headRadians(1) = deg2rad(phaseHeadDark);
    headBlockRadians(1:numBlocksVisual,2) = deg2rad(phaseBlockHeadVisual);
    headRadians(2) = deg2rad(phaseHeadVisual);
    rsBlockRadians(1:numBlocksVisual,1) = deg2rad(phaseBlockRS);
    rsRadians = deg2rad(phaseRS);

    eyePhaseReHeadDark = (phaseEyeDark - phaseHeadDark);
    eyePhaseReHeadDark = mod(eyePhaseReHeadDark,360) - 180;
    eyePhaseReHeadVisual = (phaseEyeVisual - phaseHeadVisual);
    eyePhaseReHeadVisual = mod(eyePhaseReHeadVisual,360) - 180;
    if condition == 0
        rsPhaseReEye = (phaseRS - phaseEyeVisual);
        rsPhaseReEye = mod(rsPhaseReEye,360) - 180;
        rsPhaseReHead = (phaseRS - phaseHeadVisual+180);
        rsPhaseReHead = mod(rsPhaseReHead,360) - 180;
    elseif condition == 1 || condition == 2
        rsPhaseReEye = (phaseRS - (phaseEyeVisual+180));
        rsPhaseReEye = mod(rsPhaseReEye,360) - 180;
        rsPhaseReHead = (phaseRS - phaseHeadVisual);
        rsPhaseReHead = mod(rsPhaseReHead,360) - 180;
    end

    if phasePlots == 1
        figure('Name','Polar plots')
        subplot(2,4,[1,4])
        b = polarscatter(eyeBlockRadians(:,1),eyeIpsiBlockAmp(:,1)); hold on
        b.MarkerEdgeColor = 'r';
        ba = polarscatter(eyeRadians(1),eyeIpsiAmpAvg(1),'filled');
        ba.MarkerFaceColor = 'k';
        c = polarscatter(headBlockRadians(:,1),headContraBlockAmp(:,1))
        c.MarkerEdgeColor = [0 0.4470 0.7410];
        ca = polarscatter(headRadians(1),headContraAmpAvg(1),'filled');
        ca.MarkerFaceColor = 'k';
        legend('Eye vel. phase (blocks)','','Head vel. phase (blocks)','Population Averages')
        title('Cycle average phases','Vestibular-dark')

        subplot(2,4,[5,8])
        if condition == 0
            b = polarscatter(eyeBlockRadians(1:numBlocksVisual,2),eyeIpsiBlockAmp(1:numBlocksVisual,2)); hold on
            b.MarkerEdgeColor = 'r';
            ba = polarscatter(eyeRadians(2),eyeIpsiAmpAvg(2),'filled');
            ba.MarkerFaceColor = 'k';
            c = polarscatter(headBlockRadians(1:numBlocksVisual,2),headContraBlockAmp(1:numBlocksVisual,2))
            c.MarkerEdgeColor = [0 0.4470 0.7410];
            ca = polarscatter(headRadians(2),headContraAmpAvg(2),'filled');
            ca.MarkerFaceColor = 'k';
        elseif condition == 1 
            b = polarscatter(eyeBlockRadians(1:numBlocksVisual,2),eyeContraBlockAmp(1:numBlocksVisual,2))
            b.MarkerEdgeColor = 'r';
            ba = polarscatter(eyeRadians(2),eyeContraAmpAvg(2),'filled');
            ba.MarkerFaceColor = 'k';
            c = polarscatter(headBlockRadians(1:numBlocksVisual,2),headIpsiBlockAmp(1:numBlocksVisual,2))
            c.MarkerEdgeColor = [0 0.4470 0.7410];
            ca = polarscatter(headRadians(2),headIpsiAmpAvg(2),'filled');
            ca.MarkerFaceColor = 'k';
        elseif condition == 2
            b = polarscatter(eyeBlockRadians(1:numBlocksVisual,2),eyeContraBlockAmp(:,2))
            b.MarkerEdgeColor = 'r';
            ba = polarscatter(eyeRadians(2),eyeContraAmpAvg(2),'filled');
            ba.MarkerFaceColor = 'k';
        end
        d = polarscatter(rsBlockRadians(1:numBlocksVisual,1),rsBlockAmp(:,1))
        d.MarkerEdgeColor = 'm';
        da = polarscatter(rsRadians(1),rsAmpAvg(1),'filled');
        da.MarkerFaceColor = 'k';
        legend('Eye vel. phase (blocks)','','Head vel. phase (blocks)','','Retinal slip phase (blocks)','Population Averages')
        title('Visual')
    end
end

%% sriramOKRmodAlex expt
if expSubType == 2
    [randSortReshape,conditionIdxs] = randBlockSort(dataRand,numBlocksVisual,numFreq,numTestPerFreq);
    %% Eye sorting for multiple frequency experiment
    blockVisualEye05 = cell(1,numTestPerFreq);
    blockVisualEye1 = cell(1,numTestPerFreq);
    blockVisualEye2 = cell(1,numTestPerFreq);
    blockVisualEye4 = cell(1,numTestPerFreq);
    blockVisualEye5 = cell(1,numTestPerFreq+1);
    blockVisualEye10 = cell(1,numTestPerFreq+1);
    visualEyeReshape05 = cell(1,numTestPerFreq);
    visualEyeReshape1 = cell(1,numTestPerFreq);
    visualEyeReshape2 = cell(1,numTestPerFreq);
    visualEyeReshape4 = cell(1,numTestPerFreq);
    visualEyeReshape5 = cell(1,numTestPerFreq+1);
    visualEyeReshape10 = cell(1,numTestPerFreq+1);
    visualEyeBlockAvg05 = cell(1,numTestPerFreq);
    visualEyeBlockAvg1 = cell(1,numTestPerFreq);
    visualEyeBlockAvg2 = cell(1,numTestPerFreq);
    visualEyeBlockAvg4 = cell(1,numTestPerFreq);
    visualEyeBlockAvg5 = cell(1,numTestPerFreq+1);
    visualEyeBlockAvg10 = cell(1,numTestPerFreq+1);

    blockVisualDrum05 = cell(1,numTestPerFreq);
    blockVisualDrum1 = cell(1,numTestPerFreq);
    blockVisualDrum2 = cell(1,numTestPerFreq);
    blockVisualDrum4 = cell(1,numTestPerFreq);
    blockVisualDrum5 = cell(1,numTestPerFreq+1);
    blockVisualDrum10 = cell(1,numTestPerFreq+1);
    visualDrumReshape05 = cell(1,numTestPerFreq);
    visualDrumReshape1 = cell(1,numTestPerFreq);
    visualDrumReshape2 = cell(1,numTestPerFreq);
    visualDrumReshape4 = cell(1,numTestPerFreq);
    visualDrumReshape5 = cell(1,numTestPerFreq+1);
    visualDrumReshape10 = cell(1,numTestPerFreq+1);
    visualDrumBlockAvg05 = cell(1,numTestPerFreq);
    visualDrumBlockAvg1 = cell(1,numTestPerFreq);
    visualDrumBlockAvg2 = cell(1,numTestPerFreq);
    visualDrumBlockAvg4 = cell(1,numTestPerFreq);
    visualDrumBlockAvg5 = cell(1,numTestPerFreq+1);
    visualDrumBlockAvg10 = cell(1,numTestPerFreq+1);

    blockVisual05 = cell(1,numTestPerFreq);
    blockVisual1 = cell(1,numTestPerFreq);
    blockVisual2 = cell(1,numTestPerFreq);
    blockVisual4 = cell(1,numTestPerFreq);
    blockVisual5 = cell(1,numTestPerFreq+1);
    blockVisual10 = cell(1,numTestPerFreq+1);
    visualReshape05 = cell(1,numTestPerFreq);
    visualReshape1 = cell(1,numTestPerFreq);
    visualReshape2 = cell(1,numTestPerFreq);
    visualReshape4 = cell(1,numTestPerFreq);
    visualReshape5 = cell(1,numTestPerFreq+1);
    visualReshape10 = cell(1,numTestPerFreq+1);
    visualBlockAvg05 = cell(1,numTestPerFreq);
    visualBlockAvg1 = cell(1,numTestPerFreq);
    visualBlockAvg2 = cell(1,numTestPerFreq);
    visualBlockAvg4 = cell(1,numTestPerFreq);
    visualBlockAvg5 = cell(1,numTestPerFreq+1);
    visualBlockAvg10 = cell(1,numTestPerFreq+1);

    for i = 1:numTestPerFreq
        blockVisualEye05{i} = [eyeVelFiltBlockTrunc{freq05(i)}];
        blockVisualEye1{i} = [eyeVelFiltBlockTrunc{freq1(i)}];
        blockVisualEye2{i} = [eyeVelFiltBlockTrunc{freq2(i)}];
        blockVisualEye4{i} = [eyeVelFiltBlockTrunc{freq4(i)}];
        blockVisualEye5{i} = [eyeVelFiltBlockTrunc{step5(i)}];
        blockVisualEye10{i} = [eyeVelFiltBlockTrunc{step10(i)}];
        blockVisualEye5{4} = [eyeVelFiltBlockTrunc{step5(4)}];
        blockVisualEye10{4} = [eyeSmoothBlockTrunc{step10(4)}];

        blockVisualDrum05{i} = [drumVelBlockTrunc{freq05(i)}];
        blockVisualDrum1{i} = [drumVelBlockTrunc{freq1(i)}];
        blockVisualDrum2{i} = [drumVelBlockTrunc{freq2(i)}];
        blockVisualDrum4{i} = [drumVelBlockTrunc{freq4(i)}];
        blockVisualDrum5{i} = [drumVelBlockTrunc{step5(i)}];
        blockVisualDrum10{i} = [drumVelBlockTrunc{step10(i)}];
        blockVisualDrum5{4} = [drumVelBlockTrunc{step5(4)}];
        blockVisualDrum10{4} = [drumVelBlockTrunc{step10(4)}];

        blockVisual05{i} = [calFiltBlockTrunc{freq05(i)}];
        blockVisual1{i} = [calFiltBlockTrunc{freq1(i)}];
        blockVisual2{i} = [calFiltBlockTrunc{freq2(i)}];
        blockVisual4{i} = [calFiltBlockTrunc{freq4(i)}];
        blockVisual5{i} = [calFiltBlockTrunc{step5(i)}];
        blockVisual10{i} = [calFiltBlockTrunc{step10(i)}];
        blockVisual5{4} = [calFiltBlockTrunc{step5(4)}];
        blockVisual10{4} = [calFiltBlockTrunc{step10(4)}];
        
        visualEyeReshape05{i} = reshape(blockVisualEye05{i},fr*2,numTimeVisual/2);
        visualEyeReshape1{i} = reshape(blockVisualEye1{i},fr,numTimeVisual);
        visualEyeReshape2{i} = reshape(blockVisualEye2{i},fr/2,numTimeVisual*2);
        visualEyeReshape4{i} = reshape(blockVisualEye4{i},fr/4,numTimeVisual*4);
        visualEyeReshape5{i} = reshape(blockVisualEye5{i},fr*2,numTimeVisual/2);
        visualEyeReshape10{i} = reshape(blockVisualEye10{i},fr*2,numTimeVisual/2);
        
        visualDrumReshape05{i} = reshape(blockVisualDrum05{i},fr*2,numTimeVisual/2);
        visualDrumReshape1{i} = reshape(blockVisualDrum1{i},fr,numTimeVisual);
        visualDrumReshape2{i} = reshape(blockVisualDrum2{i},fr/2,numTimeVisual*2);
        visualDrumReshape4{i} = reshape(blockVisualDrum4{i},fr/4,numTimeVisual*4);
        visualDrumReshape5{i} = reshape(blockVisualDrum5{i},fr*2,numTimeVisual/2);
        visualDrumReshape10{i} = reshape(blockVisualDrum10{i},fr*2,numTimeVisual/2);

        visualReshape05{i} = reshape(blockVisual05{i},fr*2,numTimeVisual/2);
        visualReshape1{i} = reshape(blockVisual1{i},fr,numTimeVisual);
        visualReshape2{i} = reshape(blockVisual2{i},fr/2,numTimeVisual*2);
        visualReshape4{i} = reshape(blockVisual4{i},fr/4,numTimeVisual*4);
        visualReshape5{i} = reshape(blockVisual5{i},fr*2,numTimeVisual/2);
        visualReshape10{i} = reshape(blockVisual10{i},fr*2,numTimeVisual/2);

        visualEyeBlockAvg05{i} = nanmean(visualEyeReshape05{i},2);
        visualEyeBlockAvg1{i} = nanmean(visualEyeReshape1{i},2);
        visualEyeBlockAvg2{i} = nanmean(visualEyeReshape2{i},2);
        visualEyeBlockAvg4{i} = nanmean(visualEyeReshape4{i},2);
        visualEyeBlockAvg5{i} = nanmean(visualEyeReshape5{i},2);
        visualEyeBlockAvg10{i} = nanmean(visualEyeReshape10{i},2);

        visualDrumBlockAvg05{i} = nanmean(visualDrumReshape05{i},2);
        visualDrumBlockAvg1{i} = nanmean(visualDrumReshape1{i},2);
        visualDrumBlockAvg2{i} = nanmean(visualDrumReshape2{i},2);
        visualDrumBlockAvg4{i} = nanmean(visualDrumReshape4{i},2);
        visualDrumBlockAvg5{i} = nanmean(visualDrumReshape5{i},2);
        visualDrumBlockAvg10{i} = nanmean(visualDrumReshape10{i},2);

        visualBlockAvg05{i} = nanmean(visualReshape05{i},2);
        visualBlockAvg1{i} = nanmean(visualReshape1{i},2);
        visualBlockAvg2{i} = nanmean(visualReshape2{i},2);
        visualBlockAvg4{i} = nanmean(visualReshape4{i},2);
        visualBlockAvg5{i} = nanmean(visualReshape5{i},2);
        visualBlockAvg10{i} = nanmean(visualReshape10{i},2);
    end

    visualEyeReshape05 = cat(2,visualEyeReshape05{:});
    visualEyeReshape1 = cat(2,visualEyeReshape1{:});
    visualEyeReshape2 = cat(2,visualEyeReshape2{:});
    visualEyeReshape4 = cat(2,visualEyeReshape4{:});
    visualEyeReshape5 = cat(2,visualEyeReshape5{:});
    visualEyeReshape10 = cat(2,visualEyeReshape10{:});
    eyeVelFiltBlockMat = cat(2,eyeVelFiltBlockMat{:});
    [madEye05,madEye1,madEye2,madEye4,madEye5,madEye10,madEye05vector,madEye1vector,madEye2vector,madEye4vector,madEye5vector,madEye10vector,madEyeSpVector] = madDesacFrequencies(numBlocksVisual,numBlocksGap,madMultiplier,madMultiplierVisual,madMultiplierSp,visualEyeReshape05,visualEyeReshape1,visualEyeReshape2,visualEyeReshape4,visualEyeReshape5,visualEyeReshape10,eyeVelFiltBlockMat,presac,postsac);
    
    visualEyeAvg05 = cat(2,visualEyeBlockAvg05{:});
    visualEyeAvg05 = mean(visualEyeAvg05,2);
    [visualEyeAmp05,visualEyeAmpIdx05] = min(visualEyeAvg05);
    visualEyeAvg1 = cat(2,visualEyeBlockAvg1{:});
    visualEyeAvg1 = mean(visualEyeAvg1,2);
    [visualEyeAmp1,visualEyeAmpIdx1] = min(visualEyeAvg1);
    visualEyeAvg2 = cat(2,visualEyeBlockAvg2{:});
    visualEyeAvg2 = mean(visualEyeAvg2,2);
    [visualEyeAmp2,visualEyeAmpIdx2] = min(visualEyeAvg2);
    visualEyeAvg4 = cat(2,visualEyeBlockAvg4{:});
    visualEyeAvg4 = mean(visualEyeAvg4,2);
    [visualEyeAmp4,visualEyeAmpIdx4] = min(visualEyeAvg4);
    visualEyeAvg5 = cat(2,visualEyeBlockAvg5{:});
    visualEyeAvg5 = mean(visualEyeAvg5,2);
    [visualEyeAmp5,visualEyeAmpIdx5] = min(visualEyeAvg5);
    visualEyeAvg10 = cat(2,visualEyeBlockAvg10{:});
    visualEyeAvg10 = mean(visualEyeAvg10,2);
    [visualEyeAmp10,visualEyeAmpIdx10] = min(visualEyeAvg10);
    
    madEye05avg = nanmean(madEye05,2);
    [madEyeAmp05,madEyeAmpIdx05] = min(madEye05avg);
    madEye1avg = nanmean(madEye1,2);
    [madEyeAmp1,madEyeAmpIdx1] = min(madEye1avg);
    madEye2avg = nanmean(madEye2,2);
    [madEyeAmp2,madEyeAmpIdx2] = min(madEye2avg);
    madEye4avg = nanmean(madEye4,2);
    [madEyeAmp4,madEyeAmpIdx4] = min(madEye4avg);
    madEye5avg = nanmean(madEye5,2);
    [madEyeAmp5,madEyeAmpIdx5] = min(madEye5avg);
    madEye10avg = nanmean(madEye10,2);
    [madEyeAmp10,madEyeAmpIdx10] = min(madEye10avg);

    visualDrumAvg05 = cat(2,visualDrumBlockAvg05{:});
    visualDrumAvg05 = mean(visualDrumAvg05,2);
    [visualDrumAmp05,visualDrumAmpIdx05] = min(visualDrumAvg05);
    visualDrumAvg1 = cat(2,visualDrumBlockAvg1{:});
    visualDrumAvg1 = mean(visualDrumAvg1,2);
    [visualDrumAmp1,visualDrumAmpIdx1] = min(visualDrumAvg1);
    visualDrumAvg2 = cat(2,visualDrumBlockAvg2{:});
    visualDrumAvg2 = mean(visualDrumAvg2,2);
    [visualDrumAmp2,visualDrumAmpIdx2] = min(visualDrumAvg2);
    visualDrumAvg4 = cat(2,visualDrumBlockAvg4{:});
    visualDrumAvg4 = mean(visualDrumAvg4,2);
    [visualDrumAmp4,visualDrumAmpIdx4] = min(visualDrumAvg4);
    visualDrumAvg5 = cat(2,visualDrumBlockAvg5{:});
    visualDrumAvg5 = mean(visualDrumAvg5,2);
    [visualDrumAmp5,visualDrumAmpIdx5] = min(visualDrumAvg5(1:350));
    visualDrumAvg10 = cat(2,visualDrumBlockAvg10{:});
    visualDrumAvg10 = mean(visualDrumAvg10,2);
    [visualDrumAmp10,visualDrumAmpIdx10] = min(visualDrumAvg10(1:350));

    rsAvg05 = visualDrumAvg05 - madEye05avg;
    [rsAmp05,rsAmpIdx05] = min(rsAvg05);
    rsAvg1 = visualDrumAvg1 - madEye1avg;
    [rsAmp1,rsAmpIdx1] = min(rsAvg1);
    rsAvg2 = visualDrumAvg2 - madEye2avg;
    [rsAmp2,rsAmpIdx2] = min(rsAvg2);
    rsAvg4 = visualDrumAvg4 - madEye4avg;
    [rsAmp4,rsAmpIdx4] = min(rsAvg4);
    rsAvg5 = visualDrumAvg5 - madEye5avg;
    [rsAmp5,rsAmpIdx5] = min(rsAvg5);
    rsAvg10 = visualDrumAvg10 - madEye10avg;
    [rsAmp10,rsAmpIdx10] = min(rsAvg10);

    visualAvg05 = cat(2,visualBlockAvg05{:});
    visualAvg05 = mean(visualAvg05,2);
    [visualAmp05,visualAmpIdx05] = max(visualAvg05);
    visualAvg1 = cat(2,visualBlockAvg1{:});
    visualAvg1 = mean(visualAvg1,2);
    [visualAmp1,visualAmpIdx1] = max(visualAvg1);
    visualAvg2 = cat(2,visualBlockAvg2{:});
    visualAvg2 = mean(visualAvg2,2);
    [visualAmp2,visualAmpIdx2] = max(visualAvg2);
    visualAvg4 = cat(2,visualBlockAvg4{:});
    visualAvg4 = mean(visualAvg4,2);
    [visualAmp4,visualAmpIdx4] = max(visualAvg4);
    visualAvg5 = cat(2,visualBlockAvg5{:});
    visualAvg5 = mean(visualAvg5,2);
    [visualAmp5,visualAmpIdx5] = max(visualAvg5);
    visualAvg10 = cat(2,visualBlockAvg10{:});
    visualAvg10 = mean(visualAvg10,2);
    [visualAmp10,visualAmpIdx10] = max(visualAvg10);

    calDelayEye05 = visualAmpIdx05 - visualEyeAmpIdx05;
    calDelayEye1 = visualAmpIdx1 - visualEyeAmpIdx1;
    calDelayEye2 = visualAmpIdx2 - visualEyeAmpIdx2;
    calDelayEye4 = visualAmpIdx4 - visualEyeAmpIdx4;
    calDelayEye5 = visualAmpIdx5 - visualEyeAmpIdx5;
    calDelayEye10 = visualAmpIdx10 - visualEyeAmpIdx10;

    calDelayDrum05 = visualAmpIdx05 - visualDrumAmpIdx05;
    calDelayDrum1 = visualAmpIdx1 - visualDrumAmpIdx1;
    calDelayDrum2 = visualAmpIdx2 - visualDrumAmpIdx2;
    calDelayDrum4 = visualAmpIdx4 - visualDrumAmpIdx4;
    calDelayDrum5 = visualAmpIdx5 - visualDrumAmpIdx5;
    calDelayDrum10 = visualAmpIdx10 - visualDrumAmpIdx10;

    calDelayRS05 = visualAmpIdx05 - rsAmpIdx05;
    calDelayRS1 = visualAmpIdx1 - rsAmpIdx1;
    calDelayRS2 = visualAmpIdx2 - rsAmpIdx2;
    calDelayRS4 = visualAmpIdx4 - rsAmpIdx4;
    calDelayRS5 = visualAmpIdx5 - rsAmpIdx5;
    calDelayRS10 = visualAmpIdx10 - rsAmpIdx10;

    %% 
    figure()
    t = tiledlayout(2,3)
    t.TileSpacing = 'compact';
    t.Padding = 'tight';
    nexttile; hold on
    for i = 1:3
        plot(visualBlockAvg05{i}*100)
    end
    plot(visualAvg05*100,'k','LineWidth',2)
    ylabel('% \DeltaF/G')
    title('0.5 Hz')
    nexttile; hold on
    for i = 1:3
        plot(visualBlockAvg1{i}*100)
    end
    plot(visualAvg1*100,'k','LineWidth',2)
    title('1 Hz')
    nexttile; hold on
    for i = 1:3
        plot(visualBlockAvg2{i}*100)
    end
    plot(visualAvg2*100,'k','LineWidth',2)
    title('2 Hz')
    nexttile; hold on
    for i = 1:3
        plot(visualBlockAvg4{i}*100)
    end
    plot(visualAvg4*100,'k','LineWidth',2)
    ylabel('% \DeltaF/G')
    xlabel('Time (ms)')
    title('4 Hz')
    nexttile; hold on
    for i = 1:3
        plot(visualBlockAvg5{i}*100)
    end
    plot(visualAvg5*100,'k','LineWidth',2)
    xlabel('Time (ms)')
    title('Step 5 ^{\circ}/s')
    nexttile; hold on
    for i = 1:3
        plot(visualBlockAvg10{i}*100)
    end
    plot(visualAvg10*100,'k','LineWidth',2)
    xlabel('Time (ms)')
    title('Step 10 ^{\circ}/s')

    %% 
    figure()
    t = tiledlayout(2,3)
    t.TileSpacing = 'compact';
    t.Padding = 'tight';
    nexttile; hold on
    for i = 1:3
        plot(visualEyeBlockAvg05{i})
    end
    plot(visualEyeAvg05,'k','LineWidth',2)
    ylabel('% \DeltaF/G')
    title('0.5 Hz')
    nexttile; hold on
    for i = 1:3
        plot(visualEyeBlockAvg1{i})
    end
    plot(visualEyeAvg1,'k','LineWidth',2)
    title('1 Hz')
    nexttile; hold on
    for i = 1:3
        plot(visualEyeBlockAvg2{i})
    end
    plot(visualEyeAvg2,'k','LineWidth',2)
    title('2 Hz')
    nexttile; hold on
    for i = 1:3
        plot(visualEyeBlockAvg4{i})
    end
    plot(visualEyeAvg4,'k','LineWidth',2)
    ylabel('% \DeltaF/G')
    xlabel('Time (ms)')
    title('4 Hz')
    nexttile; hold on
    for i = 1:3
        plot(visualEyeBlockAvg5{i})
    end
    plot(visualEyeAvg5,'k','LineWidth',2)
    xlabel('Time (ms)')
    title('Step 5 ^{\circ}/s')
    nexttile; hold on
    for i = 1:3
        plot(visualEyeBlockAvg10{i})
    end
    plot(visualEyeAvg10,'k','LineWidth',2)
    xlabel('Time (ms)')
    title('Step 10 ^{\circ}/s')

    %% 
    figure();
    t = tiledlayout(2,3)
    t.TileSpacing = 'compact';
    t.Padding = 'tight';
    nexttile; hold on
    plot(visualEyeAvg05)
    plot(visualDrumAvg05)
    plot(rsAvg05)
    ylabel('% \DeltaF/G')
    title('0.5 Hz')

    nexttile; hold on
    plot(visualEyeAvg1)
    plot(visualDrumAvg1)
    plot(rsAvg1)
    ylabel('% \DeltaF/G')
    title('1 Hz')

    nexttile; hold on
    plot(visualEyeAvg2)
    plot(visualDrumAvg2)
    plot(rsAvg2)
    ylabel('% \DeltaF/G')
    title('2 Hz')

    nexttile; hold on
    plot(visualEyeAvg4)
    plot(visualDrumAvg4)
    plot(rsAvg4)
    ylabel('% \DeltaF/G')
    title('4 Hz')

    nexttile; hold on
    plot(visualEyeAvg5)
    plot(visualDrumAvg5)
    plot(rsAvg5)
    ylabel('% \DeltaF/G')
    title('5{\circ}/s')

    nexttile; hold on
    plot(visualEyeAvg10)
    plot(visualDrumAvg10)
    plot(rsAvg10)
    ylabel('% \DeltaF/G')
    title('10{\circ}/s')
    
    %% 
    visual05sine = cell(1,numTestPerFreq);
    visual1sine = cell(1,numTestPerFreq);
    visual2sine = cell(1,numTestPerFreq);
    visual4sine = cell(1,numTestPerFreq);
    segLength05 = length(visualBlockAvg05{1});
    segLength1 = length(visualBlockAvg1{1});
    segLength2 = length(visualBlockAvg2{1});
    segLength4 = length(visualBlockAvg1{1});
    segTime05 = (1:segLength05)/(fr/2);
    segTime1 = (1:segLength1)/(fr);
    segTime2 = (1:segLength2)/(fr*2);
    segTime4 = (1:segLength4)/(fr);
    y1freq05 = sin(2*pi*(frequency/2)*segTime05(:));
    y2freq05 = cos(2*pi*(frequency/2)*segTime05(:));
    y1freq1 = sin(2*pi*(frequency)*segTime1(:));
    y2freq1 = cos(2*pi*(frequency)*segTime1(:));
    y1freq2 = sin(2*pi*(frequency*2)*segTime2(:));
    y2freq2 = cos(2*pi*(frequency*2)*segTime2(:));
    y1freq4 = sin(2*pi*(frequency*4)*segTime4(:));
    y2freq4 = cos(2*pi*(frequency*4)*segTime4(:));
    constant05 = ones(segLength05,1);
    constant1 = ones(segLength1,1);
    constant2 = ones(segLength2,1);
    constant4 = ones(segLength4,1);
    vars05 = [y1freq05 y2freq05 constant05];
    vars1 = [y1freq1 y2freq1 constant1];
    vars2 = [y1freq2 y2freq2 constant2];
    vars4 = [y1freq4 y2freq4 constant4];
    keepItVisual05 = cell(1,numTestPerFreq);
    keepItVisual1 = cell(1,numTestPerFreq);
    keepItVisual2 = cell(1,numTestPerFreq);
    keepItVisual4 = cell(1,numTestPerFreq);
    bVisual05 = cell(1,numTestPerFreq);
    bVisual1 = cell(1,numTestPerFreq);
    bVisual2 = cell(1,numTestPerFreq);
    bVisual4 = cell(1,numTestPerFreq);
    ampVisual05 = cell(1,numTestPerFreq);
    ampVisual1 = cell(1,numTestPerFreq);
    ampVisual2 = cell(1,numTestPerFreq);
    ampVisual4 = cell(1,numTestPerFreq);
    phaseVisual05 = cell(1,numTestPerFreq);
    phaseVisual1 = cell(1,numTestPerFreq);
    phaseVisual2 = cell(1,numTestPerFreq);
    phaseVisual4 = cell(1,numTestPerFreq);
    visual05sineAmp = cell(1,numTestPerFreq);
    visual05sineAmpIdx = cell(1,numTestPerFreq);
    visual1sineAmp = cell(1,numTestPerFreq);
    visual1sineAmpIdx = cell(1,numTestPerFreq);
    visual2sineAmp = cell(1,numTestPerFreq);
    visual2sineAmpIdx = cell(1,numTestPerFreq);
    visual4sineAmp = cell(1,numTestPerFreq);
    visual4sineAmpIdx = cell(1,numTestPerFreq);
    for i = 1:numTestPerFreq
        keepItVisual05{i} = abs(visualBlockAvg05{i}) < 5*nanstd(abs(visualBlockAvg05{i})) + nanmean(abs(visualBlockAvg05{i}));
        keepItVisual1{i} = abs(visualBlockAvg1{i}) < 5*nanstd(abs(visualBlockAvg1{i})) + nanmean(abs(visualBlockAvg1{i}));
        keepItVisual2{i} = abs(visualBlockAvg2{i}) < 5*nanstd(abs(visualBlockAvg2{i})) + nanmean(abs(visualBlockAvg2{i}));
        keepItVisual4{i} = abs(visualBlockAvg4{i}) < 5*nanstd(abs(visualBlockAvg4{i})) + nanmean(abs(visualBlockAvg4{i}));
        bVisual05{i} = regress(visualBlockAvg05{i}(keepItVisual05{i}),vars05(keepItVisual05{i},:));
        bVisual1{i} = regress(visualBlockAvg1{i}(keepItVisual1{i}),vars1(keepItVisual1{i},:));
        bVisual2{i} = regress(visualBlockAvg2{i}(keepItVisual2{i}),vars2(keepItVisual2{i},:));
        bVisual4{i} = regress(visualBlockAvg4{i}(keepItVisual4{i}),vars4(keepItVisual4{i},:));
        ampVisual05{i} = sqrt(bVisual05{i}(1)^2+bVisual05{i}(2)^2);
        ampVisual1{i} = sqrt(bVisual1{i}(1)^2+bVisual1{i}(2)^2);
        ampVisual2{i} = sqrt(bVisual2{i}(1)^2+bVisual2{i}(2)^2);
        ampVisual4{i} = sqrt(bVisual4{i}(1)^2+bVisual4{i}(2)^2);
        phaseVisual05{i} = rad2deg(atan2(bVisual05{i}(2), bVisual05{i}(1)));
        phaseVisual1{i} = rad2deg(atan2(bVisual1{i}(2), bVisual1{i}(1)));
        phaseVisual2{i} = rad2deg(atan2(bVisual2{i}(2), bVisual2{i}(1)));
        phaseVisual4{i} = rad2deg(atan2(bVisual4{i}(2), bVisual4{i}(1)));
        visual05sine{i} = (sin(2*pi*(frequency/4)*segTime05 + deg2rad(phaseVisual05{i}))*ampVisual05{i});
        visual1sine{i} = (sin(2*pi*frequency*segTime1 + deg2rad(phaseVisual1{i}))*ampVisual1{i});
        visual2sine{i} = (sin(2*pi*(frequency*4)*segTime2 + deg2rad(phaseVisual2{i}))*ampVisual2{i});
        visual4sine{i} = (sin(2*pi*(frequency*16)*segTime4 + deg2rad(phaseVisual4{i}))*ampVisual4{i});
        [visual05sineAmp{i},visual05sineAmpIdx{i}] = max(visual05sine{i});
        [visual1sineAmp{i},visual1sineAmpIdx{i}] = max(visual1sine{i});
        [visual2sineAmp{i},visual2sineAmpIdx{i}] = max(visual2sine{i});
        [visual4sineAmp{i},visual4sineAmpIdx{i}] = max(visual4sine{i});
    end
    
    figure()
    for i = 1:3
        plot(visual05sine{i})
        hold on
    end
    
    figure(); hold on
    for i = 1:3
        plot(visual1sine{i})
    end
    
    figure(); hold on
    for i = 1:3
        plot(visual2sine{i})
    end
    
    figure(); hold on
    for i = 1:3
        plot(visual4sine{i})
    end
end

%% 
if expSubType ~= 3
    if protocol ~= 2
        eyeBlockSineDarkMat = cell2mat(eyeDarkBlockSine)';
        eyeBlockSineVisualMat = cell2mat(eyeVisualBlockSine)';
        eyePrePost = NaN(fr*(1/frequency),8);
        eyePrePost(:,1) = mean(eyeDarkBlockAvg(:,numBlocksDark-3:numBlocksDark-1),2) - mean(eyeDarkBlockAvg(:,1:3),2);
        eyePrePost(:,2) = eyeVisualBlockAvg(:,numBlocksVisual) - eyeVisualBlockAvg(:,1);
        eyePrePost(:,3) = mean(eyeBlockSineDarkMat(:,numBlocksDark-3:numBlocksDark-1),2) - mean(eyeBlockSineDarkMat(:,1:3),2);
        eyePrePost(:,4) = eyeBlockSineVisualMat(:,numBlocksVisual) - eyeBlockSineVisualMat(:,1);
        eyePrePost(1,5) = mean(eyeIpsiBlockAmp(numBlocksDark-3:numBlocksDark-1)) - mean(eyeIpsiBlockAmp(1:3));
        eyePrePost(2,5) = mean(eyeIpsiBlockAmpIdx(numBlocksDark-3:numBlocksDark-1)) - mean(eyeIpsiBlockAmpIdx(1:3));
        eyePrePost(1,6) = mean(eyeIpsiSineBlockAmp(numBlocksDark-3:numBlocksDark-1)) - mean(eyeIpsiSineBlockAmp(1:3));
        eyePrePost(2,6) = mean(eyeIpsiSineBlockAmpIdx(numBlocksDark-3:numBlocksDark-1)) - mean(eyeIpsiSineBlockAmpIdx(1:3));
        eyePrePost(1,7) = eyeIpsiBlockAmp(numBlocksVisual,2) - eyeIpsiBlockAmp(1,2);
        eyePrePost(2,7) = eyeIpsiBlockAmpIdx(numBlocksVisual,2) - eyeIpsiBlockAmpIdx(1,2);
        eyePrePost(1,8) = eyeIpsiSineBlockAmp(numBlocksVisual,2) - eyeIpsiSineBlockAmp(1,2);
        eyePrePost(2,8) = eyeIpsiSineBlockAmpIdx(numBlocksVisual,2) - eyeIpsiSineBlockAmpIdx(1,2);
        eyePrePost(3,5) = mean(eyeContraBlockAmp(numBlocksDark-3:numBlocksDark-1)) - mean(eyeContraBlockAmp(1:3));
        eyePrePost(4,5) = mean(eyeContraBlockAmpIdx(numBlocksDark-3:numBlocksDark-1)) - mean(eyeContraBlockAmpIdx(1:3));
        eyePrePost(3,6) = mean(eyeContraSineBlockAmp(numBlocksDark-3:numBlocksDark-1)) - mean(eyeContraSineBlockAmp(1:3));
        eyePrePost(4,6) = mean(eyeContraSineBlockAmpIdx(numBlocksDark-3:numBlocksDark-1)) - mean(eyeContraSineBlockAmpIdx(1:3));
        eyePrePost(3,7) = eyeContraBlockAmp(numBlocksVisual,2) - eyeContraBlockAmp(1,2);
        eyePrePost(4,7) = eyeContraBlockAmpIdx(numBlocksVisual,2) - eyeContraBlockAmpIdx(1,2);
        eyePrePost(3,8) = eyeContraSineBlockAmp(numBlocksVisual,2) - eyeContraSineBlockAmp(1,2);
        eyePrePost(4,8) = eyeContraSineBlockAmpIdx(numBlocksVisual,2) - eyeContraSineBlockAmpIdx(1,2);

        rsBlockSineVisualMat = cell2mat(rsBlockSine)';
        rsPrePost = NaN(fr*(1/frequency),12);
        rsPrePost(:,1) = rsVisualBlockAvg(:,numBlocksVisual) - rsVisualBlockAvg(:,1);
        rsPrePost(:,2) = rsBlockSineVisualMat(:,numBlocksVisual) - rsBlockSineVisualMat(:,1);
        rsPrePost(1,3) = rsBlockAmp(numBlocksVisual) - rsBlockAmp(1);
        rsPrePost(2,3) = rsBlockAmpIdx(numBlocksVisual) - rsBlockAmpIdx(1);
        rsPrePost(1,4) = rsSineBlockAmp(numBlocksVisual) - rsSineBlockAmp(1);
        rsPrePost(2,4) = rsSineBlockAmpIdx(numBlocksVisual) - rsSineBlockAmpIdx(1);

        eyePrePost = NaN(fr*(1/frequency),4);
        eyePrePost(:,1) = mean(eyeDarkBlockAvg(:,1:3),2);
        eyePrePost(:,2) = mean(eyeDarkBlockAvg(:,numBlocksDark-3:numBlocksDark-1),2);
        eyePrePost(:,3) = mean(eyeBlockSineDarkMat(:,1:3),2);
        eyePrePost(:,4) = mean(eyeBlockSineDarkMat(:,numBlocksDark-3:numBlocksDark-1),2);
        eyePrePost(:,5) = eyeVisualBlockAvg(:,1);
        eyePrePost(:,6) = eyeVisualBlockAvg(:,numBlocksVisual);
        eyePrePost(:,7) = eyeBlockSineVisualMat(:,1);
        eyePrePost(:,8) = eyeBlockSineVisualMat(:,numBlocksVisual);
    elseif protocol == 2
        eyeBlockSineDarkMat = cell2mat(eyeDarkBlockSine)';
        eyeBlockSineVisualMat = cell2mat(eyeVisualBlockSine)';
        eyePrePost = NaN(fr*(1/frequency),8);
        eyePrePost(:,1) = eyeDarkBlockAvg(:,2) - eyeDarkBlockAvg(:,1);
        eyePrePost(:,2) = eyeVisualBlockAvg(:,numBlocksVisual) - eyeVisualBlockAvg(:,1);
        eyePrePost(:,3) = eyeBlockSineDarkMat(:,2) - eyeBlockSineDarkMat(:,1);
        eyePrePost(:,4) = eyeBlockSineVisualMat(:,numBlocksVisual) - eyeBlockSineVisualMat(:,1);
        eyePrePost(1,5) = eyeIpsiBlockAmp(2) - eyeIpsiBlockAmp(1);
        eyePrePost(2,5) = eyeIpsiBlockAmpIdx(2) - eyeIpsiBlockAmpIdx(1);
        eyePrePost(1,6) = eyeIpsiSineBlockAmp(2) - eyeIpsiSineBlockAmp(1);
        eyePrePost(2,6) = eyeIpsiSineBlockAmpIdx(2) - eyeIpsiSineBlockAmpIdx(1);
        eyePrePost(1,7) = eyeIpsiBlockAmp(numBlocksVisual,2) - eyeIpsiBlockAmp(1,2);
        eyePrePost(2,7) = eyeIpsiBlockAmpIdx(numBlocksVisual,2) - eyeIpsiBlockAmpIdx(1,2);
        eyePrePost(1,8) = eyeIpsiSineBlockAmp(numBlocksVisual,2) - eyeIpsiSineBlockAmp(1,2);
        eyePrePost(2,8) = eyeIpsiSineBlockAmpIdx(numBlocksVisual,2) - eyeIpsiSineBlockAmpIdx(1,2);
        eyePrePost(3,5) = eyeContraBlockAmp(2) - eyeContraBlockAmp(1);
        eyePrePost(4,5) = eyeContraBlockAmpIdx(2) - eyeContraBlockAmpIdx(1);
        eyePrePost(3,6) = eyeContraSineBlockAmp(2) - eyeContraSineBlockAmp(1);
        eyePrePost(4,6) = eyeContraSineBlockAmpIdx(2) - eyeContraSineBlockAmpIdx(1);
        eyePrePost(3,7) = eyeContraBlockAmp(numBlocksVisual,2) - eyeContraBlockAmp(1,2);
        eyePrePost(4,7) = eyeContraBlockAmpIdx(numBlocksVisual,2) - eyeContraBlockAmpIdx(1,2);
        eyePrePost(3,8) = eyeContraSineBlockAmp(numBlocksVisual,2) - eyeContraSineBlockAmp(1,2);
        eyePrePost(4,8) = eyeContraSineBlockAmpIdx(numBlocksVisual,2) - eyeContraSineBlockAmpIdx(1,2);

        rsBlockSineVisualMat = cell2mat(rsBlockSine)';
        rsPrePost = NaN(fr*(1/frequency),12);
        rsPrePost(:,1) = rsVisualBlockAvg(:,numBlocksVisual) - rsVisualBlockAvg(:,1);
        rsPrePost(:,2) = rsBlockSineVisualMat(:,numBlocksVisual) - rsBlockSineVisualMat(:,1);
        rsPrePost(1,3) = rsBlockAmp(numBlocksVisual) - rsBlockAmp(1);
        rsPrePost(2,3) = rsBlockAmpIdx(numBlocksVisual) - rsBlockAmpIdx(1);
        rsPrePost(1,4) = rsSineBlockAmp(numBlocksVisual) - rsSineBlockAmp(1);
        rsPrePost(2,4) = rsSineBlockAmpIdx(numBlocksVisual) - rsSineBlockAmpIdx(1);

        eyePrePost = NaN(fr*(1/frequency),4);
        eyePrePost(:,1) = eyeDarkBlockAvg(:,1);
        eyePrePost(:,2) = eyeDarkBlockAvg(:,2);
        eyePrePost(:,3) = eyeBlockSineDarkMat(:,1);
        eyePrePost(:,4) = eyeBlockSineDarkMat(:,2);
        eyePrePost(:,5) = eyeVisualBlockAvg(:,1);
        eyePrePost(:,6) = eyeVisualBlockAvg(:,numBlocksVisual);
        eyePrePost(:,7) = eyeBlockSineVisualMat(:,1);
        eyePrePost(:,8) = eyeBlockSineVisualMat(:,numBlocksVisual);
    end
    
    if prePostPlots == 1
        figure('Name','Post - pre'); hold on
        subplot(2,2,1); hold on
        shade((1:length(eyePrePost)),eyePrePost(:,1),(1:length(eyePrePost)),eyePrePost(:,2),'FillType',[1 2;2 1]);
        k1 = plot(eyePrePost(:,1),'Color','k','LineWidth',1);
        k2 = plot(eyePrePost(:,2),'Color','r','LineWidth',1);
        ylabel('Velocity')
        legend([k1(1), k2(1)], 'Pre eye vel.','Post eye vel.')
        title('Vestibular-dark (unfitted)')

        subplot(2,2,2); hold on
        shade((1:length(eyePrePost)),eyePrePost(:,5),(1:length(eyePrePost)),eyePrePost(:,6),'FillType',[1 2;2 1]);
        h1 = plot(eyePrePost(:,5),'Color','k','LineWidth',1);
        h2 = plot(eyePrePost(:,6),'Color','r','LineWidth',1);
        ylabel('Velocity')
        legend([h1(1), h2(1)], 'Pre eye vel.','Post eye vel.')
        title('Visual (unfitted)')

        subplot(2,2,3); hold on
        shade((1:length(eyePrePost)),eyePrePost(:,3),(1:length(eyePrePost)),eyePrePost(:,4),'FillType',[1 2;2 1]);
        k1 = plot(eyePrePost(:,3),'Color','k','LineWidth',1);
        k2 = plot(eyePrePost(:,4),'Color','r','LineWidth',1);
        xlabel('Time (ms)')
        ylabel('Velocity')
        legend([k1(1), k2(1)], 'Pre eye vel.','Post eye vel.')
        title('Vestibular-dark (unfitted)')

        subplot(2,2,4); hold on
        shade((1:length(eyePrePost)),eyePrePost(:,7),(1:length(eyePrePost)),eyePrePost(:,8),'FillType',[1 2;2 1]);
        h1 = plot(eyePrePost(:,7),'Color','k','LineWidth',1);
        h2 = plot(eyePrePost(:,8),'Color','r','LineWidth',1);
        xlabel('Time (ms)')
        ylabel('Velocity')
        legend([h1(1), h2(1)], 'Pre eye vel.','Post eye vel.')
        title('Visual (unfitted)')
    end
end