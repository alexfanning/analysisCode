%% Single trial analyses relating fluorescence to retinal slip, eye velocity, and head velocity
%Need to import desaccadeF workspace data and eyeTracesAcute workspace data to begin

%add NaN values for spontaneous matrix to create equal matrices for comparison 

%set test condition (x0 == 0, x2 and OKR == 1)
test = 1

%% define variables

calcium_nosaccade = calcium'
calcium_darkNoSaccade = calD'
calcium_spNoSaccade = calSp'

%% define calcium events where saccades exist and set threshold for calcium events

% Setting the threshold for calcium event based on percentile/stdev
calcium_stdev = std(df);
event_thresh = prctile(df,30) + (calcium_stdev/2);

% Uncomment below to plot the desaccaded calcium data with threshold line
figure(1);
plot(calcium_nosaccade,'color','b');
hold on
plot(calcium_darkNoSaccade,'color','r');
plot(calcium_spNoSaccade,'color','g');
yline(event_thresh);

% Reshape data into 1-second cycles (columns)
ca_ns_chunks = reshape(calcium_nosaccade,1000,108);
caD_ns_chunks = reshape(calcium_darkNoSaccade,1000,108);
caSp_ns_chunks = reshape(calcium_spNoSaccade,1000,108);
headvel_chunks = reshape(headvel,1000,108);
headvelD_chunks = reshape(headvelD,1000,108);
rs_chunks = reshape(rs,1000,108);
rsSp_chunks = reshape(rsSp,1000,108);
ds_chunks = reshape(desaccade,1000,108);
dsD_chunks = reshape(desaccadeD,1000,108);
dsSp_chunks = reshape(desaccadeSp,1000,108);
eyeL_chunks = reshape(eyeL,1000,108);
eyeD_chunks = reshape(eyeD,1000,108);
eyeSp_chunks = reshape(eyeSp,1000,108);

% Create Vectors of size 120 (number of cycles)
% to store difference data
rs_peak_diffs = NaN(1,108);
rsSp_peak_diffs = NaN(1,108);
headvel_peak_diffs = NaN(1,108);
headvelD_peak_diffs = NaN(1,108);
eyeL_peak_diffs = NaN(1,108);
eyeD_peak_diffs = NaN(1,108);
eyeSp_peak_diffs = NaN(1,108);

cal_peak_amps = NaN(1,108);
calNorm = NaN(1,108);
calD_peak_amps = NaN(1,108);
calNormD = NaN(1,108);
calSp_peak_amps = NaN(1,108);
rs_peak_amps = NaN(1,108);
rsSp_peak_amps = NaN(1,108);
headvel_peak_amps = NaN(1,108);
headvelD_peak_amps = NaN(1,108);
eyeL_peak_amps = NaN(1,108);
eyeD_peak_amps = NaN(1,108);
eyeSp_peak_amps = NaN(1,108);

cal_peak_idxs = NaN(1,108);
calD_peak_idxs = NaN(1,108);
calSp_peak_idxs = NaN(1,108);
rs_peak_idxs = NaN(1,108);
rsSp_peak_idxs = NaN(1,108);
headvel_peak_idxs = NaN(1,108);
headvelD_peak_idxs = NaN(1,108);
eyeL_peak_idxs = NaN(1,108);
eyeD_peak_idxs = NaN(1,108);
eyeSp_peak_idxs = NaN(1,108);

    for i = 1:108
    %Isolate individual column/cycle
    %for each type of data 
        cal_cycle =  ca_ns_chunks(:,i);
        calD_cycle = caD_ns_chunks(:,i);
        calSp_cycle = caSp_ns_chunks(:,i);
        ds_cycle = ds_chunks(:,i);
        dsD_cycle = dsD_chunks(:,i);
        dsSp_cycle = dsSp_chunks(:,i);
        rs_cycle = rs_chunks(1:650,i);
        rsSp_cycle = rsSp_chunks(:,i);
        headvel_cycle = headvel_chunks(:,i);
        headvelD_cycle = headvelD_chunks(:,i);
        eyeL_cycle = eyeL_chunks(:,i);
        eyeD_cycle = eyeD_chunks(:,i);
        eyeSp_cycle = eyeSp_chunks(:,i);
    
        % Take max or min value for velocities and calcium
        [max_cal, max_cal_idx] = max(cal_cycle);
        cal_peak_idxs(i) = max_cal_idx;
        [min_rs, min_rs_idx] = min(rs_cycle);
        rs_peak_idxs(i) = min_rs_idx;
        [max_headvel, max_headvel_idx] = max(headvel_cycle);
        headvel_peak_idxs(i) = max_headvel_idx;
        [max_eyeL, max_eyeL_idx] = max(eyeL_cycle);
        eyeL_peak_idxs(i) = max_eyeL_idx;
 
        % Populate vectors, divide by sampling rate to convert to time
        cal_peak_amps(i) = max_cal;
        rs_peak_amps(i) = min_rs;
        headvel_peak_amps(i) = max_headvel;
        eyeL_peak_amps(i) = max_eyeL;
            
        %average time before pruning
        rsCalTime = nanmean(rs_peak_diffs);
        eyeCalTime = nanmean(eyeL_peak_diffs);
        headCalTime = nanmean(headvel_peak_diffs);
            
        %average amplitude before pruning
        cal = nanmean(cal_peak_amps);
        rsCal = nanmean(rs_peak_amps);
        eyeCal = nanmean(eyeL_peak_amps);
        headCal = nanmean(headvel_peak_amps);
        
        %calculate time difference between calcium peak and velocity peak
        rs_peak_diffs = (cal_peak_idxs - rs_peak_idxs)*1/1000;
        headvel_peak_diffs = (cal_peak_idxs - headvel_peak_idxs)*1/1000;
        eyeL_peak_diffs = (cal_peak_idxs - eyeL_peak_idxs)*1/1000;
        
        %narrow the relevant window for analysis
