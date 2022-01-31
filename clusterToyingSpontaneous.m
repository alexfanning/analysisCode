compareConnectDist = 0;

%% Check calcium desaccading accuracy
calVisualMatVec = calGapMatOut(:)';
calVisualMatInVec = calVisualMatIn';
calVisualMatInVec = calVisualMatInVec(:);

eyeVisualMatVec = eyeVisualMatOut(:)';
eyeVisualMatInVec = eyeVisualMatIn';
eyeVisualMatInVec = eyeVisualMatInVec(:);

eyeSmoothVisualMatVec = eyeSmoothVisualMatOut(:)';
eyeSmoothVisualMatInVec = eyeSmoothVisualMatIn';
eyeSmoothVisualMatInVec = eyeSmoothVisualMatInVec(:);

figure();
ax1 = subplot(2,1,1); hold on
plot(calVisualMatInVec*1000,'LineWidth',2)
plot(calVisualMatVec*1000,'LineWidth',2)
xticklabels(0:20000:120000)
ylabel('\DeltaF/G')
legend('Raw data','Cluster desaccaded data')

ax2 = subplot(2,1,2); hold on
plot(eyeSmoothVisualMatInVec,'LineWidth',2)
plot(eyeSmoothVisualMatVec,'LineWidth',2)
linkaxes([ax1 ax2],'xy')
xticklabels(0:20000:120000)
xlabel('Time (ms)')
ylabel('Eye Velocity')

% ax2 = subplot(2,1,2); hold on
% plot(eyeVisualMatInVec,'LineWidth',2)
% plot(eyeVisualMatVec,'LineWidth',2)
% linkaxes([ax1 ax2],'xy')
% xticklabels(0:20000:120000)
% xlabel('Time (ms)')
% ylabel('Eye Velocity')

%% Modify clusterCenter and connectionDistance values
%find desaccaded calcium events
calVisualMatIn = calGapMatIn';
t = 1;
desacCal = NaN(1000,size(calVisualMatOut,2));
rawCal = NaN(1000,size(calVisualMatOut,2));
for i = 1:size(calVisualMatOut,2)
    if find(isnan(calGapMatOut(:,i)))
        desacCal(:,i) = calGapMatOut(:,i);
        desacCalIdx(t) = i;
        t = t+1;
    else
        rawCal(:,i) = calGapMatOut(:,i);
    end
end
desacCalSqueeze = desacCal(:,desacCalIdx);

%subtract clusterCenter from calcium traces
clusterCenter3 = clusterCenter3';
calMinusCenter = NaN(1000,size(calVisualMatOut,2));
for i = 1:size(calVisualMatIn,2)
    calMinusCenter(:,i) = calVisualMatIn(:,i) - clusterCenter3;
end

figure()
subplot(2,1,1); hold on
plot(desacCal)
subplot(2,1,2); hold on
plot(rawCal)

figure(); hold on
plot(calVisualMatIn(:,desacCalIdx),'Color','k')
plot(desacCal,'Color','r')
clusterCenter3 = clusterCenter3';

desacIdxCycling = desacCalIdx;

for t = 21:20:length(desacCalIdx)
    if t+20 > length(desacCalIdx)
        continue
    else
        figure()
        for i = 1:20
            nexttile; hold on
            plot(calVisualMatIn(:,desacIdxCycling(i)),'LineWidth',2,'Color','k')
            plot(desacCalSqueeze(:,i),'LineWidth',2,'Color','r')
            plot(clusterCenter3)
            plot(clusterCenter3+connectionDistance3)
            plot(calMinusCenter(:,desacIdxCycling(i)),'LineWidth',0.5,'Color','cyan')
        end
        desacIdxCycling = desacCalIdx(:,t:t+20);
    end
end

