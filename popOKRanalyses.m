

calPopAvg = NaN(1000,numExpts);
for i = 1:numExpts
    calPopAvg(:,i) = mean(cat(2,calVisualAvg{i,:}),2);
end
figure(); hold on
plot(calPopAvg)

figure(); hold on
for i = 1:numExpts
    subplot(4,1,i); hold on
    plot(cat(2,calVisualAvg{i,:}))
end


eyePopAvg = NaN(1000,numExpts);
for i = 1:numExpts
    eyePopAvg(:,i) = mean(cat(2,eyeVisualAvg{i,:}),2);
end
figure(); hold on
plot(eyePopAvg)

figure(); hold on
for i = 1:numExpts
    subplot(4,1,i); hold on
    plot(cat(2,eyeVisualAvg{i,:}))
end

%% cycle averaged vestibular-dark calcium trace
% calDavgReshape1 = reshape(calDavg1,1000,3);
% calDavgReshape1 = nanmean(calDavgReshape1(:,1:2),2);
% calciumAvgReshape1 = reshape(calciumAvg1,1000,3);
% 
% %average across experiments
% calDsinePeak1 = mean(calDsinePeak1(1:2));
% calDsinePeak1 = 2*calDsinePeak1;
% calSinePeak1 = 2*calSinePeak1;
% 
% calDsineBlockAvg1 = [calDsineBlockAvg1{1:end}];
% calDconcatBlockAvg1 = cell(1,1);
% calDconcatBlockAvg1{1} = max(nanmean(calDsineBlockAvg1(:,1:2),2));
% calDconcatBlockAvg1{2} = max(nanmean(calDsineBlockAvg1(:,3:4),2));
% calDconcatBlockAvg1{3} = max(nanmean(calDsineBlockAvg1(:,5:6),2));
% calDconcatBlockAvg1{4} = max(nanmean(calDsineBlockAvg1(:,7:8),2));
% calDconcatBlockAvg1{5} = max(nanmean(calDsineBlockAvg1(:,9:10),2));
% calDconcatBlockAvg1{6} = max(nanmean(calDsineBlockAvg1(:,11:12),2));
% calDconcatBlockAvg1{7} = max(nanmean(calDsineBlockAvg1(:,13:14),2));
% calDconcatBlockAvg1{8} = max(nanmean(calDsineBlockAvg1(:,15:16),2));
% calDconcatBlockAvg1{9} = max(nanmean(calDsineBlockAvg1(:,17:18),2));
% calDconcatBlockAvg1{10} = max(nanmean(calDsineBlockAvg1(:,19:20),2));
% calDconcatBlockAvg1{11} = max(nanmean(calDsineBlockAvg1(:,21:22),2));
% calDconcatBlockAvg1{12} = max(nanmean(calDsineBlockAvg1(:,23:24),2));
% calDconcatBlock1 = cat(1,calDconcatBlockAvg1{1:12});