%% Concatenate data across experiments
t = 1; k = 1;
tLength = 2350;
delay = 350;
condition = 0;
repeatDays = 3;
numSxs = 5;
numExpts = numSxs*repeatDays;

if condition == 0 %gain down
    directories = {'C:\Users\afanning\Documents\Data\GPdata\probeOC\3rdCohort'};
end

%% create variables for storing data
idxEyeVelBlock2mat = NaN(numSxs,repeatDays);
idxEyeVelBlockAvg = NaN(numSxs,repeatDays);
idxEyeVelFirstAvg = NaN(numSxs,repeatDays);
idxEyeVelLastAvg = NaN(numSxs,repeatDays);
idxDrumVelBlock2mat = NaN(numSxs,repeatDays);
idxDrumVelBlockAvg = NaN(numSxs,repeatDays);
idxDrumVelAvg = NaN(numSxs,repeatDays);
idxDrumVelFirstAvg = NaN(numSxs,repeatDays);
idxDrumVelLastAvg = NaN(numSxs,repeatDays);
idxEyeAccFirstAvg = NaN(numSxs,repeatDays);
idxEyeAccLastAvg = NaN(numSxs,repeatDays);

idxDrumVelProbe1avg = NaN(numSxs,repeatDays);
idxDrumVelProbe2avg = NaN(numSxs,repeatDays);
idxEyeVelProbe1avg = NaN(numSxs,repeatDays);
idxEyeVelProbe2avg = NaN(numSxs,repeatDays);
idxEyeAccProbe1avg = NaN(numSxs,repeatDays);
idxEyeAccProbe2avg = NaN(numSxs,repeatDays);

eyeVelBlockAvg = cell(numSxs,repeatDays);
eyeVelBlock2mat = cell(numSxs,repeatDays);
eyeVelFirstAvg = cell(numSxs,repeatDays);
eyeVelLastAvg = cell(numSxs,repeatDays);
drumVelBlock2mat = cell(numSxs,repeatDays);
drumVelBlockAvg = cell(numSxs,repeatDays);
drumVelAvg = cell(numSxs,repeatDays);
drumVelFirstAvg = cell(numSxs,repeatDays);
drumVelLastAvg = cell(numSxs,repeatDays);
eyeAccFirstAvg = cell(numSxs,repeatDays);
eyeAccLastAvg = cell(numSxs,repeatDays);
drumVelProbe1avg = cell(numSxs,repeatDays);
drumVelProbe2avg = cell(numSxs,repeatDays);
eyeVelProbe1avg = cell(numSxs,repeatDays);
eyeVelProbe2avg = cell(numSxs,repeatDays);
eyeAccProbe1avg = cell(numSxs,repeatDays);
eyeAccProbe2avg = cell(numSxs,repeatDays);

%% Extract data from each experiment
cd(directories{1})
for i = 1:numExpts
    dataSx = load(uigetfile('*.mat'));
    varNames = fieldnames(dataSx);

    [~, idxEyeVelBlock2mat(i)] = ismember('eyeVelBlock2mat', varNames);
    [~, idxEyeVelBlockAvg(i)] = ismember('eyeVelBlockAvg', varNames);
    [~, idxEyeVelFirstAvg(i)] = ismember('eyeVelFirstAvg', varNames);
    [~, idxEyeVelLastAvg(i)] = ismember('eyeVelLastAvg', varNames);
    [~, idxDrumVelBlock2mat(i)] = ismember('drumVelBlock2mat', varNames);
    [~, idxDrumVelBlockAvg(i)] = ismember('drumVelBlockAvg', varNames);
    [~, idxDrumVelAvg(i)] = ismember('drumVelAvg', varNames);
    [~, idxDrumVelFirstAvg(i)] = ismember('drumVelFirstAvg', varNames);
    [~, idxDrumVelLastAvg(i)] = ismember('drumVelLastAvg', varNames);
    [~, idxEyeAccFirstAvg(i)] = ismember('eyeAccFirstAvg', varNames);
    [~, idxEyeAccLastAvg(i)] = ismember('eyeAccLastAvg', varNames);
    
    [~, idxDrumVelProbe1avg(i)] = ismember('drumVelProbe1avg', varNames);
    [~, idxDrumVelProbe2avg(i)] = ismember('drumVelProbe2avg', varNames);
    [~, idxEyeVelProbe1avg(i)] = ismember('eyeVelProbe1avg', varNames);
    [~, idxEyeVelProbe2avg(i)] = ismember('eyeVelProbe2avg', varNames);
    [~, idxEyeAccProbe1avg(i)] = ismember('eyeAccProbe1avg', varNames);
    [~, idxEyeAccProbe2avg(i)] = ismember('eyeAccProbe2avg', varNames);

    eyeVelBlockAvg{t,k} = dataSx.(varNames{idxEyeVelBlockAvg(i)});
    eyeVelBlock2mat{t,k} = dataSx.(varNames{idxEyeVelBlock2mat(i)});
    eyeVelFirstAvg{t,k} = dataSx.(varNames{idxEyeVelFirstAvg(i)});
    eyeVelLastAvg{t,k} = dataSx.(varNames{idxEyeVelLastAvg(i)});
    drumVelBlock2mat{t,k} = dataSx.(varNames{idxDrumVelBlock2mat(i)});
    drumVelBlockAvg{t,k} = dataSx.(varNames{idxDrumVelBlockAvg(i)});
    drumVelAvg{t,k} = dataSx.(varNames{idxDrumVelAvg(i)});
    drumVelFirstAvg{t,k} = dataSx.(varNames{idxDrumVelFirstAvg(i)});
    drumVelLastAvg{t,k} = dataSx.(varNames{idxDrumVelLastAvg(i)});
    
    eyeAccFirstAvg{t,k} = dataSx.(varNames{idxEyeAccFirstAvg(i)});
    eyeAccLastAvg{t,k} = dataSx.(varNames{idxEyeAccLastAvg(i)});
    drumVelProbe1avg{t,k} = dataSx.(varNames{idxDrumVelProbe1avg(i)});
    drumVelProbe2avg{t,k} = dataSx.(varNames{idxDrumVelProbe2avg(i)});
    eyeVelProbe1avg{t,k} = dataSx.(varNames{idxEyeVelProbe1avg(i)});
    eyeVelProbe2avg{t,k} = dataSx.(varNames{idxEyeVelProbe2avg(i)});
    eyeAccProbe1avg{t,k} = dataSx.(varNames{idxEyeAccProbe1avg(i)});
    eyeAccProbe2avg{t,k} = dataSx.(varNames{idxEyeAccProbe2avg(i)});
    
    if condition == 0 && (i == numSxs || i == numSxs*2)
        k = k + 1;
        t = 1;
    else
        t = t + 1;
    end
