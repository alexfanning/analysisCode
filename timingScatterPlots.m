
a = 0.25;
aa = [0.25,0.25,0.25,0.25,0.25,0.25,0.25];
b = 0.5;
ca = [0.5,0.5,0.5,0.5,0.5,0.5,0.5];
c = 0.75;
ca = [0.75,0.75,0.75,0.75,0.75,0.75,0.75];
d = 1;
da = [1,1,1,1,1,1,1];
e = 1.25;
ea = [1.25,1.25,1.25,1.25,1.25,1.25,1.25];
f = 1.5;
fa = [1.5,1.5,1.5,1.5,1.5,1.5,1.5];


%% 
figure(); hold on
scatter(aa,calSinePeakReshape(3,:))
scatter(a,calSinePeakOKRavg,'k')
errorbar(aa,calSinePeakOKRavg,calSinePeakOKRse,'k')
scatter(ca,calSinePeakReshape(1,:))
scatter(b,calSinePeakX2avg,'k')
errorbar(ca,calSinePeakX2avg,calSinePeakX2se,'k')
scatter(ya,calSinePeakReshape(2,:))
scatter(c,calSinePeakX0avg,'k')
errorbar(ya,calSinePeakX0avg,calSinePeakX0se,'k')
scatter(da,calDsinePeak)
scatter(d,calDsinePeakAvg,'k')
errorbar(da,calDsinePeakAvg,calDsinePeakSE,'k')
%% 

figure(); hold on
scatter(calDelayDrum05a,a,'b')
scatter(calDelayDrum1a,b,'b')
scatter(calDelayDrum2a,c,'b')
scatter(calDelayDrum4a,d,'b')
scatter(calDelayDrum5a,e,'b')
scatter(calDelayDrum10a,f,'b')
xlim([-500 500])
ylim([0 1.5])
yticks([0 0.25 0.5 0.75 1 1.25 1.5])
scatter(calDelayDrum05b,a,'r')
scatter(calDelayDrum1b,b,'r')
scatter(calDelayDrum2b,c,'r')
scatter(calDelayDrum4b,d,'r')
scatter(calDelayDrum5b,e,'r')
scatter(calDelayDrum10b,f,'r')

scatter(calDelayDrum05mean,a,'k','Filled')
scatter(calDelayDrum1mean,b,'k','Filled')
scatter(calDelayDrum2mean,c,'k','Filled')
scatter(calDelayDrum4mean,d,'k','Filled')
scatter(calDelayDrum5mean,e,'k','Filled')
scatter(calDelayDrum10mean,f,'k','Filled')
legend('Subject 1','Subject 2','Population avg.')

figure(); hold on
scatter(calDelayRS05a,a,'b')
scatter(calDelayRS1a,b,'b')
scatter(calDelayRS2a,c,'b')
scatter(calDelayRS4a,d,'b')
scatter(calDelayRS5a,e,'b')
scatter(calDelayRS10a,f,'b')
xlim([-500 500])
ylim([0 1.75])
yticks([0 0.25 0.5 0.75 1 1.25 1.5])

scatter(calDelayRS05b,a,'r')
scatter(calDelayRS1b,b,'r')
scatter(calDelayRS2b,c,'r')
scatter(calDelayRS4b,d,'r')
scatter(calDelayRS5b,e,'r')
scatter(calDelayRS10b,f,'r')

scatter(calDelayRS05mean,a,'k','Filled')
scatter(calDelayRS1mean,b,'k','Filled')
scatter(calDelayRS2mean,c,'k','Filled')
scatter(calDelayRS4mean,d,'k','Filled')
scatter(calDelayRS5mean,e,'k','Filled')
scatter(calDelayRS10mean,f,'k','Filled')