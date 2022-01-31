function datout = extendSaccadesToThres(saccades, magnetPos, thres)
% The input should be a matrix, where each row represents a saccade
%   Col 1 contains the start index of the saccade
%   Col 2 contains the end index of the saccade
    datout = saccades;
    velocity = [diff(magnetPos); magnetPos(end)] * 1000; % Calculate the velocity without smoothing
    for i = 1:size(saccades, 1)
        start = saccades(i, 1);
        stop = saccades(i, 2);
        
        B = sign(velocity(round((start + stop) / 2))); % Sign of velocity at center of saccade
        
        % Extend to the left until velocity goes below thres
        A = velocity(1:start);
        if B > 0
            start = find(A <= thres, 1, 'last');
        else
            start = find(A >= -thres, 1, 'last');
        end
        if isempty(start)
            start = saccades(i, 1);
        end
        
        % Extend to the right until velocity goes below thres
        A = velocity(stop:end);
        if B > 0
            stop = find(A <= thres, 1, 'first') + stop - 1;
        else
            stop = find(A >= -thres, 1, 'first') + stop - 1;
        end
        if isempty(stop)
            stop = saccades(i, 2);
        end
        
        datout(i, 1) = start;
        datout(i, 2) = stop;
    end
end