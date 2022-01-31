%% concatenating calcium data from individual subjects (sine fitted and unfitted, vestibular-dark and x2)
numCells = 6;
numCellsD = 12;
x2desac05 = cell(numCells,1);
x2desac05{1} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacSMCS19.xlsx');
x2desac05{2} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacSMCS30.xlsx');
x2desac05{3} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacSMCS32.xlsx');
x2desac05{4} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacSMCS38.xlsx');
x2desac05{5} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacL7cre2.xlsx');
x2desac05{6} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacL7cre2b.xlsx');

x2desac2 = cell(numCells,1);
x2desac2{1} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacSMCS19.xlsx');
x2desac2{2} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacSMCS30.xlsx');
x2desac2{3} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacSMCS32.xlsx');
x2desac2{4} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacSMCS38.xlsx');
x2desac2{5} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacL7cre2.xlsx');
x2desac2{6} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacL7cre2b.xlsx');

x2desac05dark = cell(numCellsD,1);
x2desac05dark{1} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacSMCS19.xlsx','sheet2');
x2desac05dark{2} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacSMCS30.xlsx','sheet2');
x2desac05dark{3} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacSMCS32.xlsx','sheet2');
x2desac05dark{4} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacSMCS38.xlsx','sheet2');
x2desac05dark{5} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacL7cre2.xlsx','sheet2');
x2desac05dark{6} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacL7cre2b.xlsx','sheet2');

x2desac2dark = cell(numCellsD,1);
x2desac2dark{1} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacSMCS19.xlsx','sheet2');
x2desac2dark{2} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacSMCS30.xlsx','sheet2');
x2desac2dark{3} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacSMCS32.xlsx','sheet2');
x2desac2dark{4} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacSMCS38.xlsx','sheet2');
x2desac2dark{5} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacL7cre2.xlsx','sheet2');
x2desac2dark{6} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacL7cre2b.xlsx','sheet2');

x2desac05sp = cell(numCellsD,1);
x2desac05sp{1} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacSMCS19.xlsx','sheet3');
x2desac05sp{2} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacSMCS30.xlsx','sheet3');
x2desac05sp{3} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacSMCS32.xlsx','sheet3');
x2desac05sp{4} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacSMCS38.xlsx','sheet3');
x2desac05sp{5} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacL7cre2.xlsx','sheet3');
x2desac05sp{6} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacL7cre2b.xlsx','sheet3');

x2desac2sp = cell(numCellsD,1);
x2desac2sp{1} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacSMCS19.xlsx','sheet3');
x2desac2sp{2} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacSMCS30.xlsx','sheet3');
x2desac2sp{3} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacSMCS32.xlsx','sheet3');
x2desac2sp{4} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacSMCS38.xlsx','sheet3');
x2desac2sp{5} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacL7cre2.xlsx','sheet3');
x2desac2sp{6} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacL7cre2b.xlsx','sheet3');

x2desac05sine = cell(numCells,1);
x2desac05sine{1} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacSMCS19.xlsx','sheet4');
x2desac05sine{2} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacSMCS30.xlsx','sheet4');
x2desac05sine{3} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacSMCS32.xlsx','sheet4');
x2desac05sine{4} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacSMCS38.xlsx','sheet4');
x2desac05sine{5} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacL7cre2.xlsx','sheet4');
x2desac05sine{6} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacL7cre2b.xlsx','sheet4');

x2desac2sine = cell(numCells,1);
x2desac2sine{1} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacSMCS19.xlsx','sheet4');
x2desac2sine{2} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacSMCS30.xlsx','sheet4');
x2desac2sine{3} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacSMCS32.xlsx','sheet4');
x2desac2sine{4} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacSMCS38.xlsx','sheet4');
x2desac2sine{5} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacL7cre2.xlsx','sheet4');
x2desac2sine{6} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacL7cre2b.xlsx','sheet4');

x2desac05darkSine = cell(numCellsD,1);
x2desac05darkSine{1} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacSMCS19.xlsx','sheet5');
x2desac05darkSine{2} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacSMCS30.xlsx','sheet5');
x2desac05darkSine{3} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacSMCS32.xlsx','sheet5');
x2desac05darkSine{4} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacSMCS38.xlsx','sheet5');
x2desac05darkSine{5} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacL7cre2.xlsx','sheet5');
x2desac05darkSine{6} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacL7cre2b.xlsx','sheet5');

x2desac2darkSine = cell(numCellsD,1);
x2desac2darkSine{1} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacSMCS19.xlsx','sheet5');
x2desac2darkSine{2} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacSMCS30.xlsx','sheet5');
x2desac2darkSine{3} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacSMCS32.xlsx','sheet5');
x2desac2darkSine{4} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacSMCS38.xlsx','sheet5');
x2desac2darkSine{5} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacL7cre2.xlsx','sheet5');
x2desac2darkSine{6} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacL7cre2b.xlsx','sheet5');

