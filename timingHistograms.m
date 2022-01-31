%timing histograms!
figure(1); hold on
xlim([0 1200]);
histogram(cal_peak_idxs,10,'FaceColor','g','BinWidth',50);
title('Distribution of fluorescence peaks');
xlabel('Time of fluorescence peaks');
ylabel('Number of events');

figure(2); hold on
xlim([0 1200]);
histogram(calD_peak_idxs,10,'FaceColor','g','BinWidth',50);
title('Distribution of fluorescence peaks during vestibular-dark');
xlabel('Time of fluorescence peaks');
ylabel('Number of events');

figure(3); hold on
xlim([0 1000]);
histogram(rs_peak_idxs,10,'FaceColor','m','BinWidth',50);
title('Distribution of retinal slip peaks');
xlabel('Time of retinal slip peaks');
ylabel('Number of events');

figure(4); hold on
xlim([0 1000]);
histogram(eyeL_peak_idxs,10,'FaceColor','r','BinWidth',50);
title('Distribution of eye velocity peaks');
xlabel('Time of eye velocity peaks');
ylabel('Number of events');

figure(5); hold on
xlim([0 1000]);
histogram(eyeD_peak_idxs,10,'FaceColor','r','BinWidth',50);
title('Distribution of eye velocity peaks in the dark');
xlabel('Time of eye velocity peaks');
ylabel('Number of events');

figure(6); hold on
xlim([0 1000]);
histogram(headvel_peak_idxs,10,'FaceColor','b','BinWidth',50);
title('Distribution of head velocity peaks');
xlabel('Time of head velocity peaks');
ylabel('Number of events');

figure(7); hold on
xlim([0 1000]);
histogram(headvelD_peak_idxs,10,'FaceColor','b','BinWidth',50);
title('Distribution of head velocity peaks during vestibular-dark');
xlabel('Time of head velocity peaks');
ylabel('Number of events');

figure(8); hold on
histogram(calRSidxs,10,'FaceColor','m','BinWidth',50);
title('Timing delay of fluorescence re retinal slip');
xlabel('Time of peak fluorescence re retina slip');
ylabel('Number of events');

figure(9); hold on
histogram(calEyeLidxs,10,'FaceColor','r','BinWidth',50);
title('Timing delay of fluorescence re eye velocity');
xlabel('Time of peak fluorescence re eye velocity');
ylabel('Number of events');

figure(10); hold on
histogram(calEyeDidxs,10,'FaceColor','r','BinWidth',50);
title('Timing delay of fluorescence re eye velocity in the dark');
xlabel('Time of peak fluorescence re eye velocity in dark');
ylabel('Number of events');

figure(11); hold on
histogram(calHeadvelIdxs,10,'FaceColor','k','BinWidth',50);
title('Timing delay of fluorescence re head velocity');
xlabel('Time of head velocity peaks');
ylabel('Number of events');

figure(12); hold on
histogram(calHeadvelDidxs,10,'FaceColor','k','BinWidth',50);
title('Timing delay of fluorescence re head velocity in dark');
xlabel('Time of head velocity peaks');
ylabel('Number of events');