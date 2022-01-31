function [madEye,madDeye,madEyeSp,madEyeVector,madDeyeVector,madEyeSpVector,madEyeDesacMat,madEyeDdesac,madEyeDesacSp] = madDesacOC(tLength,delay,numBlocksD,numBlocksL,numBlocksGap,madMultiplier,madMultiplierCued,madMultiplierD,madMultiplierGap,eyeTrace,eyeTraceD,eyeTraceSp,presac,postsac,type)
%matrix for trial by trial raw eye velocity

if type == 0
    visualEyeVel = eyeTrace(tLength/2+delay+1:end,:);
    cuedEyeVel = eyeTrace(tLength/2+1:tLength/2+delay,:);
    darkEyeVel = eyeTrace(1:tLength/2,:);
elseif type == 1
    cuedEyeVel = eyeTrace(1:delay,:);
    visualEyeVel = eyeTrace(delay+1:delay+tLength/2,:);
    darkEyeVel = eyeTrace(delay+tLength/2+1:delay+tLength,:);
end
    
%calculate Median Absolute Deviation, median, and upper and lower bounds
madEyeL = mad(visualEyeVel,1,2);
medianEyeL = nanmedian(visualEyeVel,2);
madEyeL1 = medianEyeL + madMultiplier * madEyeL;
madEyeL2 = medianEyeL - madMultiplier * madEyeL;

madEyeDark = mad(darkEyeVel,1,2);
medianEyeDark = nanmedian(darkEyeVel,2);
madEyeDark1 = medianEyeDark + madMultiplier * madEyeDark;
madEyeDark2 = medianEyeDark - madMultiplier * madEyeDark;

madEyeCued = mad(cuedEyeVel,1,2);
medianEyeCued = nanmedian(cuedEyeVel,2);
madEyeCued1 = medianEyeCued + madMultiplierCued * madEyeCued;
madEyeCued2 = medianEyeCued - madMultiplierCued * madEyeCued;

madEyeD = mad(eyeTraceD,1,2);
medianEyeD = nanmedian(eyeTraceD,2);
madEyeD1 = medianEyeD + madMultiplierD * madEyeD;
madEyeD2 = medianEyeD - madMultiplierD * madEyeD;

madEyeSp = mad(eyeTraceSp,1,2);
medianEyeSp = nanmedian(eyeTraceSp,2);
madEyeSp1 = medianEyeSp + madMultiplierGap * madEyeSp;
madEyeSp2 = medianEyeSp - madMultiplierGap * madEyeSp;

%Set data points that exceed MAD thresholds to 0
numTrials = 1:size(visualEyeVel,2);
numTime = 1:size(visualEyeVel,1);
madDesacEye = zeros(length(numTime),length(numTrials));
for j = numTrials
    for k = numTime
        if visualEyeVel(k,j) < madEyeL2(k) || visualEyeVel(k,j) > madEyeL1(k)
            madDesacEye(k,j) = 0;
        else
            madDesacEye(k,j) = visualEyeVel(k,j);
        end
    end
end

%Set data points that exceed MAD thresholds to 0 for vestibular dark 
madDesacEyeDark = zeros(length(numTime),length(numTrials));
for j = numTrials
    for k = numTime
        if darkEyeVel(k,j) < madEyeDark2(k) || darkEyeVel(k,j) > madEyeDark1(k)
            madDesacEyeDark(k,j) = 0;
        else
            madDesacEyeDark(k,j) = darkEyeVel(k,j);
        end
    end
end

numTrialsCued = 1:size(cuedEyeVel,2);
numTimeCued = 1:size(cuedEyeVel,1);
madDesacEyeCued = zeros(length(numTimeCued),length(numTrialsCued));
for j = numTrialsCued
    for k = numTimeCued
        if cuedEyeVel(k,j) < madEyeCued2(k) || cuedEyeVel(k,j) > madEyeCued1(k)
            madDesacEyeCued(k,j) = 0;
        else
            madDesacEyeCued(k,j) = cuedEyeVel(k,j);
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

madDesacEyeDark = madDesacEyeDark(:)';
madDesacEyeDark = logical(madDesacEyeDark);
madEyeDesacDark = madDesacEyeDark;
madDesacDarkVal = logical(diff(madDesacEyeDark));

madDesacEyeCued = madDesacEyeCued(:)';
madDesacEyeCued = logical(madDesacEyeCued);
madEyeDesacCued = madDesacEyeCued;
madDesacCuedVal = logical(diff(madDesacEyeCued));

% madDesacEyeD = madDesacEyeD';
madDesacEyeD = madDesacEyeD(:)';
madDesacEyeD = logical(madDesacEyeD);
madEyeDdesac = madDesacEyeD;
madDesacDval = logical(diff(madDesacEyeD));

madDesacEyeSp = madDesacEyeSp(:)';
madDesacEyeSp = logical(madDesacEyeSp);
madEyeDesacSp = madDesacEyeSp;
madDesacValSp = logical(diff(madDesacEyeSp));

numTrace = presac+1:length(madDesacVal)-postsac;
numTraceCued = presac+1:length(madDesacCuedVal)-postsac;
numTraceD = presac+1:length(madDesacDval)-postsac;
numTraceSp = presac+1:length(madDesacValSp)-postsac;

%set pre and post saccade timepoints to 0
for i = numTrace
    if madDesacVal(i) == 1
        madEyeDesac((i) - presac:(i) + postsac) = 0;
    end
end

for i = numTrace
    if madDesacDarkVal(i) == 1
        madEyeDesacDark((i) - presac:(i) + postsac) = 0;
    end
end

