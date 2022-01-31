function [sineOut,phaseOut] = sinesFit(dataIn,fr,frequency,numBlocks,t)

segLength = size(dataIn,1);
segTime = (1:segLength)/fr;
y1 = sin(2*pi*frequency*segTime(:));
y2 = cos(2*pi*frequency*segTime(:));
constant = ones(segLength,1);
vars = [y1 y2 constant];

if t == 0
    sinesOffset= NaN(numBlocks,1);
    b = cell(3,1);
    amp = NaN(1,numBlocks);
    phaseOut = NaN(1,numBlocks);
    sineOut = cell(numBlocks,1);

    for i = 1:numBlocks
                sinesOffset(i,1) = nanmean(dataIn(:,i));
                b{1}(:,i) = regress(dataIn(:,i),vars);
                amp(:,i) = sqrt(b{1}(1,i)^2+b{1}(2,i)^2);
                phaseOut(:,i) = rad2deg(atan2(b{1}(2,i),b{1}(1,i)));
                sineOut{i,1} = (sin(2*pi*frequency*segTime + deg2rad(phaseOut(1,i)))*amp(1,i))+sinesOffset(i,1);
    end
    
elseif t == 1
    sinesOffset = nanmean(dataIn);
    b = regress(dataIn,vars);
    amp = sqrt(b(1)^2+b(2)^2);
    phaseOut = rad2deg(atan2(b(2),b(1)));
    sineOut = (sin(2*pi*frequency*segTime + deg2rad(phaseOut(1)))*amp(1))+sinesOffset;
end