lightX2desac05 = [x2desac05{1}(:,1:6),x2desac05{2}(:,1:6),x2desac05{3}(:,1:6),x2desac05{4}(:,1:6),x2desac05{5}(:,1:6),x2desac05{6}(:,1:6)];
lightX2avg05 = nanmean(lightX2desac05,2);
lightX2se05 = nanstd(lightX2desac05,0,2)/sqrt(length(lightX2desac05(1,:)));

lightX2desac2 = [x2desac2{1}(:,1:6),x2desac2{2}(:,1:6),x2desac2{3}(:,1:6),x2desac2{4}(:,1:6),x2desac2{5}(:,1:6),x2desac2{6}(:,1:6)];
lightX2avg2 = nanmean(lightX2desac2,2);
lightX2se2 = nanstd(lightX2desac2,0,2)/sqrt(length(lightX2desac2(1,:)));

lightAvgX2desac05 = [x2desac05{1}(:,8),x2desac05{2}(:,8),x2desac05{3}(:,8),x2desac05{4}(:,8),x2desac05{5}(:,8),x2desac05{6}(:,8)];
lightAvgX2avg05 = nanmean(lightAvgX2desac05,2);
lightAvgX2se05 = nanstd(lightAvgX2desac05,0,2)/sqrt(length(lightAvgX2desac05(1,:)));

lightAvgX2desac2 = [x2desac2{1}(:,8),x2desac2{2}(:,8),x2desac2{3}(:,8),x2desac2{4}(:,8),x2desac2{5}(:,8),x2desac2{6}(:,8)];
lightAvgX2avg2 = nanmean(lightAvgX2desac2,2);
lightAvgX2se2 = nanstd(lightAvgX2desac2,0,2)/sqrt(length(lightAvgX2desac2(1,:)));

darkX2desac05 = [x2desac05dark{1}(:,1:12),x2desac05dark{2}(:,1:12),x2desac05dark{3}(:,1:12),x2desac05dark{4}(:,1:12),x2desac05dark{5}(:,1:12),x2desac05dark{6}(:,1:12)];
darkX2avg05 = nanmean(darkX2desac05,2);
darkX2se05 = nanstd(darkX2desac05,0,2)/sqrt(length(darkX2desac05(1,:)));

darkX2desac2 = [x2desac2dark{1}(:,1:12),x2desac2dark{2}(:,1:12),x2desac2dark{3}(:,1:12),x2desac2dark{4}(:,1:12),x2desac2dark{5}(:,1:12),x2desac2dark{6}(:,1:12)];
darkX2avg2 = nanmean(darkX2desac2,2);
darkX2se2 = nanstd(darkX2desac2,0,2)/sqrt(length(darkX2desac2(1,:)));

darkAvgX2desac05 = [x2desac05dark{1}(:,14),x2desac05dark{2}(:,14),x2desac05dark{3}(:,14),x2desac05dark{4}(:,14),x2desac05dark{5}(:,14),x2desac05dark{6}(:,14)];
darkAvgX2avg05 = nanmean(darkAvgX2desac05,2);
darkAvgX2se05 = nanstd(darkAvgX2desac05,0,2)/sqrt(length(darkAvgX2desac05(1,:)));

darkAvgX2desac2 = [x2desac2dark{1}(:,14),x2desac2dark{2}(:,14),x2desac2dark{3}(:,14),x2desac2dark{4}(:,14),x2desac2dark{5}(:,14),x2desac2dark{6}(:,14)];
darkAvgX2avg2 = nanmean(darkAvgX2desac2,2);
darkAvgX2se2 = nanstd(darkAvgX2desac2,0,2)/sqrt(length(darkAvgX2desac2(1,:)));

lightSineX2desac05 = [x2desac05sine{1}(:,1:6),x2desac05sine{2}(:,1:6),x2desac05sine{3}(:,1:6),x2desac05sine{4}(:,1:6),x2desac05sine{5}(:,1:6),x2desac05sine{6}(:,1:6)];
lightSineX2avg05 = nanmean(lightSineX2desac05,2);
lightSineX2se05 = nanstd(lightSineX2desac05,0,2)/sqrt(length(lightSineX2desac05(1,:)));

lightSineX2desac2 = [x2desac2sine{1}(:,1:6),x2desac2sine{2}(:,1:6),x2desac2sine{3}(:,1:6),x2desac2sine{4}(:,1:6),x2desac2sine{5}(:,1:6),x2desac2sine{6}(:,1:6)];
lightSineX2avg2 = nanmean(lightSineX2desac2,2);
lightSineX2se2 = nanstd(lightSineX2desac2,0,2)/sqrt(length(lightSineX2desac2(1,:)));

