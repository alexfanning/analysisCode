function [data,dataSubset] = importDatObjectOC(file)

chanList = readSpikeFile(fullfile(file),[]);
chanIndAll = [chanList.number];
[data,dataDrumVel,dataChairVel] = importSpikeHg(fullfile(file),chanIndAll(:));

data(11).data = dataDrumVel;
data(12).data = dataChairVel;

% data(11).data = upsampDownsamp(data(11).data,data(3).data);
% data(12).data = upsampDownsamp(data(12).data,data(3).data);

idxs = NaN(1,length(data));
for i = 1:length(data)
    idxs(i) = data(1,i).chanval;
end

chVind = find(idxs==12);
chPind = find(idxs==4);
drumPind = find(idxs==3);
drumVind = find(idxs==11);
eyeCh1ind = find(idxs==5);
eyeCh2ind = find(idxs==6);
LEDidxs = find(idxs==9);
keystrokes = find(idxs==31);
fpIdxs = find(idxs==15);

dataSubset = [chVind chPind drumVind eyeCh1ind eyeCh2ind LEDidxs(1) LEDidxs(2) fpIdxs(1) fpIdxs(2) drumPind keystrokes];