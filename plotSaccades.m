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