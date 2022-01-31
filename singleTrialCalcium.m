%% Single trial analyses relating fluorescence to retinal slip, eye velocity, and head velocity
%Need to import dFtraining workspace data
smallWindow = 0;            %set small window = 1 for narrower window of cycle by cycle analysis, 0 is default
next_cycle_check = 250;     %number of samples to check the next cycle (i+1) for peak calcium responses
diffCutoff = 250;           %time difference of calcium event peak relative to stimulus peak to keep values within
switchTest = 1;             %when condition == 4, set to 0 for x2 or 1 for x0 analyses

lightSegLength = size(eyeVisualMatIn,1);       %total # of seconds for each condition (needs to match dFtraining reshapeNum(D,Sp) * numBlocks(L)
darkSegLength = size(eyeDarkMatIn,1);
spSegLength = size(eyeGapMatIn,1);
minPeakProm = 0.008;        %parameters for finding calcium events
minPeakDist = 300;
maxPeakWidth = 1000;
minPeakWidth = 100;

if exist('calSp_peak_amps')
    if ~isempty(calSp_peak_amps)
        calSp_peak_amps = [];
    end
end

if switchTest == 0
    if condition == 4 && desacCalcium == 1
        calVisualVector = calVisualMatIn(:);
        calVisualMatOutVector = calVisualMatOut(:)';
        calVisualMatOutVector = calVisualMatOutVector';
    else
        calVisualMatIn = calVisualMatIn';
        calVisualVector = calVisualMatIn(:);
        calVisualMatOutVector = calVisualMatOutVector;
    end
else
    if condition == 4 && desacCalcium == 1
        calVisualMatIn = calVisualMatIn2;
        calVisualVector = calVisualMatIn(:)';
        calVisualMatOutVector = calVisualMatOut2(:)';
        calVisualMatOutVector = calVisualMatOutVector';
        calVisualMatOut = calVisualMatOut2;
    else
        calVisualMatIn = calVisualMatIn2';
        calVisualVector = calVisualMatIn(:)';
        calVisualMatOutVector = calVisualMatOut2(:)';
        calVisualMatOutVector = calVisualMatOutVector';
        calVisualMatOut = calVisualMatOut2;
    end
end
if condition ~= 4
    calDarkMatIn = calDarkMatIn';
    calDarkVector = calDarkMatIn(:)';
    calGapMatIn = calGapMatIn';
    calGapVector = calGapMatIn(:)';
else
    if desacCalcium == 1
        calDarkMatIn = calDarkMatIn;
        calDarkVector = calDarkMatIn(:)';
        calGapMatIn = calGapMatIn;
        calGapVector = calGapMatIn(:)';
    else
        calDarkMatIn = calDarkMatIn';
        calDarkVector = calDarkMatIn(:)';
        calGapMatIn = calGapMatIn';
        calGapVector = calGapMatIn(:)';
    end
end

%% Calcium event detection for visual period
if expSubType ~= 3 && expSubType ~= 5
    [pks,locs,w,p] = findpeaks(calVisualVector,1,'MinPeakProminence',minPeakProm,'MinPeakDistance',minPeakDist,'Annotate','extents','MaxPeakWidth',maxPeakWidth,'MinPeakWidth',minPeakWidth);
    interPeakInterval = diff(locs);
    figure(); hold on
    findpeaks(calVisualVector,1,'MinPeakDistance',minPeakDist,'MinPeakProminence',minPeakProm,'Annotate','extents','MaxPeakWidth',maxPeakWidth,'MinPeakWidth',minPeakWidth)
    ylabel('\DeltaF/G')
    xlabel('Time (ms)')
    eventNumTotal = length(w);
    eventFrequency = eventNumTotal/size(calVisualMatIn,2);
    [locsMat(1,:),locsMat(2,:)] = ind2sub(size(calVisualMatIn),locs);

    figure()
    subplot(2,2,1); hold on
    histogram(pks,30)
    xlabel('\DeltaF/G')
    ylabel('Number of events')
    title('Peak amplitude')
    subplot(2,2,2); hold on
    histogram(interPeakInterval,30)
    xlabel('Inter-peak interval (ms)')
    ylabel('Number of events')
    title('Inter-peak interval')
    subplot(2,2,3); hold on
    histogram(w,30)
    xlabel('Time (ms)')
    ylabel('Number of events')
    title('Half-width')
    subplot(2,2,4); hold on
    text(500,10,num2str(eventFrequency))
    histogram(locsMat(1,:),30)
    xlabel('Time (ms)')
    ylabel('Number of events')
    title('Time of peaks')

    [pks2,locs2,w2,p2] = findpeaks(calVisualMatOutVector,1,'MinPeakProminence',minPeakProm,'MinPeakDistance',minPeakDist,'Annotate','extents','MaxPeakWidth',maxPeakWidth,'MinPeakWidth',minPeakWidth);
    interPeakInterval2 = diff(locs2);
    figure(); hold on
    findpeaks(calVisualMatOutVector,1,'MinPeakDistance',minPeakDist,'MinPeakProminence',minPeakProm,'Annotate','extents','MaxPeakWidth',maxPeakWidth,'MinPeakWidth',minPeakWidth)
    ylabel('\DeltaF/G')
    xlabel('Time (ms)')
    [locsMat2(1,:),locsMat2(2,:)] = ind2sub(size(calVisualMatOut),locs2);
    eventNumTotal(2) = length(w2);
    eventFrequency(2) = eventNumTotal(2)/size(calVisualMatIn,2);

    figure()
    subplot(2,2,1); hold on
    histogram(pks2,30)
    xlabel('\DeltaF/G')
    ylabel('Number of events')
    title('Peak amplitude')
    subplot(2,2,2); hold on
    histogram(interPeakInterval2,30)
    xlabel('Inter-peak interval (ms)')
    ylabel('Number of events')
    title('Inter-peak interval')
    subplot(2,2,3); hold on
    histogram(w2,30)
    xlabel('Time (ms)')
    ylabel('Number of events')
    title('Half-width')
    subplot(2,2,4); hold on
    histogram(locsMat2(1,:),30)
    text(500,10,num2str(eventFrequency(2)))
    xlabel('Time (ms)')
    ylabel('Number of events')
    title('Time of peaks')
end

