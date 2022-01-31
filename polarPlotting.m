%polar plots for each test condition

%Quiver(x,y,u,v)
%      x and y are origin points (0,0)
%      u and v are SE of theta and rho, respectively

polarscatter(eyeDark,fpDark);
hold on
polarscatter(stimDark,fpDark);
quiver(x,y,u,v);

polarscatter(eyeGainDown,fpGainDown);
hold on
polarscatter(stimGainDown,fpGainDown);
polarscatter(rsGainDown,fpGainDown);

polarscatter(eyeGainUp,fpGainUp);
hold on
polarscatter(stimGainUp,fpGainUp);
polarscatter(rsGainUp,fpGainUp);

polarscatter(eyeOKR,fpOKR);
hold on
polarscatter(rsOKR,fpOKR);

%plot single variable with all test conditions
polarscatter(rsGainDown,fpGainDown);
hold on
polarscatter(rsGainUp,fpGainUp);
polarscatter(rsOKR,fpOKR);

polarscatter(eyeDark,fpDark);
hold on
polarscatter(eyeGainDown,fpGainDown);
polarscatter(eyeGainUp,fpGainUp);
polarscatter(eyeOKR,fpOKR);

polarscatter(stimDark,fpDark);
hold on
polarscatter(stimGainDown,fpGainDown);
polarscatter(stimGainUp,fpGainUp);