%% Reorganizing stimuli and neural data into blocks and grouping according to test condition
desacMethod = 1;                %set to 0 for cluster desaccading or 1 for MAD desaccading
sinesFitting = 0;               %set to 0 for sines-fitting or 1 to skip sines-fitting
minDataLength = 250;            %set minimum data length for removal of data that is not continuous for minimum amount of samples
goodCycMin = 2;                 %minimum number of cycles per block needed to add block to cycle-average
nextCycleTime = 0;              %time threshold for averaged time that falls outside of the current cycle (typically 250-300)
expSubType = 0;                 %set to 0 for default analysis, 1 for alternating x2x0 protocol analyses, 2 for multiple frequency protocol, 3 for VORD acute experiments, 4 for OKR acute experiments, or 5 for VORD training experiments
desacCalcium = 0;               %apply desaccading of calcium
numConditions = 3;              %number of different conditions to do separate analysis on
thresh = 0.002;                 %threshold for cluster saccade threshold (typically between 0.001-1)
movingMean = 50;                %smoothing of eye data, which turns more "neighbor" points into saccades for cluster desaccading (typically between 10-150)
madMultiplier = 3;              %multiplier for upper and lower threshold bounds for visual segments
madMultiplierD = 3;             %vestibular-dark segments
madMultiplierSp = 3;            %gap segments
madMultiplierCalcium = 6;       %calcium data
sacLength = 500;
neighborThresh = 200;
isUsingSaccades = false;

eyeArtifactPlotting = 0;
minDataCheck = 1;
cycAvgPlotting = 1;
sinesFitPlots = 1;
eyeGainPlots = 1;
phasePlots = 1;
calciumNorm = 1;
prePostPlots = 1;

if expSubType == 2
    randFileName = uigetfile('*.txt');
    randFile = fopen(randFileName);                                 %filename for multiple frequencies experiment
    dataRand = textscan(randFile,'%s','delimiter','\n');
    randBlockStr = str2double(strsplit(dataRand{1}{1},','));
    numFreq = numel(unique(randBlockStr))-3;                    %for sriramOKRtestModAlex, the number of different test frequencies
    numTestPerFreq = round(numel(randBlockStr)/(numFreq+3));    %for sriramOKRtestModAlex, the total number of sine frequency tests
end

if expSubType ~= 3
    numBlocksVisual = numel(endVisual);             %total number of segments per visual test condition (x2, x0, okr)
else
    numBlocksVisual = numel(endVisual);
end
numBlocksDark = numel(endDark);                 %total number of segments per VORD test condition
numBlocksGap = numel(endGap);                   %total number of segments per gaps


if protocol == 4
    protocol = 0;
end

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
    numTimeVisual = round((endVisual(1)/1000)-(startVisual(1)/1000));
    numTimeGap = round((endGap(2)/1000)-(startGap(2)/1000));
    numTimeDark = round((endDark(1)/1000)-(startDark(1)/1000));
elseif condition == 4
    numTimeVisual = round((endVisual(1)/1000)-(startVisual(1)/1000));           %number of seconds for each testing condition for reshaping purposes (visual period)
    numTimeGap = round((endGap(2)/1000)-(startGap(2)/1000));                    %gap period
    numTimeDark = round((endDark(1)/1000)-(startDark(1)/1000));   
end

%% Determine condition with largest number of segments
if numBlocksVisual >= numBlocksDark && numBlocksVisual >= numBlocksGap
    numBlocksMax = numBlocksVisual;
elseif numBlocksDark >= numBlocksVisual && numBlocksDark >= numBlocksGap
    numBlocksMax = numBlocksDark;
else
    numBlocksMax = numBlocksGap;
end

%% Create cell arrays for each variable of interest
calFiltBlock = cell(numBlocksMax,numConditions);
calFiltBlockTrunc = cell(numBlocksMax,numConditions);
calFiltBlockMat = cell(numBlocksMax,numConditions);
calciumRawBlock = cell(numBlocksMax,numConditions); 
calciumRawBlockTrunc = cell(numBlocksMax,numConditions); 
calciumRawBlockMat = cell(numBlocksMax,numConditions);
eyeRawBlock = cell(numBlocksMax,numConditions);
eyeRawBlockTrunc = cell(numBlocksMax,numConditions);
eyeRawBlockMat = cell(numBlocksMax,numConditions);
eyeVelFiltBlock = cell(numBlocksMax,numConditions);
eyeVelFiltBlockTrunc = cell(numBlocksMax,numConditions);
eyeVelFiltBlockMat = cell(numBlocksMax,numConditions);
eyeSmoothBlock = cell(numBlocksMax,numConditions);
eyeSmoothBlockTrunc = cell(numBlocksMax,numConditions);
eyeSmoothBlockMat = cell(numBlocksMax,numConditions);
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
fBlock = cell(numBlocksMax,numConditions);
fBlockTrunc = cell(numBlocksMax,numConditions);
fBlockMat = cell(numBlocksMax,numConditions);
f0block = cell(numBlocksMax,numConditions);
f0blockTrunc = cell(numBlocksMax,numConditions);
f0blockMat = cell(numBlocksMax,numConditions);
gBlock = cell(numBlocksMax,numConditions);
gBlockTrunc = cell(numBlocksMax,numConditions);
gBlockMat = cell(numBlocksMax,numConditions);

%% Splits data into blocks and with respect to test conditions
keep = numTimeDark * fr;                   %number for what the actual segment length should be per condition, removes extraneous data points
keepL = numTimeVisual * fr;                %for visual blocks
keepSp = numTimeGap * fr;                  %for gap blocks

%dark test segmenting
if numBlocksDark > 0
    nthTime = 1;
    visualRef = 0;
    for i = 1:numBlocksDark
        [calFiltBlock{i},calFiltBlockTrunc{i},calFiltBlockMat{i}] = segmenting(calcium_upsampled,startDark,startGap,endDark,nthTime,fr,frequency,numTimeDark,keep,visualRef);
        [calciumRawBlock{i},calciumRawBlockTrunc{i},calciumRawBlockMat{i}] = segmenting(calciumRaw,startDark,startGap,endDark,nthTime,fr,frequency,numTimeDark,keep,visualRef);
        [eyeRawBlock{i},eyeRawBlockTrunc{i},eyeRawBlockMat{i}] = segmenting(eyeVelRawTrunc,startDark,startGap,endDark,nthTime,fr,frequency,numTimeDark,keep,visualRef);
        [eyeSmoothBlock{i},eyeSmoothBlockTrunc{i},eyeSmoothBlockMat{i}] = segmenting(eyeSmoothTrunc,startDark,startGap,endDark,nthTime,fr,frequency,numTimeDark,keep,visualRef);
        [eyeVelFiltBlock{i},eyeVelFiltBlockTrunc{i},eyeVelFiltBlockMat{i}] = segmenting(eyeVelFiltTrunc,startDark,startGap,endDark,nthTime,fr,frequency,numTimeDark,keep,visualRef);
        [eyeAccRawBlock{i},eyeAccRawBlockTrunc{i},eyeAccRawBlockMat{i}] = segmenting(eyeAccRawTrunc,startDark,startGap,endDark,nthTime,fr,frequency,numTimeDark,keep,visualRef);
        [eyePrawBlock{i},eyePrawBlockTrunc{i},eyePrawBlockMat{i}] = segmenting(eyePtrunc,startDark,startGap,endDark,nthTime,fr,frequency,numTimeDark,keep,visualRef);
        [eyePfiltBlock{i},eyePfiltBlockTrunc{i},eyePfiltBlockMat{i}] = segmenting(eyePfiltTrunc,startDark,startGap,endDark,nthTime,fr,frequency,numTimeDark,keep,visualRef);
        [eyeSacsBlock{i},eyeSacsBlockTrunc{i},eyeSacsBlockMat{i}] = segmenting(eyeSacsTrunc,startDark,startGap,endDark,nthTime,fr,frequency,numTimeDark,keep,visualRef);
        [turntableBlock{i},turntableBlockTrunc{i},turntableBlockMat{i}] = segmenting(chVtrunc,startDark,startGap,endDark,nthTime,fr,frequency,numTimeDark,keep,visualRef);
        [turntablePblock{i},turntablePblockTrunc{i},turntablePblockMat{i}] = segmenting(chPtrunc,startDark,startGap,endDark,nthTime,fr,frequency,numTimeDark,keep,visualRef);
        [fBlock{i},fBlockTrunc{i},fBlockMat{i}] = segmenting(Fupsamp,startDark,startGap,endDark,nthTime,fr,frequency,numTimeDark,keep,visualRef);
        [f0block{i},f0blockTrunc{i},f0blockMat{i}] = segmenting(f0upsamp,startDark,startGap,endDark,nthTime,fr,frequency,numTimeDark,keep,visualRef);
        [gBlock{i},gBlockTrunc{i},gBlockMat{i}] = segmenting(Gupsamp,startDark,startGap,endDark,nthTime,fr,frequency,numTimeDark,keep,visualRef);
        nthTime = nthTime + 1;
    end
end