%         rs_peak_diffs(rs_peak_diffs < 0) = NaN;
%         rs_peak_diffs(rs_peak_diffs > 0.3) = NaN;
%         headvel_peak_diffs(headvel_peak_diffs < 0) = NaN;
%         headvel_peak_diffs(headvel_peak_diffs > 0.3) = NaN;
%         eyeL_peak_diffs(eyeL_peak_diffs < 0) = NaN;
%         eyeL_peak_diffs(eyeL_peak_diffs > 0.3) = NaN;
%         rs_peak_amps(rs_peak_amps > 0) = NaN;
%         headvel_peak_amps(headvel_peak_amps < 0) = NaN;
%         eyeL_peak_amps(eyeL_peak_amps > 0) = NaN;
% 
%         rs_peak_amps(rs_peak_amps > 0) = NaN;
%         headvel_peak_amps(headvel_peak_amps > 0) = NaN;
%         eyeL_peak_amps(eyeL_peak_amps < 0) = NaN;
% 
%         rsX = find(rs_peak_diffs > 0);
%         headX = find(headvel_peak_diffs > 0);
%         eyeX = find(eyeL_peak_diffs > 0);
%         
          %calculate amplitude and differences after removing values
          %outside of narrow window specified above
%         [calPeakAmps] = cal_peak_amps(rsX);
%         [rsPeakAmps] = rs_peak_amps(rsX);
%         [rsPeakDiffs] = rs_peak_diffs(rsX);
%         [headvelPeakAmps] = headvel_peak_amps(headX);
%         [headvelPeakDiffs] = headvel_peak_diffs(headX);
%         [calPeakAmpsH] = cal_peak_amps(headX);
%         [eyeLpeakAmps] = eyeL_peak_amps(eyeX);
%         [eyeLpeakDiffs] = eyeL_peak_diffs(eyeX);
%         [calPeakAmpsE] = cal_peak_amps(eyeX);

        %set values with no saccade to NaN
        eyeL_peak_idxs(eyeL_peak_idxs == 1) = NaN;
        cal_peak_idxs(cal_peak_idxs == 1) = NaN;
         
            % Take max or min value of velocities and calcium for stimulation in the dark
        [max_calD, max_calD_idx] = max(calD_cycle);
        calD_peak_idxs(i) = max_calD_idx;
        [max_headvelD, max_headvelD_idx] = min(headvelD_cycle);
        headvelD_peak_idxs(i) = max_headvelD_idx;
        [max_eyeD, max_eyeD_idx] = max(eyeD_cycle);
        eyeD_peak_idxs(i) = max_eyeD_idx;
 
        % Populate vectors, dividing by sampling rate to convert to time
        calD_peak_amps(i) = max_calD;
        headvelD_peak_amps(i) = max_headvelD;
        eyeD_peak_amps(i) = max_eyeD;
            
        %average amplitude and velocity before pruning
        eyeDcalTime = nanmean(eyeD_peak_diffs);
        headDcalTime = nanmean(headvelD_peak_diffs);
            
        calDavg = nanmean(calD_peak_amps);
        eyeDcal = nanmean(eyeD_peak_amps);
        headDcal = nanmean(headvelD_peak_amps);
        
        %calculate time difference between calcium and eye peaks
        headvelD_peak_diffs = (calD_peak_idxs - headvelD_peak_idxs)*1/1000;
        eyeD_peak_diffs = (calD_peak_idxs - eyeD_peak_idxs)*1/1000;
            
