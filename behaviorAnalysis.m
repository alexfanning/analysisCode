%% Analysis of stimuli, eye, and fluorescence signals
%load raw data and set parameters for analysis
frequency = 1;                                  %frequency of stimuli
fr = 1000;                                      %sampling rate
protocol = 1;                                   %used to extract different keystrokes for different experimental protocols (0 for default, 1 for oldest version of default, 2 for sriramOKR, or 3 for sriramOKRtestModAlex)
condition = 0;                                  %set condition to 0 for gain down, 1 for gain up, 2 for okr, or 3 for VORD analyses
sf1 = 0;                                        %scaling factor for eye channels (need to set channel not being used to 0)
sf2 = -100;
transientThreshold = 0.1;                       %threshold for removing high-frequency artifact (typically between 0.1 and 1.5)
saccadeThresh = 300;                            %eye velocity mean squared error threshold for what is considered a saccade (linear desaccading; typically between 100 and 2000)
presac = 50;                                    %number of additional points to remove prior to each point considered a saccade
postsac = 50;                                   %same except for points to remove following each time point considered a saccade

%% Extract stimuli data, select and scale eye data, create raw eye velocity vector
file = uigetfile('*.smr');
[data,dataSubset] = importDatObject(file);      %extracts raw data from .smr experimental file

drumP = data(1,dataSubset(3)).data;                         %drum position
chP = data(1,dataSubset(2)).data*-1;                        %turntable position (the sign for the turntable in d019 or d241a isn't flipped properly during acquistion)
drumVel = smooth([diff(smooth(drumP,50)); 0],50)*fr;        %drum velocity
chV = data(1,dataSubset(1)).data*-1;                        %turntable velocity
drumLED = [data(1,dataSubset(6)).data data(1,dataSubset(7)).data]*fr;  %drum LEDs high and low
fpTTL = [data(1,dataSubset(8)).data data(1,dataSubset(9)).data]*fr;    %run experiment, end experiment timepoints

if sf1 ~= 0                                                 %selects eye channel
    eyeP = data(1,dataSubset(4)).data * sf1;                %extracts and scales eye position data vector
else
    eyeP = data(1,dataSubset(5)).data * sf2;
end

%% Find start and end times for all test condition segments
%extract keyboard keys and their corresponding time
if protocol == 0
    SampKeys = strcat(data(dataSubset(end)).samplerate(any(data(dataSubset(end)).samplerate == ['x' 'S' 's' 'L' 'X'], 2))');
    SampKeyTimes = round(data(dataSubset(end)).data(any(data(dataSubset(end)).samplerate == ['x' 'S' 's' 'L' 'X'], 2))*fr)';
    
    startDark = SampKeyTimes(strfind(SampKeys, 'XS'));
    endDark = SampKeyTimes(strfind(SampKeys, 'XSx')+2);
    startVisual = SampKeyTimes(strfind(SampKeys, 'XL'));
    endVisual = SampKeyTimes(strfind(SampKeys, 'XLxs')+3);
    startGap = SampKeyTimes(strfind(SampKeys, 'xss'));
    endGap = SampKeyTimes(strfind(SampKeys, 'sX')+1);
    
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
    endGap = SampKeyTimes(strfind(SampKeys, 'xssX')+3);
    
else
    SampKeys = strcat(data(dataSubset(end)).samplerate(any(data(dataSubset(end)).samplerate == ['t' 'S' 's' 'L' 'H' 'h'], 2))');
    SampKeyTimes = round(data(dataSubset(end)).data(any(data(dataSubset(end)).samplerate == ['t' 'S' 's' 'L' 'H' 'h'], 2))*fr)';
    startSineL = SampKeyTimes(strfind(SampKeys, 'S'));
    endSineL = SampKeyTimes(strfind(SampKeys, 'Ss')+1);
    startStepL = SampKeyTimes(strfind(SampKeys, 't'));
    endStepL = SampKeyTimes(strfind(SampKeys, 'ts')+1);
    startGap = SampKeyTimes(strfind(SampKeys, 'sLL'));
    endGap = SampKeyTimes(strfind(SampKeys, 'sLL')+2);
    startRec = SampKeyTimes(strfind(SampKeys, 'H'));
    endRec = SampKeyTimes(strfind(SampKeys, 'h'));
    startVisual = sort([startSineL startStepL]);
    endVisual = sort([endSineL endStepL]);
    startDark = NaN;
end

%% Linear regression desaccading (for saccade-related analyses, this removes all non-saccade eye data)
datout = removeTransients(eyeP,transientThreshold);
[omitH,omitCenters,eye_pos_filt,eye_vel_pfilt,eyeVelRaw,params] = desaccading(fr,datout,saccadeThresh,presac,postsac,frequency,drumVel,chV);
eyeAccRaw = smooth([diff(smooth(eyeVelRaw,50)); 0],50)*fr;
eyeSacs = eyeVelRaw;
eyeSacs(~omitH) = nan;

%% Remove extraneous data points in beginning and end of record
eyeVelRawTrunc = eyeVelRaw(fpTTL(end,1):fpTTL(end,end));
eyeVelFiltTrunc = eye_vel_pfilt(fpTTL(end,1):fpTTL(end,end));
eyeAccRawTrunc = eyeAccRaw(fpTTL(end,1):fpTTL(end,end));
eyePtrunc = eyeP(fpTTL(end,1):fpTTL(end,end));
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
elseif condition == 2
    if drumVelTrunc((startVisual(1)-startGap(1))+(((1/frequency)*fr))/4) > 0
        rsTrunc = drumVelTrunc - eyeVelRawTrunc;
        rsFiltTrunc = drumVelTrunc - chVtrunc + eyeVelFiltTrunc;
    elseif drumVelTrunc((startVisual(1)-startGap(1))+(((1/frequency)*fr))/4) < 0
        rsTrunc = drumVelTrunc*-1 - eyeVelRawTrunc;
        rsFiltTrunc = drumVelTrunc*-1 - chVtrunc + eyeVelFiltTrunc;
    end
end
