function [desaccade] = removeAroundCenters(omitCenters, shift, windowsize)
    %Shifting
    omitCenters = circshift(omitCenters, [shift 0]);
    omitCenters(1:shift) = 0;
    
    sacmask = ones(1, windowsize);
    % Finding points withink plus/minus windowsize/2
    desaccade = conv(double(omitCenters),sacmask);
    desaccade = logical(desaccade(windowsize/2:windowsize/2+length(omitCenters)-1));
end