lightSineAvgX2desac05 = [x2desac05sine{1}(:,8),x2desac05sine{2}(:,8),x2desac05sine{3}(:,8),x2desac05sine{4}(:,8),x2desac05sine{5}(:,8),x2desac05sine{6}(:,8)];
lightSineAvgX2avg05 = nanmean(lightSineAvgX2desac05,2);
lightSineAvgX2se05 = nanstd(lightSineAvgX2desac05,0,2)/sqrt(length(lightSineAvgX2desac05(1,:)));

lightSineAvgX2desac2 = [x2desac2sine{1}(:,8),x2desac2sine{2}(:,8),x2desac2sine{3}(:,8),x2desac2sine{4}(:,8),x2desac2sine{5}(:,8),x2desac2sine{6}(:,8)];
lightSineAvgX2avg2 = nanmean(lightSineAvgX2desac2,2);
lightSineAvgX2se2 = nanstd(lightSineAvgX2desac2,0,2)/sqrt(length(lightSineAvgX2desac2(1,:)));

darkSineX2desac05 = [x2desac05darkSine{1}(:,1:12),x2desac05darkSine{2}(:,1:12),x2desac05darkSine{3}(:,1:12),x2desac05darkSine{4}(:,1:12),x2desac05darkSine{5}(:,1:12),x2desac05darkSine{6}(:,1:12)];
darkSineX2avg05 = nanmean(darkSineX2desac05,2);
darkSineX2se05 = nanstd(darkSineX2desac05,0,2)/sqrt(length(darkSineX2desac05(1,:)));

darkSineX2desac2 = [x2desac2darkSine{1}(:,1:12),x2desac2darkSine{2}(:,1:12),x2desac2darkSine{3}(:,1:12),x2desac2darkSine{4}(:,1:12),x2desac2darkSine{5}(:,1:12),x2desac2darkSine{6}(:,1:12)];
darkSineX2avg2 = nanmean(darkSineX2desac2,2);
darkSineX2se2 = nanstd(darkSineX2desac2,0,2)/sqrt(length(darkSineX2desac2(1,:)));

darkSineAvgX2desac05 = [x2desac05darkSine{1}(:,14),x2desac05darkSine{2}(:,14),x2desac05darkSine{3}(:,14),x2desac05darkSine{4}(:,14),x2desac05darkSine{5}(:,14),x2desac05darkSine{6}(:,14)];
darkSineAvgX2avg05 = nanmean(darkSineAvgX2desac05,2);
darkSineAvgX2se05 = nanstd(darkSineAvgX2desac05,0,2)/sqrt(length(darkSineAvgX2desac05(1,:)));

darkSineAvgX2desac2 = [x2desac2darkSine{1}(:,14),x2desac2darkSine{2}(:,14),x2desac2darkSine{3}(:,14),x2desac2darkSine{4}(:,14),x2desac2darkSine{5}(:,14),x2desac2darkSine{6}(:,14)];
darkSineAvgX2avg2 = nanmean(darkSineAvgX2desac2,2);
darkSineAvgX2se2 = nanstd(darkSineAvgX2desac2,0,2)/sqrt(length(darkSineAvgX2desac2(1,:)));

spX2desac05 = [x2desac05sp{1}(:,1:12),x2desac05sp{2}(:,1:12),x2desac05sp{3}(:,1:12),x2desac05sp{4}(:,1:12),x2desac05sp{5}(:,1:12),x2desac05sp{6}(:,1:12)];
spX2avg05 = nanmean(spX2desac05,2);
spX2se05 = nanstd(spX2desac05,0,2)/sqrt(length(spX2desac05(1,:)));

spX2desac2 = [x2desac2sp{1}(:,1:12),x2desac2sp{2}(:,1:12),x2desac2sp{3}(:,1:12),x2desac2sp{4}(:,1:12),x2desac2sp{5}(:,1:12),x2desac2sp{6}(:,1:12)];
spX2avg2 = nanmean(spX2desac2,2);
spX2se2 = nanstd(spX2desac2,0,2)/sqrt(length(spX2desac2(1,:)));

spAvgX2desac05 = [x2desac05sp{1}(:,14),x2desac05sp{2}(:,14),x2desac05sp{3}(:,14),x2desac05sp{4}(:,14),x2desac05sp{5}(:,14),x2desac05sp{6}(:,14)];
spAvgX2avg05 = nanmean(spAvgX2desac05,2);
spAvgX2se05 = nanstd(spAvgX2desac05,0,2)/sqrt(length(spAvgX2desac05(1,:)));

