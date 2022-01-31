
% Example Data

dataStruct = load("da0505.0007.mat");
eyeChannel = getChannel(dataStruct, "hevel");
headData = getChannel(dataStruct, "hhvel").data;
contraTimesChan = getChannel(dataStruct, "contra");
contraTimes = contraTimesChan.data;
periodEye = 2.192;
periodCalcium = 1;
samplerate = eyeChannel.samplerate;
eyeData = eyeChannel.data;
truncEyeData = eyeData(int32(samplerate*contraTimes(1)):end);
chunkedEyeData = chunkData(truncEyeData, samplerate, periodEye);
block05Hz = load("visualCalcium05hz.mat").blockLreshape;
block1Hz = load("visualCalcium.mat").blockLightDfReshape;
block2Hz = load("visualCalcium2Hz.mat").blockLtrunc;
for i = 1:6
    block2Hz{i,1} = reshape(block2Hz{i,1}, [500, 20]);
end
calcium05Hz = block05Hz{1,1}.';
calcium1Hz = block1Hz{1,1}.';
calcium2Hz = block2Hz{2,1}.';

[saccade05Vec, calcium05HzFlat] = saccadeFilter(calcium05Hz);
[saccade1Vec, calcium1HzFlat] = saccadeFilter(calcium1Hz);
[saccade2Vec, calcium2HzFlat] = saccadeFilter(calcium2Hz);