%% Event detection for vestibular-dark period
if condition ~= 2
    [pks3,locs3,w3,p3] = findpeaks(calDarkVector,1,'MinPeakProminence',minPeakProm,'MinPeakDistance',minPeakDist,'Annotate','extents','MaxPeakWidth',maxPeakWidth,'MinPeakWidth',minPeakWidth);
    interPeakInterval3 = diff(locs3);
    figure(); hold on
    findpeaks(calDarkVector,1,'MinPeakDistance',minPeakDist,'MinPeakProminence',minPeakProm,'Annotate','extents','MaxPeakWidth',maxPeakWidth,'MinPeakWidth',minPeakWidth)
    ylabel('\DeltaF/G')
    xlabel('Time (ms)')
    eventNumTotal(3) = length(w3);
    eventFrequency(3) = eventNumTotal(3)/size(calDarkMatIn,2);
    [locsMat3(1,:),locsMat3(2,:)] = ind2sub(size(calDarkMatIn),locs3);

    figure()
    subplot(2,2,1); hold on
    histogram(pks3,30)
    xlabel('\DeltaF/G')
    ylabel('Number of events')
    title('Peak amplitude')
    subplot(2,2,2); hold on
    histogram(interPeakInterval3,30)
    xlabel('Inter-peak interval (ms)')
    ylabel('Number of events')
    title('Inter-peak interval')
    subplot(2,2,3); hold on
    histogram(w3,30)
    xlabel('Time (ms)')
    ylabel('Number of events')
    title('Half-width')
    subplot(2,2,4); hold on
    text(500,10,num2str(eventFrequency(3)))
    histogram(locsMat3(1,:),30)
    xlabel('Time (ms)')
    ylabel('Number of events')
    title('Time of peaks')

    calDarkMatOutVector = calDarkMatOutVector';
    [pks4,locs4,w4,p4] = findpeaks(calDarkMatOutVector,1,'MinPeakProminence',minPeakProm,'MinPeakDistance',minPeakDist,'Annotate','extents','MaxPeakWidth',maxPeakWidth,'MinPeakWidth',minPeakWidth);
    interPeakInterval4 = diff(locs4);
    figure(); hold on
    findpeaks(calDarkMatOutVector,1,'MinPeakDistance',minPeakDist,'MinPeakProminence',minPeakProm,'Annotate','extents','MaxPeakWidth',maxPeakWidth,'MinPeakWidth',minPeakWidth)
    ylabel('\DeltaF/G')
    xlabel('Time (ms)')
    [locsMat4(1,:),locsMat4(2,:)] = ind2sub(size(calDarkMatOut),locs4);
    eventNumTotal(4) = length(w4);
    eventFrequency(4) = eventNumTotal(4)/size(calVisualMatIn,2);

    figure()
    subplot(2,2,1); hold on
    histogram(pks4,30)
    xlabel('\DeltaF/G')
    ylabel('Number of events')
    title('Peak amplitude')
    subplot(2,2,2); hold on
    histogram(interPeakInterval4,30)
    xlabel('Inter-peak interval (ms)')
    ylabel('Number of events')
    title('Inter-peak interval')
    subplot(2,2,3); hold on
    histogram(w4,30)
    xlabel('Time (ms)')
    ylabel('Number of events')
    title('Half-width')
    subplot(2,2,4); hold on
    histogram(locsMat4(1,:),30)
    text(500,10,num2str(eventFrequency(4)))
    xlabel('Time (ms)')
    ylabel('Number of events')
    title('Time of peaks')
end
%% Event detection for gap period
[pks5,locs5,w5,p5] = findpeaks(calGapVector,1,'MinPeakProminence',minPeakProm,'MinPeakDistance',minPeakDist,'Annotate','extents','MaxPeakWidth',maxPeakWidth,'MinPeakWidth',minPeakWidth);
interPeakInterval5 = diff(locs5);
figure(); hold on
findpeaks(calGapVector,1,'MinPeakDistance',minPeakDist,'MinPeakProminence',minPeakProm,'Annotate','extents','MaxPeakWidth',maxPeakWidth,'MinPeakWidth',minPeakWidth)
ylabel('\DeltaF/G')
xlabel('Time (ms)')
eventNumTotal(5) = length(w5);
eventFrequency(5) = eventNumTotal(5)/size(calGapMatIn,2);
[locsMat5(1,:),locsMat5(2,:)] = ind2sub(size(calGapMatIn),locs5);

figure()
subplot(2,2,1); hold on
histogram(pks5,30)
xlabel('\DeltaF/G')
ylabel('Number of events')
title('Peak amplitude')
subplot(2,2,2); hold on
histogram(interPeakInterval5,30)
xlabel('Inter-peak interval (ms)')
ylabel('Number of events')
title('Inter-peak interval')
subplot(2,2,3); hold on
histogram(w5,30)
xlabel('Time (ms)')
ylabel('Number of events')
title('Half-width')
subplot(2,2,4); hold on
text(500,10,num2str(eventFrequency(3)))
histogram(locsMat5(1,:),30)
xlabel('Time (ms)')
ylabel('Number of events')
title('Time of peaks')

calDarkMatOutVector = calDarkMatOutVector';
[pks6,locs6,w6,p6] = findpeaks(calGapMatOutVector,1,'MinPeakProminence',minPeakProm,'MinPeakDistance',minPeakDist,'Annotate','extents','MaxPeakWidth',maxPeakWidth,'MinPeakWidth',minPeakWidth);
interPeakInterval6 = diff(locs6);
figure(); hold on
findpeaks(calGapMatOutVector,1,'MinPeakDistance',minPeakDist,'MinPeakProminence',minPeakProm,'Annotate','extents','MaxPeakWidth',maxPeakWidth,'MinPeakWidth',minPeakWidth)
ylabel('\DeltaF/G')
xlabel('Time (ms)')
[locsMat6(1,:),locsMat6(2,:)] = ind2sub(size(calGapMatOut),locs6);
eventNumTotal(6) = length(w6);
eventFrequency(6) = eventNumTotal(6)/size(calVisualMatIn,2);

figure()
subplot(2,2,1); hold on
histogram(pks6,30)
xlabel('\DeltaF/G')
ylabel('Number of events')
title('Peak amplitude')
subplot(2,2,2); hold on
histogram(interPeakInterval6,30)
xlabel('Inter-peak interval (ms)')
ylabel('Number of events')
title('Inter-peak interval')
subplot(2,2,3); hold on
histogram(w6,30)
xlabel('Time (ms)')
ylabel('Number of events')
title('Half-width')
subplot(2,2,4); hold on
histogram(locsMat6(1,:),30)
text(500,5,num2str(eventFrequency(6)))
xlabel('Time (ms)')
ylabel('Number of events')
title('Time of peaks')

%% Find start and end of calcium events
if expSubType ~= 3 && expSubType ~= 5 && condition ~= 4
    j = 1;
    k = 1;
    m = 1;
    base1 = NaN(size(eyeVisualMatIn,1)*2,1000);
    base2 = NaN(size(eyeVisualMatIn,1)*2,1000);
    for i = locs(1:end)
        if i < 1000
            for a = 1:i-1
                if calVisualVector(i-a) <= 0
                    base1(j,k) = i-a+1;
                else
                    base1(j,k) = NaN;
                end
                k = k+1;
            end

            for a = i:locs(j+1)
                if calVisualVector(a) <= 0
                    base2(j,m) = a;
                else
                    base2(j,m) = NaN;
                end
                m = m+1;
            end

            [~,col] = find(~isnan(base1(j,:)));
            if ~isempty(col)
                base1(j) = col(1);
            else
                base1(j) = 1;
            end

            [~,col1] = find(~isnan(base2(j,:)));
            if ~isempty(col1)
                base2(j) = col1(1);
            else
                base2(j) = i+500;
            end

        elseif i > length(calVisualVector)-1000
            for a = locs(j-1):i
                if calVisualVector(a) <= 0
                    base1(j,k) = a;
                else
                    base1(j,k) = NaN;
                end
                k = k+1;
            end

            lastEventTime = length(calVisualVector) - i;
            for a = 1:lastEventTime
                if calVisualVector(i+a) <= 0
                    base2(j,m) = i+a;
                else
                    base2(j,m) = NaN;
                end
                m = m+1;
            end

            [~,col] = find(~isnan(base1(j,:)));
            if ~isempty(col)
                base1(j) = i-col(1);
            else
                base1(j) = i-500;
            end

            [~,col1] = find(~isnan(base2(j,:)));
            if ~isempty(col1) && col1(end) < 1001
                base2(j) = i+col1(1);
            else
                base2(j) = length(calVisualVector);
            end

        else
            for a = 1:1000
                if calVisualVector(i-a) <= 0
                    base1(j,k) = i-a;
                else
                    base1(j,k) = NaN;
                end
                k = k+1;

                if calVisualVector(i+a) <= 0
                    base2(j,m) = i+a;
                else
                    base2(j,m) = NaN;
                end
                m = m+1;
            end

            [~,col] = find(~isnan(base1(j,:)));
            if ~isempty(col)
                base1(j) = i-col(1);
            else
                base1(j) = i-500;
            end

            [~,col1] = find(~isnan(base2(j,:)));
            if ~isempty(col1)
                base2(j) = i+col1(1);
            else
                base2(j) = i+500;
            end
        end
        j = j + 1;
        k = 1;
        m = 1;
    end
    eventStartIdx = base1(:,1);
    eventStart = eventStartIdx(~isnan(eventStartIdx));
    eventEndIdx = base2(:,1);
    eventEnd = eventEndIdx(~isnan(eventEndIdx));

    calEventsRemoved = calVisualVector;
    for i = 1:length(eventEnd)
        calEventsRemoved(eventStart(i):eventEnd(i)) = NaN;
    end
    calEventsRemovedReshape = reshape(calEventsRemoved,fr*(1/frequency),size(calVisualMatIn,2));
    calEventsRemovedCycAvg = nanmean(calEventsRemovedReshape,2);

    figure()
    subplot(2,1,1); hold on
    plot(calVisualVector)
    plot(calEventsRemoved)
    legend('Raw calcium','Events removed')
    ylabel('\DeltaF/G')
    title('Removal of calcium events')
    subplot(2,1,2); hold on
    plot(calEventsRemovedReshape)
    plot(calEventsRemovedCycAvg,'Color','k','LineWidth',2)
    ylabel('\DeltaF/G')
    xlabel('Time (ms)')
    title('Cycle average of non-events')

    figure(); hold on
    plot(calVisualVector)
    plot(calVisualMatOutVector)

    % Setting the threshold for calcium event based on percentile/stdev
    % calcium_upsampled = calcium_upsampled(~isnan(calcium_upsampled));
    % calcium_stdev = std(calcium_upsampled);
    % event_thresh = prctile(calcium_upsampled,30) + (calcium_stdev/thresh);

    %plot the desaccaded calcium data with threshold line
    % figure(1);
    % plot(calcium_upsampled,'color','g');
    % hold on
    % yline(event_thresh,'color','k');
