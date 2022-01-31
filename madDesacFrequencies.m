function[madEye05,madEye1,madEye2,madEye4,madEye5,madEye10,madEye05vector,madEye1vector,madEye2vector,madEye4vector,madEye5vector,madEye10vector,madEyeSpVector] = madDesacFrequencies(numBlocksL,numBlocksGap,madMultiplier,madMultiplierStep,madMultiplierGap,eyeTrace05,eyeTrace1,eyeTrace2,eyeTrace4,eyeTrace5,eyeTrace10,eyeTraceSp,presac,postsac)

%calculate Median Absolute Deviation, median, and upper and lower bounds
madEye05 = mad(eyeTrace05,1,2);
medianEye05 = nanmedian(eyeTrace05,2);
madEye05a = medianEye05 + madMultiplier * madEye05;
madEye05b = medianEye05 - madMultiplier * madEye05;

madEye1 = mad(eyeTrace1,1,2);
medianEye1 = nanmedian(eyeTrace1,2);
madEye1a = medianEye1 + madMultiplier * madEye1;
madEye1b = medianEye1 - madMultiplier * madEye1;

madEye2 = mad(eyeTrace2,1,2);
medianEye2 = nanmedian(eyeTrace2,2);
madEye2a = medianEye2 + madMultiplier * madEye2;
madEye2b = medianEye2 - madMultiplier * madEye2;

madEye4 = mad(eyeTrace4,1,2);
medianEye4 = nanmedian(eyeTrace4,2);
madEye4a = medianEye4 + madMultiplier * madEye4;
madEye4b = medianEye4 - madMultiplier * madEye4;

madEye5 = mad(eyeTrace5,1,2);
medianEye5 = nanmedian(eyeTrace5,2);
madEye5a = medianEye5 + madMultiplierStep * madEye5;
madEye5b = medianEye5 - madMultiplierStep * madEye5;

madEye10 = mad(eyeTrace10,1,2);
medianEye10 = nanmedian(eyeTrace10,2);
madEye10a = medianEye10 + madMultiplierStep * madEye10;
madEye10b = medianEye10 - madMultiplierStep * madEye10;

madEyeSp = mad(eyeTraceSp,1,2);
medianEyeSp = nanmedian(eyeTraceSp,2);
madEyeSp1 = medianEyeSp + madMultiplierGap * madEyeSp;
madEyeSp2 = medianEyeSp - madMultiplierGap * madEyeSp;
    
%plot median and upper and lower MAD bounds
figure(); hold on
plot(eyeTrace05(:,1:20))
plot(medianEye05,'k','LineWidth',2)
plot(madEye05a,'b','LineWidth',2)
plot(madEye05b,'b','LineWidth',2)
title('0.5 Hz Median and MAD thresholds');
legend('Median','MAD upper thresh.','MAD lower thresh.');
xlabel('Time (ms)');
ylabel('Velocity');

figure(); hold on
plot(eyeTrace1(:,1:20))
plot(medianEye1,'k','LineWidth',2)
plot(madEye1a,'b','LineWidth',2)
plot(madEye1b,'b','LineWidth',2)
title('1 Hz Median and MAD thresholds');
legend('Median','MAD upper thresh.','MAD lower thresh.');
xlabel('Time (ms)');
ylabel('Velocity');

figure(); hold on
plot(eyeTrace2(:,1:20))
plot(medianEye2,'k','LineWidth',2)
plot(madEye2a,'b','LineWidth',2)
plot(madEye2b,'b','LineWidth',2)
title('2 Hz Median and MAD thresholds');
legend('Median','MAD upper thresh.','MAD lower thresh.');
xlabel('Time (ms)');
ylabel('Velocity');

figure(); hold on
plot(eyeTrace4(:,1:20))
plot(medianEye4,'k','LineWidth',2)
plot(madEye4a,'b','LineWidth',2)
plot(madEye4b,'b','LineWidth',2)
title('4 Hz Median and MAD thresholds');
legend('Median','MAD upper thresh.','MAD lower thresh.');
xlabel('Time (ms)');
ylabel('Velocity');

figure(); hold on
plot(eyeTrace5(:,1:20))
plot(medianEye5,'k','LineWidth',2)
plot(madEye5a,'b','LineWidth',2)
plot(madEye5b,'b','LineWidth',2)
title('5 {\circ}/s Median and MAD thresholds');
legend('Median','MAD upper thresh.','MAD lower thresh.');
xlabel('Time (ms)');
ylabel('Velocity');

