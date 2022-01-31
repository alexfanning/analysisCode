%plot okr avg and SE with shade
okr1dsAvg = mean(okr1ds,2);
okr1dsSE = std(okr1ds,0,2)/sqrt(length(okr1ds(1));
darkAllAvg = mean(darkAll,2);
darkAllSE = std(darkAll,0,2)/sqrt(length(darkAll));
darkAllAvg = mean(darkAll,2);
darkAllSE = std(darkAll,0,2)/sqrt(length(darkAll));
darkAllAvg = mean(darkAll,2);
darkAllSE = std(darkAll,0,2)/sqrt(length(darkAll));

darkAllAvg = mean(darkAll,2);
darkAllSE = std(darkAll,0,2)/sqrt(length(darkAll));
darkAllAvg = mean(darkAll,2);
darkAllSE = std(darkAll,0,2)/sqrt(length(darkAll));
darkAllAvg = mean(darkAll,2);
darkAllSE = std(darkAll,0,2)/sqrt(length(darkAll));
darkAllAvg = mean(darkAll,2);
darkAllSE = std(darkAll,0,2)/sqrt(length(darkAll));

%calculate upper and lower standard error
okr1ds1 = okr1dsAvg + okr1dsSE;
okr1ds2 = okr1dsAvg - okr1dsSE;
okr5ds1 = okr5dsAvg + okr5dsSE;
okr5ds2 = okr5dsAvg - okr5dsSE;
okr10ds1 = okr10dsAvg + okr10dsSE;
okr10ds2 = okr10dsAvg - okr10dsSE;
okr20ds1 = okr20dsAvg + okr20dsSE;
okr20ds2 = okr20dsAvg - okr20dsSE;

vord1ds1 = vord1dsAvg + vord1dsSE;
vord1ds2 = vord1dsAvg - vord1dsSE;
vord5ds1 = vord5dsAvg + vord5dsSE;
vord5ds2 = vord5dsAvg - vord5dsSE;
vord10ds1 = vord10dsAvg + vord10dsSE;
vord10ds2 = vord10dsAvg - vord10dsSE;
vord20ds1 = vord20dsAvg + vord20dsSE;
vord20ds2 = vord20dsAvg - vord20dsSE;

okrEye1ds1 = okrEye1dsAvg + okrEye1dsSE;
okrEye1ds2 = okrEye1dsAvg - okrEye1dsSE;
okrEye5ds1 = okrEye5dsAvg + okrEye5dsSE;
okrEye5ds2 = okrEye5dsAvg - okrEye5dsSE;
okrEye10ds1 = okrEye10dsAvg + okrEye10dsSE;
okrEye10ds2 = okrEye10dsAvg - okrEye10dsSE;
okrEye20ds1 = okrEye20dsAvg + okrEye20dsSE;
okrEye20ds2 = okrEye20dsAvg - okrEye20dsSE;

vordEye1ds1 = vordEye1dsAvg + vordEye1dsSE;
vordEye1ds2 = vordEye1dsAvg - vordEye1dsSE;
vordEye5ds1 = vordEye5dsAvg + vordEye5dsSE;
vordEye5ds2 = vordEye5dsAvg - vordEye5dsSE;
vordEye10ds1 = vordEye10dsAvg + vordEye10dsSE;
vordEye10ds2 = vordEye10dsAvg - vordEye10dsSE;
vordEye20ds1 = vordEye20dsAvg + vordEye20dsSE;
vordEye20ds2 = vordEye20dsAvg - vordEye20dsSE;

okr1dsRS1 = okr1dsRSavg + okr1dsRSse;
okr1dsRS2 = okr1dsRSavg - okr1dsRSse;
okr5dsRS1 = okr5dsRSavg + okr5dsRSse;
okr5dsRS2 = okr5dsRSavg - okr5dsRSse;
okr10dsRS1 = okr10dsRSavg + okr10dsRSse;
okr10dsRS2 = okr10dsRSavg - okr10dsRSse;
okr20dsRS1 = okr20dsRSavg + okr20dsRSse;
okr20dsRS2 = okr20dsRSavg - okr20dsRSse;

x = 1:39
x = x'


%plot each velocity profile with shading
figure(1);
hold on
plot(okr1dsAvg);
shade(x,okr1ds1,x,okr1ds2,'FillType',[1 2],'FillColor','k','FillAlpha',0.5);
plot(okr5dsAvg);
shade(x,okr5ds1,x,okr5ds2,'FillType',[1 2],'FillColor','b','FillAlpha',0.5);
plot(okr10dsAvg);
shade(x,okr10ds1,x,okr10ds2,'FillType',[1 2],'FillColor','r','FillAlpha',0.5);
plot(okr20dsAvg);
shade(x,okr20ds1,x,okr20ds2,'FillType',[1 2],'FillColor','cyan','FillAlpha',0.5);

figure(2);
hold on
plot(vord1dsAvg);
shade(x,vord1ds1,x,vord1ds2,'FillType',[1 2],'FillColor','k','FillAlpha',0.5);
plot(vord5dsAvg);
shade(x,vord5ds1,x,vord5ds2,'FillType',[1 2],'FillColor','b','FillAlpha',0.5);
plot(vord10dsAvg);
shade(x,vord10ds1,x,vord10ds2,'FillType',[1 2],'FillColor','r','FillAlpha',0.5);
plot(vord20dsAvg);
shade(x,vord20ds1,x,vord20ds2,'FillType',[1 2],'FillColor','cyan','FillAlpha',0.5);

figure(3);
hold on
plot(okrEye1dsAvg);
shade(x,okrEye1ds1,x,okrEye1ds2,'FillType',[1 2],'FillColor','k','FillAlpha',0.5);
plot(okrEye5dsAvg);
shade(x,okrEye5ds1,x,okrEye5ds2,'FillType',[1 2],'FillColor','b','FillAlpha',0.5);
plot(okrEye10dsAvg);
shade(x,okrEye10ds1,x,okrEye10ds2,'FillType',[1 2],'FillColor','r','FillAlpha',0.5);
plot(okrEye20dsAvg);
shade(x,okrEye20ds1,x,okrEye20ds2,'FillType',[1 2],'FillColor','cyan','FillAlpha',0.5);

figure(4);
hold on
plot(vordEye1dsAvg);
shade(x,vordEye1ds1,x,vordEye1ds2,'FillType',[1 2],'FillColor','k','FillAlpha',0.5);
plot(vordEye5dsAvg);
shade(x,vordEye5ds1,x,vordEye5ds2,'FillType',[1 2],'FillColor','b','FillAlpha',0.5);
plot(vordEye10dsAvg);
shade(x,vordEye10ds1,x,vordEye10ds2,'FillType',[1 2],'FillColor','r','FillAlpha',0.5);
plot(vordEye20dsAvg);
shade(x,vordEye20ds1,x,vordEye20ds2,'FillType',[1 2],'FillColor','cyan','FillAlpha',0.5);

figure(5);
hold on
plot(okr1dsRSavg);
shade(x,okr1dsRS1,x,okr1dsRS2,'FillType',[1 2],'FillColor','k','FillAlpha',0.5);
plot(okr5dsRSavg);
shade(x,okr5dsRS1,x,okr5dsRS2,'FillType',[1 2],'FillColor','b','FillAlpha',0.5);
plot(okr10dsRSavg);
shade(x,okr10dsRS1,x,okr10dsRS2,'FillType',[1 2],'FillColor','r','FillAlpha',0.5);
plot(okr20dsRSavg);
shade(x,okr20dsRS1,x,okr20dsRS2,'FillType',[1 2],'FillColor','cyan','FillAlpha',0.5);

figure(6);
hold on
plot(drum1ds,'color','k');
plot(drum5ds,'color','b');
plot(drum10ds,'color','r');
plot(drum20ds,'color','cyan');

figure(7);
hold on
plot(turntable1ds,'color','k');
plot(turntable5ds,'color','b');
plot(turntable10ds,'color','r');
plot(turntable20ds,'color','cyan');