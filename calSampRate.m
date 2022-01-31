function [calWindowSize,calFR] = calSampRate(bonsai)

timeStamps = bonsai(:,1);
timeStamps = timeStamps - timeStamps(1);
sampleInt = timeStamps(2:end)-timeStamps(1:end-1);
calFRmean = floor((1/mean(sampleInt))*1000);
if rem(calFRmean, 2) == 0
    calWindowSize = calFRmean;
else
    calWindowSize = calFRmean + 1;
end
calFR = floor((1/mean(sampleInt))*1000);