end

%% 
if expSubType ~= 3 && expSubType ~= 5
    if switchTest == 0
        saccadesVisualVec = saccadesVisualMat(:);
        turntableVisualVec = turntableVisualMat(:);
        rsVec = rsSmoothDesacMat;
        rsVec = rsVec(:);
        eyeSmoothVisualMatOutVector = eyeSmoothVisualMatOut(:);
    else
        saccadesVisualVec = saccadesVisualMat2(:);
        turntableVisualVec = turntableVisualMat2(:);
        rsVec = rsSmoothDesacMat2;
        rsVec = rsVec(:);
        eyeSmoothVisualMatOutVector = eyeSmoothVisualMatOut2(:);
    end
    rsSpVec = cat(2,rsBlockMat{1:numBlocksGap,3});
    rsSpVec = rsSpVec(:);
end
saccadesDarkVec = saccadesDarkMat(:);
saccadesGapVec = saccadesGapMat(:);
turntableDarkVec = turntableDarkMat(:);
eyeSmoothDarkMatOutVector = eyeSmoothDarkMatOut(:);

% Reshape data for 1-second cycle analyses (analysis per column)
if expSubType ~= 3 && expSubType ~= 5
    ca_ns_chunks = reshape(calVisualMatOutVector,fr*(1/frequency),lightSegLength);
    headvel_chunks = reshape(turntableVisualVec,fr*(1/frequency),lightSegLength);
    rs_chunks = reshape(rsVec,fr*(1/frequency),lightSegLength);
    ds_chunks = reshape(saccadesVisualVec,fr*(1/frequency),lightSegLength);
    eyeL_chunks = reshape(eyeSmoothVisualMatOutVector,fr*(1/frequency),lightSegLength);
    rsSp_chunks = reshape(rsSpVec,fr*(1/frequency),spSegLength);
end

caD_ns_chunks = reshape(calDarkMatOutVector,fr*(1/frequency),darkSegLength);
caSp_ns_chunks = reshape(calGapMatOutVector,fr*(1/frequency),spSegLength);
headvelD_chunks = reshape(turntableDarkVec,fr*(1/frequency),darkSegLength);
dsD_chunks = reshape(saccadesDarkVec,fr*(1/frequency),darkSegLength);
dsSp_chunks = reshape(saccadesGapVec,fr*(1/frequency),spSegLength);
eyeD_chunks = reshape(eyeSmoothDarkMatOutVector,fr*(1/frequency),darkSegLength);
eyeSp_chunks = reshape(eyeGapOutVector,fr*(1/frequency),spSegLength);

% Create vectors of size(number of cycles) to perform individual cycle analysis
rs_peak_diffs = NaN(1,lightSegLength);          %variables for time difference of calcium relative to each stimulus
rsSp_peak_diffs = NaN(2,spSegLength);
headvel_peak_diffs = NaN(2,lightSegLength);
headvelD_peak_diffs = NaN(2,darkSegLength);
eyeL_peak_diffs = NaN(2,lightSegLength);
eyeD_peak_diffs = NaN(2,darkSegLength);
eyeSp_peak_diffs = NaN(2,spSegLength);

cal_peak_amps = NaN(1,lightSegLength);          %variables for maximum or minimum amplitude of stimuli or calcium
calD_peak_amps = NaN(1,darkSegLength);
calSp_peak_amps = NaN(1,spSegLength);
rs_peak_amps = NaN(2,lightSegLength);
rsSp_peak_amps = NaN(2,spSegLength);
headvel_peak_amps = NaN(2,lightSegLength);
headvelD_peak_amps = NaN(2,darkSegLength);
eyeL_peak_amps = NaN(2,lightSegLength);
eyeD_peak_amps = NaN(2,darkSegLength);
eyeSp_peak_amps = NaN(2,spSegLength);

cal_peak_idxs = NaN(1,lightSegLength);          %variables for the indexes of the max or min amplitude value of stimuli or calcium
calD_peak_idxs = NaN(1,darkSegLength);
calSp_peak_idxs = NaN(1,spSegLength);
rs_peak_idxs = NaN(2,lightSegLength);
rsSp_peak_idxs = NaN(2,spSegLength);
headvel_peak_idxs = NaN(2,lightSegLength);
headvelD_peak_idxs = NaN(2,darkSegLength);
eyeL_peak_idxs = NaN(2,lightSegLength);
eyeD_peak_idxs = NaN(2,darkSegLength);
eyeSp_peak_idxs = NaN(2,spSegLength);

calDauc = NaN(1,darkSegLength);                 %for area under the curv (AUC) analyses of each test condition
calLauc = NaN(1,lightSegLength);
calSpAuc = NaN(1,spSegLength);

eyeLampNextTrial = NaN(2,lightSegLength);
eyeLampIdxsNextTrial = NaN(2,lightSegLength);
calAmpPriorTrial = NaN(1,lightSegLength);
calAmpIdxPriorTrial = NaN(2,lightSegLength);
calLaucPriorTrial = NaN(1,lightSegLength);
if numTimeDark*numBlocksDark > numTimeVisual*numBlocksVisual
    calPriorTrialIdx = NaN(2,darkSegLength);
else
    calPriorTrialIdx = NaN(2,lightSegLength);
end
eyeDampNextTrial = NaN(2,darkSegLength);
eyeDampIdxsNextTrial = NaN(2,darkSegLength);
calDarkAmpPriorTrial = NaN(1,darkSegLength);
calDarkAmpIdxPriorTrial = NaN(1,darkSegLength);
calDaucPriorTrial = NaN(1,darkSegLength);

