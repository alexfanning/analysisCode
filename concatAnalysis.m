
numSxs = 13;
t = 1;
condition = 4;

if condition == 0 %gain down
    directories = {'E:\FP\data\MouseF\data0828\data082811','E:\FP\data\SMCS1\data100219\data10029','E:\FP\data\SMCS3\data1008\data10083',...
        'E:\FP\data\SMCS5\data111219\data11123','E:\FP\data\SMCS12\data0109\data01092','E:\FP\data\SMCS14\data0123\data01231',...
        'E:\FP\data\SMCS15\data0123\data012328','E:\FP\data\SMCS19\data0604\data06049'};
elseif condition == 1 %gain up
    directories = {'E:\FP\data\MouseF\data0828\data08289','E:\FP\data\SMCS1\data100219\data10022','E:\FP\data\SMCS3\data1008\data10084',...
        'E:\FP\data\SMCS5\data111219\data11122','E:\FP\data\SMCS12\data0109\data010912','E:\FP\data\SMCS14\data0123\data01232',...
        'E:\FP\data\SMCS15\data0123\data012327','E:\FP\data\SMCS19\data0604\data06049'};
elseif condition == 2 %okr
    directories = {'E:\FP\data\MouseF\data0828\data082812','E:\FP\data\SMCS1\data100219\data10027','E:\FP\data\SMCS3\data1008\data100810',...
    'E:\FP\data\SMCS5\data111219\data11127','E:\FP\data\SMCS12\data0109\data01094','E:\FP\data\SMCS14\data0123\data01236',...
    'E:\FP\data\SMCS15\data0123\data012334'};
elseif condition == 4 %gain down in alt x2x0
    %smcs35 no good for desacCalcium, smcs39data0722(?)
    %utilize both x2x0 files per subject
    directories = {'E:\FP\data\smcs37\smcs37data1222','E:\FP\data\smcs37\smcs37data0104','E:\FP\data\smcs38\smcs38data0104\smcs38data01045',...
    'E:\FP\data\smcs38\smcs38data0620','E:\FP\data\smcs38\smcs38data0620','E:\FP\data\smcs39\smcs39data0716\smcs39data071610',...
    'E:\FP\data\smcs39\smcs39data0722\smcs39data07223','E:\FP\data\l7cre3\l7cre3data0529\l7cre3data05295','E:\FP\data\l7cre8\l7cre8data0921',...
    'E:\FP\data\l7cre8\l7cre8data1007','E:\FP\data\l7cre8\l7cre8data1007','E:\FP\data\l7cre8\l7cre8data1012',...
    'E:\FP\data\l7cre8\l7cre8data1012'};
elseif condition == 5 %gain up in alt x2x0
    directories = {'E:\FP\data\smcs38\smcs38data0620\smcs38data062014','E:\FP\data\smcs39\smcs39data0716\smcs39data071614',...
    'E:\FP\data\l7cre8\l7cre8data0921','E:\FP\data\l7cre8\l7cre8data1007','E:\FP\data\l7cre8\l7cre8data1012',...
    'E:\FP\data\MouseF\data0828\data082812','E:\FP\data\SMCS1\data100219\data10027','E:\FP\data\SMCS5\data111219\data11127',...
    'E:\FP\data\SMCS12\data0109\data01094','E:\FP\data\SMCS15\data0123\data012334'};
elseif condition == 6 %vord peak velocity series
    directories = {'E:\FP\data\SMCS3\data1008\data10086','E:\FP\data\SMCS5\data111219\data111284',...
        'E:\FP\data\smcs41\smcs41data0803\smcs41data08034','E:\FP\data\l7cre8\l7cre8data1007','E:\FP\data\l7cre8\l7cre8data1012',...
        'E:\FP\data\SMCS3\data1008\data10088','E:\FP\data\SMCS5\data111219\data111286','E:\FP\data\smcs41\smcs41data0803\smcs41data08038',...
        'E:\FP\data\l7cre8\l7cre8data1007','E:\FP\data\l7cre8\l7cre8data1012','E:\FP\data\SMCS3\data1008\data10085',...
        'E:\FP\data\SMCS5\data111219\data111285','E:\FP\data\smcs41\smcs41data0803\smcs41data08039','E:\FP\data\l7cre8\l7cre8data1007',...
        'E:\FP\data\l7cre8\l7cre8data1012','E:\FP\data\SMCS3\data1008\data10087','E:\FP\data\SMCS5\data111219\data111287',...
        'E:\FP\data\smcs41\smcs41data0803\smcs41data08033','E:\FP\data\l7cre8\l7cre8data1007','E:\FP\data\l7cre8\l7cre8data1012'};
elseif condition == 7 %okr peak velocity series
    directories = {'E:\FP\data\SMCS5\data111219\data11126','E:\FP\data\smcs30\smcs30data1003\smcs30data100312',...
        'E:\FP\data\smcs41\smcs41data0803\smcs41data08036','E:\FP\data\l7cre8\l7cre8data1007','E:\FP\data\l7cre8\l7cre8data1012',...
        'E:\FP\data\SMCS5\data111219\data11124','E:\FP\data\smcs30\smcs30data1003\smcs30data10038','E:\FP\data\smcs41\smcs41data0803\smcs41data080311',...
        'E:\FP\data\l7cre8\l7cre8data1007','E:\FP\data\l7cre8\l7cre8data1012','E:\FP\data\SMCS5\data111219\data11127',...
        'E:\FP\data\smcs30\smcs30data1003\smcs30data10035','E:\FP\data\smcs41\smcs41data0803\smcs41data080310','E:\FP\data\l7cre8\l7cre8data1007',...
        'E:\FP\data\l7cre8\l7cre8data1012','E:\FP\data\SMCS5\data111219\data11125','E:\FP\data\smcs30\smcs30data1003\smcs30data100311',...
        'E:\FP\data\smcs41\smcs41data0803\smcs41data08035','E:\FP\data\l7cre8\l7cre8data1007','E:\FP\data\l7cre8\l7cre8data1012'};
elseif condition == 8 %dim vs bright okr
    directories = {'E:\FP\data\l7cre2\l7cre2data0916\l7cre2data09167','E:\FP\data\smcs38\smcs38data0620\smcs38data062016',...
        'E:\FP\data\smcs39\smcs39data0716\smcs39data071615','E:\FP\data\l7cre11\l7cre11data0907','E:\FP\data\l7cre2\l7cre2data0916\l7cre2data09168',...
        'E:\FP\data\smcs38\smcs38data0620\smcs38data062014','E:\FP\data\smcs39\smcs39data0716\smcs39data071614','E:\FP\data\l7cre11\l7cre11data0907'...
        'E:\FP\data\l7cre8\l7cre8data0816','E:\FP\data\l7cre8\l7cre8data0910','E:\FP\data\l7cre8\l7cre8data0921',...
        'E:\FP\data\l7cre9\l7cre9data0824','E:\FP\data\l7cre8\l7cre8data0816','E:\FP\data\l7cre8\l7cre8data0910',...
        'E:\FP\data\l7cre8\l7cre8data0921','E:\FP\data\l7cre9\l7cre9data0824'};
end