figure(); hold on
plot(eyeTrace10(:,1:20))
plot(medianEye10,'k','LineWidth',2)
plot(madEye10a,'b','LineWidth',2)
plot(madEye10b,'b','LineWidth',2)
title('10 {\circ}/s Median and MAD thresholds');
legend('Median','MAD upper thresh.','MAD lower thresh.');
xlabel('Time (ms)');
ylabel('Velocity');

figure(); hold on
plot(eyeTraceSp(:,1:9))
plot(medianEyeSp,'g')
plot(madEyeSp1,'g','LineWidth',2)
plot(madEyeSp2,'g','LineWidth',2)
title('Sp Median and MAD thresholds');
legend('Median','MAD upper thresh.','MAD lower thresh.');
xlabel('Time (ms)');
ylabel('Velocity');

%Set data points that exceed MAD thresholds to 0
numTrials05 = 1:size(eyeTrace05,2);
numTime05 = 1:size(eyeTrace05,1);
madDesacEye05 = zeros(length(numTime05),length(numTrials05));
for j = numTrials05
    for k = numTime05
        if eyeTrace05(k,j) < madEye05b(k) || eyeTrace05(k,j) > madEye05a(k)
            madDesacEye05(k,j) = 0;
        else
            madDesacEye05(k,j) = eyeTrace05(k,j);
        end
    end
end

numTrials1 = 1:size(eyeTrace1,2);
numTime1 = 1:size(eyeTrace1,1);
madDesacEye1 = zeros(length(numTime1),length(numTrials1));
for j = numTrials1
    for k = numTime1
        if eyeTrace1(k,j) < madEye1b(k) || eyeTrace1(k,j) > madEye1a(k)
            madDesacEye1(k,j) = 0;
        else
            madDesacEye1(k,j) = eyeTrace1(k,j);
        end
    end
end

numTrials2 = 1:size(eyeTrace2,2);
numTime2 = 1:size(eyeTrace2,1);
madDesacEye2 = zeros(length(numTime2),length(numTrials2));
for j = numTrials2
    for k = numTime2
        if eyeTrace2(k,j) < madEye2b(k) || eyeTrace2(k,j) > madEye2a(k)
            madDesacEye2(k,j) = 0;
        else
            madDesacEye2(k,j) = eyeTrace2(k,j);
        end
    end
end

numTrials4 = 1:size(eyeTrace4,2);
numTime4 = 1:size(eyeTrace4,1);
madDesacEye4 = zeros(length(numTime4),length(numTrials4));
for j = numTrials4
    for k = numTime4
        if eyeTrace4(k,j) < madEye4b(k) || eyeTrace4(k,j) > madEye4a(k)
            madDesacEye4(k,j) = 0;
        else
            madDesacEye4(k,j) = eyeTrace4(k,j);
        end
    end
end

numTrials5 = 1:size(eyeTrace5,2);
numTime5 = 1:size(eyeTrace5,1);
madDesacEye5 = zeros(length(numTime5),length(numTrials5));
for j = numTrials5
    for k = numTime5
        if eyeTrace5(k,j) < madEye5b(k) || eyeTrace5(k,j) > madEye5a(k)
            madDesacEye5(k,j) = 0;
        else
            madDesacEye5(k,j) = eyeTrace5(k,j);
        end
    end
end

numTrials10 = 1:size(eyeTrace10,2);
numTime10 = 1:size(eyeTrace10,1);
madDesacEye10 = zeros(length(numTime10),length(numTrials10));
for j = numTrials10
    for k = numTime10
        if eyeTrace10(k,j) < madEye10b(k) || eyeTrace10(k,j) > madEye10a(k)
            madDesacEye10(k,j) = 0;
        else
            madDesacEye10(k,j) = eyeTrace10(k,j);
        end
    end
end

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

%Concatenate rows into single vector, change to logical, differentiate to identify timepoints of "saccades"
% madDesacEye05 = madDesacEye05';
madDesacEye05 = madDesacEye05(:)';
madDesacEye05 = logical(madDesacEye05);
madEye05copy = madDesacEye05;
madDesacVal05 = logical(diff(madDesacEye05));