end

%% 
for j = 1:repeatDays
    drumVelBegin(j) = {[drumVelFirstAvg{1:numSxs,j}]};
    drumVelEnd(j) = {[drumVelLastAvg{1:numSxs,j}]};
    
    eyeVelAvg(j) = {[eyeVelBlockAvg{1:numSxs,j}]};
    eyeVelBegin(j) = {[eyeVelFirstAvg{1:numSxs,j}]};
    eyeVelEnd(j) = {[eyeVelLastAvg{1:numSxs,j}]};
    
    eyeAccBegin(j) = {[eyeAccFirstAvg{1:numSxs,j}]};
    eyeAccEnd(j) = {[eyeAccLastAvg{1:numSxs,j}]};
    
    drumVelProbe1(j) = {[drumVelProbe1avg{1:numSxs,j}]};
    drumVelProbe2(j) = {[drumVelProbe2avg{1:numSxs,j}]};
    
    eyeVelProbe1(j) = {[eyeVelProbe1avg{1:numSxs,j}]};
    eyeVelProbe2(j) = {[eyeVelProbe2avg{1:numSxs,j}]};
    
    eyeAccProbe1(j) = {[eyeAccProbe1avg{1:numSxs,j}]};
    eyeAccProbe2(j) = {[eyeAccProbe2avg{1:numSxs,j}]};
end
drumVelBeginAvg = cellfun(@(x) nanmean(x,2),drumVelBegin,'UniformOutput',false);
drumVelEndAvg = cellfun(@(x) nanmean(x,2),drumVelEnd,'UniformOutput',false);
eyeVelBeginAvg = cellfun(@(x) nanmean(x,2),eyeVelBegin,'UniformOutput',false);
eyeVelEndAvg = cellfun(@(x) nanmean(x,2),eyeVelEnd,'UniformOutput',false);
eyeAccBeginAvg = cellfun(@(x) nanmean(x,2),eyeAccBegin,'UniformOutput',false);
eyeAccEndAvg = cellfun(@(x) nanmean(x,2),eyeAccEnd,'UniformOutput',false);

drumVelProbe1popAvg = cellfun(@(x) nanmean(x,2),drumVelProbe1,'UniformOutput',false);
drumVelProbe2popAvg = cellfun(@(x) nanmean(x,2),drumVelProbe2,'UniformOutput',false);
eyeVelProbe1popAvg = cellfun(@(x) nanmean(x,2),eyeVelProbe1,'UniformOutput',false);
eyeVelProbe2popAvg = cellfun(@(x) nanmean(x,2),eyeVelProbe2,'UniformOutput',false);
eyeAccProbe1popAvg = cellfun(@(x) nanmean(x,2),eyeAccProbe1,'UniformOutput',false);
eyeAccProbe2popAvg = cellfun(@(x) nanmean(x,2),eyeAccProbe2,'UniformOutput',false);