calLampNextTrialNoCS = NaN(2,lightSegLength);
calLampIdxNextTrialNoCS = NaN(2,lightSegLength);
calLaucNextTrialNoCS = NaN(2,lightSegLength);
calLaucIdxNextTrialNoCS = NaN(2,lightSegLength);
eyeLampNextTrialNoCS = NaN(2,lightSegLength);
eyeLampIdxNextTrialNoCS = NaN(2,lightSegLength);
eyeDampNextTrialNoCS = NaN(2,darkSegLength);
eyeDampIdxNextTrialNoCS = NaN(2,darkSegLength);

if exist('locsMat4')
    %cycle by cycle analysis
    for i = 1:darkSegLength
        calD_cycle = caD_ns_chunks(:,i);
        dsD_cycle = dsD_chunks(:,i);
        headvelD_cycle = headvelD_chunks(:,i);
        eyeD_cycle = eyeD_chunks(:,i);

        if ismember(i,locsMat4(2,:)) %ismember(1,dsD_cycle)
            %grab min or max of each cycle and populate vectors
            [calD_peak_amps(i), calD_peak_idxs(i)] = max(calD_cycle);
            [headvelD_peak_amps(1,i), headvelD_peak_idxs(1,i)] = max(headvelD_cycle);
            [headvelD_peak_amps(2,i), headvelD_peak_idxs(2,i)] = min(headvelD_cycle);
            [eyeD_peak_amps(1,i), eyeD_peak_idxs(1,i)] = max(eyeD_cycle);
            [eyeD_peak_amps(2,i), eyeD_peak_idxs(2,i)] = min(eyeD_cycle);

            calD_cycle = calD_cycle(~isnan(calD_cycle));
            calDauc(i) = trapz(calD_cycle(calD_cycle > 0));

            %calculate time difference between calcium and stimuli peaks
            headvelD_peak_diffs(1,i) = calD_peak_idxs(1,i) - headvelD_peak_idxs(1,i);
            headvelD_peak_diffs(2,i) = calD_peak_idxs(1,i) - headvelD_peak_idxs(2,i);
            eyeD_peak_diffs(1,i) = calD_peak_idxs(1,i) - eyeD_peak_idxs(1,i);
            eyeD_peak_diffs(2,i) = calD_peak_idxs(1,i) - eyeD_peak_idxs(2,i);
        end
        if i > 1
            if ~isnan(calD_peak_amps(i-1))
                [eyeDampNextTrial(1,i-1),eyeDampIdxsNextTrial(1,i-1)] = max(eyeD_cycle);
                [eyeDampNextTrial(2,i-1),eyeDampIdxsNextTrial(2,i-1)] = min(eyeD_cycle);
                calDarkAmpPriorTrial(i-1) = calD_peak_amps(i-1);
                calDarkAmpIdxPriorTrial(i-1) = calD_peak_idxs(i-1);
                calDaucPriorTrial(i-1) = calDauc(i-1);
                calPriorTrialIdx(1,i-1) = i-1;
            end
        end
        
        if smallWindow == 1
            headvelD_peak_diffs(headvelD_peak_diffs < -diffCutoff) = NaN;
            headvelD_peak_diffs(headvelD_peak_diffs > diffCutoff) = NaN;
            eyeD_peak_diffs(eyeD_peak_diffs < -diffCutoff) = NaN;
            eyeD_peak_diffs(eyeD_peak_diffs > diffCutoff) = NaN;
            
            headvelD_peak_amps(headvelD_peak_amps > 0) = NaN;
            headvelD_peak_amps(headvelD_peak_amps < -10) = NaN;
            eyeD_peak_amps(eyeD_peak_amps < 0) = NaN;
            eyeD_peak_amps(eyeD_peak_amps > 15) = NaN;
            
            headDX = find(headvelD_peak_diffs(1,:) < diffCutoff*2);
            eyeDX = find(eyeD_peak_diffs(1,:) < diffCutoff*2);
            
            [calPeakAmpsHD] = calD_peak_amps(headDX);
            [headvelDpeakAmps] = headvelD_peak_amps(headDX);
            [headvelDpeakDiffs] = headvelD_peak_diffs(headDX);
            
            [calDpeakAmpsE] = calD_peak_amps(eyeDX);
            [eyeDpeakAmps] = eyeD_peak_amps(eyeDX);
            [eyeDpeakDiffs] = eyeD_peak_diffs(eyeDX);
        end
    end
end

