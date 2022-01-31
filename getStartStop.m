function datout = getStartStop(datin)

D = diff([false; ~isnan(datin); false]); % Marks start of saccade with 1, and end of saccade with -1
starts = find(D > 0); % Col 1 contains the start index of each saccade
stops = find(D < 0) - 1; % Col 2 contains the end index of each saccade
datout = [starts, stops];