spAvgX2desac2 = [x2desac2sp{1}(:,8),x2desac2sp{2}(:,8),x2desac2sp{3}(:,8),x2desac2sp{4}(:,8),x2desac2sp{5}(:,8),x2desac2sp{6}(:,14)];
spAvgX2avg2 = nanmean(spAvgX2desac2,2);
spAvgX2se2 = nanstd(spAvgX2desac2,0,2)/sqrt(length(spAvgX2desac2(1,:)));

filename = 'C:\Users\afanning\Documents\Data\FP\05and2hzVORacuteConcat.xlsx';
sheet = 1;
header = cellstr('lightAll');
header2 = cellstr('dark');
header3 = cellstr('sp');

xlswrite(filename,header,sheet,'A1');
xlswrite(filename,lightX2desac05,sheet,'B1');
xlswrite(filename,lightX2avg05,sheet,'AM1');
xlswrite(filename,lightX2se05,sheet,'AN1');

xlswrite(filename,header,'sheet2','A1');
xlswrite(filename,lightAvgX2desac05,'sheet2','B1');
xlswrite(filename,lightAvgX2avg05,'sheet2','L1');
xlswrite(filename,lightAvgX2se05,'sheet2','M1');

xlswrite(filename,header,'sheet3','A1');
xlswrite(filename,lightX2desac2,'sheet3','B1');
xlswrite(filename,lightX2avg2,'sheet3','AM1');
xlswrite(filename,lightX2se2,'sheet3','AN1');

xlswrite(filename,header,'sheet4','A1');
xlswrite(filename,lightAvgX2desac2,'sheet4','B1');
xlswrite(filename,lightAvgX2avg2,'sheet4','L1');
xlswrite(filename,lightAvgX2se2,'sheet4','M1');

xlswrite(filename,header2,'sheet5','A1');
xlswrite(filename,darkX2desac05,'sheet5','B1');
xlswrite(filename,darkX2avg05,'sheet5','AM1');
xlswrite(filename,darkX2se05,'sheet5','AN1');

xlswrite(filename,header2,'sheet6','A1');
xlswrite(filename,darkAvgX2desac05,'sheet6','B1');
xlswrite(filename,darkAvgX2avg05,'sheet6','L1');
xlswrite(filename,darkAvgX2se05,'sheet6','M1');

xlswrite(filename,header2,'sheet7','A1');
xlswrite(filename,darkX2desac2,'sheet7','B1');
xlswrite(filename,darkX2avg2,'sheet7','AM1');
xlswrite(filename,darkX2se2,'sheet7','AN1');

xlswrite(filename,header2,'sheet8','A1');
xlswrite(filename,darkAvgX2desac2,'sheet8','B1');
xlswrite(filename,darkAvgX2avg2,'sheet8','L1');
xlswrite(filename,darkAvgX2se2,'sheet8','M1');

xlswrite(filename,header,'sheet9','A1');
xlswrite(filename,lightSineX2desac05,'sheet9','B1');
xlswrite(filename,lightSineX2avg05,'sheet9','AM1');
xlswrite(filename,lightSineX2se05,'sheet9','AN1');

xlswrite(filename,header,'sheet10','A1');
xlswrite(filename,lightSineAvgX2desac05,'sheet10','B1');
xlswrite(filename,lightSineAvgX2avg05,'sheet10','L1');
xlswrite(filename,lightSineAvgX2se05,'sheet10','M1');

xlswrite(filename,header,'sheet11','A1');
xlswrite(filename,lightSineX2desac2,'sheet11','B1');
xlswrite(filename,lightSineX2avg2,'sheet11','AM1');
xlswrite(filename,lightSineX2se2,'sheet11','AN1');

xlswrite(filename,header,'sheet12','A1');
xlswrite(filename,lightSineAvgX2desac2,'sheet12','B1');
xlswrite(filename,lightSineAvgX2avg2,'sheet12','L1');
xlswrite(filename,lightSineAvgX2se2,'sheet12','M1');

xlswrite(filename,header2,'sheet13','A1');
xlswrite(filename,darkSineX2desac05,'sheet13','B1');
xlswrite(filename,darkSineX2avg05,'sheet13','AM1');
xlswrite(filename,darkSineX2se05,'sheet13','AN1');

xlswrite(filename,header2,'sheet14','A1');
xlswrite(filename,darkSineAvgX2desac05,'sheet14','B1');
xlswrite(filename,darkSineAvgX2avg05,'sheet14','L1');
xlswrite(filename,darkSineAvgX2se05,'sheet14','M1');

xlswrite(filename,header2,'sheet15','A1');
xlswrite(filename,darkSineX2desac2,'sheet15','B1');
xlswrite(filename,darkSineX2avg2,'sheet15','AM1');
xlswrite(filename,darkSineX2se2,'sheet15','AN1');