% madDesacEye1 = madDesacEye1';
madDesacEye1 = madDesacEye1(:)';
madDesacEye1 = logical(madDesacEye1);
madEye1copy = madDesacEye1;
madDesacVal1 = logical(diff(madDesacEye1));

% madDesacEye2 = madDesacEye2';
madDesacEye2 = madDesacEye2(:)';
madDesacEye2 = logical(madDesacEye2);
madEye2copy = madDesacEye2;
madDesacVal2 = logical(diff(madDesacEye2));

% madDesacEye4 = madDesacEye4';
madDesacEye4 = madDesacEye4(:)';
madDesacEye4 = logical(madDesacEye4);
madEye4copy = madDesacEye4;
madDesacVal4 = logical(diff(madDesacEye4));

% madDesacEye5 = madDesacEye5';
madDesacEye5 = madDesacEye5(:)';
madDesacEye5 = logical(madDesacEye5);
madEye5copy = madDesacEye5;
madDesacVal5 = logical(diff(madDesacEye5));

% madDesacEye10 = madDesacEye10';
madDesacEye10 = madDesacEye10(:)';
madDesacEye10 = logical(madDesacEye10);
madEye10copy = madDesacEye10;
madDesacVal10 = logical(diff(madDesacEye10));

madDesacEyeSp = madDesacEyeSp(:)';
madDesacEyeSp = logical(madDesacEyeSp);
madEyeDesacSp = madDesacEyeSp;
madDesacValSp = logical(diff(madDesacEyeSp));

numTrace = presac+1:length(madDesacVal05)-postsac;
numTraceSp = presac+1:length(madDesacValSp)-postsac;

%set pre and post saccade timepoints to 0
for i = numTrace
    if madDesacVal05(i) == 1
        madEye05copy((i) - presac:(i) + postsac) = 0;
    end
end

for i = numTrace
    if madDesacVal1(i) == 1
        madEye1copy((i) - presac:(i) + postsac) = 0;
    end
end

for i = numTrace
    if madDesacVal2(i) == 1
        madEye2copy((i) - presac:(i) + postsac) = 0;
    end
end

for i = numTrace
    if madDesacVal4(i) == 1
        madEye4copy((i) - presac:(i) + postsac) = 0;
    end
end

for i = numTrace
    if madDesacVal5(i) == 1
        madEye5copy((i) - presac:(i) + postsac) = 0;
    end
end

for i = numTrace
    if madDesacVal10(i) == 1
        madEye10copy((i) - presac:(i) + postsac) = 0;
    end
end

for i = numTraceSp
    if madDesacValSp(i) == 1
        madEyeDesacSp((i) - presac:(i) + postsac) = 0;
    end
end

%convert back to matrix and remove saccade timepoints
madEye05 = eyeTrace05;
madEye05copy = (reshape(madEye05copy,length(numTime05),length(numTrials05)));
madEye05(~madEye05copy) = nan;

madEye1 = eyeTrace1;
madEye1copy = (reshape(madEye1copy,length(numTime1),length(numTrials1)));
madEye1(~madEye1copy) = nan;

madEye2 = eyeTrace2;
madEye2copy = (reshape(madEye2copy,length(numTime2),length(numTrials2)));
madEye2(~madEye2copy) = nan;

madEye4 = eyeTrace4;
madEye4copy = (reshape(madEye4copy,length(numTime4),length(numTrials4)));
madEye4(~madEye4copy) = nan;

madEye5 = eyeTrace5;
madEye5copy = (reshape(madEye5copy,length(numTime5),length(numTrials5)));
madEye5(~madEye5copy) = nan;

madEye10 = eyeTrace10;
madEye10copy = (reshape(madEye10copy,length(numTime10),length(numTrials10)));
madEye10(~madEye10copy) = nan;

madEyeSp = eyeTraceSp;
madEyeDesacSp = (reshape(madEyeDesacSp,length(numTimeSp),length(numTrialsSp)));
madEyeSp(~madEyeDesacSp) = nan;

%create vectors for each test condition
madEye05vector = madEye05(:);
madEye1vector = madEye1(:);
madEye2vector = madEye2(:);
madEye4vector = madEye4(:);
madEye5vector = madEye5(:);
madEye10vector = madEye10(:);
madEyeSpVector = madEyeSp(:);