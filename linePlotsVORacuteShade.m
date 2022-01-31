dark1 = darkAvg + darkSE;
dark2 = darkAvg - darkSE;
okr1 = okrAvg + okrSE;
okr2 = okrAvg - okrSE;
x01 = x0avg + x0se;
x02 = x0avg - x0se;
x21 = x2avg + x2se;
x22 = x2avg - x2se;
sp1 = spAvg + spSE;
sp2 = spAvg - spSE;

x = 1:1000
x = x'

figure(1);
hold on
plot(darkAvg);
shade(x,dark1,x,dark2,'FillType',[1 2],'FillColor','k','FillAlpha',0.5);
plot(x0avg);
shade(x,x01,x,x02,'FillType',[1 2],'FillColor','b','FillAlpha',0.5);
plot(x2avg);
shade(x,x21,x,x22,'FillType',[1 2],'FillColor','r','FillAlpha',0.5);
plot(okrAvg);
shade(x,okr1,x,okr2,'FillType',[1 2],'FillColor','cyan','FillAlpha',0.5);
plot(spAvg);
shade(x,sp1,x,sp2,'FillType',[1 2],'FillColor','y','FillAlpha',0.5);