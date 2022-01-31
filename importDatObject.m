function [data,dataSubset] = importDatObject(file)

chanList = readSpikeFile(fullfile(file),[]);
chanIndAll = [chanList.number];
[data,dataDrum,dataChairVel] = importSpike(fullfile(file),chanIndAll(:));
idxs = NaN(1,length(data));
for i = 1:length(data)
    idxs(i) = data(1,i).chanval;
end

chVind = find(idxs==8);
chPind = find(idxs==4);
drumPind = find(idxs==3);
eyeCh1ind = find(idxs==5);
eyeCh2ind = find(idxs==6);
LEDidxs = find(idxs==9);
keystrokes = find(idxs==31);
fpIdxs = find(idxs==15);

if ~isempty(LEDidxs) && ~isempty(fpIdxs)
    dataSubset = [chVind chPind drumPind eyeCh1ind eyeCh2ind LEDidxs(1) LEDidxs(2) fpIdxs(1) fpIdxs(2) keystrokes];
elseif isempty(fpIdxs)
    dataSubset = [chVind chPind drumPind eyeCh1ind eyeCh2ind LEDidxs(1) LEDidxs(2) NaN NaN keystrokes];
else
    dataSubset = [chVind chPind drumPind eyeCh1ind eyeCh2ind NaN NaN fpIdxs(1) fpIdxs(2) keystrokes];
end