for i = numTraceCued
    if madDesacCuedVal(i) == 1
        madEyeDesacCued((i) - presac:(i) + postsac) = 0;
    end
end

for i = numTraceD
    if madDesacDval(i) == 1
        madEyeDdesac((i) - presac:(i) + postsac) = 0;
    end
end

for i = numTraceSp
    if madDesacValSp(i) == 1
        madEyeDesacSp((i) - presac:(i) + postsac) = 0;
    end
end

%convert back to matrix and remove saccade timepoints
madTrialEye = visualEyeVel;
madEyeDesac = (reshape(madEyeDesac,length(numTime),length(numTrials)));
madTrialEye(~madEyeDesac) = nan;
madTrialEyeDark = darkEyeVel;
madEyeDesacDark = (reshape(madEyeDesacDark,length(numTime),length(numTrials)));
madTrialEyeDark(~madEyeDesacDark) = nan;
madTrialEyeCued = cuedEyeVel;
madEyeDesacCued = (reshape(madEyeDesacCued,length(numTimeCued),length(numTrialsCued)));
madTrialEyeCued(~madEyeDesacCued) = nan;

if type == 0
    madEyeDesacMat = NaN(tLength+delay,length(numTrials));
    madEyeDesacMat(1:tLength/2,:) = madEyeDesacDark;
    madEyeDesacMat(tLength/2+1:tLength/2+delay,:) = madEyeDesacCued;
    madEyeDesacMat(tLength/2+delay+1:tLength+delay,:) = madEyeDesac;
    madEyeDesacMat = logical(madEyeDesacMat);
else
    madEyeDesacMat = NaN(tLength+delay,length(numTrials));
    madEyeDesacMat(1:delay,:) = madEyeDesacCued;
    madEyeDesacMat(delay+1:delay+tLength/2,:) = madEyeDesac;
    madEyeDesacMat(delay+tLength/2+1:delay+tLength,:) = madEyeDesacDark;
    madEyeDesacMat = logical(madEyeDesacMat);
end

if type == 0
    madEye = NaN(tLength+delay,length(numTrials));
    madEye(1:tLength/2,:) = madTrialEyeDark;
    madEye(tLength/2+1:tLength/2+delay,:) = madTrialEyeCued;
    madEye(tLength/2+delay+1:tLength+delay,:) = madTrialEye;
    madEyeVector = madEye(:);

    madDeye = eyeTraceD;
    madEyeDdesac = (reshape(madEyeDdesac,length(numTimeD),length(numTrialsD)));
    madDeye(~madEyeDdesac) = nan;
    madDeyeVector = madDeye(:);

    madEyeSp = eyeTrace;
    madEyeDesacSp = (reshape(madEyeDesacSp,length(numTimeSp),length(numTrialsSp)));
    madEyeSp(~madEyeDesacSp) = nan;
    madEyeSpVector = madEyeSp(:);
else
    madEye = NaN(length(eyeTrace)-500,length(numTrials));
    madEye(1:delay,:) = madTrialEyeCued;
    madEye(delay+1:delay+tLength/2,:) = madTrialEye;
    madEye(delay+tLength/2+1:delay+(tLength),:) = madTrialEyeDark;
    madEyeVector = madEye(:);
    
    madDeye = eyeTraceD;
    madEyeDdesac = (reshape(madEyeDdesac,length(numTimeD),length(numTrialsD)));
    madDeye(~madEyeDdesac) = nan;
    madDeyeVector = madDeye(:);

    madEyeSp = eyeTrace;
    madEyeDesacSp = (reshape(madEyeDesacSp,length(numTimeSp),length(numTrialsSp)));
    madEyeSp(~madEyeDesacSp) = nan;
    madEyeSpVector = madEyeSp(:);
end
%plot median and upper and lower MAD bounds
if type == 0
    figure(); hold on
    subplot(2,1,1); hold on
    plot(visualEyeVel(:,1:20))
    plot(medianEyeL,'k','LineWidth',2)
    plot(madEyeL1,'b','LineWidth',2)
    plot(madEyeL2,'b','LineWidth',2)
    title('Visual MAD')
    xlabel('Time (ms)')
    ylabel('Velocity')

    subplot(2,1,2); hold on
    plot(darkEyeVel(:,1:20))
    plot(medianEyeDark,'k','LineWidth',2)
    plot(madEyeDark1,'b','LineWidth',2)
    plot(madEyeDark2,'b','LineWidth',2)
    title('Dark MAD')
    xlabel('Time (ms)')
    ylabel('Velocity')

    figure(); hold on
    subplot(2,1,1); hold on
    plot(cuedEyeVel(:,1:20))
    plot(medianEyeCued,'k','LineWidth',2)
    plot(madEyeCued1,'b','LineWidth',2)
    plot(madEyeCued2,'b','LineWidth',2)
    title('Cued MAD')
    xlabel('Time (ms)')
    ylabel('Velocity')

%     subplot(2,1,2); hold on
%     plot(eyeTraceD(:,1:20))
%     plot(medianEyeD,'k','LineWidth',2)
%     plot(madEyeD1,'r','LineWidth',2)
%     plot(madEyeD2,'r','LineWidth',2)
%     title('Vestibular-dark MAD');
%     xlabel('Time (ms)')
%     ylabel('Velocity')

    figure(); hold on
    plot(eyeTraceSp(:,1:9))
    plot(medianEyeSp,'g')
    plot(madEyeSp1,'g','LineWidth',2)
    plot(madEyeSp2,'g','LineWidth',2)
    title('Spontaneous MAD')
    xlabel('Time (ms)')
    ylabel('Velocity')
end
