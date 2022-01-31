function [omitH, omitCenters, eye_pos_filt, eye_vel_pfilt] = desacVel(eyeTrace, fr, presac, postsac, frequency, saccadeThresh, fit1)
% lowpassCutoff = 15
% LOW PASS ON POSITION
N = 4;
% fc = lowpassCutoff;
fc = 15;
% nq = samplerate / 2;
[bb,aa] = butter(N, fc/fr, 'low');
% [bb,aa] = butter(N, fc/nq, 'low');
eye_pos_filt = filtfilt(bb,aa,eyeTrace);

% CALC VEL - use Hannah's calulation method, not the 'diff()' function.
veltau = .01;
%eye_vel_pfilt = movingslopeCausal(eyeP5,round(samplerate*veltau))*samplerate;
eye_vel_pfilt = smooth([diff(smooth(eye_pos_filt,50)); 0],50)*fr;
eye_vel_praw = movingslopeCausal(eye_pos_filt,round(fr*veltau))*fr;

% filter_window = 50;
% eye_vel_pfilt = movingslope(eye_pos_filt,filter_window) * samplerate;
% eye_vel_praw = movingslope(eyeP5, filter_window) * samplerate;

%% REMOVE EXPMT FREQ
option = 2;

N = 6;
fc = frequency+7;
[bb,aa] = butter(N, fc/fr, 'high');
try
    eye_vel_pfilt2 = filtfilt(bb,aa,eye_vel_pfilt);
catch
    eye_vel_pfilt2 = filter(bb,aa,eye_vel_pfilt);
    print('FAIL')
end
    
eye_vel_mse = (eye_vel_pfilt - fit1).^2;


% OPTION 1 - USE HIGH PASS
if option == 1
    omitCenters = abs(eye_vel_pfilt2) > saccadeThresh;
% OPTION 2 - USE MSE OF 'FIT'
elseif option == 2
    omitCenters = eye_vel_mse > saccadeThresh;
end

%%
% remove points around omit centers as defined by pre & post saccade time
sacmask = ones(1,presac+postsac);