%[saccadeEyeVec, finalEyeData] = saccadeFilter(chunkedEyeData);
%[saccadeCalciumVec, finalCalciumData] = saccadeFilter(blocks{1,:}.');
plotSaccades(saccade05Vec, calcium05HzFlat, 1, "Calcium Event Detection 0.5 Hz", 2000);
plotSaccades(saccade1Vec, calcium1HzFlat, 2, "Calcium Event Detection 1 Hz", 1000);
plotSaccades(saccade2Vec, calcium2HzFlat, 3, "Calcium Event Detection 2 Hz", 500);
%plotSaccades(saccadeCalciumVec, finalCalciumData, 3);
%[saccadeVec05hz,~] = saccadeFilter(bloc


function plotSaccades(saccadeVec, dataVec, fig, t, cycleLength)
% Plotting function
%
%   This function plots the resulting detected events, with events/saccades
%   colored in red and non-events/saccades colored in blue
%  
% 
% Andrew Kirjner, July 2021
% *********************************************************************
    figure(fig);
    cmap = zeros(length(saccadeVec), 3);
    for i = 1:length(saccadeVec)
        if saccadeVec(i)
            cmap(i, 1) = 1;
        else
            cmap(i, 3) = 1;
        end

    end
    xs = (1:length(dataVec));
    ys = dataVec;
    scatter(xs, ys, 10, cmap, 'filled');
    title(t, "FontSize", 16);
    figure(fig + 3);
    title(t + " (Overlay)", "FontSize", 16);
    hold on;
    for i = 1:20
        xs = (1:cycleLength);
        ys = dataVec((i-1)*cycleLength + 1:i*cycleLength);
        cmapCycle = cmap((i-1)*cycleLength + 1:i*cycleLength,:);
        scatter(xs, ys, 10, cmapCycle, 'filled');
    end
    hold off;
end

function [saccadeVec, flatData] = saccadeFilter(chunks)
% Detect saccades/events in periodic data
%
%   This function takes in period data reshaped into an m x n "chunk" array
%   where each row in the array is one cycle/period of the data. 

%   It works by considering each column of the array (points that are
%   equivalent in time modulo the period length) as a (sorted) distribution
%   and labelling outlier points as saccades/events. 

%   Outliers are defined via their relationship to the "center" of this 
%   distribution, which we take to be the point in the middle of 
%   the tightest cluster of this distribution. This is done to account for
%   the case of characteristically timed saccades/events. Outliers are then
%   found by computing Sn (a robust scale measure), and 
%   comparing the distance between successive pairs of points both above 
%   and below the center until this distance exceeds the Sn-value. Once
%   this occurs, all points further away from the center are labelled as
%   saccades, events. 
%   
%   As a final step, the binary vector of saccades/events is smoothed so 
%   that points tend to have the same label as their neighbors
%   
%   The function returns a binary vector of length m * n, as well as the
%   flattened input data.
%
% Andrew Kirjner, July 2021
% *********************************************************************
   
    % Flatten data
    flatData = reshape(chunks.', 1, []);
   
    % Create an array of zeros that is the same size as the chunk array, 
    % the elements of which will be replaced with ones at the points that
    % are saccades/events. The array will then be flattened and smoothed
    [m, n] = size(chunks);
    saccadeArray = zeros(size(chunks));
    
    % Loop through each chunk 
    for i = 1:n
        % Consider each chunk (distribution of equvialent points mod period
        % length)
        chunk = chunks(:,i);
        
        % Sort the chunk, keeping track of the sorted indices
        [sortedChunk, sortedIdxs] = sort(chunk);
        
        % Set size of cluster, which determines the "center". Currently,
        % the size is the largest odd number smaller than 1/3 the size of
        % the chunk. This can change depending on the nature of the data,
        % but it should always be an odd number so that there is a well
        % defined center point.
        clusterSize = length(chunk)/3;
        clusterSize = 2*floor(clusterSize)/2 - 1;
        
        % Get the index of the center of the tightest cluster
        sortedCenterIdx = findTightestCluster(sortedChunk, clusterSize);
     
        % Find the indices of the saccade/event points within a given chunk
        saccadeIdxs = sortedIdxs(getSaccadeIdxs(sortedCenterIdx, sortedChunk, 1));
        
        % Create binary vector that is the size of the chunk, with ones in
        % at the indices of points labeled as saccades/events
        chunkBin = zeros(length(chunk), 1);
        for j = 1:length(chunk)
            if ismember(j, saccadeIdxs)
                chunkBin(j) = 1;
            end
        end
        
        % Fill the column of the saccade array with the binary vector
        saccadeArray(:,i) = chunkBin;
    end
    
    % Flatten the array and smooth using a moving average filter and a
    % thresold. These values can be changed
    saccadeVec = reshape(saccadeArray.', 1, []);
    saccadeVec = (smoothdata(saccadeVec, 'movmean', 100) > 0.3);
end

function sortedCenterIdx = findTightestCluster(sortedChunk, clusterSize)
% Find the center of the tightest cluster in a given chunk
%
%   This function takes in a sorted chunk and the size of the cluster to be
%   considered. It calculates the range (max - min) of each cluster
%   and returns the index of the center of the cluster with the smallest 
%   range (ignoring clusters that contain NaNs)
%  
% 
% Andrew Kirjner, July 2021
% *********************************************************************
    % Set initial minimum to infinity and set initial cluster center index
    minRange = Inf; 
    winCenterIdx = floor(clusterSize/2);
    % Loop through all potential clusters
    for i = 1:length(sortedChunk)-clusterSize
        win = sortedChunk(i:i+clusterSize-1);
        % Skip clusters containing NaNs
        if sum(isnan(win)) > 0
            continue
        end
        winCenter = sortedChunk(i + winCenterIdx);
        windowRange = range(win);
        if windowRange < minRange
            minRange = windowRange;
            sortedCenterIdx = i + winCenterIdx;
        end
    end
end


function saccadeIdxs = getSaccadeIdxs(sortedCenterIdx, sortedChunk)
% Find saccades/event indices within a given chunk
%
%   This function takes in a sorted chunk and the center of the tightest
%   cluster and uses the Sn scale measurement to determine the indices of
%   saccades/events 
%
%   The function returns the indices of the saccade/event points in the
%   sorted chunk 
% 
% Andrew Kirjner, July 2021
% *********************************************************************
      
      % Start with defining the points that are non-saccades, define a
      % counter to keep track of the current next index of this vector so
      % that new indices can be easily appened
      nonSaccadeIdxs = [sortedCenterIdx];
      counter = 2;
      
      % Compute the "connection distance", which is the maximum distance that 
      % successive pairs of points can be apart to be considered
      % non-saccades/events. Note that we use the Sn metric here (and also
      % truncate the chunk to avoid NaNs and exceedingly large values), but
      % this connection distance can change in principle.
      connectionDistance = RousseeuwCrouxSn(sortedChunk(abs(sortedChunk) < 35 ...
      & ~isnan(sortedChunk)));
      
      
      % Consider the distance between pairs of successive points 
      % above the tightest cluster center, and compare that distance to the 
      % connection distance threshold. If the distance does not exceed the
      % threshold, the point further away from the cluster center is added
      % to the non-saccade/event indices vector
      currUpperIdx = sortedCenterIdx + 1;
      while 1
          if currUpperIdx > length(sortedChunk)
              break;
          end
          if sortedChunk(currUpperIdx) - sortedChunk(currUpperIdx-1) ...
                  > connectionDistance
              break
          end
          nonSaccadeIdxs(counter) = currUpperIdx;
          counter = counter + 1;
          currUpperIdx = currUpperIdx + 1;    
      end
      
      % The same process, but using successive pairs of points below the
      % tight cluster center
      currLowerIdx = sortedCenterIdx-1;
      while 1
          if currLowerIdx == 0
              break;
          end
          if sortedChunk(currLowerIdx + 1) - sortedChunk(currLowerIdx) ...
                  > connectionDistance
              break;
          end
          nonSaccadeIdxs(counter) = currLowerIdx;
          counter = counter + 1;
          currLowerIdx = currLowerIdx - 1;
      end
      
      % return saccade indices, which are all indices that are not
      % non-saccade indices
      saccadeIdxs = 1:length(sortedChunk);
      saccadeIdxs = saccadeIdxs(~ismember(saccadeIdxs, nonSaccadeIdxs));
      
    % A simpler version of this algorithm that considers multiples of the 
    % connection distance, rather than successive pairs of points
    
    % if max(sortedChunk) - min(sortedChunk) <= 5
    % saccadeIdxs = [];
    %   return;
    % end
    % S = RousseeuwCrouxSn(sortedChunk);
    % diffVec = abs(sortedChunk-sortedChunk(sortedCenterIdx));
    % saccadeIdxs = find(diffVec >= 2*S);
end

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



function Sn = RousseeuwCrouxSn(X)
% Compute the measure of scale 'Sn', from Rousseeuw & Croux (1993)
%
%   A robust alternative to MADn for statistical outlier identification.
%   Unlike MADn, Sn does not make an assumption of symmetry, so in
%   principle should be more robust to skewed distributions.
%
%   The outputs of this function have been validated against equivalent
%   function in Maple(tm).
%
% Example:          X = [1 5 2 2 7 4 1 5]
%                   Sn = RousseeuwCrouxSn(X) % should give 3.015
%
% Requires:         none
%
% See also:         mad.m
%
% Author(s):        Pete R Jones <petejonze@gmail.com>
% 
% Version History:  19/04/2016  PJ  Initial version
%                                               
%
% Copyright 2016 : P R Jones
% *********************************************************************
% 
    % get number of elements
    n = length(X);
      % Set c: bias correction factor for finite sample size
      if n < 10
          cc = [NaN 0.743 1.851 0.954 1.351 0.993 1.198 1.005 1.131];
          c = cc(n);
      elseif mod(n,2)==0 % is odd
          c = n/(n-.9);
      else % is even
          c = 1;
      end
      % compute median difference for each element
      tmp = nan(n,1);
      for i = 1:n
          tmp(i) = median(abs(X(i) - X([1:i-1 i+1:end])));
      end
      % compute median of median differences, and apply finite sample correction
      Sn = c * median(tmp);
 end