if expSubType ~= 3 && expSubType ~= 5
    for i = 1:lightSegLength
        if (condition == 1 || condition == 2 || switchTest == 0) && i < lightSegLength
            cal_cycle =  [ca_ns_chunks(next_cycle_check*(1/frequency)+1:end,i); ca_ns_chunks(1:next_cycle_check*(1/frequency), i+1)];
            ds_cycle =  [ds_chunks(next_cycle_check*(1/frequency)+1:end,i); ds_chunks(1:next_cycle_check*(1/frequency), i+1)];
            rs_cycle =  [rs_chunks(next_cycle_check*(1/frequency)+1:end,i); rs_chunks(1:next_cycle_check*(1/frequency), i+1)];
            headvel_cycle =  [headvel_chunks(next_cycle_check*(1/frequency)+1:end,i); headvel_chunks(1:next_cycle_check*(1/frequency), i+1)];
            eyeL_cycle =  [eyeL_chunks(next_cycle_check*(1/frequency)+1:end,i); eyeL_chunks(1:next_cycle_check*(1/frequency), i+1)];
        else
            cal_cycle = ca_ns_chunks(:,i);
            ds_cycle = ds_chunks(:,i);
            rs_cycle = rs_chunks(:,i);
            headvel_cycle = headvel_chunks(:,i);
            eyeL_cycle = eyeL_chunks(:,i);
        end

        if (condition == 0 || switchTest == 1) && i > 1
            cal_cycle = [ca_ns_chunks((fr*1/frequency)-next_cycle_check*(1/frequency):end, i-1); ca_ns_chunks(1:fr*(1/frequency)-next_cycle_check*(1/frequency),i)];
            ds_cycle = [ds_chunks((fr*1/frequency)-next_cycle_check*(1/frequency):end, i-1); ds_chunks(1:fr*(1/frequency)-next_cycle_check*(1/frequency),i)];
            rs_cycle = [rs_chunks((fr*1/frequency)-next_cycle_check*(1/frequency):end, i-1); rs_chunks(1:fr*(1/frequency)-next_cycle_check*(1/frequency),i)];
            headvel_cycle = [headvel_chunks((fr*1/frequency)-next_cycle_check*(1/frequency):end, i-1); headvel_chunks(1:fr*(1/frequency)-next_cycle_check*(1/frequency),i)];
            eyeL_cycle = [eyeL_chunks((fr*1/frequency)-next_cycle_check*(1/frequency):end, i-1); eyeL_chunks(1:fr*(1/frequency)-next_cycle_check*(1/frequency),i)];
        elseif i == 1 && condition == 0
            cal_cycle = ca_ns_chunks(:,i);
            ds_cycle = ds_chunks(:,i);
            rs_cycle = rs_chunks(:,i);
            headvel_cycle = headvel_chunks(:,i);
            eyeL_cycle = eyeL_chunks(:,i);
        end
        
        %evaluate whether the calcium transient happens in the following
        %cycle or current cycle
        if (condition == 1 || condition == 2 || switchTest == 0) && i ~= lightSegLength
            if ismember(i,locsMat2(2,:))
                [~,nextCycIdx] = find(i==locsMat2(2,:));
                if locsMat2(1,nextCycIdx) > next_cycle_check*(1/frequency)
                    nextCyc1 = 1;
                else
                    nextCyc1 = 0;
                end
            else
                nextCyc1 = 0;
            end
            if ismember(i+1,locsMat2(2,:))
                [~,nextCycIdx] = find(i+1==locsMat2(2,:));
                if locsMat2(1,nextCycIdx) <= next_cycle_check*(1/frequency)
                    nextCyc2 = 1;
                else
                    nextCyc2 = 0;
                end
            else
                nextCyc2 = 0;
            end
        elseif condition == 0 || switchTest == 1
            if ismember(i,locsMat2(2,:))
                    [~,nextCycIdx] = find(i==locsMat2(2,:));
                        if locsMat2(1,nextCycIdx) <= fr*(1/frequency)-next_cycle_check*(1/frequency)
                            nextCyc1 = 1;
                        else
                            nextCyc1 = 0;
                        end
            else
                nextCyc1 = 0;
            end
            if ismember(i-1,locsMat2(2,:))
                    [~,nextCycIdx] = find(i-1==locsMat2(2,:));
                        if locsMat2(1,nextCycIdx) >= fr*(1/frequency)-next_cycle_check*(1/frequency)
                            nextCyc2 = 1;
                        else
                            nextCyc2 = 0;
                        end
            else
                nextCyc2 = 0;
            end
        end

        if nextCyc1 == 1 || nextCyc2 == 1
            proceed = 1;
        else
            proceed = 0;
        end

        if proceed == 1 %ismember(1,ds_cycle)
            %grab max or min and populate vectors
            [cal_peak_amps(i), cal_peak_idxs(i)] = max(cal_cycle);
            [rs_peak_amps(1,i), rs_peak_idxs(1,i)] = max(rs_cycle);
            [rs_peak_amps(2,i), rs_peak_idxs(2,i)] = min(rs_cycle);
            [headvel_peak_amps(1,i), headvel_peak_idxs(1,i)] = max(headvel_cycle);
            [headvel_peak_amps(2,i), headvel_peak_idxs(2,i)] = min(headvel_cycle);
            [eyeL_peak_amps(1,i),eyeL_peak_idxs(1,i)] = max(eyeL_cycle);
            [eyeL_peak_amps(2,i),eyeL_peak_idxs(2,i)] = min(eyeL_cycle);
            cal_cycle = cal_cycle(~isnan(cal_cycle));
            calLauc(i) = trapz(cal_cycle(cal_cycle > 0));

            if i < lightSegLength && (condition == 1 || condition == 2 || switchTest == 0)
                cal_peak_idxs(i) = cal_peak_idxs(i) + next_cycle_check;
                rs_peak_idxs(1,i) = rs_peak_idxs(1,i) + next_cycle_check;
                rs_peak_idxs(2,i) = rs_peak_idxs(2,i) + next_cycle_check;
                eyeL_peak_idxs(1,i) = eyeL_peak_idxs(1,i) + next_cycle_check;
                eyeL_peak_idxs(2,i) = eyeL_peak_idxs(2,i) + next_cycle_check;
                headvel_peak_idxs(1,i) = headvel_peak_idxs(1,i) + next_cycle_check;
                headvel_peak_idxs(2,i) = headvel_peak_idxs(2,i) + next_cycle_check;
            end
            if i > 1 && condition == 0 || switchTest == 1
                cal_peak_idxs(i) = cal_peak_idxs(i) - next_cycle_check;
                rs_peak_idxs(1,i) = rs_peak_idxs(1,i) - next_cycle_check;
                rs_peak_idxs(2,i) = rs_peak_idxs(2,i) - next_cycle_check;
                eyeL_peak_idxs(1,i) = eyeL_peak_idxs(1,i) - next_cycle_check;
                eyeL_peak_idxs(2,i) = eyeL_peak_idxs(2,i) - next_cycle_check;
                headvel_peak_idxs(1,i) = headvel_peak_idxs(1,i) - next_cycle_check;
                headvel_peak_idxs(2,i) = headvel_peak_idxs(2,i) - next_cycle_check;
            end
            rs_peak_diffs(1,i) = cal_peak_idxs(i) - rs_peak_idxs(1,i);
            rs_peak_diffs(2,i) = cal_peak_idxs(i) - rs_peak_idxs(2,i);
            headvel_peak_diffs(1,i) = cal_peak_idxs(i) - headvel_peak_idxs(1,i);
            headvel_peak_diffs(2,i) = cal_peak_idxs(i) - headvel_peak_idxs(2,i);
            eyeL_peak_diffs(1,i) = cal_peak_idxs(i) - eyeL_peak_idxs(1,i);
            eyeL_peak_diffs(2,i) = cal_peak_idxs(i) - eyeL_peak_idxs(2,i);
        end
        if i > 1
            if ~isnan(cal_peak_amps(i-1))
                [eyeLampNextTrial(1,i-1),eyeLampIdxsNextTrial(1,i-1)] = max(eyeL_cycle);
                [eyeLampNextTrial(2,i-1),eyeLampIdxsNextTrial(2,i-1)] = min(eyeL_cycle);
                calAmpPriorTrial(i-1) = cal_peak_amps(i-1);
                calAmpIdxPriorTrial(1,i-1) = rs_peak_diffs(1,i-1);
                calAmpIdxPriorTrial(2,i-1) = rs_peak_diffs(2,i-1);
                calLaucPriorTrial(i-1) = calLauc(i-1);
                calPriorTrialIdx(2,i-1) = i-1;
            
                if rs_peak_diffs(2,i-1) <= 75 || rs_peak_diffs(2,i-1) >= 300
                    [calLampNextTrialNoCS(1,i-1),calLampIdxNextTrialNoCS(1,i-1)] = max(cal_cycle);
                    [calLaucNextTrialNoCS(1,i-1),calLampIdxNextTrialNoCS(1,i-1)] = max(cal_cycle);
                    [eyeLampNextTrialNoCS(1,i-1),eyeLampIdxNextTrialNoCS(1,i-1)] = max(eyeL_cycle);
                    [eyeLampNextTrialNoCS(2,i-1),eyeLampIdxNextTrialNoCS(2,i-1)] = min(eyeL_cycle);
                else
                    [calLampNextTrialNoCS(2,i-1),calLampIdxNextTrialNoCS(2,i-1)] = max(cal_cycle);
                    [calLaucNextTrialNoCS(2,i-1),calLampIdxNextTrialNoCS(2,i-1)] = max(cal_cycle);
                    [eyeLampNextTrialNoCS(1,i-1),eyeLampIdxNextTrialNoCS(1,i-1)] = max(eyeL_cycle);
                    [eyeLampNextTrialNoCS(2,i-1),eyeLampIdxNextTrialNoCS(2,i-1)] = min(eyeL_cycle);
                end
            end

            if smallWindow == 1
                rs_peak_amps(rs_peak_amps > 2) = NaN;
                rs_peak_amps(rs_peak_amps < -22) = NaN;
                headvel_peak_amps(headvel_peak_amps > 12) = NaN;
                headvel_peak_amps(headvel_peak_amps < 0) = NaN;
                eyeL_peak_amps(eyeL_peak_amps < -22) = NaN;
                eyeL_peak_amps(eyeL_peak_amps > 0) = NaN;

                rs_peak_diffs(rs_peak_diffs < -diffCutoff) = NaN;
                rs_peak_diffs(rs_peak_diffs > diffCutoff*2) = NaN;
                headvel_peak_diffs(headvel_peak_diffs < -diffCutoff) = NaN;
                headvel_peak_diffs(headvel_peak_diffs > diffCutoff*2) = NaN;
                eyeL_peak_diffs(eyeL_peak_diffs < -diffCutoff) = NaN;
                eyeL_peak_diffs(eyeL_peak_diffs > diffCutoff*2) = NaN;

                rsX = find(rs_peak_diffs(2,:) < diffCutoff*2);
                headX = find(headvel_peak_diffs(1,:) < diffCutoff*2);
                eyeX = find(eyeL_peak_diffs(2,:) < diffCutoff*2);

                [calPeakAmps] = cal_peak_amps(rsX);
                [rsPeakAmps] = rs_peak_amps(rsX);
                [rsPeakDiffs] = rs_peak_diffs(rsX);

                [calPeakAmpsH] = cal_peak_amps(headX);
                [headvelPeakAmps] = headvel_peak_amps(headX);
                [headvelPeakDiffs] = headvel_peak_diffs(headX);

                [calPeakAmpsE] = cal_peak_amps(eyeX);
                [eyeLpeakAmps] = eyeL_peak_amps(eyeX);
                [eyeLpeakDiffs] = eyeL_peak_diffs(eyeX);
            end
        end
    end