%         headvelD_peak_diffs(headvelD_peak_diffs < 0) = NaN;
%         headvelD_peak_diffs(headvelD_peak_diffs > 0.3) = NaN;
%         eyeD_peak_diffs(eyeD_peak_diffs < 0) = NaN;
%         eyeD_peak_diffs(eyeD_peak_diffs > 0.3) = NaN;
%             
%         headvelD_peak_amps(headvelD_peak_amps > 0) = NaN;
%         eyeD_peak_amps(eyeD_peak_amps < 0) = NaN;
%             
%         headDX = find(headvelD_peak_diffs > 0);
%         eyeDX = find(eyeD_peak_diffs > 0);
%             
%         [headvelDpeakAmps] = headvelD_peak_amps(headDX);
%         [headvelDpeakDiffs] = headvelD_peak_diffs(headDX);
%         [calPeakAmpsHD] = calD_peak_amps(headDX);
%         [eyeDpeakAmps] = eyeD_peak_amps(eyeDX);
%         [eyeDpeakDiffs] = eyeD_peak_diffs(eyeDX);
%         [calPeakAmpsED] = cal_peak_amps(eyeDX);

        eyeD_peak_idxs(eyeD_peak_idxs == 1) = NaN;
        calD_peak_idxs(calD_peak_idxs == 1) = NaN;

        % Take max or min value for velocities and calcium
        [max_calSp, max_calSp_idx] = max(calSp_cycle);
        calSp_peak_idxs(i) = max_calSp_idx;
        [min_rsSp, min_rsSp_idx] = min(rsSp_cycle);
        rsSp_peak_idxs(i) = min_rsSp_idx;
        [max_eyeSp, max_eyeSp_idx] = max(eyeSp_cycle);
        eyeSp_peak_idxs(i) = max_eyeSp_idx;
 
        % Populate vectors, divide by sampling rate to convert to time
        calSp_peak_amps(i) = max_calSp;
        rsSp_peak_amps(i) = min_rsSp;
        eyeSp_peak_amps(i) = max_eyeSp;
            
        %average time and amplitude before pruning
        rsSpCalTime = nanmean(rsSp_peak_diffs);
        eyeSpCalTime = nanmean(eyeSp_peak_diffs);
            
        calSpAvg = nanmean(calSp_peak_amps);
        rsCalSpAvg = nanmean(rsSp_peak_amps);
        eyeCalSpAvg = nanmean(eyeSp_peak_amps);
        
        %calculate time difference between calcium and velocity
        rsSp_peak_diffs = (calSp_peak_idxs - rsSp_peak_idxs)*1/1000;
        eyeSp_peak_diffs = (calSp_peak_idxs - eyeSp_peak_idxs)*1/1000;
            
%             rsSp_peak_diffs(rsSp_peak_diffs < 0) = NaN;
%             rsSp_peak_diffs(rsSp_peak_diffs > 0.3) = NaN;
%             eyeLsp_peak_diffs(eyeLsp_peak_diffs < 0) = NaN;
%             eyeLsp_peak_diffs(eyeLsp_peak_diffs > 0.3) = NaN;
%             
%             rsSp_peak_amps(rsSp_peak_amps > 0) = NaN;
%             eyeLsp_peak_amps(eyeLsp_peak_amps < 0) = NaN;
%             
%             rsXsp = find(rsSp_peak_diffs > 0);
%             eyeXsp = find(eyeLsp_peak_diffs > 0);
%             
%             [calSpPeakAmps] = calSp_peak_amps(rsXsp);
%             [rsSpPeakAmps] = rsSp_peak_amps(rsXsp);
%             [rsSpPeakDiffs] = rsSp_peak_diffs(rsXsp);
%             [eyeLspPeakAmps] = eyeLsp_peak_amps(eyeXsp);
%             [eyeLspPeakDiffs] = eyeLsp_peak_diffs(eyeXsp);
%             [calSpPeakAmpsE] = calSp_peak_amps(eyeXsp);

        eyeSp_peak_idxs(eyeSp_peak_idxs == 1) = NaN;
        calSp_peak_idxs(calSp_peak_idxs == 1) = NaN;
    end
    