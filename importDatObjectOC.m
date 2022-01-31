function [data,dataSubset] = importDatObjectOC(file,version)

chanList = readSpikeFile(fullfile(file),[]);
chanIndAll = [chanList.number];
[data,dataDrumVel,dataDrumPos,dataChairVel,dataChairPos] = importSpike(fullfile(file),chanIndAll(:));
if version == 1
    dataDrumNew = upsampDownsamp(dataDrumVel,data(5).data);
    dataChairVelNew = upsampDownsamp(dataChairVel,data(5).data);
    dataDrumPosNew = upsampDownsamp(dataDrumPos,data(5).data);
    dataChairPosNew = upsampDownsamp(dataChairPos,data(5).data);
    
    data(7).data = dataDrumNew;
    data(8).data = dataChairVelNew;
    data(3).data = dataDrumPosNew;
    data(4).data = dataChairPosNew;
else
    data(7).data = dataDrumVel;
    data(8).data = dataChairVel;
    data(3).data = dataDrumPos;
    data(4).data = dataChairPos;
end

idxs = NaN(1,length(data));
for i = 1:length(data)
    idxs(i) = data(1,i).chanval;
end

chVind = find(idxs==8);
chPind = find(idxs==4);
drumPind = find(idxs==3);
drumVind = find(idxs==7);
eyeCh1ind = find(idxs==5);
eyeCh2ind = find(idxs==6);
LEDidxs = find(idxs==9);
keystrokes = find(idxs==31);
fpIdxs = find(idxs==15);

dataSubset = [chVind chPind drumVind eyeCh1ind eyeCh2ind LEDidxs(1) LEDidxs(2) fpIdxs(1) fpIdxs(2) drumPind keystrokes];