xlswrite(filename,header2,'sheet16','A1');
xlswrite(filename,darkSineAvgX2desac2,'sheet16','B1');
xlswrite(filename,darkSineAvgX2avg2,'sheet16','L1');
xlswrite(filename,darkSineAvgX2se2,'sheet16','M1');

xlswrite(filename,header3,'sheet17','A1');
xlswrite(filename,spX2desac05,'sheet17','B1');
xlswrite(filename,spX2avg05,'sheet17','AM1');
xlswrite(filename,spX2se05,'sheet17','AN1');

xlswrite(filename,header3,'sheet18','A1');
xlswrite(filename,spAvgX2desac05,'sheet18','B1');
xlswrite(filename,spAvgX2avg05,'sheet18','L1');
xlswrite(filename,spAvgX2se05,'sheet18','M1');

xlswrite(filename,header3,'sheet19','A1');
xlswrite(filename,spX2desac2,'sheet19','B1');
xlswrite(filename,spX2avg2,'sheet19','AM1');
xlswrite(filename,spX2se2,'sheet19','AN1');

xlswrite(filename,header3,'sheet20','A1');
xlswrite(filename,spAvgX2desac2,'sheet20','B1');
xlswrite(filename,spAvgX2avg2,'sheet20','L1');
xlswrite(filename,spAvgX2se2,'sheet20','M1');

%% concatenating eye data from individual subjects (sine fitted and unfitted, vestibular-dark and x2)
numCells = 6;
numCellsD = 12;
x2eye05 = cell(numCells,1);
x2eye05{1} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeSMCS19.xlsx');
x2eye05{2} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeSMCS30.xlsx');
x2eye05{3} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeSMCS32.xlsx');
x2eye05{4} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeSMCS38.xlsx');
x2eye05{5} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeL7cre2.xlsx');
x2eye05{6} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeL7cre2b.xlsx');

x2eye2 = cell(numCells,1);
x2eye2{1} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeSMCS19.xlsx');
x2eye2{2} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeSMCS30.xlsx');
x2eye2{3} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeSMCS32.xlsx');
x2eye2{4} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeSMCS38.xlsx');
x2eye2{5} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeL7cre2.xlsx');
x2eye2{6} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeL7cre2b.xlsx');

x2eye05dark = cell(numCellsD,1);
x2eye05dark{1} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeSMCS19.xlsx','sheet2');
x2eye05dark{2} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeSMCS30.xlsx','sheet2');
x2eye05dark{3} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeSMCS32.xlsx','sheet2');
x2eye05dark{4} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeSMCS38.xlsx','sheet2');
x2eye05dark{5} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeL7cre2.xlsx','sheet2');
x2eye05dark{6} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeL7cre2b.xlsx','sheet2');

x2eye2dark = cell(numCellsD,1);
x2eye2dark{1} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeSMCS19.xlsx','sheet2');
x2eye2dark{2} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeSMCS30.xlsx','sheet2');
x2eye2dark{3} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeSMCS32.xlsx','sheet2');
x2eye2dark{4} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeSMCS38.xlsx','sheet2');
x2eye2dark{5} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeL7cre2.xlsx','sheet2');
x2eye2dark{6} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeL7cre2b.xlsx','sheet2');

x2eye05sp = cell(numCellsD,1);
x2eye05sp{1} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeSMCS19.xlsx','sheet3');
x2eye05sp{2} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeSMCS30.xlsx','sheet3');
x2eye05sp{3} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeSMCS32.xlsx','sheet3');
x2eye05sp{4} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeSMCS38.xlsx','sheet3');
x2eye05sp{5} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeL7cre2.xlsx','sheet3');
x2eye05sp{6} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeL7cre2b.xlsx','sheet3');

x2eye2sp = cell(numCellsD,1);
x2eye2sp{1} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeSMCS19.xlsx','sheet3');
x2eye2sp{2} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeSMCS30.xlsx','sheet3');
x2eye2sp{3} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeSMCS32.xlsx','sheet3');
x2eye2sp{4} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeSMCS38.xlsx','sheet3');
x2eye2sp{5} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeL7cre2.xlsx','sheet3');
x2eye2sp{6} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeL7cre2b.xlsx','sheet3');

x2eye05sine = cell(numCells,1);
x2eye05sine{1} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeSMCS19.xlsx','sheet4');
x2eye05sine{2} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeSMCS30.xlsx','sheet4');
x2eye05sine{3} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeSMCS32.xlsx','sheet4');
x2eye05sine{4} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeSMCS38.xlsx','sheet4');
x2eye05sine{5} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeL7cre2.xlsx','sheet4');
x2eye05sine{6} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeL7cre2b.xlsx','sheet4');

