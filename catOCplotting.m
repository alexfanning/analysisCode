%% concatenate linear regression data and further analyses

condition = 1;              %set condition to 0 for 10d/s and 250 ms delay, set to 1 for 10d/s and 500 ms delay, set to 2 for 15d/s and 250 ms delay, set to 3 for 15d/s and 500 ms delay
tLength = 10000;            %trial length without delay
delay1 = 250;               %delay length
delay2 = 500;  
numSxs10d250ms = 6;
numSxs10d500ms = 17;
numSxs15d250ms = 6;
numSxs15d500ms = 6;

if condition == 0
    %%10d 250 ms
    cuedBegin10d250ms = cat(1,cuedAvgFirst{1:numSxs10d250ms,1})';
    visualBegin10d250ms = cat(1,visualAvgFirst{1:numSxs10d250ms,1})';
    darkBegin10d250ms = cat(1,darkAvgFirst{1:numSxs10d250ms,1})';
    linearTrialEyeBegin10d250ms = zeros(tLength+delay1,numSxs10d250ms);
    linearTrialEyeBegin10d250ms(1:tLength/2,1:numSxs10d250ms) = darkBegin10d250ms(2:end,:);
    linearTrialEyeBegin10d250ms(tLength/2+1:tLength/2+delay1,1:numSxs10d250ms) = cuedBegin10d250ms(2:end,:);
    linearTrialEyeBegin10d250ms(tLength/2+delay1+1:tLength+delay1,1:numSxs10d250ms) = visualBegin10d250ms(2:end,:);
    linearTrialEyeBeginAvg10d250ms = mean(linearTrialEyeBegin10d250ms,2);

    cuedEnd10d250ms = cat(1,cuedAvgLast{1:numSxs10d250ms,1})';
    visualEnd10d250ms = cat(1,visualAvgLast{1:numSxs10d250ms,1})';
    darkEnd10d250ms = cat(1,darkAvgLast{1:numSxs10d250ms,1})';
    linearTrialEyeEnd10d250ms = zeros(tLength+delay1,numSxs10d250ms);
    linearTrialEyeEnd10d250ms(1:tLength/2,1:numSxs10d250ms) = darkEnd10d250ms(2:end,:);
    linearTrialEyeEnd10d250ms(tLength/2+1:tLength/2+delay1,1:numSxs10d250ms) = cuedEnd10d250ms(2:end,:);
    linearTrialEyeEnd10d250ms(tLength/2+delay1+1:tLength+delay1,1:numSxs10d250ms) = visualEnd10d250ms(2:end,:);
    linearTrialEyeEndAvg10d250ms = mean(linearTrialEyeEnd10d250ms,1);

    drumAvg10d250ms = cat(2,drumAll{1:numSxs10d250ms,1});
    drumPopAvg10d250ms = mean(drumAvg10d250ms,2);

    subplot(2,1,1)
    hold on
    plot(linearTrialEyeBegin10d250ms)
    plot(drumAvg10d250ms)
    ylabel('Velocity')
    title('Each subjects avg eye vel. during first 2 blocks')

    subplot(2,1,2)
    hold on
    plot(linearTrialEyeEnd10d250ms)
    plot(drumAvg10d250ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    title('Each subjects avg eye vel. during last 2 blocks')

    figure()
    hold on
    plot(linearTrialEyeBeginAvg10d250ms)
    plot(linearTrialEyeEndAvg10d250ms)
    plot(drumPopAvg10d250ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    legend('First 2 blocks avg','Last 2 blocks avg','Drum vel.')
    title('Population avg eye vel. during first and last 2 blocks')

    %% Concatenate MAD data and further analyses
    madEyeBegin10d250ms = cat(2,madFirstAvg{1:numSxs10d250ms,1});
    madEyeBeginAvg10d250ms = mean(madEyeBegin10d250ms,2);
    madEyeEnd10d250ms = cat(2,madLastAvg{1:numSxs10d250ms,1});
    madEyeEndAvg10d250ms = mean(madEyeEnd10d250ms,2);

    subplot(2,1,1)
    hold on
    plot(madEyeBegin10d250ms)
    plot(drumAvg10d250ms)
    ylabel('Velocity')
    title('Each subjects avg eye vel. during first 2 blocks')

    subplot(2,1,2)
    hold on
    plot(madEyeEnd10d250ms)
    plot(drumAvg10d250ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    title('Each subjects avg eye vel. during last 2 blocks')

    figure()
    hold on
    plot(madEyeBeginAvg10d250ms)
    plot(madEyeEndAvg10d250ms)
    plot(drumPopAvg10d250ms)
    xlabel('Trial time (ms)')


    ylabel('Velocity')
    legend('First 2 blocks avg','Last 2 blocks avg','Drum vel.')
    title('Population avg eye vel. during first and last 2 blocks')

    %% Concatenate relative eye data and further analyses
    relEyeBegin10d250ms = cat(1,madRelFirstAvg{1:numSxs10d250ms,1})';
    relEyeBeginAvg10d250ms = mean(relEyeBegin10d250ms,2);
    relEyeEnd10d250ms = cat(1,madRelLastAvg{1:numSxs10d250ms,1})';
    relEyeEndAvg10d250ms = mean(relEyeEnd10d250ms,2);
    drumRescale10d250ms = rescale(drumAvg10d250ms,-1,1);
    drumPopRescale10d250ms = rescale(drumPopAvg10d250ms,-1,1);

    subplot(2,1,1)
    hold on
    plot(relEyeBegin10d250ms)
    plot(drumPopRescale10d250ms)
    ylabel('Velocity')
    title('Each subjects avg eye vel. during first 2 blocks')
    ylim([-1 1.5])

    subplot(2,1,2)
    hold on
    plot(relEyeEnd10d250ms)
    plot(drumPopRescale10d250ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    title('Each subjects avg eye vel. during last 2 blocks')
    ylim([-1 1.5])

    figure()
    hold on
    plot(relEyeBeginAvg10d250ms)
    plot(relEyeEndAvg10d250ms)
    plot(drumPopRescale10d250ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    legend('First 2 blocks avg','Last 2 blocks avg','Drum vel.')
    title('Population avg eye vel. during first and last 2 blocks')
    ylim([-1 1.5])

    %% Concatenate pre and post data and further analyses
    preVdark10d250ms = cat(2,preDarkAvgAll{1:numSxs10d250ms,1});
    preVdarkAvg10d250ms = mean(preVdark10d250ms(2:end,:),2);
    postVdark10d250ms = cat(2,postDarkAvgAll{1:numSxs10d250ms,1});
    postVdarkAvg10d250ms = mean(postVdark10d250ms(2:end,:),2);
    preTurntable10d250ms = cat(2,preTurntableAvgAll{1:numSxs10d250ms,1});
    preTurntableAvg10d250ms = mean(preTurntable10d250ms(2:end,:),2);
    postTurntable10d250ms = cat(2,postTurntableAvgAll{1:numSxs10d250ms,1});
    postTurntableAvg10d250ms = mean(postTurntable10d250ms(2:end,:),2);

    subplot(2,1,1)
    hold on
    plot(preVdark10d250ms(2:end,:))
    plot(preTurntable10d250ms)
    ylabel('Velocity')
    title('Each subjects avg eye vel. during first 2 blocks')

    subplot(2,1,2)
    hold on
    plot(postVdark10d250ms(2:end,:))
    plot(postTurntable10d250ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    title('Each subjects avg eye vel. during last 2 blocks')

    figure()
    hold on
    plot(preVdarkAvg10d250ms)
    plot(postVdarkAvg10d250ms)
    plot(preTurntableAvg10d250ms)
    plot(postTurntableAvg10d250ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    legend('First 2 blocks avg','Last 2 blocks avg','Drum vel.')
    title('Population avg eye vel. during first and last 2 blocks')

    %% Concatenate spontaneous data and further analyses
    spEye10d250ms = cat(2,gapEyeAllAvg{1:numSxs10d250ms,1});
    spEyeAvg10d250ms = mean(spEye10d250ms,2);

    figure()
    hold on
    plot(spEye10d250ms)
    plot(spEyeAvg10d250ms,'LineWidth',3,'Color','k')
elseif condition == 1
    cuedBegin10d500ms = cat(1,cuedAvgFirst{1:numSxs10d500ms,2})';
    visualBegin10d500ms = cat(1,visualAvgFirst{1:numSxs10d500ms,2})';
    darkBegin10d500ms = cat(1,darkAvgFirst{1:numSxs10d500ms,2})';
    linearTrialEyeBegin10d500ms = zeros(tLength+delay2,numSxs10d500ms);
    linearTrialEyeBegin10d500ms(1:tLength/2,1:numSxs10d500ms) = darkBegin10d500ms(2:end,:);
    linearTrialEyeBegin10d500ms(tLength/2+1:tLength/2+delay2,1:numSxs10d500ms) = cuedBegin10d500ms(2:end,:);
    linearTrialEyeBegin10d500ms(tLength/2+delay2+1:tLength+delay2,1:numSxs10d500ms) = visualBegin10d500ms(2:end,:);
    linearTrialEyeBeginAvg10d500ms = mean(linearTrialEyeBegin10d500ms,2);

    cuedEnd10d500ms = cat(1,cuedAvgLast{1:numSxs10d500ms,2})';
    visualEnd10d500ms = cat(1,visualAvgLast{1:numSxs10d500ms,2})';
    darkEnd10d500ms = cat(1,darkAvgLast{1:numSxs10d500ms,2})';
    linearTrialEyeEnd10d500ms = zeros(tLength+delay2,numSxs10d500ms);
    linearTrialEyeEnd10d500ms(1:tLength/2,1:numSxs10d500ms) = darkEnd10d500ms(2:end,:);
    linearTrialEyeEnd10d500ms(tLength/2+1:tLength/2+delay2,1:numSxs10d500ms) = cuedEnd10d500ms(2:end,:);
    linearTrialEyeEnd10d500ms(tLength/2+delay2+1:tLength+delay2,1:numSxs10d500ms) = visualEnd10d500ms(2:end,:);
    linearTrialEyeEndAvg10d500ms = mean(linearTrialEyeEnd10d500ms,2);

    drumAvg10d500ms = cat(2,drumAll{1:numSxs10d500ms,2});
    drumPopAvg10d500ms = mean(drumAvg10d500ms,2);

    subplot(2,1,1)
    hold on
    plot(linearTrialEyeBegin10d500ms)
    plot(drumAvg10d500ms)
    ylabel('Velocity')
    title('Each subjects avg eye vel. during first 2 blocks')

    subplot(2,1,2)
    hold on
    plot(linearTrialEyeEnd10d500ms)
    plot(drumAvg10d500ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    title('Each subjects avg eye vel. during last 2 blocks')

    figure()
    hold on
    plot(linearTrialEyeBeginAvg10d500ms)
    plot(linearTrialEyeEndAvg10d500ms)
    plot(drumPopAvg10d500ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    legend('First 2 blocks avg','Last 2 blocks avg','Drum vel.')
    title('Population avg eye vel. during first and last 2 blocks')

    %% Concatenate MAD data and further analyses
    madEyeBegin10d500ms = cat(2,madFirstAvg{1:numSxs10d500ms,2});
    madEyeBeginAvg10d500ms = mean(madEyeBegin10d500ms,2);
    madEyeEnd10d500ms = cat(2,madLastAvg{1:numSxs10d500ms,2});
    madEyeEndAvg10d500ms = mean(madEyeEnd10d500ms,2);

    subplot(2,1,1)
    hold on
    plot(madEyeBegin10d500ms)
    plot(drumAvg10d500ms)
    ylabel('Velocity')
    title('Each subjects avg eye vel. during first 2 blocks')

    subplot(2,1,2)
    hold on
    plot(madEyeEnd10d500ms)
    plot(drumAvg10d500ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    title('Each subjects avg eye vel. during last 2 blocks')

    figure()
    hold on
    plot(madEyeBeginAvg10d500ms)
    plot(madEyeEndAvg10d500ms)
    plot(drumPopAvg10d500ms)
    xlabel('Trial time (ms)')


    ylabel('Velocity')
    legend('First 2 blocks avg','Last 2 blocks avg','Drum vel.')
    title('Population avg eye vel. during first and last 2 blocks')

    %% Concatenate relative eye data and further analyses
    relEyeBegin10d500ms = cat(1,madRelFirstAvg{1:numSxs10d500ms,2})';
    relEyeBeginAvg10d500ms = mean(relEyeBegin10d500ms,2);
    relEyeEnd10d500ms = cat(1,madRelLastAvg{1:numSxs10d500ms,2})';
    relEyeEndAvg10d500ms = mean(relEyeEnd10d500ms,2);
    drumRescale10d500ms = rescale(drumAvg10d500ms,-1,1);
    drumPopRescale10d500ms = rescale(drumPopAvg10d500ms,-1,1);

    subplot(2,1,1)
    hold on
    plot(relEyeBegin10d500ms)
    plot(drumPopRescale10d500ms)
    ylabel('Velocity')
    title('Each subjects avg eye vel. during first 2 blocks')
    ylim([-1 1.5])

    subplot(2,1,2)
    hold on
    plot(relEyeEnd10d500ms)
    plot(drumPopRescale10d500ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    title('Each subjects avg eye vel. during last 2 blocks')
    ylim([-1 1.5])

    figure()
    hold on
    plot(relEyeBeginAvg10d500ms)
    plot(relEyeEndAvg10d500ms)
    plot(drumPopRescale10d500ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    legend('First 2 blocks avg','Last 2 blocks avg','Drum vel.')
    title('Population avg eye vel. during first and last 2 blocks')
    ylim([-1 1.5])

    %% Concatenate pre and post data and further analyses
    preVdark10d500ms = cat(2,preDarkAvgAll{1:numSxs10d500ms,2});
    preVdarkAvg10d500ms = mean(preVdark10d500ms(2:end,:),2);
    postVdark10d500ms = cat(2,postDarkAvgAll{1:numSxs10d500ms,2});
    postVdarkAvg10d500ms = mean(postVdark10d500ms(2:end,:),2);
    preTurntable10d500ms = cat(2,preTurntableAvgAll{1:numSxs10d500ms,2});
    preTurntableAvg10d500ms = mean(preTurntable10d500ms(2:end,:),2);
    postTurntable10d500ms = cat(2,postTurntableAvgAll{1:numSxs10d500ms,2});
    postTurntableAvg10d500ms = mean(postTurntable10d500ms(2:end,:),2);

    subplot(2,1,1)
    hold on
    plot(preVdark10d500ms(2:end,:))
    plot(preTurntable10d500ms)
    ylabel('Velocity')
    title('Each subjects avg eye vel. during first 2 blocks')

    subplot(2,1,2)
    hold on
    plot(postVdark10d500ms(2:end,:))
    plot(postTurntable10d500ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    title('Each subjects avg eye vel. during last 2 blocks')

    figure()
    hold on
    plot(preVdarkAvg10d500ms)
    plot(postVdarkAvg10d500ms)
    plot(preTurntableAvg10d500ms)
    plot(postTurntableAvg10d500ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    legend('First 2 blocks avg','Last 2 blocks avg','Drum vel.')
    title('Population avg eye vel. during first and last 2 blocks')

    %% Concatenate spontaneous data and further analyses
    spEye10d500ms = cat(2,gapEyeAllAvg{1:numSxs10d500ms,2});
    spEyeAvg10d500ms = mean(spEye10d500ms,2);

    figure()
    hold on
    plot(spEye10d500ms)
    plot(spEyeAvg10d500ms,'LineWidth',3,'Color','k')
elseif condition == 2
    cuedBegin15d250ms = cat(1,cuedAvgFirst{1:numSxs15d250ms,1})';
    visualBegin15d250ms = cat(1,visualAvgFirst{1:numSxs15d250ms,1})';
    darkBegin15d250ms = cat(1,darkAvgFirst{1:numSxs15d250ms,1})';
    linearTrialEyeBegin15d250ms = zeros(tLength+delay1,numSxs15d250ms);
    linearTrialEyeBegin15d250ms(1:tLength/2,1:numSxs15d250ms) = darkBegin15d250ms(2:end,:);
    linearTrialEyeBegin15d250ms(tLength/2+1:tLength/2+delay1,1:numSxs15d250ms) = cuedBegin15d250ms(2:end,:);
    linearTrialEyeBegin15d250ms(tLength/2+delay1+1:tLength+delay1,1:numSxs15d250ms) = visualBegin15d250ms(2:end,:);
    linearTrialEyeBeginAvg15d250ms = mean(linearTrialEyeBegin15d250ms,2);

    cuedEnd15d250ms = cat(1,cuedAvgLast{1:numSxs15d250ms,1})';
    visualEnd15d250ms = cat(1,visualAvgLast{1:numSxs15d250ms,1})';
    darkEnd15d250ms = cat(1,darkAvgLast{1:numSxs15d250ms,1})';
    linearTrialEyeEnd15d250ms = zeros(tLength+delay1,numSxs15d250ms);
    linearTrialEyeEnd15d250ms(1:tLength/2,1:numSxs15d250ms) = darkEnd15d250ms(2:end,:);
    linearTrialEyeEnd15d250ms(tLength/2+1:tLength/2+delay1,1:numSxs15d250ms) = cuedEnd15d250ms(2:end,:);
    linearTrialEyeEnd15d250ms(tLength/2+delay1+1:tLength+delay1,1:numSxs15d250ms) = visualEnd15d250ms(2:end,:);
    linearTrialEyeEndAvg15d250ms = mean(linearTrialEyeEnd15d250ms,1);

    drumAvg15d250ms = cat(2,drumAll{1:numSxs15d250ms,1});
    drumPopAvg15d250ms = mean(drumAvg15d250ms,2);

    subplot(2,1,1)
    hold on
    plot(linearTrialEyeBegin15d250ms)
    plot(drumAvg15d250ms)
    ylabel('Velocity')
    title('Each subjects avg eye vel. during first 2 blocks')

    subplot(2,1,2)
    hold on
    plot(linearTrialEyeEnd15d250ms)
    plot(drumAvg15d250ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    title('Each subjects avg eye vel. during last 2 blocks')

    figure()
    hold on
    plot(linearTrialEyeBeginAvg15d250ms)
    plot(linearTrialEyeEndAvg15d250ms)
    plot(drumPopAvg15d250ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    legend('First 2 blocks avg','Last 2 blocks avg','Drum vel.')
    title('Population avg eye vel. during first and last 2 blocks')

    %% Concatenate MAD data and further analyses
    madEyeBegin15d250ms = cat(2,madFirstAvg{1:numSxs15d250ms,1});
    madEyeBeginAvg15d250ms = mean(madEyeBegin15d250ms,2);
    madEyeEnd15d250ms = cat(2,madLastAvg{1:numSxs15d250ms,1});
    madEyeEndAvg15d250ms = mean(madEyeEnd15d250ms,2);

    subplot(2,1,1)
    hold on
    plot(madEyeBegin15d250ms)
    plot(drumAvg15d250ms)
    ylabel('Velocity')
    title('Each subjects avg eye vel. during first 2 blocks')

    subplot(2,1,2)
    hold on
    plot(madEyeEnd15d250ms)
    plot(drumAvg15d250ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    title('Each subjects avg eye vel. during last 2 blocks')

    figure()
    hold on
    plot(madEyeBeginAvg15d250ms)
    plot(madEyeEndAvg15d250ms)
    plot(drumPopAvg15d250ms)
    xlabel('Trial time (ms)')


    ylabel('Velocity')
    legend('First 2 blocks avg','Last 2 blocks avg','Drum vel.')
    title('Population avg eye vel. during first and last 2 blocks')

    %% Concatenate relative eye data and further analyses
    relEyeBegin15d250ms = cat(1,madRelFirstAvg{1:numSxs15d250ms,1})';
    relEyeBeginAvg15d250ms = mean(relEyeBegin15d250ms,2);
    relEyeEnd15d250ms = cat(1,madRelLastAvg{1:numSxs15d250ms,1})';
    relEyeEndAvg15d250ms = mean(relEyeEnd15d250ms,2);
    drumRescale15d250ms = rescale(drumAvg15d250ms,-1,1);
    drumPopRescale15d250ms = rescale(drumPopAvg15d250ms,-1,1);

    subplot(2,1,1)
    hold on
    plot(relEyeBegin15d250ms)
    plot(drumPopRescale15d250ms)
    ylabel('Velocity')
    title('Each subjects avg eye vel. during first 2 blocks')
    ylim([-1 1.5])

    subplot(2,1,2)
    hold on
    plot(relEyeEnd15d250ms)
    plot(drumPopRescale15d250ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    title('Each subjects avg eye vel. during last 2 blocks')
    ylim([-1 1.5])

    figure()
    hold on
    plot(relEyeBeginAvg15d250ms)
    plot(relEyeEndAvg15d250ms)
    plot(drumPopRescale15d250ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    legend('First 2 blocks avg','Last 2 blocks avg','Drum vel.')
    title('Population avg eye vel. during first and last 2 blocks')
    ylim([-1 1.5])

    %% Concatenate pre and post data and further analyses
    preVdark15d250ms = cat(2,preDarkAvgAll{1:numSxs15d250ms,1});
    preVdarkAvg15d250ms = mean(preVdark15d250ms(2:end,:),2);
    postVdark15d250ms = cat(2,postDarkAvgAll{1:numSxs15d250ms,1});
    postVdarkAvg15d250ms = mean(postVdark15d250ms(2:end,:),2);
    preTurntable15d250ms = cat(2,preTurntableAvgAll{1:numSxs15d250ms,1});
    preTurntableAvg15d250ms = mean(preTurntable15d250ms(2:end,:),2);
    postTurntable15d250ms = cat(2,postTurntableAvgAll{1:numSxs15d250ms,1});
    postTurntableAvg15d250ms = mean(postTurntable15d250ms(2:end,:),2);

    subplot(2,1,1)
    hold on
    plot(preVdark15d250ms(2:end,:))
    plot(preTurntable15d250ms)
    ylabel('Velocity')
    title('Each subjects avg eye vel. during first 2 blocks')

    subplot(2,1,2)
    hold on
    plot(postVdark15d250ms(2:end,:))
    plot(postTurntable15d250ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    title('Each subjects avg eye vel. during last 2 blocks')

    figure()
    hold on
    plot(preVdarkAvg15d250ms)
    plot(postVdarkAvg15d250ms)
    plot(preTurntableAvg15d250ms)
    plot(postTurntableAvg15d250ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    legend('First 2 blocks avg','Last 2 blocks avg','Drum vel.')
    title('Population avg eye vel. during first and last 2 blocks')

    %% Concatenate spontaneous data and further analyses
    spEye15d250ms = cat(2,gapEyeAllAvg{1:numSxs15d250ms,1});
    spEyeAvg15d250ms = mean(spEye15d250ms,2);

    figure()
    hold on
    plot(spEye15d250ms)
    plot(spEyeAvg15d250ms,'LineWidth',3,'Color','k')
elseif condition == 3
    cuedBegin15d500ms = cat(1,cuedAvgFirst{1:numSxs15d500ms,2})';
    visualBegin15d500ms = cat(1,visualAvgFirst{1:numSxs15d500ms,2})';
    darkBegin15d500ms = cat(1,darkAvgFirst{1:numSxs15d500ms,2})';
    linearTrialEyeBegin15d500ms = zeros(tLength+delay2,numSxs15d500ms,2);
    linearTrialEyeBegin15d500ms(1:tLength/2,1:numSxs15d500ms) = darkBegin15d500ms(2:end,:);
    linearTrialEyeBegin15d500ms(tLength/2+1:tLength/2+delay2,1:numSxs15d500ms) = cuedBegin15d500ms(2:end,:);
    linearTrialEyeBegin15d500ms(tLength/2+delay2+1:tLength+delay2,1:numSxs15d500ms) = visualBegin15d500ms(2:end,:);
    linearTrialEyeBeginAvg15d500ms = mean(linearTrialEyeBegin15d500ms,2);

    cuedEnd15d500ms = cat(1,cuedAvgLast{1:numSxs15d500ms,2})';
    visualEnd15d500ms = cat(1,visualAvgLast{1:numSxs15d500ms,2})';
    darkEnd15d500ms = cat(1,darkAvgLast{1:numSxs15d500ms,2})';
    linearTrialEyeEnd15d500ms = zeros(tLength+delay2,numSxs15d500ms);
    linearTrialEyeEnd15d500ms(1:tLength/2,1:numSxs15d500ms) = darkEnd15d500ms(2:end,:);
    linearTrialEyeEnd15d500ms(tLength/2+1:tLength/2+delay2,1:numSxs15d500ms) = cuedEnd15d500ms(2:end,:);
    linearTrialEyeEnd15d500ms(tLength/2+delay2+1:tLength+delay2,1:numSxs15d500ms) = visualEnd15d500ms(2:end,:);
    linearTrialEyeEndAvg15d500ms = mean(linearTrialEyeEnd15d500ms,2);

    drumAvg15d500ms = cat(2,drumAll{1:numSxs15d500ms,2});
    drumPopAvg15d500ms = mean(drumAvg15d500ms,2);

    subplot(2,1,1)
    hold on
    plot(linearTrialEyeBegin15d500ms)
    plot(drumAvg15d500ms)
    ylabel('Velocity')
    title('Each subjects avg eye vel. during first 2 blocks')

    subplot(2,1,2)
    hold on
    plot(linearTrialEyeEnd15d500ms)
    plot(drumAvg15d500ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    title('Each subjects avg eye vel. during last 2 blocks')

    figure()
    hold on
    plot(linearTrialEyeBeginAvg15d500ms)
    plot(linearTrialEyeEndAvg15d500ms)
    plot(drumPopAvg15d500ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    legend('First 2 blocks avg','Last 2 blocks avg','Drum vel.')
    title('Population avg eye vel. during first and last 2 blocks')

    %% Concatenate MAD data and further analyses
    madEyeBegin15d500ms = cat(2,madFirstAvg{1:numSxs15d500ms,2});
    madEyeBeginAvg15d500ms = mean(madEyeBegin15d500ms,2);
    madEyeEnd15d500ms = cat(2,madLastAvg{1:numSxs15d500ms,2});
    madEyeEndAvg15d500ms = mean(madEyeEnd15d500ms,2);

    subplot(2,1,1)
    hold on
    plot(madEyeBegin15d500ms)
    plot(drumAvg15d500ms)
    ylabel('Velocity')
    title('Each subjects avg eye vel. during first 2 blocks')

    subplot(2,1,2)
    hold on
    plot(madEyeEnd15d500ms)
    plot(drumAvg15d500ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    title('Each subjects avg eye vel. during last 2 blocks')

    figure()
    hold on
    plot(madEyeBeginAvg15d500ms)
    plot(madEyeEndAvg15d500ms)
    plot(drumPopAvg15d500ms)
    xlabel('Trial time (ms)')


    ylabel('Velocity')
    legend('First 2 blocks avg','Last 2 blocks avg','Drum vel.')
    title('Population avg eye vel. during first and last 2 blocks')

    %% Concatenate relative eye data and further analyses
    relEyeBegin15d500ms = cat(1,madRelFirstAvg{1:numSxs15d500ms,2})';
    relEyeBeginAvg15d500ms = mean(relEyeBegin15d500ms,2);
    relEyeEnd15d500ms = cat(1,madRelLastAvg{1:numSxs15d500ms,2})';
    relEyeEndAvg15d500ms = mean(relEyeEnd15d500ms,2);
    drumRescale15d500ms = rescale(drumAvg15d500ms,-1,1);
    drumPopRescale15d500ms = rescale(drumPopAvg15d500ms,-1,1);

    subplot(2,1,1)
    hold on
    plot(relEyeBegin15d500ms)
    plot(drumPopRescale15d500ms)
    ylabel('Velocity')
    title('Each subjects avg eye vel. during first 2 blocks')
    ylim([-1 1.5])

    subplot(2,1,2)
    hold on
    plot(relEyeEnd15d500ms)
    plot(drumPopRescale15d500ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    title('Each subjects avg eye vel. during last 2 blocks')
    ylim([-1 1.5])

    figure()
    hold on
    plot(relEyeBeginAvg15d500ms)
    plot(relEyeEndAvg15d500ms)
    plot(drumPopRescale15d500ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    legend('First 2 blocks avg','Last 2 blocks avg','Drum vel.')
    title('Population avg eye vel. during first and last 2 blocks')
    ylim([-1 1.5])

    %% Concatenate pre and post data and further analyses
    preVdark15d500ms = cat(2,preDarkAvgAll{1:numSxs15d500ms,2});
    preVdarkAvg15d500ms = mean(preVdark15d500ms(2:end,:),2);
    postVdark15d500ms = cat(2,postDarkAvgAll{1:numSxs15d500ms,2});
    postVdarkAvg15d500ms = mean(postVdark15d500ms(2:end,:),2);
    preTurntable15d500ms = cat(2,preTurntableAvgAll{1:numSxs15d500ms,2});
    preTurntableAvg15d500ms = mean(preTurntable15d500ms(2:end,:),2);
    postTurntable15d500ms = cat(2,postTurntableAvgAll{1:numSxs15d500ms,2});
    postTurntableAvg15d500ms = mean(postTurntable15d500ms(2:end,:),2);

    subplot(2,1,1)
    hold on
    plot(preVdark15d500ms(2:end,:))
    plot(preTurntable15d500ms)
    ylabel('Velocity')
    title('Each subjects avg eye vel. during first 2 blocks')

    subplot(2,1,2)
    hold on
    plot(postVdark15d500ms(2:end,:))
    plot(postTurntable15d500ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    title('Each subjects avg eye vel. during last 2 blocks')

    figure()
    hold on
    plot(preVdarkAvg15d500ms)
    plot(postVdarkAvg15d500ms)
    plot(preTurntableAvg15d500ms)
    plot(postTurntableAvg15d500ms)
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    legend('First 2 blocks avg','Last 2 blocks avg','Drum vel.')
    title('Population avg eye vel. during first and last 2 blocks')

    %% Concatenate spontaneous data and further analyses
    spEye15d500ms = cat(2,gapEyeAllAvg{1:numSxs15d500ms,2});
    spEyeAvg15d500ms = mean(spEye15d500ms,2);

    figure()
    hold on
    plot(spEye15d500ms)
    plot(spEyeAvg15d500ms,'LineWidth',3,'Color','k')
end