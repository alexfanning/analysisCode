function cycAvgPlots(dataDarkBlock,dataDarkBlockAvg,dataVisualBlock,dataVisualAvg,dataGapBlock,dataGapAvg,t)

if iscell(dataDarkBlock)
    figure('Name',t)
    subplot(2,1,1); hold on
    for i = 1:size(dataDarkBlock,1)
        plot(dataDarkBlock{i})
    end
    plot(dataDarkBlockAvg,'Color','k','LineWidth',2)
    ylabel('Amplitude')
    title('Vestibular-dark')
    
    subplot(2,1,2); hold on
    for i = 1:size(dataVisualBlock,1)
        plot(dataVisualBlock{i})
    end
    plot(dataVisualAvg,'Color','k','LineWidth',2)
    xlabel('Time (ms)')
    ylabel('Amplitude')
    title('Visual')

else
    figure('Name',t)
    subplot(3,1,1); hold on
    plot(dataDarkBlock)
    plot(dataDarkBlockAvg,'Color','k','LineWidth',2)
    ylabel('Amplitude')
    title('Vestibular-dark')

    subplot(3,1,2); hold on
    plot(dataVisualBlock)
    plot(dataVisualAvg,'Color','k','LineWidth',2)
    ylabel('Amplitude')
    title('Visual')

    subplot(3,1,3); hold on
    plot(dataGapBlock)
    plot(dataGapAvg,'Color','k','LineWidth',2)
    xlabel('Time (ms)')
    ylabel('Amplitude')
    title('Gap')
end