function [dataOut1,dataOut2,dataOut3,saccade1vec,saccade2vec,saccade3vec,connectionDistance2,clusterCenter2,connectionDistance3,clusterCenter3] = clusterDesaccading(data1,data2,data3,movingMeanRange,saccadeThresh,clusterSize,t)
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

[saccade1vec, data1vec,connectionDistance1,clusterCenter1] = saccadeFilter(data1,clusterSize,movingMeanRange,saccadeThresh);
clusterSize = size(data2,1)/3;
clusterSize = 2*floor(clusterSize)/2 - 1;
[saccade2vec, data2vec,connectionDistance2,clusterCenter2] = saccadeFilter(data2,clusterSize,movingMeanRange,saccadeThresh);
clusterSize = size(data3,1)/3;
clusterSize = 2*floor(clusterSize)/2 - 1;
[saccade3vec, data3vec,connectionDistance3,clusterCenter3] = saccadeFilter(data3,clusterSize,movingMeanRange,saccadeThresh);

%[saccadeEyeVec, finalEyeData] = saccadeFilter(chunkedEyeData);
%[saccadeCalciumVec, finalCalciumData] = saccadeFilter(blocks{1,:}.');

% plotSaccades(saccade1vec, data1vec, 1, "Event Detection 0.5 Hz", length(data1));
% plotSaccades(saccade2vec, data2vec, 2, "Event Detection 1 Hz", length(data2));
% plotSaccades(saccade3vec, data3vec, 3, "Event Detection 2 Hz", length(data3));

%plotSaccades(saccadeCalciumVec, finalCalciumData, 3);
%[saccadeVec05hz,~] = saccadeFilter(bloc
data1rawVec = data1vec;
data1vec(saccade1vec) = NaN;
dataOut1 = reshape(data1vec,size(data1,2),size(data1,1));
data2rawVec = data2vec;
data2vec(saccade2vec) = NaN;
dataOut2 = reshape(data2vec,size(data2,2),size(data2,1));
data3rawVec = data3vec;
data3vec(saccade3vec) = NaN;
dataOut3 = reshape(data3vec,size(data3,2),size(data3,1));

data1 = data1';
data2 = data2';
data3 = data3';
figure('Name',t)
subplot(3,1,1); hold on
plot(data1,'Color','k')
plot(dataOut1,'Color','r')
plot(clusterCenter1,'LineWidth',3)
plot(clusterCenter1+connectionDistance1,'LineWidth',3,'Color','b')
ylabel('Amplitude')
title('Vestibular-dark')
subplot(3,1,2); hold on
plot(data2,'Color','k')
plot(dataOut2,'Color','r')
plot(clusterCenter2,'LineWidth',3)
plot(clusterCenter2+connectionDistance2,'LineWidth',3,'Color','b')
ylabel('Amplitude')
title('Visual')
subplot(3,1,3); hold on
plot(data3,'Color','k')
plot(dataOut3,'Color','r')
plot(clusterCenter3,'LineWidth',3)
plot(clusterCenter3+connectionDistance3,'LineWidth',3,'Color','b')
xlabel('Time (ms)')
ylabel('Amplitude')
title('Gap')

figure('Name',t)
subplot(3,1,1); hold on
plot(data1rawVec,'Color','k')
plot(data1vec,'Color','r')
ylabel('Amplitude')
title(t,'Vestibular-dark')

subplot(3,1,2); hold on
plot(data2rawVec,'Color','k')
plot(data2vec,'Color','r')
ylabel('Amplitude')
title('Visual')

subplot(3,1,3); hold on
plot(data3rawVec,'Color','k')
plot(data3vec,'Color','r')
xlabel('Time (ms)')
ylabel('Amplitude')
title('Gap')

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