x2eye2sine = cell(numCells,1);
x2eye2sine{1} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeSMCS19.xlsx','sheet4');
x2eye2sine{2} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeSMCS30.xlsx','sheet4');
x2eye2sine{3} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeSMCS32.xlsx','sheet4');
x2eye2sine{4} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeSMCS38.xlsx','sheet4');
x2eye2sine{5} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeL7cre2.xlsx','sheet4');
x2eye2sine{6} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeL7cre2b.xlsx','sheet4');

x2eye05darkSine = cell(numCellsD,1);
x2eye05darkSine{1} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeSMCS19.xlsx','sheet5');
x2eye05darkSine{2} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeSMCS30.xlsx','sheet5');
x2eye05darkSine{3} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeSMCS32.xlsx','sheet5');
x2eye05darkSine{4} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeSMCS38.xlsx','sheet5');
x2eye05darkSine{5} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeL7cre2.xlsx','sheet5');
x2eye05darkSine{6} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacEyeL7cre2b.xlsx','sheet5');

x2eye2darkSine = cell(numCellsD,1);
x2eye2darkSine{1} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeSMCS19.xlsx','sheet5');
x2eye2darkSine{2} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeSMCS30.xlsx','sheet5');
x2eye2darkSine{3} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeSMCS32.xlsx','sheet5');
x2eye2darkSine{4} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeSMCS38.xlsx','sheet5');
x2eye2darkSine{5} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeL7cre2.xlsx','sheet5');
x2eye2darkSine{6} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacEyeL7cre2b.xlsx','sheet5');

lightX2eye05 = [x2eye05{1}(:,1:6),x2eye05{2}(:,1:6),x2eye05{3}(:,1:6),x2eye05{4}(:,1:6),x2eye05{5}(:,1:6),x2eye05{6}(:,1:6)];
lightX2eyeAvg05 = nanmean(lightX2eye05,2);
lightX2se05 = nanstd(lightX2eye05,0,2)/sqrt(length(lightX2eye05(1,:)));

lightX2eye2 = [x2eye2{1}(:,1:6),x2eye2{2}(:,1:6),x2eye2{3}(:,1:6),x2eye2{4}(:,1:6),x2eye2{5}(:,1:6),x2eye2{6}(:,1:6)];
lightX2eyeAvg2 = nanmean(lightX2eye2,2);
lightX2se2 = nanstd(lightX2eye2,0,2)/sqrt(length(lightX2eye2(1,:)));

lightAvgX2eye05 = [x2eye05{1}(:,8),x2eye05{2}(:,8),x2eye05{3}(:,8),x2eye05{4}(:,8),x2eye05{5}(:,8),x2eye05{6}(:,8)];
lightAvgX2eyeAvg05 = nanmean(lightAvgX2eye05,2);
lightAvgX2se05 = nanstd(lightAvgX2eye05,0,2)/sqrt(length(lightAvgX2eye05(1,:)));

lightAvgX2eye2 = [x2eye2{1}(:,8),x2eye2{2}(:,8),x2eye2{3}(:,8),x2eye2{4}(:,8),x2eye2{5}(:,8),x2eye2{6}(:,8)];
lightAvgX2eyeAvg2 = nanmean(lightAvgX2eye2,2);
lightAvgX2se2 = nanstd(lightAvgX2eye2,0,2)/sqrt(length(lightAvgX2eye2(1,:)));

filename = 'C:\Users\afanning\Documents\Data\FP\05and2hzVORacuteConcatEye.xlsx';
sheet = 1;
header = cellstr('lightAll');
header2 = cellstr('dark');
header3 = cellstr('sp');

xlswrite(filename,header,sheet,'A1');
xlswrite(filename,lightX2eye05,sheet,'B1');
xlswrite(filename,lightX2eyeAvg05,sheet,'AM1');
xlswrite(filename,lightX2se05,sheet,'AN1');

xlswrite(filename,header,'sheet2','A1');
xlswrite(filename,lightAvgX2eye05,'sheet2','B1');
xlswrite(filename,lightAvgX2eyeAvg05,'sheet2','L1');
xlswrite(filename,lightAvgX2se05,'sheet2','M1');

xlswrite(filename,header,'sheet3','A1');
xlswrite(filename,lightX2eye2,'sheet3','B1');
xlswrite(filename,lightX2eyeAvg2,'sheet3','AM1');
xlswrite(filename,lightX2se2,'sheet3','AN1');

xlswrite(filename,header,'sheet4','A1');
xlswrite(filename,lightAvgX2eye2,'sheet4','B1');
xlswrite(filename,lightAvgX2eyeAvg2,'sheet4','L1');
xlswrite(filename,lightAvgX2se2,'sheet4','M1');
%% concatenating stimuli data from individual subjects (sine fitted and unfitted, vestibular-dark and x2)
numCells = 6;
numCellsD = 12;
x2turntable05 = cell(numCells,1);
x2turntable05{1} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacStimuliSMCS19.xlsx');
x2turntable05{2} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacStimuliSMCS30.xlsx');
x2turntable05{3} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacStimuliSMCS32.xlsx');
x2turntable05{4} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacStimuliSMCS38.xlsx');
x2turntable05{5} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacStimuliL7cre2.xlsx');
x2turntable05{6} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacStimuliL7cre2b.xlsx');

