function [omitH, omitCenters, eye_pos_filt, eye_vel_pfilt, eyeVelRaw, saccadeThresh] = desaccading(fr,eyeTrace,saccadeThresh,presac,postsac,frequency,drDiff,chV)
%% PARAMETERS
segLength = length(eyeTrace);
segTime = (1:segLength)/fr;
eyeVelRaw = smooth([diff(smooth(eyeTrace,50)); 0],50)*fr;

%% REMOVE OBVIOUS SACCADES/ARTIFACTS
y1 = sin(2*pi*frequency*segTime(:));
y2 = cos(2*pi*frequency*segTime(:));
constant = ones(segLength,1);
vars = [y1 y2 constant];
keep = abs(eyeVelRaw) < 5*std(abs(eyeVelRaw)) + mean(abs(eyeVelRaw));
b = regress(eyeVelRaw(keep),vars(keep,:));
fit1 = vars*b;

%% DESACCADE
[omitH, omitCenters, eye_pos_filt, eye_vel_pfilt] = desacVel(double(eyeTrace), fr, presac, postsac, frequency, saccadeThresh, fit1);
eye_vel_pfilt(omitH) = nan;
eye_vel_mse = (eyeVelRaw - fit1).^2;

figure('Name','Linear regression desaccading'); hold on
ax1 = subplot(2,1,1);
plot(eyeVelRaw); hold on
plot(eye_vel_pfilt)
plot(omitH)
plot(drDiff)
plot(chV)
ylim([-50 50])
legend('Raw eye vel','Desaccaded eye vel','Desaccade timepts','Drum vel.','Turntable vel.')
ylabel('Eye velocity')
ax2 = subplot(2,1,2);
plot(eye_vel_mse,'k')
yline(saccadeThresh,'r')                 
xlabel('Time (ms)')
legend('Eye vel MSE','threshold')
linkaxes([ax1 ax2],'x')
set(ax1,'ylim',[-50 50])
set(ax2,'ylim',[0 500])
