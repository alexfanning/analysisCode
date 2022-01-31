function sampRateChange = upsampDownsamp(data1,data2scale2)

var2scale2 = data2scale2;
var2scale = data1;
scale = (length(var2scale2)/length(var2scale));
x = [1 scale*(2:length(var2scale))];
xq = 1:length(var2scale2);
sampRateChange = interp1(x, var2scale, xq);

% desaccade2 = visualAvg1;
% deltaF = visualAvg4a;
% scale = (length(desaccade2)/length(deltaF));
% x = [1 scale*(2:length(deltaF))];
% xq = 1:length(desaccade2);
% visualAvg4interp = interp1(x, deltaF, xq);
% 
% visualAvg05downsamp = resample(visualAvg05a,1000,2000);
% 
% desaccade2 = visualAvg1;
% deltaF = visualAvg4b;
% scale = (length(desaccade2)/length(deltaF));
% x = [1 scale*(2:length(deltaF))];
% xq = 1:length(desaccade2);
% visualAvg4interpB = interp1(x, deltaF, xq);
% 
% visualAvg05downsampB = resample(visualAvg05b,1000,2000);
% 
% desaccade2 = visualAvg1;
% deltaF = visualDrumAvg4a;
% scale = (length(desaccade2)/length(deltaF));
% x = [1 scale*(2:length(deltaF))];
% xq = 1:length(desaccade2);
% visualDrumAvgInterp = interp1(x, deltaF, xq);
% 
% desaccade2 = visualAvg1;
% deltaF = visualDrumAvg4b;
% scale = (length(desaccade2)/length(deltaF));
% x = [1 scale*(2:length(deltaF))];
% xq = 1:length(desaccade2);
% visualDrumAvgInterpB = interp1(x, deltaF, xq);