%find desaccade indexes in one vector that are not in the other
%% 
if compareConnectDist == 1
    desacIdxDiff = setdiff(desacCalIdx,desacCalIdx3);
    desacIdxCycling = desacIdxDiff;
    % desacCalDiff = desacIdxDiff(:,desacCalIdx);
    t = 1;
    for t = 21:20:length(desacIdxDiff)
        if t+20 > length(desacCalIdx)
            continue
        else
            figure()
            for i = 1:20
                nexttile; hold on
                plot(calVisualMatIn(:,desacIdxCycling(i)),'LineWidth',2,'Color','k')
                plot(calVisualMatOut(:,desacIdxCycling(i)),'LineWidth',2,'Color','r')
                plot(clusterCenter3)
                plot(clusterCenter3+connectionDistance3)
                plot(calMinusCenter(:,desacIdxCycling(i)),'LineWidth',0.5,'Color','cyan')
            end
            desacIdxCycling = desacIdxDiff(:,t:t+20);
        end
    end
end
%% Find desaccaded timepoints
nanLocs = zeros(1000,size(calVisualMatOut,2));
for k = 1:size(calVisualMatOut,2)
    for t = 1:1000
        if isnan(calGapMatOut(t,k))
            nanLocs(t,k) = 1;
        else
            nanLocs(t,k) = 0;
        end
    end
end
nanStart = find(diff(nanLocs)==1);
nanStop = find(diff(nanLocs)==-1);
if length(nanStop)~=length(nanStart)
    nanStop(1) = [];
end

for i = 1:length(nanStop)
    if ~isnan(eyeSmoothGapMatOut(nanStart(i)-75:nanStop(i)+75))
        noSacIdx(i) = ceil(nanStart(i)/1000);
    end
end

noSacIdxNew = find(noSacIdx);
noSacIdxNew2 = noSacIdx(noSacIdxNew);
noSacIdxNew3 = unique(noSacIdxNew2);

for i = 1:length(noSacIdxNew3)
    nexttile; hold on
    plot(calVisualMatIn(:,noSacIdxNew3(i)),'LineWidth',2,'Color','k')
    plot(calGapMatOut(:,noSacIdxNew3(i)),'LineWidth',2,'Color','r')
    plot(clusterCenter3)
    plot(clusterCenter3+connectionDistance3)
end

%% Find peak amplitude and half-width of events
separatedCalDiffVec = calMinusCenter(:)';
separatedCalDiffVec1 = separatedCalDiffVec*-1;

minPeakProm = 0.005;        %parameters for finding calcium events
minPeakDist = 300;
maxPeakWidth = 1000;
minPeakWidth = 100;
figure()
[pks,locs,w,p] = findpeaks(separatedCalDiffVec,1,'MinPeakProminence',minPeakProm,'MinPeakDistance',minPeakDist,'Annotate','extents','MaxPeakWidth',maxPeakWidth,'MinPeakWidth',minPeakWidth);
[pks1,locs1,w1,p1] = findpeaks(separatedCalDiffVec1,1,'MinPeakProminence',minPeakProm,'MinPeakDistance',minPeakDist,'Annotate','extents','MaxPeakWidth',maxPeakWidth,'MinPeakWidth',minPeakWidth);
interPeakInterval = diff(locs);
findpeaks(separatedCalDiffVec,1,'MinPeakDistance',minPeakDist,'MinPeakProminence',minPeakProm,'Annotate','extents','MaxPeakWidth',maxPeakWidth,'MinPeakWidth',minPeakWidth)
figure()
subplot(2,1,1); hold on
plot(pks)
ylabel('\DeltaF/G')
subplot(2,1,2); hold on
plot(interPeakInterval)
ylabel('Inter-peak interval (ms)')

[eventLocs,eventLocs(2,:)] = ind2sub(size(calMinusCenter),locs);
[eventLocs1,eventLocs1(2,:)] = ind2sub(size(calMinusCenter),locs1);
calMinusLog = calMinusCenter;
calMinusLog1 = calMinusCenter*-1;
otherIdx = [1:size(calMinusCenter,2)];
otherIdx1 = ~ismember(otherIdx,desacCalIdx);
otherIdx2 = otherIdx(otherIdx1);
calMinusLog(:,otherIdx2) = NaN;
calMinusLog1(:,otherIdx2) = NaN;

