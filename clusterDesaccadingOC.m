function [dataOut2,dataOut3,saccade2vec,saccade3vec] = clusterDesaccadingOC(data2,data3,fr,frequency,movingMeanRange,saccadeThresh,clusterSize)
%% Cluster desaccading method
% dataStruct = load("da0505.0007.mat");
% eyeChannel = getChannel(dataStruct, "hevel");
% headData = getChannel(dataStruct, "hhvel").data;
% contraTimesChan = getChannel(dataStruct, "contra");
% contraTimes = contraTimesChan.data;
% periodEye = 1;      %time of cycle or trial (s)
% eyeData = eyeChannel.data;
% truncEyeData = eyeData(int32(samplerate*contraTimes(1)):end);
% chunkedEyeData = chunkData(truncEyeData, samplerate, periodEye);

% Set size of cluster, which determines the "center". Currently,
% the size is the largest odd number smaller than 1/3 the size of
% the chunk. This can change depending on the nature of the data,
% but it should always be an odd number so that there is a well
% defined center point.

%[saccade1vec, data1vec,connectionDistance] = saccadeFilter(data1,clusterSize,movingMeanRange,saccadeThresh);
[saccade2vec, data2vec,connectionDistance] = saccadeFilter(data2,clusterSize,movingMeanRange,saccadeThresh);
[saccade3vec, data3vec,connectionDistance] = saccadeFilter(data3,clusterSize,movingMeanRange,saccadeThresh);

%[saccadeEyeVec, finalEyeData] = saccadeFilter(chunkedEyeData);
%[saccadeCalciumVec, finalCalciumData] = saccadeFilter(blocks{1,:}.');

% plotSaccades(saccade1vec, data1vec, 1, "Event Detection 0.5 Hz", length(data1));
% plotSaccades(saccade2vec, data2vec, 2, "Event Detection 1 Hz", length(data2));
% plotSaccades(saccade3vec, data3vec, 3, "Event Detection 2 Hz", length(data3));

%plotSaccades(saccadeCalciumVec, finalCalciumData, 3);
%[saccadeVec05hz,~] = saccadeFilter(bloc
% data1vec(saccade1vec) = NaN;
% dataOut1 = reshape(data1vec,length(data1),size(data1,1));
data2vec(saccade2vec) = NaN;
dataOut2 = reshape(data2vec,length(data2),size(data2,1));
data3vec(saccade3vec) = NaN;
dataOut3 = reshape(data3vec,length(data3),size(data3,1));

% data1 = data1';
data2 = data2';
data3 = data3';
figure()
subplot(3,1,1); hold on
% plot(data1,'Color','k')
% plot(dataOut1,'Color','r')
ylabel('Amplitude')
title('Visual activity')
subplot(3,1,2); hold on
plot(data2,'Color','k')
plot(dataOut2,'Color','r')
ylabel('Amplitude')
title('Vestibular-dark activity')
subplot(3,1,3); hold on
plot(data3,'Color','k')
plot(dataOut3,'Color','r')
xlabel('Time (ms)')
ylabel('Amplitude')
title('Gap activity')

%% 
function chan = getChannel(dataStruct, chanName)
% Find specific channel from the ".dat" data structure
%
%   This function takes in .dat data structure and a channel name, and
%   returns that channel if the name is contained in the structure.
%   Otherwise, the function returns -1
% 
% Andrew Kirjner, July 2021
% *********************************************************************
    behChannels = dataStruct.beh;
    chanNumber = 0;
    for i = 1:length(behChannels)
       chan = behChannels(i);
       if chan.chanlabel == chanName
           chanNumber = i;
           break
       end
    end
    if chanNumber == 0
        msg  = "Channel Not Found";
        error(msg);
    end
    chan = behChannels(chanNumber);
end

function chunkedData = chunkData(data, samplerate, period)
% Reshape data into chunks with the rows as cycle
%
%   This function takes in a periodic data vector, the samplerate, and the
%   period length, and returns an array where the cycles/periods are the
%   rows of the data. If the data length is not an exact multiple of the
%   period, excess data is discarded
% 
% Andrew Kirjner, July 2021
% *********************************************************************
    chunkSize = int32(samplerate*period);
    numChunks = floor(length(data)/chunkSize);
    chunkedData = zeros(numChunks, chunkSize);
    startIdx = 1;
    chunkCounter = 1;
    while 1
        nextTrialIdx = startIdx + chunkSize - 1;
        endIdx = nextTrialIdx;
        if endIdx > length(data)
            break;
        end
        chunkedData(chunkCounter,:) = data(startIdx:endIdx);
        startIdx = nextTrialIdx+1;
        chunkCounter = chunkCounter + 1;
    end
end
end