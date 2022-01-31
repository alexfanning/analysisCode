%% Analysis of stimuli, eye, and fluorescence signals
%load raw data and set parameters for analysis
protocol = 0;                                   %used to extract different keystrokes for different experimental protocols (0 for default, 1 for oldest version of default, 2 for sriramOKR, 3 for sriramOKRtestModAlex, or 4 for OKR with VORD tests during training)
condition = 1;                                  %set condition to 0 for gain down, 1 for gain up, 2 for okr, 3 for VORD, or 4 for x2x0 analyses
frequency = 0.5;                                  %frequency of stimuli
transientThreshold = 0.5;                       %threshold for removing high-frequency artifact (typically between 0.1 and 1.5)
saccadeThresh = 500;                            %eye velocity mean squared error threshold for what is considered a saccade (linear desaccading; typically between 100 and 2000)
eyeBoxFilt = 75;                                %number of points to average for filtering noisy eye data (typically between 25 and 150)
presac = 50;                                    %number of additional points to remove prior to each point considered a saccade
postsac = 50;                                   %same except for points to remove following each time point considered a saccade
windowsize = 500;                               %number of timepoints to remove from fluorescence trace (related to saccades)
shift = 100;                                    %shift windowsize in time (positive value shifts rightward)
fr = 1000;                                      %sampling rate

%% Extract stimuli data, select and scale eye data, create raw eye velocity vector
file = uigetfile('*.smr');
bonsai = readtable(uigetfile('*.csv'));
bonsai = table2array(bonsai);
[data,dataSubset] = importDatObject(file);      %extracts raw data from .smr experimental file

