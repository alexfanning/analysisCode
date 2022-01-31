function[eyeVisualMatOut,eyeDarkMatOut,eyeGapMatOut,eyeVisualMatOutVector,eyeDarkMatOutVector,eyeGapMatOutVector,madEyeDdesac,madEyeDesac,madEyeDesacSp,madEyeL1,madEyeL2,madEyeD1,madEyeD2] = madDesac(numBlocksD,numBlocksL,numBlocksGap,madMultiplier,madMultiplierD,madMultiplierGap,eyeTrace,eyeTraceD,eyeTraceSp,presac,postsac,t)
%matrix for trial by trial raw eye velocity
    eyeTrace = eyeTrace';
    eyeTraceD = eyeTraceD';
    eyeTraceSp = eyeTraceSp';
    eyeTraceVec = eyeTrace(:);
    eyeTraceDvec = eyeTraceD(:);
    eyeTraceSpVec = eyeTraceSp(:);
    
    %calculate Median Absolute Deviation, median, and upper and lower bounds
    madEyeL = mad(eyeTrace,1,2);
    medianEyeL = nanmedian(eyeTrace,2);
    madEyeL1 = medianEyeL + madMultiplier * madEyeL;
    madEyeL2 = medianEyeL - madMultiplier * madEyeL;
    
    madEyeD = mad(eyeTraceD,1,2);
    medianEyeD = nanmedian(eyeTraceD,2);
    madEyeD1 = medianEyeD + madMultiplierD * madEyeD;
    madEyeD2 = medianEyeD - madMultiplierD * madEyeD;
    
    madEyeSp = mad(eyeTraceSp,1,2);
    medianEyeSp = nanmedian(eyeTraceSp,2);
    madEyeSp1 = medianEyeSp + madMultiplierGap * madEyeSp;
    madEyeSp2 = medianEyeSp - madMultiplierGap * madEyeSp;
    
    tf = isempty(eyeTraceD);
    %plot median and upper and lower MAD bounds
    figure('Name',t)
    subplot(3,1,1); hold on
    plot(eyeTrace)
    plot(medianEyeL,'k','LineWidth',2)
    plot(madEyeL1,'k','LineWidth',3)
    plot(madEyeL2,'k','LineWidth',3)
    title('Visual');
    xlabel('Time (ms)');
    ylabel('Velocity');
    
    if tf == 0
        subplot(3,1,2); hold on
        plot(eyeTraceD)
        plot(medianEyeD,'k','LineWidth',2)
        plot(madEyeD1,'k','LineWidth',3)
        plot(madEyeD2,'k','LineWidth',3)
        title('Vestibular-dark');
        xlabel('Time (ms)');
        ylabel('Velocity');
    end

    subplot(3,1,3); hold on
    plot(eyeTraceSp)
    plot(medianEyeSp,'k','LineWidth',2)
    plot(madEyeSp1,'k','LineWidth',3)
    plot(madEyeSp2,'k','LineWidth',3)
    title('Gap');
    xlabel('Time (ms)');
    ylabel('Velocity');

%Set data points that exceed MAD thresholds to 0
numTrials = 1:size(eyeTrace,2);
numTime = 1:size(eyeTrace,1);
madDesacEye = zeros(length(numTime),length(numTrials));
for j = numTrials
    for k = numTime
        if eyeTrace(k,j) < madEyeL2(k) || eyeTrace(k,j) > madEyeL1(k)
            madDesacEye(k,j) = 0;
        else
            madDesacEye(k,j) = eyeTrace(k,j);
        end
    end
end

%Set data points that exceed MAD thresholds to 0 for vestibular dark 
numTrialsD = 1:size(eyeTraceD,2);
numTimeD = 1:size(eyeTraceD,1);
madDesacEyeD = zeros(length(numTimeD),length(numTrialsD));
for j = numTrialsD
    for k = numTimeD
        if eyeTraceD(k,j) < madEyeD2(k) || eyeTraceD(k,j) > madEyeD1(k)
            madDesacEyeD(k,j) = 0;
        else
            madDesacEyeD(k,j) = eyeTraceD(k,j);
        end
    end