end

for i = 1:spSegLength
    calSp_cycle = caSp_ns_chunks(:,i);
    dsSp_cycle = dsSp_chunks(:,i);
    if expSubType ~= 3 && expSubType ~= 5
        rsSp_cycle = rsSp_chunks(:,i);
    end
    eyeSp_cycle = eyeSp_chunks(:,i);
    
    if ismember(i,locsMat6(2,:)) %ismember(1,dsSp_cycle)
        [calSp_peak_amps(i), calSp_peak_idxs(i)] = max(calSp_cycle);
        [eyeSp_peak_amps(1,i), eyeSp_peak_idxs(1,i)] = max(eyeSp_cycle);
        [eyeSp_peak_amps(2,i), eyeSp_peak_idxs(2,i)] = min(eyeSp_cycle);
        if expSubType ~= 3 && expSubType ~= 5
            [rsSp_peak_amps(1,i), rsSp_peak_idxs(1,i)] = max(rsSp_cycle);
            [rsSp_peak_amps(2,i), rsSp_peak_idxs(2,i)] = min(rsSp_cycle);
        end
        calSp_cycle = calSp_cycle(~isnan(calSp_cycle));
        calSpAuc(i) = trapz(calSp_cycle(calSp_cycle > 0));
        
        if expSubType ~= 3 && expSubType ~= 5
            rsSp_peak_diffs(1,i) = calSp_peak_idxs(i) - rsSp_peak_idxs(1,i);
            rsSp_peak_diffs(2,i) = calSp_peak_idxs(i) - rsSp_peak_idxs(2,i);
        end
        eyeSp_peak_diffs(1,i) = calSp_peak_idxs(i) - eyeSp_peak_idxs(1,i);
        eyeSp_peak_diffs(2,i) = calSp_peak_idxs(i) - eyeSp_peak_idxs(2,i);
    end
end

%% calcium amplitude and AUC averaging and plotting
calEventAmpsAvg = nanmean(cal_peak_amps);
calEventAmpsAvg(2) = nanmean(calD_peak_amps);
calEventAmpsAvg(3) = nanmean(calSp_peak_amps);
calEventAmpsSE = nanstd(cal_peak_amps)/sqrt(numel(cal_peak_amps));
calEventAmpsSE(2) = nanstd(calD_peak_amps)/sqrt(numel(calD_peak_amps));
calEventAmpsSE(3) = nanstd(calSp_peak_amps)/sqrt(numel(calSp_peak_amps));

calDaucNew = calDauc(calDauc~=0);
calLaucNew = calLauc(calLauc~=0);
calSpAucNew = calSpAuc(calSpAuc~=0);
calDaucAvg = nanmean(calDaucNew);
calLaucAvg = nanmean(calLaucNew);
calSpAucAvg = nanmean(calSpAucNew);
calDaucSE = nanstd(calDaucNew)/sqrt(numel(calDaucNew));
calLaucSE = nanstd(calLaucNew)/sqrt(numel(calLaucNew));
calSpAucSE = nanstd(calSpAucNew)/sqrt(numel(calSpAucNew));

figure()
subplot(1,2,1); hold on
bar(calEventAmpsAvg,'FaceColor','w','LineWidth',1)
ylabel('\DeltaF/G')
xticks(1:3)
xticklabels({'Vdark','Visual','Sp'})
scatter(ones(size(cal_peak_amps)),cal_peak_amps)
scatter(ones(size(calD_peak_amps)).*2,calD_peak_amps)
scatter(ones(size(calSp_peak_amps)).*3,calSp_peak_amps)
errorbar(calEventAmpsAvg,calEventAmpsSE,'Color','k','LineStyle','none','LineWidth',2)
xticks(1:3)
xticklabels({'Visual','Vdark','Sp'})

subplot(1,2,2); hold on
bar([calLaucAvg;calDaucAvg;calSpAucAvg],'FaceColor','w','LineWidth',1)
scatter(ones(size(calLauc)),calLauc)
scatter(ones(size(calDauc)).*2,calDauc)
scatter(ones(size(calSpAuc)).*3,calSpAuc)
errorbar([calLaucAvg;calDaucAvg;calSpAucAvg],[calLaucSE;calDaucSE;calSpAucSE],'Color','k','LineStyle','none','LineWidth',2)
xticks(1:3)
xticklabels({'Visual','Vdark','Sp'})
ylabel('AUC')

%% Normalize events
b = 1;
for a = numTimeGap/(1/frequency):(numTimeGap/(1/frequency)):spSegLength
    spEventNorm(b) = nanmean(calSp_peak_amps(a-(numTimeGap/(1/frequency))+1:a));
    spAucNorm(b) = nanmean(calSpAuc(a-(numTimeGap/(1/frequency))+1:a));
    b = b + 1;
end

for a = 2:numBlocksGap
    spEventNormNew(a-1) = nanmean([spEventNorm(a) spEventNorm(a-1)]);
    spAucNormNew(a-1) = nanmean([spAucNorm(a) spAucNorm(a-1)]);
end

if protocol ~= 2 && condition ~= 2
    c = 3;
elseif numBlocksVisual < 3 && numBlocksVisual >= 1
    c = 1;
else
    c = 2;
end
calNorm = NaN(1,length(cal_peak_amps));
calAucNorm = NaN(1,length(cal_peak_amps));
timeKeep = 1;
for a = 1:numBlocksVisual
    for i = timeKeep:timeKeep+(numTimeVisual/(1/frequency))-1
        calNorm(i) = cal_peak_amps(i) / spEventNormNew(c);
        calAucNorm(i) = calLauc(i) / spAucNormNew(c);
    end
    timeKeep = timeKeep + (numTimeVisual/(1/frequency));
    c = c + 1;
end
calNormAvg = nanmean(calNorm);
calAucNormAvg = nanmean(calAucNorm);
calNormSE = nanstd(calNorm)/sqrt(numel(calNorm));
calAucNormSE = nanstd(calAucNorm)/sqrt(numel(calAucNorm));

i = 1;
c = 1;
timeKeep = 1;
calDarkNorm = NaN(1,length(calD_peak_amps));
calDarkAucNorm = NaN(1,length(calD_peak_amps));
if expSubType ~= 3 && expSubType ~= 5
    for a = 1:numBlocksDark-1
        for i = timeKeep:timeKeep+(numTimeDark/(1/frequency))-1
            calDarkNorm(i) = calD_peak_amps(i) / spEventNormNew(c);
            calDarkAucNorm(i) = calDauc(i) / spAucNormNew(c);
        end
        timeKeep = timeKeep + (numTimeDark/(1/frequency));
        c = c + 1;
    end