%% event peak and width analysis
peakAmps = NaN(1000,2);
peakWidths = NaN(1000,2);
peakLocs = NaN(1000,2);
figure()
for i = 1:size(calMinusLog,2)
    if isnan(calMinusLog(1,i))
        continue
    else
        nexttile; hold on
        plot(calVisualMatIn(:,i),'LineWidth',2,'Color','k')
        plot(calGapMatOut(:,i),'LineWidth',2,'Color','r')
        plot(clusterCenter3)
        plot(clusterCenter3+connectionDistance3)
        plot(calMinusLog(:,i));
        plot(calMinusLog1(:,i))
        temp = find(eventLocs(2,:)==i);
        for t = 1:length(temp)
            if isnan(calGapMatOut(eventLocs(1,temp(t)),i))
                scatter(eventLocs(1,temp(t)),pks(temp(t)),100,'LineWidth',2)
                peakAmps(i,1) = pks(temp(t));
                peakWidths(i,1) = w(temp(t));
                peakLocs(i) = eventLocs(1,temp(t));
            end
        end
        temp1 = find(eventLocs1(2,:)==i);
        for t = 1:length(temp1)
            if isnan(calGapMatOut(eventLocs1(1,temp1(t)),i))
                scatter(eventLocs1(1,temp1(t)),pks1(temp1(t)),100,'LineWidth',2)
                peakAmps(i,2) = pks1(temp1(t));
                peakWidths(i,2) = w1(temp1(t));
            end
        end
    end
end

%% Event analysis
peakAmpsNew{1} = peakAmps(~isnan(peakAmps(:,1)));
peakAmpsNew{2} = peakAmps(~isnan(peakAmps(:,2)),2);
peakAmpsNum = [1:length(peakAmpsNew{1})];
peakAmpsNum1 = [1:length(peakAmpsNew{2})];
figure(); hold on
scatter(peakAmpsNum,peakAmpsNew{1},'LineWidth',2)
scatter(peakAmpsNum1,peakAmpsNew{2},'LineWidth',2)
ylabel('% \DeltaF/G')
xlabel('Event number')
title('Amplitude')

peakWidthsNew{1} = peakWidths(~isnan(peakWidths(:,1)));
peakWidthsNew{2} = peakWidths(~isnan(peakWidths(:,2)),2);
peakWidthsNum = [1:length(peakWidthsNew{1})];
peakWidthsNum1 = [1:length(peakWidthsNew{2})];
figure(); hold on
scatter(peakWidthsNew{1},peakWidthsNum,'LineWidth',2)
scatter(peakWidthsNew{2},peakWidthsNum1,'LineWidth',2)
xlabel('Half-width (ms)')
ylabel('Event number')
title('Spontaneous')

figure(); hold on
scatter(peakWidthsNew{1},peakAmpsNew{1}*100,'LineWidth',2)
scatter(peakWidthsNew{2},peakAmpsNew{2}*100,'LineWidth',2)
xlabel('Half-width')
ylabel('% \DeltaF/G')

figure(); hold on
histogram(peakAmpsNew{1},30,'Orientation', 'vertical')
xlabel('\DeltaF/G')
ylabel('Number of events')

%% 
kSize = 2;
kSizeGap = 2;
ampWidth = ([pks;w])';
kCluster = kmeans(ampWidth,kSize);
c = {'bg','bgr','bgrc','bgrcy','bgrcyk','bgrcykm'};

% amp3width = ([pks2(1:end-1);w2(1:end-1);interPeakInterval2])';
% k3cluster = kmeans(amp3width,kSize);
% figure();
% for i = 1:length(amp3width)
%     scatter3(amp3width(i,2),amp3width(i,1),amp3width(i,3),k3cluster(i,1)*50,kCluster(i,1)); hold on
% end
% %k3cluster(i,1)*50
% %interPeakInterval2(1,i)/10
% xlabel('Half-width (ms)')
% ylabel('%\DeltaF/G')
% zlabel('Inter-peak interval')

