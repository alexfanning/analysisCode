function [saccadeVec, flatData,connectionDistance,clusterCenter] = saccadeFilter(chunks,clusterSize,movingMeanRange,saccadeThresh)
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
        
        % Get the index of the center of the tightest cluster
        [clusterCenter(i),sortedCenterIdx] = findTightestCluster(sortedChunk, clusterSize);
     
        % Find the indices of the saccade/event points within a given chunk
        [saccadeTemp,connectionDistance(i)] = getSaccadeIdxs(sortedCenterIdx,sortedChunk);
        saccadeIdxs = sortedIdxs(saccadeTemp);
        %saccadeIdxs = sortedIdxs(getSaccadeIdxs(sortedCenterIdx, sortedChunk));
        %saccadeIdxs = sortedIdxs(getSaccadeIdxs(sortedCenterIdx, sortedChunk, 1));
        
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
    saccadeVec = (smoothdata(saccadeVec, 'movmean', movingMeanRange) > saccadeThresh);
end