%visual test segmenting
if numBlocksVisual > 0 && protocol ~= 3 && condition ~= 3
    nthTime = 1;
    visualRef = 1;
    for i = 1:numBlocksVisual
        [calFiltBlock{i,2},calFiltBlockTrunc{i,2},calFiltBlockMat{i,2}] = segmenting(calcium_upsampled,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [calciumRawBlock{i,2},calciumRawBlockTrunc{i,2},calciumRawBlockMat{i,2}] = segmenting(calciumRaw,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [eyeRawBlock{i,2},eyeRawBlockTrunc{i,2},eyeRawBlockMat{i,2}] = segmenting(eyeVelRawTrunc,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [eyeSmoothBlock{i,2},eyeSmoothBlockTrunc{i,2},eyeSmoothBlockMat{i,2}] = segmenting(eyeSmoothTrunc,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [eyeVelFiltBlock{i,2},eyeVelFiltBlockTrunc{i,2},eyeVelFiltBlockMat{i,2}] = segmenting(eyeVelFiltTrunc,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [eyeAccRawBlock{i,2},eyeAccRawBlockTrunc{i,2},eyeAccRawBlockMat{i,2}] = segmenting(eyeAccRawTrunc,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [eyePrawBlock{i,2},eyePrawBlockTrunc{i,2},eyePrawBlockMat{i,2}] = segmenting(eyePtrunc,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [eyePfiltBlock{i,2},eyePfiltBlockTrunc{i,2},eyePfiltBlockMat{i,2}] = segmenting(eyePfiltTrunc,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [eyeSacsBlock{i,2},eyeSacsBlockTrunc{i,2},eyeSacsBlockMat{i,2}] = segmenting(eyeSacsTrunc,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [turntableBlock{i,2},turntableBlockTrunc{i,2},turntableBlockMat{i,2}] = segmenting(chVtrunc,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [turntablePblock{i,2},turntablePblockTrunc{i,2},turntablePblockMat{i,2}] = segmenting(chPtrunc,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [fBlock{i,2},fBlockTrunc{i,2},fBlockMat{i,2}] = segmenting(Fupsamp,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [f0block{i,2},f0blockTrunc{i,2},f0blockMat{i,2}] = segmenting(f0upsamp,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [gBlock{i,2},gBlockTrunc{i,2},gBlockMat{i,2}] = segmenting(Gupsamp,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [drumVelBlock{i,2},drumVelBlockTrunc{i,2},drumVelBlockMat{i,2}] = segmenting(drumVelTrunc,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [drumPblock{i,2},drumPblockTrunc{i,2},drumPblockMat{i,2}] = segmenting(drumPtrunc,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [rsBlock{i,2},rsBlockTrunc{i,2},rsBlockMat{i,2}] = segmenting(rsTrunc,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [rsFiltBlock{i,2},rsFiltBlockTrunc{i,2},rsFiltBlockMat{i,2}] = segmenting(rsFiltTrunc,startVisual,startGap,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        nthTime = nthTime + 1;
    end
elseif numBlocksVisual > 0 && protocol == 3
    nthTime = 1;
    visualRef = 1;
    for i = 1:numBlocksVisual
        [calFiltBlock{i,2},calFiltBlockTrunc{i,2},calFiltBlockMat{i,2}] = segmenting(calcium_upsampled,startVisual,startRec,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [calciumRawBlock{i,2},calciumRawBlockTrunc{i,2},calciumRawBlockMat{i,2}] = segmenting(calciumRaw,startVisual,startRec,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [eyeRawBlock{i,2},eyeRawBlockTrunc{i,2},eyeRawBlockMat{i,2}] = segmenting(eyeVelRawTrunc,startVisual,startRec,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [eyeSmoothBlock{i,2},eyeSmoothBlockTrunc{i,2},eyeSmoothBlockMat{i,2}] = segmenting(eyeSmoothTrunc,startVisual,startRec,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [eyeVelFiltBlock{i,2},eyeVelFiltBlockTrunc{i,2},eyeVelFiltBlockMat{i,2}] = segmenting(eyeVelFiltTrunc,startVisual,startRec,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [eyeAccRawBlock{i,2},eyeAccRawBlockTrunc{i,2},eyeAccRawBlockMat{i,2}] = segmenting(eyeAccRawTrunc,startVisual,startRec,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [eyePrawBlock{i,2},eyePrawBlockTrunc{i,2},eyePrawBlockMat{i,2}] = segmenting(eyePtrunc,startVisual,startRec,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [eyePfiltBlock{i,2},eyePfiltBlockTrunc{i,2},eyePfiltBlockMat{i,2}] = segmenting(eyePfiltTrunc,startVisual,startRec,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [eyeSacsBlock{i,2},eyeSacsBlockTrunc{i,2},eyeSacsBlockMat{i,2}] = segmenting(eyeSacsTrunc,startVisual,startRec,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [turntableBlock{i,2},turntableBlockTrunc{i,2},turntableBlockMat{i,2}] = segmenting(chVtrunc,startVisual,startRec,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [turntablePblock{i,2},turntablePblockTrunc{i,2},turntablePblockMat{i,2}] = segmenting(chPtrunc,startVisual,startRec,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [fBlock{i,2},fBlockTrunc{i,2},fBlockMat{i,2}] = segmenting(Fupsamp,startVisual,startRec,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [f0block{i,2},f0blockTrunc{i,2},f0blockMat{i,2}] = segmenting(f0upsamp,startVisual,startRec,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [gBlock{i,2},gBlockTrunc{i,2},gBlockMat{i,2}] = segmenting(Gupsamp,startVisual,startRec,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [drumVelBlock{i,2},drumVelBlockTrunc{i,2},drumVelBlockMat{i,2}] = segmenting(drumVelTrunc,startVisual,startRec,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [drumPblock{i,2},drumPblockTrunc{i,2},drumPblockMat{i,2}] = segmenting(drumPtrunc,startVisual,startRec,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [rsBlock{i,2},rsBlockTrunc{i,2},rsBlockMat{i,2}] = segmenting(rsTrunc,startVisual,startRec,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        [rsFiltBlock{i,2},rsFiltBlockTrunc{i,2},rsFiltBlockMat{i,2}] = segmenting(rsFiltTrunc,startVisual,startRec,endVisual,nthTime,fr,frequency,numTimeVisual,keepL,visualRef);
        nthTime = nthTime + 1;
    end
end
visualRef = 0;

%gap segmenting
if numBlocksGap > 0 && (protocol == 0 || protocol == 1 || protocol == 2)
    nthTime = 1;
    for i = 1:numBlocksGap
        [calFiltBlock{i,3},calFiltBlockTrunc{i,3},calFiltBlockMat{i,3}] = segmenting(calcium_upsampled,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [calciumRawBlock{i,3},calciumRawBlockTrunc{i,3},calciumRawBlockMat{i,3}] = segmenting(calciumRaw,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [eyeRawBlock{i,3},eyeRawBlockTrunc{i,3},eyeRawBlockMat{i,3}] = segmenting(eyeVelRawTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [eyeSmoothBlock{i,3},eyeSmoothBlockTrunc{i,3},eyeSmoothBlockMat{i,3}] = segmenting(eyeSmoothTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [eyeVelFiltBlock{i,3},eyeVelFiltBlockTrunc{i,3},eyeVelFiltBlockMat{i,3}] = segmenting(eyeVelFiltTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [eyeAccRawBlock{i,3},eyeAccRawBlockTrunc{i,3},eyeAccRawBlockMat{i,3}] = segmenting(eyeAccRawTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [eyePrawBlock{i,3},eyePrawBlockTrunc{i,3},eyePrawBlockMat{i,3}] = segmenting(eyePtrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [eyePfiltBlock{i,3},eyePfiltBlockTrunc{i,3},eyePfiltBlockMat{i,3}] = segmenting(eyePfiltTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [eyeSacsBlock{i,3},eyeSacsBlockTrunc{i,3},eyeSacsBlockMat{i,3}] = segmenting(eyeSacsTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [turntableBlock{i,3},turntableBlockTrunc{i,3},turntableBlockMat{i,3}] = segmenting(chVtrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [turntablePblock{i,3},turntablePblockTrunc{i,3},turntablePblockMat{i,3}] = segmenting(chPtrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [fBlock{i,3},fBlockTrunc{i,3},fBlockMat{i,3}] = segmenting(Fupsamp,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [f0block{i,3},f0blockTrunc{i,3},f0blockMat{i,3}] = segmenting(f0upsamp,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [gBlock{i,3},gBlockTrunc{i,3},gBlockMat{i,3}] = segmenting(Gupsamp,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
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
    for i = 1:numBlocksGap
        [calFiltBlock{i,3},calFiltBlockTrunc{i,3},calFiltBlockMat{i,3}] = segmenting(calcium_upsampled,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [calciumRawBlock{i,3},calciumRawBlockTrunc{i,3},calciumRawBlockMat{i,3}] = segmenting(calciumRaw,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [eyeRawBlock{i,3},eyeRawBlockTrunc{i,3},eyeRawBlockMat{i,3}] = segmenting(eyeVelRawTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [eyeSmoothBlock{i,3},eyeSmoothBlockTrunc{i,3},eyeSmoothBlockMat{i,3}] = segmenting(eyeSmoothTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [eyeVelFiltBlock{i,3},eyeVelFiltBlockTrunc{i,3},eyeVelFiltBlockMat{i,3}] = segmenting(eyeVelFiltTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [eyeAccRawBlock{i,3},eyeAccRawBlockTrunc{i,3},eyeAccRawBlockMat{i,3}] = segmenting(eyeAccRawTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [eyePrawBlock{i,3},eyePrawBlockTrunc{i,3},eyePrawBlockMat{i,3}] = segmenting(eyePtrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [eyePfiltBlock{i,3},eyePfiltBlockTrunc{i,3},eyePfiltBlockMat{i,3}] = segmenting(eyePfiltTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [eyeSacsBlock{i,3},eyeSacsBlockTrunc{i,3},eyeSacsBlockMat{i,3}] = segmenting(eyeSacsTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [turntableBlock{i,3},turntableBlockTrunc{i,3},turntableBlockMat{i,3}] = segmenting(chVtrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [turntablePblock{i,3},turntablePblockTrunc{i,3},turntablePblockMat{i,3}] = segmenting(chPtrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [fBlock{i,3},fBlockTrunc{i,3},fBlockMat{i,3}] = segmenting(Fupsamp,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [f0block{i,3},f0blockTrunc{i,3},f0blockMat{i,3}] = segmenting(f0upsamp,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [gBlock{i,3},gBlockTrunc{i,3},gBlockMat{i,3}] = segmenting(Gupsamp,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [drumVelBlock{i,3},drumVelBlockTrunc{i,3},drumVelBlockMat{i,3}] = segmenting(drumVelTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        [drumPblock{i,3},drumPblockTrunc{i,3},drumPblockMat{i,3}] = segmenting(drumPtrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        if condition ~= 3
            [rsBlock{i,3},rsBlockTrunc{i,3},rsBlockMat{i,3}] = segmenting(rsTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
            [rsFiltBlock{i,3},rsFiltBlockTrunc{i,3},rsFiltBlockMat{i,3}] = segmenting(rsFiltTrunc,startGap,startGap,endGap,nthTime,fr,frequency,numTimeGap,keepSp,visualRef);
        end
        nthTime = nthTime + 1;
    end
end

if protocol == 3
    [randSortReshape,conditionIdxs] = randBlockSort(dataRand,numBlocksVisual,numFreq,numTestPerFreq);
% Eye sorting for multiple frequency experiment
    for t = 1:6
        for i = 1:numTestPerFreq
            calVisual{t,i} = calciumRawBlockMat{conditionIdxs{1,t}(i),2};
            eyeVisual{t,i} = eyeRawBlockMat{conditionIdxs{1,t}(i),2};
            rs{t,i} = rsBlockMat{conditionIdxs{1,t}(i),2};
            drumVisual{t,i} = drumVelBlockMat{conditionIdxs{1,t}(i),2};
        end
    end
    calVisual{5,4} = calciumRawBlockMat{conditionIdxs{1,5}(4),2};
    calVisual{6,4} = calciumRawBlockMat{conditionIdxs{1,6}(4),2};
    eyeVisual{5,4} = eyeRawBlockMat{conditionIdxs{1,5}(4),2};
    eyeVisual{6,4} = eyeRawBlockMat{conditionIdxs{1,6}(4),2};
    rs{5,4} = rsBlockMat{conditionIdxs{1,5}(4),2};
    rs{6,4} = rsBlockMat{conditionIdxs{1,6}(4),2};
    drumVisual{5,4} = drumVelBlockMat{conditionIdxs{1,5}(4),2};
    drumVisual{6,4} = drumVelBlockMat{conditionIdxs{1,6}(4),2};
    
    calVisualVec = cellfun(@(x) x(:),calVisual,'UniformOutput',false);
    eyeVisualVec = cellfun(@(x) x(:),eyeVisual,'UniformOutput',false);
    rsVec = cellfun(@(x) x(:),rs,'UniformOutput',false);
    drumVisualVec = cellfun(@(x) x(:),drumVisual,'UniformOutput',false);
    freq = [0.5 1 2 4 0.5 0.5];
    for t = 1:6
        for i = 1:3
            calVisual{t,i} = reshape(calVisualVec{t,i},fr*1/freq(t),numTimeVisual*freq(t));
            eyeVisual{t,i} = reshape(eyeVisualVec{t,i},fr*1/freq(t),numTimeVisual*freq(t));
            rs{t,i} = reshape(rsVec{t,i},fr*1/freq(t),numTimeVisual*freq(t));
            drumVisual{t,i} = reshape(drumVisualVec{t,i},fr*1/freq(t),numTimeVisual*freq(t));
        end
    end
    calVisual{5,4} = reshape(calVisualVec{5,4},fr*1/freq(5),numTimeVisual*freq(5));
    calVisual{6,4} = reshape(calVisualVec{6,4},fr*1/freq(6),numTimeVisual*freq(6));
    eyeVisual{5,4} = reshape(eyeVisualVec{5,4},fr*1/freq(5),numTimeVisual*freq(5));
    eyeVisual{6,4} = reshape(eyeVisualVec{6,4},fr*1/freq(6),numTimeVisual*freq(6));
    rs{5,4} = reshape(rsVec{5,4},fr*1/freq(5),numTimeVisual*freq(5));
    rs{6,4} = reshape(rsVec{6,4},fr*1/freq(6),numTimeVisual*freq(6));
    drumVisual{5,4} = reshape(drumVisualVec{5,4},fr*1/freq(5),numTimeVisual*freq(5));
    drumVisual{6,4} = reshape(drumVisualVec{6,4},fr*1/freq(6),numTimeVisual*freq(6));
    
    calDarkMatIn = [];
    calVisualMatIn05 = [calVisual{1,1:numTestPerFreq}]';
    calVisualMatIn1 = [calVisual{2,1:numTestPerFreq}]';
    calVisualMatIn2 = [calVisual{3,1:numTestPerFreq}]';
    calVisualMatIn4 = [calVisual{4,1:numTestPerFreq}]';
    calVisualMatIn5 = [calVisual{5,1:numTestPerFreq}]';
    calVisualMatIn10 = [calVisual{6,1:numTestPerFreq}]';
    calVisualMatIn5(end+1:end+20,:) = [calVisual{5,4}]';
    calVisualMatIn10(end+1:end+20,:) = [calVisual{6,4}]';
    calGapMatIn = [];
    eyeDarkMatIn = [];
    eyeVisualMatIn05 = [eyeVisual{1,1:numTestPerFreq}]';
    eyeVisualMatIn1 = [eyeVisual{2,1:numTestPerFreq}]';
    eyeVisualMatIn2 = [eyeVisual{3,1:numTestPerFreq}]';
    eyeVisualMatIn4 = [eyeVisual{4,1:numTestPerFreq}]';
    eyeVisualMatIn5 = [eyeVisual{5,1:numTestPerFreq}]';
    eyeVisualMatIn10 = [eyeVisual{6,1:numTestPerFreq}]';
    eyeVisualMatIn5(end+1:end+20,:) = [eyeVisual{5,4}]';
    eyeVisualMatIn10(end+1:end+20,:) = [eyeVisual{6,4}]';
    eyeGapMatIn = [];
    
    rsMatIn05 = [rs{1,1:numTestPerFreq}]';
    rsMatIn1 = [rs{2,1:numTestPerFreq}]';
    rsMatIn2 = [rs{3,1:numTestPerFreq}]';
    rsMatIn4 = [rs{4,1:numTestPerFreq}]';
    rsMatIn5 = [rs{5,1:numTestPerFreq}]';
    rsMatIn10 = [rs{6,1:numTestPerFreq}]';
    rsMatIn5(end+1:end+20,:) = [rs{5,4}]';
    rsMatIn10(end+1:end+20,:) = [rs{6,4}]';
end

%% Desaccading
if protocol ~= 3 & expSubType ~= 1
    calDarkMatIn = [calciumRawBlockMat{1:numBlocksDark,1}]';
    calVisualMatIn = [calciumRawBlockMat{1:numBlocksVisual,2}]';
    calGapMatIn = [calciumRawBlockMat{1:numBlocksGap,3}]';
    eyeDarkMatIn = [eyeRawBlockMat{1:numBlocksDark,1}]';
    eyeVisualMatIn = [eyeRawBlockMat{1:numBlocksVisual,2}]';
    eyeGapMatIn = [eyeRawBlockMat{1:numBlocksGap,3}]';
    eyeSmoothDarkMatIn = [eyeSmoothBlockMat{1:numBlocksDark,1}]';
    eyeSmoothVisualMatIn = [eyeSmoothBlockMat{1:numBlocksVisual,2}]';
    eyeSmoothGapMatIn = [eyeSmoothBlockMat{1:numBlocksGap,3}]';
    eyePdarkMatIn = [eyePrawBlockMat{1:numBlocksDark,1}];
    eyePvisualMatIn = [eyePrawBlockMat{1:numBlocksVisual,2}];
    eyePgapMatIn = [eyePrawBlockMat{1:numBlocksGap,3}];
elseif expSubType == 1
    calDarkMatIn = [calciumRawBlockMat{1:numBlocksDark,1}]';
    calVisualMatIn = [calciumRawBlockMat{1:2:numBlocksVisual*2,2}]';
    calVisualMatIn2 = [calciumRawBlockMat{2:2:numBlocksVisual*2,2}]';
    calGapMatIn = [calciumRawBlockMat{1:numBlocksGap,3}]';
    eyeDarkMatIn = [eyeRawBlockMat{1:numBlocksDark,1}]';
    eyeVisualMatIn = [eyeRawBlockMat{1:2:numBlocksVisual*2,2}]';
    eyeVisualMatIn2 = [eyeRawBlockMat{2:2:numBlocksVisual*2,2}]';
    eyeGapMatIn = [eyeRawBlockMat{1:numBlocksGap,3}]';
    eyeSmoothDarkMatIn = [eyeSmoothBlockMat{1:numBlocksDark,1}]';
    eyeSmoothVisualMatIn = [eyeSmoothBlockMat{1:2:numBlocksVisual*2,2}]';
    eyeSmoothVisualMatIn2 = [eyeSmoothBlockMat{2:2:numBlocksVisual*2,2}]';
    eyeSmoothGapMatIn = [eyeSmoothBlockMat{1:numBlocksGap,3}]';
    eyePdarkMatIn = [eyePrawBlockMat{1:numBlocksDark,1}];
    eyePvisualMatIn = [eyePrawBlockMat{1:2:numBlocksVisual*2,2}];
    eyePvisualMatIn2 = [eyePrawBlockMat{2:2:numBlocksVisual*2,2}];
    eyePgapMatIn = [eyePrawBlockMat{1:numBlocksGap,3}];

    numBlocksVisual = numel(endVisual)/2;
end

if desacMethod == 0
% Cluster desaccading
    clusterSize = size(calDarkMatIn,1)/3;
    clusterSize = 2*floor(clusterSize)/2 - 1;
    
    [eyeDarkMatOut,eyeVisualMatOut,eyeGapMatOut,eyeDarkSacVector,eyeVisualSacVector,eyeGapSacVector,~,~,~,~] = clusterDesaccading(eyeDarkMatIn,eyeVisualMatIn,eyeGapMatIn,movingMean,thresh,clusterSize,'Cluster desaccaded eye vel.');
    [eyeSmoothDarkMatOut,eyeSmoothVisualMatOut,eyeSmoothGapMatOut,eyeSmoothDarkSacVector,eyeSmoothVisualSacVector,eyeSmoothGapSacVector,~,~,~,~] = clusterDesaccading(eyeSmoothDarkMatIn,eyeSmoothVisualMatIn,eyeSmoothGapMatIn,movingMean,thresh,clusterSize,'Cluster desaccaded smooth eye vel.');
    presac = presac * 4;
    postsac = postsac * 4;
    [calDarkMatOut,calVisualMatOut,calGapMatOut,calDarkSacVector,calVisualSacVector,calGapSacVector,connectionDistance2,clusterCenter2,connectionDistance3,clusterCenter3] = clusterDesaccading(calDarkMatIn,calVisualMatIn,calGapMatIn,movingMean,thresh,clusterSize,'Cluster desaccaded calcium');

    
    eyeDarkSacs = eyeDarkMatIn';
    eyeVisualSacs = eyeVisualMatIn';
    eyeGapSacs = eyeGapMatIn';
    saccadesDarkMat = reshape(eyeDarkSacVector,fr*(1/frequency),numBlocksDark*numTimeDark);
    saccadesVisualMat = reshape(eyeVisualSacVector,fr*(1/frequency),numBlocksVisual*numTimeVisual);
    saccadesSmoothVisualMat = reshape(eyeSmoothVisualSacVector,fr*(1/frequency),numBlocksVisual*numTimeVisual);
    saccadesGapMat = reshape(eyeGapSacVector,fr*(1/frequency),numBlocksGap*numTimeGap);
    eyeDarkSacs(~saccadesDarkMat) = NaN;
    eyeVisualSacs(~saccadesVisualMat) = NaN;
    eyeGapSacs(~saccadesGapMat) = NaN;
    
    saccadeCentersDark = eyeDarkSacs(:);
    saccadeCentersVisual = eyeVisualSacs(:);
    saccadeCentersGap = eyeGapSacs(:);
    
    eyeVisualVecIn = eyeVisualMatIn';
    eyeVisualVecIn = eyeVisualVecIn(:);
    eyePvisualVecIn = eyePvisualMatIn(:);
    
    eyeDarkVecIn = eyeDarkMatIn';
    eyeDarkVecIn = eyeDarkVecIn(:);
    eyePdarkVecIn = eyePdarkMatIn(:);
    
    eyeGapVecIn = eyeGapMatIn';
    eyeGapVecIn = eyeGapVecIn(:);
    eyePgapVecIn = eyePgapMatIn(:);
    
elseif desacMethod == 1
% MAD desaccading
    if protocol ~= 3 && expSubType ~= 1
        [eyeVisualMatOut,eyeDarkMatOut,eyeGapMatOut,eyeVisualOutVector,eyeDarkOutVector,eyeGapOutVector,saccadesDarkMat,saccadesVisualMat,saccadesGapMat,upperVisual,lowerVisual,upperDark,lowerDark] = madDesac(numBlocksDark,numBlocksVisual,numBlocksGap,madMultiplier,madMultiplierD,madMultiplierSp,eyeVisualMatIn,eyeDarkMatIn,eyeGapMatIn,presac,postsac,'MAD desaccading eye vel.');
        [eyeSmoothVisualMatOut,eyeSmoothDarkMatOut,eyeSmoothGapMatOut,eyeSmoothVisualMatOutVector,eyeSmoothMatOutVector,eyeSmoothGapMatOutVector,saccadesSmoothDarkMat,saccadesSmoothVisualMat,saccadesSmoothGapMat] = madDesac(numBlocksDark,numBlocksVisual,numBlocksGap,madMultiplier,madMultiplierD,madMultiplierSp,eyeSmoothVisualMatIn,eyeSmoothDarkMatIn,eyeSmoothGapMatIn,presac,postsac,'MAD desaccading smoothed eye vel.');
        presac = presac * 4;
        postsac = postsac * 4;
        [calVisualMatOut,calDarkMatOut,calGapMatOut,calVisualMatOutVector,calDarkMatOutVector,calGapMatOutVector,saccadesCalDarkMat,saccadesCalVisualMat,saccadesCalGapMat] = madDesac(numBlocksDark,numBlocksVisual,numBlocksGap,madMultiplierCalcium,madMultiplierCalcium,madMultiplierCalcium,calVisualMatIn,calDarkMatIn,calGapMatIn,presac,postsac,'MAD desaccading calcium');
        
        eyeDarkSacs = eyeDarkMatIn';
        eyeVisualSacs = eyeVisualMatIn';
        eyeGapSacs = eyeGapMatIn';
        eyeDarkSacs(saccadesDarkMat) = NaN;
        eyeVisualSacs(saccadesVisualMat) = NaN;
        eyeGapSacs(saccadesGapMat) = NaN;

        saccadeCentersDark = eyeDarkSacs(:);
        saccadeCentersVisual = eyeVisualSacs(:);
        saccadeCentersGap = eyeGapSacs(:);

        eyeVisualVecIn = eyeVisualMatIn';
        eyeVisualVecIn = eyeVisualVecIn(:);
        eyePvisualVecIn = eyePvisualMatIn(:);

        eyeDarkVecIn = eyeDarkMatIn';
        eyeDarkVecIn = eyeDarkVecIn(:);
        eyePdarkVecIn = eyePdarkMatIn(:);

        eyeGapVecIn = eyeGapMatIn';
        eyeGapVecIn = eyeGapVecIn(:);
        eyePgapVecIn = eyePgapMatIn(:);
    elseif expSubType == 1
        [eyeVisualMatOut,eyeDarkMatOut,eyeGapMatOut,eyeVisualOutVector,eyeDarkOutVector,eyeGapOutVector,saccadesDarkMat,saccadesVisualMat,saccadesGapMat,upperVisual,lowerVisual,upperDark,lowerDark] = madDesac(numBlocksDark,numBlocksVisual,numBlocksGap,madMultiplier,madMultiplierD,madMultiplierSp,eyeVisualMatIn,eyeDarkMatIn,eyeGapMatIn,presac,postsac,'MAD desaccading eye vel.');
        [eyeSmoothVisualMatOut,eyeSmoothDarkMatOut,eyeSmoothGapMatOut,eyeSmoothVisualMatOutVector,eyeSmoothMatOutVector,eyeSmoothGapMatOutVector,saccadesSmoothDarkMat,saccadesSmoothVisualMat,saccadesSmoothGapMat] = madDesac(numBlocksDark,numBlocksVisual,numBlocksGap,madMultiplier,madMultiplierD,madMultiplierSp,eyeSmoothVisualMatIn,eyeSmoothDarkMatIn,eyeSmoothGapMatIn,presac,postsac,'MAD desaccading smoothed eye vel.');
        [eyeVisualMatOut2,~,~,eyeVisualOutVector2,~,~,~,saccadesVisualMat2,~,upperVisual,lowerVisual,upperDark,lowerDark] = madDesac(numBlocksDark,numBlocksVisual,numBlocksGap,madMultiplier,madMultiplierD,madMultiplierSp,eyeVisualMatIn2,eyeDarkMatIn,eyeGapMatIn,presac,postsac,'MAD desaccading eye vel.');
        [eyeSmoothVisualMatOut2,~,~,eyeSmoothVisualMatOutVector2,~,~,~,saccadesSmoothVisualMat2,~] = madDesac(numBlocksDark,numBlocksVisual,numBlocksGap,madMultiplier,madMultiplierD,madMultiplierSp,eyeSmoothVisualMatIn2,eyeSmoothDarkMatIn,eyeSmoothGapMatIn,presac,postsac,'MAD desaccading smoothed eye vel.');
        presac = presac * 4;
        postsac = postsac * 4;
        [calVisualMatOut,calDarkMatOut,calGapMatOut,calVisualMatOutVector,calDarkMatOutVector,calGapMatOutVector,saccadesCalDarkMat,saccadesCalVisualMat,saccadesCalGapMat] = madDesac(numBlocksDark,numBlocksVisual,numBlocksGap,madMultiplierCalcium,madMultiplierCalcium,madMultiplierCalcium,calVisualMatIn,calDarkMatIn,calGapMatIn,presac,postsac,'MAD desaccading calcium');
        [calVisualMatOut2,~,~,calVisualMatOutVector2,~,~,~,saccadesCalVisualMat2,~] = madDesac(numBlocksDark,numBlocksVisual,numBlocksGap,madMultiplierCalcium,madMultiplierCalcium,madMultiplierCalcium,calVisualMatIn2,calDarkMatIn,calGapMatIn,presac,postsac,'MAD desaccading calcium');

        eyeDarkSacs = eyeDarkMatIn';
        eyeVisualSacs = eyeVisualMatIn';
        eyeGapSacs = eyeGapMatIn';
        eyeDarkSacs(saccadesDarkMat) = NaN;
        eyeVisualSacs(saccadesVisualMat) = NaN;
        eyeGapSacs(saccadesGapMat) = NaN;

        eyeVisualSacs2 = eyeVisualMatIn2';
        eyeVisualSacs2(saccadesVisualMat2) = NaN;

        saccadeCentersDark = eyeDarkSacs(:);
        saccadeCentersVisual = eyeVisualSacs(:);
        saccadeCentersGap = eyeGapSacs(:);

        eyeVisualVecIn = eyeVisualMatIn';
        eyeVisualVecIn = eyeVisualVecIn(:);
        eyePvisualVecIn = eyePvisualMatIn(:);

        eyeDarkVecIn = eyeDarkMatIn';
        eyeDarkVecIn = eyeDarkVecIn(:);
        eyePdarkVecIn = eyePdarkMatIn(:);

        eyeGapVecIn = eyeGapMatIn';
        eyeGapVecIn = eyeGapVecIn(:);
        eyePgapVecIn = eyePgapMatIn(:);
    else
        [eyeVisualMatOut05,eyeVisualMatOut1,eyeVisualMatOut2,eyeVisualOutVector05,eyeVisualOutVector1,eyeVisualOutVector2,saccadesVisualMat1,saccadesVisualMat05,saccadesVisualMat2,upperVisual,lowerVisual,upperDark,lowerDark] = madDesac(numBlocksVisual,numBlocksVisual,numBlocksVisual,madMultiplier,madMultiplierD,madMultiplierSp,eyeVisualMatIn05,eyeVisualMatIn1,eyeVisualMatIn2,presac,postsac,'MAD desaccading eye vel.');
        [eyeVisualMatOut4,eyeVisualMatOut5,eyeVisualMatOut10,eyeVisualOutVector4,eyeVisualOutVector5,eyeVisualOutVector10,saccadesVisualMat5,saccadesVisualMat4,saccadesVisualMat10,upperVisual,lowerVisual,upperDark,lowerDark] = madDesac(numBlocksVisual,numBlocksVisual,numBlocksVisual,madMultiplier,madMultiplierD,madMultiplierSp,eyeVisualMatIn4,eyeVisualMatIn5,eyeVisualMatIn10,presac,postsac,'MAD desaccading eye vel.');
        presac = presac * 4;
        postsac = postsac * 4;
        [calVisualMatOut05,calVisualMatOut1,calVisualMatOut2,calVisualMatOutVector05,calVisualMatOutVector1,calVisualMatOutVector2,saccadesCalVisualMat1,saccadesCalVisualMat05,saccadesCalVisualMat2] = madDesac(numBlocksVisual,numBlocksVisual,numBlocksVisual,madMultiplierCalcium,madMultiplierCalcium,madMultiplierCalcium,calVisualMatIn05,calVisualMatIn1,calVisualMatIn2,presac,postsac,'MAD desaccading calcium');
        [calVisualMatOut4,calVisualMatOut5,calVisualMatOut10,calVisualMatOutVector4,calVisualMatOutVector5,calVisualMatOutVector10,saccadesCalVisualMat5,saccadesCalVisualMat4,saccadesCalVisualMat10] = madDesac(numBlocksVisual,numBlocksVisual,numBlocksVisual,madMultiplierCalcium,madMultiplierCalcium,madMultiplierCalcium,calVisualMatIn4,calVisualMatIn5,calVisualMatIn10,presac,postsac,'MAD desaccading calcium');
    end
end

%% Distinguishing saccades from eye blinks
% Prep
if condition ~= 3 && protocol ~=3
    fig1 = figure('Name','Differentiating saccades');
    tiledlayout(2, 1);
    colormap = brewermap(4, 'Set1');

    magnetTime = (0:0.001:length(eyePvisualVecIn) / 1000 - 0.001)';

    % Magnet pos
    ax1 = nexttile;
    hold on;
    plot(magnetTime, eyePvisualVecIn, 'Color', [0.7, 0.7, 0.7]);

    % Magnet vel
    ax2 = nexttile;
    hold on;
    magnetVel = eyeVisualVecIn;
    plot(magnetTime, eyeVisualVecIn, 'Color', [0.7, 0.7, 0.7]);

    % Detect saccades
    saccadesVisual = getStartStop(saccadeCentersVisual);
    saccadesDark = getStartStop(saccadeCentersDark);
    saccadesGap = getStartStop(saccadeCentersGap);
    
    % Get min PV
    for i = 1:size(saccadesVisual, 1)
        start = saccadesVisual(i, 1);
        stop = saccadesVisual(i, 2);
        
        % Peak velocity
        absVel = abs(eyeVisualMatIn);
        A = absVel(start:stop);
        peakVel(i) = max(A);
        minPV = min(peakVel);
    end
    
    for i = 1:size(saccadesDark, 1)
        start = saccadesDark(i, 1);
        stop = saccadesDark(i, 2);
        
        % Peak velocity
        absVelDark = abs(eyeDarkMatIn);
        A = absVelDark(start:stop);
        peakVelDark(i) = max(A);
        minPVdark = min(peakVelDark);
    end
    
    for i = 1:size(saccadesGap, 1)
        start = saccadesGap(i, 1);
        stop = saccadesGap(i, 2);
        
        % Peak velocity
        absVelGap = abs(eyeGapMatIn);
        A = absVelGap(start:stop);
        peakVelGap(i) = max(A);
        minPVgap = min(peakVelGap);
    end
    
    saccadesVisual = extendSaccadesToThres(saccadesVisual, eyePvisualVecIn, minPV);
    [saccadesVisual, artifactsVisual] = removeArtifacts(saccadesVisual, eyePvisualVecIn,sacLength,neighborThresh);
    
    if condition ~= 2
        saccadesDark = extendSaccadesToThres(saccadesDark, eyePdarkVecIn, minPVdark);
        [saccadesDark, artifactsDark] = removeArtifacts(saccadesDark, eyePdarkVecIn,sacLength,neighborThresh);
    end
    
    saccadesGap = extendSaccadesToThres(saccadesGap, eyePgapVecIn, minPVgap);
    [saccadesGap, artifactsGap] = removeArtifacts(saccadesGap, eyePgapVecIn,sacLength,neighborThresh);

    % Plot
    axes(ax1);
    saccadesInContext = putInContext(saccadesVisual, eyePvisualVecIn, true);
    plot(magnetTime, saccadesInContext, 'Color', colormap(2, :), 'LineWidth', 1);
    artifactsInContext = putInContext(artifactsVisual, eyePvisualVecIn, true);
    plot(magnetTime, artifactsInContext, 'Color', colormap(1, :), 'LineWidth', 1);
    
    if expSubType ~= 2
        fig2 = figure('Name','Differentiating saccades');
        tiledlayout(2, 1);
        colormap = brewermap(4, 'Set1');

        magnetTime = (0:0.001:length(eyePdarkVecIn) / 1000 - 0.001)';

        % Magnet pos
        ax1 = nexttile;
        hold on;
        plot(magnetTime, eyePdarkVecIn, 'Color', [0.7, 0.7, 0.7]);

        % Magnet vel
        ax2 = nexttile;
        hold on;
        magnetVel = eyeDarkVecIn;
        plot(magnetTime, eyeDarkVecIn, 'Color', [0.7, 0.7, 0.7]);

        axes(ax1);
        saccadesInContext = putInContext(saccadesDark, eyePdarkVecIn, true);
        plot(magnetTime, saccadesInContext, 'Color', colormap(2, :), 'LineWidth', 1);
        if condition ~= 2
            artifactsInContext = putInContext(artifactsDark, eyePdarkVecIn, true);
            plot(magnetTime, artifactsInContext, 'Color', colormap(1, :), 'LineWidth', 1);
        end

        grid on;
        xlabel('Time (s)');
        ylabel('Position (deg)');
        linkaxes([ax1, ax2], 'x');
        legend('Pos', 'Saccades', 'Artifacts')
    end
%% Saccade differentiation analysis
% Extract features
    duration = zeros(size(saccadesVisual, 1), 1);
    peakVel = zeros(size(saccadesVisual, 1), 1);
    amplitude = zeros(size(saccadesVisual, 1), 1);

    for i = 1:size(saccadesVisual, 1)
        start = saccadesVisual(i, 1);
        stop = saccadesVisual(i, 2);

        % Peak velocity
        absVel = abs(eyeVisualVecIn);
        A = absVel(start:stop);
        peakVel(i) = max(A);

        % Amplitude
        A = eyePvisualVecIn(start:stop);
        amplitude(i) = range(A);

        % Duration
        duration(i) = stop - start + 1;
    end

    PVTimesDuration = peakVel .* duration ./ 1000;

    durationArtifacts = zeros(size(saccadesVisual, 1), 1);
    peakVelArtifacts = zeros(size(saccadesVisual, 1), 1);
    amplitudeArtifacts = zeros(size(saccadesVisual, 1), 1);
    for i = 1:size(artifactsVisual, 1)
        start = artifactsVisual(i, 1);
        stop = artifactsVisual(i, 2);

        % Peak velocity
        absVel = abs(eyeVisualVecIn);
        A = absVel(start:stop);
        peakVelArtifacts(i) = max(A);

        % Amplitude
        A = eyePvisualVecIn(start:stop);
        amplitudeArtifacts(i) = range(A);

        % Duration
        durationArtifacts(i) = stop - start + 1;
    end

    %% PV vs. amplitude
    if eyeArtifactPlotting == 1
        fig2 = figure('units', 'normalized', 'outerposition', [0, 0, 1, 1]);
        tiledlayout(1, 1);

        ax4 = nexttile;
        hold on;
        scatter(amplitude, peakVel, 10, colormap(2, :), 'filled');
        coefficients = polyfit(amplitude, peakVel, 1);
        xFit = linspace(0, max(amplitude), 2);
        yFit = polyval(coefficients, xFit);
        plot(xFit, yFit, 'Color', colormap(2, :), 'HandleVisibility', 'off');
        [r, pval] = corr(amplitude, peakVel);

        grid on;
        xlabel('Amplitude (deg)');
        ylabel('PV (deg / s)');
        xline(0, 'HandleVisibility', 'off');
        yline(0, 'HandleVisibility', 'off');
        legend(sprintf('y = %f * x + %f, R^2 = %f', coefficients(1), coefficients(2), r * r));

    %% Duration vs. amplitude

        fig3 = figure('units', 'normalized', 'outerposition', [0, 0, 1, 1]);
        tiledlayout(1, 1);

        ax3 = nexttile;
        hold on;
        scatter(amplitude, duration, 10, colormap(2, :), 'filled');
        coefficients = polyfit(amplitude, duration, 1);
        xFit = linspace(0, max(amplitude), 2);
        yFit = polyval(coefficients, xFit);
        plot(xFit, yFit, 'Color', colormap(2, :), 'HandleVisibility', 'off');
        [r, pval] = corr(amplitude, duration);

        grid on;
        legend(sprintf('y = %f * x + %f, R^2 = %f', coefficients(1), coefficients(2), r * r));
        xlabel('Amplitude (deg)');
        ylabel('Duration (ms)');
        xline(0, 'HandleVisibility', 'off');
        yline(0, 'HandleVisibility', 'off');

    %% PV * Duration vs. amplitude

        fig4 = figure('units', 'normalized', 'outerposition', [0, 0, 1, 1]);
        tiledlayout(1, 1);

        ax5 = nexttile;
        hold on;
        scatter(amplitude, PVTimesDuration, 10, colormap(2, :), 'filled');
        coefficients = polyfit(amplitude, PVTimesDuration, 1);
        xFit = linspace(0, max(amplitude), 2);
        yFit = polyval(coefficients, xFit);
        plot(xFit, yFit, 'Color', colormap(2, :), 'HandleVisibility', 'off');
        [r, pval] = corr(amplitude, PVTimesDuration);

        grid on;
        legend(sprintf('y = %f * x + %f, R^2 = %f', coefficients(1), coefficients(2), r * r));
        xlabel('Amplitude (deg)');
        ylabel('PV * Duration');
        xline(0, 'HandleVisibility', 'off');
        yline(0, 'HandleVisibility', 'off');
    end
end
%% Saccade timepoint removal of calcium data
if desacCalcium == 1
    eyeVisualSacVector = saccadesVisualMat(:)';
    eyeDarkSacVector = saccadesDarkMat(:)';
    eyeGapSacVector = saccadesGapMat(:)';
    desac = removeAroundCenters(eyeVisualSacVector,shift,windowsize);
    desacDark = removeAroundCenters(eyeDarkSacVector,shift,windowsize);
    desacSp = removeAroundCenters(eyeGapSacVector,shift,windowsize);
    calDesac = calVisualMatOut(:)';
    calDarkDesac = calDarkMatOut(:)';
    calSpDesac = calGapMatOut(:)';
    calDesac(desac) = NaN;
    calDarkDesac(desacDark) = NaN;
    calSpDesac(desacSp) = NaN;
    calVisualMatOut = reshape(calDesac,(1/frequency)*fr,numTimeVisual*frequency*numBlocksVisual);
    calDarkMatOut = reshape(calDarkDesac,(1/frequency)*fr,numTimeDark*frequency*numBlocksDark);
    calGapMatOut = reshape(calSpDesac,(1/frequency)*fr,numTimeGap*frequency*numBlocksGap);
    
    figure('Name','Desaccaded calcium')
    subplot(3,1,1); hold on
    calDarkMatIn = calDarkMatIn';
    plot(calDarkMatIn(:)')
    plot(calDarkMatOut(:)')
    subplot(3,1,2); hold on
    calVisualMatIn = calVisualMatIn';
    plot(calVisualMatIn(:)')
    plot(calVisualMatOut(:)')
    subplot(3,1,3); hold on
    calGapMatIn = calGapMatIn';
    plot(calGapMatIn(:)')
    plot(calGapMatOut(:)')
end

%% Remove data that isn't continuous for minimum amount of time
if protocol ~= 3
    eyeVisualMatOutVector = eyeVisualMatOut(:);
    eyeDarkMatOutVector = eyeDarkMatOut(:);
    eyeGapMatOutVector = eyeGapMatOut(:);
    calVisualMatOutVector = calVisualMatOut(:);
    calDarkMatOutVector = calDarkMatOut(:);
    calGapMatOutVector = calGapMatOut(:);
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
    calTestVisual = calVisualMatOutVector;
    calTestDark = calDarkMatOutVector;
    calTestGap = calGapMatOutVector;

    %% Good segment data lengths
    %%%%%%%%need to take all 3 conditions and make single vector, then do this
%     eyeTestMat = eyeVisualMatOutVector';
%     nanIdx = find(isnan(eyeTestMat));
%     for i = 1:length(eyeTestMat)
%         if isnan(eyeTestMat(i))
%             nanIdx2(i) = 1;
%         else
%             nanIdx2(i) = 0;
%         end
%     end
%     nanIdx3 = diff(nanIdx2);
%     nanIdx4 = find(nanIdx3);
%     if mod(nanIdx5,2)==0
%         nanIdx5 = nanIdx4(1:2:end)';
%         nanIdx5(:,2) = nanIdx4(2:2:end);
%     else
%         nanIdx5 = nanIdx4(1:2:end-1)';
%         nanIdx5(:,2) = nanIdx4(2:2:end-1);
%     end
%     keepIdx = cell(length(nanIdx5)-1,1);
%     keepIdxLength = cell(length(nanIdx5)-1,1);
%     for i = 1:length(nanIdx5)-1
%         keepIdx{i} = eyeTestMat(nanIdx5(i,2):nanIdx5(i+1));
%         keepIdxLength{i} = length(keepIdx{i});
%     end
%     keepIdxLength = cell2mat(keepIdxLength);
%     figure('Name','Length of all good segments'); hold on
%     bar(keepIdxLength)

    %% Remove segments below minimum data threshold
    for ii = 1:length(goodChunkStartsVisual)
        eyeVisualMatOutVector(goodChunkStartsVisual(ii):goodChunkStartsVisual(ii)+keepChunksVisual(ii)-1) = NaN;
        calVisualMatOutVector(goodChunkStartsVisual(ii):goodChunkStartsVisual(ii)+keepChunksVisual(ii)-1) = NaN;
    end
    for ii = 1:length(goodChunkStartsDark)
        eyeDarkMatOutVector(goodChunkStartsDark(ii):goodChunkStartsDark(ii)+keepChunksDark(ii)-1) = NaN;
        calDarkMatOutVector(goodChunkStartsDark(ii):goodChunkStartsDark(ii)+keepChunksDark(ii)-1) = NaN;
    end
    for ii = 1:length(goodChunkStartsGap)
        eyeGapMatOutVector(goodChunkStartsGap(ii):goodChunkStartsGap(ii)+keepChunksGap(ii)-1) = NaN;
        calGapMatOutVector(goodChunkStartsGap(ii):goodChunkStartsGap(ii)+keepChunksGap(ii)-1) = NaN;
    end

    if minDataCheck == 1
        minDataPlot(eyeTestVisual,eyeVisualMatOutVector,eyeTestDark,eyeDarkMatOutVector,eyeTestGap,eyeGapMatOutVector,'Minimum data removal (eye)');
        minDataPlot(calTestVisual,calVisualMatOutVector,calTestDark,calDarkMatOutVector,calTestGap,calGapMatOutVector,'Minimum data removal (calcium)');
    end

    eyeVisualMatOut = reshape(eyeVisualMatOutVector,fr*1/frequency,numTimeVisual*frequency*numBlocksVisual);
    eyeDarkMatOut = reshape(eyeDarkMatOutVector,fr*1/frequency,numTimeDark*frequency*numBlocksDark);
    eyeGapMatOut = reshape(eyeGapMatOutVector,fr*1/frequency,numTimeGap*frequency*numBlocksGap);
    calVisualMatOut = reshape(calVisualMatOutVector,fr*1/frequency,numTimeVisual*frequency*numBlocksVisual);
    calDarkMatOut = reshape(calDarkMatOutVector,fr*1/frequency,numTimeDark*frequency*numBlocksDark);
    calGapMatOut = reshape(calGapMatOutVector,fr*1/frequency,numTimeGap*frequency*numBlocksGap);

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

    %% blocks to keep calculation
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
            calVisualMatOut(:,m:m+numTimeVisual-1) = NaN;
        end
        m = m + numTimeVisual;
    end

    m = 1;
    for i = 1:numBlocksDark
        if blocks2keepDark(i) == 1
            eyeDarkMatOut(:,m:m+numTimeDark-1) = NaN;
            calDarkMatOut(:,m:m+numTimeDark-1) = NaN;
        end
        m = m + numTimeDark;
    end

    m = 1;
    for i = 1:numBlocksGap
        if blocks2keepGap(i) == 1
            eyeGapMatOut(:,m:m+numTimeGap-1) = NaN;
            calGapMatOut(:,m:m+numTimeGap-1) = NaN;
        end
        m = m + numTimeGap;
    end

    %% Calculate average of each block and across whole record for each condition
    turntableDarkBlockAvg = cellfun(@(x) nanmean(x,2),turntableBlockMat(1:numBlocksDark,1),'UniformOutput',false);
    turntableGapBlockAvg = cellfun(@(x) nanmean(x,2),turntableBlockMat(1:numBlocksGap,3),'UniformOutput',false);
    turntablePdarkBlockAvg = cellfun(@(x) nanmean(x,2),turntableBlockMat(1:numBlocksDark,1),'UniformOutput',false);
    turntablePgapBlockAvg = cellfun(@(x) nanmean(x,2),turntablePblockMat(1:numBlocksGap,3),'UniformOutput',false);
    drumVelGapBlockAvg = cellfun(@(x) nanmean(x,2),drumVelBlockMat(1:numBlocksGap,3),'UniformOutput',false);
    drumPgapBlockAvg = cellfun(@(x) nanmean(x,2),drumPblockMat(1:numBlocksGap,3),'UniformOutput',false);

    if condition ~= 4
        turntableVisualBlockAvg = cellfun(@(x) nanmean(x,2),turntableBlockMat(1:numBlocksVisual,2),'UniformOutput',false);
        turntablePvisualBlockAvg = cellfun(@(x) nanmean(x,2),turntablePblockMat(1:numBlocksVisual,2),'UniformOutput',false);
        drumVelVisualBlockAvg = cellfun(@(x) nanmean(x,2),drumVelBlockMat(1:numBlocksVisual,2),'UniformOutput',false);
        drumPvisualBlockAvg = cellfun(@(x) nanmean(x,2),drumPblockMat(1:numBlocksVisual,2),'UniformOutput',false);
    else
        turntableVisualBlockAvg = cellfun(@(x) nanmean(x,2),turntableBlockMat(1:2:numBlocksVisual*2,2),'UniformOutput',false);
        turntablePvisualBlockAvg = cellfun(@(x) nanmean(x,2),turntablePblockMat(1:2:numBlocksVisual*2,2),'UniformOutput',false);
        drumVelVisualBlockAvg = cellfun(@(x) nanmean(x,2),drumVelBlockMat(1:2:numBlocksVisual*2,2),'UniformOutput',false);
        drumPvisualBlockAvg = cellfun(@(x) nanmean(x,2),drumPblockMat(1:2:numBlocksVisual*2,2),'UniformOutput',false);

        turntableVisualBlockAvg2 = cellfun(@(x) nanmean(x,2),turntableBlockMat(2:2:numBlocksVisual*2,2),'UniformOutput',false);
        turntablePvisualBlockAvg2 = cellfun(@(x) nanmean(x,2),turntablePblockMat(2:2:numBlocksVisual*2,2),'UniformOutput',false);
        drumVelVisualBlockAvg2 = cellfun(@(x) nanmean(x,2),drumVelBlockMat(2:2:numBlocksVisual*2,2),'UniformOutput',false);
        drumPvisualBlockAvg2 = cellfun(@(x) nanmean(x,2),drumPblockMat(2:2:numBlocksVisual*2,2),'UniformOutput',false);

        turntableVisualAvg2 = mean(cat(2,turntableVisualBlockAvg2{1:numBlocksVisual}),2);
        turntablePvisualAvg2 = mean(cat(2,turntablePvisualBlockAvg2{1:numBlocksVisual}),2);
        drumVelVisualAvg2 = mean(cat(2,drumVelVisualBlockAvg2{1:numBlocksVisual}),2);
        drumPvisualAvg2 = mean(cat(2,drumPvisualBlockAvg2{1:numBlocksVisual}),2);
    end
    
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
    if condition == 4
        turntableVisualBlockAvgMat(:,numBlocksVisual+1:numBlocksVisual*2) = cat(2,turntableVisualBlockAvg2{1:end});
        drumVelVisualBlockAvgMat(:,numBlocksVisual+1:numBlocksVisual*2) = cat(2,drumVelVisualBlockAvg2{1:end});
    end

    calBlockAmp = NaN(numBlocksMax,numConditions);           %block averaged peak amplitude of fluorescence for visual stim
    calBlockAmpTrough = NaN(numBlocksMax,numConditions);     %block averaged trough amplitude of fluorescence for visual stim
    calBlockAmpIdx = NaN(numBlocksMax,numConditions);        %block averaged peak amplitude of fluorescence for visual stim
    calBlockAmpTroughIdx = NaN(numBlocksMax,numConditions);  %block averaged trough amplitude index of fluorescence for visual stim
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
        calDarkBlockAvg = NaN(fr*(1/frequency),numBlocksDark);
        eyeDarkBlockAvg = NaN(fr*(1/frequency),numBlocksDark);
        eyeSmoothDarkBlockAvg = NaN(fr*(1/frequency),numBlocksDark);
        eyeSacsDarkBlockAvg = NaN(fr*(1/frequency),numBlocksDark);
        t = 1:numTimeDark*frequency;
        while t < size(calDarkMatOut,2)
            for i = 1:numBlocksDark
                calDarkBlockAvg(1:fr*(1/frequency),i) = nanmean(calDarkMatOut(:,t),2)*100;
                eyeDarkBlockAvg(1:fr*(1/frequency),i) = nanmean(eyeDarkMatOut(:,t),2);
                eyeSmoothDarkBlockAvg(1:fr*(1/frequency),i) = nanmean(eyeSmoothDarkMatOut(:,t),2);
                eyeSacsDarkBlockAvg(1:fr*(1/frequency),i) = nanmean(eyeDarkSacs(:,t),2);
                [calBlockAmp(i,1), calBlockAmpIdx(i,1)] = max(calDarkBlockAvg(:,i));
                [calBlockAmpTrough(i,1),calBlockAmpTroughIdx(i,1)] = min(calDarkBlockAvg(:,i));
                calBlockAmp(i,1) = calBlockAmp(i,1) - calBlockAmpTrough(i,1);
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
                    if calBlockAmpIdx(i,1) > nextCycleTime*(1/frequency) + fr*(1/frequency)/2
                        calBlockAmpIdx(i,1) = calBlockAmpIdx(i,1) - fr*(1/frequency);
                    end
                    if calBlockAmpTroughIdx(i,1) < nextCycleTime*(1/frequency)
                        calBlockAmpTroughIdx(i,1) = calBlockAmpTroughIdx(i,1) + fr*(1/frequency);
                    end
                end
                t = t + numTimeDark*frequency;
            end
        end
    else
        calDarkBlockAvg = NaN(fr*(1/frequency),numBlocksDark);
        eyeDarkBlockAvg = NaN(fr*(1/frequency),numBlocksDark);
        eyeSmoothDarkBlockAvg = NaN(fr*(1/frequency),numBlocksDark);
        eyeSacsDarkBlockAvg = NaN(fr*(1/frequency),numBlocksDark);
        t = 1:size(calDarkMatOut,2);
                calDarkBlockAvg(1:fr*(1/frequency),i) = nanmean(calDarkMatOut(:,t),2)*100;
                eyeDarkBlockAvg(1:fr*(1/frequency),i) = nanmean(eyeDarkMatOut(:,t),2);
                eyeSmoothDarkBlockAvg(1:fr*(1/frequency),i) = nanmean(eyeSmoothDarkMatOut(:,t),2);
                eyeSacsDarkBlockAvg(1:fr*(1/frequency),i) = nanmean(eyeDarkSacs(:,t),2);
                [calBlockAmp(i,1), calBlockAmpIdx(i,1)] = max(calDarkBlockAvg(:,i));
                [calBlockAmpTrough(i,1),calBlockAmpTroughIdx(i,1)] = min(calDarkBlockAvg(:,i));
                calBlockAmp(i,1) = calBlockAmp(i,1) - calBlockAmpTrough(i,1);
                [eyeIpsiBlockAmp(i,1),eyeIpsiBlockAmpIdx(i,1)] = max(eyeDarkBlockAvg(:,i));
                [eyeContraBlockAmp(i,1),eyeContraBlockAmpIdx(i,1)] = min(eyeDarkBlockAvg(:,i));
                [headIpsiBlockAmp(i,1),headIpsiBlockAmpIdx(i,1)] = max(turntableDarkAvg(i));
                [headContraBlockAmp(i,1),headContraBlockAmpIdx(i,1)] = min(turntableDarkAvg(i));
                if nextCycleTime ~= 0
                    if eyeIpsiBlockAmpIdx(i,1) > nextCycleTime*(1/frequency) + fr*(1/frequency)/2
                        eyeIpsiBlockAmpIdx(i,1) = eyeIpsiBlockAmpIdx(i,1) - fr*(1/frequency);
                    end
                    if eyeContraBlockAmpIdx(i,1) < nextCycleTime*(1/frequency)
                        eyeContraBlockAmpIdx(i,1) = eyeContraBlockAmpIdx(i,1) + fr*(1/frequency);
                    end
                    if calBlockAmpIdx(i,1) > nextCycleTime*(1/frequency) + fr*(1/frequency)/2
                        calBlockAmpIdx(i,1) = calBlockAmpIdx(i,1) - fr*(1/frequency);
                    end
                    if calBlockAmpTroughIdx(i,1) < nextCycleTime*(1/frequency)
                        calBlockAmpTroughIdx(i,1) = calBlockAmpTroughIdx(i,1) + fr*(1/frequency);
                    end
            end
    end
    calDarkAvg = nanmean(calDarkMatOut,2)*100;
    eyeDarkAvg = nanmean(eyeDarkMatOut,2);
    eyeSmoothDarkAvg = nanmean(eyeSmoothDarkMatOut,2);
    eyeSacsDarkAvg = nanmean(eyeDarkSacs,2);

    [calAmpAvg(1),calAmpIdxAvg(1)] = max(calDarkAvg);
    [calAmpTroughAvg(1),calAmpTroughIdxAvg(1)] = min(calDarkAvg);
    calAmpAvg = calAmpAvg(1) - calAmpTroughAvg(1);
    [eyeIpsiAmpAvg(1),eyeIpsiAmpIdxAvg(1)] = max(eyeDarkAvg);
    [eyeContraAmpAvg(1),eyeContraAmpIdxAvg(1)] = min(eyeDarkAvg);
    if protocol ~= 3
        [headIpsiAmpAvg(1),headIpsiAmpIdxAvg(1)] = max(turntableDarkAvg);
        [headContraAmpAvg(1),headContraAmpIdxAvg(1)] = min(turntableDarkAvg);
    end

    if expSubType ~= 3
        %visual cycle-averaging and amplitude calculations
        rsBlockAmp = NaN(numBlocksVisual,numConditions);
        rsBlockAmpIdx = NaN(numBlocksVisual,numConditions);
        drumIpsiBlockAmp = NaN(numBlocksMax,numConditions);
        drumContraBlockAmp = NaN(numBlocksMax,numConditions);
        drumIpsiBlockAmpIdx = NaN(numBlocksMax,numConditions);
        drumContraBlockAmpIdx = NaN(numBlocksMax,numConditions);
    
        if expSubType ~= 1
            rsSmoothBlockMat = cell(1,numBlocksVisual);
            for i = 1:numBlocksVisual
                rsSmoothBlockMat{i} = drumVelBlockMat{i,2} - (eyeSmoothBlockMat{i,2} + turntableBlockMat{i,2});
            end
            rsDesacMat = cat(2,rsBlockMat{1:numBlocksVisual,2});
            rsSmoothDesacMat = cat(2,rsSmoothBlockMat{1:numBlocksVisual});
            if desacMethod == 0
                rsDesacMat(saccadesVisualMat) = NaN;
                rsSmoothDesacMat(saccadesSmoothVisualMat) = NaN;
            elseif desacMethod == 1
                rsDesacMat(~saccadesVisualMat) = NaN;
                rsSmoothDesacMat(~saccadesSmoothVisualMat) = NaN;
            end
        else
            rsSmoothBlockMat = cell(1,numBlocksVisual);
            rsSmoothBlockMat2 = cell(1,numBlocksVisual);
            for i = 1:2:numBlocksVisual*2
                rsSmoothBlockMat{i} = drumVelBlockMat{i,2} - (eyeSmoothBlockMat{i,2} + turntableBlockMat{i,2});
            end
            for i = 2:2:numBlocksVisual*2
                rsSmoothBlockMat2{i} = drumVelBlockMat{i,2} - (eyeSmoothBlockMat{i,2} + turntableBlockMat{i,2});
            end
            rsDesacMat = cat(2,rsBlockMat{1:2:numBlocksVisual*2,2});
            rsSmoothDesacMat = cat(2,rsSmoothBlockMat{1:2:numBlocksVisual*2});
            rsDesacMat2 = cat(2,rsBlockMat{2:2:numBlocksVisual*2,2});
            rsSmoothDesacMat2 = cat(2,rsSmoothBlockMat2{2:2:numBlocksVisual*2});
            if desacMethod == 0
                rsDesacMat(saccadesVisualMat) = NaN;
                rsSmoothDesacMat(saccadesSmoothVisualMat) = NaN;
            elseif desacMethod == 1
                rsDesacMat(~saccadesVisualMat) = NaN;
                rsSmoothDesacMat(~saccadesSmoothVisualMat) = NaN;
                rsDesacMat2(~saccadesVisualMat2) = NaN;
                rsSmoothDesacMat2(~saccadesSmoothVisualMat2) = NaN;
            end
        end
        
        rsBlockDesac = cell(1,numBlocksVisual);
        a = 1;
        for t = 1:numTimeVisual:size(rsDesacMat,2);
            rsBlockDesac{a} = rsDesacMat(:,t:t+numTimeVisual-1);
            a = a + 1;
        end
        
        rsBlockAvg = cellfun(@(x) nanmean(x,2),rsBlockDesac,'UniformOutput',false);
    
        if condition == 4
            rsBlockDesac2 = cell(1,numBlocksVisual);
            a = 1;
            for t = 1:numTimeVisual:size(rsDesacMat2,2);
                rsBlockDesac2{a} = rsDesacMat2(:,t:t+numTimeVisual-1);
                a = a + 1;
            end

            rsBlockAvg = cellfun(@(x) nanmean(x,2),rsBlockDesac2,'UniformOutput',false);
        end

        calVisualBlockAvg = NaN(fr*(1/frequency),numBlocksVisual);
        eyeVisualBlockAvg = NaN(fr*(1/frequency),numBlocksVisual);
        eyeSmoothVisualBlockAvg = NaN(fr*(1/frequency),numBlocksVisual);
        eyeSacsVisualBlockAvg = NaN(fr*(1/frequency),numBlocksVisual);
        rsVisualBlockAvg = NaN(fr*(1/frequency),numBlocksVisual);
        t = 1:numTimeVisual*frequency;
        while t < size(calVisualMatOut,2)
            for i = 1:numBlocksVisual
                calVisualBlockAvg(1:fr*(1/frequency),i) = nanmean(calVisualMatOut(:,t),2)*100;
                eyeVisualBlockAvg(1:fr*(1/frequency),i) = nanmean(eyeVisualMatOut(:,t),2);
                eyeSmoothVisualBlockAvg(1:fr*(1/frequency),i) = nanmean(eyeSmoothVisualMatOut(:,t),2);
                eyeSacsVisualBlockAvg(1:fr*(1/frequency),i) = nanmean(eyeVisualSacs(:,t),2);
                rsVisualBlockAvg(1:fr*(1/frequency),i) = nanmean(rsDesacMat(:,t),2);
                if condition == 4
                    calVisualBlockAvg(1:fr*(1/frequency),i+3) = nanmean(calVisualMatOut2(:,t),2)*100;
                    eyeVisualBlockAvg(1:fr*(1/frequency),i+3) = nanmean(eyeVisualMatOut2(:,t),2);
                    eyeSmoothVisualBlockAvg(1:fr*(1/frequency),i+3) = nanmean(eyeSmoothVisualMatOut2(:,t),2);
                    eyeSacsVisualBlockAvg(1:fr*(1/frequency),i+3) = nanmean(eyeVisualSacs2(:,t),2);
                    rsVisualBlockAvg(1:fr*(1/frequency),i+3) = nanmean(rsDesacMat2(:,t),2);
                end
                [calBlockAmp(i,2), calBlockAmpIdx(i,2)] = max(calVisualBlockAvg(:,i));
                [calBlockAmpTrough(i,2),calBlockAmpTroughIdx(i,2)] = min(calVisualBlockAvg(:,i));
                calBlockAmp(i,2) = calBlockAmp(i,2) - calBlockAmpTrough(i,2);
                [eyeIpsiBlockAmp(i,2),eyeIpsiBlockAmpIdx(i,2)] = max(eyeVisualBlockAvg(:,i));
                [eyeContraBlockAmp(i,2),eyeContraBlockAmpIdx(i,2)] = min(eyeVisualBlockAvg(:,i));
                if protocol ~= 3
                    [headIpsiBlockAmp(i,2),headIpsiBlockAmpIdx(i,2)] = max(turntableVisualBlockAvg{i});
                    [headContraBlockAmp(i,2),headContraBlockAmpIdx(i,2)] = min(turntableVisualBlockAvg{i});
                end
                [drumIpsiBlockAmp(i,1),drumIpsiBlockAmpIdx(i,1)] = max(drumVelVisualBlockAvg{i});
                [drumContraBlockAmp(i,1),drumContraBlockAmpIdx(i,1)] = min(drumVelVisualBlockAvg{i});
                [rsBlockAmp(i,1),rsBlockAmpIdx(i,1)] = min(rsVisualBlockAvg(:,i));
                if condition == 4
                    [calBlockAmp(i+3,2), calBlockAmpIdx(i+3,2)] = max(calVisualBlockAvg(:,i+3));
                    [calBlockAmpTrough(i+3,2),calBlockAmpTroughIdx(i+3,2)] = min(calVisualBlockAvg(:,i+3));
                    calBlockAmp(i+3,2) = calBlockAmp(i+3,2) - calBlockAmpTrough(i+3,2);
                    [eyeIpsiBlockAmp(i+3,2),eyeIpsiBlockAmpIdx(i+3,2)] = max(eyeVisualBlockAvg(:,i+3));
                    [eyeContraBlockAmp(i+3,2),eyeContraBlockAmpIdx(i+3,2)] = min(eyeVisualBlockAvg(:,i+3));
                    if protocol ~= 3
                        [headIpsiBlockAmp(i+3,2),headIpsiBlockAmpIdx(i+3,2)] = max(turntableVisualBlockAvg2{i});
                        [headContraBlockAmp(i+3,2),headContraBlockAmpIdx(i+3,2)] = min(turntableVisualBlockAvg2{i});
                    end
                    [drumIpsiBlockAmp(i+3,1),drumIpsiBlockAmpIdx(i+3,1)] = max(drumVelVisualBlockAvg2{i});
                    [drumContraBlockAmp(i+3,1),drumContraBlockAmpIdx(i+3,1)] = min(drumVelVisualBlockAvg2{i});
                    [rsBlockAmp(i+3,1),rsBlockAmpIdx(i+3,1)] = min(rsVisualBlockAvg(:,i+3));
                end
                if nextCycleTime ~= 0
                    if condition == 0
                        if eyeIpsiBlockAmpIdx(i,2) > nextCycleTime*(1/frequency) + fr*(1/frequency)/2
                            eyeIpsiBlockAmpIdx(i,2) = eyeIpsiBlockAmpIdx(i,2) - fr*(1/frequency);
                        end
                        if eyeContraBlockAmpIdx(i,2) < nextCycleTime*(1/frequency)
                            eyeContraBlockAmpIdx(i,2) = eyeContraBlockAmpIdx(i,2) + fr*(1/frequency);
                        end
                        if calBlockAmpIdx(i,2) > nextCycleTime*(1/frequency) + fr*(1/frequency)/2
                            calBlockAmpIdx(i,2) = calBlockAmpIdx(i,2) - fr*(1/frequency);
                        end
                        if calBlockAmpTroughIdx(i,2) < nextCycleTime*(1/frequency)
                            calBlockAmpTroughIdx(i,2) = calBlockAmpTroughIdx(i,2) + fr*(1/frequency);
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
                        if calBlockAmpIdx(i,2) < nextCycleTime*(1/frequency)
                            calBlockAmpIdx(i,2) = calBlockAmpIdx(i,2) + fr*(1/frequency);
                        end
                        if calBlockAmpTroughIdx(i,2) > nextCycleTime*(1/frequency) + fr*(1/frequency)/2
                            calBlockAmpTroughIdx(i,2) = calBlockAmpTroughIdx(i,2) - fr*(1/frequency);
                        end
                        if rsBlockAmpIdx(i,1) < nextCycleTime*(1/frequency)
                            rsBlockAmpIdx(i,1) = rsBlockAmpIdx(i,1) + fr*(1/frequency);
                        end
                    end
                end
                t = t + numTimeVisual*frequency;
            end
        end
        calVisualAvg = nanmean(calVisualMatOut,2)*100;
        eyeVisualAvg = nanmean(eyeVisualMatOut,2);
        eyeSmoothVisualAvg = nanmean(eyeSmoothVisualMatOut,2);
        eyeSacsVisualAvg = nanmean(eyeVisualSacs,2);
        rsVisualAvg = nanmean(rsDesacMat,2);

        if condition == 4
            calVisualAvg2 = nanmean(calVisualMatOut2,2)*100;
            eyeVisualAvg2 = nanmean(eyeVisualMatOut2,2);
            eyeSmoothVisualAvg2 = nanmean(eyeSmoothVisualMatOut2,2);
            eyeSacsVisualAvg2 = nanmean(eyeVisualSacs2,2);
            rsVisualAvg2 = nanmean(rsDesacMat2,2);

            [calAmpAvg2(2),calAmpIdxAvg2(2)] = max(calVisualAvg2);
            [calAmpTroughAvg2(2),calAmpTroughIdxAvg2(2)] = min(calVisualAvg2);
            calAmpAvg2(2) = calAmpAvg2(2) - calAmpTroughAvg2(2);
            [eyeIpsiAmpAvg2(2),eyeIpsiAmpIdxAvg2(2)] = max(eyeVisualAvg2);
            [eyeContraAmpAvg2(2),eyeContraAmpIdxAvg2(2)] = min(eyeVisualAvg2);
            if protocol ~= 3
                [headIpsiAmpAvg2(2),headIpsiAmpIdxAvg2(2)] = max(turntableVisualAvg2);
                [headContraAmpAvg2(2),headContraAmpIdxAvg2(2)] = min(turntableVisualAvg2);
            end
            [drumIpsiAmpAvg2(2),drumIpsiAmpIdxAvg2(2)] = max(drumVelVisualAvg2);
            [drumContraAmpAvg2(2),drumContraAmpIdxAvg2(2)] = min(drumVelVisualAvg2);
            [rsAmpAvg2(1),rsAmpIdxAvg2(1)] = min(rsVisualAvg2);
        end

        [calAmpAvg(2),calAmpIdxAvg(2)] = max(calVisualAvg);
        [calAmpTroughAvg(2),calAmpTroughIdxAvg(2)] = min(calVisualAvg);
        calAmpAvg(2) = calAmpAvg(2) - calAmpTroughAvg(2);
        [eyeIpsiAmpAvg(2),eyeIpsiAmpIdxAvg(2)] = max(eyeVisualAvg);
        [eyeContraAmpAvg(2),eyeContraAmpIdxAvg(2)] = min(eyeVisualAvg);
        if protocol ~= 3
            [headIpsiAmpAvg(2),headIpsiAmpIdxAvg(2)] = max(turntableVisualAvg);
            [headContraAmpAvg(2),headContraAmpIdxAvg(2)] = min(turntableVisualAvg);
        end
        [drumIpsiAmpAvg(2),drumIpsiAmpIdxAvg(2)] = max(drumVelVisualAvg);
        [drumContraAmpAvg(2),drumContraAmpIdxAvg(2)] = min(drumVelVisualAvg);
        [rsAmpAvg(1),rsAmpIdxAvg(1)] = min(rsVisualAvg);

        %gap cycle-averaging
        calGapBlockAvg = NaN(fr*(1/frequency),numBlocksGap);
        eyeGapBlockAvg = NaN(fr*(1/frequency),numBlocksGap);
        eyeSmoothGapBlockAvg = NaN(fr*(1/frequency),numBlocksGap);
        eyeSacsGapBlockAvg = NaN(fr*(1/frequency),numBlocksGap);
        t = 1:numTimeGap*frequency;
        while t < size(calGapMatOut,2)
            for i = 1:numBlocksGap
                calGapBlockAvg(1:fr*(1/frequency),i) = nanmean(calGapMatOut(:,t),2)*100;
                eyeGapBlockAvg(1:fr*(1/frequency),i) = nanmean(eyeGapMatOut(:,t),2);
                eyeSmoothGapBlockAvg(1:fr*(1/frequency),i) = nanmean(eyeSmoothGapMatOut(:,t),2);
                eyeSacsGapBlockAvg(1:fr*(1/frequency),i) = nanmean(eyeGapSacs(:,t),2);
                t = t + numTimeGap*frequency;
            end
        end
        calGapAvg = nanmean(calGapMatOut,2)*100;
        eyeGapAvg = nanmean(eyeGapMatOut,2);
        eyeSmoothGapAvg = nanmean(eyeSmoothGapMatOut,2);
        eyeSacsGapAvg = nanmean(eyeGapSacs,2);
    end
    
    if protocol ~= 3 && expSubType ~= 4 && expSubType ~= 3
        turntableDarkMat = cat(2,turntableBlockMat{1:numBlocksDark,1});
        eyeGazeVelDark = eyeDarkMatOut + turntableDarkMat;
        turntableVisualMat = cat(2,turntableBlockMat{1:numBlocksVisual,2});
        eyeGazeVelVisual = eyeVisualMatOut + turntableVisualMat;
        if condition == 4
            turntableVisualMat = cat(2,turntableBlockMat{1:2:numBlocksVisual*2,2});
            turntableVisualMat2 = cat(2,turntableBlockMat{2:2:numBlocksVisual*2,2});
        end

        eyeGazeVelDarkAvg = nanmean(eyeGazeVelDark,2);
        eyeGazeVelVisualAvg = nanmean(eyeGazeVelVisual,2);
        figure('Name','Gaze velocity'); hold on
        plot(eyeGazeVelDarkAvg);
        plot(eyeGazeVelVisualAvg);
        legend('Vestibular-dark','Visual')
        xlabel('Time (ms)')
        ylabel('Gaze velocity')
    elseif condition ~=3
        eyeGazeVelVisual = eyeVisualMatOut;
        eyeGazeVelVisualAvg = nanmean(eyeGazeVelVisual,2);
        figure('Name','Gaze velocity'); hold on
        plot(eyeGazeVelVisualAvg);
        xlabel('Time (ms)')
        ylabel('Gaze velocity')
    elseif condition == 3
        turntableDarkMat = cat(2,turntableBlockMat{1:numBlocksDark,1});
    end
end
%% plotting cycle averages, amplitude, and timing indexes
if expSubType == 0
    if cycAvgPlotting == 1
        cycAvgPlots(calDarkBlockAvg,calDarkAvg,calVisualBlockAvg,calVisualAvg,calGapBlockAvg,calGapAvg,'Calcium block averages');
        cycAvgPlots(eyeDarkBlockAvg,eyeDarkAvg,eyeVisualBlockAvg,eyeVisualAvg,eyeGapBlockAvg,eyeGapAvg,'Eye vel. block averages');
        cycAvgPlots(eyeSmoothDarkBlockAvg,eyeSmoothDarkAvg,eyeSmoothVisualBlockAvg,eyeSmoothVisualAvg,eyeSmoothGapBlockAvg,eyeSmoothGapAvg,'Smoothed eye vel. block averages');
        cycAvgPlots(eyeSacsDarkBlockAvg,eyeSacsDarkAvg,eyeSacsVisualBlockAvg,eyeSacsVisualAvg,eyeSacsGapBlockAvg,eyeSacsGapAvg,'Saccade block averages');
        
        ampIdxPlots(calBlockAmp,calBlockAmpIdx,calBlockAmp,calBlockAmpIdx,numBlocksVisual,'g','Peak calcium amplitude and timing');
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
        if numBlocksVisual > 1
            xticks(1:numBlocksVisual)
            xlim([1 numBlocksVisual])
        else
            xticks(1)
            xlim([0 1])
        end
        subplot(3,1,3); hold on
        m = plot(rsBlockAmpIdx(1:numBlocksVisual,1),'-s','MarkerFaceColor','m');
        m.Color = 'm';
        xlabel('Block number')
        ylabel('Time (ms)')
        title('Peak retinal slip amplitude time for each visual block')
        if numBlocksVisual > 1
            xticks(1:numBlocksVisual)
            xlim([1 numBlocksVisual])
        else
            xticks(1)
            xlim([0 1])
        end
    end
    
elseif expSubType == 1
    %plotting for VOR x2, x0 alternating experiment
    if cycAvgPlotting == 1
        figure('Name','Calcium cycle-averages')
        subplot(3,1,1); hold on
        plot(calDarkBlockAvg)
        plot(calDarkAvg,'Color','k','LineWidth',2)
        ylabel('% \DeltaF/G')
        title('Vestibular-dark calcium responses')
        subplot(3,1,2); hold on
        plot(calVisualBlockAvg(:,1:numBlocksVisual))
        plot(mean(calVisualBlockAvg(:,1:numBlocksVisual),2),'Color','k','LineWidth',2)
        ylabel('% \DeltaF/G')
        xlabel('Time (ms)')
        legend('Block 1','Block 2','Block 3','Gain up avg')
        title('Gain up calcium responses')
        subplot(3,1,3); hold on
        plot(calVisualBlockAvg(:,numBlocksVisual+1:numBlocksVisual*2))
        plot(mean(calVisualBlockAvg(:,numBlocksVisual+1:numBlocksVisual*2),2),'Color','k','LineWidth',2)
        ylabel('% \DeltaF/G')
        xlabel('Time (ms)')
        legend('Block 1','Block 2','Block 3','Gain down avg')
        title('Gain down calcium responses')
        
        figure('Name','Eye vel. cycle-averages')
        subplot(3,1,1); hold on
        plot(eyeDarkBlockAvg)
        plot(eyeDarkAvg,'Color','k','LineWidth',2)
        subplot(3,1,2); hold on
        plot(eyeVisualBlockAvg(:,1:numBlocksVisual))
        plot(mean(eyeVisualBlockAvg(:,1:numBlocksVisual),2),'Color','k','LineWidth',2)
        ylabel('Eye velocity')
        xlabel('Time (ms)')
        legend('Block 1','Block 2','Block 3','Gain up avg')
        title('Gain up eye velocity')
        subplot(3,1,3); hold on
        plot(eyeVisualBlockAvg(:,numBlocksVisual+1:numBlocksVisual*2))
        plot(mean(eyeVisualBlockAvg(:,numBlocksVisual+1:numBlocksVisual*2),2),'Color','k','LineWidth',2)
        ylabel('Eye velocity')
        xlabel('Time (ms)')
        legend('Block 1','Block 2','Block 3','Gain down avg')
        title('Gain down eye velocity')
    end
elseif expSubType == 3
    if cycAvgPlotting == 1
        figure('Name','Calcium cycle-averages'); hold on
        plot(calDarkMatOut*100)
        plot(calDarkAvg,'Color','k','LineWidth',3)
        ylabel('% \DeltaF/G')
        xlabel('Time (ms)')
        title('Vestibular-dark block avg calcium response')
        
        figure('Name','Eye vel. cycle-averages'); hold on
        plot(eyeDarkMatOut)
        plot(eyeDarkAvg,'Color','k','LineWidth',3)
        ylabel('Eye velocity')
        xlabel('Time (ms)')
        title('Vestibular-dark block avg eye vel.')
    end
end

%% Sines-fitting each block and across whole record for each condition
if sinesFitting == 0 && protocol ~= 3
    if expSubType ~= 3
        [calDarkBlockSine,phaseBlockCalDark] = sinesFit(calDarkBlockAvg,fr,frequency,numBlocksDark,0);
        [calVisualBlockSine,phaseBlockCalVisual] = sinesFit(calVisualBlockAvg,fr,frequency,numBlocksVisual,0);
        [eyeDarkBlockSine,phaseBlockEyeDark] = sinesFit(eyeDarkBlockAvg,fr,frequency,numBlocksDark,0);
        [eyeVisualBlockSine,phaseBlockEyeVisual] = sinesFit(eyeVisualBlockAvg,fr,frequency,numBlocksVisual,0);
        [headDarkBlockSine,phaseBlockHeadDark] = sinesFit(turntableDarkBlockAvgMat,fr,frequency,numBlocksDark,0);
        [headVisualBlockSine,phaseBlockHeadVisual] = sinesFit(turntableVisualBlockAvgMat,fr,frequency,numBlocksVisual,0);
        [drumVisualBlockSine,phaseBlockDrumVisual] = sinesFit(drumVelVisualBlockAvgMat,fr,frequency,numBlocksVisual,0);
        [rsBlockSine,phaseBlockRS] = sinesFit(rsVisualBlockAvg,fr,frequency,numBlocksVisual,0);
        if condition == 4
            [calVisualBlockSine,phaseBlockCalVisual] = sinesFit(calVisualBlockAvg(:,1:numBlocksVisual),fr,frequency,numBlocksVisual,0);
            [eyeVisualBlockSine,phaseBlockEyeVisual] = sinesFit(eyeVisualBlockAvg(:,1:numBlocksVisual),fr,frequency,numBlocksVisual,0);
            [headVisualBlockSine,phaseBlockHeadVisual] = sinesFit(turntableVisualBlockAvgMat(:,1:numBlocksVisual),fr,frequency,numBlocksVisual,0);
            [drumVisualBlockSine,phaseBlockDrumVisual] = sinesFit(drumVelVisualBlockAvgMat(:,1:numBlocksVisual),fr,frequency,numBlocksVisual,0);
            [rsBlockSine,phaseBlockRS] = sinesFit(rsVisualBlockAvg(:,1:numBlocksVisual),fr,frequency,numBlocksVisual,0);
            [calVisualBlockSine2,phaseBlockCalVisual2] = sinesFit(calVisualBlockAvg(:,numBlocksVisual+1:numBlocksVisual*2),fr,frequency,numBlocksVisual,0);
            [eyeVisualBlockSine2,phaseBlockEyeVisual2] = sinesFit(eyeVisualBlockAvg(:,numBlocksVisual+1:numBlocksVisual*2),fr,frequency,numBlocksVisual,0);
            [headVisualBlockSine2,phaseBlockHeadVisual2] = sinesFit(turntableVisualBlockAvgMat(:,numBlocksVisual+1:numBlocksVisual*2),fr,frequency,numBlocksVisual,0);
            [drumVisualBlockSine2,phaseBlockDrumVisual2] = sinesFit(drumVelVisualBlockAvgMat(:,numBlocksVisual+1:numBlocksVisual*2),fr,frequency,numBlocksVisual,0);
            [rsBlockSine2,phaseBlockRS2] = sinesFit(rsVisualBlockAvg(:,numBlocksVisual+1:numBlocksVisual*2),fr,frequency,numBlocksVisual,0);
        end
        calSineBlockAmp = NaN(numBlocksMax,numConditions);
        calSineBlockAmpTrough = NaN(numBlocksMax,numConditions);
        calSineBlockAmpIdx = NaN(numBlocksMax,numConditions);
        calSineBlockAmpTroughIdx = NaN(numBlocksMax,numConditions);
        eyeIpsiSineBlockAmp = NaN(numBlocksMax,numConditions);
        eyeIpsiSineBlockAmpIdx = NaN(numBlocksMax,numConditions);
        eyeContraSineBlockAmp = NaN(numBlocksMax,numConditions);
        eyeContraSineBlockAmpIdx = NaN(numBlocksMax,numConditions);
        headIpsiSineBlockAmp = NaN(numBlocksMax,numConditions);
        headIpsiSineBlockAmpIdx = NaN(numBlocksMax,numConditions);
        headContraSineBlockAmp = NaN(numBlocksMax,numConditions);
        headContraSineBlockAmpIdx = NaN(numBlocksMax,numConditions);

        for i = 1:numBlocksDark
            [calSineBlockAmp(i,1),calSineBlockAmpIdx(i,1)] = max(calDarkBlockSine{i});
            [calSineBlockAmpTrough(i,1),calSineBlockAmpTroughIdx(i,1)] = min(calDarkBlockSine{i});
            calSineBlockAmp(i,1) = calSineBlockAmp(i,1) - calSineBlockAmpTrough(i);
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
                if calSineBlockAmpIdx(i,1) > nextCycleTime*(1/frequency) + fr*(1/frequency)/2
                    calSineBlockAmpIdx(i,1) = calSineBlockAmpIdx(i,1) - fr*(1/frequency);
                end
                if calSineBlockAmpTroughIdx(i,1) < nextCycleTime*(1/frequency)
                    calSineBlockAmpTroughIdx(i,1) = calSineBlockAmpTroughIdx(i,1) + fr*(1/frequency);
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
            [calSineBlockAmp(i,2),calSineBlockAmpIdx(i,2)] = max(calVisualBlockSine{i});
            [calSineBlockAmpTrough(i,2),calSineBlockAmpTroughIdx(i,2)] = min(calVisualBlockSine{i});
            calSineBlockAmp(i,2) = calSineBlockAmp(i,2) - calSineBlockAmpTrough(i,2);
            [eyeIpsiSineBlockAmp(i,2),eyeIpsiSineBlockAmpIdx(i,2)] = max(eyeVisualBlockSine{i});
            [eyeContraSineBlockAmp(i,2),eyeContraSineBlockAmpIdx(i,2)] = min(eyeVisualBlockSine{i});
            [headIpsiSineBlockAmp(i,2),headIpsiSineBlockAmpIdx(i,2)] = max(headVisualBlockSine{i});
            [headContraSineBlockAmp(i,2),headContraSineBlockAmpIdx(i,2)] = min(headVisualBlockSine{i});
            [drumIpsiSineBlockAmp(i,1),drumIpsiSineBlockAmpIdx(i,1)] = max(drumVisualBlockSine{i});
            [drumContraSineBlockAmp(i,1),drumContraSineBlockAmpIdx(i,1)] = min(drumVisualBlockSine{i});
            [rsSineBlockAmp(i,1),rsSineBlockAmpIdx(i,1)] = min(rsBlockSine{i});
            if condition == 4
                [calSineBlockAmp(i+3,2),calSineBlockAmpIdx(i+3,2)] = max(calVisualBlockSine2{i});
                [calSineBlockAmpTrough(i+3,2),calSineBlockAmpTroughIdx(i+3,2)] = min(calVisualBlockSine2{i});
                calSineBlockAmp(i+3,2) = calSineBlockAmp(i+3,2) - calSineBlockAmpTrough(i+3,2);
                [eyeIpsiSineBlockAmp(i+3,2),eyeIpsiSineBlockAmpIdx(i+3,2)] = max(eyeVisualBlockSine2{i});
                [eyeContraSineBlockAmp(i+3,2),eyeContraSineBlockAmpIdx(i+3,2)] = min(eyeVisualBlockSine2{i});
                [headIpsiSineBlockAmp(i+3,2),headIpsiSineBlockAmpIdx(i+3,2)] = max(headVisualBlockSine2{i});
                [headContraSineBlockAmp(i+3,2),headContraSineBlockAmpIdx(i+3,2)] = min(headVisualBlockSine2{i});
                [drumIpsiSineBlockAmp(i+3,1),drumIpsiSineBlockAmpIdx(i+3,1)] = max(drumVisualBlockSine2{i});
                [drumContraSineBlockAmp(i+3,1),drumContraSineBlockAmpIdx(i+3,1)] = min(drumVisualBlockSine2{i});
                [rsSineBlockAmp(i+3,1),rsSineBlockAmpIdx(i+3,1)] = min(rsBlockSine2{i});
            end
            if nextCycleTime ~= 0
                if condition == 0
                    if eyeIpsiSineBlockAmpIdx(i,2) > nextCycleTime*(1/frequency) + fr*(1/frequency)/2
                        eyeIpsiSineBlockAmpIdx(i,2) = eyeIpsiSineBlockAmpIdx(i,2) - fr*(1/frequency);
                    end
                    if eyeContraSineBlockAmpIdx(i,2) < nextCycleTime*(1/frequency)
                        eyeContraSineBlockAmpIdx(i,2) = eyeContraSineBlockAmpIdx(i,2) + fr*(1/frequency);
                    end
                    if calSineBlockAmpIdx(i,2) > nextCycleTime*(1/frequency) + fr*(1/frequency)/2
                        calSineBlockAmpIdx(i,2) = calSineBlockAmpIdx(i,2) - fr*(1/frequency);
                    end
                    if calSineBlockAmpTroughIdx(i,2) < nextCycleTime*(1/frequency)
                        calSineBlockAmpTroughIdx(i,2) = calSineBlockAmpTroughIdx(i,2) + fr*(1/frequency);
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
                    if calSineBlockAmpIdx(i,2) < nextCycleTime*(1/frequency)
                        calSineBlockAmpIdx(i,2) = calSineBlockAmpIdx(i,2) + fr*(1/frequency);
                    end
                    if calSineBlockAmpTroughIdx(i,2) > nextCycleTime*(1/frequency) + fr*(1/frequency)/2
                        calSineBlockAmpTroughIdx(i,2) = calSineBlockAmpTroughIdx(i,2) - fr*(1/frequency);
                    end
                    if rsSineBlockAmpIdx(i,1) < nextCycleTime*(1/frequency)
                        rsSineBlockAmpIdx(i,1) = rsSineBlockAmpIdx(i,1) + fr*(1/frequency);
                    end
                end
            end
        end
        
        [rsSine,phaseRS] = sinesFit(rsVisualAvg,fr,frequency,numBlocksVisual,1);
        [drumVisualSine,phaseDrumVisual] = sinesFit(drumVelVisualAvg,fr,frequency,numBlocksVisual,1);
        
        [rsSineAmpAvg,rsSineAmpAvgIdx] = min(rsSine(1,:));
        [drumIpsiSineAmpAvg,drumIpsiSineAmpAvgIdx] = max(drumVisualSine(1,:));
        [drumContraSineAmpAvg,drumContraSineAmpAvgIdx] = min(drumVisualSine(1,:));
        
        [calVisualSine,phaseCalVisual] = sinesFit(calVisualAvg,fr,frequency,numBlocksVisual,1);
        [eyeVisualSine,phaseEyeVisual] = sinesFit(eyeVisualAvg,fr,frequency,numBlocksVisual,1);
        [headVisualSine,phaseHeadVisual] = sinesFit(turntableVisualAvg,fr,frequency,numBlocksVisual,1);
        if condition == 4
            [rsSine2,phaseRS2] = sinesFit(rsVisualAvg2,fr,frequency,numBlocksVisual,1);
            [drumVisualSine2,phaseDrumVisual2] = sinesFit(drumVelVisualAvg2,fr,frequency,numBlocksVisual,1);

            [rsSineAmpAvg2,rsSineAmpAvgIdx2] = min(rsSine2(1,:));
            [drumIpsiSineAmpAvg2,drumIpsiSineAmpAvgIdx2] = max(drumVisualSine2(1,:));
            [drumContraSineAmpAvg2,drumContraSineAmpAvgIdx2] = min(drumVisualSine2(1,:));

            [calVisualSine2,phaseCalVisual2] = sinesFit(calVisualAvg2,fr,frequency,numBlocksVisual,1);
            [eyeVisualSine2,phaseEyeVisual2] = sinesFit(eyeVisualAvg2,fr,frequency,numBlocksVisual,1);
            [headVisualSine2,phaseHeadVisual2] = sinesFit(turntableVisualAvg2,fr,frequency,numBlocksVisual,1);
        end
    end
    
    [calDarkSine,phaseCalDark] = sinesFit(calDarkAvg,fr,frequency,numBlocksDark,1);
    [eyeDarkSine,phaseEyeDark] = sinesFit(eyeDarkAvg,fr,frequency,numBlocksDark,1);
    [headDarkSine,phaseHeadDark] = sinesFit(turntableDarkAvg,fr,frequency,numBlocksDark,1);
    
    [calSineAmpAvg,calSineAmpIdxAvg] = max(calDarkSine);
    calSineAmpAvg = 2*calSineAmpAvg;
    [eyeIpsiSineAmpAvg,eyeIpsiSineAmpIdxAvg] = max(eyeDarkSine(1,:));
    [eyeContraSineAmpAvg,eyeContraSineAmpIdxAvg] = min(eyeDarkSine(1,:));
    [headIpsiSineAmpAvg,headIpsiSineAmpIdxAvg] = max(headDarkSine(1,:));
    [headContraSineAmpAvg,headContraSineAmpIdxAvg] = min(headDarkSine(1,:));
    
    if expSubType ~= 3
        [calSineAmpAvg(2,:),calSineAmpIdxAvg(2,:)] = max(calVisualSine);
        [eyeIpsiSineAmpAvg(2,:),eyeIpsiSineAmpIdxAvg(2,:)] = max(eyeVisualSine);
        [eyeContraSineAmpAvg(2,:),eyeContraSineAmpIdxAvg(2,:)] = min(eyeVisualSine);
        [headIpsiSineAmpAvg(2,:),headIpsiSineAmpIdxAvg(2,:)] = max(headVisualSine);
        [headContraSineAmpAvg(2,:),headContraSineAmpIdxAvg(2,:)] = min(headVisualSine);

        if condition == 4
            [calSineAmpAvg2(2,:),calSineAmpIdxAvg2(2,:)] = max(calVisualSine2);
            [eyeIpsiSineAmpAvg2(2,:),eyeIpsiSineAmpIdxAvg2(2,:)] = max(eyeVisualSine2);
            [eyeContraSineAmpAvg2(2,:),eyeContraSineAmpIdxAvg2(2,:)] = min(eyeVisualSine2);
            [headIpsiSineAmpAvg2(2,:),headIpsiSineAmpIdxAvg2(2,:)] = max(headVisualSine2);
            [headContraSineAmpAvg2(2,:),headContraSineAmpIdxAvg2(2,:)] = min(headVisualSine2);
        end

        if sinesFitPlots == 1
            cycAvgPlots(calDarkBlockSine,calDarkSine,calVisualBlockSine,calVisualSine,calDarkBlockSine,calDarkSine,'Sines-fitted calcium block averages');
            cycAvgPlots(eyeDarkBlockSine,eyeDarkSine,eyeVisualBlockSine,eyeVisualSine,eyeDarkBlockSine,eyeDarkSine,'Sines-fitted eye vel. block averages');
            cycAvgPlots(headDarkBlockSine,headDarkSine,headVisualBlockSine,headVisualSine,headVisualBlockSine,headVisualSine,'Sines-fitted head vel. block averages');
            if condition == 4
                cycAvgPlots(calDarkBlockSine,calDarkSine,calVisualBlockSine2,calVisualSine2,calDarkBlockSine,calDarkSine,'Sines-fitted calcium block averages');
                cycAvgPlots(eyeDarkBlockSine,eyeDarkSine,eyeVisualBlockSine2,2,eyeDarkBlockSine,eyeDarkSine,'Sines-fitted eye vel. block averages');
                cycAvgPlots(headDarkBlockSine,headDarkSine,headVisualBlockSine2,headVisualSine2,headVisualBlockSine2,headVisualSine2,'Sines-fitted head vel. block averages');
            end
            if condition ~= 4
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
            else
                figure('Name','Retinal slip (sines-fitted)')
                subplot(3,2,1); hold on
                for i = 1:numBlocksVisual
                    plot(rsBlockSine{i})
                end
                plot(rsSine(1,:),'Color','k','LineWidth',2)
                xlabel('Time (ms)')
                ylabel('Amplitude')
                title('Retinal slip vel. block averages')

                subplot(3,2,3); hold on
                m = plot(rsSineBlockAmp(1:numBlocksVisual,1),'-s','MarkerFaceColor','m');
                m.Color = 'm';
                xlabel('Block number')
                ylabel('Amplitude')
                title('Peak retinal slip amplitude for each visual block')
                xticklabels(1:numBlocksVisual)
                xticks(1:numBlocksVisual)

                subplot(3,2,5); hold on
                m = plot(rsSineBlockAmpIdx(1:numBlocksVisual,1),'-s','MarkerFaceColor','m');
                m.Color = 'm';
                xlabel('Block number')
                ylabel('Time (ms)')
                title('Peak retinal slip amplitude time for each visual block')
                xticklabels(1:numBlocksVisual)
                xticks(1:numBlocksVisual)

                subplot(3,2,2); hold on
                for i = 1:numBlocksVisual
                    plot(rsBlockSine2{i})
                end
                plot(rsSine2(1,:),'Color','k','LineWidth',2)
                xlabel('Time (ms)')
                ylabel('Amplitude')
                title('Retinal slip vel. block averages')

                subplot(3,2,4); hold on
                m = plot(rsSineBlockAmp(numBlocksVisual+1:numBlocksVisual*2,1),'-s','MarkerFaceColor','m');
                m.Color = 'm';
                xlabel('Block number')
                ylabel('Amplitude')
                title('Peak retinal slip amplitude for each visual block')
                xticklabels(1:numBlocksVisual)
                xticks(1:numBlocksVisual)

                subplot(3,2,6); hold on
                m = plot(rsSineBlockAmpIdx(numBlocksVisual+1:numBlocksVisual*2,1),'-s','MarkerFaceColor','m');
                m.Color = 'm';
                xlabel('Block number')
                ylabel('Time (ms)')
                title('Peak retinal slip amplitude time for each visual block')
                xticklabels(1:numBlocksVisual)
                xticks(1:numBlocksVisual)
            end
            
            figure('Name','Block-averaged drum vel.'); hold on
            for i = 1:numBlocksVisual
                plot(drumVisualBlockSine{i,1})
            end
            plot(drumVisualSine(1,:),'Color','k','LineWidth',2)
            xlabel('Time (ms)')
            ylabel('Amplitude')

            if condition == 4
                figure('Name','Block-averaged drum vel.'); hold on
                for i = 1:numBlocksVisual
                    plot(drumVisualBlockSine2{i,1})
                end
                plot(drumVisualSine2(1,:),'Color','k','LineWidth',2)
                xlabel('Time (ms)')
                ylabel('Amplitude')
            end

            ampIdxPlots(calSineBlockAmp,calSineBlockAmpIdx,calSineBlockAmp,calSineBlockAmpIdx,numBlocksVisual,'g','Peak calcium amplitude and timing');
            ampIdxPlots(eyeIpsiSineBlockAmp,eyeIpsiSineBlockAmpIdx,eyeIpsiSineBlockAmp,eyeIpsiSineBlockAmpIdx,numBlocksVisual,'r','Peak ipsi eye amplitude and timing');
            ampIdxPlots(eyeContraSineBlockAmp,eyeContraSineBlockAmpIdx,eyeContraSineBlockAmp,eyeContraSineBlockAmpIdx,numBlocksVisual,'r','Peak contra eye amplitude and timing');
            ampIdxPlots(headIpsiBlockAmp,headIpsiBlockAmpIdx,headIpsiBlockAmp,headIpsiBlockAmpIdx,numBlocksVisual,'b','Peak ipsi head (sines-fitted) amplitude and timing');
            ampIdxPlots(headContraBlockAmp,headContraBlockAmpIdx,headContraBlockAmp,headContraBlockAmpIdx,numBlocksVisual,'b','Peak contra head (sines-fitted) amplitude and timing');
            
            if condition == 4
                ampIdxPlots(calSineBlockAmp,calSineBlockAmpIdx,calSineBlockAmp(numBlocksVisual+1:numBlocksVisual*2,:),calSineBlockAmpIdx(numBlocksVisual+1:numBlocksVisual*2,:),numBlocksVisual,'g','Peak calcium amplitude and timing');
                ampIdxPlots(eyeIpsiSineBlockAmp,eyeIpsiSineBlockAmpIdx,eyeIpsiSineBlockAmp(numBlocksVisual+1:numBlocksVisual*2,:),eyeIpsiSineBlockAmpIdx(numBlocksVisual+1:numBlocksVisual*2,:),numBlocksVisual,'r','Peak ipsi eye amplitude and timing');
                ampIdxPlots(eyeContraSineBlockAmp,eyeContraSineBlockAmpIdx,eyeContraSineBlockAmp(numBlocksVisual+1:numBlocksVisual*2,:),eyeContraSineBlockAmpIdx(numBlocksVisual+1:numBlocksVisual*2,:),numBlocksVisual,'r','Peak contra eye amplitude and timing');
                ampIdxPlots(headIpsiBlockAmp,headIpsiBlockAmpIdx,headIpsiBlockAmp(numBlocksVisual+1:numBlocksVisual*2,:),headIpsiBlockAmpIdx(numBlocksVisual+1:numBlocksVisual*2,:),numBlocksVisual,'b','Peak ipsi head (sines-fitted) amplitude and timing');
                ampIdxPlots(headContraBlockAmp,headContraBlockAmpIdx,headContraBlockAmp(numBlocksVisual+1:numBlocksVisual*2,:),headContraBlockAmpIdx(numBlocksVisual+1:numBlocksVisual*2,:),numBlocksVisual,'b','Peak contra head (sines-fitted) amplitude and timing');
            end
        end
    else
        figure('Name','Calcium cycle-average sines-fitted'); hold on
        plot(calDarkSine,'Color','k','LineWidth',2)
        ylabel('% \DeltaF/G')
        xlabel('Time (ms)')
        title('Vestibular-dark block avg calcium response')
        
        figure('Name','Eye vel. cycle-average sines-fitted'); hold on
        plot(eyeDarkSine,'Color','k','LineWidth',2)
        ylabel('Eye vel.')
        xlabel('Time (ms)')
        title('Vestibular-dark block avg eye response')
    end
end

%%Gain calculations
if expSubType ~= 3 && protocol ~= 3
    if protocol ~= 2 && condition ~= 2
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
        eyeIpsiGainPct(round(numBlocksDark/2)+1,1) = ((eyeIpsiGainPost / eyeIpsiGainPre)-1) * 100;
        eyeContraGainPct(round(numBlocksDark/2)+1,1) = ((eyeContraGainPost / eyeContraGainPre)-1) * 100;
        eyeIpsiGainPct(round(numBlocksDark/2)+1,3) = ((eyeIpsiGainPost(2) / eyeIpsiGainPre(2))-1) * 100;
        eyeContraGainPct(round(numBlocksDark/2)+1,3) = ((eyeContraGainPost(2) / eyeContraGainPre(2))-1) * 100;
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
    if expSubType ~= 1 && (condition == 0 || condition == 1)
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
    elseif expSubType == 1
        for i = 1:numBlocksVisual
            eyeIpsiGain(i,2) = eyeIpsiBlockAmp(i,2) / abs(headContraBlockAmp(i,2));
            eyeContraGain(i,2) = abs(eyeContraBlockAmp(i,2)) / headIpsiBlockAmp(i,2);
            eyeIpsiGain(i,4) = eyeIpsiSineBlockAmp(i,2) / abs(headContraSineBlockAmp(i,2));
            eyeContraGain(i,4) = abs(eyeContraSineBlockAmp(i,2)) / headIpsiSineBlockAmp(i,2);
        end

        for i = numBlocksVisual+1:numBlocksVisual*2
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

        for i = numBlocksVisual+1:numBlocksVisual*2
            eyeIpsiGainPct(i,2) = ((eyeIpsiGain(i,2) / eyeIpsiGain(numBlocksVisual+1,2))-1) * 100;
            eyeContraGainPct(i,2) = ((eyeContraGain(i,2) / eyeContraGain(numBlocksVisual+1,2))-1) * 100;
            eyeIpsiGainPct(i,4) = ((eyeIpsiGain(i,4) / eyeIpsiGain(numBlocksVisual+1,4))-1) * 100;
            eyeContraGainPct(i,4) = ((eyeContraGain(i,4) / eyeContraGain(numBlocksVisual+1,4))-1) * 100;
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
    calBlockRadians(1,1:numBlocksDark) = deg2rad(phaseBlockCalDark);
    calRadians(1) = deg2rad(phaseCalDark);
    eyeBlockRadians(1,1:numBlocksDark) = deg2rad(phaseBlockEyeDark);
    eyeRadians(1) = deg2rad(phaseEyeDark);
    headBlockRadians(1,1:numBlocksDark) = deg2rad(phaseBlockHeadDark);
    headRadians(1) = deg2rad(phaseHeadDark);
    
    eyePhaseReHeadDark = (phaseEyeDark - phaseHeadDark);
    eyePhaseReHeadDark = mod(eyePhaseReHeadDark,360) - 180;
    calPhaseReHeadDark = (phaseCalDark - phaseHeadDark);
    calPhaseReHeadDark = mod(calPhaseReHeadDark,360) - 180;
    calPhaseReEyeDark = (phaseCalDark - (phaseEyeDark+180));
    calPhaseReEyeDark = mod(calPhaseReEyeDark,360) - 180;
    
    calBlockRadians(2,1:numBlocksVisual) = deg2rad(phaseBlockCalVisual);
    calRadians(2) = deg2rad(phaseCalVisual);
    eyeBlockRadians(2,1:numBlocksVisual) = deg2rad(phaseBlockEyeVisual);
    eyeRadians(2) = deg2rad(phaseEyeVisual);
    headBlockRadians(2,1:numBlocksVisual) = deg2rad(phaseBlockHeadVisual);
    headRadians(2) = deg2rad(phaseHeadVisual);
    rsBlockRadians(2,1:numBlocksVisual) = deg2rad(phaseBlockRS);
    rsRadians = deg2rad(phaseRS);

    eyePhaseReHeadVisual = (phaseEyeVisual - phaseHeadVisual);
    eyePhaseReHeadVisual = mod(eyePhaseReHeadVisual,360) - 180;
    calPhaseReRS = (phaseCalVisual - phaseRS);
    calPhaseReRS = mod(calPhaseReRS,360) - 180;
    if condition == 0
        calPhaseReHeadVisual = (phaseCalVisual - (phaseHeadVisual));
        calPhaseReHeadVisual = mod(calPhaseReHeadVisual,360) - 180;
        calPhaseReEyeVisual = (phaseCalVisual - phaseEyeVisual+180);
        calPhaseReEyeVisual = mod(calPhaseReEyeVisual,360) - 180;
        rsPhaseReEye = (phaseRS - phaseEyeVisual);
        rsPhaseReEye = mod(rsPhaseReEye,360) - 180;
        rsPhaseReHead = (phaseRS - phaseHeadVisual+180);
        rsPhaseReHead = mod(rsPhaseReHead,360) - 180;
    elseif condition == 1 || condition == 2
        calPhaseReHeadVisual = (phaseCalVisual - (phaseHeadVisual+180));
        calPhaseReHeadVisual = mod(calPhaseReHeadVisual,360) - 180;
        calPhaseReEyeVisual = (phaseCalVisual - phaseEyeVisual);
        calPhaseReEyeVisual = mod(calPhaseReEyeVisual,360) - 180;
        rsPhaseReEye = (phaseRS - (phaseEyeVisual+180));
        rsPhaseReEye = mod(rsPhaseReEye,360) - 180;
        rsPhaseReHead = (phaseRS - phaseHeadVisual);
        rsPhaseReHead = mod(rsPhaseReHead,360) - 180;
    end

    if phasePlots == 1 && expSubType ~= 1
        figure('Name','Polar plots')
        subplot(2,4,[1,4])
        a = polarscatter(calBlockRadians(1,1:numBlocksDark),calBlockAmp(1:numBlocksDark,1)); hold on
        a.MarkerEdgeColor = 'g';
        aa = polarscatter(calRadians(1),calAmpAvg(1),'filled');
        aa.MarkerFaceColor = 'k';
        b = polarscatter(eyeBlockRadians(1,1:numBlocksDark),eyeIpsiBlockAmp(1:numBlocksDark,1));
        b.MarkerEdgeColor = 'r';
        ba = polarscatter(eyeRadians(1),eyeIpsiAmpAvg(1),'filled');
        ba.MarkerFaceColor = 'k';
        if protocol ~= 3
            c = polarscatter(headBlockRadians(1,1:numBlocksDark),headContraBlockAmp(1:numBlocksDark,1));
            c.MarkerEdgeColor = [0 0.4470 0.7410];
            ca = polarscatter(headRadians(1),headContraAmpAvg(1),'filled');
            ca.MarkerFaceColor = 'k';
        end
        legend('Calcium phase(blocks)','','Eye vel. phase (blocks)','','Head vel. phase (blocks)','Population Averages')
        title('Cycle average phases','Vestibular-dark')

        subplot(2,4,[5,8])
        a = polarscatter(calBlockRadians(2,1:numBlocksVisual),calBlockAmp(1:numBlocksVisual,2)); hold on
        a.MarkerEdgeColor = 'g';
        a = polarscatter(calRadians(2),calAmpAvg(2),'filled');
        a.MarkerFaceColor = 'k';
        if condition == 0
            b = polarscatter(eyeBlockRadians(2,1:numBlocksVisual),eyeIpsiBlockAmp(1:numBlocksVisual,2));
            b.MarkerEdgeColor = 'r';
            ba = polarscatter(eyeRadians(2),eyeIpsiAmpAvg(2),'filled');
            ba.MarkerFaceColor = 'k';
            c = polarscatter(headBlockRadians(2,1:numBlocksVisual),headContraBlockAmp(1:numBlocksVisual,2));
            c.MarkerEdgeColor = [0 0.4470 0.7410];
            ca = polarscatter(headRadians(2),headContraAmpAvg(2),'filled');
            ca.MarkerFaceColor = 'k';
        elseif condition == 1 
            b = polarscatter(eyeBlockRadians(2,1:numBlocksVisual),eyeContraBlockAmp(1:numBlocksVisual,2));
            b.MarkerEdgeColor = 'r';
            ba = polarscatter(eyeRadians(2),eyeContraAmpAvg(2),'filled');
            ba.MarkerFaceColor = 'k';
            c = polarscatter(headBlockRadians(2,1:numBlocksVisual),headIpsiBlockAmp(1:numBlocksVisual,2));
            c.MarkerEdgeColor = [0 0.4470 0.7410];
            ca = polarscatter(headRadians(2),headIpsiAmpAvg(2),'filled');
            ca.MarkerFaceColor = 'k';
        elseif condition == 2
            b = polarscatter(eyeBlockRadians(2,1:numBlocksVisual),eyeContraBlockAmp(1:numBlocksVisual,2));
            b.MarkerEdgeColor = 'r';
            ba = polarscatter(eyeRadians(2),eyeContraAmpAvg(2),'filled');
            ba.MarkerFaceColor = 'k';
        end
        d = polarscatter(rsBlockRadians(1,1:numBlocksVisual),rsBlockAmp(:,1));
        d.MarkerEdgeColor = 'm';
        da = polarscatter(rsRadians(1),rsAmpAvg(1),'filled');
        da.MarkerFaceColor = 'k';
        legend('Calcium phase (blocks)','','Eye vel. phase (blocks)','','Head vel. phase (blocks)','','Retinal slip phase (blocks)','Population Averages')
        title('Visual')
    end
end

%% sriramOKRmodAlex expt
if expSubType == 2
%     [randSortReshape,conditionIdxs] = randBlockSort(dataRand,numBlocksVisual,numFreq,numTestPerFreq);
%     % Eye sorting for multiple frequency experiment
    saccadesVisualMat05 = saccadesVisualMat05';
    saccadesVisualMat1 = saccadesVisualMat1';
    saccadesVisualMat2 = saccadesVisualMat2';
    saccadesVisualMat4 = saccadesVisualMat4';
    saccadesVisualMat5 = saccadesVisualMat5';
    saccadesVisualMat10 = saccadesVisualMat10';
    rsMatIn05(~saccadesVisualMat05) = NaN;
    rsMatIn1(~saccadesVisualMat1) = NaN;
    rsMatIn2(~saccadesVisualMat2) = NaN;
    rsMatIn4(~saccadesVisualMat4) = NaN;
    rsMatIn5(~saccadesVisualMat5) = NaN;
    rsMatIn10(~saccadesVisualMat10) = NaN;

    calVisualCell = cell(numTestPerFreq,6);
    eyeVisualCell = cell(numTestPerFreq,6);
    rsCell = cell(numTestPerFreq,6);
    w = 1;
    t = 1;
    m = 1;
    n = 1;
    p = 1;
    q = 1;
    for k = 1:numTestPerFreq
        calVisualCell{k} = calVisualMatOut05(:,w:w+(numTimeVisual*freq(1))-1);
        eyeVisualCell{k} = eyeVisualMatOut05(:,w:w+(numTimeVisual*freq(1))-1);
        rsCell{k} = rsMatIn05(w:w+(numTimeVisual*freq(1))-1,:);
        w = w + (numTimeVisual*freq(1));
        
        calVisualCell{k,2} = calVisualMatOut1(:,t:t+(numTimeVisual*freq(2))-1);
        eyeVisualCell{k,2} = eyeVisualMatOut1(:,t:t+(numTimeVisual*freq(2))-1);
        rsCell{k,2} = rsMatIn1(t:t+(numTimeVisual*freq(2))-1,:);
        t = t + (numTimeVisual*freq(2));
        
        calVisualCell{k,3} = calVisualMatOut2(:,m:m+(numTimeVisual*freq(3))-1);
        eyeVisualCell{k,3} = eyeVisualMatOut2(:,m:m+(numTimeVisual*freq(3))-1);
        rsCell{k,3} = rsMatIn2(m:m+(numTimeVisual*freq(3))-1,:);
        m = m + (numTimeVisual*freq(3));
        
        calVisualCell{k,4} = calVisualMatOut4(:,n:n+(numTimeVisual*freq(4))-1);
        eyeVisualCell{k,4} = eyeVisualMatOut4(:,n:n+(numTimeVisual*freq(4))-1);
        rsCell{k,4} = rsMatIn4(n:n+(numTimeVisual*freq(4))-1,:);
        n = n + (numTimeVisual*freq(4));
        
        calVisualCell{k,5} = calVisualMatOut5(:,p:p+(numTimeVisual*freq(5))-1);
        eyeVisualCell{k,5} = eyeVisualMatOut5(:,p:p+(numTimeVisual*freq(5))-1);
        rsCell{k,5} = rsMatIn05(p:p+(numTimeVisual*freq(5))-1,:);
        p = p + (numTimeVisual*freq(5));
        
        calVisualCell{k,6} = calVisualMatOut10(:,q:q+(numTimeVisual*freq(6))-1);
        eyeVisualCell{k,6} = eyeVisualMatOut10(:,q:q+(numTimeVisual*freq(6))-1);
        rsCell{k,6} = rsMatIn05(q:q+(numTimeVisual*freq(6))-1,:);
        q = q + (numTimeVisual*freq(6));
    end
    
    calVisualCell{4,5} = calVisualMatOut5(:,p:p+(numTimeVisual*freq(5))-1);
    eyeVisualCell{4,5} = eyeVisualMatOut5(:,p:p+(numTimeVisual*freq(5))-1);
    rsCell{4,5} = rsMatIn5(p:p+(numTimeVisual*freq(5))-1,:);
    
    calVisualCell{4,6} = calVisualMatOut10(:,q:q+(numTimeVisual*freq(6))-1);
    eyeVisualCell{4,6} = eyeVisualMatOut10(:,q:q+(numTimeVisual*freq(6))-1);
    rsCell{4,6} = rsMatIn10(q:q+(numTimeVisual*freq(6))-1,:);
    
    calVisualBlockAvg = cellfun(@(x) nanmean(x,2),calVisualCell,'UniformOutput',false);
    eyeVelVisualBlockAvg = cellfun(@(x) nanmean(x,2),eyeVisualCell,'UniformOutput',false);
    rsBlockAvg = cellfun(@(x) nanmean(x,1),rsCell,'UniformOutput',false);
	drumVisualBlockAvg = cellfun(@(x) nanmean(x,2),drumVisual,'UniformOutput',false);
    
    [calVisualBlockAmpAvg,calVisualBlockAmpIdxAvg] = cellfun(@(x) max(x),calVisualBlockAvg,'UniformOutput',false);
    [calVisualBlockAmpAvgTrough,calVisualBlockAmpIdxAvgTrough] = cellfun(@(x) min(x),calVisualBlockAvg,'UniformOutput',false);
    [eyeVelVisualBlockAmpAvgContra,eyeVisualBlockAmpIdxAvgContra] = cellfun(@(x) min(x),eyeVelVisualBlockAvg,'UniformOutput',false);
    [eyeVelVisualBlockAmpAvgIpsi,eyeVisualBlockAmpIdxAvgIpsi] = cellfun(@(x) max(x),eyeVelVisualBlockAvg,'UniformOutput',false);
    [rsBlockAmpAvg,rsBlockAmpIdxAvg] = cellfun(@(x) min(x),rsBlockAvg,'UniformOutput',false);
    [drumVisualBlockAmpAvgContra,drumVisualBlockAmpIdxAvgContra] = cellfun(@(x) min(x),drumVisualBlockAvg,'UniformOutput',false);
    [drumVisualBlockAmpAvgIpsi,drumVisualBlockAmpIdxAvgIpsi] = cellfun(@(x) max(x),drumVisualBlockAvg,'UniformOutput',false);
    
    calVisualCat = cell(6,1);
    eyeVisualCat = cell(6,1);
    rsCat = cell(6,1);
    drumVisualCat = cell(6,1);
    for t = 1:6
        calVisualCat{t} = cat(2,calVisualBlockAvg{1:numTestPerFreq,t});
        eyeVisualCat{t} = cat(2,eyeVelVisualBlockAvg{1:numTestPerFreq,t});
        rsCat{t} = cat(1,rsBlockAvg{1:numTestPerFreq,t});
        drumVisualCat{t} = cat(2,drumVisualBlockAvg{t,1:numTestPerFreq});
    end
    calVisualCat{5} = cat(2,calVisualBlockAvg{:,5});
    calVisualCat{6} = cat(2,calVisualBlockAvg{:,6});
    eyeVisualCat{5} = cat(2,eyeVelVisualBlockAvg{:,5});
    eyeVisualCat{6} = cat(2,eyeVelVisualBlockAvg{:,6});
    rsCat{5} = cat(1,rsBlockAvg{:,5});
    rsCat{6} = cat(1,rsBlockAvg{:,6});
    drumVisualCat{5} = cat(2,drumVisualBlockAvg{5,:});
    drumVisualCat{6} = cat(2,drumVisualBlockAvg{6,:});
    
    calVisualAvg = cellfun(@(x) nanmean(x,2),calVisualCat,'UniformOutput',false);
    eyeVisualAvg = cellfun(@(x) nanmean(x,2),eyeVisualCat,'UniformOutput',false);
    rsAvg = cellfun(@(x) nanmean(x,1),rsCat,'UniformOutput',false);
    drumVisualAvg = cellfun(@(x) nanmean(x,2),drumVisualCat,'UniformOutput',false);
    
    [calVisualAmpAvg,calVisualAmpIdxAvg] = cellfun(@(x) max(x),calVisualAvg,'UniformOutput',false);
    [calVisualAmpAvgTrough,calVisualAmpIdxAvgTrough] = cellfun(@(x) min(x),calVisualAvg,'UniformOutput',false);
    [eyeVelVisualAmpAvgContra,eyeVisualAmpIdxAvgContra] = cellfun(@(x) min(x),eyeVisualAvg,'UniformOutput',false);
    [eyeVelVisualAmpAvgIpsi,eyeVisualAmpIdxAvgIpsi] = cellfun(@(x) max(x),eyeVisualAvg,'UniformOutput',false);
    [rsAmpAvg,rsAmpIdxAvg] = cellfun(@(x) min(x),rsAvg,'UniformOutput',false);
    [drumVisualAmpAvgContra,drumVisualAmpIdxAvgContra] = cellfun(@(x) min(x),drumVisualAvg,'UniformOutput',false);
    [drumVisualAmpAvgIpsi,drumVisualAmpIdxAvgIpsi] = cellfun(@(x) max(x),drumVisualAvg,'UniformOutput',false);
    calVisualAmpIdxAvg{5} = max(calVisualAvg{5}(1:1000));
    calVisualAmpIdxAvg{6} = max(calVisualAvg{6}(1:1000));
    
    a = 1;
    b = 1;
    for i = 4:length(drumVisualAvg{5})
        thresh(1) = mean(drumVisualAvg{5}(i-3:i-1));
        thresh(2) = mean(drumVisualAvg{6}(i-3:i-1));
        signDrumIdx(1) = sign(drumVisualAvg{5}(i));
        signDrumIdx(2) = sign(drumVisualAvg{5}(i));
        if drumVisualAvg{5}(i) < thresh(1) && drumVisualAvg{5}(i) < i-3 && signDrumIdx(1) < 0 && drumVisualAvg{5}(i) > -1
            startPtDrum(a) = drumVisualAvg{5}(i);
            startPtDrumIdx(a) = i;
            a = a + 1;
        end
        if drumVisualAvg{6}(i) < thresh(2) && drumVisualAvg{6}(i) < i-3 && signDrumIdx(2) < 0 && drumVisualAvg{6}(i) > -1
            startPtDrum(2,b) = drumVisualAvg{6}(i);
            startPtDrumIdx(2,b) = i;
            b = b + 1;
        end
    end
    if startPtDrumIdx(1) > 1000
        startPtDrumIdx(1) = startPtDrumIdx(1)-2000;
    end
    if startPtDrumIdx(2) > 1000
        startPtDrumIdx(2) = startPtDrumIdx(2)-2000;
    end
    
    calDelayEye = NaN(6,1);
    calDelayDrum = NaN(6,1);
    calDelayRS = NaN(6,1);
    for i = 1:6
        calDelayEye(i) = calVisualAmpIdxAvg{i} - eyeVisualAmpIdxAvgContra{i};
        calDelayDrum(i) = calVisualAmpIdxAvg{i} - drumVisualAmpIdxAvgContra{i};
        calDelayRS(i) = calVisualAmpIdxAvg{i} - rsAmpIdxAvg{i};
    end
    calDelayDrum(5) = calVisualAmpIdxAvg{5} - startPtDrumIdx(1);
    calDelayDrum(6) = calVisualAmpIdxAvg{6} - startPtDrumIdx(2);
    drumRescale = cellfun(@(x) rescale(x,0,1),drumVisualAvg,'UniformOutput',false);
    
    %% 
    figure()
    t = tiledlayout(2,3)
    t.TileSpacing = 'compact';
    t.Padding = 'tight';
    nexttile; hold on
    for i = 1:3
        plot(calVisualBlockAvg{i}*100)
    end
    plot(calVisualAvg{1}*100,'k','LineWidth',2)
    plot(drumRescale{1},'LineWidth',1)
    ylabel('% \DeltaF/G')
    title('0.5 Hz')
    legend('Block 1','Block 2','Block 3','Record Avg','Drum avg')
    
    nexttile; hold on
    for i = 1:3
        plot(calVisualBlockAvg{i,2}*100)
    end
    plot(calVisualAvg{2}*100,'k','LineWidth',2)
    plot(drumRescale{2},'LineWidth',1)
    title('1 Hz')
    
    nexttile; hold on
    for i = 1:3
        plot(calVisualBlockAvg{i,3}*100)
    end
    plot(calVisualAvg{3}*100,'k','LineWidth',2)
    plot(drumRescale{3},'LineWidth',1)
    title('2 Hz')
    
    nexttile; hold on
    for i = 1:3
        plot(calVisualBlockAvg{i,4}*100)
    end
    plot(calVisualAvg{4}*100,'k','LineWidth',2)
    plot(drumRescale{4},'LineWidth',1)
    ylabel('% \DeltaF/G')
    xlabel('Time (ms)')
    title('4 Hz')
    
    nexttile; hold on
    for i = 1:3
        plot(calVisualBlockAvg{i,5}*100)
    end
    plot(calVisualAvg{5}*100,'k','LineWidth',2)
    plot(drumRescale{5},'LineWidth',1)
    xlabel('Time (ms)')
    title('Step 5 ^{\circ}/s')
    
    nexttile; hold on
    for i = 1:3
        plot(calVisualBlockAvg{i,6}*100)
    end
    plot(calVisualAvg{6}*100,'k','LineWidth',2)
    plot(drumRescale{6},'LineWidth',1)
    xlabel('Time (ms)')
    title('Step 10 ^{\circ}/s')

    %% 
    figure()
    t = tiledlayout(2,3)
    t.TileSpacing = 'compact';
    t.Padding = 'tight';
    nexttile; hold on
    for i = 1:3
        plot(eyeVelVisualBlockAvg{i,1})
    end
    plot(eyeVisualAvg{1},'k','LineWidth',2)
    ylabel('Eye Velocity')
    title('0.5 Hz')
    
    nexttile; hold on
    for i = 1:3
        plot(eyeVelVisualBlockAvg{i,2})
    end
    plot(eyeVisualAvg{2},'k','LineWidth',2)
    title('1 Hz')
    
    nexttile; hold on
    for i = 1:3
        plot(eyeVelVisualBlockAvg{i,3})
    end
    plot(eyeVisualAvg{3},'k','LineWidth',2)
    title('2 Hz')
    
    nexttile; hold on
    for i = 1:3
        plot(eyeVelVisualBlockAvg{i,4})
    end
    plot(eyeVisualAvg{4},'k','LineWidth',2)
    ylabel('Eye Velocity')
    xlabel('Time (ms)')
    title('4 Hz')
    
    nexttile; hold on
    for i = 1:3
        plot(eyeVelVisualBlockAvg{i,5})
    end
    plot(eyeVisualAvg{5},'k','LineWidth',2)
    xlabel('Time (ms)')
    title('Step 5 ^{\circ}/s')
    
    nexttile; hold on
    for i = 1:3
        plot(eyeVelVisualBlockAvg{i,6})
    end
    plot(eyeVisualAvg{6},'k','LineWidth',2)
    xlabel('Time (ms)')
    title('Step 10 ^{\circ}/s')

    %% 
    figure();
    t = tiledlayout(2,3);
    t.TileSpacing = 'compact';
    t.Padding = 'tight';
    nexttile; hold on
    plot(rescale(calVisualAvg{1}*100,-5,5))
    plot(eyeVisualAvg{1})
    plot(drumVisualAvg{1})
    plot(rsAvg{1})
    ylabel('Amplitude')
    title('0.5 Hz')
    legend('Calcium','Eye vel.','Drum vel.','Retinal slip vel.')

    nexttile; hold on
    plot(rescale(calVisualAvg{2}*100,-5,5))
    plot(eyeVisualAvg{2})
    plot(drumVisualAvg{2})
    plot(rsAvg{2})
    title('1 Hz')

    nexttile; hold on
    plot(rescale(calVisualAvg{3}*100,-5,5))
    plot(eyeVisualAvg{3})
    plot(drumVisualAvg{3})
    plot(rsAvg{3})
    title('2 Hz')

    nexttile; hold on
    plot(rescale(calVisualAvg{4}*100,-5,5))
    plot(eyeVisualAvg{4})
    plot(drumVisualAvg{4})
    plot(rsAvg{4})
    ylabel('Amplitude')
    title('4 Hz')
    xlabel('Time (ms)')

    nexttile; hold on
    plot(rescale(calVisualAvg{5}*100,-5,5))
    plot(eyeVisualAvg{5})
    plot(drumVisualAvg{5})
    plot(rsAvg{5})
    title('5{\circ}/s')
    xlabel('Time (ms)')

    nexttile; hold on
    plot(rescale(calVisualAvg{6}*100,-5,5))
    plot(eyeVisualAvg{6})
    plot(drumVisualAvg{6})
    plot(rsAvg{6})
    title('10{\circ}/s')
    xlabel('Time (ms)')
    
    %% 
    for i = 1:6
        rsAvg{i} = rsAvg{i}(:,:)';
    end
    [calVisualSine05,phaseCalVisual(:,1)] = sinesFit(calVisualAvg{1},fr,freq(1),numBlocksVisual,1);
    [eyeVisualSine05,phaseEyeVisual(:,1)] = sinesFit(eyeVisualAvg{1},fr,freq(1),numBlocksVisual,1);
    [rsSine05,phaseRS(:,1)] = sinesFit(rsAvg{1},fr,freq(1),numBlocksVisual,1);
    
    [calVisualSineAmpAvg,calVisualSineAmpIdxAvg] = max(calVisualSine05);
    [calVisualSineAmpAvgTrough,calVisualSineAmpIdxAvgTrough] = min(calVisualSine05);
    [eyeVelVisualSineAmpAvgContra,eyeVisualSineAmpIdxAvgContra] = min(eyeVisualSine05);
    [eyeVelVisualSineAmpAvgIpsi,eyeVisualSineAmpIdxAvgIpsi] = max(eyeVisualSine05);
    [rsSineAmpAvg,rsSineAmpIdxAvg] = min(rsSine05);
    
    [calVisualSine1,phaseCalVisual(:,2)] = sinesFit(calVisualAvg{2},fr,freq(2),numBlocksVisual,1);
    [eyeVisualSine1,phaseEyeVisual(:,2)] = sinesFit(eyeVisualAvg{2},fr,freq(2),numBlocksVisual,1);
    [rsSine1,phaseRS(:,2)] = sinesFit(rsAvg{2},fr,freq(2),numBlocksVisual,1);
    
    [calVisualSineAmpAvg(2),calVisualSineAmpIdxAvg(2)] = max(calVisualSine1);
    [calVisualSineAmpAvgTrough(2),calVisualSineAmpIdxAvgTrough(2)] = min(calVisualSine1);
    [eyeVelVisualSineAmpAvgContra(2),eyeVisualSineAmpIdxAvgContra(2)] = min(eyeVisualSine1);
    [eyeVelVisualSineAmpAvgIpsi(2),eyeVisualSineAmpIdxAvgIpsi(2)] = max(eyeVisualSine1);
    [rsSineAmpAvg(2),rsSineAmpIdxAvg(2)] = min(rsSine1);
    
    [calVisualSine2,phaseCalVisual(:,3)] = sinesFit(calVisualAvg{3},fr,freq(3),numBlocksVisual,1);
    [eyeVisualSine2,phaseEyeVisual(:,3)] = sinesFit(eyeVisualAvg{3},fr,freq(3),numBlocksVisual,1);
    [rsSine2,phaseRS(:,3)] = sinesFit(rsAvg{3},fr,freq(3),numBlocksVisual,1);
    
    [calVisualSineAmpAvg(3),calVisualSineAmpIdxAvg(3)] = max(calVisualSine2);
    [calVisualSineAmpAvgTrough(3),calVisualSineAmpIdxAvgTrough(3)] = min(calVisualSine2);
    [eyeVelVisualSineAmpAvgContra(3),eyeVisualSineAmpIdxAvgContra(3)] = min(eyeVisualSine2);
    [eyeVelVisualSineAmpAvgIpsi(3),eyeVisualSineAmpIdxAvgIpsi(3)] = max(eyeVisualSine2);
    [rsSineAmpAvg(3),rsSineAmpIdxAvg(3)] = min(rsSine2);
    
    [calVisualSine4,phaseCalVisual(:,4)] = sinesFit(calVisualAvg{4},fr,freq(4),numBlocksVisual,1);
    [eyeVisualSine4,phaseEyeVisual(:,4)] = sinesFit(eyeVisualAvg{4},fr,freq(4),numBlocksVisual,1);
    [rsSine4,phaseRS(:,4)] = sinesFit(rsAvg{4},fr,freq(4),numBlocksVisual,1);
    
    [calVisualSineAmpAvg(4),calVisualSineAmpIdxAvg(4)] = max(calVisualSine4);
    [calVisualSineAmpAvgTrough(4),calVisualSineAmpIdxAvgTrough(4)] = min(calVisualSine4);
    [eyeVelVisualSineAmpAvgContra(4),eyeVisualSineAmpIdxAvgContra(4)] = min(eyeVisualSine4);
    [eyeVelVisualSineAmpAvgIpsi(4),eyeVisualSineAmpIdxAvgIpsi(4)] = max(eyeVisualSine4);
    [rsSineAmpAvg(4),rsSineAmpIdxAvg(4)] = min(rsSine4);
    
    for i = 1:4
        calDelayEye(i,2) = calVisualSineAmpIdxAvg(i) - eyeVisualSineAmpIdxAvgContra(i);
        calDelayDrum(i,2) = calVisualSineAmpIdxAvg(i) - drumVisualAmpIdxAvgContra{i};
        calDelayRS(i,2) = calVisualSineAmpIdxAvg(i) - rsSineAmpIdxAvg(i);
    end
    
    figure();
    nexttile; hold on
    plot(calVisualSine05*100)
    plot(eyeVisualSine05)
    plot(rsSine05)
    title('0.5 Hz')
    ylabel('Amplitude')
    
    nexttile; hold on
    plot(calVisualSine1*100)
    plot(eyeVisualSine1)
    plot(rsSine1)
    title('1 Hz')
    
    nexttile; hold on
    plot(calVisualSine2*100)
    plot(eyeVisualSine2)
    plot(rsSine2)
    title('2 Hz')
    xlabel('Time (ms)')
    ylabel('Amplitude')
    
    nexttile; hold on
    plot(calVisualSine4*100)
    plot(eyeVisualSine4)
    plot(rsSine4)
    xlabel('Time (ms)')
    title('4 Hz')
    legend('Calcium','Eye vel.','Retinal Slip')
    
end

%% Normalize calcium amplitude
if condition == 4
    numBlocksVisual = numBlocksVisual*2;
end
if calciumNorm == 1
    spNorm = NaN(1,numBlocksVisual);
    calVisualNorm = NaN(1,numBlocksVisual);
    calSineVisualNorm = NaN(1,numBlocksVisual);
    if protocol ~= 2 && protocol ~= 3 && condition ~= 2
        t = numTimeGap*frequency*2+1;
    else
        t = 1;
    end
    if expSubType ~= 3
        for i = 1:numBlocksVisual
            spNorm(i) = mean(nanmean(calGapMatOut(:,t:t+(numTimeGap*frequency)*2-1),2),1)*100;
            calVisualNorm(i) = calBlockAmp(i,2)./spNorm(i);
            calSineVisualNorm(i) = calSineBlockAmp(i,2)*2./spNorm(i);
            t = t + numTimeGap*frequency;
        end
    
        spDarkNorm = NaN(1,numBlocksDark);
        calDarkNorm = NaN(1,numBlocksDark);
        calSineDarkNorm = NaN(1,numBlocksDark);
        t = 1;
        for i = 1:numBlocksDark-1
            spDarkNorm(i) = mean(nanmean(calGapMatOut(:,t:t+(numTimeGap*frequency)*2-1),2),1)*100;
            calDarkNorm(i) = calBlockAmp(i,1)./spDarkNorm(i);
            calSineDarkNorm(i) = calSineBlockAmp(i,1)*2./spDarkNorm(i);
            t = t + numTimeGap*frequency;
        end

        figure('Name','Normalized calcium amplitude')
        subplot(2,2,1); hold on
        a = plot(calDarkNorm,'-s','MarkerFaceColor','g');
        a.Color = 'g';
        ylabel('Normalized \DeltaF/G')
        title('Unfitted','Vestibular-dark')
        xticks(1:numBlocksDark)
        xticklabels(1:numBlocksDark)
        subplot(2,2,2); hold on
        a = plot(calVisualNorm,'-s','MarkerFaceColor','g');
        a.Color = 'g';
        title('Unfitted','Visual')
        xticks(1:numBlocksVisual)
        xticklabels(1:numBlocksVisual)
        subplot(2,2,3); hold on
        a = plot(calSineDarkNorm,'-s','MarkerFaceColor','g');
        a.Color = 'g';
        xlabel('Block number')
        ylabel('Normalized \DeltaF/G')
        title('Sines-fitted')
        xticks(1:numBlocksDark)
        xticklabels(1:numBlocksDark)
        subplot(2,2,4); hold on
        a = plot(calSineVisualNorm,'-s','MarkerFaceColor','g');
        a.Color = 'g';
        title('Sines-fitted')
        xlabel('Block number')
        xticks(1:numBlocksVisual)
        xticklabels(1:numBlocksVisual)
    else
        spDarkNorm = NaN(1,numBlocksDark);
        calDarkNorm = NaN(1,numBlocksDark);
        calSineDarkNorm = NaN(1,numBlocksDark);
        spDarkNorm = nanmean(calGapMatOut,2)*100;
        calDarkNorm = calBlockAmp(1,1)./spDarkNorm;
        calSineDarkNorm = calSineAmpAvg(1,1)*2./spDarkNorm;
    end
end

if condition == 4
    numBlocksVisual = numBlocksVisual/2;
end
%% 
if expSubType ~= 3
    if protocol ~= 2
        calBlockSineDarkMat = cell2mat(calDarkBlockSine)';
        calBlockSineVisualMat = cell2mat(calVisualBlockSine)';
        calPrePost = NaN(fr*(1/frequency),12);
        calPrePost(:,1) = mean(calDarkBlockAvg(:,numBlocksDark-3:numBlocksDark-1),2) - mean(calDarkBlockAvg(:,1:3),2);
        calPrePost(:,2) = calVisualBlockAvg(:,numBlocksVisual) - calVisualBlockAvg(:,1);
        calPrePost(:,3) = mean(calBlockSineDarkMat(:,numBlocksDark-3:numBlocksDark-1),2) - mean(calBlockSineDarkMat(:,1:3),2);
        calPrePost(:,4) = calBlockSineVisualMat(:,numBlocksVisual) - calBlockSineVisualMat(:,1);
        calPrePost(1,5) = mean(calBlockAmp(numBlocksDark-3:numBlocksDark-1)) - mean(calBlockAmp(1:3));
        calPrePost(2,5) = mean(calBlockAmpIdx(numBlocksDark-3:numBlocksDark-1)) - mean(calBlockAmpIdx(1:3));
        calPrePost(1,6) = mean(calSineBlockAmp(numBlocksDark-3:numBlocksDark-1)) - mean(calSineBlockAmp(1:3));
        calPrePost(2,6) = mean(calSineBlockAmpIdx(numBlocksDark-3:numBlocksDark-1)) - mean(calSineBlockAmpIdx(1:3));
        calPrePost(1,7) = calBlockAmp(numBlocksVisual,2) - calBlockAmp(1,2);
        calPrePost(2,7) = calBlockAmpIdx(numBlocksVisual,2) - calBlockAmpIdx(1,2);
        calPrePost(1,8) = calSineBlockAmp(numBlocksVisual,2) - calSineBlockAmp(1,2);
        calPrePost(2,8) = calSineBlockAmpIdx(numBlocksVisual,2) - calSineBlockAmpIdx(1,2);
        calPrePost(1,9) = mean(calDarkNorm(numBlocksDark-3:numBlocksDark-1)) - mean(calDarkNorm(1:3));
        calPrePost(1,10) = mean(calSineDarkNorm(numBlocksDark-3:numBlocksDark-1)) - mean(calSineDarkNorm(1:3));
        calPrePost(1,11) = calVisualNorm(numBlocksVisual) - calVisualNorm(1);
        calPrePost(1,12) = calSineVisualNorm(numBlocksVisual) - calSineVisualNorm(1);

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
        eyePrePost(:,9) = mean(eyeDarkBlockAvg(:,1:3),2);
        eyePrePost(:,10) = mean(eyeDarkBlockAvg(:,numBlocksDark-3:numBlocksDark-1),2);
        eyePrePost(:,11) = mean(eyeBlockSineDarkMat(:,1:3),2);
        eyePrePost(:,12) = mean(eyeBlockSineDarkMat(:,numBlocksDark-3:numBlocksDark-1),2);
        eyePrePost(:,13) = eyeVisualBlockAvg(:,1);
        eyePrePost(:,14) = eyeVisualBlockAvg(:,numBlocksVisual);
        eyePrePost(:,15) = eyeBlockSineVisualMat(:,1);
        eyePrePost(:,16) = eyeBlockSineVisualMat(:,numBlocksVisual);
    elseif protocol == 2
        calBlockSineDarkMat = cell2mat(calDarkBlockSine)';
        calBlockSineVisualMat = cell2mat(calVisualBlockSine)';
        calPrePost = NaN(fr*(1/frequency),12);
        calPrePost(:,1) = calDarkBlockAvg(:,2) - calDarkBlockAvg(:,1);
        calPrePost(:,2) = calVisualBlockAvg(:,numBlocksVisual) - calVisualBlockAvg(:,1);
        calPrePost(:,3) = calBlockSineDarkMat(:,2) - calBlockSineDarkMat(:,1);
        calPrePost(:,4) = calBlockSineVisualMat(numBlocksVisual) - calBlockSineVisualMat(1);
        calPrePost(1,5) = calBlockAmp(2) - calBlockAmp(1);
        calPrePost(2,5) = calBlockAmpIdx(2) - calBlockAmpIdx(1);
        calPrePost(1,6) = calSineBlockAmp(2) - calSineBlockAmp(1);
        calPrePost(2,6) = calSineBlockAmpIdx(2) - calSineBlockAmpIdx(1);
        calPrePost(1,7) = calBlockAmp(numBlocksVisual,2) - calBlockAmp(1,2);
        calPrePost(2,7) = calBlockAmpIdx(numBlocksVisual,2) - calBlockAmpIdx(1,2);
        calPrePost(1,8) = calSineBlockAmp(numBlocksVisual,2) - calSineBlockAmp(1,2);
        calPrePost(2,8) = calSineBlockAmpIdx(numBlocksVisual,2) - calSineBlockAmpIdx(1,2);
        calPrePost(1,9) = calDarkNorm(2) - calDarkNorm(1);
        calPrePost(1,10) = calSineDarkNorm(2) - calSineDarkNorm(1);
        calPrePost(1,11) = calVisualNorm(numBlocksVisual) - calVisualNorm(1);
        calPrePost(1,12) = calSineVisualNorm(numBlocksVisual) - calSineVisualNorm(1);

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

        eyePrePost(:,9) = eyeDarkBlockAvg(:,1);
        eyePrePost(:,10) = eyeDarkBlockAvg(:,2);
        eyePrePost(:,11) = eyeBlockSineDarkMat(:,1);
        eyePrePost(:,12) = eyeBlockSineDarkMat(:,2);
        eyePrePost(:,13) = eyeVisualBlockAvg(:,1);
        eyePrePost(:,14) = eyeVisualBlockAvg(:,numBlocksVisual);
        eyePrePost(:,15) = eyeBlockSineVisualMat(:,1);
        eyePrePost(:,16) = eyeBlockSineVisualMat(:,numBlocksVisual);
    end
    
    if prePostPlots == 1
        figure('Name','Post - pre'); hold on
        subplot(2,2,1); hold on
        shade((1:length(eyePrePost)),eyePrePost(:,9),(1:length(eyePrePost)),eyePrePost(:,10),'FillType',[1 2;2 1]);
        k1 = plot(eyePrePost(:,9),'Color','k','LineWidth',1);
        k2 = plot(eyePrePost(:,10),'Color','r','LineWidth',1);
        ylabel('Velocity')
        legend([k1(1), k2(1)], 'Pre eye vel.','Post eye vel.')
        title('Vestibular-dark (unfitted)')

        subplot(2,2,2); hold on
        shade((1:length(eyePrePost)),eyePrePost(:,13),(1:length(eyePrePost)),eyePrePost(:,14),'FillType',[1 2;2 1]);
        h1 = plot(eyePrePost(:,13),'Color','k','LineWidth',1);
        h2 = plot(eyePrePost(:,14),'Color','r','LineWidth',1);
        ylabel('Velocity')
        legend([h1(1), h2(1)], 'Pre eye vel.','Post eye vel.')
        title('Visual (unfitted)')

        subplot(2,2,3); hold on
        shade((1:length(eyePrePost)),eyePrePost(:,11),(1:length(eyePrePost)),eyePrePost(:,12),'FillType',[1 2;2 1]);
        k1 = plot(eyePrePost(:,11),'Color','k','LineWidth',1);
        k2 = plot(eyePrePost(:,12),'Color','r','LineWidth',1);
        xlabel('Time (ms)')
        ylabel('Velocity')
        legend([k1(1), k2(1)], 'Pre eye vel.','Post eye vel.')
        title('Vestibular-dark (unfitted)')

        subplot(2,2,4); hold on
        shade((1:length(eyePrePost)),eyePrePost(:,15),(1:length(eyePrePost)),eyePrePost(:,16),'FillType',[1 2;2 1]);
        h1 = plot(eyePrePost(:,15),'Color','k','LineWidth',1);
        h2 = plot(eyePrePost(:,16),'Color','r','LineWidth',1);
        xlabel('Time (ms)')
        ylabel('Velocity')
        legend([h1(1), h2(1)], 'Pre eye vel.','Post eye vel.')
        title('Visual (unfitted)')
    end
end