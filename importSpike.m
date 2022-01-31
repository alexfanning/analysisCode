function [datout,dataDrumVel,dataDrumPos,dataChairVel,dataChairPos] = importSpike(filename, chans)
%% Converts Spike File to continuous data structure
%
% Input:
%    filename
%   (chans) - which channels to import
%
% Output:
%   datout - dat object with fields:
%     'data' - column vector of numeric data (row)
%     'chanlabels' - string labels for each channel
%     'chanvals' - numeric values associated with each
%         channel (e.g. frequency at each bin for a spectrogram).
%     'samplerate' - derived, not claimed (samples/second, double-precision)
%     'tstart','tend' - time of first/last sample; in seconds.
%     'units' - descriptive string giving units of data.
%     ('wavemark') - spike identity
%     ('waveform') for waveform spk channel from spike2
%
% Dependencies: SON library, readSpikeFile.m
%
% Hannah Payne July 2012
%

%% Load data
if ~exist('chans', 'var')
    chanlist = readSpikeFile(filename,[]);
    chans = [chanlist(:).number];
end


if iscell(chans)
    chanlist = readSpikeFile(filename,[]);
    temp = arrayfun(@(x) any(strcmp(x.title,chans)),chanlist);
    chans = [chanlist(temp).number];
end

d = readSpikeFile(filename,chans);
nchans = length(d);

% Preallocate object array
datout(nchans) = dat;

%% Load data
iIn=0;
iOut = 0;
itend = 0;

%% Alex modified 09/28/2021
dataDrumVel = NaN(1,length(d(7).data.adc));
dataDrumVel = d(7).data.adc;
dataDrumPos = NaN(1,length(d(3).data.adc));
dataDrumPos = d(3).data.adc;

dataChairVel = NaN(1,length(d(8).data.adc));
dataChairVel = d(8).data.adc;
dataChairPos = NaN(1,length(d(4).data.adc));
dataChairPos = d(4).data.adc;

%% 

while iIn < nchans
    iIn=iIn+1;
    iOut=iOut+1;
    ichanval = d(iIn).header.channel;
    ichanlabel = d(iIn).header.title;
    
    if strcmp(d(iIn).header.channeltype,'Episodic Waveform')
        d(iIn) = fillGaps(d(iIn));
    end
    
    % Continuous data
    if strcmp(d(iIn).header.channeltype,'Continuous Waveform')
        % Scale current data
        iData = single(d(iIn).data.adc);
        scaleFactor = d(iIn).header.adc.Scale;
        iData = scaleFactor*iData;
        
        % Store it
        isamplerate = 1/prod(d(iIn).header.adc.SampleInterval);
        itstart = 0;
        itend = (length(iData)-1)/isamplerate;
        %     itend = d(i).data.tim(end) - d(i).data.tim(1);
        iunits = d(iIn).header.adc.Units;
        
        % Waveform data
    elseif strcmpi( d(iIn).header.channeltype,'Framed Waveform (Spike)')
        iData = d(iIn).data.tim(:,1); % *** Not sure what the three times are: beginning, peak, and end?
        
        isamplerate_actual = 1/prod(d(iIn).header.adc.SampleInterval);
        
        disp(diff(d(iIn).data.tim(1,:),[],2)/isamplerate_actual);
        spkcode = d(iIn).data.mrk(:,1); % Only uses first assignment;
        %         isamplerate = spkcode;
        isamplerate = 1/prod(d(iIn).header.adc.SampleInterval);
        waveform = d(iIn).data.adc;
        
        iunits = 's';
        itstart = 0;
        itend = max(itend,max(iData(:)));
        
        % Event data
    else
        iData = d(iIn).data.tim;
        
        if ~isempty(d(iIn).data.mrk) && any( d(iIn).data.mrk(:) ~=0 )
            isamplerate = native2unicode(d(iIn).data.mrk(:,1));
        else
            isamplerate = 'event';
        end
        iunits = 's';
        itstart = 0;
        itend = max(itend,max(iData(:)));
        
        
    end
    
    % Make the object instance
    if size(iData,2)==2
        datout(iOut) = dat(iData(:,1),ichanlabel,ichanval,isamplerate,itstart,itend,iunits);
        datout(iOut+1) = dat(iData(:,2),ichanlabel,ichanval,isamplerate,itstart,itend,iunits);
        if iscell(datout(iOut).chanlabel)
            currlabel = datout(iOut).chanlabel{:};
        else
            currlabel = datout(iOut).chanlabel;
        end
        datout(iOut).chanlabel = [currlabel '+'];        % Rising edge
        datout(iOut+1).chanlabel = [currlabel '-'];    % Falling edge
        iOut = iOut+1;
    else
        datout(iOut) = dat(iData,ichanlabel,ichanval,isamplerate,itstart,itend,iunits);
        
        %         If waveform channel, add the cell identity
        if   strcmpi( d(iIn).header.channeltype,'Framed Waveform (Spike)')
            datout(iOut).wavemark = spkcode;
            datout(iOut).waveform = waveform;
            
        end
        
    end
end

%% Make sure all channels with same samplerate are the same size

contchans = arrayfun(@(x) strcmp(x,'cont'),getchantype(datout));

samplerates_sub = arrayfun(@(x) x.samplerate, datout(contchans));
samplerates = zeros(size(contchans)); samplerates(contchans) = samplerates_sub;
unique_samplerates = unique(samplerates(samplerates>0));
if ~any(samplerates)
    return
end


for ii = length(unique_samplerates)
    curr_mask = unique_samplerates(ii)==samplerates & contchans;
    
    ns = arrayfun(@(x) length(x.data),datout(curr_mask));
    targetN = min(ns);
    
    for jj = find(curr_mask)
        datout(jj).data = datout(jj).data(1:targetN);
    end
    
end

end


function dout = fillGaps(din)
%% dout = fillGaps(din) Fill in gaps in older Spike2 recordings
% Hannah Payne 12/16/13

dout = din;
nsegs = size(din.data.tim,1);
maxt = din.data.tim(end); % seconds
samplerate = 1/prod(din.header.adc.SampleInterval);
npoints = round(maxt*samplerate+1);
data = zeros(1,npoints);
tt = (1:npoints)/samplerate;

for j = 1:nsegs
    currlength = din.header.adc.Npoints(j);
    currdata = din.data.adc(1:currlength,j);
    currtime = din.data.tim(j,1);
    startind = find(tt>=currtime,1);
    data(startind:startind+currlength-1) = currdata;
end

dout.data.adc = data;
dout.data.tim = [0 maxt];
dout.header.channeltype = 'Continuous Waveform';
end