end

%Set data points that exceed MAD thresholds to 0 for spontaneous activity
numTrialsSp = 1:size(eyeTraceSp,2);
numTimeSp = 1:size(eyeTraceSp,1);
madDesacEyeSp = zeros(length(numTimeSp),length(numTrialsSp));
for j = numTrialsSp
    for k = numTimeSp
        if eyeTraceSp(k,j) < madEyeSp2(k) || eyeTraceSp(k,j) > madEyeSp1(k)
            madDesacEyeSp(k,j) = 0;
        else
            madDesacEyeSp(k,j) = eyeTraceSp(k,j);
        end
    end
end

%Concatenate rows into single vector, change to logical, differentiate to
%identify timepoints of "saccades"
% madDesacEye = madDesacEye';
madDesacEye = madDesacEye(:)';
madDesacEye = logical(madDesacEye);
madEyeDesac = madDesacEye;
madDesacVal = logical(diff(madDesacEye));

% madDesacEyeD = madDesacEyeD';
madDesacEyeD = madDesacEyeD(:)';
madDesacEyeD = logical(madDesacEyeD);
madEyeDdesac = madDesacEyeD;
madDesacRelVal = logical(diff(madDesacEyeD));

madDesacEyeSp = madDesacEyeSp(:)';
madDesacEyeSp = logical(madDesacEyeSp);
madEyeDesacSp = madDesacEyeSp;
madDesacValSp = logical(diff(madDesacEyeSp));

numTrace = presac+1:length(madDesacVal)-postsac;
numTraceD = presac+1:length(madDesacRelVal)-postsac;
numTraceSp = presac+1:length(madDesacValSp)-postsac;

%set pre and post saccade timepoints to 0
for i = numTrace
    if madDesacVal(i) == 1
        madEyeDesac((i) - presac:(i) + postsac) = 0;
    end
end

for i = numTraceD
    if madDesacRelVal(i) == 1
        madEyeDdesac((i) - presac:(i) + postsac) = 0;
    end
end

for i = numTraceSp
    if madDesacValSp(i) == 1
        madEyeDesacSp((i) - presac:(i) + postsac) = 0;
    end
end

%convert back to matrix and remove saccade timepoints
eyeVisualMatOut = eyeTrace;
madEyeDesac = (reshape(madEyeDesac,length(numTime),length(numTrials)));
eyeVisualMatOut(~madEyeDesac) = nan;
eyeDarkMatOut = eyeTraceD;
madEyeDdesac = (reshape(madEyeDdesac,length(numTimeD),length(numTrialsD)));
eyeDarkMatOut(~madEyeDdesac) = nan;
eyeGapMatOut = eyeTraceSp;
madEyeDesacSp = (reshape(madEyeDesacSp,length(numTimeSp),length(numTrialsSp)));
eyeGapMatOut(~madEyeDesacSp) = nan;
eyeVisualMatOutVector = eyeVisualMatOut(:);
eyeDarkMatOutVector = eyeDarkMatOut(:);
eyeGapMatOutVector = eyeGapMatOut(:);

figure('Name',t)
subplot(3,1,1); hold on
plot(eyeTraceDvec,'k')
plot(eyeDarkMatOutVector,'r')
title('Vestibular-dark');
legend('Raw eye vel.','MAD desaccaded eye vel.');
xlabel('Time (ms)');
ylabel('Velocity');

subplot(3,1,2); hold on
plot(eyeTraceVec,'k')
plot(eyeVisualMatOutVector,'r')
title('Visual');
xlabel('Time (ms)');
ylabel('Velocity');

subplot(3,1,3); hold on
plot(eyeTraceSpVec,'k')
plot(eyeGapMatOutVector,'r')
title('Gap');
xlabel('Time (ms)');
ylabel('Velocity');