drumP = data(1,dataSubset(3)).data;                         %drum position
if condition ~= 4
    chP = data(1,dataSubset(2)).data;                        %turntable position (the sign for the turntable in d019 or d241a isn't flipped properly during acquistion)
    chV = data(1,dataSubset(1)).data;                        %turntable velocity
else
    chP = data(1,dataSubset(2)).data;                        %turntable position (the sign for the turntable in d019 or d241a isn't flipped properly during acquistion)
    chV = data(1,dataSubset(1)).data;
end
drumVel = smooth([diff(smooth(drumP,50)); 0],50)*fr;        %drum velocity
if isnan(dataSubset(6)) || isnan(dataSubset(7))
    drumLED(1) = 1;
    drumLED(2) = length(drumVel);
elseif condition ~=3
    drumLED = [data(1,dataSubset(6)).data data(1,dataSubset(7)).data]*fr;  %drum LEDs high and low
else
    drumLED = [];
end
if ~isnan(dataSubset(8))
    fpTTL = [data(1,dataSubset(8)).data data(1,dataSubset(9)).data]*fr;    %run experiment, end experiment timepoints
    if isnan(fpTTL(2))
        fpTTL(2) = length(chV);
    end
else
    fpTTL = [];
end

directory = uigetdir;
cd(directory);
caliGrab = uigetfile('*.mat');
prompt = 'Scaling factor 1: ';
prompt2 = 'Scaling factor 2: ';
if caliGrab > 0
    load(caliGrab);
    if mag1.vel_fitr2 > mag2.vel_fitr2
        sf = mag1.vel_scale;
        eyeP = data(1,dataSubset(4)).data * sf;
        eyeP = detrend(eyeP);
    else
        sf = mag2.vel_scale;
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

%% Calculate deltaF/G
[calWindowSize,calFR] = calSampRate(bonsai);                    %window size for baseline fitting (typically equal to the sampling rate)
f0smoothFactor = calWindowSize - 10;                            %number of frames to smooth across baseline
f = bonsai(:,3);                                                %calcium-dependent fluorescence
g = bonsai(:,4);                                                %isobestic fluorescence
[f0smooth,deltaF] = getF0(f,calWindowSize,f0smoothFactor,g);    %calculates deltaF/G
df = deltaF;                                                    %copy raw vector for alternate uses

%% Find start and end times for all test condition segments
%extract keyboard keys and their corresponding time
if protocol == 0
    SampKeys = strcat(data(dataSubset(end)).samplerate(any(data(dataSubset(end)).samplerate == ['H' 'x' 'S' 's' 'L' 'X' 'h'], 2))');
    SampKeyTimes = round(data(dataSubset(end)).data(any(data(dataSubset(end)).samplerate == ['H' 'x' 'S' 's' 'L' 'X' 'h'], 2))*fr)';
    
    startDark = SampKeyTimes(strfind(SampKeys, 'XS'));
    endDark = SampKeyTimes(strfind(SampKeys, 'XSx')+2);
    startVisual = SampKeyTimes(strfind(SampKeys, 'XL'));
    endVisual = SampKeyTimes(strfind(SampKeys, 'XLxs')+3);
    startGap = SampKeyTimes(strfind(SampKeys, 'xss'));
    if isempty('startGap')
        startGap = SampKeyTimes(strfind(SampKeys, 'xssL'));
    end
    endGap = SampKeyTimes(strfind(SampKeys, 'sX')+1);
    startRec = SampKeyTimes(strfind(SampKeys, 'H'));
    endRec = SampKeyTimes(strfind(SampKeys, 'h'));
    if isnan(dataSubset(8)) || fpTTL(1) < 0
        fpTTL(1) = startRec;
        fpTTL(1,2) = endRec;
    end
    
    if numel(fpTTL) == 4
        if isnan(fpTTL(2,2))
            fpTTL(2,2) = length(drumVel);
        end
        for i = 1:length(startGap)
            if startGap(i) < fpTTL(2)
                startGap(i) = NaN;
            end
        end
        startGap = startGap(~isnan(startGap));
    end
elseif protocol == 1
    SampKeys = strcat(data(dataSubset(end)).samplerate(any(data(dataSubset(end)).samplerate == ['x' 'S' 's' 'L' 'X'], 2))');
    SampKeyTimes = round(data(dataSubset(end)).data(any(data(dataSubset(end)).samplerate == ['x' 'S' 's' 'L' 'X'], 2))*fr)';
    
    startDark = SampKeyTimes(strfind(SampKeys, 'S'));
    endPrePostDark = SampKeyTimes(strfind(SampKeys, 'Ss')+1);
    endTrainDark = SampKeyTimes(strfind(SampKeys, 'SL')+1);
    startVisual = SampKeyTimes(strfind(SampKeys, 'LssLS'));
    endVisual = SampKeyTimes(strfind(SampKeys, 'LssLS')+1);
    startGap = SampKeyTimes(strfind(SampKeys, 'ssLS'));
    endGap = SampKeyTimes(strfind(SampKeys, 'ssLS')+3);
    endDark = sort([endPrePostDark endTrainDark]);
elseif protocol == 2
    SampKeys = strcat(data(dataSubset(end)).samplerate(any(data(dataSubset(end)).samplerate == ['x' 'S' 's' 'L' 'X'], 2))');
    SampKeyTimes = round(data(dataSubset(end)).data(any(data(dataSubset(end)).samplerate == ['x' 'S' 's' 'L' 'X'], 2))*fr)';
    
    startDark = SampKeyTimes(strfind(SampKeys, 'XS'));
    endDark = SampKeyTimes(strfind(SampKeys, 'XSx')+2);
    startVisual = SampKeyTimes(strfind(SampKeys, 'XL'));
    endVisual = SampKeyTimes(strfind(SampKeys, 'XLSxs')+4);
    startGap = SampKeyTimes(strfind(SampKeys, 'xss'));
    if length(endDark)>4
        endGap = SampKeyTimes(strfind(SampKeys, 'xssX')+3);
    else
        endGap = SampKeyTimes(strfind(SampKeys, 'xssLX')+4);
    end
elseif protocol == 3
    SampKeys = strcat(data(dataSubset(end)).samplerate(any(data(dataSubset(end)).samplerate == ['t' 'S' 's' 'L' 'H' 'h'], 2))');
    SampKeyTimes = round(data(dataSubset(end)).data(any(data(dataSubset(end)).samplerate == ['t' 'S' 's' 'L' 'H' 'h'], 2))*fr)';
    startSineL = SampKeyTimes(strfind(SampKeys, 'S'));
    endSineL = SampKeyTimes(strfind(SampKeys, 'Ss')+1);
    startStepL = SampKeyTimes(strfind(SampKeys, 't'));
    endStepL = SampKeyTimes(strfind(SampKeys, 'ts')+1);
    startGap = SampKeyTimes(strfind(SampKeys, 'sLL'));
    startGapOther = SampKeyTimes(strfind(SampKeys, 'sLs'));
    endGap = SampKeyTimes(strfind(SampKeys, 'sLL')+2);
    startRec = SampKeyTimes(strfind(SampKeys, 'H'));
    endRec = SampKeyTimes(strfind(SampKeys, 'h'));
    startVisual = sort([startSineL startStepL]);
    endVisual = sort([endSineL endStepL]);
    startDark = [];
    endDark = [];
    startGap = [startGap startGapOther];
    endGap = [endGap endRec];
else
    SampKeys = strcat(data(dataSubset(end)).samplerate(any(data(dataSubset(end)).samplerate == ['x' 'S' 's' 'L' 'X'], 2))');
    SampKeyTimes = round(data(dataSubset(end)).data(any(data(dataSubset(end)).samplerate == ['x' 'S' 's' 'L' 'X'], 2))*fr)';
    
    startDark = SampKeyTimes(strfind(SampKeys, 'XS'));
    endDark = SampKeyTimes(strfind(SampKeys, 'XSx')+2);
    startVisual = SampKeyTimes(strfind(SampKeys, 'XL'));
    endVisual = SampKeyTimes(strfind(SampKeys, 'XLSxs')+4);
    startGap = SampKeyTimes(strfind(SampKeys, 'xss'));
    if isempty('startGap')
        startGap = SampKeyTimes(strfind(SampKeys, 'xssL'));
    end
    endGap = SampKeyTimes(strfind(SampKeys, 'sX')+1);
    
    if numel(fpTTL) == 4
        for i = 1:length(startGap)
            if startGap(i) < fpTTL(2)
                startGap(i) = NaN;
            end
        end
        startGap = startGap(~isnan(startGap));
    end
end

%% Linear regression desaccading (for saccade-related analyses, this removes all non-saccade eye data)
datout = removeTransients(eyeP,transientThreshold);
[omitH,omitCenters,eye_pos_filt,eye_vel_pfilt,eyeVelRaw,params] = desaccading(fr,datout,saccadeThresh,presac,postsac,frequency,drumVel,chV);
eyeAccRaw = [diff(eyeVelRaw); 0];
eyeSacs = eyeVelRaw;
eyeSacs(~omitH) = nan;

%% Calculate vector to convolve with calcium data to remove saccade-related fluorescence
desaccade = removeAroundCenters(omitCenters,shift,windowsize);
desaccade2 = desaccade(fpTTL(end,1):fpTTL(end,end))';

%upsample calcium data to match sampling rate of behavioral data
scale = (numel(fpTTL(end,1):fpTTL(end,end))/length(deltaF));
x = [1 scale*(2:length(deltaF))];
xq = 1:numel(fpTTL(end,1):fpTTL(end,end));
calcium_upsampled = interp1(x, deltaF, xq);
Fupsamp = interp1(x,f,xq);
f0upsamp = interp1(x,f0smooth,xq);
Gupsamp = interp1(x,g,xq);
calciumRaw = calcium_upsampled;
calcium_upsampled(desaccade2) = nan;

%% Plot eye velocity smoothing
eyeSmooth = movmean(eyeVelRaw,[eyeBoxFilt eyeBoxFilt]);
figure()
subplot(2,1,1); hold on
plot(eyeVelRaw);
plot(eyeSmooth);
ylim([-50 50])
title('Smoothing of raw eye velocity')
ylabel('Eye velocity')
xlabel('Time (ms)')
legend('Raw eye vel.','Smoothed eye vel.')

%% Remove extraneous data points in beginning and end of record
eyeVelRawTrunc = eyeVelRaw(fpTTL(end,1):fpTTL(end,end));
eyeSmoothTrunc = eyeSmooth(fpTTL(end,1):fpTTL(end,end));
eyeVelFiltTrunc = eye_vel_pfilt(fpTTL(end,1):fpTTL(end,end));
eyeAccRawTrunc = eyeAccRaw(fpTTL(end,1):fpTTL(end,end));
eyePtrunc = datout(fpTTL(end,1):fpTTL(end,end));
eyePfiltTrunc = eye_pos_filt(fpTTL(end,1):fpTTL(end,end));
eyeSacsTrunc = eyeSacs(fpTTL(end,1):fpTTL(end,end));
chVtrunc = chV(fpTTL(end,1):fpTTL(end,end));
chPtrunc = chP(fpTTL(end,1):fpTTL(end,end));
drumVelTrunc = drumVel(fpTTL(end,1):fpTTL(end,end));
drumPtrunc = drumP(fpTTL(end,1):fpTTL(end,end));

if condition == 0
    if drumVelTrunc((startVisual(1)-startGap(1))+(((1/frequency)*fr))/4) > 0 && chVtrunc((startVisual(1)-startGap(1))+(((1/frequency)*fr))/4) > 0
        rsTrunc = drumVelTrunc*-1 - (chVtrunc*-1 + eyeVelRawTrunc);
        rsFiltTrunc = drumVelTrunc*-1 - (chVtrunc*-1 + eyeVelFiltTrunc);
    elseif drumVelTrunc((startVisual(1)-startGap(1))+(((1/frequency)*fr))/4) < 0 && chVtrunc((startVisual(1)-startGap(1))+(((1/frequency)*fr))/4) < 0
        rsTrunc = drumVelTrunc - (chVtrunc + eyeVelRawTrunc);
        rsFiltTrunc = drumVelTrunc - (chVtrunc + eyeVelFiltTrunc);
    elseif drumVelTrunc((startVisual(1)-startGap(1))+(((1/frequency)*fr))/4) > 0 && chVtrunc((startVisual(1)-startGap(1))+(((1/frequency)*fr))/4) < 0
        rsTrunc = drumVelTrunc*-1 - (chVtrunc + eyeVelRawTrunc);
        rsFiltTrunc = drumVelTrunc*-1 - (chVtrunc + eyeVelFiltTrunc);
    elseif drumVelTrunc((startVisual(1)-startGap(1))+(((1/frequency)*fr))/4) < 0 && chVtrunc((startVisual(1)-startGap(1))+(((1/frequency)*fr))/4) > 0
        rsTrunc = drumVelTrunc - (chVtrunc*-1 + eyeVelRawTrunc);
        rsFiltTrunc = drumVelTrunc - (chVtrunc*-1 + eyeVelFiltTrunc);
    end
elseif condition == 1
    if drumVelTrunc((startVisual(1)-startGap(1))+(((1/frequency)*fr))/4) > 0 && chVtrunc((startVisual(1)-startGap(1))+(((1/frequency)*fr))/4) > 0
        rsTrunc = drumVelTrunc - (chVtrunc*-1 + eyeVelRawTrunc);
        rsFiltTrunc = drumVelTrunc - (chVtrunc*-1 + eyeVelFiltTrunc);
    elseif drumVelTrunc((startVisual(1)-startGap(1))+(((1/frequency)*fr))/4) < 0 && chVtrunc((startVisual(1)-startGap(1))+(((1/frequency)*fr))/4) < 0
        rsTrunc = drumVelTrunc*-1 - (chVtrunc + eyeVelRawTrunc);
        rsFiltTrunc = drumVelTrunc*-1 - (chVtrunc + eyeVelFiltTrunc);
    elseif drumVelTrunc((startVisual(1)-startGap(1))+(((1/frequency)*fr))/4) > 0 && chVtrunc((startVisual(1)-startGap(1))+(((1/frequency)*fr))/4) < 0
        rsTrunc = drumVelTrunc - (chVtrunc + eyeVelRawTrunc);
        rsFiltTrunc = drumVelTrunc - (chVtrunc + eyeVelFiltTrunc);
    elseif drumVelTrunc((startVisual(1)-startGap(1))+(((1/frequency)*fr))/4) < 0 && chVtrunc((startVisual(1)-startGap(1))+(((1/frequency)*fr))/4) > 0
        rsTrunc = drumVelTrunc*-1 - (chVtrunc*-1 + eyeVelRawTrunc);
        rsFiltTrunc = drumVelTrunc*-1 - (chVtrunc*-1 + eyeVelFiltTrunc);
    end
elseif condition == 2 && protocol ~= 3 && protocol ~= 2
    if drumVelTrunc((startVisual(1)-startGap(1))+(((1/frequency)*fr))/4) > 0
        rsTrunc = drumVelTrunc - eyeVelRawTrunc;
        rsFiltTrunc = drumVelTrunc - eyeVelFiltTrunc;
    elseif drumVelTrunc((startVisual(1)-startGap(1))+(((1/frequency)*fr))/4) < 0
        rsTrunc = drumVelTrunc*-1 - eyeVelRawTrunc;
        rsFiltTrunc = drumVelTrunc*-1 - eyeVelFiltTrunc;
    end
elseif condition == 2 && protocol == 3
    if drumVelTrunc((startVisual(1)-startRec(1))+(((1/frequency)*fr))/4) > 0
        rsTrunc = drumVelTrunc - eyeVelRawTrunc;
        rsFiltTrunc = drumVelTrunc - chVtrunc + eyeVelFiltTrunc;
    elseif drumVelTrunc((startVisual(1)-startRec(1))+(((1/frequency)*fr))/4) < 0
        rsTrunc = drumVelTrunc*-1 - eyeVelRawTrunc;
        rsFiltTrunc = drumVelTrunc*-1 - eyeVelFiltTrunc;
    end
elseif condition == 2 && protocol == 2
    rsTrunc = drumVelTrunc - eyeVelRawTrunc;
    rsFiltTrunc = drumVelTrunc - eyeVelFiltTrunc;
elseif condition == 4
    rsTrunc = drumVelTrunc - (chVtrunc + eyeVelRawTrunc);
    rsFiltTrunc = drumVelTrunc - (chVtrunc + eyeVelFiltTrunc);
end

%% Plot desaccaded fluorescence trace relative to desaccaded eye trace
subplot(2,1,2); hold on
plot(eyeVelRawTrunc)
plot(eyeVelFiltTrunc)
plot(calciumRaw*1000)
plot(calcium_upsampled*1000)
ylim([-50 50])
title('"Desaccading" of fluorescence')
legend('Raw eye vel','Desaccaded eye vel','Raw fluorescence','Desaccaded fluorescence')
xlabel('Time (ms)')

%% Photobleaching calculations
%calculate photobleaching of isobestic fluorescence across experimental record
photoBleach = mean(g(1:calWindowSize*5));
photoBleach2 = mean(g(end-(calWindowSize*5)+1:end));
photoBleachGcalc = (1-(photoBleach2/photoBleach))*100;
%calculate photobleaching of baseline fluorescence across experimental record
photoBleachF = mean(f0smooth(1:calWindowSize*5));
photoBleachF2 = mean(f0smooth(end-(calWindowSize*5)+1:end));
photoBleachFcalc = (1-(photoBleachF2/photoBleachF))*100;