figure(); hold on
gscatter(ampWidth(:,2),ampWidth(:,1),kCluster,c{kSize-1})
ylabel('\DeltaF/G')
title('k-means clustering of calcium')
title('Spontaneous')
xlabel('Half-width (ms)')
legend off


%% Plot each calcium event corresponding to K-means cluster group 1 or 2
peakAmps = NaN(1000,2);
peakWidths = NaN(1000,2);
peakLocs = NaN(1000,2);
figure()
for i = 1:size(calMinusLog,2)
    if isnan(calMinusLog(1,i))
        continue
    else
        temp = find(eventLocs(2,:)==i);
        for t = 1:length(temp)
            if isnan(calGapMatOut(eventLocs(1,temp(t)),i)) && kCluster(temp(t))==1
                nexttile; hold on
                scatter(eventLocs(1,temp(t)),pks(temp(t)),100,'LineWidth',2)
                peakAmps(i,1) = pks(temp(t));
                peakWidths(i,1) = w(temp(t));
                peakLocs(i) = eventLocs(1,temp(t));
                plot(calVisualMatIn(:,i),'LineWidth',2,'Color','k')
                plot(calGapMatOut(:,i),'LineWidth',2,'Color','r')
                plot(clusterCenter3)
                plot(clusterCenter3+connectionDistance3)
                plot(calMinusLog(:,i));
            end
        end
%         temp1 = find(eventLocs1(2,:)==i);
%         for t = 1:length(temp1)
%             if isnan(calGapMatOut(eventLocs1(1,temp1(t)),i))
%                 scatter(eventLocs1(1,temp1(t)),pks1(temp1(t)),100,'LineWidth',2)
%                 peakAmps(i,2) = pks1(temp1(t));
%                 peakWidths(i,2) = w1(temp1(t));
%             end
%         end
    end
end


%% 
%plot all cycles with Kmeans cluster group 1 peaks circled
peakAmps = NaN(1000,2);
peakWidths = NaN(1000,2);
peakLocs = NaN(1000,2);
figure()
for i = 1:size(calMinusLog,2)
    if isnan(calMinusLog(1,i))
        continue
    else
        nexttile; hold on
        plot(calVisualMatIn(:,i),'LineWidth',2,'Color','k')
        plot(calGapMatOut(:,i),'LineWidth',2,'Color','r')
        plot(clusterCenter3)
        plot(clusterCenter3+connectionDistance3)
        plot(calMinusLog(:,i));
        temp = find(eventLocs(2,:)==i);
        for t = 1:length(temp)
            if kCluster(temp(t))==1
                scatter(eventLocs(1,temp(t)),pks(temp(t)),100,'LineWidth',2,'MarkerEdgeColor','k')
                peakAmps(i,1) = pks(temp(t));
                peakWidths(i,1) = w(temp(t));
                peakLocs(i) = eventLocs(1,temp(t));
            elseif kCluster(temp(t))==2
                scatter(eventLocs(1,temp(t)),pks(temp(t)),100,'LineWidth',2,'MarkerEdgeColor','m')
                peakAmps(i,1) = pks(temp(t));
                peakWidths(i,1) = w(temp(t));
                peakLocs(i) = eventLocs(1,temp(t));
            end
        end
%         temp1 = find(eventLocs1(2,:)==i);
%         for t = 1:length(temp1)
%             if isnan(calGapMatOut(eventLocs1(1,temp1(t)),i))
%                 scatter(eventLocs1(1,temp1(t)),pks1(temp1(t)),100,'LineWidth',2)
%                 peakAmps(i,2) = pks1(temp1(t));
%                 peakWidths(i,2) = w1(temp1(t));
%             end
%         end
    end
end