function plotBlockCycAvgs(head,drum,eye,rslip,numBlocks,figTitle,plotType)
if plotType == 0
    figure('Name',figTitle)
    subplot(2,2,1); hold on
    for i = 1:numBlocks
        plot(head{i})
    end
    ylabel('Velocity')
    title('Head vel.')
    legend('1','2','3','4','5','6')

    subplot(2,2,2); hold on
    for i = 1:numBlocks
        plot(drum{i})
    end
    title('Drum vel.')

    subplot(2,2,3); hold on
    for i = 1:numBlocks
        plot(eye{i})
    end
    xlabel('Time (ms)')
    ylabel('Velocity')
    title('Eye vel.')

    subplot(2,2,4); hold on
    for i = 1:numBlocks
        plot(rslip{i})
    end
    xlabel('Time (ms)')
    title('Rslip vel.')
    
    saveas(gcf,'SineVisualblockAverages.pdf')
elseif plotType == 1
    figure('Name',figTitle)
    subplot(2,2,1); hold on
    for i = 1:numBlocks
        plot(head(:,i))
    end
    ylabel('Velocity')
    title('Head vel.')
    legend('1','2','3','4','5','6')

    subplot(2,2,2); hold on
    for i = 1:numBlocks
        plot(drum(:,i))
    end
    title('Drum vel.')

    subplot(2,2,3); hold on
    for i = 1:numBlocks
        plot(eye(:,i))
    end
    xlabel('Time (ms)')
    ylabel('Velocity')
    title('Eye vel.')

    subplot(2,2,4); hold on
    for i = 1:numBlocks
        plot(rslip(:,i))
    end
    xlabel('Time (ms)')
    title('Rslip vel.')
    saveas(gcf,'VisualBlockAverages.pdf')
elseif plotType == 2
    figure('Name',figTitle)
    subplot(2,1,1); hold on
    for i = 1:numBlocks
        plot(head(:,i))
    end
    ylabel('Velocity')
    title('Head vel.')
    legend('1','2','3','4','5','6','7','8','9','10','11','12')

    subplot(2,1,2); hold on
    for i = 1:numBlocks
        plot(eye(:,i))
    end
    xlabel('Time (ms)')
    ylabel('Velocity')
    title('Eye vel.')
    saveas(gcf,'VdarkBlockAverages.pdf')
elseif plotType == 3
    figure('Name',figTitle)
    subplot(2,1,1); hold on
    for i = 1:numBlocks
        plot(head{i})
    end
    ylabel('Velocity')
    title('Head vel.')
    legend('1','2','3','4','5','6','7','8','9','10','11','12')

    subplot(2,1,2); hold on
    for i = 1:numBlocks
        plot(eye{i})
    end
    xlabel('Time (ms)')
    ylabel('Velocity')
    title('Eye vel.')
    saveas(gcf,'SineVdarkBlockAverages.pdf')
end