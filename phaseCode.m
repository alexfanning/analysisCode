data = turntable1hz;

freq = 1;
samplerate = 1000;
segLength = length(data);
segTime = (1:segLength)/samplerate;
y1 = sin(2*pi*freq*segTime(:));
y2 = cos(2*pi*freq*segTime(:));
constant = ones(segLength,1);
vars = [y1 y2 constant];
b = regress(data, vars);
dataAngle = rad2deg(atan2(b(2), b(1)));
dataAngleAmp = sqrt(b(1)^2+b(2)^2);

b = regress(eye1hz, vars);
eyeVelPhase = rad2deg(atan2(b(2), b(1)));
eyeVelAmp = sqrt(b(1)^2+b(2)^2);

refAngle = dataAngle;
eyeVelRelPhase = (eyeVelPhase - refAngle);

b = regress(data1hz, vars);
dataPhase = rad2deg(atan2(b(2), b(1)));
dataPhaseAmp = sqrt(b(1)^2+b(2)^2);

refAngle = dataAngle;
dataRelPhase = (dataPhase - refAngle);

b = regress(rs1hz, vars);
rsPhase = rad2deg(atan2(b(2), b(1)))+180;
rsPhaseAmp = sqrt(b(1)^2+b(2)^2);

refAngle = rsPhase;
rsDataRelPhase = (dataPhase - rsPhase);