else
    for a = 1:numBlocksDark
        for i = timeKeep:timeKeep+(numTimeDark/(1/frequency))-1
            calDarkNorm(i) = calD_peak_amps(i) / spEventNorm(c);
            calDarkAucNorm(i) = calDauc(i) / spAucNorm(c);
        end
        timeKeep = timeKeep + (numTimeDark/(1/frequency));
        c = c + 1;
    end
end
calDarkNormAvg = nanmean(calDarkNorm);
calDarkAucNormAvg = nanmean(calDarkAucNorm);
calDarkNormSE = nanstd(calDarkNorm)/sqrt(numel(calDarkNorm));
calDarkAucNormSE = nanstd(calDarkAucNorm)/sqrt(numel(calDarkAucNorm));

figure()
subplot(1,2,1); hold on
bar([calNormAvg calDarkNormAvg],'FaceColor','w','LineWidth',1)
scatter(ones(size(calNorm)),calNorm)
scatter(ones(size(calDarkNorm)).*2,calDarkNorm)
xticks(1:2)
xticklabels({'Visual' 'Vdark'})
ylabel('\DeltaF/G (normalized)')
yline(1,'LineStyle','--')
errorbar([calNormAvg calDarkNormAvg],[calNormSE calDarkNormSE],'Color','k','LineStyle','none','LineWidth',2)
subplot(1,2,2); hold on
bar([calAucNormAvg calDarkAucNormAvg],'FaceColor','w','LineWidth',1)
scatter(ones(size(calAucNorm)),calAucNorm)
scatter(ones(size(calDarkAucNorm)).*2,calDarkAucNorm)
xticks(1:2)
xticklabels({'Visual' 'Vdark'})
ylabel('AUC (normalized)')
yline(1,'LineStyle','--')
errorbar([calAucNormAvg calDarkAucNormAvg],[calAucNormSE calDarkAucNormSE],'Color','k','LineStyle','none','LineWidth',2)

%% next trial effect
calDarkNormPriorTrial = NaN(1,length(calD_peak_amps));
calAucDarkNormPriorTrial = NaN(1,length(calD_peak_amps));
calNormPriorTrial = NaN(1,length(cal_peak_amps));
calAucNormPriorTrial = NaN(1,length(cal_peak_amps));
if condition ~= 2 && expSubType ~= 3 && expSubType ~= 5
    for i = 1:length(calD_peak_amps)
        if ~isnan(calPriorTrialIdx(1,i))
            calDarkNormPriorTrial(i) = calDarkNorm(i);
            calAucDarkNormPriorTrial(i) = calDarkAucNorm(i);
        else
            calDarkNormPriorTrial(i) = NaN;
            calAucDarkNormPriorTrial(i) = NaN;
        end
    end
    for i = 1:length(cal_peak_amps)
        if ~isnan(calPriorTrialIdx(2,i))
            calNormPriorTrial(i) = calNorm(i);
            calAucNormPriorTrial(i) = calAucNorm(i);
        else
            calNormPriorTrial(i) = NaN;
            calAucNormPriorTrial(i) = NaN;
        end
    end
elseif expSubType == 3 || expSubType == 5
    for i = 1:length(calD_peak_amps)
        if ~isnan(calPriorTrialIdx(1,i))
            calDarkNormPriorTrial(i) = calDarkNorm(i);
            calAucDarkNormPriorTrial(i) = calDarkAucNorm(i);
        else
            calDarkNormPriorTrial(i) = NaN;
            calAucDarkNormPriorTrial(i) = NaN;
        end
    end
elseif condition == 2
	for i = 1:length(cal_peak_amps)
        if ~isnan(calPriorTrialIdx(2,i))
            calNormPriorTrial(i) = calNorm(i);
            calAucNormPriorTrial(i) = calAucNorm(i);
        else
            calNormPriorTrial(i) = NaN;
            calAucNormPriorTrial(i) = NaN;
        end
    end
end

if condition ~= 2
    figure('Name','Vdark, next trial effect (norm)')
    subplot(2,1,1); hold on
    scatter(abs(eyeDampNextTrial(2,:)),calDarkNormPriorTrial)
    [calDarkNormPriorTrialFit,calDarkNormPriorTrialFitR2] = linearFitting(abs(eyeDampNextTrial(2,:)),calDarkNormPriorTrial);
    plot(calDarkNormPriorTrialFit)
    legend off
    text(prctile(abs(eyeDampNextTrial(2,:)),50),prctile(calDarkNormPriorTrial,95),['R^2=' num2str(round(calDarkNormPriorTrialFitR2,3))])
    ylabel('Amp')
    xlabel('Eye vel.')
    title('Vdark -- next trial effect')

    subplot(2,1,2); hold on
    scatter(abs(eyeDampNextTrial(2,:)),calAucDarkNormPriorTrial)
    [calAucDarkNormPriorTrialFit,calAucDarkNormPriorTrialFitR2] = linearFitting(abs(eyeDampNextTrial(2,:)),calAucDarkNormPriorTrial);
    plot(calAucDarkNormPriorTrialFit)
    legend off
    text(prctile(abs(eyeDampNextTrial(2,:)),50),prctile(calAucDarkNormPriorTrial,95),['R^2=' num2str(round(calAucDarkNormPriorTrialFitR2,3))])
    ylabel('AUC')
    xlabel('Eye vel.')
    title('')
end

figure('Name','Visual, next trial effect (norm)')
subplot(2,1,1); hold on
scatter(abs(eyeLampNextTrial(2,:)),calNormPriorTrial)
[calNormPriorTrialFit,calNormPriorTrialFitR2] = linearFitting(abs(eyeLampNextTrial(2,:)),calNormPriorTrial);
plot(calNormPriorTrialFit)
legend off
text(prctile(abs(eyeLampNextTrial(2,:)),50),prctile(calNormPriorTrial,95),['R^2=' num2str(round(calNormPriorTrialFitR2,3))])
ylabel('Amp')
xlabel('Eye vel.')
title('Visual -- next trial effect')

subplot(2,1,2); hold on
scatter(abs(eyeLampNextTrial(2,:)),calAucNormPriorTrial)
[calAucNormPriorTrialFit,calAucNormPriorTrialFitR2] = linearFitting(abs(eyeLampNextTrial(2,:)),calAucNormPriorTrial);
plot(calAucNormPriorTrialFit)
legend off
text(prctile(abs(eyeLampNextTrial(2,:)),50),prctile(calAucNormPriorTrial,95),['R^2=' num2str(round(calAucNormPriorTrialFitR2,3))])
ylabel('AUC')
xlabel('Eye vel.')
title('')