%% Concatenate data across experiments from same subject (#1)
%extract data from 1st experiment
idxPks2 = NaN(numSxs,1);
idxIpi2 = NaN(numSxs,1);
idxW2 = NaN(numSxs,1);
idxLocs2 = NaN(numSxs,1);
idxPks4 = NaN(numSxs,1);
idxIpi4 = NaN(numSxs,1);
idxW4 = NaN(numSxs,1);
idxLocs4 = NaN(numSxs,1);
idxPks6 = NaN(numSxs,1);
idxIpi6 = NaN(numSxs,1);
idxW6 = NaN(numSxs,1);
idxLocs6 = NaN(numSxs,1);
idxEventFrequency = NaN(numSxs,1);
idxCalEventsRemovedReshape = NaN(numSxs,1);
idxCalEventAmpsAvg = NaN(numSxs,1);
idxCalDaucNew = NaN(numSxs,1);
idxCalLaucNew = NaN(numSxs,1);
idxCalSpAucNew = NaN(numSxs,1);
idxCalDaucAvg = NaN(numSxs,1);
idxCalLaucAvg = NaN(numSxs,1);
idxCalSpAucAvg = NaN(numSxs,1);
idxCalNorm = NaN(numSxs,1);
idxCalDarkNorm = NaN(numSxs,1);
idxCalAucNorm = NaN(numSxs,1);
idxCalDarkAucNorm = NaN(numSxs,1);
idxCalNormAvg = NaN(numSxs,1);
idxCalDarkNormAvg = NaN(numSxs,1);
idxCalAucNormAvg = NaN(numSxs,1);
idxCalDarkAucNormAvg = NaN(numSxs,1);

idxCalPeakAmps = NaN(numSxs,1);
idxCalDpeakAmps = NaN(numSxs,1);
idxRSpeakAmps = NaN(numSxs,1);
idxRSpeakDiffs = NaN(numSxs,1);

idxCalAmpPriorTrial = NaN(numSxs,1);
idxCalDarkAmpPriorTrial = NaN(numSxs,1);
idxCalLaucPriorTrial = NaN(numSxs,1);
idxCalDaucPriorTrial = NaN(numSxs,1);
idxEyeLampNextTrial = NaN(numSxs,1);
idxCalAmpIdxPriorTrial = NaN(numSxs,1);
idxEyeDampNextTrial = NaN(numSxs,1);
idxCalDarkAmpIdxPriorTrial = NaN(numSxs,1);

idxCalDarkMatOut = NaN(numSxs,1);
idxCalDarkBlockAvg = NaN(numSxs,1);
idxCalDarkBlockSine = NaN(numSxs,1);
idxCalDarkSine = NaN(numSxs,1);
idxEyeDarkBlockAvg = NaN(numSxs,1);
idxTurntableDarkBlockAvg = NaN(numSxs,1);
idxTurntableDarkAvg = NaN(numSxs,1);

idxCalAmpNormPriorTrial = NaN(numSxs,1);
idxCalDarkAmpNormPriorTrial = NaN(numSxs,1);
idxCalAucNormPriorTrial = NaN(numSxs,1);
idxCalDaucNormPriorTrial = NaN(numSxs,1);

calPeaks = cell(numSxs,3);
ipi = cell(numSxs,3);
calWidths = cell(numSxs,3);
peakIdxs = cell(numSxs,3);
eventFrequency = cell(numSxs,3);
calEventsRemovedReshape = cell(numSxs,1);
calEventAmpsAvg = cell(numSxs,1);
calAuc = cell(numSxs,3);
calAucAvg = cell(numSxs,3);
calNorm = cell(numSxs,2);
calAucNorm = cell(numSxs,2);
calNormAvg = cell(numSxs,2);
calAucNormAvg = cell(numSxs,2);

calPeakAmps = cell(numSxs,1);
calDpeakAmps = cell(numSxs,1);
rsPeakAmps = cell(numSxs,1);
rsPeakDiffs = cell(numSxs,1);

calAmpPriorTrial = cell(numSxs,1);
calDarkAmpPriorTrial = cell(numSxs,1);
calLaucPriorTrial = cell(numSxs,1);
calDaucPriorTrial = cell(numSxs,1);
eyeLampNextTrial = cell(numSxs,1);
calAmpIdxPriorTrial = cell(numSxs,1);
eyeDampNextTrial = cell(numSxs,1);
calDarkAmpIdxPriorTrial = cell(numSxs,1);

calAmpNormPriorTrial = cell(numSxs,1);
calAucNormPriorTrial = cell(numSxs,1);
calDarkAmpNormPriorTrial = cell(numSxs,1);
calDaucNormPriorTrial = cell(numSxs,1);

calDarkMatOut = cell(numSxs,1);
calDarkBlockAvg = cell(numSxs,1);
calDarkBlockSine = cell(numSxs,1);
calDarkSine = cell(numSxs,1);
eyeDarkBlockAvg = cell(numSxs,1);
turntableDarkBlockAvg = cell(numSxs,1);
turntableDarkAvg = cell(numSxs,1);

for i = 1:numSxs
    cd(directories{i})
    dataSx = load(uigetfile('*.mat'));
    varNames = fieldnames(dataSx);
    
    if condition ~= 6
        [~, idxPks2(i)] = ismember('pks2', varNames);
        [~, idxIpi2(i)] = ismember('interPeakInterval2', varNames);
        [~, idxW2(i)] = ismember('w2', varNames);
        [~, idxLocs2(i)] = ismember('locsMat2', varNames);
        
        [~, idxCalEventsRemovedReshape(i)] = ismember('calEventsRemovedReshape', varNames);
    end
    [~, idxPks4(i)] = ismember('pks4', varNames);
    [~, idxIpi4(i)] = ismember('interPeakInterval4', varNames);
    [~, idxW4(i)] = ismember('w4', varNames);
    [~, idxLocs4(i)] = ismember('locsMat4', varNames);
    [~, idxPks6(i)] = ismember('pks6', varNames);
    [~, idxIpi6(i)] = ismember('interPeakInterval6', varNames);
    [~, idxW6(i)] = ismember('w6', varNames);
    [~, idxLocs6(i)] = ismember('locsMat6', varNames);
    [~, idxEventFrequency(i)] = ismember('eventFrequency', varNames);
    [~, idxCalEventAmpsAvg(i)] = ismember('calEventAmpsAvg', varNames);
    [~, idxCalDaucNew(i)] = ismember('calDaucNew', varNames);
    [~, idxCalLaucNew(i)] = ismember('calLaucNew', varNames);
    [~, idxCalSpAucNew(i)] = ismember('calSpAucNew', varNames);
    [~, idxCalDaucAvg(i)] = ismember('calDaucAvg', varNames);
    [~, idxCalLaucAvg(i)] = ismember('calLaucAvg', varNames);
    [~, idxCalSpAucAvg(i)] = ismember('calSpAucAvg', varNames);
    [~, idxCalNorm(i)] = ismember('calNorm', varNames);
    [~, idxCalDarkNorm(i)] = ismember('calDarkNorm', varNames);
    [~, idxCalAucNorm(i)] = ismember('calAucNorm', varNames);
    [~, idxCalDarkAucNorm(i)] = ismember('calDarkAucNorm', varNames);
    [~, idxCalNormAvg(i)] = ismember('calNormAvg', varNames);
    [~, idxCalDarkNormAvg(i)] = ismember('calDarkNormAvg', varNames);
    [~, idxCalAucNormAvg(i)] = ismember('calAucNormAvg', varNames);
    [~, idxCalDarkAucNormAvg(i)] = ismember('calDarkAucNormAvg', varNames);
    [~, idxCalPeakAmps(i)] = ismember('cal_peak_amps', varNames);
    [~, idxCalDpeakAmps(i)] = ismember('calD_peak_amps', varNames);
    [~, idxRSpeakAmps(i)] = ismember('rs_peak_amps', varNames);
    [~, idxRSpeakDiffs(i)] = ismember('rs_peak_diffs', varNames);
    [~, idxCalAmpPriorTrial(i)] = ismember('calAmpPriorTrial', varNames);
    [~, idxCalDarkAmpPriorTrial(i)] = ismember('calDarkAmpPriorTrial', varNames);
    [~, idxCalLaucPriorTrial(i)] = ismember('calLaucPriorTrial', varNames);
    [~, idxCalDaucPriorTrial(i)] = ismember('calDaucPriorTrial', varNames);
    [~, idxEyeLampNextTrial(i)] = ismember('eyeLampNextTrial', varNames);
    [~, idxEyeDampNextTrial(i)] = ismember('eyeDampNextTrial', varNames);
    [~, idxCalAmpIdxPriorTrial(i)] = ismember('calAmpIdxPriorTrial', varNames);
    [~, idxCalDarkAmpIdxPriorTrial(i)] = ismember('calDarkAmpIdxPriorTrial', varNames);
    [~, idxCalAmpNormPriorTrial(i)] = ismember('calNormPriorTrial', varNames);
    [~, idxCalDarkAmpNormPriorTrial(i)] = ismember('calDarkNormPriorTrial', varNames);
    [~, idxCalAucNormPriorTrial(i)] = ismember('calAucNormPriorTrial', varNames);
    [~, idxCalDaucNormPriorTrial(i)] = ismember('calAucDarkNormPriorTrial', varNames);
    
    [~, idxCalDarkMatOut(i)] = ismember('calDarkMatOut', varNames);
    [~, idxCalDarkBlockAvg(i)] = ismember('calDarkBlockAvg', varNames);
    [~, idxCalDarkSine(i)] = ismember('calDarkSine', varNames);
    [~, idxEyeDarkBlockAvg(i)] = ismember('eyeDarkBlockAvg', varNames);
    [~, idxTurntableDarkBlockAvg(i)] = ismember('turntableDarkBlockAvg', varNames);
    [~, idxTurntableDarkAvg(i)] = ismember('turntableDarkAvg', varNames);
    
    if condition ~= 6
        calPeaks{t,1} = dataSx.(varNames{idxPks2(i)});
        ipi{t,1} = dataSx.(varNames{idxIpi2(i)});
        calWidths{t,1} = dataSx.(varNames{idxW2(i)});
        peakIdxs{t,1} = dataSx.(varNames{idxLocs2(i)});
        
        %calEventsRemovedReshape{t} = dataSx.(varNames{idxCalEventsRemovedReshape(i)});
    end
    
    
    if condition ~= 5 && condition ~= 7
        calPeaks{t,2} = dataSx.(varNames{idxPks4(i)});
        ipi{t,2} = dataSx.(varNames{idxIpi4(i)});
        calWidths{t,2} = dataSx.(varNames{idxW4(i)});
        peakIdxs{t,2} = dataSx.(varNames{idxLocs4(i)});
        
        calDarkMatOut{t,1} = dataSx.(varNames{idxCalDarkMatOut(i)});
        calDarkBlockAvg{t,1} = dataSx.(varNames{idxCalDarkBlockAvg(i)});
        calDarkSine{t,1} = dataSx.(varNames{idxCalDarkSine(i)});
        eyeDarkBlockAvg{t,1} = dataSx.(varNames{idxEyeDarkBlockAvg(i)});
        turntableDarkBlockAvg{t,1} = dataSx.(varNames{idxTurntableDarkBlockAvg(i)});
        turntableDarkAvg{t,1} = dataSx.(varNames{idxTurntableDarkAvg(i)});
    end
    
    calPeaks{t,3} = dataSx.(varNames{idxPks6(i)});
    ipi{t,3} = dataSx.(varNames{idxIpi6(i)});
    calWidths{t,3} = dataSx.(varNames{idxW6(i)});
    peakIdxs{t,3} = dataSx.(varNames{idxLocs6(i)});
    
    eventFrequency{t,1} = dataSx.(varNames{idxEventFrequency(i)});
    calEventAmpsAvg{t} = dataSx.(varNames{idxCalEventAmpsAvg(i)});
    calAuc{t,1} = dataSx.(varNames{idxCalDaucNew(i)});
    calAuc{t,2} = dataSx.(varNames{idxCalLaucNew(i)});
    calAuc{t,3} = dataSx.(varNames{idxCalSpAucNew(i)});
    calAucAvg{t,1} = dataSx.(varNames{idxCalDaucAvg(i)});
    calAucAvg{t,2} = dataSx.(varNames{idxCalLaucAvg(i)});
    calAucAvg{t,3} = dataSx.(varNames{idxCalSpAucAvg(i)});
    calNorm{t,1} = dataSx.(varNames{idxCalDarkNorm(i)});
    calNorm{t,2} = dataSx.(varNames{idxCalNorm(i)});
    calAucNorm{t,1} = dataSx.(varNames{idxCalDarkAucNorm(i)});
    calAucNorm{t,2} = dataSx.(varNames{idxCalAucNorm(i)});
    calNormAvg{t,1} = dataSx.(varNames{idxCalDarkNormAvg(i)});
    calNormAvg{t,2} = dataSx.(varNames{idxCalNormAvg(i)});
    calAucNormAvg{t,1} = dataSx.(varNames{idxCalDarkAucNormAvg(i)});
    calAucNormAvg{t,2} = dataSx.(varNames{idxCalAucNormAvg(i)});
    
    calPeakAmps{t,1} = dataSx.(varNames{idxCalPeakAmps(i)});
    calPeakAmps{t,2} = dataSx.(varNames{idxCalDpeakAmps(i)});
    rsPeakAmps{t,1} = dataSx.(varNames{idxRSpeakAmps(i)});
    rsPeakDiffs{t,1} = dataSx.(varNames{idxRSpeakDiffs(i)});
    
    calAmpPriorTrial{t,1} = dataSx.(varNames{idxCalAmpPriorTrial(i)});
    calDarkAmpPriorTrial{t,1} = dataSx.(varNames{idxCalDarkAmpPriorTrial(i)});
    calLaucPriorTrial{t,1} = dataSx.(varNames{idxCalLaucPriorTrial(i)});
    calDaucPriorTrial{t,1} = dataSx.(varNames{idxCalDaucPriorTrial(i)});
    eyeLampNextTrial{t,1} = dataSx.(varNames{idxEyeLampNextTrial(i)});
    calAmpIdxPriorTrial{t,1} = dataSx.(varNames{idxCalAmpIdxPriorTrial(i)});
    eyeDampNextTrial{t,1} = dataSx.(varNames{idxEyeDampNextTrial(i)});
    calDarkAmpIdxPriorTrial{t,1} = dataSx.(varNames{idxCalDarkAmpIdxPriorTrial(i)});
    
    calAmpNormPriorTrial{t,1} = dataSx.(varNames{idxCalAmpNormPriorTrial(i)});
    calDarkAmpNormPriorTrial{t,1} = dataSx.(varNames{idxCalDarkAmpNormPriorTrial(i)});
    calAucNormPriorTrial{t,1} = dataSx.(varNames{idxCalAucNormPriorTrial(i)});
    calDaucNormPriorTrial{t,1} = dataSx.(varNames{idxCalDaucNormPriorTrial(i)});
    t = t + 1;
end

%% Compile data from all subjects
if condition ~= 5 && condition ~= 7
    calDarkAvg = cellfun(@(x) nanmean(x,2),calDarkMatOut,'UniformOutput',false);
    a = 1;
    calDarkPopAvg = NaN(1000,4);
    calDarkSinePopAvg = NaN(4,1000);
    for i = 1:numSxs/4:numSxs
        calDarkPop(:,i:i+numSxs/4-1) = cat(2,calDarkAvg{i:i+numSxs/4-1});
        calDarkPopAvg(:,a) = nanmean(calDarkPop(:,i:i+numSxs/4-1),2);
        calDarkSinePop(i:i+numSxs/4-1,:) = cat(1,calDarkSine{i:i+numSxs/4-1});
        calDarkSinePopAvg(a,:) = nanmean(calDarkSinePop(i:i+numSxs/4-1,:),1);
        a = a + 1;
    end

    if condition ~= 4
        figure('Name','vestibular-dark subject cycle-averages');
        subplot(2,2,1); hold on
        for i = 1:numSxs/4
            plot(calDarkAvg{i}*100)
        end
        ylabel('%\DeltaF/G')

        subplot(2,2,2); hold on
        for i = numSxs/4+1:numSxs/2
            plot(calDarkAvg{i}*100)
        end

        subplot(2,2,3); hold on
        for i = numSxs/2+1:numSxs-numSxs/4
            plot(calDarkAvg{i}*100)
        end
        xlabel('Time (ms)')
        ylabel('%\DeltaF/G')

        subplot(2,2,4); hold on
        for i = numSxs-numSxs/4+1:numSxs
            plot(calDarkAvg{i}*100)
        end
        xlabel('Time (ms)')

        figure('Name','vestibular-dark population cycle-averages');
        plot(calDarkPopAvg*100)
        xlabel('Time (ms)')
        ylabel('%\DeltaF/G')

        figure('Name','vestibular-dark subject cycle-averages');
        subplot(2,2,1); hold on
        for i = 1:numSxs/4
            plot(calDarkSine{i}*100)
        end
        ylabel('%\DeltaF/G')

        subplot(2,2,2); hold on
        for i = numSxs/4+1:numSxs/2
            plot(calDarkSine{i}*100)
        end

        subplot(2,2,3); hold on
        for i = numSxs/2+1:numSxs-numSxs/4
            plot(calDarkSine{i}*100)
        end
        xlabel('Time (ms)')
        ylabel('%\DeltaF/G')

        subplot(2,2,4); hold on
        for i = numSxs-numSxs/4+1:numSxs
            plot(calDarkSine{i}*100)
        end
        xlabel('Time (ms)')

        figure('Name','vestibular-dark population cycle-averages');
        plot(calDarkSinePopAvg')
        xlabel('Time (ms)')
        ylabel('%\DeltaF/G')
    end
end

%% Plot calcium amplitude and AUC
calAmpPop = NaN(numSxs,3);
for i = 1:numSxs
    calAmpPop(i,1:3) = cat(2,calEventAmpsAvg{i}(1,:));
end
if condition ~= 6 && condition ~= 7
    calAmpPopAvg = mean(calAmpPop,1);
    calAmpPopSE = std(calAmpPop,0,1)/sqrt(numel(calAmpPop(:,1)));
else
    j = 1;
    for i = 1:numSxs/4:numSxs
        calAmpPopAvg(j,:) = mean(calAmpPop(i:i+(numSxs/4)-1,:),1);
        calAmpPopSE(j,:) = std(calAmpPop(i:i+(numSxs/4)-1,:),0,1)/sqrt(numel(calAmpPop(i:i+(numSxs/4)-1,2)));
        j = j + 1;
    end
end

calAucPop = NaN(numSxs,3);
for i = 1:3
    calAucPop(1:numSxs,i) = cat(2,calAucAvg{1:end,i});
end
if condition ~= 6 && condition ~= 7
    calAucPopAvg = mean(calAucPop,1);
    calAucPopSE = std(calAucPop,0,1)/sqrt(numel(calAucPop(:,1)));
else
    j = 1;
    for i = 1:numSxs/4:numSxs
        calAucPopAvg(j,:) = mean(calAucPop(i:i+(numSxs/4)-1,:),1);
        calAucPopSE(j,:) = std(calAucPop(i:i+(numSxs/4)-1,:),0,1)/sqrt(numel(calAucPop(i:i+(numSxs/4)-1,:)));
        j = j + 1;
    end
end

figure()
if condition == 0 || condition == 4
    subplot(1,2,1);hold on
    sgtitle('x0 acute')
    bar([calAmpPopAvg(:,2),calAmpPopAvg(:,1),calAmpPopAvg(:,3)],'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    scatter(ones(size(calAmpPop(:,2))),calAmpPop(:,2),'LineWidth',1)
    scatter(ones(size(calAmpPop(:,1))).*2,calAmpPop(:,1),'LineWidth',1)
    scatter(ones(size(calAmpPop(:,3))).*3,calAmpPop(:,3),'LineWidth',1)
    errorbar([calAmpPopAvg(:,2),calAmpPopAvg(:,1),calAmpPopAvg(:,3)],[calAmpPopSE(2),calAmpPopSE(1),calAmpPopSE(3)],'Color','k','LineStyle','none','LineWidth',2)
    xticks(1:3)
    xticklabels({'Vdark','Visual','Sp'})
    ylabel('Peak amplitude')
    
    subplot(1,2,2); hold on
    bar(calAucPopAvg,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    scatter(ones(size(calAucPop(:,1))),calAucPop(:,1),'LineWidth',1)
    scatter(ones(size(calAucPop(:,2))).*2,calAucPop(:,2),'LineWidth',1)
    scatter(ones(size(calAucPop(:,3))).*3,calAucPop(:,3),'LineWidth',1)
    errorbar(calAucPopAvg,calAucPopSE,'Color','k','LineStyle','none','LineWidth',2)
    xticks(1:3)
    xticklabels({'Vdark','Visual','Sp'})
    ylabel('AUC')
elseif condition == 1 || condition == 5
    subplot(1,2,1);hold on
    sgtitle('x2 acute')
    bar([calAmpPopAvg(:,2),calAmpPopAvg(:,1),calAmpPopAvg(:,3)],'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    scatter(ones(size(calAmpPop(:,2))),calAmpPop(:,2),'LineWidth',1)
    scatter(ones(size(calAmpPop(:,1))).*2,calAmpPop(:,1),'LineWidth',1)
    scatter(ones(size(calAmpPop(:,3))).*3,calAmpPop(:,3),'LineWidth',1)
    errorbar([calAmpPopAvg(:,2),calAmpPopAvg(:,1),calAmpPopAvg(:,3)],[calAmpPopSE(2),calAmpPopSE(1),calAmpPopSE(3)],'Color','k','LineStyle','none','LineWidth',2)
    xticks(1:3)
    xticklabels({'Vdark','Visual','Sp'})
    ylabel('Peak amplitude')
    
    subplot(1,2,2); hold on
    bar(calAucPopAvg,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    scatter(ones(size(calAucPop(:,1))),calAucPop(:,1),'LineWidth',1)
    scatter(ones(size(calAucPop(:,2))).*2,calAucPop(:,2),'LineWidth',1)
    scatter(ones(size(calAucPop(:,3))).*3,calAucPop(:,3),'LineWidth',1)
    errorbar(calAucPopAvg,calAucPopSE,'Color','k','LineStyle','none','LineWidth',2)
    xticks(1:3)
    xticklabels({'Vdark','Visual','Sp'})
    ylabel('AUC')
elseif condition == 2
    subplot(1,2,1);hold on
    sgtitle('okr acute')
    bar([calAmpPopAvg(:,1),calAmpPopAvg(:,3)],'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    scatter(ones(size(calAmpPop(:,1))).*1,calAmpPop(:,1),'LineWidth',1)
    scatter(ones(size(calAmpPop(:,3))).*2,calAmpPop(:,3),'LineWidth',1)
    errorbar([calAmpPopAvg(:,1),calAmpPopAvg(:,3)],[calAmpPopSE(1),calAmpPopSE(3)],'Color','k','LineStyle','none','LineWidth',2)
    xticks(1:2)
    xticklabels({'Visual','Sp'})
    ylabel('Peak amplitude')
    
    subplot(1,2,2); hold on
    bar([calAucPopAvg(2),calAucPopAvg(3)],'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    scatter(ones(size(calAucPop(:,2))),calAucPop(:,2),'LineWidth',1)
    scatter(ones(size(calAucPop(:,3))).*2,calAucPop(:,3),'LineWidth',1)
    errorbar([calAucPopAvg(2),calAucPopAvg(3)],[calAucPopSE(2),calAucPopSE(3)],'Color','k','LineStyle','none','LineWidth',2)
    xticks(1:2)
    xticklabels({'Visual','Sp'})
    ylabel('AUC')
elseif condition == 6
    subplot(1,2,1);hold on
    sgtitle('vord')
    bar(calAmpPopAvg(:,2),'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    scatter(ones(size(calAmpPop(1:numSxs/4,2))).*1,calAmpPop(1:numSxs/4,2),'LineWidth',1)
    scatter(ones(size(calAmpPop(numSxs/4+1:numSxs/2,2))).*2,calAmpPop(numSxs/4+1:numSxs/2,2),'LineWidth',1)
    scatter(ones(size(calAmpPop(numSxs/2+1:numSxs-numSxs/4,2))).*3,calAmpPop(numSxs/2+1:numSxs-numSxs/4,2),'LineWidth',1)
    scatter(ones(size(calAmpPop(numSxs-numSxs/4+1:numSxs,2))).*4,calAmpPop(numSxs-numSxs/4+1:numSxs,2),'LineWidth',1)
    errorbar([calAmpPopAvg(1,2),calAmpPopAvg(2,2),calAmpPopAvg(3,2),calAmpPopAvg(4,2)],[calAmpPopSE(1,2),calAmpPopSE(2,2),calAmpPopSE(3,2),calAmpPopSE(4,2)],'Color','k','LineStyle','none','LineWidth',2)
    xticks(1:4)
    xticklabels({'1','5','10','20'})
    ylabel('Peak amplitude')
    
    subplot(1,2,2); hold on
    bar(calAucPopAvg(:,1),'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    scatter(ones(size(calAucPop(1:numSxs/4,1))).*1,calAucPop(1:numSxs/4,1),'LineWidth',1)
    scatter(ones(size(calAucPop(numSxs/4+1:numSxs/2,1))).*2,calAucPop(numSxs/4+1:numSxs/2,1),'LineWidth',1)
    scatter(ones(size(calAucPop(numSxs/2+1:numSxs-numSxs/4,1))).*3,calAucPop(numSxs/2+1:numSxs-numSxs/4,1),'LineWidth',1)
    scatter(ones(size(calAucPop(numSxs-numSxs/4+1:numSxs,1))).*4,calAucPop(numSxs-numSxs/4+1:numSxs,1),'LineWidth',1)
    errorbar([calAucPopAvg(1,1),calAucPopAvg(2,1),calAucPopAvg(3,1),calAucPopAvg(4,1)],[calAucPopSE(1,1),calAucPopSE(2,1),calAucPopSE(3,1),calAucPopSE(4,1)],'Color','k','LineStyle','none','LineWidth',2)
    xticks(1:4)
    xticklabels({'1','5','10','20'})
    ylabel('AUC')
    xlabel('Peak velocity ({\circ}/s)')
elseif condition == 7
    subplot(1,2,1);hold on
    sgtitle('okr')
    bar(calAmpPopAvg(:,1),'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    scatter(ones(size(calAmpPop(1:numSxs/4,1))).*1,calAmpPop(1:numSxs/4,1),'LineWidth',1)
    scatter(ones(size(calAmpPop(numSxs/4+1:numSxs/2,1))).*2,calAmpPop(numSxs/4+1:numSxs/2,1),'LineWidth',1)
    scatter(ones(size(calAmpPop(numSxs/2+1:numSxs-numSxs/4,1))).*3,calAmpPop(numSxs/2+1:numSxs-numSxs/4,1),'LineWidth',1)
    scatter(ones(size(calAmpPop(numSxs-numSxs/4+1:numSxs,1))).*4,calAmpPop(numSxs-numSxs/4+1:numSxs,1),'LineWidth',1)
    errorbar([calAmpPopAvg(1,1),calAmpPopAvg(2,1),calAmpPopAvg(3,1),calAmpPopAvg(4,1)],[calAmpPopSE(1,1),calAmpPopSE(2,1),calAmpPopSE(3,1),calAmpPopSE(4,1)],'Color','k','LineStyle','none','LineWidth',2)
    xticks(1:4)
    xticklabels({'1','5','10','20'})
    ylabel('Peak amplitude')
    
    subplot(1,2,2); hold on
    bar(calAucPopAvg(:,2),'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    scatter(ones(size(calAucPop(1:numSxs/4,2))).*1,calAucPop(1:numSxs/4,2),'LineWidth',1)
    scatter(ones(size(calAucPop(numSxs/4+1:numSxs/2,2))).*2,calAucPop(numSxs/4+1:numSxs/2,2),'LineWidth',1)
    scatter(ones(size(calAucPop(numSxs/2+1:numSxs-numSxs/4,2))).*3,calAucPop(numSxs/2+1:numSxs-numSxs/4,2),'LineWidth',1)
    scatter(ones(size(calAucPop(numSxs-numSxs/4+1:numSxs,2))).*4,calAucPop(numSxs-numSxs/4+1:numSxs,2),'LineWidth',1)
    errorbar([calAucPopAvg(1,2),calAucPopAvg(2,2),calAucPopAvg(3,2),calAucPopAvg(4,2)],[calAucPopSE(1,2),calAucPopSE(2,2),calAucPopSE(3,2),calAucPopSE(4,2)],'Color','k','LineStyle','none','LineWidth',2)
    xticks(1:4)
    xticklabels({'1','5','10','20'})
    ylabel('AUC')
    xlabel('Peak velocity ({\circ}/s)')
end

%% Compile normalized data
calNormPop = NaN(numSxs,2);
calAucNormPop = NaN(numSxs,2);
for i = 1:numSxs
    calNormPop(i,1:2) = cat(2,calNormAvg{i,:});
    calAucNormPop(i,1:2) = cat(2,calAucNormAvg{i,:});
end
calNormPopAvg = mean(calNormPop,1);
calNormPopSE = std(calNormPop,0,1)/sqrt(numel(calNormPop(:,1)));
calAucNormPopAvg = mean(calAucNormPop,1);
calAucNormPopSE = std(calAucNormPop)/sqrt(numel(calAucNormPop(:,1)));

figure()
if condition == 0 || condition == 4
    subplot(1,2,1);hold on
    sgtitle('x0 acute')
    bar([calNormPopAvg(1),calNormPopAvg(2)],'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    scatter(ones(size(calNormPop(:,1))),calNormPop(:,1),'LineWidth',1)
    scatter(ones(size(calNormPop(:,2))).*2,calNormPop(:,2),'LineWidth',1)
    errorbar(calNormPopAvg,calNormPopSE,'Color','k','LineStyle','none','LineWidth',2)
    yline(1,'LineStyle','--')
    xticks(1:2)
    xticklabels({'Vdark','Visual'})
    ylabel('Peak amplitude (normalized)')
    
    subplot(1,2,2); hold on
    bar(calAucNormPopAvg,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    scatter(ones(size(calAucNormPop(:,1))),calAucNormPop(:,1),'LineWidth',1)
    scatter(ones(size(calAucNormPop(:,2))).*2,calAucNormPop(:,2),'LineWidth',1)
    errorbar(calAucNormPopAvg,calAucNormPopSE,'Color','k','LineStyle','none','LineWidth',2)
    yline(1,'LineStyle','--')
    xticks(1:2)
    xticklabels({'Vdark','Visual'})
    ylabel('AUC (normalized)')
elseif condition == 1 || condition == 5
    subplot(1,2,1);hold on
    sgtitle('x2 acute')
    bar([calNormPopAvg(1),calNormPopAvg(2)],'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    scatter(ones(size(calNormPop(:,1))),calNormPop(:,1),'LineWidth',1)
    scatter(ones(size(calNormPop(:,2))).*2,calNormPop(:,2),'LineWidth',1)
    errorbar(calNormPopAvg,calNormPopSE,'Color','k','LineStyle','none','LineWidth',2)
    yline(1,'LineStyle','--')
    xticks(1:2)
    xticklabels({'Vdark','Visual'})
    ylabel('Peak amplitude (normalized)')
    
    subplot(1,2,2); hold on
    bar(calAucNormPopAvg,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    scatter(ones(size(calAucNormPop(:,1))),calAucNormPop(:,1),'LineWidth',1)
    scatter(ones(size(calAucNormPop(:,2))).*2,calAucNormPop(:,2),'LineWidth',1)
    errorbar(calAucNormPopAvg,calAucNormPopSE,'Color','k','LineStyle','none','LineWidth',2)
    yline(1,'LineStyle','--')
    xticks(1:2)
    xticklabels({'Vdark','Visual'})
    ylabel('AUC (normalized)')
elseif condition == 2
    subplot(1,2,1);hold on
    sgtitle('okr acute')
    bar(calNormPopAvg(2),'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    scatter(ones(size(calNormPop(:,2))).*1,calNormPop(:,2),'LineWidth',1)
    errorbar(calNormPopAvg(2),calNormPopSE(2),'Color','k','LineStyle','none','LineWidth',2)
    yline(1,'LineStyle','--')
    xticks(1)
    xticklabels({'Visual'})
    ylabel('Peak amplitude (normalized)')
    
    subplot(1,2,2); hold on
    bar(calAucNormPopAvg(2),'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    scatter(ones(size(calAucNormPop(:,2))).*1,calAucNormPop(:,2),'LineWidth',1)
    errorbar(calAucNormPopAvg(2),calAucNormPopSE(2),'Color','k','LineStyle','none','LineWidth',2)
    yline(1,'LineStyle','--')
    xticks(1)
    xticklabels({'Visual'})
    ylabel('AUC (normalized)')
end

%% Compile event parameters data
maxDims = cellfun('size', peakIdxs,2);
maxDimPeakIdxs = max(sum(maxDims));
maxDimsIpi1 = cellfun('size', ipi,2);
maxDimsIpi2 = cellfun('size', ipi,1);
maxDimsWidths1 = cellfun('size', calWidths,2);
maxDimsWidths2 = cellfun('size', calWidths,1);
a = 1;
for t = 1:3
    for i = 1:numSxs
        maxDimsIpi(a,1) = maxDimsIpi1(i,t);
        maxDimsIpi(a,2) = maxDimsIpi2(i,t);
        maxDimsWidths(a,1) = maxDimsWidths1(i,t);
        maxDimsWidths(a,2) = maxDimsWidths2(i,t);
        a = a + 1;
    end
end
for i = 1:length(maxDimsIpi)
    ipiDims(i) = max(maxDimsIpi(i,:));
    widthDims(i) = max(maxDimsWidths(i,:));
end
ipiDimsReshape = reshape(ipiDims,size(ipi,1),size(ipi,2));
widthDimsReshape = reshape(widthDims,size(calWidths,1),size(calWidths,2));
m = 1;
for i = 1:numSxs:(numSxs*3)
    ipiSum(m) = sum(ipiDims(i:i+numSxs-1));
    widthSum(m) = sum(widthDims(i:i+numSxs-1));
    m = m + 1;
end
maxDimsIpiLength = max(ipiSum);
maxDimsWidthLength = max(widthSum);

peakIdxsPop = NaN(maxDimPeakIdxs,3);
ipiPop = NaN(maxDimsIpiLength,3);
widthPop = NaN(maxDimsWidthLength,3);
if condition ~= 5 && condition ~= 6 && condition ~= 7
    for t = 1:3
        a = 1; b = 1; c = 1;
        for i = 1:numSxs
            peakIdxsPop(a:a+maxDims(i,t)-1,t) = peakIdxs{i,t}(1,:);
            ipiPop(b:b+ipiDimsReshape(i,t)-1,t) = ipi{i,t};
            widthPop(c:c+widthDimsReshape(i,t)-1,t) = calWidths{i,t};
            a = a + maxDims(i,t);
            b = b + ipiDimsReshape(i,t);
            c = c + widthDimsReshape(i,t);
        end
    end
elseif condition == 5
    for t = 1:2:3
        a = 1; b = 1; c = 1;
        for i = 1:numSxs
            peakIdxsPop(a:a+maxDims(i,t)-1,t) = peakIdxs{i,t}(1,:);
            ipiPop(b:b+ipiDimsReshape(i,t)-1,t) = ipi{i,t};
            widthPop(c:c+widthDimsReshape(i,t)-1,t) = calWidths{i,t};
            a = a + maxDims(i,t);
            b = b + ipiDimsReshape(i,t);
            c = c + widthDimsReshape(i,t);
        end
    end
elseif condition == 6
    peakIdxsPop = NaN(maxDimPeakIdxs,4);
    ipiPop = NaN(maxDimsIpiLength,4);
    widthPop = NaN(maxDimsWidthLength,4);
    j = 1;
    for d = 1:4
        a = 1; b = 1; c = 1;
        for i = 1:numSxs/4
            peakIdxsPop(a:a+maxDims(j,2)-1,d) = peakIdxs{j,2}(1,:);
            ipiPop(b:b+ipiDimsReshape(j,2)-1,d) = ipi{j,2};
            widthPop(c:c+widthDimsReshape(j,2)-1,d) = calWidths{j,2};
            if j + 1 < numSxs + 1
                j = j + 1;
                a = a + maxDims(j,2);
                b = b + ipiDimsReshape(j,2);
                c = c + widthDimsReshape(j,2);
            end
        end
    end
elseif condition == 7
    peakIdxsPop = NaN(maxDimPeakIdxs,4);
    ipiPop = NaN(maxDimsIpiLength,4);
    widthPop = NaN(maxDimsWidthLength,4);
    j = 1;
    for d = 1:4
        a = 1; b = 1; c = 1;
        for i = 1:numSxs/4
            peakIdxsPop(a:a+maxDims(j,1)-1,d) = peakIdxs{j,1}(1,:);
            ipiPop(b:b+ipiDimsReshape(j,1)-1,d) = ipi{j,1};
            widthPop(c:c+widthDimsReshape(j,1)-1,d) = calWidths{j,1};
            if j + 1 < numSxs + 1
                j = j + 1;
                a = a + maxDims(j,2);
                b = b + ipiDimsReshape(j,1);
                c = c + widthDimsReshape(j,1);
            end
        end
    end
end
ipiPop(ipiPop > 6000) = NaN;

%% Plot calcium event peaks
figure()
if condition == 0 || condition == 4
    sgtitle('x0 acute')
    subplot(2,2,1);hold on
    histogram(peakIdxsPop(:,2),30,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xline(250,'LineStyle','--','Color','r','LineWidth',1)
    text(300,44,'Ipsi drum peak','Color','r')
    xticks(0:250:1000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis'); 
    set(xax,'TickDirection','out','TickLength',[0.01 0.05])
    ylabel('Number of events')
    xlabel('Time of peak (ms)')
    title('Vdark')
    subplot(2,2,2); hold on
    histogram(peakIdxsPop(:,1),30,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xline(750,'LineStyle','--','Color','r','LineWidth',1)
    text(100,55,'Contra drum peak','Color','r')
    xticks(0:250:1000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis'); 
    set(xax,'TickDirection','out','TickLength',[0.01 0.05])
    xlabel('Time of peak(ms)')
    title('Visual')
    subplot(2,2,3); hold on
    histogram(peakIdxsPop(:,3),30,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(0:250:1000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis'); 
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    ylabel('Number of events')
    title('Spontaneous')
elseif condition == 1 || condition == 5
    sgtitle('x2 acute')
    subplot(2,2,1);hold on
    histogram(peakIdxsPop(:,2),30,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xline(250,'LineStyle','--','Color','r','LineWidth',1)
    text(300,44,'Ipsi drum peak','Color','r')
    xticks(0:250:1000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis'); 
    set(xax,'TickDirection','out','TickLength',[0.01 0.05])
    ylabel('Number of events')
    xlabel('Time of peak (ms)')
    title('Vdark')
    subplot(2,2,2); hold on
    histogram(peakIdxsPop(:,1),30,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xline(750,'LineStyle','--','Color','r','LineWidth',1)
    text(100,55,'Contra drum peak','Color','r')
    xticks(0:250:1000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis'); 
    set(xax,'TickDirection','out','TickLength',[0.01 0.05])
    xlabel('Time of peak(ms)')
    title('Visual')
    subplot(2,2,3); hold on
    histogram(peakIdxsPop(:,3),30,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(0:250:1000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis'); 
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    ylabel('Number of events')
    title('Spontaneous')
elseif condition == 2
    sgtitle('okr acute')
    subplot(2,2,1); hold on
    histogram(peakIdxsPop(:,1),30,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xline(750,'LineStyle','--','Color','r','LineWidth',1)
    text(100,55,'Contra drum peak','Color','r')
    xticks(0:250:1000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis'); 
    set(xax,'TickDirection','out','TickLength',[0.01 0.05])
    xlabel('Time of peak(ms)')
    title('Visual')
    subplot(2,2,2); hold on
    histogram(peakIdxsPop(:,3),30,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(0:250:1000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis'); 
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    ylabel('Number of events')
    title('Spontaneous')
elseif condition == 6
    sgtitle('vord')
    subplot(2,2,1); hold on
    histogram(peakIdxsPop(:,1),30,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xline(250,'LineStyle','--','Color','r','LineWidth',1)
    text(300,44,'Ipsi drum peak','Color','r')
    xticks(0:250:1000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis'); 
    set(xax,'TickDirection','out','TickLength',[0.01 0.05])
    ylabel('Number of events')
    title('1{\circ}/s')
    
    subplot(2,2,2); hold on
    histogram(peakIdxsPop(:,2),30,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xline(250,'LineStyle','--','Color','r','LineWidth',1)
    text(100,55,'Contra drum peak','Color','r')
    xticks(0:250:1000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis'); 
    set(xax,'TickDirection','out','TickLength',[0.01 0.05])
    title('5{\circ}/s')
    
    subplot(2,2,3); hold on
    histogram(peakIdxsPop(:,3),30,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xline(250,'LineStyle','--','Color','r','LineWidth',1)
    xticks(0:250:1000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis'); 
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    ylabel('Number of events')
    xlabel('Time of peak(ms)')
    title('10{\circ}/s')
    
    subplot(2,2,4); hold on
    histogram(peakIdxsPop(:,4),30,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xline(250,'LineStyle','--','Color','r','LineWidth',1)
    xticks(0:250:1000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis'); 
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    ylabel('Number of events')
    xlabel('Time of peak(ms)')
    title('20{\circ}/s')
elseif condition == 7
    sgtitle('okr')
    subplot(2,2,1); hold on
    histogram(peakIdxsPop(:,1),30,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xline(750,'LineStyle','--','Color','r','LineWidth',1)
    text(300,44,'Ipsi drum peak','Color','r')
    xticks(0:250:1000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis'); 
    set(xax,'TickDirection','out','TickLength',[0.01 0.05])
    ylabel('Number of events')
    title('1{\circ}/s')
    
    subplot(2,2,2); hold on
    histogram(peakIdxsPop(:,2),30,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xline(750,'LineStyle','--','Color','r','LineWidth',1)
    text(100,55,'Contra drum peak','Color','r')
    xticks(0:250:1000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis'); 
    set(xax,'TickDirection','out','TickLength',[0.01 0.05])
    title('5{\circ}/s')
    
    subplot(2,2,3); hold on
    histogram(peakIdxsPop(:,3),30,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xline(750,'LineStyle','--','Color','r','LineWidth',1)
    xticks(0:250:1000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis'); 
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    ylabel('Number of events')
    xlabel('Time of peak(ms)')
    title('10{\circ}/s')
    
    subplot(2,2,4); hold on
    histogram(peakIdxsPop(:,4),30,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xline(750,'LineStyle','--','Color','r','LineWidth',1)
    xticks(0:250:1000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis'); 
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    ylabel('Number of events')
    xlabel('Time of peak(ms)')
    title('20{\circ}/s')
end

%% Plot inter-peak intervals
figure()
if condition == 0 || condition == 4
    sgtitle('x0 acute')
    subplot(2,2,1);hold on
    histogram(ipiPop(:,2),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(0:1000:6000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis');
    set(xax,'TickDirection','out','TickLength',[0.01 0.05])
    ylabel('Number of events')
    %xlabel('Inter-peak interval (ms)')
    title('Vdark')
    subplot(2,2,2); hold on
    histogram(ipiPop(:,1),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(0:1000:6000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis');
    set(xax,'TickDirection','out','TickLength',[0.01 0.05])
    xlabel('Inter-peak interval (ms)')
    ylabel('Number of events')
    title('Visual')
    subplot(2,2,3); hold on
    histogram(ipiPop(:,3),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(0:1000:6000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis');
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    ylabel('Number of events')
    xlabel('Inter-peak interval (ms)')
    title('Spontaneous')
elseif condition == 1 || condition == 5
    sgtitle('x2 acute')
    subplot(2,2,1);hold on
    histogram(ipiPop(:,2),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(0:1000:6000)
    ax = gca;
    xax = ax.XAxis
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    ylabel('Number of events')
    %xlabel('Inter-peak interval (ms)')
    title('Vdark')
    subplot(2,2,2); hold on
    histogram(ipiPop(:,1),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(0:1000:6000)
    ax = gca;
    xax = ax.XAxis;
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    xlabel('Inter-peak interval (ms)')
    ylabel('Number of events')
    title('Visual')
    subplot(2,2,3); hold on
    histogram(ipiPop(:,3),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(0:1000:6000)
    ax = gca;
    xax = ax.XAxis;
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    ylabel('Number of events')
    xlabel('Inter-peak interval (ms)')
    title('Spontaneous')
elseif condition == 2
    sgtitle('okr acute')
    subplot(2,2,1); hold on
    histogram(ipiPop(:,1),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(0:1000:6000)
    ax = gca;
    xax = ax.XAxis;
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    xlabel('Inter-peak interval (ms)')
    ylabel('Number of events')
    title('Visual')
    subplot(2,2,2); hold on
    histogram(ipiPop(:,3),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(0:1000:6000)
    ax = gca;
    xax = ax.XAxis;
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    ylabel('Number of events')
    xlabel('Inter-peak interval (ms)')
    title('Spontaneous')
elseif condition == 6
    sgtitle('vord')
    subplot(2,2,1);hold on
    histogram(ipiPop(:,1),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(0:1000:6000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis');
    set(xax,'TickDirection','out','TickLength',[0.01 0.05])
    ylabel('Number of events')
    %xlabel('Inter-peak interval (ms)')
    title('1{\circ}/s')
    
    subplot(2,2,2); hold on
    histogram(ipiPop(:,2),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(0:1000:6000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis');
    set(xax,'TickDirection','out','TickLength',[0.01 0.05])
    ylabel('Number of events')
    title('5{\circ}/s')
    
    subplot(2,2,3); hold on
    histogram(ipiPop(:,3),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(0:1000:6000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis');
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    ylabel('Number of events')
    xlabel('Inter-peak interval (ms)')
    title('10{\circ}/s')
    
    subplot(2,2,4); hold on
    histogram(ipiPop(:,4),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(0:1000:6000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis');
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    ylabel('Number of events')
    xlabel('Inter-peak interval (ms)')
    title('20{\circ}/s')
elseif condition == 7
    sgtitle('okr')
    subplot(2,2,1);hold on
    histogram(ipiPop(:,1),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(0:1000:6000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis');
    set(xax,'TickDirection','out','TickLength',[0.01 0.05])
    ylabel('Number of events')
    %xlabel('Inter-peak interval (ms)')
    title('1{\circ}/s')
    
    subplot(2,2,2); hold on
    histogram(ipiPop(:,2),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(0:1000:6000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis');
    set(xax,'TickDirection','out','TickLength',[0.01 0.05])
    ylabel('Number of events')
    title('5{\circ}/s')
    
    subplot(2,2,3); hold on
    histogram(ipiPop(:,3),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(0:1000:6000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis');
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    ylabel('Number of events')
    xlabel('Inter-peak interval (ms)')
    title('10{\circ}/s')
    
    subplot(2,2,4); hold on
    histogram(ipiPop(:,4),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(0:1000:6000)
    ax = gca;
    xax = ax.XAxis; % xax = get(ax,'XAxis');
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    ylabel('Number of events')
    xlabel('Inter-peak interval (ms)')
    title('20{\circ}/s')
end

%% Plot calcium event half-widths
figure()
if condition == 0 || condition == 4
    sgtitle('x0 acute')
    subplot(2,2,1);hold on
    histogram(widthPop(:,2),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(100:200:700)
    ax = gca;
    xax = ax.XAxis;
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    ylabel('Number of events')
    title('Vdark')
    subplot(2,2,2); hold on
    histogram(widthPop(:,1),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(100:200:700)
    ax = gca;
    xax = ax.XAxis;
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    xlabel('Half-width (ms)')
    ylabel('Number of events')
    title('Visual')
    subplot(2,2,3); hold on
    histogram(widthPop(:,3),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(100:200:700)
    ax = gca;
    xax = ax.XAxis;
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    ylabel('Number of events')
    title('Spontaneous')
    xlabel('Half-width (ms)')
elseif condition == 1 || condition == 5
    sgtitle('x2 acute')
    subplot(2,2,1);hold on
    histogram(widthPop(:,2),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(100:200:700)
    ax = gca;
    xax = ax.XAxis;
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    ylabel('Number of events')
    title('Vdark')
    subplot(2,2,2); hold on
    histogram(widthPop(:,1),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(100:200:700)
    ax = gca;
    xax = ax.XAxis;
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    xlabel('Half-width (ms)')
    ylabel('Number of events')
    title('Visual')
    subplot(2,2,3); hold on
    histogram(widthPop(:,3),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(100:200:700)
    ax = gca;
    xax = ax.XAxis;
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    ylabel('Number of events')
    title('Spontaneous')
    xlabel('Half-width (ms)')
elseif condition == 2
    sgtitle('okr acute')
    subplot(2,2,1); hold on
    histogram(widthPop(:,1),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(100:200:700)
    ax = gca;
    xax = ax.XAxis;
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    xlabel('Half-width (ms)')
    ylabel('Number of events')
    title('Visual')
    subplot(2,2,2); hold on
    histogram(widthPop(:,3),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(100:200:700)
    ax = gca;
    xax = ax.XAxis;
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    ylabel('Number of events')
    title('Spontaneous')
    xlabel('Half-width (ms)')
elseif condition == 6
    sgtitle('vord')
    subplot(2,2,1);hold on
    histogram(widthPop(:,1),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(100:200:700)
    ax = gca;
    xax = ax.XAxis;
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    ylabel('Number of events')
    title('1{\circ}/s')
    
    subplot(2,2,2); hold on
    histogram(widthPop(:,2),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(100:200:700)
    ax = gca;
    xax = ax.XAxis;
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    xlabel('Half-width (ms)')
    ylabel('Number of events')
    title('5{\circ}/s')
    
    subplot(2,2,3); hold on
    histogram(widthPop(:,3),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(100:200:700)
    ax = gca;
    xax = ax.XAxis;
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    ylabel('Number of events')
    title('10{\circ}/s')
    xlabel('Half-width (ms)')
    
    subplot(2,2,4); hold on
    histogram(widthPop(:,4),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(100:200:700)
    ax = gca;
    xax = ax.XAxis;
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    ylabel('Number of events')
    title('20{\circ}/s')
    xlabel('Half-width (ms)')
elseif condition == 7
    sgtitle('okr')
    subplot(2,2,1);hold on
    histogram(widthPop(:,1),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(100:200:700)
    ax = gca;
    xax = ax.XAxis;
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    ylabel('Number of events')
    title('1{\circ}/s')
    
    subplot(2,2,2); hold on
    histogram(widthPop(:,2),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(100:200:700)
    ax = gca;
    xax = ax.XAxis;
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    xlabel('Half-width (ms)')
    ylabel('Number of events')
    title('5{\circ}/s')
    
    subplot(2,2,3); hold on
    histogram(widthPop(:,3),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(100:200:700)
    ax = gca;
    xax = ax.XAxis;
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    ylabel('Number of events')
    title('10{\circ}/s')
    xlabel('Half-width (ms)')
    
    subplot(2,2,4); hold on
    histogram(widthPop(:,4),60,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    xticks(100:200:700)
    ax = gca;
    xax = ax.XAxis;
    set(xax,'TickDirection','out','TickLength',[0.025 0.05])
    ylabel('Number of events')
    title('20{\circ}/s')
    xlabel('Half-width (ms)')
end

%% Plot calcium traces with events removed
if condition ~= 6 && condition ~= 7
    calEventsRemoved = cat(2,calEventsRemovedReshape{1:numSxs});
    calEventsRemovedAvg = nanmean(calEventsRemoved,2);
    figure(); hold on
    plot(calEventsRemoved*100)
    plot(calEventsRemovedAvg*100,'LineWidth',3,'Color','k')
    xlabel('Time (ms)')
    ylabel('% \DeltaF/G')
    title('Calcium traces with events removed')
end

%% Plot event frequencies
eventFrequencyPop = NaN(numSxs,6);
for i = 1:numSxs
    eventFrequencyPop(i,1:size(eventFrequency{i,1},2)) = cat(2,eventFrequency{i,1});
end
if condition ~= 6 && condition ~= 7
    eventFreqPopAvg = nanmean(eventFrequencyPop,1);
    for i = 1:6
        eventFreqPopSE = nanstd(eventFrequencyPop,0,1)/sqrt(numel(eventFrequencyPop(:,i)));
    end
elseif condition == 6
    a = 1;
    for i = 1:numSxs/4:numSxs
        eventFreqPopAvg(a) = nanmean(eventFrequencyPop(i:i+numSxs/4-1,3));
        eventFreqPopSE(a) = nanstd(eventFrequencyPop(i:i+numSxs/4-1,3),0,1)/sqrt(numel(eventFrequencyPop(i:i+numSxs/4-1,3)));
        a = a+1;
    end
elseif condition == 7
    a = 1;
    for i = 1:numSxs/4:numSxs
        eventFreqPopAvg(a) = nanmean(eventFrequencyPop(i:i+numSxs/4-1,1));
        eventFreqPopSE(a) = nanstd(eventFrequencyPop(i:i+numSxs/4-1,1),0,1)/sqrt(numel(eventFrequencyPop(i:i+numSxs/4-1,1)));
        a = a+1;
    end
end

figure(); hold on
if condition == 0 || condition == 4
    sgtitle('x0 acute')
elseif condition == 1 || condition == 5
    sgtitle('x2 acute')
elseif condition == 2
    sgtitle('okr acute')
elseif condition == 6
    sgtitle('vord')
elseif condition == 7
    sgtitle('okr')
end
if condition ~= 6 && condition ~= 7
    bar([eventFreqPopAvg(1),eventFreqPopAvg(3),eventFreqPopAvg(5)],'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    scatter(ones(size(eventFrequencyPop(:,1))),eventFrequencyPop(:,1),'LineWidth',1)
    scatter(ones(size(eventFrequencyPop(:,3))).*2,eventFrequencyPop(:,3),'LineWidth',1)
    scatter(ones(size(eventFrequencyPop(:,5))).*3,eventFrequencyPop(:,5),'LineWidth',1)
    errorbar([eventFreqPopAvg(1),eventFreqPopAvg(3),eventFreqPopAvg(5)],[eventFreqPopSE(1),eventFreqPopSE(3),eventFreqPopSE(5)],'Color','k','LineStyle','none','LineWidth',2)
    xticks(1:3)
    xticklabels({'Vdark','Visual','Spontaneous'})
    ylabel('Event frequency (Hz)')
elseif condition == 6
    bar(eventFreqPopAvg,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    scatter(ones(size(eventFrequencyPop(1:numSxs/4,1))),eventFrequencyPop(1:numSxs/4,3),'LineWidth',1)
    scatter(ones(size(eventFrequencyPop(numSxs/4+1:numSxs/2,2))).*2,eventFrequencyPop(numSxs/4+1:numSxs/2,3),'LineWidth',1)
    scatter(ones(size(eventFrequencyPop(numSxs/2+1:numSxs-numSxs/4,3))).*3,eventFrequencyPop(numSxs/2+1:numSxs-numSxs/4,3),'LineWidth',1)
    scatter(ones(size(eventFrequencyPop(numSxs-numSxs/4+1:numSxs,4))).*4,eventFrequencyPop(numSxs-numSxs/4+1:numSxs,3),'LineWidth',1)
    errorbar(eventFreqPopAvg,eventFreqPopSE,'Color','k','LineStyle','none','LineWidth',2)
    xticks(1:4)
    xticklabels({'1','5','10','20'})
    xlabel('Turntable peak velocity ({\circ}/s)')
    ylabel('Event frequency (Hz)')
elseif condition == 7
    bar(eventFreqPopAvg,'FaceColor',[0.5 0.5 0.5],'LineWidth',1)
    scatter(ones(size(eventFrequencyPop(1:numSxs/4,1))),eventFrequencyPop(1:numSxs/4,1),'LineWidth',1)
    scatter(ones(size(eventFrequencyPop(numSxs/4+1:numSxs/2,2))).*2,eventFrequencyPop(numSxs/4+1:numSxs/2,1),'LineWidth',1)
    scatter(ones(size(eventFrequencyPop(numSxs/2+1:numSxs-numSxs/4,3))).*3,eventFrequencyPop(numSxs/2+1:numSxs-numSxs/4,1),'LineWidth',1)
    scatter(ones(size(eventFrequencyPop(numSxs-numSxs/4+1:numSxs,4))).*4,eventFrequencyPop(numSxs-numSxs/4+1:numSxs,1),'LineWidth',1)
    errorbar(eventFreqPopAvg,eventFreqPopSE,'Color','k','LineStyle','none','LineWidth',2)
    xticks(1:4)
    xticklabels({'1','5','10','20'})
    xlabel('Turntable peak velocity ({\circ}/s)')
    ylabel('Event frequency (Hz)')
end

%% Next trial effects
if condition ~= 6 & condition ~= 7
    calAmpPriorTrialNew = cat(2,calAmpPriorTrial{1:numSxs});
    calDarkAmpPriorTrialNew = cat(2,calDarkAmpPriorTrial{1:numSxs});
    calLaucPriorTrialNew = cat(2,calLaucPriorTrial{1:numSxs});
    calDaucPriorTrialNew = cat(2,calDaucPriorTrial{1:numSxs});
    calAmpIdxPriorTrialNew = cat(2,calAmpIdxPriorTrial{1:numSxs});
    calDarkAmpIdxPriorTrialNew = cat(2,calDarkAmpIdxPriorTrial{1:numSxs});
    eyeLampNextTrialNew = cat(2,eyeLampNextTrial{1:numSxs});
    eyeDampNextTrialNew = cat(2,eyeDampNextTrial{1:numSxs});
    
    calAmpNormPriorTrialNew = cat(2,calAmpNormPriorTrial{1:numSxs});
    calAucNormPriorTrialNew = cat(2,calAucNormPriorTrial{1:numSxs});
    calDarkAmpNormPriorTrialNew = cat(2,calDarkAmpNormPriorTrial{1:numSxs});
    calDaucNormPriorTrialNew = cat(2,calDaucNormPriorTrial{1:numSxs});
elseif condition == 6
    a = 1; b = 1;
    vecLength = size(calDarkAmpPriorTrial{1}(1,:),2)*numSxs/4;
    calDarkAmpPriorTrialNew = NaN(4,vecLength);
    calDaucPriorTrialNew = NaN(4,vecLength);
    calDarkAmpIdxPriorTrialNew = NaN(4,vecLength);
    eyeDampNextTrialNew = NaN(4,vecLength);
    for i = 1:numSxs/4:numSxs
        calDarkAmpPriorTrialNew(a,:) = cat(2,calDarkAmpPriorTrial{i:i+numSxs/4-1});
        calDaucPriorTrialNew(a,:) = cat(2,calDaucPriorTrial{i:i+numSxs/4-1});
        calDarkAmpIdxPriorTrialNew(a,:) = cat(2,calDarkAmpIdxPriorTrial{i:i+numSxs/4-1});
        eyeDampNextTrialNew(b:b+1,:) = cat(2,eyeDampNextTrial{i:i+numSxs/4-1});
        a = a + 1; b = b + 2;
    end
elseif condition == 7
    a = 1; b = 1;
    vecLength = size(calAmpPriorTrial{1}(1,:),2)*numSxs/4;
    calAmpPriorTrialNew = NaN(4,vecLength);
    calLaucPriorTrialNew = NaN(4,vecLength);
    calAmpIdxPriorTrialNew = NaN(4,vecLength);
    eyeLampNextTrialNew = NaN(4,vecLength);
    for i = 1:numSxs/4:numSxs
        calAmpPriorTrialNew(a,:) = cat(2,calAmpPriorTrial{i:i+numSxs/4-1});
        calLaucPriorTrialNew(a,:) = cat(2,calLaucPriorTrial{i:i+numSxs/4-1});
        calAmpIdxPriorTrialNew(b:b+1,:) = cat(2,calAmpIdxPriorTrial{i:i+numSxs/4-1});
        eyeLampNextTrialNew(b:b+1,:) = cat(2,eyeLampNextTrial{i:i+numSxs/4-1});
        a = a + 1; b = b + 2;
    end
end

% a = 1;
% for i = 1:length(calAmpPriorTrialNew)
%     if eyeLampNextTrialNew(i) < -15
%         removeData(a) = i;
%         eyeLampNextTrialNew(i) = NaN;
%         calLaucPriorTrialNew(i) = NaN;
%         a = a + 1;
%     end
% end
%% Plot next trial effects
if condition ~= 6 && condition ~= 7
    figure('Name','AUC, next trial effect'); hold on
    scatter(abs(eyeLampNextTrialNew(2,:)),calLaucPriorTrialNew)
    [calAucPriorTrialFit,calAucPriorTrialFitR2] = linearFitting(abs(eyeLampNextTrialNew(2,:)),calLaucPriorTrialNew);
    plot(calAucPriorTrialFit)
    text(prctile(abs(eyeLampNextTrialNew(2,:)),50),prctile(calLaucPriorTrialNew,95),['R^2=' num2str(round(calAucPriorTrialFitR2,3))])
    ylabel('AUC')
    xlabel('Eye vel.')
    title('Visual -- next trial effect')
    legend off
    
    figure('Name','Amp, next trial effect'); hold on
    scatter(abs(eyeLampNextTrialNew(2,:)),calAmpPriorTrialNew)
    [calAmpPriorTrialFit,calAmpPriorTrialFitR2] = linearFitting(abs(eyeLampNextTrialNew(2,:)),calAmpPriorTrialNew);
    plot(calAmpPriorTrialFit)
    text(prctile(abs(eyeLampNextTrialNew(2,:)),50),prctile(calAmpPriorTrialNew,95),['R^2=' num2str(round(calAmpPriorTrialFitR2,3))])
    ylabel('Amp')
    xlabel('Eye vel.')
    title('Visual -- next trial effect')
    legend off
    
    figure('Name','AUC (norm), next trial effect'); hold on
    scatter(abs(eyeLampNextTrialNew(2,:)),calAucNormPriorTrialNew)
    [calAucNormPriorTrialFit,calAucNormPriorTrialFitR2] = linearFitting(abs(eyeLampNextTrialNew(2,:)),calAucNormPriorTrialNew);
    plot(calAucNormPriorTrialFit)
    text(prctile(abs(eyeLampNextTrialNew(2,:)),50),prctile(calAucNormPriorTrialNew,95),['R^2=' num2str(round(calAucNormPriorTrialFitR2,3))])
    ylabel('AUC')
    xlabel('Eye vel.')
    title('Visual -- next trial effect')
    legend off
    
    figure('Name','Amp (norm), next trial effect'); hold on
    scatter(abs(eyeLampNextTrialNew(2,:)),calAmpNormPriorTrialNew)
    [calAmpNormPriorTrialFit,calAmpNormPriorTrialFitR2] = linearFitting(abs(eyeLampNextTrialNew(2,:)),calAmpNormPriorTrialNew);
    plot(calAmpNormPriorTrialFit)
    text(prctile(abs(eyeLampNextTrialNew(2,:)),50),prctile(calAmpNormPriorTrialNew,95),['R^2=' num2str(round(calAmpNormPriorTrialFitR2,3))])
    ylabel('Amp')
    xlabel('Eye vel.')
    title('Visual -- next trial effect')
    legend off
    
    figure('Name','AUC, next trial effect'); hold on
    scatter(abs(eyeDampNextTrialNew(1,:)),calDaucPriorTrialNew)
    [calDaucPriorTrialFit,calDaucPriorTrialFitR2] = linearFitting(abs(eyeDampNextTrialNew(1,:)),calDaucPriorTrialNew);
    plot(calDaucPriorTrialFit)
    text(prctile(abs(eyeDampNextTrialNew(1,:)),50),prctile(calDaucPriorTrialNew,95),['R^2=' num2str(round(calDaucPriorTrialFitR2,3))])
    ylabel('AUC')
    xlabel('Eye vel.')
    title('Vdark -- next trial effect')
    legend off
    
    figure('Name','Amp, next trial effect'); hold on
    scatter(abs(eyeDampNextTrialNew(1,:)),calDarkAmpPriorTrialNew)
    [calDarkAmpPriorTrialFit,calDarkAmpPriorTrialFitR2] = linearFitting(abs(eyeDampNextTrialNew(1,:)),calDarkAmpPriorTrialNew);
    plot(calDarkAmpPriorTrialFit)
    text(prctile(abs(eyeDampNextTrialNew(1,:)),50),prctile(calDarkAmpPriorTrialNew,95),['R^2=' num2str(round(calDarkAmpPriorTrialFitR2,3))])
    ylabel('Amp')
    xlabel('Eye vel.')
    title('Vdark -- next trial effect')
    legend off
    
    figure('Name','AUC, next trial effect'); hold on
    scatter(abs(eyeDampNextTrialNew(1,:)),calDaucNormPriorTrialNew)
    [calDaucNormPriorTrialFit,calDaucNormPriorTrialFitR2] = linearFitting(abs(eyeDampNextTrialNew(1,:)),calDaucNormPriorTrialNew);
    plot(calDaucNormPriorTrialFit)
    text(prctile(abs(eyeDampNextTrialNew(1,:)),50),prctile(calDaucNormPriorTrialNew,95),['R^2=' num2str(round(calDaucNormPriorTrialFitR2,3))])
    ylabel('AUC')
    xlabel('Eye vel.')
    title('Vdark -- next trial effect')
    legend off
    
    figure('Name','Amp, next trial effect'); hold on
    scatter(abs(eyeDampNextTrialNew(1,:)),calDarkAmpNormPriorTrialNew)
    [calDarkAmpNormPriorTrialFit,calDarkAmpNormPriorTrialFitR2] = linearFitting(abs(eyeDampNextTrialNew(1,:)),calDarkAmpNormPriorTrialNew);
    plot(calDarkAmpNormPriorTrialFit)
    text(prctile(abs(eyeDampNextTrialNew(1,:)),50),prctile(calDarkAmpNormPriorTrialNew,95),['R^2=' num2str(round(calDarkAmpNormPriorTrialFitR2,3))])
    ylabel('Amp')
    xlabel('Eye vel.')
    title('Vdark -- next trial effect')
    legend off
elseif condition == 6
    figure('Name','AUC next trial effect')
    sgtitle('vord - next trial effect')
    subplot(2,2,1); hold on
    scatter(abs(eyeDampNextTrialNew(1,:)),calDaucPriorTrialNew(1,:))
    ylabel('AUC')
    title('1{\circ}')
    legend off
    
    subplot(2,2,2); hold on
    scatter(abs(eyeDampNextTrialNew(3,:)),calDaucPriorTrialNew(2,:))
    title('5{\circ}')
    legend off
    
    subplot(2,2,3); hold on
    scatter(abs(eyeDampNextTrialNew(5,:)),calDaucPriorTrialNew(3,:))
    xlabel('Eye vel.')
    ylabel('AUC')
    title('10{\circ}')
    legend off
    
    subplot(2,2,4); hold on
    scatter(abs(eyeDampNextTrialNew(7,:)),calDaucPriorTrialNew(4,:))
    xlabel('Eye vel.')
    title('20{\circ}')
    legend off
elseif condition == 7
    figure('Name','AUC next trial effect')
    sgtitle('vord - next trial effect')
    subplot(2,2,1); hold on
    scatter(abs(eyeLampNextTrialNew(2,:)),calLaucPriorTrialNew(1,:))
    ylabel('AUC')
    title('1{\circ}')
    legend off
    
    subplot(2,2,2); hold on
    scatter(abs(eyeLampNextTrialNew(4,:)),calLaucPriorTrialNew(2,:))
    title('5{\circ}')
    legend off
    
    subplot(2,2,3); hold on
    scatter(abs(eyeLampNextTrialNew(6,:)),calLaucPriorTrialNew(3,:))
    xlabel('Eye vel.')
    ylabel('AUC')
    title('10{\circ}')
    legend off
    
    subplot(2,2,4); hold on
    scatter(abs(eyeLampNextTrialNew(8,:)),calLaucPriorTrialNew(4,:))
    xlabel('Eye vel.')
    title('20{\circ}')
    legend off
end

%% plot calcium responses for individual subjects
figure(); hold on
for i = 1:length(calAmpPriorTrial)
    scatter(abs(eyeLampNextTrial{i}(2,:)),calAmpPriorTrial{i})
end