x2turntable2 = cell(numCells,1);
x2turntable2{1} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacStimuliSMCS19.xlsx');
x2turntable2{2} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacStimuliSMCS30.xlsx');
x2turntable2{3} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacStimuliSMCS32.xlsx');
x2turntable2{4} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacStimuliSMCS38.xlsx');
x2turntable2{5} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacStimuliL7cre2.xlsx');
x2turntable2{6} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacStimuliL7cre2b.xlsx');

x2drum05 = cell(numCells,1);
x2drum05{1} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacStimuliSMCS19.xlsx','sheet2');
x2drum05{2} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacStimuliSMCS30.xlsx','sheet2');
x2drum05{3} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacStimuliSMCS32.xlsx','sheet2');
x2drum05{4} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacStimuliSMCS38.xlsx','sheet2');
x2drum05{5} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacStimuliL7cre2.xlsx','sheet2');
x2drum05{6} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacStimuliL7cre2b.xlsx','sheet2');

x2drum2 = cell(numCells,1);
x2drum2{1} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacStimuliSMCS19.xlsx','sheet2');
x2drum2{2} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacStimuliSMCS30.xlsx','sheet2');
x2drum2{3} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacStimuliSMCS32.xlsx','sheet2');
x2drum2{4} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacStimuliSMCS38.xlsx','sheet2');
x2drum2{5} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacStimuliL7cre2.xlsx','sheet2');
x2drum2{6} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacStimuliL7cre2b.xlsx','sheet2');

x2turntableDark05 = cell(numCellsD,1);
x2turntableDark05{1} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacStimuliSMCS19.xlsx','sheet3');
x2turntableDark05{2} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacStimuliSMCS30.xlsx','sheet3');
x2turntableDark05{3} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacStimuliSMCS32.xlsx','sheet3');
x2turntableDark05{4} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacStimuliSMCS38.xlsx','sheet3');
x2turntableDark05{5} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacStimuliL7cre2.xlsx','sheet3');
x2turntableDark05{6} = xlsread('C:\Users\afanning\Documents\Data\FP\05hzX2acute\05hzX2cycleAverageDesacStimuliL7cre2b.xlsx','sheet3');

x2turntableDark2 = cell(numCellsD,1);
x2turntableDark2{1} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacStimuliSMCS19.xlsx','sheet3');
x2turntableDark2{2} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacStimuliSMCS30.xlsx','sheet3');
x2turntableDark2{3} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacStimuliSMCS32.xlsx','sheet3');
x2turntableDark2{4} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacStimuliSMCS38.xlsx','sheet3');
x2turntableDark2{5} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacStimuliL7cre2.xlsx','sheet3');
x2turntableDark2{6} = xlsread('C:\Users\afanning\Documents\Data\FP\2hzX2acute\2hzX2cycleAverageDesacStimuliL7cre2b.xlsx','sheet3');


lightX2turntable05 = [x2turntable05{1}(:,1:6),x2turntable05{2}(:,1:6),x2turntable05{3}(:,1:6),x2turntable05{4}(:,1:6),x2turntable05{5}(:,1:6),x2turntable05{6}(:,1:6)];
lightX2turntableAvg05 = nanmean(lightX2turntable05,2);
lightX2se05 = nanstd(lightX2turntable05,0,2)/sqrt(length(lightX2turntable05(1,:)));

lightX2turntable2 = [x2turntable2{1}(:,1:6),x2turntable2{2}(:,1:6),x2turntable2{3}(:,1:6),x2turntable2{4}(:,1:6),x2turntable2{5}(:,1:6),x2turntable2{6}(:,1:6)];
lightX2turntableAvg2 = nanmean(lightX2turntable2,2);
lightX2se2 = nanstd(lightX2turntable2,0,2)/sqrt(length(lightX2turntable2(1,:)));

lightAvgX2turntable05 = [x2turntable05{1}(:,8),x2turntable05{2}(:,8),x2turntable05{3}(:,8),x2turntable05{4}(:,8),x2turntable05{5}(:,8),x2turntable05{6}(:,8)];
lightAvgX2turntableAvg05 = nanmean(lightAvgX2turntable05,2);
lightAvgX2se05 = nanstd(lightAvgX2turntable05,0,2)/sqrt(length(lightAvgX2turntable05(1,:)));