%% Remove NaNs from vectors for correlation analyses
% cal_peak_ampsNew = cal_peak_amps(~isnan(cal_peak_amps))';
% cal_peak_idxsNew = cal_peak_idxs(~isnan(cal_peak_idxs))';
% calD_peak_ampsNew = calD_peak_amps(~isnan(calD_peak_amps))';
% calD_peak_idxsNew = calD_peak_idxs(~isnan(calD_peak_idxs))';
% calSp_peak_idxsNew = calSp_peak_idxs(~isnan(calSp_peak_idxs))';
% rs_peak_ampsNew(1,:) = rs_peak_amps(1,~isnan(rs_peak_amps(1,:)))';
% rs_peak_ampsNew(2,:) = rs_peak_amps(2,~isnan(rs_peak_amps(2,:)))';
% rs_peak_idxsNewNew(1,:) = rs_peak_idxs(1,~isnan(rs_peak_idxs(1,:)))';
% rs_peak_idxsNewNew(2,:) = rs_peak_idxs(2,~isnan(rs_peak_idxs(2,:)))';
% eyeL_peak_ampsNew(1,:) = eyeL_peak_amps(1,~isnan(eyeL_peak_amps(1,:)))';
% eyeL_peak_ampsNew(2,:) = eyeL_peak_amps(2,~isnan(eyeL_peak_amps(2,:)))';
% eyeL_peak_idxsNew(1,:) = eyeL_peak_idxs(1,~isnan(eyeL_peak_idxs(1,:)))';
% eyeL_peak_idxsNew(2,:) = eyeL_peak_idxs(2,~isnan(eyeL_peak_idxs(2,:)))';
% eyeD_peak_ampsNew(1,:) = eyeD_peak_amps(1,~isnan(eyeD_peak_amps(1,:)))';
% eyeD_peak_ampsNew(2,:) = eyeD_peak_amps(2,~isnan(eyeD_peak_amps(2,:)))';
% eyeD_peak_idxsNew(1,:) = eyeD_peak_idxs(1,~isnan(eyeD_peak_idxs(1,:)))';
% eyeD_peak_idxsNew(2,:) = eyeD_peak_idxs(2,~isnan(eyeD_peak_idxs(2,:)))';
% headvel_peak_ampsNew(1,:) = headvel_peak_amps(1,~isnan(headvel_peak_amps(1,:)))';
% headvel_peak_ampsNew(2,:) = headvel_peak_amps(2,~isnan(headvel_peak_amps(2,:)))';
% headvel_peak_idxsNew(1,:) = headvel_peak_idxs(1,~isnan(headvel_peak_idxs(1,:)))';
% headvel_peak_idxsNew(2,:) = headvel_peak_idxs(2,~isnan(headvel_peak_idxs(2,:)))';
% headvelD_peak_ampsNew(1,:) = headvelD_peak_amps(1,~isnan(headvelD_peak_amps(1,:)))';
% headvelD_peak_ampsNew(2,:) = headvelD_peak_amps(2,~isnan(headvelD_peak_amps(2,:)))';
% headvelD_peak_idxsNew(1,:) = headvelD_peak_idxs(1,~isnan(headvelD_peak_idxs(1,:)))';
% headvelD_peak_idxsNew(2,:) = headvelD_peak_idxs(2,~isnan(headvelD_peak_idxs(2,:)))';

% rsCalTimeAll = nanmean(calRSidxsNaN);
% eyeLcalTimeAll = nanmean(calEyeLidxsNaN);
% headCalTimeAll = nanmean(calEyeDidxsNaN);
% eyeDcalTimeAll = nanmean(calHeadvelIdxsNaN);
% headDcalTimeAll = nanmean(calHeadvelDidxsNaN);
% rsCalTime = nanmean(rsPeakDiffs);
% eyeLcalTime = nanmean(eyeLpeakDiffs);
% headCalTime = nanmean(headvelPeakDiffs);
% eyeDcalTime = nanmean(eyeDpeakDiffs);
% headDcalTime = nanmean(headvelDpeakDiffs);

%% K-means clustering and plotting
if expSubType ~= 3 && expSubType ~= 5 && condition ~= 4
    kSize = 6;
    kSizeDark = 6;
    kSizeGap = 6;
    ampWidth = ([pks2;w2])';
    kCluster = kmeans(ampWidth,kSize);
    c = {'bg','bgr','bgrc','bgrcy','bgrcyk','bgrcykm'};

    amp3width = ([pks2(1:end-1);w2(1:end-1);interPeakInterval2])';
    k3cluster = kmeans(amp3width,kSize);
    figure();
    for i = 1:length(amp3width)
        scatter3(amp3width(i,2),amp3width(i,1),amp3width(i,3),k3cluster(i,1)*50,kCluster(i,1)); hold on
    end
    %k3cluster(i,1)*50
    %interPeakInterval2(1,i)/10
    xlabel('Half-width (ms)')
    ylabel('%\DeltaF/G')
    zlabel('Inter-peak interval')

    figure()
    subplot(2,2,1); hold on
    gscatter(ampWidth(:,2),ampWidth(:,1),kCluster,c{kSize-1})
    ylabel('\DeltaF/G')
    title('Visual')
    legend off

    if condition ~= 2
        ampWidthDark = ([pks4;w4])';
        kCluster = kmeans(ampWidthDark,kSizeDark);
        subplot(2,2,2); hold on
        gscatter(ampWidthDark(:,2),ampWidthDark(:,1),kCluster,c{kSizeDark-1})
        ylabel('\DeltaF/G')
        xlabel('Half-width (ms)')
        title('Vdark')
        legend off
    end

    ampWidthGap = ([pks6,w6]);
    kCluster = kmeans(ampWidthGap,kSizeGap);
    subplot(2,2,3); hold on
    gscatter(ampWidthGap(:,2),ampWidthGap(:,1),kCluster,c{kSizeGap-1})
    ylabel('\DeltaF/G')
    xlabel('Half-width (ms)')
    title('Spontaneous')
    legend off
    sgtitle('k-means clustering of calcium')

    amp3widthGap = ([pks6(1:end-1),w6(1:end-1),interPeakInterval6]);
    k3clusterGap = kmeans(amp3widthGap,kSizeGap);
    figure();
    for i = 1:length(amp3widthGap)
        scatter3(amp3widthGap(i,2),amp3widthGap(i,1),amp3widthGap(i,3),interPeakInterval6(i,1)/10,kCluster(i,1)); hold on
    end
    %k3clusterGap(i,1)*50
    %interPeakInterval6(i,1)/10
    xlabel('Half-width (ms)')
    ylabel('%\DeltaF/G')
    zlabel('Inter-peak interval')
    title('Spontaneous')
end
%% 

calLampNextTrialNoCSavg(1) = nanmean(calLampNextTrialNoCS(1,:));
calLampNextTrialNoCSavg(2) = nanmean(calLampNextTrialNoCS(2,:));
calLampNextTrialNoCSse(1) = nanstd(calLampNextTrialNoCS(1,:))/sqrt(numel(calLampNextTrialNoCS(1,~isnan(calLampNextTrialNoCS(1,:)))));
calLampNextTrialNoCSse(2) = nanstd(calLampNextTrialNoCS(2,:))/sqrt(numel(calLampNextTrialNoCS(2,~isnan(calLampNextTrialNoCS(2,:)))));

calLaucNextTrialNoCSavg(1) = nanmean(calLaucNextTrialNoCS(1,:));
calLaucNextTrialNoCSavg(2) = nanmean(calLaucNextTrialNoCS(2,:));
calLaucNextTrialNoCSse(1) = nanstd(calLaucNextTrialNoCS(1,:))/sqrt(numel(calLaucNextTrialNoCS(1,~isnan(calLaucNextTrialNoCS(1,:)))));
calLaucNextTrialNoCSse(2) = nanstd(calLaucNextTrialNoCS(2,:))/sqrt(numel(calLaucNextTrialNoCS(2,~isnan(calLaucNextTrialNoCS(2,:)))));

calLampIdxNextTrialNoCS = nanmean(calLampIdxNextTrialNoCS);
eyeLampNextTrialAvg = nanmean(eyeLampNextTrial(2,:));
eyeLampNextTrialNoCSavg = nanmean(eyeLampNextTrialNoCS(2,:));
eyeLampNextTrialSe = nanstd(eyeLampNextTrial(2,:))/sqrt(numel(eyeLampNextTrial(2,~isnan(eyeLampNextTrial(2,:)))));
eyeLampNextTrialNoCSse = nanstd(eyeLampNextTrialNoCS(2,:))/sqrt(numel(eyeLampNextTrialNoCS(2,~isnan(eyeLampNextTrialNoCS(2,:)))));