%% plot eye vel and acceleration begin v. end of training
for i = 1:repeatDays
    figure('Name','Each subject eye vel begin v end')
    subplot(2,1,1); hold on
    plot(eyeVelBegin{i})
    plot(drumVelBegin{i})
    ylabel('Velocity')
    title('Each subjects avg eye vel. during first 2 blocks')
    yline(0,'--','Color',[0.65 0.65 0.65])
    
    subplot(2,1,2); hold on
    plot(eyeVelEnd{i})
    plot(drumVelEnd{i})
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    title('Each subjects avg eye vel. during last 2 blocks')
    yline(0,'--','Color',[0.65 0.65 0.65])
    
    figure('Name','Population eye vel begin v end'); hold on
    plot(eyeVelBeginAvg{i})
    plot(eyeVelEndAvg{i})
    plot(drumVelBeginAvg{i})
    plot(drumVelEndAvg{i})
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    legend('First 2 blocks avg','Last 2 blocks avg','Drum vel.')
    title('Population avg eye vel. during first and last 2 blocks')
    yline(0,'--','Color',[0.65 0.65 0.65])

    figure('Name','Each subject eye acc begin v end')
    subplot(2,1,1); hold on
    plot(eyeAccBegin{i})
    plot(drumVelBegin{i})
    ylabel('Motion')
    title('Each subjects avg eye acc. during first 2 blocks')
    yline(0,'--','Color',[0.65 0.65 0.65])
    
    subplot(2,1,2); hold on
    plot(eyeAccEnd{i})
    plot(drumVelEnd{i})
    xlabel('Trial time (ms)')
    ylabel('Motion')
    title('Each subjects avg eye acc. during last 2 blocks')
    yline(0,'--','Color',[0.65 0.65 0.65])
    
    figure('Name','Population avg eye acc. begin v end'); hold on
    plot(eyeAccBeginAvg{i})
    plot(eyeAccEndAvg{i})
    plot(drumVelBeginAvg{i})
    plot(drumVelEndAvg{i})
    xlabel('Trial time (ms)')
    ylabel('Motion')
    legend('First 2 blocks avg','Last 2 blocks avg','Drum vel.')
    title('Population avg eye acc. during first and last 2 blocks')
    yline(0,'--','Color',[0.65 0.65 0.65])
end

%% plot eye vel and acceleration for probe trials
for i = 1:numSxs
    figure('Name','Each subject eye vel during probe trials')
    subplot(2,1,1); hold on
    plot(eyeVelProbe1{i})
    plot(drumVelProbe1{i})
    ylabel('Velocity')
    title('Each subjects avg eye vel. during cued onset probe')
    xline(2500,'--','Color',[0.65 0.65 0.65])
    yline(0,'--','Color',[0.65 0.65 0.65])
    
    subplot(2,1,2); hold on
    plot(eyeVelProbe2{i})
    plot(drumVelProbe2{i})
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    title('Each subjects avg eye vel. during drum offset probe')
    plot(drumVelProbe1{1}(:,1),'--','Color',[0.65 0.65 0.65])
    yline(0,'--','Color',[0.65 0.65 0.65])
    
    figure('Name','Population eye vel during probe trials')
    subplot(2,1,1); hold on
    plot(eyeVelProbe1popAvg{i})
    plot(drumVelProbe1popAvg{i})
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    title('Population avg eye vel. during cued onset probe')
    xline(2500,'--','Color',[0.65 0.65 0.65])
    yline(0,'--','Color',[0.65 0.65 0.65])
    
    subplot(2,1,2); hold on
    plot(eyeVelProbe2popAvg{i})
    plot(drumVelProbe2popAvg{i})
    xlabel('Trial time (ms)')
    ylabel('Velocity')
    title('Population avg eye vel. during drum offset probe')
    plot(drumVelProbe1popAvg{1}(:,1),'--','Color',[0.65 0.65 0.65])
    

    figure('Name','Each subject eye acc during cued onset probe')
    subplot(2,1,1); hold on
    plot(eyeAccProbe1{i})
    plot(drumVelProbe1{i})
    ylabel('Motion')
    title('Each subjects avg eye acc. during cued onset probe')
    xline(2500,'--','Color',[0.65 0.65 0.65])
    yline(0,'--','Color',[0.65 0.65 0.65])
    
    subplot(2,1,2); hold on
    plot(eyeAccProbe2{i})
    plot(drumVelProbe2{i})
    xlabel('Trial time (ms)')
    ylabel('Motion')
    title('Each subjects avg eye acc. during drum offset probe')
    plot(drumVelProbe1popAvg{1}(:,1),'--','Color',[0.65 0.65 0.65])
    
    figure('Name','Population avg eye acc. during cued onset probe')
    subplot(2,1,1); hold on
    plot(eyeAccProbe1popAvg{i})
    plot(drumVelProbe1popAvg{i})
    xlabel('Trial time (ms)')
    ylabel('Motion')
    title('Population avg eye acc. during cued onset probe')
    xline(2500,'--','Color',[0.65 0.65 0.65])
    yline(0,'--','Color',[0.65 0.65 0.65])
    
    subplot(2,1,2); hold on
    plot(eyeAccProbe2popAvg{i})
    plot(drumVelProbe2popAvg{i})
    xlabel('Trial time (ms)')
    ylabel('Motion')
    title('Population avg eye acc. during drum offset probe')
    plot(drumVelProbe1popAvg{1}(:,1),'--','Color',[0.65 0.65 0.65])
end