lightAvgX2turntable2 = [x2turntable2{1}(:,8),x2turntable2{2}(:,8),x2turntable2{3}(:,8),x2turntable2{4}(:,8),x2turntable2{5}(:,8),x2turntable2{6}(:,8)];
lightAvgX2turntableAvg2 = nanmean(lightAvgX2turntable2,2);
lightAvgX2se2 = nanstd(lightAvgX2turntable2,0,2)/sqrt(length(lightAvgX2turntable2(1,:)));

lightX2drum05 = [x2drum05{1}(:,1:6),x2drum05{2}(:,1:6),x2drum05{3}(:,1:6),x2drum05{4}(:,1:6),x2drum05{5}(:,1:6),x2drum05{6}(:,1:6)];
lightX2drumAvg05 = nanmean(lightX2drum05,2);
lightX2drumSE05 = nanstd(lightX2drum05,0,2)/sqrt(length(lightX2drum05(1,:)));

lightX2drum2 = [x2drum2{1}(:,1:6),x2drum2{2}(:,1:6),x2drum2{3}(:,1:6),x2drum2{4}(:,1:6),x2drum2{5}(:,1:6),x2drum2{6}(:,1:6)];
lightX2drumAvg2 = nanmean(lightX2drum2,2);
lightX2drumSE2 = nanstd(lightX2drum2,0,2)/sqrt(length(lightX2drum2(1,:)));

lightAvgX2drum05 = [x2drum05{1}(:,8),x2drum05{2}(:,8),x2drum05{3}(:,8),x2drum05{4}(:,8),x2drum05{5}(:,8),x2drum05{6}(:,8)];
lightAvgX2drumAvg05 = nanmean(lightAvgX2drum05,2);
lightAvgX2drumSE05 = nanstd(lightAvgX2drum05,0,2)/sqrt(length(lightAvgX2drum05(1,:)));

lightAvgX2drum2 = [x2drum2{1}(:,8),x2drum2{2}(:,8),x2drum2{3}(:,8),x2drum2{4}(:,8),x2drum2{5}(:,8),x2drum2{6}(:,8)];
lightAvgX2drumAvg2 = nanmean(lightAvgX2drum2,2);
lightAvgX2drumSE2 = nanstd(lightAvgX2drum2,0,2)/sqrt(length(lightAvgX2drum2(1,:)));

filename = 'C:\Users\afanning\Documents\Data\FP\05and2hzVORacuteConcatStimuli.xlsx';
sheet = 1;
header = cellstr('lightAll');
header2 = cellstr('dark');
header3 = cellstr('sp');

xlswrite(filename,header,sheet,'A1');
xlswrite(filename,lightX2turntable05,sheet,'B1');
xlswrite(filename,lightX2turntableAvg05,sheet,'AM1');
xlswrite(filename,lightX2se05,sheet,'AN1');

xlswrite(filename,header,'sheet2','A1');
xlswrite(filename,lightAvgX2turntable05,'sheet2','B1');
xlswrite(filename,lightAvgX2turntableAvg05,'sheet2','L1');
xlswrite(filename,lightAvgX2se05,'sheet2','M1');

xlswrite(filename,header,'sheet3','A1');
xlswrite(filename,lightX2turntable2,'sheet3','B1');
xlswrite(filename,lightX2turntableAvg2,'sheet3','AM1');
xlswrite(filename,lightX2se2,'sheet3','AN1');

xlswrite(filename,header,'sheet4','A1');
xlswrite(filename,lightAvgX2turntable2,'sheet4','B1');
xlswrite(filename,lightAvgX2turntableAvg2,'sheet4','L1');
xlswrite(filename,lightAvgX2se2,'sheet4','M1');

xlswrite(filename,header,'sheet5','A1');
xlswrite(filename,lightX2drum05,'sheet5','B1');
xlswrite(filename,lightX2drumAvg05,'sheet5','AM1');
xlswrite(filename,lightX2drumSE05,'sheet5','AN1');

xlswrite(filename,header,'sheet6','A1');
xlswrite(filename,lightAvgX2drum05,'sheet6','B1');
xlswrite(filename,lightAvgX2drumAvg05,'sheet6','L1');
xlswrite(filename,lightAvgX2drumSE05,'sheet6','M1');

xlswrite(filename,header,'sheet7','A1');
xlswrite(filename,lightX2drum2,'sheet7','B1');
xlswrite(filename,lightX2drumAvg2,'sheet7','AM1');
xlswrite(filename,lightX2drumSE2,'sheet7','AN1');

xlswrite(filename,header,'sheet8','A1');
xlswrite(filename,lightAvgX2drum2,'sheet8','B1');
xlswrite(filename,lightAvgX2drumAvg2,'sheet8','L1');
xlswrite(filename,lightAvgX2drumSE2,'sheet8','M1');