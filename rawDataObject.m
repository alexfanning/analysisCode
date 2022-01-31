function params = VOR_Default(params)

T = readtable(fullfile(params.folder,[params.file '.xlsx']));

% Remove NaN values from T
goodRows = ~isnan(table2array(T(:,2)));
params.segAmt = sum(goodRows);
T = T(goodRows,:);


% Used for some of Jaydev & Sriram's Experiments Summer 2019
[params.segStarts, params.segEnds] = extractSineSegs_B(params.folder);

chanlist = readSpikeFile(fullfile(params.folder,[params.file '.smr']),[]);
chanindsAll = [chanlist.number];
chanlabels = {'hhpos','htpos','hepos1','hepos2','hepos','vepos','hhvel','htvel','htvel','TTL3','TTL4'};
chaninds = find(      arrayfun(@(x) any(strcmp(x.title,chanlabels)),chanlist)     );
rawdata = importSpike(fullfile(params.folder,[params.file '.smr']),chanindsAll(chaninds));