% filter function replaces zeros with ones (equal to remove time) around an omit center
rejecttemp1 = conv2(double(omitCenters'),sacmask);
rejecttemp2 = rejecttemp1(presac:presac+length(eyeTrace)-1);

% eyevel with desaccade segments removed
eyevelOut = eye_pos_filt;
eyevelOut(logical(rejecttemp2))= NaN;
omitH = isnan(eyevelOut);

accel = 0;
if accel

    eye_acc_pfilt = movingslopeCausal(eye_vel_pfilt,round(fr*veltau))*fr;
    eye_acc_praw = movingslopeCausal(eye_vel_praw,round(fr*veltau))*fr;

    % Calculations
    accelThresh = 500;
    omitCenters = abs(eye_acc_pfilt) > accelThresh;
    rejecttemp1 = conv(double(omitCenters),sacmask);
    rejecttemp2 = rejecttemp1(presac:presac+length(eyeTrace)-2);
    eyevelOut = eye_pos_filt;
    eyevelOut(logical(rejecttemp2))= NaN;
    omitH = isnan(eyevelOut);
end
    
%% FOR TESTING, DEBUGGING, AND TWEAKING DESACCADE %%%%%%%%%%%%%%%%%%%%%%%%
if 0 
    % find start and end times of sacs
    sac_start = strfind(omitH', [0 1]);
    sac_end = strfind(omitH', [1 0]);
    
    if ~isempty(sac_end) && isempty(sac_start)
        sac_start = 1;
        
    elseif isempty(sac_end) && ~isempty(sac_start)
        sac_end = length(omitH);
        
    elseif ~isempty(sac_end) && ~isempty(sac_start)
        if sac_end(1) < sac_start(1)
            sac_start = [1 sac_start];
        end

        if sac_end(end) < sac_start(end)
            sac_end = [sac_end length(omitH)];
        end
    end
    
    x = [sac_start; sac_end; sac_end; sac_start];
    y = [-20000;-20000;20000;20000];
    y = repmat(y,[1 size(x, 2)]);
    
    if isempty(sac_end) && isempty(sac_start)
        x = [];
        y = [];
    end
    
    
    %% Plot Basic Visuals
    figure();
    
    ha = tight_subplot(3,1,[.01 .02],[.1 .01],[.01 .01]);

    axes(ha(1))
    plot(eyeP5, 'r')
    hold on
    plot(eye_pos_filt, 'k', 'LineWidth', 1.5)    
    title('Position')
    PrevYlim = ylim;
    patch(x, y, 'k', 'FaceAlpha',.1, 'LineStyle', 'none');
    ylim(PrevYlim);
    xlim([0 length(eye_vel_pfilt)])
    hold off
    
    if accel
        % Plot
        axes(ha(2))
        plot(eye_acc_praw, 'r')
        hold on
        plot(eye_acc_pfilt, 'k', 'LineWidth', 1.5)
        title('Accel')
        ylim([-15000 15000])
        patch(x, y, 'k', 'FaceAlpha',.5, 'LineStyle', 'none');
        xlim([0 length(eye_vel_pfilt)])
        hold off
        
        axes(ha(3))
        plot(abs(eye_acc_pfilt), 'k', 'LineWidth', 1.5)
        hline(450, 'b')
        patch(x, y.*100, 'k', 'FaceAlpha',.1, 'LineStyle', 'none');
        ylim([0 2500])
        xlim([0 length(eye_vel_pfilt)])
        
       
    else
        axes(ha(2))
        plot(eye_vel_praw, 'r')
        hold on
        plot(eye_vel_pfilt, 'k', 'LineWidth', 1.5)
        title('Velocity')
        patch(x, y, 'k', 'FaceAlpha',.1, 'LineStyle', 'none');
        ylim([-200 200])
        xlim([0 length(eye_vel_pfilt)])
        hold off
        
        axes(ha(3))
        plot((eye_vel_pfilt - fit1).^2, 'k', 'LineWidth', 1.5)
        hline(saccadeThresh, 'b')
        patch(x, y.*100, 'k', 'FaceAlpha',.1, 'LineStyle', 'none');
        ylim([0 10000])
        xlim([0 length(eye_vel_pfilt)])
    end
    

    %% Plot frequency spectrum as check on experiment freq
    do_100 = 0 ;
    if do_100
        figure(100)
        L = length(eye_vel_pfilt);
        Y = fft(eye_vel_pfilt);
        P2 = abs(Y/L);
        P1 = P2(1:L/2+1);
        P1(2:end-1) = 2*P1(2:end-1);
        f = fr*(0:(L/2))/L;
        plot(f,P1) 
        title(num2str(frequency))
    end

    %% Plot raw and filtered w/ desaccaded
    do_101 = 0;
    if do_101

        figure(101)
        ha = tight_subplot(4,1,[.01 .03],[.1 .01],[.01 .01]);


        axes(ha(1))
        plot(eyeP5)
        hold on
        eye_pos_des = eyeP5;
        eye_pos_des(omitH) = NaN;
        plot(eye_pos_des)
        preLim = ylim;
        patch(x, y, 'k', 'FaceAlpha',.1, 'LineStyle', 'none');
        ylim(preLim)
        hold off
        title('Raw Pos')

        axes(ha(2))
        plot(eye_pos_filt);
        hold on
        eye_pos_filt_des = eye_pos_filt;
        eye_pos_filt_des(omitH) = NaN;
        plot(eye_pos_filt_des)
        preLim = ylim;
        patch(x, y, 'k', 'FaceAlpha',.1, 'LineStyle', 'none');
        ylim(preLim)
        hold off
        title('Filtered Pos')

        axes(ha(3))
        plot(eye_vel_praw)
        hold on
        eye_vel_praw(omitH) = NaN;
        plot(eye_vel_praw)
        preLim = ylim;
        patch(x, y, 'k', 'FaceAlpha',.1, 'LineStyle', 'none');
        ylim(preLim)
        hold off
        title('Raw Vel')

        axes(ha(4))
        filtP_eye_vel = diff(eye_pos_filt);
        plot(filtP_eye_vel);
        hold on
        filtP_eye_vel(omitH) = NaN;
        plot(filtP_eye_vel)
        preLim = ylim;
        patch(x, y, 'k', 'FaceAlpha',.1, 'LineStyle', 'none');
        ylim(preLim)
        hold off
        title('Filtered Vel')
    end
    
    %% Plot Different ways of getting Vel
    do_102 = 0;
    if do_102
        lw = 1;
        eye_vel01_praw = eye_vel_praw;
        veltau = .02;
        eye_vel02_praw = movingslopeCausal(eyeP5,round(fr*veltau))*fr;
        veltau = .03;
        eye_vel03_praw = movingslopeCausal(eyeP5,round(fr*veltau))*fr;
        veltau = .04;
        eye_vel04_praw = movingslopeCausal(eyeP5,round(fr*veltau))*fr;
        veltau = .05;
        eye_vel05_praw = movingslopeCausal(eyeP5,round(fr*veltau))*fr;
        
        A = figure(102);clf
        ha = tight_subplot(6,1,[.01 .03],[.1 .01],[.04 .01]);
        
        axes(ha(1))
        plot(eye_vel_praw, 'k'); hold on
        grid on
         
        axes(ha(2))
        plot(eye_vel_praw, 'k'); hold on
        plot(eye_vel02_praw, 'r', 'LineWidth', lw)
        grid on
        
        axes(ha(3))
        plot(eye_vel_praw, 'k'); hold on
        plot(eye_vel03_praw, 'r', 'LineWidth', lw)
        grid on
        
        axes(ha(4))
        plot(eye_vel_praw, 'k'); hold on
        plot(eye_vel04_praw, 'r', 'LineWidth', lw)
        grid on 
        
        axes(ha(5))
        plot(eye_vel_praw, 'k'); hold on
        plot(eye_vel05_praw, 'r', 'LineWidth', lw)
        grid on 
        
        axes(ha(6))
        plot(eye_vel_praw, 'k'); hold on
        plot(eye_vel_pfilt, 'r', 'LineWidth', lw)
        grid on 
        
        linkaxes(ha)
        A.Color = 'w';
    end
    
      
    %disp('a')
end
end