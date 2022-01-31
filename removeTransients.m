%% REMOVE TRANSIENTS
function datout = removeTransients(datin, thresh)
    datout = datin;
    datDiff = NaN(1,length(datin))-1;
    for i = 2 : length(datin) - 1
        if abs(datin(i) - datin(i - 1)) > thresh && abs(datin(i) - datin(i + 1)) > thresh && abs(datin(i - 1) - datin(i + 1)) < thresh
            datout(i) = (datin(i - 1) + datin(i + 1)) / 2;
        end
        datDiff(i) = abs(datin(i) - datin(i - 1));
    end
    datout = smooth(datout,5);
    datDiffMean = nanmean(datDiff);
    datDiffMedian = nanmedian(datDiff);
    
    figure('Name','Transient removal')
    subplot(2,1,1); hold on
    bar(datDiff)
    yline(datDiffMean,'LineWidth',2,'Color','k')
    yline(datDiffMedian,'LineWidth',2,'Color','r')
    legend('','Mean','Median')
    xlabel('Time (ms)')
    ylabel('Difference (i - (i-1))')
    
    subplot(2,1,2); hold on
    plot(datin);
    plot(datout);
    legend('Raw eye pos.','Filtered eye pos.')
    xlabel('Time (ms)')
    
    disp(['Transient thresh (mean): ',num2str(datDiffMean)])
    disp(['Transient thresh (median): ',num2str(datDiffMedian)])
end