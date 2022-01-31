function datout = putInContext(saccades, magnetPos, merged)
    if merged
        % Returns a column
        % The column contains all the saccades, on the same time scale as magnetPos
        datout = NaN(size(magnetPos));
        for i = 1:size(saccades, 1)
            start = saccades(i, 1);
            stop = saccades(i, 2);
            datout(start:stop) = magnetPos(start:stop);
        end
    else
        % Returns a matrix
        % Each column contains one saccade
        % Each column is on the same time scale as magnetPos
        datout = NaN(numel(magnetPos), numel(saccades));
        for i = 1:size(saccades, 1)
            start = saccades(i, 1);
            stop = saccades(i, 2);
            datout(start:stop, i) = magnetPos(start:stop);
        end
    end
end